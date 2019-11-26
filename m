Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E7310A4E8
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKZTza (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 14:55:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:40204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfKZTyn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADBAFAE34;
        Tue, 26 Nov 2019 19:54:39 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 rebase 02/10] cdrom: factor out common open_for_* code
Date:   Tue, 26 Nov 2019 20:54:21 +0100
Message-Id: <28ea5ed3fc07adba819bbcdb9fe9e969a727b203.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The open_for_audio and open_for_data copies are bitrotten in different
ways already and will need to update the autoclose logic in both.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: do not add unrelated whitespace changes
v3: fix declaration style
v4: fix the debug message logic around closing tray
---
 drivers/cdrom/cdrom.c | 118 ++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 78 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 2ad6b73482fe..bb32decdadf1 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1045,13 +1045,12 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	       tracks->cdi, tracks->xa);
 }
 
-static
-int open_for_data(struct cdrom_device_info *cdi)
+static int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
 {
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+
+	cd_dbg(CD_OPEN, "entering open_for_common\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
@@ -1059,49 +1058,48 @@ int open_for_data(struct cdrom_device_info *cdi)
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
 			cd_dbg(CD_OPEN, "the tray is open...\n");
-			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
+			if (CDROM_CAN(CDC_CLOSE_TRAY)) {
+				if (!(cdi->options & CDO_AUTO_CLOSE))
+					return -ENOMEDIUM;
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
 				ret=cdo->tray_move(cdi,0);
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
-					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
-					ret=-ENOMEDIUM;
-					goto clean_up_and_return;
+					return -ENOMEDIUM;
 				}
+				ret = cdo->drive_status(cdi, CDSL_CURRENT);
+				if (ret == CDS_TRAY_OPEN)
+					cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
+				if (ret == CDS_NO_DISC)
+					cd_dbg(CD_OPEN, "tray might not contain a medium\n");
 			} else {
 				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				ret=-ENOMEDIUM;
-				goto clean_up_and_return;
-			}
-			/* Ok, the door should be closed now.. Check again */
-			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
-				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
-				ret=-ENOMEDIUM;
-				goto clean_up_and_return;
+				return -ENOMEDIUM;
 			}
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
-		}
-		/* the door should be closed now, check for the disc */
-		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		if (ret!=CDS_DISC_OK) {
-			ret = -ENOMEDIUM;
-			goto clean_up_and_return;
 		}
+		if (ret != CDS_DISC_OK)
+			return -ENOMEDIUM;
 	}
-	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error == CDS_NO_DISC) {
+	cdrom_count_tracks(cdi, tracks);
+	if (tracks->error == CDS_NO_DISC) {
 		cd_dbg(CD_OPEN, "bummer. no disc.\n");
-		ret=-ENOMEDIUM;
-		goto clean_up_and_return;
+		return -ENOMEDIUM;
 	}
+
+	return 0;
+}
+
+static int open_for_data(struct cdrom_device_info *cdi)
+{
+	int ret;
+	const struct cdrom_device_ops *cdo = cdi->ops;
+	tracktype tracks;
+
+	cd_dbg(CD_OPEN, "entering open_for_data\n");
+	ret = open_for_common(cdi, &tracks);
+	if (ret)
+		goto clean_up_and_return;
+
 	/* CD-Players which don't use O_NONBLOCK, workman
 	 * for example, need bit CDO_CHECK_TYPE cleared! */
 	if (tracks.data==0) {
@@ -1208,53 +1206,17 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 /* This code is similar to that in open_for_data. The routine is called
    whenever an audio play operation is requested.
 */
-static int check_for_audio_disc(struct cdrom_device_info *cdi,
-				const struct cdrom_device_ops *cdo)
+static int check_for_audio_disc(struct cdrom_device_info *cdi)
 {
         int ret;
 	tracktype tracks;
 	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
-	if (cdo->drive_status != NULL) {
-		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
-		if (ret == CDS_TRAY_OPEN) {
-			cd_dbg(CD_OPEN, "the tray is open...\n");
-			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
-				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close tray but failed.\n");
-					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
-					return -ENOMEDIUM;
-				}
-			} else {
-				cd_dbg(CD_OPEN, "bummer. this driver can't close the tray.\n");
-				return -ENOMEDIUM;
-			}
-			/* Ok, the door should be closed now.. Check again */
-			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
-				return -ENOMEDIUM;
-			}	
-			if (ret!=CDS_DISC_OK) {
-				cd_dbg(CD_OPEN, "bummer. disc isn't ready.\n");
-				return -EIO;
-			}	
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
-		}	
-	}
-	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error) 
-		return(tracks.error);
+
+	ret = open_for_common(cdi, &tracks);
+	if (ret)
+		return ret;
 
 	if (tracks.audio==0)
 		return -EMEDIUMTYPE;
@@ -2725,7 +2687,7 @@ static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
 	if (copy_from_user(&ti, argp, sizeof(ti)))
 		return -EFAULT;
 
-	ret = check_for_audio_disc(cdi, cdi->ops);
+	ret = check_for_audio_disc(cdi);
 	if (ret)
 		return ret;
 	return cdi->ops->audio_ioctl(cdi, CDROMPLAYTRKIND, &ti);
@@ -2773,7 +2735,7 @@ static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
-	ret = check_for_audio_disc(cdi, cdi->ops);
+	ret = check_for_audio_disc(cdi);
 	if (ret)
 		return ret;
 	return cdi->ops->audio_ioctl(cdi, cmd, NULL);
-- 
2.23.0

