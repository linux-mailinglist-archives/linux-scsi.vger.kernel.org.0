Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32F44B5A6
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Nov 2021 23:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbhKIWWK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Nov 2021 17:22:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245475AbhKIWUw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 9 Nov 2021 17:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DA160524;
        Tue,  9 Nov 2021 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636496274;
        bh=7RNfVy3XxtsBTqoQwptlnEhpciqJvnAuuiD3CWrqgmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZDraMeSLKZJuV5tz8dD8z/wbdlYl6qJALc9xZZ8jQ+Uc66//1e7dmYWeUhd1iSzZ
         P/d9OTWrZ8CKls5c+ZKvGQC7YBYTPbvmiIH4ZzJi7jewSVxlCOhm/F7RfH+QodhVbH
         ceK2fyC2scWvGROrI84HMDY2BF1gTL1SGX2ojjG0tF/QtRN4luAhme17cUaeGWBe7s
         ZWW6d6jHWJT1Zl9jP2ryYOnYb347qi3ut7itM9fdMvtF3fpgx7irakK4iXIHaa6GL6
         FualVbdpx8WyQRnLsADAyvplH/Ai0emYrLiOk8TPQFJRQKya9/lwfk+zf6+WBkp0hW
         tXRcYi8LFAidg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, JBottomley@odin.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 37/82] scsi: core: Fix scsi_mode_sense() buffer length handling
Date:   Tue,  9 Nov 2021 17:15:55 -0500
Message-Id: <20211109221641.1233217-37-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

[ Upstream commit 17b49bcbf8351d3dbe57204468ac34f033ed60bc ]

Several problems exist with scsi_mode_sense() buffer length handling:

 1) The allocation length field of the MODE SENSE(10) command is 16-bits,
    occupying bytes 7 and 8 of the CDB. With this command, access to mode
    pages larger than 255 bytes is thus possible. However, the CDB
    allocation length field is set by assigning len to byte 8 only, thus
    truncating buffer length larger than 255.

 2) If scsi_mode_sense() is called with len smaller than 8 with
    sdev->use_10_for_ms set, or smaller than 4 otherwise, the buffer length
    is increased to 8 and 4 respectively, and the buffer is zero filled
    with these increased values, thus corrupting the memory following the
    buffer.

Fix these 2 problems by using put_unaligned_be16() to set the allocation
length field of MODE SENSE(10) CDB and by returning an error when len is
too small.

Furthermore, if len is larger than 255B, always try MODE SENSE(10) first,
even if the device driver did not set sdev->use_10_for_ms. In case of
invalid opcode error for MODE SENSE(10), access to mode pages larger than
255 bytes are not retried using MODE SENSE(6). To avoid buffer length
overflows for the MODE_SENSE(10) case, check that len is smaller than 65535
bytes.

While at it, also fix the folowing:

 * Use get_unaligned_be16() to retrieve the mode data length and block
   descriptor length fields of the mode sense reply header instead of using
   an open coded calculation.

 * Fix the kdoc dbd argument explanation: the DBD bit stands for Disable
   Block Descriptor, which is the opposite of what the dbd argument
   description was.

Link: https://lore.kernel.org/r/20210820070255.682775-2-damien.lemoal@wdc.com
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 572673873ddf8..701d8e8480f22 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2075,7 +2075,7 @@ EXPORT_SYMBOL_GPL(scsi_mode_select);
 /**
  *	scsi_mode_sense - issue a mode sense, falling back from 10 to six bytes if necessary.
  *	@sdev:	SCSI device to be queried
- *	@dbd:	set if mode sense will allow block descriptors to be returned
+ *	@dbd:	set to prevent mode sense from returning block descriptors
  *	@modepage: mode page being requested
  *	@buffer: request buffer (may not be smaller than eight bytes)
  *	@len:	length of request buffer.
@@ -2110,18 +2110,18 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 		sshdr = &my_sshdr;
 
  retry:
-	use_10_for_ms = sdev->use_10_for_ms;
+	use_10_for_ms = sdev->use_10_for_ms || len > 255;
 
 	if (use_10_for_ms) {
-		if (len < 8)
-			len = 8;
+		if (len < 8 || len > 65535)
+			return -EINVAL;
 
 		cmd[0] = MODE_SENSE_10;
-		cmd[8] = len;
+		put_unaligned_be16(len, &cmd[7]);
 		header_length = 8;
 	} else {
 		if (len < 4)
-			len = 4;
+			return -EINVAL;
 
 		cmd[0] = MODE_SENSE;
 		cmd[4] = len;
@@ -2145,9 +2145,15 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 			if ((sshdr->sense_key == ILLEGAL_REQUEST) &&
 			    (sshdr->asc == 0x20) && (sshdr->ascq == 0)) {
 				/*
-				 * Invalid command operation code
+				 * Invalid command operation code: retry using
+				 * MODE SENSE(6) if this was a MODE SENSE(10)
+				 * request, except if the request mode page is
+				 * too large for MODE SENSE single byte
+				 * allocation length field.
 				 */
 				if (use_10_for_ms) {
+					if (len > 255)
+						return -EIO;
 					sdev->use_10_for_ms = 0;
 					goto retry;
 				}
@@ -2171,12 +2177,11 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 		data->longlba = 0;
 		data->block_descriptor_length = 0;
 	} else if (use_10_for_ms) {
-		data->length = buffer[0]*256 + buffer[1] + 2;
+		data->length = get_unaligned_be16(&buffer[0]) + 2;
 		data->medium_type = buffer[2];
 		data->device_specific = buffer[3];
 		data->longlba = buffer[4] & 0x01;
-		data->block_descriptor_length = buffer[6]*256
-			+ buffer[7];
+		data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
 	} else {
 		data->length = buffer[0] + 1;
 		data->medium_type = buffer[1];
-- 
2.33.0

