Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6104A666B
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfICKSo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 06:18:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfICKSn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 3 Sep 2019 06:18:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0FAFAC7F;
        Tue,  3 Sep 2019 10:18:42 +0000 (UTC)
From:   Oliver Neukum <oneukum@suse.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        stern@rowland.harvard.edu
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] scsi: ignore a failure to synchronize cache due to lack of authorization
Date:   Tue,  3 Sep 2019 12:18:39 +0200
Message-Id: <20190903101840.16483-1-oneukum@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I've got a report about a UAS drive enclosure reporting back
Sense: Logical unit access not authorized
if the drive it holds is password protected. While the drive
is obviously unusable in that state as a mass storage device,
it still exists as a sd device and when the system is asked
to perform a suspend of the drive, it will be sent a
SYNCHRONIZE CACHE. If that fails due to password protection,
the error must be ignored.
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 149d406aacc9..2d77f32e13d5 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1655,7 +1655,8 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 		/* we need to evaluate the error return  */
 		if (scsi_sense_valid(sshdr) &&
 			(sshdr->asc == 0x3a ||	/* medium not present */
-			 sshdr->asc == 0x20))	/* invalid command */
+			 sshdr->asc == 0x20 ||	/* invalid command */
+			 (sshdr->asc == 0x74 && sshdr->ascq == 0x71)))	/* drive is password locked */
 				/* this is no error here */
 				return 0;
 
-- 
2.16.4

