Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29B512FFB
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Apr 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiD1JuQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Apr 2022 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiD1JdE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 Apr 2022 05:33:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FC7CDD9;
        Thu, 28 Apr 2022 02:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbs8FS0UYtCjiklv5ZbbzG2YCARn/9n7T+ZQUoapdg4/ODYr5xKlxKdeNpa4m4N1ebqKKhBP6B/zA1Qum3gMQpTb9bxE6Hlt2/eh4Oc+d6+EzyW8biDG9dGPbJxSEacs6v9v3BHTNcJoqUgLVSqDat6hnKgCxW3xOz7uMLPPRkbSWmS/cPcVZRvun2e3/3aAzc+/XoWxo8G/sXwywTA9EwqQf3eiH0+3dpIF2BNL+5oOxUZirjhRvEX+1e2m2xXADQwa1TTgsJJDUElKYRUBgVfi9x4VRs06hUgh0s6ib2QpVjlpWNqKslY675qAnHFCWWsJCojtC+dn+a5EEGWW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzg/TcKbzkamBV8shzeHH3T6AxqERhAEIltL6lyxwB4=;
 b=ACd2yS47ihfIqjg4J6zRvDTWm+aXgxutYt4fM66NNwMl2PZ2I86YnIpVp4ai6IUMNRhCdvrtawUhlCyDLw8M/+kG4cC/IKL2uyHjpUBc2/dhQMiAgUP6C8giW0xvWEZ/OM0amQW2WgOecaM3fjy555lxGqJpG8tv1PTXy4cjf8woxRH9QDEBwJqX7lTTr8J3Sub5Brbwj4UgoHJA6bjO85mYT5JF/RPA6K2dwYZGPI25HiNw4XV+cfbi51O1SbQUOn5VLK67CtIuVZ51lRIJ8gN5VhvAL0AD2oQ5GnHA8fkpwrzGZxUsIeAS6xcgETo6Plfa9kycilKMdVblFLKJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzg/TcKbzkamBV8shzeHH3T6AxqERhAEIltL6lyxwB4=;
 b=jOy2oeGYuCGdubBsP/WHTzOTgtO3uCgZNtNU7Xk+KYHqkvDGhHzKX5v0uxQ5UYZ8QlBAIO1cC2JVtHaXy0dtSkVIx1eM0V4I4Qq4ufX3nU4ZkfmL4jyHi9o8R1mYUJuNZYt342eq8lyUsBH4zROiM38Q0sQfUNI6gs8aioKyQ+wddoKKEc85xlR/dw3ne8WI11DQoCmJkJXMHHWREr6b6KDsXMPaVYs0ITgmAPhwAmDjbPDfofHv1WCbYQ3tvtKz6V4qcbVfs2ytKcGX4vsb4x77wyU9zW3u8T1YLXNVjikSc1INbnHJ6Nr0/20oPZmskpDgwGvoGAuBiFNfQUeIgQ==
Received: from DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) by
 DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.19; Thu, 28 Apr 2022 09:29:44 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::36) by DM6PR01CA0001.outlook.office365.com
 (2603:10b6:5:296::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 09:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 09:29:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 28 Apr 2022 09:29:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:29:42 -0700
Received: from r-arch-stor04.mtr.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 28 Apr 2022 02:29:40 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <michael.christie@oracle.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] target/iscsi: rename iscsi_cmd to iscsit_cmd
Date:   Thu, 28 Apr 2022 12:29:37 +0300
Message-ID: <20220428092939.36768-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6803c7ef-27cf-473d-f22c-08da28f9a0cc
X-MS-TrafficTypeDiagnostic: DS7PR12MB6141:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6141549F1A5E13961A71EDCFDEFD9@DS7PR12MB6141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4XZMTpzmlUgOccMSk5iXhtSz4x8uLKbqw0hL7pP+wEgYxqrfo3m9+2iaaA8KPjkQ2nacqixnei0rUV3VybBXBdHuiwxBp4KHAGzzaTolqAFWLbsLxx/2uqs4EMX3MvXDvypxH4OGyHMuGM+p8kL2I+UXNOH7uVMOehZpazMVbMpu6IrOQTlBEWqWGX7AeTb8Vo6y/NdHNON6Fq7wqJw7YLu1xg5dImtjSeVGIAx29Xg4mTQIkbymTlSeYPfEAIXAqCmD3N+Tk985oDax1TsEP14GTW6cWk3mGQukHEvWga2khxA8CCjUBFngRchxgKFMOWX6T5xgyfgEzJd8X0//7vx+wPDiDMxxOifuKNi6dmcOL1WR8sTFGWJhQN31uvd2Llv7+bdWbsyFiRhCAN2t2K4GNRhSMzLvQDcNhfUBhxx8B01i9uHfxLJ8FXy0gl8STQFt3mxHAzpSdLu52djz6AUdx6PwRbvvvQNCbCEE2YJz92WTRLcaj5wP0krx0LU62ETniMu62qHok85jCKQ/JxUwaESw9i59XSUg2l+9zZQwDmyuwvB41XLttlcitQfJOU2gd/kBfgkb+koKmsU+FgDYtxN1/qUTXxux24jD+kUkWC4KZoBIzvkP3HT+nqMtAhiBV6qjPa0SovLVNniI4mkwy11yJISnfiHxUarX5lBzJCzV1oDNRutilLhTmHaM3HAvVp79NXKPGStSE3vvji/r0azqn/9/ebTDXz4hI8=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(356005)(30864003)(426003)(336012)(4326008)(110136005)(8676002)(81166007)(82310400005)(2616005)(70206006)(316002)(5660300002)(8936002)(47076005)(40460700003)(54906003)(508600001)(107886003)(2906002)(83380400001)(6666004)(36756003)(1076003)(26005)(186003)(86362001)(70586007)(21314003)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:29:43.4381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6803c7ef-27cf-473d-f22c-08da28f9a0cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The structure iscsi_cmd naming is used by the iscsi initiator driver.
Rename the target cmd to iscsit_cmd to have more readable code.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c       |  64 ++++----
 drivers/infiniband/ulp/isert/ib_isert.h       |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit.h          |   8 +-
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c      |   4 +-
 drivers/target/iscsi/cxgbit/cxgbit_target.c   |  34 ++--
 drivers/target/iscsi/iscsi_target.c           | 150 +++++++++---------
 drivers/target/iscsi/iscsi_target.h           |  14 +-
 drivers/target/iscsi/iscsi_target_configfs.c  |  14 +-
 .../target/iscsi/iscsi_target_datain_values.c |  18 +--
 .../target/iscsi/iscsi_target_datain_values.h |  12 +-
 drivers/target/iscsi/iscsi_target_device.c    |   2 +-
 drivers/target/iscsi/iscsi_target_device.h    |   4 +-
 drivers/target/iscsi/iscsi_target_erl0.c      |  30 ++--
 drivers/target/iscsi/iscsi_target_erl0.h      |   8 +-
 drivers/target/iscsi/iscsi_target_erl1.c      |  42 ++---
 drivers/target/iscsi/iscsi_target_erl1.h      |  20 +--
 drivers/target/iscsi/iscsi_target_erl2.c      |  20 +--
 drivers/target/iscsi/iscsi_target_erl2.h      |   8 +-
 drivers/target/iscsi/iscsi_target_nego.c      |   2 +-
 .../target/iscsi/iscsi_target_seq_pdu_list.c  |  34 ++--
 .../target/iscsi/iscsi_target_seq_pdu_list.h  |  10 +-
 drivers/target/iscsi/iscsi_target_tmr.c       |  38 ++---
 drivers/target/iscsi/iscsi_target_tmr.h       |   8 +-
 drivers/target/iscsi/iscsi_target_util.c      |  66 ++++----
 drivers/target/iscsi/iscsi_target_util.h      |  48 +++---
 include/target/iscsi/iscsi_target_core.h      |  34 ++--
 include/target/iscsi/iscsi_transport.h        |  92 +++++------
 27 files changed, 393 insertions(+), 393 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 636d590765f9..4cb746ab53be 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -46,7 +46,7 @@ static struct workqueue_struct *isert_comp_wq;
 static struct workqueue_struct *isert_release_wq;
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd);
+isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd);
 static int
 isert_login_post_recv(struct isert_conn *isert_conn);
 static int
@@ -1020,21 +1020,21 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 	schedule_delayed_work(&conn->login_work, 0);
 }
 
-static struct iscsi_cmd
+static struct iscsit_cmd
 *isert_allocate_cmd(struct iscsi_conn *conn, struct iser_rx_desc *rx_desc)
 {
 	struct isert_conn *isert_conn = conn->context;
 	struct isert_cmd *isert_cmd;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd) {
-		isert_err("Unable to allocate iscsi_cmd + isert_cmd\n");
+		isert_err("Unable to allocate iscsit_cmd + isert_cmd\n");
 		return NULL;
 	}
 	isert_cmd = iscsit_priv_cmd(cmd);
 	isert_cmd->conn = isert_conn;
-	isert_cmd->iscsi_cmd = cmd;
+	isert_cmd->iscsit_cmd = cmd;
 	isert_cmd->rx_desc = rx_desc;
 
 	return cmd;
@@ -1042,7 +1042,7 @@ static struct iscsi_cmd
 
 static int
 isert_handle_scsi_cmd(struct isert_conn *isert_conn,
-		      struct isert_cmd *isert_cmd, struct iscsi_cmd *cmd,
+		      struct isert_cmd *isert_cmd, struct iscsit_cmd *cmd,
 		      struct iser_rx_desc *rx_desc, unsigned char *buf)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1115,7 +1115,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 {
 	struct scatterlist *sg_start;
 	struct iscsi_conn *conn = isert_conn->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
 	u32 unsol_data_len = ntoh24(hdr->dlength);
 	int rc, sg_nents, sg_off, page_off;
@@ -1171,7 +1171,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 
 static int
 isert_handle_nop_out(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
-		     struct iscsi_cmd *cmd, struct iser_rx_desc *rx_desc,
+		     struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		     unsigned char *buf)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1190,7 +1190,7 @@ isert_handle_nop_out(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
 
 static int
 isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
-		      struct iscsi_cmd *cmd, struct iser_rx_desc *rx_desc,
+		      struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		      struct iscsi_text *hdr)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1221,7 +1221,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 {
 	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
 	struct iscsi_conn *conn = isert_conn->conn;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct isert_cmd *isert_cmd;
 	int ret = -EINVAL;
 	u8 opcode = (hdr->opcode & ISCSI_OPCODE_MASK);
@@ -1404,7 +1404,7 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 static void
 isert_rdma_rw_ctx_destroy(struct isert_cmd *cmd, struct isert_conn *conn)
 {
-	struct se_cmd *se_cmd = &cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *se_cmd = &cmd->iscsit_cmd->se_cmd;
 	enum dma_data_direction dir = target_reverse_dma_direction(se_cmd);
 
 	if (!cmd->rw.nr_ops)
@@ -1426,7 +1426,7 @@ isert_rdma_rw_ctx_destroy(struct isert_cmd *cmd, struct isert_conn *conn)
 static void
 isert_put_cmd(struct isert_cmd *isert_cmd, bool comp_err)
 {
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 	struct isert_conn *isert_conn = isert_cmd->conn;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_text_rsp *hdr;
@@ -1575,7 +1575,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_device *device = isert_conn->device;
 	struct iser_tx_desc *desc = cqe_to_tx_desc(wc->wr_cqe);
 	struct isert_cmd *isert_cmd = tx_desc_to_cmd(desc);
-	struct se_cmd *cmd = &isert_cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *cmd = &isert_cmd->iscsit_cmd->se_cmd;
 	int ret = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
@@ -1604,7 +1604,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		/*
 		 * XXX: isert_put_response() failure is not retried.
 		 */
-		ret = isert_put_response(isert_conn->conn, isert_cmd->iscsi_cmd);
+		ret = isert_put_response(isert_conn->conn, isert_cmd->iscsit_cmd);
 		if (ret)
 			pr_warn_ratelimited("isert_put_response() ret: %d\n", ret);
 	}
@@ -1617,7 +1617,7 @@ isert_rdma_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_device *device = isert_conn->device;
 	struct iser_tx_desc *desc = cqe_to_tx_desc(wc->wr_cqe);
 	struct isert_cmd *isert_cmd = tx_desc_to_cmd(desc);
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	int ret = 0;
 
@@ -1662,7 +1662,7 @@ isert_do_control_comp(struct work_struct *work)
 			struct isert_cmd, comp_work);
 	struct isert_conn *isert_conn = isert_cmd->conn;
 	struct ib_device *ib_dev = isert_conn->cm_id->device;
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 
 	isert_dbg("Cmd %p i_state %d\n", isert_cmd, cmd->i_state);
 
@@ -1720,7 +1720,7 @@ isert_send_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	isert_dbg("Cmd %p\n", isert_cmd);
 
-	switch (isert_cmd->iscsi_cmd->i_state) {
+	switch (isert_cmd->iscsit_cmd->i_state) {
 	case ISTATE_SEND_TASKMGTRSP:
 	case ISTATE_SEND_LOGOUTRSP:
 	case ISTATE_SEND_REJECT:
@@ -1731,7 +1731,7 @@ isert_send_done(struct ib_cq *cq, struct ib_wc *wc)
 		queue_work(isert_comp_wq, &isert_cmd->comp_work);
 		return;
 	default:
-		isert_cmd->iscsi_cmd->i_state = ISTATE_SENT_STATUS;
+		isert_cmd->iscsit_cmd->i_state = ISTATE_SENT_STATUS;
 		isert_completion_put(tx_desc, isert_cmd, ib_dev, false);
 		break;
 	}
@@ -1755,7 +1755,7 @@ isert_post_response(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd)
 }
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1806,7 +1806,7 @@ isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 }
 
 static void
-isert_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1842,7 +1842,7 @@ isert_get_sup_prot_ops(struct iscsi_conn *conn)
 }
 
 static int
