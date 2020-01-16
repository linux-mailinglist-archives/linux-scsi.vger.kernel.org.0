Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B413E5EF
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 18:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgAPRRS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 12:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390838AbgAPRNv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D693246A2;
        Thu, 16 Jan 2020 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194830;
        bh=zkHvV0MRPkUJW9/zrbyMGc1h24+3X4sbBAq0HLgpzqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3Lg3yqPASaYEPSTMv2lzkN3MzL9RWO0PPQd6stecNB3ROiz+fhsjMFRpS0uTuq82
         VAmZdeSRTkUNVplMDVRzZfHocIh0RQUQprOTEz1Mft68RRVMcH+IcGr+eZ+T1mt7Uc
         iA6PF01loJmbEZe4SB1dioi0Nml9aAWNOPNwZK9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 632/671] scsi: core: scsi_trace: Use get_unaligned_be*()
Date:   Thu, 16 Jan 2020 12:04:30 -0500
Message-Id: <20200116170509.12787-369-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit b1335f5b0486f61fb66b123b40f8e7a98e49605d ]

This patch fixes an unintended sign extension on left shifts. From Colin
King: "Shifting a u8 left will cause the value to be promoted to an
integer. If the top bit of the u8 is set then the following conversion to
an u64 will sign extend the value causing the upper 32 bits to be set in
the result."

Fix this by using get_unaligned_be*() instead.

Fixes: bf8162354233 ("[SCSI] add scsi trace core functions and put trace points")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Link: https://lore.kernel.org/r/20191101211447.187151-1-bvanassche@acm.org
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_trace.c | 113 +++++++++++---------------------------
 1 file changed, 33 insertions(+), 80 deletions(-)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 617a60737590..22472d140ef7 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -21,7 +21,7 @@
 #include <trace/events/scsi.h>
 
 #define SERVICE_ACTION16(cdb) (cdb[1] & 0x1f)
-#define SERVICE_ACTION32(cdb) ((cdb[8] << 8) | cdb[9])
+#define SERVICE_ACTION32(cdb) (get_unaligned_be16(&cdb[8]))
 
 static const char *
 scsi_trace_misc(struct trace_seq *, unsigned char *, int);
