Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352B32A9DB
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Mar 2021 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835262AbhCBSvo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Mar 2021 13:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350403AbhCBMVN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:21:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918A864F9B;
        Tue,  2 Mar 2021 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686314;
        bh=UBX+hDlWTye2ioLgZ1h7Fsft8q5FcT975NMOEDcdfDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1BylEgInIGN6P0bT/nLYDl+bF0XKuMS6Ek5rTZFbR35rv1FGNyLsZ6FF76uVsvlI
         Mxnj57xwuoxSEQba/1BXwXZDhLqaErUUkXYQxU0W5bxFqtVmawlOGPdmN8vCWK2f2z
         Dh8l1xmjh+jnHjL0Ozj7GMPS2SZjImI3xzPL9Ao9R6hDspxnuwS1zIeL/yyFxIKPyM
         TBJegTvoUmcBan3v4o1ZgrgOHQdKhtrs6kokG2AKX9uOVcuuEMGMi8nS8VNSLQ25QO
         YMQUZOXEpWX9ChwOQ/Vy/H6MsPgqk0lnZQahTQkJ0FbkDbv/66epeDq9U4RFvsmhNU
         kU7Qj2i8qRONA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aleksandr Miloserdov <a.miloserdov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 33/33] scsi: target: core: Prevent underflow for service actions
Date:   Tue,  2 Mar 2021 06:57:49 -0500
Message-Id: <20210302115749.62653-33-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115749.62653-1-sashal@kernel.org>
References: <20210302115749.62653-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Aleksandr Miloserdov <a.miloserdov@yadro.com>

[ Upstream commit 14d24e2cc77411301e906a8cf41884739de192de ]

TCM buffer length doesn't necessarily equal 8 + ADDITIONAL LENGTH which
might be considered an underflow in case of Data-In size being greater than
8 + ADDITIONAL LENGTH. So truncate buffer length to prevent underflow.

Link: https://lore.kernel.org/r/20210209072202.41154-3-a.miloserdov@yadro.com
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_pr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 5e931690e697..51e690ab4d29 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3731,6 +3731,7 @@ core_scsi3_pri_read_keys(struct se_cmd *cmd)
 	spin_unlock(&dev->t10_pr.registration_lock);
 
 	put_unaligned_be32(add_len, &buf[4]);
+	target_set_cmd_data_length(cmd, 8 + add_len);
 
 	transport_kunmap_data_sg(cmd);
 
@@ -3749,7 +3750,7 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 	struct t10_pr_registration *pr_reg;
 	unsigned char *buf;
 	u64 pr_res_key;
-	u32 add_len = 16; /* Hardcoded to 16 when a reservation is held. */
+	u32 add_len = 0;
 
 	if (cmd->data_length < 8) {
 		pr_err("PRIN SA READ_RESERVATIONS SCSI Data Length: %u"
@@ -3767,8 +3768,9 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 	pr_reg = dev->dev_pr_res_holder;
 	if (pr_reg) {
 		/*
-		 * Set the hardcoded Additional Length
+		 * Set the Additional Length to 16 when a reservation is held
 		 */
+		add_len = 16;
 		put_unaligned_be32(add_len, &buf[4]);
 
 		if (cmd->data_length < 22)
@@ -3804,6 +3806,8 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 			  (pr_reg->pr_res_type & 0x0f);
 	}
 
+	target_set_cmd_data_length(cmd, 8 + add_len);
+
 err:
 	spin_unlock(&dev->dev_reservation_lock);
 	transport_kunmap_data_sg(cmd);
@@ -3822,7 +3826,7 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	struct se_device *dev = cmd->se_dev;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	unsigned char *buf;
-	u16 add_len = 8; /* Hardcoded to 8. */
+	u16 len = 8; /* Hardcoded to 8. */
 
 	if (cmd->data_length < 6) {
 		pr_err("PRIN SA REPORT_CAPABILITIES SCSI Data Length:"
@@ -3834,7 +3838,7 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	if (!buf)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-	put_unaligned_be16(add_len, &buf[0]);
+	put_unaligned_be16(len, &buf[0]);
 	buf[2] |= 0x10; /* CRH: Compatible Reservation Hanlding bit. */
 	buf[2] |= 0x08; /* SIP_C: Specify Initiator Ports Capable bit */
 	buf[2] |= 0x04; /* ATP_C: All Target Ports Capable bit */
@@ -3863,6 +3867,8 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	buf[4] |= 0x02; /* PR_TYPE_WRITE_EXCLUSIVE */
 	buf[5] |= 0x01; /* PR_TYPE_EXCLUSIVE_ACCESS_ALLREG */
 
+	target_set_cmd_data_length(cmd, len);
+
 	transport_kunmap_data_sg(cmd);
 
 	return 0;
@@ -4023,6 +4029,7 @@ core_scsi3_pri_read_full_status(struct se_cmd *cmd)
 	 * Set ADDITIONAL_LENGTH
 	 */
 	put_unaligned_be32(add_len, &buf[4]);
+	target_set_cmd_data_length(cmd, 8 + add_len);
 
 	transport_kunmap_data_sg(cmd);
 
-- 
2.30.1