-isert_put_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+isert_put_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		bool nopout_response)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -1862,7 +1862,7 @@ isert_put_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 
 static int
-isert_put_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1880,7 +1880,7 @@ isert_put_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_tm_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_tm_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1898,7 +1898,7 @@ isert_put_tm_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1933,7 +1933,7 @@ isert_put_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -2035,7 +2035,7 @@ static int
 isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 		struct ib_cqe *cqe, struct ib_send_wr *chain_wr)
 {
-	struct se_cmd *se_cmd = &cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *se_cmd = &cmd->iscsit_cmd->se_cmd;
 	enum dma_data_direction dir = target_reverse_dma_direction(se_cmd);
 	u8 port_num = conn->cm_id->port_num;
 	u64 addr;
@@ -2048,7 +2048,7 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 	if (dir == DMA_FROM_DEVICE) {
 		addr = cmd->write_va;
 		rkey = cmd->write_stag;
-		offset = cmd->iscsi_cmd->write_data_done;
+		offset = cmd->iscsit_cmd->write_data_done;
 	} else {
 		addr = cmd->read_va;
 		rkey = cmd->read_stag;
@@ -2088,7 +2088,7 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 }
 
 static int
-isert_put_datain(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_put_datain(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -2129,7 +2129,7 @@ isert_put_datain(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 }
 
 static int
-isert_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd, bool recovery)
+isert_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd, bool recovery)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret;
@@ -2147,7 +2147,7 @@ isert_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd, bool recovery)
 }
 
 static int
-isert_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+isert_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret = 0;
@@ -2172,7 +2172,7 @@ isert_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
 }
 
 static int
-isert_response_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+isert_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_conn *isert_conn = conn->context;
 	int ret;
@@ -2523,7 +2523,7 @@ isert_wait4cmds(struct iscsi_conn *conn)
 static void
 isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd, *tmp;
+	struct iscsit_cmd *cmd, *tmp;
 	static LIST_HEAD(drop_cmd_list);
 
 	spin_lock_bh(&conn->cmd_lock);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index ca8cfebe26ca..a462834cb332 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -146,7 +146,7 @@ struct isert_cmd {
 	u64			pdu_buf_dma;
 	u32			pdu_buf_len;
 	struct isert_conn	*conn;
-	struct iscsi_cmd	*iscsi_cmd;
+	struct iscsit_cmd	*iscsit_cmd;
 	struct iser_tx_desc	tx_desc;
 	struct iser_rx_desc	*rx_desc;
 	struct rdma_rw_ctx	rw;
diff --git a/drivers/target/iscsi/cxgbit/cxgbit.h b/drivers/target/iscsi/cxgbit/cxgbit.h
index 406903398dfd..b23edcb41489 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit.h
+++ b/drivers/target/iscsi/cxgbit/cxgbit.h
@@ -327,9 +327,9 @@ int cxgbit_l2t_send(struct cxgbit_device *, struct sk_buff *,
 		    struct l2t_entry *);
 void cxgbit_push_tx_frames(struct cxgbit_sock *);
 int cxgbit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-int cxgbit_xmit_pdu(struct iscsi_conn *, struct iscsi_cmd *,
+int cxgbit_xmit_pdu(struct iscsi_conn *, struct iscsit_cmd *,
 		    struct iscsi_datain_req *, const void *, u32);
-void cxgbit_get_r2t_ttt(struct iscsi_conn *, struct iscsi_cmd *,
+void cxgbit_get_r2t_ttt(struct iscsi_conn *, struct iscsit_cmd *,
 			struct iscsi_r2t *);
 u32 cxgbit_send_tx_flowc_wr(struct cxgbit_sock *);
 int cxgbit_ofld_send(struct cxgbit_device *, struct sk_buff *);
@@ -340,8 +340,8 @@ struct cxgbit_device *cxgbit_find_device(struct net_device *, u8 *);
 /* DDP */
 int cxgbit_ddp_init(struct cxgbit_device *);
 int cxgbit_setup_conn_pgidx(struct cxgbit_sock *, u32);
-int cxgbit_reserve_ttt(struct cxgbit_sock *, struct iscsi_cmd *);
-void cxgbit_unmap_cmd(struct iscsi_conn *, struct iscsi_cmd *);
+int cxgbit_reserve_ttt(struct cxgbit_sock *, struct iscsit_cmd *);
+void cxgbit_unmap_cmd(struct iscsi_conn *, struct iscsit_cmd *);
 
 static inline
 struct cxgbi_ppm *cdev2ppm(struct cxgbit_device *cdev)
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
index 072afd070f3e..5feebb6c6de4 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
@@ -227,7 +227,7 @@ cxgbit_ddp_reserve(struct cxgbit_sock *csk, struct cxgbi_task_tag_info *ttinfo,
 }
 
 void
-cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_r2t *r2t)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -260,7 +260,7 @@ cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	r2t->targ_xfer_tag = ttinfo->tag;
 }
 
-void cxgbit_unmap_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+void cxgbit_unmap_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct cxgbit_cmd *ccmd = iscsit_priv_cmd(cmd);
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
index d314ee120a48..99901a8a3f64 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -337,7 +337,7 @@ static int cxgbit_queue_skb(struct cxgbit_sock *csk, struct sk_buff *skb)
 }
 
 static int
-cxgbit_map_skb(struct iscsi_cmd *cmd, struct sk_buff *skb, u32 data_offset,
+cxgbit_map_skb(struct iscsit_cmd *cmd, struct sk_buff *skb, u32 data_offset,
 	       u32 data_length)
 {
 	u32 i = 0, nr_frags = MAX_SKB_FRAGS;
@@ -390,7 +390,7 @@ cxgbit_map_skb(struct iscsi_cmd *cmd, struct sk_buff *skb, u32 data_offset,
 }
 
 static int
-cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
+cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 		     struct iscsi_datain_req *dr)
 {
 	struct iscsi_conn *conn = csk->conn;
@@ -481,7 +481,7 @@ cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
+cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 		 const struct iscsi_datain *datain)
 {
 	struct sk_buff *skb;
@@ -510,7 +510,7 @@ cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       struct iscsi_datain_req *dr,
 		       const struct iscsi_datain *datain)
 {
@@ -530,7 +530,7 @@ cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -560,7 +560,7 @@ cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 int
-cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		struct iscsi_datain_req *dr, const void *buf, u32 buf_len)
 {
 	if (dr)
@@ -832,16 +832,16 @@ cxgbit_skb_copy_to_sg(struct sk_buff *skb, struct scatterlist *sg,
 	}
 }
 
-static struct iscsi_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
+static struct iscsit_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbi_ppm *ppm = cdev2ppm(csk->com.cdev);
 	struct cxgbit_cmd *ccmd;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd) {
-		pr_err("Unable to allocate iscsi_cmd + cxgbit_cmd\n");
+		pr_err("Unable to allocate iscsit_cmd + cxgbit_cmd\n");
 		return NULL;
 	}
 
@@ -853,7 +853,7 @@ static struct iscsi_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
 }
 
 static int
-cxgbit_handle_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+cxgbit_handle_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			     u32 length)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -910,7 +910,7 @@ cxgbit_handle_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-cxgbit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			  bool dump_payload)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -964,7 +964,7 @@ cxgbit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -996,7 +996,7 @@ static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 {
 	struct scatterlist *sg_start;
 	struct iscsi_conn *conn = csk->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct cxgbit_cmd *ccmd;
 	struct cxgbi_task_tag_info *ttinfo;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1084,7 +1084,7 @@ static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 	return 0;
 }
 
-static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1134,7 +1134,7 @@ static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
 
 		ping_data[payload_length] = '\0';
 		/*
-		 * Attach ping data to struct iscsi_cmd->buf_ptr.
+		 * Attach ping data to struct iscsit_cmd->buf_ptr.
 		 */
 		cmd->buf_ptr = ping_data;
 		cmd->buf_ptr_size = payload_length;
@@ -1152,7 +1152,7 @@ static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
 }
 
 static int
-cxgbit_handle_text_cmd(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+cxgbit_handle_text_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1210,7 +1210,7 @@ static int cxgbit_target_rx_opcode(struct cxgbit_sock *csk)
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)pdu_cb->hdr;
 	struct iscsi_conn *conn = csk->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	u8 opcode = (hdr->opcode & ISCSI_OPCODE_MASK);
 	int ret = -EINVAL;
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 6fe6a6bab3f4..4d71eb8fa6ab 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -59,7 +59,7 @@ struct kmem_cache *lio_dr_cache;
 struct kmem_cache *lio_ooo_cache;
 struct kmem_cache *lio_r2t_cache;
 
-static int iscsit_handle_immediate_data(struct iscsi_cmd *,
+static int iscsit_handle_immediate_data(struct iscsit_cmd *,
 			struct iscsi_scsi_req *, u32);
 
 struct iscsi_tiqn *iscsit_get_tiqn_for_login(unsigned char *buf)
@@ -474,13 +474,13 @@ int iscsit_del_np(struct iscsi_np *np)
 
 static void iscsit_get_rx_pdu(struct iscsi_conn *);
 
-int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	return iscsit_add_cmd_to_response_queue(cmd, cmd->conn, cmd->i_state);
 }
 EXPORT_SYMBOL(iscsit_queue_rsp);
 
-void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	spin_lock_bh(&conn->cmd_lock);
 	if (!list_empty(&cmd->i_conn_node))
@@ -496,7 +496,7 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *, const void *,
 static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *);
 
 static int
-iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)cmd->pdu;
@@ -564,13 +564,13 @@ iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return 0;
 }
 
-static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
+static int iscsit_map_iovec(struct iscsit_cmd *cmd, struct kvec *iov, int nvec,
 			    u32 data_offset, u32 data_length);
-static void iscsit_unmap_iovec(struct iscsi_cmd *);
-static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsi_cmd *,
+static void iscsit_unmap_iovec(struct iscsit_cmd *);
+static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsit_cmd *,
 				    u32, u32, u32, u8 *);
 static int
-iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       const struct iscsi_datain *datain)
 {
 	struct kvec *iov;
@@ -644,7 +644,7 @@ iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return 0;
 }
 