@@ -51,17 +51,12 @@ static const char *
 scsi_trace_rw10(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	sector_t lba = 0, txlen = 0;
+	u32 lba, txlen;
 
-	lba |= (cdb[2] << 24);
-	lba |= (cdb[3] << 16);
-	lba |= (cdb[4] << 8);
-	lba |=  cdb[5];
-	txlen |= (cdb[7] << 8);
-	txlen |=  cdb[8];
+	lba = get_unaligned_be32(&cdb[2]);
+	txlen = get_unaligned_be16(&cdb[7]);
 
-	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
-			 (unsigned long long)lba, (unsigned long long)txlen,
+	trace_seq_printf(p, "lba=%u txlen=%u protect=%u", lba, txlen,
 			 cdb[1] >> 5);
 
 	if (cdb[0] == WRITE_SAME)
@@ -76,19 +71,12 @@ static const char *
 scsi_trace_rw12(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	sector_t lba = 0, txlen = 0;
-
-	lba |= (cdb[2] << 24);
-	lba |= (cdb[3] << 16);
-	lba |= (cdb[4] << 8);
-	lba |=  cdb[5];
-	txlen |= (cdb[6] << 24);
-	txlen |= (cdb[7] << 16);
-	txlen |= (cdb[8] << 8);
-	txlen |=  cdb[9];
-
-	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
-			 (unsigned long long)lba, (unsigned long long)txlen,
+	u32 lba, txlen;
+
+	lba = get_unaligned_be32(&cdb[2]);
+	txlen = get_unaligned_be32(&cdb[6]);
+
+	trace_seq_printf(p, "lba=%u txlen=%u protect=%u", lba, txlen,
 			 cdb[1] >> 5);
 	trace_seq_putc(p, 0);
 
@@ -99,23 +87,13 @@ static const char *
 scsi_trace_rw16(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	sector_t lba = 0, txlen = 0;
-
-	lba |= ((u64)cdb[2] << 56);
-	lba |= ((u64)cdb[3] << 48);
-	lba |= ((u64)cdb[4] << 40);
-	lba |= ((u64)cdb[5] << 32);
-	lba |= (cdb[6] << 24);
-	lba |= (cdb[7] << 16);
-	lba |= (cdb[8] << 8);
-	lba |=  cdb[9];
-	txlen |= (cdb[10] << 24);
-	txlen |= (cdb[11] << 16);
-	txlen |= (cdb[12] << 8);
-	txlen |=  cdb[13];
-
-	trace_seq_printf(p, "lba=%llu txlen=%llu protect=%u",
-			 (unsigned long long)lba, (unsigned long long)txlen,
+	u64 lba;
+	u32 txlen;
+
+	lba = get_unaligned_be64(&cdb[2]);
+	txlen = get_unaligned_be32(&cdb[10]);
+
+	trace_seq_printf(p, "lba=%llu txlen=%u protect=%u", lba, txlen,
 			 cdb[1] >> 5);
 
 	if (cdb[0] == WRITE_SAME_16)
@@ -130,8 +108,8 @@ static const char *
 scsi_trace_rw32(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p), *cmd;
-	sector_t lba = 0, txlen = 0;
-	u32 ei_lbrt = 0;
+	u64 lba;
+	u32 ei_lbrt, txlen;
 
 	switch (SERVICE_ACTION32(cdb)) {
 	case READ_32:
@@ -151,26 +129,12 @@ scsi_trace_rw32(struct trace_seq *p, unsigned char *cdb, int len)
 		goto out;
 	}
 
-	lba |= ((u64)cdb[12] << 56);
-	lba |= ((u64)cdb[13] << 48);
-	lba |= ((u64)cdb[14] << 40);
-	lba |= ((u64)cdb[15] << 32);
-	lba |= (cdb[16] << 24);
-	lba |= (cdb[17] << 16);
-	lba |= (cdb[18] << 8);
-	lba |=  cdb[19];
-	ei_lbrt |= (cdb[20] << 24);
-	ei_lbrt |= (cdb[21] << 16);
-	ei_lbrt |= (cdb[22] << 8);
-	ei_lbrt |=  cdb[23];
-	txlen |= (cdb[28] << 24);
-	txlen |= (cdb[29] << 16);
-	txlen |= (cdb[30] << 8);
-	txlen |=  cdb[31];
-
-	trace_seq_printf(p, "%s_32 lba=%llu txlen=%llu protect=%u ei_lbrt=%u",
-			 cmd, (unsigned long long)lba,
-			 (unsigned long long)txlen, cdb[10] >> 5, ei_lbrt);
+	lba = get_unaligned_be64(&cdb[12]);
+	ei_lbrt = get_unaligned_be32(&cdb[20]);
+	txlen = get_unaligned_be32(&cdb[28]);
+
+	trace_seq_printf(p, "%s_32 lba=%llu txlen=%u protect=%u ei_lbrt=%u",
+			 cmd, lba, txlen, cdb[10] >> 5, ei_lbrt);
 
 	if (SERVICE_ACTION32(cdb) == WRITE_SAME_32)
 		trace_seq_printf(p, " unmap=%u", cdb[10] >> 3 & 1);
@@ -185,7 +149,7 @@ static const char *
 scsi_trace_unmap(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
-	unsigned int regions = cdb[7] << 8 | cdb[8];
+	unsigned int regions = get_unaligned_be16(&cdb[7]);
 
 	trace_seq_printf(p, "regions=%u", (regions - 8) / 16);
 	trace_seq_putc(p, 0);
@@ -197,8 +161,8 @@ static const char *
 scsi_trace_service_action_in(struct trace_seq *p, unsigned char *cdb, int len)
 {
 	const char *ret = trace_seq_buffer_ptr(p), *cmd;
-	sector_t lba = 0;
-	u32 alloc_len = 0;
+	u64 lba;
+	u32 alloc_len;
 
 	switch (SERVICE_ACTION16(cdb)) {
 	case SAI_READ_CAPACITY_16:
@@ -212,21 +176,10 @@ scsi_trace_service_action_in(struct trace_seq *p, unsigned char *cdb, int len)
 		goto out;
 	}
 
-	lba |= ((u64)cdb[2] << 56);
-	lba |= ((u64)cdb[3] << 48);
-	lba |= ((u64)cdb[4] << 40);
-	lba |= ((u64)cdb[5] << 32);
-	lba |= (cdb[6] << 24);
-	lba |= (cdb[7] << 16);
-	lba |= (cdb[8] << 8);
-	lba |=  cdb[9];
-	alloc_len |= (cdb[10] << 24);
-	alloc_len |= (cdb[11] << 16);
-	alloc_len |= (cdb[12] << 8);
-	alloc_len |=  cdb[13];
-
-	trace_seq_printf(p, "%s lba=%llu alloc_len=%u", cmd,
-			 (unsigned long long)lba, alloc_len);
+	lba = get_unaligned_be64(&cdb[2]);
+	alloc_len = get_unaligned_be32(&cdb[10]);
+
+	trace_seq_printf(p, "%s lba=%llu alloc_len=%u", cmd, lba, alloc_len);
 
 out:
 	trace_seq_putc(p, 0);
-- 
2.20.1

