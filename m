Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF0D6225
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Oct 2019 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfJNMQV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Oct 2019 08:16:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNMQU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Oct 2019 08:16:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iJzGn-0001jU-Ao; Mon, 14 Oct 2019 12:16:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Tomohiro Kusumi <kusumi.tomohiro@jp.fujitsu.com>,
        Kei Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
        Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fix unintended sign extension on left shifts
Date:   Mon, 14 Oct 2019 13:16:13 +0100
Message-Id: <20191014121613.21999-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Shifting a u8 left will cause the value to be promoted to an integer. If
the top bit of the u8 is set then the following conversion to an u64 will
sign extend the value causing the upper 32 bits to be set in the result.

Fix this by casting the u8 value to a u64 before the shift.

Fixes: bf8162354233 ("[SCSI] add scsi trace core functions and put trace points")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/scsi_trace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 0f17e7dac1b0..1d3a5a2dc229 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -38,7 +38,7 @@ scsi_trace_rw10(struct trace_seq *p, unsigned char *cdb, int len)
 	const char *ret = trace_seq_buffer_ptr(p);
 	sector_t lba = 0, txlen = 0;
 
-	lba |= (cdb[2] << 24);
+	lba |= ((u64)cdb[2] << 24);
 	lba |= (cdb[3] << 16);
 	lba |= (cdb[4] << 8);
 	lba |=  cdb[5];
@@ -63,11 +63,11 @@ scsi_trace_rw12(struct trace_seq *p, unsigned char *cdb, int len)
 	const char *ret = trace_seq_buffer_ptr(p);
 	sector_t lba = 0, txlen = 0;
 
-	lba |= (cdb[2] << 24);
+	lba |= ((u64)cdb[2] << 24);
 	lba |= (cdb[3] << 16);
 	lba |= (cdb[4] << 8);
 	lba |=  cdb[5];
-	txlen |= (cdb[6] << 24);
+	txlen |= ((u64)cdb[6] << 24);
 	txlen |= (cdb[7] << 16);
 	txlen |= (cdb[8] << 8);
 	txlen |=  cdb[9];
@@ -90,11 +90,11 @@ scsi_trace_rw16(struct trace_seq *p, unsigned char *cdb, int len)
 	lba |= ((u64)cdb[3] << 48);
 	lba |= ((u64)cdb[4] << 40);
 	lba |= ((u64)cdb[5] << 32);
-	lba |= (cdb[6] << 24);
+	lba |= ((u64)cdb[6] << 24);
 	lba |= (cdb[7] << 16);
 	lba |= (cdb[8] << 8);
 	lba |=  cdb[9];
-	txlen |= (cdb[10] << 24);
+	txlen |= ((u64)cdb[10] << 24);
 	txlen |= (cdb[11] << 16);
 	txlen |= (cdb[12] << 8);
 	txlen |=  cdb[13];
@@ -140,7 +140,7 @@ scsi_trace_rw32(struct trace_seq *p, unsigned char *cdb, int len)
 	lba |= ((u64)cdb[13] << 48);
 	lba |= ((u64)cdb[14] << 40);
 	lba |= ((u64)cdb[15] << 32);
-	lba |= (cdb[16] << 24);
+	lba |= ((u64)cdb[16] << 24);
 	lba |= (cdb[17] << 16);
 	lba |= (cdb[18] << 8);
 	lba |=  cdb[19];
@@ -148,7 +148,7 @@ scsi_trace_rw32(struct trace_seq *p, unsigned char *cdb, int len)
 	ei_lbrt |= (cdb[21] << 16);
 	ei_lbrt |= (cdb[22] << 8);
 	ei_lbrt |=  cdb[23];
-	txlen |= (cdb[28] << 24);
+	txlen |= ((u64)cdb[28] << 24);
 	txlen |= (cdb[29] << 16);
 	txlen |= (cdb[30] << 8);
 	txlen |=  cdb[31];
@@ -201,7 +201,7 @@ scsi_trace_service_action_in(struct trace_seq *p, unsigned char *cdb, int len)
 	lba |= ((u64)cdb[3] << 48);
 	lba |= ((u64)cdb[4] << 40);
 	lba |= ((u64)cdb[5] << 32);
-	lba |= (cdb[6] << 24);
+	lba |= ((u64)cdb[6] << 24);
 	lba |= (cdb[7] << 16);
 	lba |= (cdb[8] << 8);
 	lba |=  cdb[9];
-- 
2.20.1

