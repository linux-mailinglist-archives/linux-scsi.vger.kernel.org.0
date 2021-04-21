Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194AB3671CD
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbhDURtQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245017AbhDURtA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73787B0BD;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/42] scsi: Fixup calling convention for scsi_mode_sense()
Date:   Wed, 21 Apr 2021 19:47:11 +0200
Message-Id: <20210421174749.11221-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The description for scsi_mode_sense() claims to return the number
of valid bytes on success, which is not what the code does.
Additionally there is no gain in returning the scsi status, as
everything the callers do is to check against scsi_result_is_good(),
which is what scsi_mode_sense() does already.
So change the calling convention to return a standard error code
on failure, and 0 on success, and adapt the description and all
callers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c           | 10 ++++++----
 drivers/scsi/scsi_transport_sas.c |  9 ++++-----
 drivers/scsi/sd.c                 | 12 ++++++------
 drivers/scsi/sr.c                 |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d7c0d5a5f263..c532f9390ae3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2135,9 +2135,7 @@ EXPORT_SYMBOL_GPL(scsi_mode_select);
  *	@sshdr: place to put sense data (or NULL if no sense to be collected).
  *		must be SCSI_SENSE_BUFFERSIZE big.
  *
- *	Returns zero if unsuccessful, or the header offset (either 4
- *	or 8 depending on whether a six or ten byte command was
- *	issued) if successful.
+ *	Returns zero if successful, or a negative error number on failure
  */
 int
 scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
@@ -2190,6 +2188,8 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 	 * byte as the problem.  MODE_SENSE commands can return
 	 * ILLEGAL REQUEST if the code page isn't supported */
 
+	if (result < 0)
+		return result;
 	if (use_10_for_ms && !scsi_status_is_good(result) &&
 	    driver_byte(result) == DRIVER_SENSE) {
 		if (scsi_sense_valid(sshdr)) {
@@ -2228,13 +2228,15 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 			data->block_descriptor_length = buffer[3];
 		}
 		data->header_length = header_length;
+		result = 0;
 	} else if ((status_byte(result) == CHECK_CONDITION) &&
 		   scsi_sense_valid(sshdr) &&
 		   sshdr->sense_key == UNIT_ATTENTION && retry_count) {
 		retry_count--;
 		goto retry;
 	}
-
+	if (result > 0)
+		result = -EIO;
 	return result;
 }
 EXPORT_SYMBOL(scsi_mode_sense);
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index c9abed8429c9..4a96fb05731d 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -1229,16 +1229,15 @@ int sas_read_port_mode_page(struct scsi_device *sdev)
 	char *buffer = kzalloc(BUF_SIZE, GFP_KERNEL), *msdata;
 	struct sas_end_device *rdev = sas_sdev_to_rdev(sdev);
 	struct scsi_mode_data mode_data;
-	int res, error;
+	int error;
 
 	if (!buffer)
 		return -ENOMEM;
 
-	res = scsi_mode_sense(sdev, 1, 0x19, buffer, BUF_SIZE, 30*HZ, 3,
-			      &mode_data, NULL);
+	error = scsi_mode_sense(sdev, 1, 0x19, buffer, BUF_SIZE, 30*HZ, 3,
+				&mode_data, NULL);
 
-	error = -EINVAL;
-	if (!scsi_status_is_good(res))
+	if (error)
 		goto out;
 
 	msdata = buffer +  mode_data.header_length +
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cb3c37d1e009..2ef2954375f4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2670,18 +2670,18 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
 		 * 5: Illegal Request, Sense Code 24: Invalid field in
 		 * CDB.
 		 */
-		if (!scsi_status_is_good(res))
+		if (res < 0)
 			res = sd_do_mode_sense(sdkp, 0, 0, buffer, 4, &data, NULL);
 
 		/*
 		 * Third attempt: ask 255 bytes, as we did earlier.
 		 */
-		if (!scsi_status_is_good(res))
+		if (res < 0)
 			res = sd_do_mode_sense(sdkp, 0, 0x3F, buffer, 255,
 					       &data, NULL);
 	}
 
-	if (!scsi_status_is_good(res)) {
+	if (res < 0) {
 		sd_first_printk(KERN_WARNING, sdkp,
 			  "Test WP failed, assume Write Enabled\n");
 	} else {
@@ -2742,7 +2742,7 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 	res = sd_do_mode_sense(sdkp, dbd, modepage, buffer, first_len,
 			&data, &sshdr);
 
-	if (!scsi_status_is_good(res))
+	if (res < 0)
 		goto bad_sense;
 
 	if (!data.header_length) {
@@ -2774,7 +2774,7 @@ sd_read_cache_type(struct scsi_disk *sdkp, unsigned char *buffer)
 		res = sd_do_mode_sense(sdkp, dbd, modepage, buffer, len,
 				&data, &sshdr);
 
-	if (scsi_status_is_good(res)) {
+	if (!res) {
 		int offset = data.header_length + data.block_descriptor_length;
 
 		while (offset < len) {
@@ -2892,7 +2892,7 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 	res = scsi_mode_sense(sdp, 1, 0x0a, buffer, 36, SD_TIMEOUT,
 			      sdkp->max_retries, &data, &sshdr);
 
-	if (!scsi_status_is_good(res) || !data.header_length ||
+	if (res < 0 || !data.header_length ||
 	    data.length < 6) {
 		sd_first_printk(KERN_WARNING, sdkp,
 			  "getting Control mode page failed, assume no ATO\n");
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index e4633b84c556..9b2ccf0c9a8c 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -911,7 +911,7 @@ static void get_capabilities(struct scsi_cd *cd)
 	rc = scsi_mode_sense(cd->device, 0, 0x2a, buffer, ms_len,
 			     SR_TIMEOUT, 3, &data, NULL);
 
-	if (!scsi_status_is_good(rc) || data.length > ms_len ||
+	if (rc < 0 || data.length > ms_len ||
 	    data.header_length + data.block_descriptor_length > data.length) {
 		/* failed, drive doesn't have capabilities mode page */
 		cd->cdi.speed = 1;
-- 
2.29.2