-static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_datain_req *dr, const void *buf,
 			   u32 buf_len)
 {
@@ -800,7 +800,7 @@ int iscsit_add_reject(
 	u8 reason,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd)
@@ -828,7 +828,7 @@ int iscsit_add_reject(
 EXPORT_SYMBOL(iscsit_add_reject);
 
 static int iscsit_add_reject_from_cmd(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 reason,
 	bool add_to_conn,
 	unsigned char *buf)
@@ -872,13 +872,13 @@ static int iscsit_add_reject_from_cmd(
 	return -1;
 }
 
-static int iscsit_add_reject_cmd(struct iscsi_cmd *cmd, u8 reason,
+static int iscsit_add_reject_cmd(struct iscsit_cmd *cmd, u8 reason,
 				 unsigned char *buf)
 {
 	return iscsit_add_reject_from_cmd(cmd, reason, true, buf);
 }
 
-int iscsit_reject_cmd(struct iscsi_cmd *cmd, u8 reason, unsigned char *buf)
+int iscsit_reject_cmd(struct iscsit_cmd *cmd, u8 reason, unsigned char *buf)
 {
 	return iscsit_add_reject_from_cmd(cmd, reason, false, buf);
 }
@@ -888,7 +888,7 @@ EXPORT_SYMBOL(iscsit_reject_cmd);
  * Map some portion of the allocated scatterlist to an iovec, suitable for
  * kernel sockets to copy data in/out.
  */
-static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
+static int iscsit_map_iovec(struct iscsit_cmd *cmd, struct kvec *iov, int nvec,
 			    u32 data_offset, u32 data_length)
 {
 	u32 i = 0, orig_data_length = data_length;
@@ -946,7 +946,7 @@ static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
 	return -1;
 }
 
-static void iscsit_unmap_iovec(struct iscsi_cmd *cmd)
+static void iscsit_unmap_iovec(struct iscsit_cmd *cmd)
 {
 	u32 i;
 	struct scatterlist *sg;
@@ -960,7 +960,7 @@ static void iscsit_unmap_iovec(struct iscsi_cmd *cmd)
 static void iscsit_ack_from_expstatsn(struct iscsi_conn *conn, u32 exp_statsn)
 {
 	LIST_HEAD(ack_list);
-	struct iscsi_cmd *cmd, *cmd_p;
+	struct iscsit_cmd *cmd, *cmd_p;
 
 	conn->exp_statsn = exp_statsn;
 
@@ -987,7 +987,7 @@ static void iscsit_ack_from_expstatsn(struct iscsi_conn *conn, u32 exp_statsn)
 	}
 }
 
-static int iscsit_allocate_iovecs(struct iscsi_cmd *cmd)
+static int iscsit_allocate_iovecs(struct iscsit_cmd *cmd)
 {
 	u32 iov_count = max(1UL, DIV_ROUND_UP(cmd->se_cmd.data_length, PAGE_SIZE));
 
@@ -1000,7 +1000,7 @@ static int iscsit_allocate_iovecs(struct iscsi_cmd *cmd)
 	return 0;
 }
 
-int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  unsigned char *buf)
 {
 	int data_direction, payload_length;
@@ -1215,7 +1215,7 @@ int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_setup_scsi_cmd);
 
-void iscsit_set_unsolicited_dataout(struct iscsi_cmd *cmd)
+void iscsit_set_unsolicited_dataout(struct iscsit_cmd *cmd)
 {
 	iscsit_set_dataout_sequence_values(cmd);
 
@@ -1225,7 +1225,7 @@ void iscsit_set_unsolicited_dataout(struct iscsi_cmd *cmd)
 }
 EXPORT_SYMBOL(iscsit_set_unsolicited_dataout);
 
-int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			    struct iscsi_scsi_req *hdr)
 {
 	int cmdsn_ret = 0;
@@ -1285,7 +1285,7 @@ int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_process_scsi_cmd);
 
 static int
-iscsit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+iscsit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			  bool dump_payload)
 {
 	int cmdsn_ret = 0, immed_ret = IMMEDIATE_DATA_NORMAL_OPERATION;
@@ -1349,7 +1349,7 @@ iscsit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)buf;
@@ -1383,7 +1383,7 @@ iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 static u32 iscsit_do_crypto_hash_sg(
 	struct ahash_request *hash,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 data_offset,
 	u32 data_length,
 	u32 padding,
@@ -1456,7 +1456,7 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
 
 int
 __iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			   struct iscsi_cmd *cmd, u32 payload_length,
+			   struct iscsit_cmd *cmd, u32 payload_length,
 			   bool *success)
 {
 	struct iscsi_data *hdr = buf;
@@ -1560,10 +1560,10 @@ EXPORT_SYMBOL(__iscsit_check_dataout_hdr);
 
 int
 iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			 struct iscsi_cmd **out_cmd)
+			 struct iscsit_cmd **out_cmd)
 {
 	struct iscsi_data *hdr = buf;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u32 payload_length = ntoh24(hdr->dlength);
 	int rc;
 	bool success = false;
@@ -1594,7 +1594,7 @@ iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
 EXPORT_SYMBOL(iscsit_check_dataout_hdr);
 
 static int
-iscsit_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_data *hdr)
 {
 	struct kvec *iov;
@@ -1662,7 +1662,7 @@ iscsit_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 int
-iscsit_check_dataout_payload(struct iscsi_cmd *cmd, struct iscsi_data *hdr,
+iscsit_check_dataout_payload(struct iscsit_cmd *cmd, struct iscsi_data *hdr,
 			     bool data_crc_failed)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -1702,7 +1702,7 @@ EXPORT_SYMBOL(iscsit_check_dataout_payload);
 
 static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
 	int rc;
 	bool data_crc_failed = false;
@@ -1722,7 +1722,7 @@ static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
 	return iscsit_check_dataout_payload(cmd, hdr, data_crc_failed);
 }
 
-int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			 struct iscsi_nopout *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -1770,7 +1770,7 @@ int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	 * This is not a response to a Unsolicited NopIN, which means
 	 * it can either be a NOPOUT ping request (with a valid ITT),
 	 * or a NOPOUT not requesting a NOPIN (with a reserved ITT).
-	 * Either way, make sure we allocate an struct iscsi_cmd, as both
+	 * Either way, make sure we allocate an struct iscsit_cmd, as both
 	 * can contain ping data.
 	 */
 	if (hdr->ttt == cpu_to_be32(0xFFFFFFFF)) {
@@ -1789,10 +1789,10 @@ int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_setup_nop_out);
 
-int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_nopout *hdr)
 {
-	struct iscsi_cmd *cmd_p = NULL;
+	struct iscsit_cmd *cmd_p = NULL;
 	int cmdsn_ret = 0;
 	/*
 	 * Initiator is expecting a NopIN ping reply..
@@ -1851,7 +1851,7 @@ int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_process_nop_out);
 
-static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 				 unsigned char *buf)
 {
 	unsigned char *ping_data = NULL;
@@ -1936,7 +1936,7 @@ static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 		ping_data[payload_length] = '\0';
 		/*
-		 * Attach ping data to struct iscsi_cmd->buf_ptr.
+		 * Attach ping data to struct iscsit_cmd->buf_ptr.
 		 */
 		cmd->buf_ptr = ping_data;
 		cmd->buf_ptr_size = payload_length;
@@ -1978,7 +1978,7 @@ static enum tcm_tmreq_table iscsit_convert_tmf(u8 iscsi_tmf)
 }
 
 int
-iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct se_tmr_req *se_tmr;
@@ -2159,7 +2159,7 @@ EXPORT_SYMBOL(iscsit_handle_task_mgt_cmd);
 
 /* #warning FIXME: Support Text Command parameters besides SendTargets */
 int
-iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		      struct iscsi_text *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -2199,7 +2199,7 @@ iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_setup_text_cmd);
 
 int
-iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			struct iscsi_text *hdr)
 {
 	unsigned char *text_in = cmd->text_in_ptr, *text_ptr;
@@ -2258,7 +2258,7 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_process_text_cmd);
 
 static int
-iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       unsigned char *buf)
 {
 	struct iscsi_text *hdr = (struct iscsi_text *)buf;
@@ -2347,7 +2347,7 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return iscsit_reject_cmd(cmd, ISCSI_REASON_PROTOCOL_ERROR, buf);
 }
 
