Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3536915E
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhDWLlL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242328AbhDWLkw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA49AB200;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 38/39] target: use standard SAM status types
Date:   Fri, 23 Apr 2021 13:39:43 +0200
Message-Id: <20210423113944.42672-39-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

target_complete_cmd() and friends requires a SAM status type,
so passing GOOD here is actually wrong.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/target/target_core_alua.c   |  6 +++---
 drivers/target/target_core_iblock.c |  2 +-
 drivers/target/target_core_pr.c     |  8 ++++----
 drivers/target/target_core_pscsi.c  |  2 +-
 drivers/target/target_core_sbc.c    | 10 +++++-----
 drivers/target/target_core_spc.c    | 14 +++++++-------
 drivers/target/target_core_xcopy.c  |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 5517c7dd5144..3bb921345bce 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -123,7 +123,7 @@ target_emulate_report_referrals(struct se_cmd *cmd)
 
 	transport_kunmap_data_sg(cmd);
 
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
@@ -255,7 +255,7 @@ target_emulate_report_target_port_groups(struct se_cmd *cmd)
 	}
 	transport_kunmap_data_sg(cmd);
 
-	target_complete_cmd_with_length(cmd, GOOD, rd_len + 4);
+	target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, rd_len + 4);
 	return 0;
 }
 
@@ -424,7 +424,7 @@ target_emulate_set_target_port_groups(struct se_cmd *cmd)
 out:
 	transport_kunmap_data_sg(cmd);
 	if (!rc)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return rc;
 }
 
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index d6fdd1c61f90..deb2b8b64d20 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -474,7 +474,7 @@ iblock_execute_zero_out(struct block_device *bdev, struct se_cmd *cmd)
 	if (ret)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 6fd5fec95539..4b94b085625b 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -234,7 +234,7 @@ target_scsi2_reservation_release(struct se_cmd *cmd)
 out_unlock:
 	spin_unlock(&dev->dev_reservation_lock);
 out:
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
@@ -297,7 +297,7 @@ target_scsi2_reservation_reserve(struct se_cmd *cmd)
 	spin_unlock(&dev->dev_reservation_lock);
 out:
 	if (!ret)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return ret;
 }
 
@@ -3676,7 +3676,7 @@ target_scsi3_emulate_pr_out(struct se_cmd *cmd)
 	}
 
 	if (!ret)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return ret;
 }
 
@@ -4073,7 +4073,7 @@ target_scsi3_emulate_pr_in(struct se_cmd *cmd)
 	}
 
 	if (!ret)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return ret;
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index dac44caf77a3..7e5e4ab3c126 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1044,7 +1044,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 	struct se_cmd *cmd = req->end_io_data;
 	struct pscsi_plugin_task *pt = cmd->priv;
 	int result = scsi_req(req)->result;
-	u8 scsi_status = status_byte(result) << 1;
+	u8 scsi_status = (result & 0xff);
 
 	if (scsi_status != SAM_STAT_GOOD) {
 		pr_debug("PSCSI Status Byte exception at cmd: %p CDB:"
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 7b07e557dc8d..b32f4ee88e79 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -67,7 +67,7 @@ sbc_emulate_readcapacity(struct se_cmd *cmd)
 		transport_kunmap_data_sg(cmd);
 	}
 
-	target_complete_cmd_with_length(cmd, GOOD, 8);
+	target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, 8);
 	return 0;
 }
 
@@ -130,7 +130,7 @@ sbc_emulate_readcapacity_16(struct se_cmd *cmd)
 		transport_kunmap_data_sg(cmd);
 	}
 
-	target_complete_cmd_with_length(cmd, GOOD, 32);
+	target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, 32);
 	return 0;
 }
 
@@ -202,14 +202,14 @@ sbc_execute_write_same_unmap(struct se_cmd *cmd)
 			return ret;
 	}
 
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
 static sense_reason_t
 sbc_emulate_noop(struct se_cmd *cmd)
 {
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
@@ -1245,7 +1245,7 @@ sbc_execute_unmap(struct se_cmd *cmd)
 err:
 	transport_kunmap_data_sg(cmd);
 	if (!ret)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return ret;
 }
 
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index 70a661801cb9..0756a690ea84 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -750,7 +750,7 @@ spc_emulate_inquiry(struct se_cmd *cmd)
 	kfree(buf);
 
 	if (!ret)
-		target_complete_cmd_with_length(cmd, GOOD, len);
+		target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, len);
 	return ret;
 }
 
@@ -1104,7 +1104,7 @@ static sense_reason_t spc_emulate_modesense(struct se_cmd *cmd)
 		transport_kunmap_data_sg(cmd);
 	}
 
-	target_complete_cmd_with_length(cmd, GOOD, length);
+	target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, length);
 	return 0;
 }
 
@@ -1122,7 +1122,7 @@ static sense_reason_t spc_emulate_modeselect(struct se_cmd *cmd)
 	int i;
 
 	if (!cmd->data_length) {
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 		return 0;
 	}
 
@@ -1165,7 +1165,7 @@ static sense_reason_t spc_emulate_modeselect(struct se_cmd *cmd)
 	transport_kunmap_data_sg(cmd);
 
 	if (!ret)
-		target_complete_cmd(cmd, GOOD);
+		target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return ret;
 }
 
@@ -1198,7 +1198,7 @@ static sense_reason_t spc_emulate_request_sense(struct se_cmd *cmd)
 	memcpy(rbuf, buf, min_t(u32, sizeof(buf), cmd->data_length));
 	transport_kunmap_data_sg(cmd);
 
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
@@ -1265,7 +1265,7 @@ sense_reason_t spc_emulate_report_luns(struct se_cmd *cmd)
 		transport_kunmap_data_sg(cmd);
 	}
 
-	target_complete_cmd_with_length(cmd, GOOD, 8 + lun_count * 8);
+	target_complete_cmd_with_length(cmd, SAM_STAT_GOOD, 8 + lun_count * 8);
 	return 0;
 }
 EXPORT_SYMBOL(spc_emulate_report_luns);
@@ -1273,7 +1273,7 @@ EXPORT_SYMBOL(spc_emulate_report_luns);
 static sense_reason_t
 spc_emulate_testunitready(struct se_cmd *cmd)
 {
-	target_complete_cmd(cmd, GOOD);
+	target_complete_cmd(cmd, SAM_STAT_GOOD);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index d31ed071cb08..44d76c304701 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -1011,7 +1011,7 @@ static sense_reason_t target_rcr_operating_parameters(struct se_cmd *se_cmd)
 	put_unaligned_be32(42, &p[0]);
 
 	transport_kunmap_data_sg(se_cmd);
-	target_complete_cmd(se_cmd, GOOD);
+	target_complete_cmd(se_cmd, SAM_STAT_GOOD);
 
 	return TCM_NO_SENSE;
 }
-- 
2.29.2