-int iscsit_logout_closesession(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closesession(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_conn *conn_p;
 	struct iscsi_session *sess = conn->sess;
@@ -2377,7 +2377,7 @@ int iscsit_logout_closesession(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_logout_closeconnection(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closeconnection(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_conn *l_conn;
 	struct iscsi_session *sess = conn->sess;
@@ -2425,7 +2425,7 @@ int iscsit_logout_closeconnection(struct iscsi_cmd *cmd, struct iscsi_conn *conn
 	return 0;
 }
 
-int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 
@@ -2455,7 +2455,7 @@ int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *cmd, struct iscsi_conn
 }
 
 int
-iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf)
 {
 	int cmdsn_ret, logout_remove = 0;
@@ -2601,7 +2601,7 @@ static void iscsit_rx_thread_wait_for_tcp(struct iscsi_conn *conn)
 }
 
 static int iscsit_handle_immediate_data(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_scsi_req *hdr,
 	u32 length)
 {
@@ -2710,7 +2710,7 @@ static int iscsit_handle_immediate_data(
 	with active network interface */
 static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct iscsi_conn *conn_p;
 	bool found = false;
 
@@ -2750,7 +2750,7 @@ static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
 }
 
 static int iscsit_send_conn_drop_async_message(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_async *hdr;
@@ -2790,7 +2790,7 @@ static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_datain_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_datain_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			struct iscsi_datain *datain, struct iscsi_data_rsp *hdr,
 			bool set_statsn)
 {
@@ -2835,7 +2835,7 @@ iscsit_build_datain_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_datain_pdu);
 
-static int iscsit_send_datain(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_datain(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_data_rsp *hdr = (struct iscsi_data_rsp *)&cmd->pdu[0];
 	struct iscsi_datain datain;
@@ -2896,7 +2896,7 @@ static int iscsit_send_datain(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 int
-iscsit_build_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			struct iscsi_logout_rsp *hdr)
 {
 	struct iscsi_conn *logout_conn = NULL;
@@ -2991,7 +2991,7 @@ iscsit_build_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_logout_rsp);
 
 static int
-iscsit_send_logout(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_logout(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	int rc;
 
@@ -3004,7 +3004,7 @@ iscsit_send_logout(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_nopin_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_nopin_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		       struct iscsi_nopin *hdr, bool nopout_response)
 {
 	hdr->opcode		= ISCSI_OP_NOOP_IN;
@@ -3035,7 +3035,7 @@ EXPORT_SYMBOL(iscsit_build_nopin_rsp);
  *	Unsolicited NOPIN, either requesting a response or not.
  */
 static int iscsit_send_unsolicited_nopin(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	int want_response)
 {
@@ -3060,15 +3060,15 @@ static int iscsit_send_unsolicited_nopin(
 }
 
 static int
-iscsit_send_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_nopin *hdr = (struct iscsi_nopin *)&cmd->pdu[0];
 
 	iscsit_build_nopin_rsp(cmd, conn, hdr, true);
 
 	/*
-	 * NOPOUT Ping Data is attached to struct iscsi_cmd->buf_ptr.
-	 * NOPOUT DataSegmentLength is at struct iscsi_cmd->buf_ptr_size.
+	 * NOPOUT Ping Data is attached to struct iscsit_cmd->buf_ptr.
+	 * NOPOUT DataSegmentLength is at struct iscsit_cmd->buf_ptr_size.
 	 */
 	pr_debug("Echoing back %u bytes of ping data.\n", cmd->buf_ptr_size);
 
@@ -3078,7 +3078,7 @@ iscsit_send_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int iscsit_send_r2t(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_r2t *r2t;
@@ -3136,7 +3136,7 @@ static int iscsit_send_r2t(
  */
 int iscsit_build_r2ts_for_cmd(
 	struct iscsi_conn *conn,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	bool recovery)
 {
 	int first_r2t = 1;
@@ -3218,7 +3218,7 @@ int iscsit_build_r2ts_for_cmd(
 }
 EXPORT_SYMBOL(iscsit_build_r2ts_for_cmd);
 
-void iscsit_build_rsp_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+void iscsit_build_rsp_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			bool inc_stat_sn, struct iscsi_scsi_rsp *hdr)
 {
 	if (inc_stat_sn)
@@ -3252,7 +3252,7 @@ void iscsit_build_rsp_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_rsp_pdu);
 
-static int iscsit_send_response(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_response(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_scsi_rsp *hdr = (struct iscsi_scsi_rsp *)&cmd->pdu[0];
 	bool inc_stat_sn = (cmd->i_state == ISTATE_SEND_STATUS);
@@ -3309,7 +3309,7 @@ static u8 iscsit_convert_tcm_tmr_rsp(struct se_tmr_req *se_tmr)
 }
 
 void
-iscsit_build_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			  struct iscsi_tm_rsp *hdr)
 {
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -3332,7 +3332,7 @@ iscsit_build_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_task_mgt_rsp);
 
 static int
-iscsit_send_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_tm_rsp *hdr = (struct iscsi_tm_rsp *)&cmd->pdu[0];
 
@@ -3344,7 +3344,7 @@ iscsit_send_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 #define SENDTARGETS_BUF_LIMIT 32768U
 
 static int
-iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
+iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 				  enum iscsit_transport_type network_transport,
 				  int skip_bytes, bool *completed)
 {
@@ -3494,7 +3494,7 @@ iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
 }
 
 int
-iscsit_build_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		      struct iscsi_text_rsp *hdr,
 		      enum iscsit_transport_type network_transport)
 {
@@ -3544,7 +3544,7 @@ iscsit_build_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_text_rsp);
 
 static int iscsit_send_text_rsp(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_text_rsp *hdr = (struct iscsi_text_rsp *)cmd->pdu;
@@ -3561,7 +3561,7 @@ static int iscsit_send_text_rsp(
 }
 
 void
-iscsit_build_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		    struct iscsi_reject *hdr)
 {
 	hdr->opcode		= ISCSI_OP_REJECT;
@@ -3578,7 +3578,7 @@ iscsit_build_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_reject);
 
 static int iscsit_send_reject(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_reject *hdr = (struct iscsi_reject *)&cmd->pdu[0];
@@ -3681,7 +3681,7 @@ void iscsit_thread_check_cpumask(
 EXPORT_SYMBOL(iscsit_thread_check_cpumask);
 
 int
-iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3729,7 +3729,7 @@ iscsit_handle_immediate_queue(struct iscsi_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u8 state;
 	int ret;
 
@@ -3748,7 +3748,7 @@ iscsit_handle_immediate_queue(struct iscsi_conn *conn)
 }
 
 int
-iscsit_response_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+iscsit_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3858,7 +3858,7 @@ static int iscsit_handle_response_queue(struct iscsi_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u8 state;
 	int ret;
 
@@ -3936,7 +3936,7 @@ int iscsi_target_tx_thread(void *arg)
 static int iscsi_target_rx_opcode(struct iscsi_conn *conn, unsigned char *buf)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)buf;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	int ret = 0;
 
 	switch (hdr->opcode & ISCSI_OPCODE_MASK) {
@@ -4144,7 +4144,7 @@ int iscsi_target_rx_thread(void *arg)
 static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 {
 	LIST_HEAD(tmp_list);
-	struct iscsi_cmd *cmd = NULL, *cmd_tmp = NULL;
+	struct iscsit_cmd *cmd = NULL, *cmd_tmp = NULL;
 	struct iscsi_session *sess = conn->sess;
 	/*
 	 * We expect this function to only ever be called from either RX or TX
@@ -4187,7 +4187,7 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 static void iscsit_stop_timers_for_cmds(
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -4252,7 +4252,7 @@ int iscsit_close_connection(
 	 *
 	 * During normal operation clear the out of order commands (but
 	 * do not free the struct iscsi_ooo_cmdsn's) and release all
-	 * struct iscsi_cmds.
+	 * struct iscsit_cmds.
 	 */
 	if (atomic_read(&conn->connection_recovery)) {
 		iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(conn);
@@ -4592,7 +4592,7 @@ static void iscsit_logout_post_handler_diffcid(
  *	Return of 0 causes the TX thread to restart.
  */
 int iscsit_logout_post_handler(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	int ret = 0;
diff --git a/drivers/target/iscsi/iscsi_target.h b/drivers/target/iscsi/iscsi_target.h
index b35a96ded9c1..bfa3559cf823 100644
--- a/drivers/target/iscsi/iscsi_target.h
+++ b/drivers/target/iscsi/iscsi_target.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_np;
 struct iscsi_portal_group;
@@ -30,13 +30,13 @@ extern struct iscsi_np *iscsit_add_np(struct sockaddr_storage *,
 extern int iscsit_reset_np_thread(struct iscsi_np *, struct iscsi_tpg_np *,
 				struct iscsi_portal_group *, bool);
 extern int iscsit_del_np(struct iscsi_np *);
-extern int iscsit_reject_cmd(struct iscsi_cmd *cmd, u8, unsigned char *);
-extern void iscsit_set_unsolicited_dataout(struct iscsi_cmd *);
-extern int iscsit_logout_closesession(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_closeconnection(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_reject_cmd(struct iscsit_cmd *cmd, u8, unsigned char *);
+extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
+extern int iscsit_logout_closesession(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_logout_closeconnection(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_send_async_msg(struct iscsi_conn *, u16, u8, u8);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsi_cmd *, bool recovery);
+extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *, bool recovery);
 extern void iscsit_thread_get_cpumask(struct iscsi_conn *);
 extern int iscsi_target_tx_thread(void *);
 extern int iscsi_target_rx_thread(void *);
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0cedcfe207b5..0c1f4ad3e04a 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1340,7 +1340,7 @@ static struct configfs_attribute *lio_target_discovery_auth_attrs[] = {
 
 static int iscsi_get_cmd_state(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	return cmd->i_state;
 }
@@ -1366,7 +1366,7 @@ static u32 lio_sess_get_initiator_sid(
 
 static int lio_queue_data_in(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_DATAIN;
@@ -1375,7 +1375,7 @@ static int lio_queue_data_in(struct se_cmd *se_cmd)
 
 static int lio_write_pending(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	if (!cmd->immediate_data && !cmd->unsolicited_data)
@@ -1386,7 +1386,7 @@ static int lio_write_pending(struct se_cmd *se_cmd)
 
 static int lio_queue_status(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_STATUS;
@@ -1399,7 +1399,7 @@ static int lio_queue_status(struct se_cmd *se_cmd)
 
 static void lio_queue_tm_rsp(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	cmd->i_state = ISTATE_SEND_TASKMGTRSP;
 	iscsit_add_cmd_to_response_queue(cmd, cmd->conn, cmd->i_state);
@@ -1407,7 +1407,7 @@ static void lio_queue_tm_rsp(struct se_cmd *se_cmd)
 
 static void lio_aborted_task(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	cmd->conn->conn_transport->iscsit_aborted_task(cmd->conn, cmd);
 }
@@ -1522,7 +1522,7 @@ static int lio_check_stop_free(struct se_cmd *se_cmd)
 
 static void lio_release_cmd(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	pr_debug("Entering lio_release_cmd for se_cmd: %p\n", se_cmd);
 	iscsit_release_cmd(cmd);
diff --git a/drivers/target/iscsi/iscsi_target_datain_values.c b/drivers/target/iscsi/iscsi_target_datain_values.c
index 07a22cd36a4e..091a710eadb0 100644
--- a/drivers/target/iscsi/iscsi_target_datain_values.c
+++ b/drivers/target/iscsi/iscsi_target_datain_values.c
@@ -32,14 +32,14 @@ struct iscsi_datain_req *iscsit_allocate_datain_req(void)
 	return dr;
 }
 
-void iscsit_attach_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
+void iscsit_attach_datain_req(struct iscsit_cmd *cmd, struct iscsi_datain_req *dr)
 {
 	spin_lock(&cmd->datain_lock);
 	list_add_tail(&dr->cmd_datain_node, &cmd->datain_list);
 	spin_unlock(&cmd->datain_lock);
 }
 
-void iscsit_free_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
+void iscsit_free_datain_req(struct iscsit_cmd *cmd, struct iscsi_datain_req *dr)
 {
 	spin_lock(&cmd->datain_lock);
 	list_del(&dr->cmd_datain_node);
@@ -48,7 +48,7 @@ void iscsit_free_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
 	kmem_cache_free(lio_dr_cache, dr);
 }
 
-void iscsit_free_all_datain_reqs(struct iscsi_cmd *cmd)
+void iscsit_free_all_datain_reqs(struct iscsit_cmd *cmd)
 {
 	struct iscsi_datain_req *dr, *dr_tmp;
 
@@ -60,7 +60,7 @@ void iscsit_free_all_datain_reqs(struct iscsi_cmd *cmd)
 	spin_unlock(&cmd->datain_lock);
 }
 
-struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *cmd)
+struct iscsi_datain_req *iscsit_get_datain_req(struct iscsit_cmd *cmd)
 {
 	if (list_empty(&cmd->datain_list)) {
 		pr_err("cmd->datain_list is empty for ITT:"
@@ -76,7 +76,7 @@ struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *cmd)
  *	For Normal and Recovery DataSequenceInOrder=Yes and DataPDUInOrder=Yes.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
@@ -174,7 +174,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_yes(
  *	For Normal and Recovery DataSequenceInOrder=No and DataPDUInOrder=Yes.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_no_and_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 offset, read_data_done, read_data_left, seq_send_order;
@@ -295,7 +295,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_yes(
  *	For Normal and Recovery DataSequenceInOrder=Yes and DataPDUInOrder=No.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
@@ -394,7 +394,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_no(
  *	For Normal and Recovery DataSequenceInOrder=No and DataPDUInOrder=No.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_no_and_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 read_data_done, read_data_left, seq_send_order;
@@ -496,7 +496,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_no(
 }
 
 struct iscsi_datain_req *iscsit_get_datain_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	struct iscsi_conn *conn = cmd->conn;
diff --git a/drivers/target/iscsi/iscsi_target_datain_values.h b/drivers/target/iscsi/iscsi_target_datain_values.h
index a420fbd37969..b28df886d828 100644
--- a/drivers/target/iscsi/iscsi_target_datain_values.h
+++ b/drivers/target/iscsi/iscsi_target_datain_values.h
@@ -2,15 +2,15 @@
 #ifndef ISCSI_TARGET_DATAIN_VALUES_H
 #define ISCSI_TARGET_DATAIN_VALUES_H
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_datain;
 
 extern struct iscsi_datain_req *iscsit_allocate_datain_req(void);
-extern void iscsit_attach_datain_req(struct iscsi_cmd *, struct iscsi_datain_req *);
-extern void iscsit_free_datain_req(struct iscsi_cmd *, struct iscsi_datain_req *);
-extern void iscsit_free_all_datain_reqs(struct iscsi_cmd *);
-extern struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *);
-extern struct iscsi_datain_req *iscsit_get_datain_values(struct iscsi_cmd *,
+extern void iscsit_attach_datain_req(struct iscsit_cmd *, struct iscsi_datain_req *);
+extern void iscsit_free_datain_req(struct iscsit_cmd *, struct iscsi_datain_req *);
+extern void iscsit_free_all_datain_reqs(struct iscsit_cmd *);
+extern struct iscsi_datain_req *iscsit_get_datain_req(struct iscsit_cmd *);
+extern struct iscsi_datain_req *iscsit_get_datain_values(struct iscsit_cmd *,
 			struct iscsi_datain *);
 
 #endif   /*** ISCSI_TARGET_DATAIN_VALUES_H ***/
diff --git a/drivers/target/iscsi/iscsi_target_device.c b/drivers/target/iscsi/iscsi_target_device.c
index 8bf36ec86e3f..d57041b860bd 100644
--- a/drivers/target/iscsi/iscsi_target_device.c
+++ b/drivers/target/iscsi/iscsi_target_device.c
@@ -42,7 +42,7 @@ void iscsit_determine_maxcmdsn(struct iscsi_session *sess)
 	atomic_add(se_nacl->queue_depth - 1, &sess->max_cmd_sn);
 }
 
-void iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess)
+void iscsit_increment_maxcmdsn(struct iscsit_cmd *cmd, struct iscsi_session *sess)
 {
 	u32 max_cmd_sn;
 
diff --git a/drivers/target/iscsi/iscsi_target_device.h b/drivers/target/iscsi/iscsi_target_device.h
index ab2166f17785..b6a463847720 100644
--- a/drivers/target/iscsi/iscsi_target_device.h
+++ b/drivers/target/iscsi/iscsi_target_device.h
@@ -2,10 +2,10 @@
 #ifndef ISCSI_TARGET_DEVICE_H
 #define ISCSI_TARGET_DEVICE_H
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_session;
 
 extern void iscsit_determine_maxcmdsn(struct iscsi_session *);
-extern void iscsit_increment_maxcmdsn(struct iscsi_cmd *, struct iscsi_session *);
+extern void iscsit_increment_maxcmdsn(struct iscsit_cmd *, struct iscsi_session *);
 
 #endif /* ISCSI_TARGET_DEVICE_H */
diff --git a/drivers/target/iscsi/iscsi_target_erl0.c b/drivers/target/iscsi/iscsi_target_erl0.c
index 102c9cbf59f3..8ca910571ed3 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.c
+++ b/drivers/target/iscsi/iscsi_target_erl0.c
@@ -24,12 +24,12 @@
 #include "iscsi_target.h"
 
 /*
- *	Used to set values in struct iscsi_cmd that iscsit_dataout_check_sequence()
+ *	Used to set values in struct iscsit_cmd that iscsit_dataout_check_sequence()
  *	checks against to determine a PDU's Offset+Length is within the current
  *	DataOUT Sequence.  Used for DataSequenceInOrder=Yes only.
  */
 void iscsit_set_dataout_sequence_values(
-	struct iscsi_cmd *cmd)
+	struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	/*
@@ -63,7 +63,7 @@ void iscsit_set_dataout_sequence_values(
 }
 
 static int iscsit_dataout_within_command_recovery_check(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -129,7 +129,7 @@ static int iscsit_dataout_within_command_recovery_check(
 }
 
 static int iscsit_dataout_check_unsolicited_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 first_burst_len;
@@ -204,7 +204,7 @@ static int iscsit_dataout_check_unsolicited_sequence(
 }
 
 static int iscsit_dataout_check_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 next_burst_len;
@@ -333,7 +333,7 @@ static int iscsit_dataout_check_sequence(
 }
 
 static int iscsit_dataout_check_datasn(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 data_sn = 0;
@@ -384,7 +384,7 @@ static int iscsit_dataout_check_datasn(
 }
 
 static int iscsit_dataout_pre_datapduinorder_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int dump = 0, recovery = 0;
@@ -394,7 +394,7 @@ static int iscsit_dataout_pre_datapduinorder_yes(
 
 	/*
 	 * For DataSequenceInOrder=Yes: If the offset is greater than the global
-	 * DataPDUInOrder=Yes offset counter in struct iscsi_cmd a protcol error has
+	 * DataPDUInOrder=Yes offset counter in struct iscsit_cmd a protcol error has
 	 * occurred and fail the connection.
 	 *
 	 * For DataSequenceInOrder=No: If the offset is greater than the per
@@ -446,7 +446,7 @@ static int iscsit_dataout_pre_datapduinorder_yes(
 }
 
 static int iscsit_dataout_pre_datapduinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_pdu *pdu;
@@ -477,7 +477,7 @@ static int iscsit_dataout_pre_datapduinorder_no(
 	return DATAOUT_NORMAL;
 }
 
-static int iscsit_dataout_update_r2t(struct iscsi_cmd *cmd, u32 offset, u32 length)
+static int iscsit_dataout_update_r2t(struct iscsit_cmd *cmd, u32 offset, u32 length)
 {
 	struct iscsi_r2t *r2t;
 
@@ -497,7 +497,7 @@ static int iscsit_dataout_update_r2t(struct iscsi_cmd *cmd, u32 offset, u32 leng
 }
 
 static int iscsit_dataout_update_datapduinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 data_sn,
 	int f_bit)
 {
@@ -530,7 +530,7 @@ static int iscsit_dataout_update_datapduinorder_no(
 }
 
 static int iscsit_dataout_post_crc_passed(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int ret, send_r2t = 0;
@@ -641,7 +641,7 @@ static int iscsit_dataout_post_crc_passed(
 }
 
 static int iscsit_dataout_post_crc_failed(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -679,7 +679,7 @@ static int iscsit_dataout_post_crc_failed(
  *	and CRC computed.
  */
 int iscsit_check_pre_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int ret;
@@ -717,7 +717,7 @@ int iscsit_check_pre_dataout(
  *	and CRC computed.
  */
 int iscsit_check_post_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u8 data_crc_failed)
 {
diff --git a/drivers/target/iscsi/iscsi_target_erl0.h b/drivers/target/iscsi/iscsi_target_erl0.h
index 883ebf6d36cf..d23a3041c325 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.h
+++ b/drivers/target/iscsi/iscsi_target_erl0.h
@@ -4,13 +4,13 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_session;
 
-extern void iscsit_set_dataout_sequence_values(struct iscsi_cmd *);
-extern int iscsit_check_pre_dataout(struct iscsi_cmd *, unsigned char *);
-extern int iscsit_check_post_dataout(struct iscsi_cmd *, unsigned char *, u8);
+extern void iscsit_set_dataout_sequence_values(struct iscsit_cmd *);
+extern int iscsit_check_pre_dataout(struct iscsit_cmd *, unsigned char *);
+extern int iscsit_check_post_dataout(struct iscsit_cmd *, unsigned char *, u8);
 extern void iscsit_start_time2retain_handler(struct iscsi_session *);
 extern void iscsit_handle_time2retain_timeout(struct timer_list *t);
 extern int iscsit_stop_time2retain_timer(struct iscsi_session *);
diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index 0dd52f484fec..d348a9af7789 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -87,7 +87,7 @@ int iscsit_dump_data_payload(
  *	Used for retransmitting R2Ts from a R2T SNACK request.
  */
 static int iscsit_send_recovery_r2t_for_snack(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_r2t *r2t)
 {
 	/*
@@ -109,7 +109,7 @@ static int iscsit_send_recovery_r2t_for_snack(
 }
 
 static int iscsit_handle_r2t_snack(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u32 begrun,
 	u32 runlength)
@@ -167,7 +167,7 @@ static int iscsit_handle_r2t_snack(
  *	FIXME: How is this handled for a RData SNACK?
  */
 int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain_req *dr)
 {
 	u32 data_sn = 0, data_sn_count = 0;
@@ -213,7 +213,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
  *	FIXME: How is this handled for a RData SNACK?
  */
 int iscsit_create_recovery_datain_values_datasequenceinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain_req *dr)
 {
 	int found_seq = 0, i;
@@ -224,7 +224,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 	struct iscsi_seq *first_seq = NULL, *seq = NULL;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return -1;
 	}
 
@@ -371,7 +371,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 }
 
 static int iscsit_handle_recovery_datain(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u32 begrun,
 	u32 runlength)
@@ -439,7 +439,7 @@ int iscsit_handle_recovery_datain_or_r2t(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_find_cmd_from_itt(conn, init_task_tag);
 	if (!cmd)
@@ -471,7 +471,7 @@ int iscsit_handle_status_snack(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	u32 last_statsn;
 	int found_cmd;
 
@@ -534,7 +534,7 @@ int iscsit_handle_data_ack(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 
 	cmd = iscsit_find_cmd_from_ttt(conn, targ_xfer_tag);
 	if (!cmd) {
@@ -565,7 +565,7 @@ int iscsit_handle_data_ack(
 }
 
 static int iscsit_send_recovery_r2t(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 xfer_len)
 {
@@ -579,7 +579,7 @@ static int iscsit_send_recovery_r2t(
 }
 
 int iscsit_dataout_datapduinorder_no_fbit(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_pdu *pdu)
 {
 	int i, send_recovery_r2t = 0, recovery = 0;
@@ -655,7 +655,7 @@ int iscsit_dataout_datapduinorder_no_fbit(
 }
 
 static int iscsit_recalculate_dataout_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 pdu_offset,
 	u32 pdu_length,
 	u32 *r2t_offset,
@@ -732,7 +732,7 @@ static int iscsit_recalculate_dataout_values(
 }
 
 int iscsit_recover_dataout_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 pdu_offset,
 	u32 pdu_length)
 {
@@ -843,7 +843,7 @@ void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 int iscsit_execute_ooo_cmdsns(struct iscsi_session *sess)
 {
 	int ooo_count = 0;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_ooo_cmdsn *ooo_cmdsn, *ooo_cmdsn_tmp;
 
 	lockdep_assert_held(&sess->cmdsn_mutex);
@@ -884,7 +884,7 @@ int iscsit_execute_ooo_cmdsns(struct iscsi_session *sess)
  *	2. With no locks held directly from iscsi_handle_XXX_pdu() functions
  *	for immediate commands.
  */
-int iscsit_execute_cmd(struct iscsi_cmd *cmd, int ooo)
+int iscsit_execute_cmd(struct iscsit_cmd *cmd, int ooo)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct iscsi_conn *conn = cmd->conn;
@@ -1010,7 +1010,7 @@ void iscsit_free_all_ooo_cmdsns(struct iscsi_session *sess)
 
 int iscsit_handle_ooo_cmdsn(
 	struct iscsi_session *sess,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 cmdsn)
 {
 	int batch = 0;
@@ -1049,7 +1049,7 @@ int iscsit_handle_ooo_cmdsn(
 }
 
 static int iscsit_set_dataout_timeout_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 *offset,
 	u32 *length)
 {
@@ -1095,7 +1095,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 {
 	u32 pdu_length = 0, pdu_offset = 0;
 	u32 r2t_length = 0, r2t_offset = 0;
-	struct iscsi_cmd *cmd = from_timer(cmd, t, dataout_timer);
+	struct iscsit_cmd *cmd = from_timer(cmd, t, dataout_timer);
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_session *sess = NULL;
 	struct iscsi_node_attrib *na;
@@ -1179,7 +1179,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void iscsit_mod_dataout_timer(struct iscsi_cmd *cmd)
+void iscsit_mod_dataout_timer(struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_session *sess = conn->sess;
@@ -1199,7 +1199,7 @@ void iscsit_mod_dataout_timer(struct iscsi_cmd *cmd)
 }
 
 void iscsit_start_dataout_timer(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
@@ -1218,7 +1218,7 @@ void iscsit_start_dataout_timer(
 	mod_timer(&cmd->dataout_timer, jiffies + na->dataout_timeout * HZ);
 }
 
-void iscsit_stop_dataout_timer(struct iscsi_cmd *cmd)
+void iscsit_stop_dataout_timer(struct iscsit_cmd *cmd)
 {
 	spin_lock_bh(&cmd->dataout_timeout_lock);
 	if (!(cmd->dataout_timer_flags & ISCSI_TF_RUNNING)) {
diff --git a/drivers/target/iscsi/iscsi_target_erl1.h b/drivers/target/iscsi/iscsi_target_erl1.h
index 1f6973f87fea..48a13fc32e93 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.h
+++ b/drivers/target/iscsi/iscsi_target_erl1.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <scsi/iscsi_proto.h> /* itt_t */
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_datain_req;
 struct iscsi_ooo_cmdsn;
@@ -14,25 +14,25 @@ struct iscsi_session;
 
 extern int iscsit_dump_data_payload(struct iscsi_conn *, u32, int);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
-			struct iscsi_cmd *, struct iscsi_datain_req *);
+			struct iscsit_cmd *, struct iscsi_datain_req *);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_no(
-			struct iscsi_cmd *, struct iscsi_datain_req *);
+			struct iscsit_cmd *, struct iscsi_datain_req *);
 extern int iscsit_handle_recovery_datain_or_r2t(struct iscsi_conn *, unsigned char *,
 			itt_t, u32, u32, u32);
 extern int iscsit_handle_status_snack(struct iscsi_conn *, itt_t, u32,
 			u32, u32);
 extern int iscsit_handle_data_ack(struct iscsi_conn *, u32, u32, u32);
-extern int iscsit_dataout_datapduinorder_no_fbit(struct iscsi_cmd *, struct iscsi_pdu *);
-extern int iscsit_recover_dataout_sequence(struct iscsi_cmd *, u32, u32);
+extern int iscsit_dataout_datapduinorder_no_fbit(struct iscsit_cmd *, struct iscsi_pdu *);
+extern int iscsit_recover_dataout_sequence(struct iscsit_cmd *, u32, u32);
 extern void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *);
 extern void iscsit_free_all_ooo_cmdsns(struct iscsi_session *);
 extern int iscsit_execute_ooo_cmdsns(struct iscsi_session *);
-extern int iscsit_execute_cmd(struct iscsi_cmd *, int);
-extern int iscsit_handle_ooo_cmdsn(struct iscsi_session *, struct iscsi_cmd *, u32);
+extern int iscsit_execute_cmd(struct iscsit_cmd *, int);
+extern int iscsit_handle_ooo_cmdsn(struct iscsi_session *, struct iscsit_cmd *, u32);
 extern void iscsit_remove_ooo_cmdsn(struct iscsi_session *, struct iscsi_ooo_cmdsn *);
 extern void iscsit_handle_dataout_timeout(struct timer_list *t);
-extern void iscsit_mod_dataout_timer(struct iscsi_cmd *);
-extern void iscsit_start_dataout_timer(struct iscsi_cmd *, struct iscsi_conn *);
-extern void iscsit_stop_dataout_timer(struct iscsi_cmd *);
+extern void iscsit_mod_dataout_timer(struct iscsit_cmd *);
+extern void iscsit_start_dataout_timer(struct iscsit_cmd *, struct iscsi_conn *);
+extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 
 #endif /* ISCSI_TARGET_ERL1_H */
diff --git a/drivers/target/iscsi/iscsi_target_erl2.c b/drivers/target/iscsi/iscsi_target_erl2.c
index b1b7db9d1eda..f19ac2dbc062 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.c
+++ b/drivers/target/iscsi/iscsi_target_erl2.c
@@ -26,7 +26,7 @@
  *	FIXME: Does RData SNACK apply here as well?
  */
 void iscsit_create_conn_recovery_datain_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	__be32 exp_data_sn)
 {
 	u32 data_sn = 0;
@@ -54,7 +54,7 @@ void iscsit_create_conn_recovery_datain_values(
 }
 
 void iscsit_create_conn_recovery_dataout_values(
-	struct iscsi_cmd *cmd)
+	struct iscsit_cmd *cmd)
 {
 	u32 write_data_done = 0;
 	struct iscsi_conn *conn = cmd->conn;
@@ -119,7 +119,7 @@ struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 
 void iscsit_free_connection_recovery_entries(struct iscsi_session *sess)
 {
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_conn_recovery *cr, *cr_tmp;
 
 	spin_lock(&sess->cr_a_lock);
@@ -197,7 +197,7 @@ static void iscsit_remove_inactive_connection_recovery_entry(
  *	Called with cr->conn_recovery_cmd_lock help.
  */
 int iscsit_remove_cmd_from_connection_recovery(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_session *sess)
 {
 	struct iscsi_conn_recovery *cr;
@@ -218,7 +218,7 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 	u32 exp_statsn)
 {
 	u32 dropped_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_session *sess = cr->sess;
 
 	spin_lock(&cr->conn_recovery_cmd_lock);
@@ -266,7 +266,7 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 {
 	u32 dropped_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_ooo_cmdsn *ooo_cmdsn, *ooo_cmdsn_tmp;
 	struct iscsi_session *sess = conn->sess;
 
@@ -307,13 +307,13 @@ int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
 {
 	u32 cmd_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_conn_recovery *cr;
 
 	/*
 	 * Allocate an struct iscsi_conn_recovery for this connection.
-	 * Each struct iscsi_cmd contains an struct iscsi_conn_recovery pointer
-	 * (struct iscsi_cmd->cr) so we need to allocate this before preparing the
+	 * Each struct iscsit_cmd contains an struct iscsi_conn_recovery pointer
+	 * (struct iscsit_cmd->cr) so we need to allocate this before preparing the
 	 * connection's command list for connection recovery.
 	 */
 	cr = kzalloc(sizeof(struct iscsi_conn_recovery), GFP_KERNEL);
@@ -393,7 +393,7 @@ int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
 
 		transport_wait_for_tasks(&cmd->se_cmd);
 		/*
-		 * Add the struct iscsi_cmd to the connection recovery cmd list
+		 * Add the struct iscsit_cmd to the connection recovery cmd list
 		 */
 		spin_lock(&cr->conn_recovery_cmd_lock);
 		list_add_tail(&cmd->i_conn_node, &cr->conn_recovery_cmd_list);
diff --git a/drivers/target/iscsi/iscsi_target_erl2.h b/drivers/target/iscsi/iscsi_target_erl2.h
index a39b0caf2337..cf411375ad4c 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.h
+++ b/drivers/target/iscsi/iscsi_target_erl2.h
@@ -4,19 +4,19 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
-extern void iscsit_create_conn_recovery_datain_values(struct iscsi_cmd *, __be32);
-extern void iscsit_create_conn_recovery_dataout_values(struct iscsi_cmd *);
+extern void iscsit_create_conn_recovery_datain_values(struct iscsit_cmd *, __be32);
+extern void iscsit_create_conn_recovery_dataout_values(struct iscsit_cmd *);
 extern struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 			struct iscsi_session *, u16);
 extern void iscsit_free_connection_recovery_entries(struct iscsi_session *);
 extern int iscsit_remove_active_connection_recovery_entry(
 			struct iscsi_conn_recovery *, struct iscsi_session *);
-extern int iscsit_remove_cmd_from_connection_recovery(struct iscsi_cmd *,
+extern int iscsit_remove_cmd_from_connection_recovery(struct iscsit_cmd *,
 			struct iscsi_session *);
 extern void iscsit_discard_cr_cmds_by_expstatsn(struct iscsi_conn_recovery *, u32);
 extern int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *);
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index c0ed6f8e5c5b..b0cc8e0a10e8 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1272,7 +1272,7 @@ int iscsi_target_locate_portal(
 alloc_tags:
 	tag_num = max_t(u32, ISCSIT_MIN_TAGS, queue_depth);
 	tag_num = (tag_num * 2) + ISCSIT_EXTRA_TAGS;
-	tag_size = sizeof(struct iscsi_cmd) + conn->conn_transport->priv_size;
+	tag_size = sizeof(struct iscsit_cmd) + conn->conn_transport->priv_size;
 
 	ret = transport_alloc_session_tags(sess->se_sess, tag_num, tag_size);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
index ea2b02a93e45..98aee976d79c 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
@@ -18,7 +18,7 @@
 #include "iscsi_target_seq_pdu_list.h"
 
 #ifdef DEBUG
-static void iscsit_dump_seq_list(struct iscsi_cmd *cmd)
+static void iscsit_dump_seq_list(struct iscsit_cmd *cmd)
 {
 	int i;
 	struct iscsi_seq *seq;
@@ -36,7 +36,7 @@ static void iscsit_dump_seq_list(struct iscsi_cmd *cmd)
 	}
 }
 
-static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd)
+static void iscsit_dump_pdu_list(struct iscsit_cmd *cmd)
 {
 	int i;
 	struct iscsi_pdu *pdu;
@@ -52,12 +52,12 @@ static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd)
 	}
 }
 #else
-static void iscsit_dump_seq_list(struct iscsi_cmd *cmd) {}
-static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd) {}
+static void iscsit_dump_seq_list(struct iscsit_cmd *cmd) {}
+static void iscsit_dump_pdu_list(struct iscsit_cmd *cmd) {}
 #endif
 
 static void iscsit_ordered_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	u32 i, seq_count = 0;
@@ -70,7 +70,7 @@ static void iscsit_ordered_seq_lists(
 }
 
 static void iscsit_ordered_pdu_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	u32 i, pdu_send_order = 0, seq_no = 0;
@@ -117,7 +117,7 @@ static void iscsit_create_random_array(u32 *array, u32 count)
 }
 
 static int iscsit_randomize_pdu_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	int i = 0;
@@ -167,7 +167,7 @@ static int iscsit_randomize_pdu_lists(
 }
 
 static int iscsit_randomize_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	int i, j = 0;
@@ -199,7 +199,7 @@ static int iscsit_randomize_seq_lists(
 }
 
 static void iscsit_determine_counts_for_list(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_build_list *bl,
 	u32 *seq_count,
 	u32 *pdu_count)
@@ -283,7 +283,7 @@ static void iscsit_determine_counts_for_list(
  *	or DataPDUInOrder=No.
  */
 static int iscsit_do_build_pdu_and_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_build_list *bl)
 {
 	int check_immediate = 0, datapduinorder, datasequenceinorder;
@@ -484,7 +484,7 @@ static int iscsit_do_build_pdu_and_seq_lists(
 }
 
 int iscsit_build_pdu_and_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 immediate_data_length)
 {
 	struct iscsi_build_list bl;
@@ -559,7 +559,7 @@ int iscsit_build_pdu_and_seq_lists(
 }
 
 struct iscsi_pdu *iscsit_get_pdu_holder(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
@@ -567,7 +567,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder(
 	struct iscsi_pdu *pdu = NULL;
 
 	if (!cmd->pdu_list) {
-		pr_err("struct iscsi_cmd->pdu_list is NULL!\n");
+		pr_err("struct iscsit_cmd->pdu_list is NULL!\n");
 		return NULL;
 	}
 
@@ -583,7 +583,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder(
 }
 
 struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_seq *seq)
 {
 	u32 i;
@@ -591,7 +591,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
 	struct iscsi_pdu *pdu = NULL;
 
 	if (!cmd->pdu_list) {
-		pr_err("struct iscsi_cmd->pdu_list is NULL!\n");
+		pr_err("struct iscsit_cmd->pdu_list is NULL!\n");
 		return NULL;
 	}
 
@@ -660,14 +660,14 @@ struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
 }
 
 struct iscsi_seq *iscsit_get_seq_holder(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
 	u32 i;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return NULL;
 	}
 
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.h b/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
index 5a0907027973..288298f9f1b4 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
@@ -82,11 +82,11 @@ struct iscsi_seq {
 	u32		xfer_len;
 } ____cacheline_aligned;
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 
-extern int iscsit_build_pdu_and_seq_lists(struct iscsi_cmd *, u32);
-extern struct iscsi_pdu *iscsit_get_pdu_holder(struct iscsi_cmd *, u32, u32);
-extern struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(struct iscsi_cmd *, struct iscsi_seq *);
-extern struct iscsi_seq *iscsit_get_seq_holder(struct iscsi_cmd *, u32, u32);
+extern int iscsit_build_pdu_and_seq_lists(struct iscsit_cmd *, u32);
+extern struct iscsi_pdu *iscsit_get_pdu_holder(struct iscsit_cmd *, u32, u32);
+extern struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(struct iscsit_cmd *, struct iscsi_seq *);
+extern struct iscsi_seq *iscsit_get_seq_holder(struct iscsit_cmd *, u32, u32);
 
 #endif /* ISCSI_SEQ_AND_PDU_LIST_H */
diff --git a/drivers/target/iscsi/iscsi_target_tmr.c b/drivers/target/iscsi/iscsi_target_tmr.c
index 7d618db80c51..aa062c3166c2 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.c
+++ b/drivers/target/iscsi/iscsi_target_tmr.c
@@ -28,10 +28,10 @@
 #include "iscsi_target.h"
 
 u8 iscsit_tmr_abort_task(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *ref_cmd;
+	struct iscsit_cmd *ref_cmd;
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -103,10 +103,10 @@ int iscsit_tmr_task_cold_reset(
 }
 
 u8 iscsit_tmr_task_reassign(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *ref_cmd = NULL;
+	struct iscsit_cmd *ref_cmd = NULL;
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_conn_recovery *cr = NULL;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
@@ -175,7 +175,7 @@ u8 iscsit_tmr_task_reassign(
 }
 
 static void iscsit_task_reassign_remove_cmd(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn_recovery *cr,
 	struct iscsi_session *sess)
 {
@@ -195,7 +195,7 @@ static int iscsit_task_reassign_complete_nop_out(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
 
 	if (!cmd->cr) {
@@ -224,7 +224,7 @@ static int iscsit_task_reassign_complete_nop_out(
 }
 
 static int iscsit_task_reassign_complete_write(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	int no_build_r2ts = 0;
@@ -296,7 +296,7 @@ static int iscsit_task_reassign_complete_write(
 }
 
 static int iscsit_task_reassign_complete_read(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -349,7 +349,7 @@ static int iscsit_task_reassign_complete_read(
 }
 
 static int iscsit_task_reassign_complete_none(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -363,7 +363,7 @@ static int iscsit_task_reassign_complete_scsi_cmnd(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
 
 	if (!cmd->cr) {
@@ -412,11 +412,11 @@ static int iscsit_task_reassign_complete(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	int ret = 0;
 
 	if (!tmr_req->ref_cmd) {
-		pr_err("TMR Request is missing a RefCmd struct iscsi_cmd.\n");
+		pr_err("TMR Request is missing a RefCmd struct iscsit_cmd.\n");
 		return -1;
 	}
 	cmd = tmr_req->ref_cmd;
@@ -451,7 +451,7 @@ static int iscsit_task_reassign_complete(
  *	Right now the only one that its really needed for is
  *	connection recovery releated TASK_REASSIGN.
  */
-int iscsit_tmr_post_handler(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_tmr_post_handler(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -475,7 +475,7 @@ static int iscsit_task_reassign_prepare_read(
 }
 
 static void iscsit_task_reassign_prepare_unsolicited_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	int i, j;
@@ -546,7 +546,7 @@ static int iscsit_task_reassign_prepare_write(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_pdu *pdu = NULL;
 	struct iscsi_r2t *r2t = NULL, *r2t_tmp;
 	int first_incomplete_r2t = 1, i = 0;
@@ -575,7 +575,7 @@ static int iscsit_task_reassign_prepare_write(
 	 *
 	 * If we have not received all DataOUT in question,  we must
 	 * make sure to make the appropriate changes to values in
-	 * struct iscsi_cmd (and elsewhere depending on session parameters)
+	 * struct iscsit_cmd (and elsewhere depending on session parameters)
 	 * so iscsit_build_r2ts_for_cmd() in iscsit_task_reassign_complete_write()
 	 * will resend a new R2T for the DataOUT sequences in question.
 	 */
@@ -708,7 +708,7 @@ static int iscsit_task_reassign_prepare_write(
 	 * to check that the Initiator is not requesting R2Ts for DataOUT
 	 * sequences it has already completed.
 	 *
-	 * Free each R2T in question and adjust values in struct iscsi_cmd
+	 * Free each R2T in question and adjust values in struct iscsit_cmd
 	 * accordingly so iscsit_build_r2ts_for_cmd() do the rest of
 	 * the work after the TMR TASK_REASSIGN Response is sent.
 	 */
@@ -773,13 +773,13 @@ static int iscsit_task_reassign_prepare_write(
 
 /*
  *	Performs sanity checks TMR TASK_REASSIGN's ExpDataSN for
- *	a given struct iscsi_cmd.
+ *	a given struct iscsit_cmd.
  */
 int iscsit_check_task_reassign_expdatasn(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *ref_cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *ref_cmd = tmr_req->ref_cmd;
 
 	if (ref_cmd->iscsi_opcode != ISCSI_OP_SCSI_CMD)
 		return 0;
diff --git a/drivers/target/iscsi/iscsi_target_tmr.h b/drivers/target/iscsi/iscsi_target_tmr.h
index 301f0936bd8e..60aac3a8f3c0 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.h
+++ b/drivers/target/iscsi/iscsi_target_tmr.h
@@ -4,17 +4,17 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_tmr_req;
 
-extern u8 iscsit_tmr_abort_task(struct iscsi_cmd *, unsigned char *);
+extern u8 iscsit_tmr_abort_task(struct iscsit_cmd *, unsigned char *);
 extern int iscsit_tmr_task_warm_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
 extern int iscsit_tmr_task_cold_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
-extern u8 iscsit_tmr_task_reassign(struct iscsi_cmd *, unsigned char *);
-extern int iscsit_tmr_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
+extern u8 iscsit_tmr_task_reassign(struct iscsit_cmd *, unsigned char *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_check_task_reassign_expdatasn(struct iscsi_tmr_req *,
 			struct iscsi_conn *);
 
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 6dd5810e2af1..39b705c34f95 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -32,7 +32,7 @@ extern struct list_head g_tiqn_list;
 extern spinlock_t tiqn_lock;
 
 int iscsit_add_r2t_to_list(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 xfer_len,
 	int recovery,
@@ -65,7 +65,7 @@ int iscsit_add_r2t_to_list(
 }
 
 struct iscsi_r2t *iscsit_get_r2t_for_eos(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
@@ -86,7 +86,7 @@ struct iscsi_r2t *iscsit_get_r2t_for_eos(
 	return NULL;
 }
 
-struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *cmd)
+struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsit_cmd *cmd)
 {
 	struct iscsi_r2t *r2t;
 
@@ -104,7 +104,7 @@ struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *cmd)
 	return NULL;
 }
 
-void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsi_cmd *cmd)
+void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsit_cmd *cmd)
 {
 	lockdep_assert_held(&cmd->r2t_lock);
 
@@ -112,7 +112,7 @@ void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsi_cmd *cmd)
 	kmem_cache_free(lio_r2t_cache, r2t);
 }
 
-void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
+void iscsit_free_r2ts_from_list(struct iscsit_cmd *cmd)
 {
 	struct iscsi_r2t *r2t, *r2t_tmp;
 
@@ -152,9 +152,9 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
  * May be called from software interrupt (timer) context for allocating
  * iSCSI NopINs.
  */
-struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
+struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct se_session *se_sess = conn->sess->se_sess;
 	int size, tag, cpu;
 
@@ -164,8 +164,8 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 	if (tag < 0)
 		return NULL;
 
-	size = sizeof(struct iscsi_cmd) + conn->conn_transport->priv_size;
-	cmd = (struct iscsi_cmd *)(se_sess->sess_cmd_map + (tag * size));
+	size = sizeof(struct iscsit_cmd) + conn->conn_transport->priv_size;
+	cmd = (struct iscsit_cmd *)(se_sess->sess_cmd_map + (tag * size));
 	memset(cmd, 0, size);
 
 	cmd->se_cmd.map_tag = tag;
@@ -187,7 +187,7 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 EXPORT_SYMBOL(iscsit_allocate_cmd);
 
 struct iscsi_seq *iscsit_get_seq_holder_for_datain(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 seq_send_order)
 {
 	u32 i;
@@ -199,12 +199,12 @@ struct iscsi_seq *iscsit_get_seq_holder_for_datain(
 	return NULL;
 }
 
-struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *cmd)
+struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsit_cmd *cmd)
 {
 	u32 i;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return NULL;
 	}
 
@@ -221,7 +221,7 @@ struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *cmd)
 }
 
 struct iscsi_r2t *iscsit_get_holder_for_r2tsn(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 r2t_sn)
 {
 	struct iscsi_r2t *r2t;
@@ -282,7 +282,7 @@ static inline int iscsit_check_received_cmdsn(struct iscsi_session *sess, u32 cm
  * Commands may be received out of order if MC/S is in use.
  * Ensure they are executed in CmdSN order.
  */
-int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf, __be32 cmdsn)
 {
 	int ret, cmdsn_ret;
@@ -333,7 +333,7 @@ int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_sequence_cmd);
 
-int iscsit_check_unsolicited_dataout(struct iscsi_cmd *cmd, unsigned char *buf)
+int iscsit_check_unsolicited_dataout(struct iscsit_cmd *cmd, unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
@@ -377,11 +377,11 @@ int iscsit_check_unsolicited_dataout(struct iscsi_cmd *cmd, unsigned char *buf)
 	return 0;
 }
 
-struct iscsi_cmd *iscsit_find_cmd_from_itt(
+struct iscsit_cmd *iscsit_find_cmd_from_itt(
 	struct iscsi_conn *conn,
 	itt_t init_task_tag)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -398,12 +398,12 @@ struct iscsi_cmd *iscsit_find_cmd_from_itt(
 }
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt);
 
-struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(
+struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(
 	struct iscsi_conn *conn,
 	itt_t init_task_tag,
 	u32 length)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -425,11 +425,11 @@ struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(
 }
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt_or_dump);
 
-struct iscsi_cmd *iscsit_find_cmd_from_ttt(
+struct iscsit_cmd *iscsit_find_cmd_from_ttt(
 	struct iscsi_conn *conn,
 	u32 targ_xfer_tag)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -447,11 +447,11 @@ struct iscsi_cmd *iscsit_find_cmd_from_ttt(
 
 int iscsit_find_cmd_for_recovery(
 	struct iscsi_session *sess,
-	struct iscsi_cmd **cmd_ptr,
+	struct iscsit_cmd **cmd_ptr,
 	struct iscsi_conn_recovery **cr_ptr,
 	itt_t init_task_tag)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_conn_recovery *cr;
 	/*
 	 * Scan through the inactive connection recovery list's command list.
@@ -498,7 +498,7 @@ int iscsit_find_cmd_for_recovery(
 }
 
 void iscsit_add_cmd_to_immediate_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	u8 state)
 {
@@ -545,7 +545,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *c
 }
 
 static void iscsit_remove_cmd_from_immediate_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
@@ -574,7 +574,7 @@ static void iscsit_remove_cmd_from_immediate_queue(
 }
 
 int iscsit_add_cmd_to_response_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	u8 state)
 {
@@ -621,7 +621,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *co
 }
 
 static void iscsit_remove_cmd_from_response_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
@@ -694,7 +694,7 @@ void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->response_queue_lock);
 }
 
-void iscsit_release_cmd(struct iscsi_cmd *cmd)
+void iscsit_release_cmd(struct iscsit_cmd *cmd)
 {
 	struct iscsi_session *sess;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
@@ -720,7 +720,7 @@ void iscsit_release_cmd(struct iscsi_cmd *cmd)
 }
 EXPORT_SYMBOL(iscsit_release_cmd);
 
-void __iscsit_free_cmd(struct iscsi_cmd *cmd, bool check_queues)
+void __iscsit_free_cmd(struct iscsit_cmd *cmd, bool check_queues)
 {
 	struct iscsi_conn *conn = cmd->conn;
 
@@ -742,7 +742,7 @@ void __iscsit_free_cmd(struct iscsi_cmd *cmd, bool check_queues)
 		conn->conn_transport->iscsit_unmap_cmd(conn, cmd);
 }
 
-void iscsit_free_cmd(struct iscsi_cmd *cmd, bool shutdown)
+void iscsit_free_cmd(struct iscsit_cmd *cmd, bool shutdown)
 {
 	struct se_cmd *se_cmd = cmd->se_cmd.se_tfo ? &cmd->se_cmd : NULL;
 	int rc;
@@ -870,7 +870,7 @@ void iscsit_inc_conn_usage_count(struct iscsi_conn *conn)
 static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
 {
 	u8 state;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_RUNNING);
 	if (!cmd)
@@ -1041,7 +1041,7 @@ void iscsit_stop_nopin_timer(struct iscsi_conn *conn)
 }
 
 int iscsit_send_tx_data(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	int use_misc)
 {
@@ -1074,7 +1074,7 @@ int iscsit_send_tx_data(
 }
 
 int iscsit_fe_sendpage_sg(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct scatterlist *sg = cmd->first_data_sg;
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index 8ee1c133a9b7..dec142ed4704 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -7,39 +7,39 @@
 
 #define MARKER_SIZE	8
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
-extern int iscsit_add_r2t_to_list(struct iscsi_cmd *, u32, u32, int, u32);
-extern struct iscsi_r2t *iscsit_get_r2t_for_eos(struct iscsi_cmd *, u32, u32);
-extern struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *);
-extern void iscsit_free_r2t(struct iscsi_r2t *, struct iscsi_cmd *);
-extern void iscsit_free_r2ts_from_list(struct iscsi_cmd *);
-extern struct iscsi_cmd *iscsit_alloc_cmd(struct iscsi_conn *, gfp_t);
-extern struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
-extern struct iscsi_seq *iscsit_get_seq_holder_for_datain(struct iscsi_cmd *, u32);
-extern struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *);
-extern struct iscsi_r2t *iscsit_get_holder_for_r2tsn(struct iscsi_cmd *, u32);
-extern int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+extern int iscsit_add_r2t_to_list(struct iscsit_cmd *, u32, u32, int, u32);
+extern struct iscsi_r2t *iscsit_get_r2t_for_eos(struct iscsit_cmd *, u32, u32);
+extern struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsit_cmd *);
+extern void iscsit_free_r2t(struct iscsi_r2t *, struct iscsit_cmd *);
+extern void iscsit_free_r2ts_from_list(struct iscsit_cmd *);
+extern struct iscsit_cmd *iscsit_alloc_cmd(struct iscsi_conn *, gfp_t);
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
+extern struct iscsi_seq *iscsit_get_seq_holder_for_datain(struct iscsit_cmd *, u32);
+extern struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsit_cmd *);
+extern struct iscsi_r2t *iscsit_get_holder_for_r2tsn(struct iscsit_cmd *, u32);
+extern int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			       unsigned char * ,__be32 cmdsn);
-extern int iscsit_check_unsolicited_dataout(struct iscsi_cmd *, unsigned char *);
-extern struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *,
+extern int iscsit_check_unsolicited_dataout(struct iscsit_cmd *, unsigned char *);
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *,
 			itt_t, u32);
-extern struct iscsi_cmd *iscsit_find_cmd_from_ttt(struct iscsi_conn *, u32);
-extern int iscsit_find_cmd_for_recovery(struct iscsi_session *, struct iscsi_cmd **,
+extern struct iscsit_cmd *iscsit_find_cmd_from_ttt(struct iscsi_conn *, u32);
+extern int iscsit_find_cmd_for_recovery(struct iscsi_session *, struct iscsit_cmd **,
 			struct iscsi_conn_recovery **, itt_t);
-extern void iscsit_add_cmd_to_immediate_queue(struct iscsi_cmd *, struct iscsi_conn *, u8);
+extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
 extern struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *);
-extern int iscsit_add_cmd_to_response_queue(struct iscsi_cmd *, struct iscsi_conn *, u8);
+extern int iscsit_add_cmd_to_response_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
 extern struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *);
-extern void iscsit_remove_cmd_from_tx_queues(struct iscsi_cmd *, struct iscsi_conn *);
+extern void iscsit_remove_cmd_from_tx_queues(struct iscsit_cmd *, struct iscsi_conn *);
 extern bool iscsit_conn_all_queues_empty(struct iscsi_conn *);
 extern void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *);
-extern void iscsit_release_cmd(struct iscsi_cmd *);
-extern void __iscsit_free_cmd(struct iscsi_cmd *, bool);
-extern void iscsit_free_cmd(struct iscsi_cmd *, bool);
+extern void iscsit_release_cmd(struct iscsit_cmd *);
+extern void __iscsit_free_cmd(struct iscsit_cmd *, bool);
+extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
 extern bool iscsit_check_session_usage_count(struct iscsi_session *sess, bool can_sleep);
 extern void iscsit_dec_session_usage_count(struct iscsi_session *);
 extern void iscsit_inc_session_usage_count(struct iscsi_session *);
@@ -56,8 +56,8 @@ extern void iscsit_handle_nopin_timeout(struct timer_list *t);
 extern void __iscsit_start_nopin_timer(struct iscsi_conn *);
 extern void iscsit_start_nopin_timer(struct iscsi_conn *);
 extern void iscsit_stop_nopin_timer(struct iscsi_conn *);
-extern int iscsit_send_tx_data(struct iscsi_cmd *, struct iscsi_conn *, int);
-extern int iscsit_fe_sendpage_sg(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsi_conn *, int);
+extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_tx_login_rsp(struct iscsi_conn *, u8, u8);
 extern void iscsit_print_session_params(struct iscsi_session *);
 extern int iscsit_print_dev_to_proc(char *, char **, off_t, int);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index adc87de0362b..4f9ef2899488 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -143,7 +143,7 @@ enum tiqn_state_table {
 	TIQN_STATE_SHUTDOWN			= 2,
 };
 
-/* struct iscsi_cmd->cmd_flags */
+/* struct iscsit_cmd->cmd_flags */
 enum cmd_flags_table {
 	ICF_GOT_LAST_DATAOUT			= 0x00000001,
 	ICF_GOT_DATACK_SNACK			= 0x00000002,
@@ -157,7 +157,7 @@ enum cmd_flags_table {
 	ICF_SENDTARGETS_SINGLE			= 0x00000200,
 };
 
-/* struct iscsi_cmd->i_state */
+/* struct iscsit_cmd->i_state */
 enum cmd_i_state_table {
 	ISTATE_NO_STATE			= 0,
 	ISTATE_NEW_CMD			= 1,
@@ -297,7 +297,7 @@ struct iscsi_sess_ops {
 
 struct iscsi_queue_req {
 	int			state;
-	struct iscsi_cmd	*cmd;
+	struct iscsit_cmd	*cmd;
 	struct list_head	qr_list;
 };
 
@@ -327,7 +327,7 @@ struct iscsi_ooo_cmdsn {
 	u32			batch_count;
 	u32			cmdsn;
 	u32			exp_cmdsn;
-	struct iscsi_cmd	*cmd;
+	struct iscsit_cmd	*cmd;
 	struct list_head	ooo_list;
 } ____cacheline_aligned;
 
@@ -349,7 +349,7 @@ struct iscsi_r2t {
 	struct list_head	r2t_list;
 } ____cacheline_aligned;
 
-struct iscsi_cmd {
+struct iscsit_cmd {
 	enum iscsi_timer_flags_table dataout_timer_flags;
 	/* DataOUT timeout retries */
 	u8			dataout_timeout_retries;
@@ -405,22 +405,22 @@ struct iscsi_cmd {
 	u32			outstanding_r2ts;
 	/* Next R2T Offset when DataSequenceInOrder=Yes */
 	u32			r2t_offset;
-	/* Iovec current and orig count for iscsi_cmd->iov_data */
+	/* Iovec current and orig count for iscsit_cmd->iov_data */
 	u32			iov_data_count;
 	u32			orig_iov_data_count;
 	/* Number of miscellaneous iovecs used for IP stack calls */
 	u32			iov_misc_count;
-	/* Number of struct iscsi_pdu in struct iscsi_cmd->pdu_list */
+	/* Number of struct iscsi_pdu in struct iscsit_cmd->pdu_list */
 	u32			pdu_count;
-	/* Next struct iscsi_pdu to send in struct iscsi_cmd->pdu_list */
+	/* Next struct iscsi_pdu to send in struct iscsit_cmd->pdu_list */
 	u32			pdu_send_order;
-	/* Current struct iscsi_pdu in struct iscsi_cmd->pdu_list */
+	/* Current struct iscsi_pdu in struct iscsit_cmd->pdu_list */
 	u32			pdu_start;
-	/* Next struct iscsi_seq to send in struct iscsi_cmd->seq_list */
+	/* Next struct iscsi_seq to send in struct iscsit_cmd->seq_list */
 	u32			seq_send_order;
-	/* Number of struct iscsi_seq in struct iscsi_cmd->seq_list */
+	/* Number of struct iscsi_seq in struct iscsit_cmd->seq_list */
 	u32			seq_count;
-	/* Current struct iscsi_seq in struct iscsi_cmd->seq_list */
+	/* Current struct iscsi_seq in struct iscsit_cmd->seq_list */
 	u32			seq_no;
 	/* Lowest offset in current DataOUT sequence */
 	u32			seq_start_offset;
@@ -444,12 +444,12 @@ struct iscsi_cmd {
 	enum dma_data_direction	data_direction;
 	/* iSCSI PDU Header + CRC */
 	unsigned char		pdu[ISCSI_HDR_LEN + ISCSI_CRC_LEN];
-	/* Number of times struct iscsi_cmd is present in immediate queue */
+	/* Number of times struct iscsit_cmd is present in immediate queue */
 	atomic_t		immed_queue_count;
 	atomic_t		response_queue_count;
 	spinlock_t		datain_lock;
 	spinlock_t		dataout_timeout_lock;
-	/* spinlock for protecting struct iscsi_cmd->i_state */
+	/* spinlock for protecting struct iscsit_cmd->i_state */
 	spinlock_t		istate_lock;
 	/* spinlock for adding within command recovery entries */
 	spinlock_t		error_lock;
@@ -503,7 +503,7 @@ struct iscsi_cmd {
 struct iscsi_tmr_req {
 	bool			task_reassign:1;
 	u32			exp_data_sn;
-	struct iscsi_cmd	*ref_cmd;
+	struct iscsit_cmd	*ref_cmd;
 	struct iscsi_conn_recovery *conn_recovery;
 	struct se_tmr_req	*se_tmr_req;
 };
@@ -583,7 +583,7 @@ struct iscsi_conn {
 	cpumask_var_t		allowed_cpumask;
 	unsigned int		conn_rx_reset_cpumask:1;
 	unsigned int		conn_tx_reset_cpumask:1;
-	/* list_head of struct iscsi_cmd for this connection */
+	/* list_head of struct iscsit_cmd for this connection */
 	struct list_head	conn_cmd_list;
 	struct list_head	immed_queue_list;
 	struct list_head	response_queue_list;
@@ -898,7 +898,7 @@ static inline u32 session_get_next_ttt(struct iscsi_session *session)
 	return ttt;
 }
 
-extern struct iscsi_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
 
 extern void iscsit_thread_check_cpumask(struct iscsi_conn *conn,
 					struct task_struct *p,
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index b8feba7ffebc..645de3542022 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include "iscsi_target_core.h" /* struct iscsi_cmd */
+#include "iscsi_target_core.h" /* struct iscsit_cmd */
 
 struct sockaddr_storage;
 
@@ -18,23 +18,23 @@ struct iscsit_transport {
 	void (*iscsit_free_conn)(struct iscsi_conn *);
 	int (*iscsit_get_login_rx)(struct iscsi_conn *, struct iscsi_login *);
 	int (*iscsit_put_login_tx)(struct iscsi_conn *, struct iscsi_login *, u32);
-	int (*iscsit_immediate_queue)(struct iscsi_conn *, struct iscsi_cmd *, int);
-	int (*iscsit_response_queue)(struct iscsi_conn *, struct iscsi_cmd *, int);
-	int (*iscsit_get_dataout)(struct iscsi_conn *, struct iscsi_cmd *, bool);
-	int (*iscsit_queue_data_in)(struct iscsi_conn *, struct iscsi_cmd *);
-	int (*iscsit_queue_status)(struct iscsi_conn *, struct iscsi_cmd *);
-	void (*iscsit_aborted_task)(struct iscsi_conn *, struct iscsi_cmd *);
-	int (*iscsit_xmit_pdu)(struct iscsi_conn *, struct iscsi_cmd *,
+	int (*iscsit_immediate_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_response_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_get_dataout)(struct iscsi_conn *, struct iscsit_cmd *, bool);
+	int (*iscsit_queue_data_in)(struct iscsi_conn *, struct iscsit_cmd *);
+	int (*iscsit_queue_status)(struct iscsi_conn *, struct iscsit_cmd *);
+	void (*iscsit_aborted_task)(struct iscsi_conn *, struct iscsit_cmd *);
+	int (*iscsit_xmit_pdu)(struct iscsi_conn *, struct iscsit_cmd *,
 			       struct iscsi_datain_req *, const void *, u32);
-	void (*iscsit_unmap_cmd)(struct iscsi_conn *, struct iscsi_cmd *);
+	void (*iscsit_unmap_cmd)(struct iscsi_conn *, struct iscsit_cmd *);
 	void (*iscsit_get_rx_pdu)(struct iscsi_conn *);
 	int (*iscsit_validate_params)(struct iscsi_conn *);
-	void (*iscsit_get_r2t_ttt)(struct iscsi_conn *, struct iscsi_cmd *,
+	void (*iscsit_get_r2t_ttt)(struct iscsi_conn *, struct iscsit_cmd *,
 				   struct iscsi_r2t *);
 	enum target_prot_op (*iscsit_get_sup_prot_ops)(struct iscsi_conn *);
 };
 
-static inline void *iscsit_priv_cmd(struct iscsi_cmd *cmd)
+static inline void *iscsit_priv_cmd(struct iscsit_cmd *cmd)
 {
 	return (void *)(cmd + 1);
 }
@@ -51,61 +51,61 @@ extern void iscsit_put_transport(struct iscsit_transport *);
 /*
  * From iscsi_target.c
  */
-extern int iscsit_setup_scsi_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern void iscsit_set_unsolicited_dataout(struct iscsi_cmd *);
-extern int iscsit_process_scsi_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
+extern int iscsit_process_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_scsi_req *);
 extern int
 __iscsit_check_dataout_hdr(struct iscsi_conn *, void *,
-			   struct iscsi_cmd *, u32, bool *);
+			   struct iscsit_cmd *, u32, bool *);
 extern int
 iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			 struct iscsi_cmd **out_cmd);
-extern int iscsit_check_dataout_payload(struct iscsi_cmd *, struct iscsi_data *,
+			 struct iscsit_cmd **out_cmd);
+extern int iscsit_check_dataout_payload(struct iscsit_cmd *, struct iscsi_data *,
 				bool);
-extern int iscsit_setup_nop_out(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_process_nop_out(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_process_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_handle_logout_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_handle_logout_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_handle_task_mgt_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_handle_task_mgt_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_setup_text_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				 struct iscsi_text *);
-extern int iscsit_process_text_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_process_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				   struct iscsi_text *);
-extern void iscsit_build_rsp_pdu(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_rsp_pdu(struct iscsit_cmd *, struct iscsi_conn *,
 				bool, struct iscsi_scsi_rsp *);
-extern void iscsit_build_nopin_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_nopin_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_nopin *, bool);
-extern void iscsit_build_task_mgt_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_task_mgt_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_tm_rsp *);
-extern int iscsit_build_text_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern int iscsit_build_text_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_text_rsp *,
 				enum iscsit_transport_type);
-extern void iscsit_build_reject(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_reject(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_reject *);
-extern int iscsit_build_logout_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern int iscsit_build_logout_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_logout_rsp *);
-extern int iscsit_logout_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_queue_rsp(struct iscsi_conn *, struct iscsi_cmd *);
-extern void iscsit_aborted_task(struct iscsi_conn *, struct iscsi_cmd *);
+extern int iscsit_logout_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_queue_rsp(struct iscsi_conn *, struct iscsit_cmd *);
+extern void iscsit_aborted_task(struct iscsi_conn *, struct iscsit_cmd *);
 extern int iscsit_add_reject(struct iscsi_conn *, u8, unsigned char *);
-extern int iscsit_reject_cmd(struct iscsi_cmd *, u8, unsigned char *);
+extern int iscsit_reject_cmd(struct iscsit_cmd *, u8, unsigned char *);
 extern int iscsit_handle_snack(struct iscsi_conn *, unsigned char *);
-extern void iscsit_build_datain_pdu(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_datain_pdu(struct iscsit_cmd *, struct iscsi_conn *,
 				    struct iscsi_datain *,
 				    struct iscsi_data_rsp *, bool);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				     bool);
-extern int iscsit_immediate_queue(struct iscsi_conn *, struct iscsi_cmd *, int);
-extern int iscsit_response_queue(struct iscsi_conn *, struct iscsi_cmd *, int);
+extern int iscsit_immediate_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
+extern int iscsit_response_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
 /*
  * From iscsi_target_device.c
  */
-extern void iscsit_increment_maxcmdsn(struct iscsi_cmd *, struct iscsi_session *);
+extern void iscsit_increment_maxcmdsn(struct iscsit_cmd *, struct iscsi_session *);
 /*
  * From iscsi_target_erl0.c
  */
@@ -113,24 +113,24 @@ extern void iscsit_cause_connection_reinstatement(struct iscsi_conn *, int);
 /*
  * From iscsi_target_erl1.c
  */
-extern void iscsit_stop_dataout_timer(struct iscsi_cmd *);
+extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 
 /*
  * From iscsi_target_tmr.c
  */
-extern int iscsit_tmr_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
 
 /*
  * From iscsi_target_util.c
  */
-extern struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
-extern int iscsit_sequence_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
+extern int iscsit_sequence_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 			       unsigned char *, __be32);
-extern void iscsit_release_cmd(struct iscsi_cmd *);
-extern void iscsit_free_cmd(struct iscsi_cmd *, bool);
-extern void iscsit_add_cmd_to_immediate_queue(struct iscsi_cmd *,
+extern void iscsit_release_cmd(struct iscsit_cmd *);
+extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
+extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *,
 					      struct iscsi_conn *, u8);
-extern struct iscsi_cmd *
+extern struct iscsit_cmd *
 iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *conn,
 				 itt_t init_task_tag, u32 length);
 
-- 
2.18.2

