Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7E513011
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Apr 2022 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiD1JuM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Apr 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347564AbiD1JdG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 Apr 2022 05:33:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264E7CDEE;
        Thu, 28 Apr 2022 02:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XapYWeP1FdDPjERlXEgiK9pwzYkVpWQFlQQ3JO93emiqqO6HlkJocyMWuPaHFsIicBRXDKTHO6a+7TWfBIUpXVmEy4cgfRvA7hbKMtYrMxPtROpG67rk88awpfrNgV+qaZfrFeRzu0sBA8fpJfj8UFtH14PVvUVY2YxSP7FedjladOOBb2UVQrTwr4TPNQpPIQToqFJjy88Eol8w+Koi+IJqLTtpG5rheoDFxxexPLbG++5f9A3o2c+PC7MqRG4KcqdcblS1Dp/hFQNMwVqMIzaC3ScEfqekgpzKhRADjL68pUMGUb77aKYsEmxnuhweAkdoYbLkp/RG877aXSVpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egtvk7IhSe34tocVLqpEmXf7tRjuZYA3sRTWzilQLig=;
 b=DnxLF/SQVEaxsRgOzPRTqiLp0TEZuw6X1cWjTXDg1XvijdrRR/SF0bNlk8MdrA1X4CMwcLCJghT/aTy7OshHSraT6PW8YuUrG05dl9nW3daC3rkhNHmF4LaryNhmb/6asL6EhMFGK3fPE3L43Owzq6CgTewG+xijPlm0kQXgaLX4UrLpHgWauM8AlQLh1BngkOs4P5jceY2onExZT6YmPer153nnTz07re8YTRkvTwwg1g+pADJpHC6Pla2WhRDJspgMepl1XtN3F4AxCoyeFmuqs/dVGTLl9bSGCQbF8lN4qaHc/hP4/qmJD0E6d97xRRN807eZakOt6t4MYCT13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egtvk7IhSe34tocVLqpEmXf7tRjuZYA3sRTWzilQLig=;
 b=py0jXjjDX65BNIuW18LZxWQXp/M6pZSXksbOjGIZUt3WsBoouSByMNQt0Xw3B4mjbTearQwV1HKM6g8sMKLMq6E1ylyepb+wPyJ/rh43vPySePY5JxCqzI8qNm0VeyUwtfx9KkrXBwVPEdmPUohOh2odl1zsQEN7oNe2o3PdYQm/+IeZskonn/HUHIb4DVL37eRl5TXfcT2eZQiwDzLp9TEmwLwU9QqlZIHVELO5YQ3o4+xE7HutIxRrRl1muI+fViFy5IGae4fhvIgbAGI8qoOi2Q+ignJoW//aB1C+pt3uddIvp60HQOwgxNA45rcJDza3ZkWsgyQbauFid0dc0Q==
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Thu, 28 Apr
 2022 09:29:46 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::56) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 28 Apr 2022 09:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 09:29:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 28 Apr 2022 09:29:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:29:44 -0700
Received: from r-arch-stor04.mtr.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 28 Apr 2022 02:29:42 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <michael.christie@oracle.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] target/iscsi: rename iscsi_conn to iscsit_conn
Date:   Thu, 28 Apr 2022 12:29:38 +0300
Message-ID: <20220428092939.36768-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220428092939.36768-1-mgurtovoy@nvidia.com>
References: <20220428092939.36768-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97172ca-93d4-4462-a157-08da28f9a263
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB442941FB1D5BAEDDAE60AE65DEFD9@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgAKS3ugAtTEwR3qPJthSYLMzUQJvFdLMHGTed0mCPeAgGAxA9qPmIpOobVHszGAryj5FgqQM3x42cpwsMRTSLZ3NWSM2xMmyKUsyENnOt1ry8TIDPNbJ2m8W4CarF8GEE4FO59wgp3mCd32qaXG09bnBxFKqm+WlFI+JwQw+oVhjf+SlH8LgQFxzkLoHDRZj08/ytrTXROmyrXg4V/GMkwBnGhnCouc8UhTDg6H33k7FiF677jpYp9PVOthXJlcyofNIhOKYlY99zi1ppAiQ1Q7I4uD7oYJ/hcEkC9ufPwq756U+ufBCGyFeiAOygje8o/3pPktWjOhUUW4L8CN+7T7ywghKIY+b6p5T8dKafmfY8PQcy6KD9WunH9Ux+amb6/37IczPxEeo3i1hZc8K3k7jOMQHvk4eLM8qWDu5cWw0Awoo8m8zurpSWcZ9kqa2Jtfv1ZX3EqIX0FByzqOYpUnJp/+REbsRhmRB0FNruZ5+Z80wrsWp5cRvjxKEEPGelOt3NdcccapPBKVpKl7d8PflHaKxEFtNjXnKZXRGYnETTsj1veoesISxLu92WMwG7CWJeCDAL0J4G/or+8WDAKm7h/uLx+/rYDfNuJb/bbbmak6X6y8GllJYTgXVR45Cq7bhWQg/ku8OjSN1AT5YrEOco0W/mvuFJbWf6d67wVuALMIk8cecr1wXz6RumeCya65ZKQ5BLgY/z27Axm/ew==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(83380400001)(82310400005)(186003)(36756003)(2616005)(107886003)(1076003)(26005)(508600001)(54906003)(110136005)(2906002)(70586007)(81166007)(6666004)(30864003)(36860700001)(40460700003)(336012)(47076005)(426003)(8676002)(86362001)(356005)(5660300002)(8936002)(316002)(4326008)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:29:45.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97172ca-93d4-4462-a157-08da28f9a263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The structure iscsi_conn naming is used by the iscsi initiator
driver. Rename the target conn to iscsit_conn to have more readable
code.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c       |  64 +++----
 drivers/infiniband/ulp/isert/ib_isert.h       |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit.h          |  20 +--
 drivers/target/iscsi/cxgbit/cxgbit_cm.c       |   8 +-
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c      |   4 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c     |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit_target.c   |  44 ++---
 drivers/target/iscsi/iscsi_target.c           | 162 +++++++++---------
 drivers/target/iscsi/iscsi_target.h           |  16 +-
 drivers/target/iscsi/iscsi_target_auth.c      |  10 +-
 drivers/target/iscsi/iscsi_target_auth.h      |   4 +-
 drivers/target/iscsi/iscsi_target_configfs.c  |   8 +-
 .../target/iscsi/iscsi_target_datain_values.c |  10 +-
 drivers/target/iscsi/iscsi_target_erl0.c      |  28 +--
 drivers/target/iscsi/iscsi_target_erl0.h      |   8 +-
 drivers/target/iscsi/iscsi_target_erl1.c      |  30 ++--
 drivers/target/iscsi/iscsi_target_erl1.h      |  14 +-
 drivers/target/iscsi/iscsi_target_erl2.c      |  10 +-
 drivers/target/iscsi/iscsi_target_erl2.h      |   8 +-
 drivers/target/iscsi/iscsi_target_login.c     |  58 +++----
 drivers/target/iscsi/iscsi_target_login.h     |  22 +--
 drivers/target/iscsi/iscsi_target_nego.c      |  52 +++---
 drivers/target/iscsi/iscsi_target_nego.h      |  12 +-
 .../target/iscsi/iscsi_target_nodeattrib.c    |   2 +-
 .../target/iscsi/iscsi_target_parameters.c    |   8 +-
 .../target/iscsi/iscsi_target_parameters.h    |   8 +-
 .../target/iscsi/iscsi_target_seq_pdu_list.c  |   8 +-
 drivers/target/iscsi/iscsi_target_tmr.c       |  30 ++--
 drivers/target/iscsi/iscsi_target_tmr.h       |  10 +-
 drivers/target/iscsi/iscsi_target_util.c      |  78 ++++-----
 drivers/target/iscsi/iscsi_target_util.h      |  62 +++----
 include/target/iscsi/iscsi_target_core.h      |  10 +-
 include/target/iscsi/iscsi_transport.h        | 100 +++++------
 33 files changed, 456 insertions(+), 456 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 4cb746ab53be..48064bd8aa2c 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -46,7 +46,7 @@ static struct workqueue_struct *isert_comp_wq;
 static struct workqueue_struct *isert_release_wq;
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd);
+isert_put_response(struct iscsit_conn *conn, struct iscsit_cmd *cmd);
 static int
 isert_login_post_recv(struct isert_conn *isert_conn);
 static int
@@ -909,7 +909,7 @@ isert_login_post_recv(struct isert_conn *isert_conn)
 }
 
 static int
-isert_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
+isert_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 		   u32 length)
 {
 	struct isert_conn *isert_conn = conn->context;
@@ -976,7 +976,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 {
 	struct iser_rx_desc *rx_desc = isert_conn->login_desc;
 	int rx_buflen = isert_conn->login_req_len;
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsi_login *login = conn->conn_login;
 	int size;
 
@@ -1021,7 +1021,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 }
 
 static struct iscsit_cmd
-*isert_allocate_cmd(struct iscsi_conn *conn, struct iser_rx_desc *rx_desc)
+*isert_allocate_cmd(struct iscsit_conn *conn, struct iser_rx_desc *rx_desc)
 {
 	struct isert_conn *isert_conn = conn->context;
 	struct isert_cmd *isert_cmd;
@@ -1045,7 +1045,7 @@ isert_handle_scsi_cmd(struct isert_conn *isert_conn,
 		      struct isert_cmd *isert_cmd, struct iscsit_cmd *cmd,
 		      struct iser_rx_desc *rx_desc, unsigned char *buf)
 {
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)buf;
 	int imm_data, imm_data_len, unsol_data, sg_nents, rc;
 	bool dump_payload = false;
@@ -1114,7 +1114,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 			   struct iser_rx_desc *rx_desc, unsigned char *buf)
 {
 	struct scatterlist *sg_start;
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
 	u32 unsol_data_len = ntoh24(hdr->dlength);
@@ -1174,7 +1174,7 @@ isert_handle_nop_out(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
 		     struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		     unsigned char *buf)
 {
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsi_nopout *hdr = (struct iscsi_nopout *)buf;
 	int rc;
 
@@ -1193,7 +1193,7 @@ isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd
 		      struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		      struct iscsi_text *hdr)
 {
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	u32 payload_length = ntoh24(hdr->dlength);
 	int rc;
 	unsigned char *text_in = NULL;
@@ -1220,7 +1220,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 		uint32_t write_stag, uint64_t write_va)
 {
 	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsit_cmd *cmd;
 	struct isert_cmd *isert_cmd;
 	int ret = -EINVAL;
@@ -1428,7 +1428,7 @@ isert_put_cmd(struct isert_cmd *isert_cmd, bool comp_err)
 {
 	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 	struct isert_conn *isert_conn = isert_cmd->conn;
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 	struct iscsi_text_rsp *hdr;
 
 	isert_dbg("Cmd %p\n", isert_cmd);
@@ -1755,7 +1755,7 @@ isert_post_response(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd)
 }
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+isert_put_response(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1806,7 +1806,7 @@ isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 }
 
 static void
-isert_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+isert_aborted_task(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1822,7 +1822,7 @@ isert_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 }
 
 static enum target_prot_op
-isert_get_sup_prot_ops(struct iscsi_conn *conn)
+isert_get_sup_prot_ops(struct iscsit_conn *conn)
 {
 	struct isert_conn *isert_conn = conn->context;
 	struct isert_device *device = isert_conn->device;
@@ -1842,7 +1842,7 @@ isert_get_sup_prot_ops(struct iscsi_conn *conn)
 }
 
 static int
-isert_put_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+isert_put_nopin(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 		bool nopout_response)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -1862,7 +1862,7 @@ isert_put_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 }
 
 static int
-isert_put_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+isert_put_logout_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1880,7 +1880,7 @@ isert_put_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_tm_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+isert_put_tm_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1898,7 +1898,7 @@ isert_put_tm_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+isert_put_reject(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1933,7 +1933,7 @@ isert_put_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+isert_put_text_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -2088,7 +2088,7 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 }
 
 static int
-isert_put_datain(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+isert_put_datain(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -2129,7 +2129,7 @@ isert_put_datain(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 }
 
 static int
-isert_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd, bool recovery)
+isert_get_dataout(struct iscsit_conn *conn, struct iscsit_cmd *cmd, bool recovery)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret;
@@ -2147,7 +2147,7 @@ isert_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd, bool recovery
 }
 
 static int
-isert_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
+isert_immediate_queue(struct iscsit_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret = 0;
@@ -2172,7 +2172,7 @@ isert_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state
 }
 
 static int
-isert_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
+isert_response_queue(struct iscsit_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_conn *isert_conn = conn->context;
 	int ret;
@@ -2332,7 +2332,7 @@ isert_rdma_accept(struct isert_conn *isert_conn)
 }
 
 static int
-isert_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
+isert_get_login_rx(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	struct isert_conn *isert_conn = conn->context;
 	int ret;
@@ -2368,7 +2368,7 @@ isert_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
 }
 
 static void
-isert_set_conn_info(struct iscsi_np *np, struct iscsi_conn *conn,
+isert_set_conn_info(struct iscsi_np *np, struct iscsit_conn *conn,
 		    struct isert_conn *isert_conn)
 {
 	struct rdma_cm_id *cm_id = isert_conn->cm_id;
@@ -2381,7 +2381,7 @@ isert_set_conn_info(struct iscsi_np *np, struct iscsi_conn *conn,
 }
 
 static int
-isert_accept_np(struct iscsi_np *np, struct iscsi_conn *conn)
+isert_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 {
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn;
@@ -2489,7 +2489,7 @@ static void isert_release_work(struct work_struct *work)
 static void
 isert_wait4logout(struct isert_conn *isert_conn)
 {
-	struct iscsi_conn *conn = isert_conn->conn;
+	struct iscsit_conn *conn = isert_conn->conn;
 
 	isert_info("conn %p\n", isert_conn);
 
@@ -2501,9 +2501,9 @@ isert_wait4logout(struct isert_conn *isert_conn)
 }
 
 static void
-isert_wait4cmds(struct iscsi_conn *conn)
+isert_wait4cmds(struct iscsit_conn *conn)
 {
-	isert_info("iscsi_conn %p\n", conn);
+	isert_info("iscsit_conn %p\n", conn);
 
 	if (conn->sess) {
 		target_stop_session(conn->sess->se_sess);
@@ -2521,7 +2521,7 @@ isert_wait4cmds(struct iscsi_conn *conn)
  * before blocking on the target_wait_for_session_cmds
  */
 static void
-isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
+isert_put_unsol_pending_cmds(struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd, *tmp;
 	static LIST_HEAD(drop_cmd_list);
@@ -2546,7 +2546,7 @@ isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
 	}
 }
 
-static void isert_wait_conn(struct iscsi_conn *conn)
+static void isert_wait_conn(struct iscsit_conn *conn)
 {
 	struct isert_conn *isert_conn = conn->context;
 
@@ -2564,7 +2564,7 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
-static void isert_free_conn(struct iscsi_conn *conn)
+static void isert_free_conn(struct iscsit_conn *conn)
 {
 	struct isert_conn *isert_conn = conn->context;
 
@@ -2572,7 +2572,7 @@ static void isert_free_conn(struct iscsi_conn *conn)
 	isert_put_conn(isert_conn);
 }
 
-static void isert_get_rx_pdu(struct iscsi_conn *conn)
+static void isert_get_rx_pdu(struct iscsit_conn *conn)
 {
 	struct completion comp;
 
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index a462834cb332..0b2dfd6e7e27 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -173,7 +173,7 @@ struct isert_conn {
 	u64			login_rsp_dma;
 	struct iser_rx_desc	*rx_descs;
 	struct ib_recv_wr	rx_wr[ISERT_QP_MAX_RECV_DTOS];
-	struct iscsi_conn	*conn;
+	struct iscsit_conn	*conn;
 	struct list_head	node;
 	struct completion	login_comp;
 	struct completion	login_req_comp;
diff --git a/drivers/target/iscsi/cxgbit/cxgbit.h b/drivers/target/iscsi/cxgbit/cxgbit.h
index b23edcb41489..aff727629663 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit.h
+++ b/drivers/target/iscsi/cxgbit/cxgbit.h
@@ -189,7 +189,7 @@ struct cxgbit_np {
 struct cxgbit_sock {
 	struct cxgbit_sock_common com;
 	struct cxgbit_np *cnp;
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	struct l2t_entry *l2t;
 	struct dst_entry *dst;
 	struct list_head list;
@@ -316,32 +316,32 @@ typedef void (*cxgbit_cplhandler_func)(struct cxgbit_device *,
 
 int cxgbit_setup_np(struct iscsi_np *, struct sockaddr_storage *);
 int cxgbit_setup_conn_digest(struct cxgbit_sock *);
-int cxgbit_accept_np(struct iscsi_np *, struct iscsi_conn *);
+int cxgbit_accept_np(struct iscsi_np *, struct iscsit_conn *);
 void cxgbit_free_np(struct iscsi_np *);
 void cxgbit_abort_conn(struct cxgbit_sock *csk);
-void cxgbit_free_conn(struct iscsi_conn *);
+void cxgbit_free_conn(struct iscsit_conn *);
 extern cxgbit_cplhandler_func cxgbit_cplhandlers[NUM_CPL_CMDS];
-int cxgbit_get_login_rx(struct iscsi_conn *, struct iscsi_login *);
+int cxgbit_get_login_rx(struct iscsit_conn *, struct iscsi_login *);
 int cxgbit_rx_data_ack(struct cxgbit_sock *);
 int cxgbit_l2t_send(struct cxgbit_device *, struct sk_buff *,
 		    struct l2t_entry *);
 void cxgbit_push_tx_frames(struct cxgbit_sock *);
-int cxgbit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-int cxgbit_xmit_pdu(struct iscsi_conn *, struct iscsit_cmd *,
+int cxgbit_put_login_tx(struct iscsit_conn *, struct iscsi_login *, u32);
+int cxgbit_xmit_pdu(struct iscsit_conn *, struct iscsit_cmd *,
 		    struct iscsi_datain_req *, const void *, u32);
-void cxgbit_get_r2t_ttt(struct iscsi_conn *, struct iscsit_cmd *,
+void cxgbit_get_r2t_ttt(struct iscsit_conn *, struct iscsit_cmd *,
 			struct iscsi_r2t *);
 u32 cxgbit_send_tx_flowc_wr(struct cxgbit_sock *);
 int cxgbit_ofld_send(struct cxgbit_device *, struct sk_buff *);
-void cxgbit_get_rx_pdu(struct iscsi_conn *);
-int cxgbit_validate_params(struct iscsi_conn *);
+void cxgbit_get_rx_pdu(struct iscsit_conn *);
+int cxgbit_validate_params(struct iscsit_conn *);
 struct cxgbit_device *cxgbit_find_device(struct net_device *, u8 *);
 
 /* DDP */
 int cxgbit_ddp_init(struct cxgbit_device *);
 int cxgbit_setup_conn_pgidx(struct cxgbit_sock *, u32);
 int cxgbit_reserve_ttt(struct cxgbit_sock *, struct iscsit_cmd *);
-void cxgbit_unmap_cmd(struct iscsi_conn *, struct iscsit_cmd *);
+void cxgbit_unmap_cmd(struct iscsit_conn *, struct iscsit_cmd *);
 
 static inline
 struct cxgbi_ppm *cdev2ppm(struct cxgbit_device *cdev)
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index da31a308a064..3336d2b78bf7 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -465,7 +465,7 @@ int cxgbit_setup_np(struct iscsi_np *np, struct sockaddr_storage *ksockaddr)
 }
 
 static void
-cxgbit_set_conn_info(struct iscsi_np *np, struct iscsi_conn *conn,
+cxgbit_set_conn_info(struct iscsi_np *np, struct iscsit_conn *conn,
 		     struct cxgbit_sock *csk)
 {
 	conn->login_family = np->np_sockaddr.ss_family;
@@ -473,7 +473,7 @@ cxgbit_set_conn_info(struct iscsi_np *np, struct iscsi_conn *conn,
 	conn->local_sockaddr = csk->com.local_addr;
 }
 
-int cxgbit_accept_np(struct iscsi_np *np, struct iscsi_conn *conn)
+int cxgbit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 {
 	struct cxgbit_np *cnp = np->np_context;
 	struct cxgbit_sock *csk;
@@ -717,7 +717,7 @@ void cxgbit_abort_conn(struct cxgbit_sock *csk)
 
 static void __cxgbit_free_conn(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	bool release = false;
 
 	pr_debug("%s: state %d\n",
@@ -751,7 +751,7 @@ static void __cxgbit_free_conn(struct cxgbit_sock *csk)
 		cxgbit_put_csk(csk);
 }
 
-void cxgbit_free_conn(struct iscsi_conn *conn)
+void cxgbit_free_conn(struct iscsit_conn *conn)
 {
 	__cxgbit_free_conn(conn->context);
 }
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
index 5feebb6c6de4..17fd0d8cc490 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
@@ -227,7 +227,7 @@ cxgbit_ddp_reserve(struct cxgbit_sock *csk, struct cxgbi_task_tag_info *ttinfo,
 }
 
 void
-cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+cxgbit_get_r2t_ttt(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_r2t *r2t)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -260,7 +260,7 @@ cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 	r2t->targ_xfer_tag = ttinfo->tag;
 }
 
-void cxgbit_unmap_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+void cxgbit_unmap_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct cxgbit_cmd *ccmd = iscsit_priv_cmd(cmd);
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_main.c b/drivers/target/iscsi/cxgbit/cxgbit_main.c
index c6678dc8dd41..2c1950df3b3e 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -657,7 +657,7 @@ cxgbit_dcbevent_notify(struct notifier_block *nb, unsigned long action,
 }
 #endif
 
-static enum target_prot_op cxgbit_get_sup_prot_ops(struct iscsi_conn *conn)
+static enum target_prot_op cxgbit_get_sup_prot_ops(struct iscsit_conn *conn)
 {
 	return TARGET_PROT_NORMAL;
 }
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
index 99901a8a3f64..acfc39683c87 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -393,7 +393,7 @@ static int
 cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 		     struct iscsi_datain_req *dr)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct sk_buff *skb;
 	struct iscsi_datain datain;
 	struct cxgbit_iso_info iso_info;
@@ -510,7 +510,7 @@ cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+cxgbit_xmit_datain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		       struct iscsi_datain_req *dr,
 		       const struct iscsi_datain *datain)
 {
@@ -530,7 +530,7 @@ cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+cxgbit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -560,7 +560,7 @@ cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 }
 
 int
-cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+cxgbit_xmit_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		struct iscsi_datain_req *dr, const void *buf, u32 buf_len)
 {
 	if (dr)
@@ -569,7 +569,7 @@ cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		return cxgbit_xmit_nondatain_pdu(conn, cmd, buf, buf_len);
 }
 
-int cxgbit_validate_params(struct iscsi_conn *conn)
+int cxgbit_validate_params(struct iscsit_conn *conn)
 {
 	struct cxgbit_sock *csk = conn->context;
 	struct cxgbit_device *cdev = csk->com.cdev;
@@ -595,7 +595,7 @@ int cxgbit_validate_params(struct iscsi_conn *conn)
 
 static int cxgbit_set_digest(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsi_param *param;
 
 	param = iscsi_find_param_from_key(HEADERDIGEST, conn->param_list);
@@ -627,7 +627,7 @@ static int cxgbit_set_digest(struct cxgbit_sock *csk)
 
 static int cxgbit_set_iso_npdu(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsi_conn_ops *conn_ops = conn->conn_ops;
 	struct iscsi_param *param;
 	u32 mrdsl, mbl;
@@ -678,7 +678,7 @@ static int cxgbit_set_iso_npdu(struct cxgbit_sock *csk)
  */
 static int cxgbit_seq_pdu_inorder(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsi_param *param;
 
 	if (conn->login->leading_connection) {
@@ -712,7 +712,7 @@ static int cxgbit_seq_pdu_inorder(struct cxgbit_sock *csk)
 	return 0;
 }
 
-static int cxgbit_set_params(struct iscsi_conn *conn)
+static int cxgbit_set_params(struct iscsit_conn *conn)
 {
 	struct cxgbit_sock *csk = conn->context;
 	struct cxgbit_device *cdev = csk->com.cdev;
@@ -771,7 +771,7 @@ static int cxgbit_set_params(struct iscsi_conn *conn)
 }
 
 int
-cxgbit_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
+cxgbit_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 		    u32 length)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -834,7 +834,7 @@ cxgbit_skb_copy_to_sg(struct sk_buff *skb, struct scatterlist *sg,
 
 static struct iscsit_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct cxgbi_ppm *ppm = cdev2ppm(csk->com.cdev);
 	struct cxgbit_cmd *ccmd;
 	struct iscsit_cmd *cmd;
@@ -856,7 +856,7 @@ static int
 cxgbit_handle_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			     u32 length)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct cxgbit_sock *csk = conn->context;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 
@@ -913,7 +913,7 @@ static int
 cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			  bool dump_payload)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	int cmdsn_ret = 0, immed_ret = IMMEDIATE_DATA_NORMAL_OPERATION;
 	/*
 	 * Special case for Unsupported SAM WRITE Opcodes and ImmediateData=Yes.
@@ -966,7 +966,7 @@ cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 static int
 cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)pdu_cb->hdr;
 	int rc;
@@ -995,7 +995,7 @@ cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 {
 	struct scatterlist *sg_start;
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsit_cmd *cmd = NULL;
 	struct cxgbit_cmd *ccmd;
 	struct cxgbi_task_tag_info *ttinfo;
@@ -1086,7 +1086,7 @@ static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 
 static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_nopout *hdr = (struct iscsi_nopout *)pdu_cb->hdr;
 	unsigned char *ping_data = NULL;
@@ -1154,7 +1154,7 @@ static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsit_cmd *cmd
 static int
 cxgbit_handle_text_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_text *hdr = (struct iscsi_text *)pdu_cb->hdr;
 	u32 payload_length = pdu_cb->dlen;
@@ -1209,7 +1209,7 @@ static int cxgbit_target_rx_opcode(struct cxgbit_sock *csk)
 {
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)pdu_cb->hdr;
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsit_cmd *cmd = NULL;
 	u8 opcode = (hdr->opcode & ISCSI_OPCODE_MASK);
 	int ret = -EINVAL;
@@ -1286,7 +1286,7 @@ static int cxgbit_target_rx_opcode(struct cxgbit_sock *csk)
 static int cxgbit_rx_opcode(struct cxgbit_sock *csk)
 {
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsi_hdr *hdr = pdu_cb->hdr;
 	u8 opcode;
 
@@ -1321,7 +1321,7 @@ static int cxgbit_rx_opcode(struct cxgbit_sock *csk)
 
 static int cxgbit_rx_login_pdu(struct cxgbit_sock *csk)
 {
-	struct iscsi_conn *conn = csk->conn;
+	struct iscsit_conn *conn = csk->conn;
 	struct iscsi_login *login = conn->login;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_login_req *login_req;
@@ -1626,7 +1626,7 @@ static int cxgbit_wait_rxq(struct cxgbit_sock *csk)
 	return -1;
 }
 
-int cxgbit_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
+int cxgbit_get_login_rx(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	struct cxgbit_sock *csk = conn->context;
 	int ret = -1;
@@ -1642,7 +1642,7 @@ int cxgbit_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
 	return ret;
 }
 
-void cxgbit_get_rx_pdu(struct iscsi_conn *conn)
+void cxgbit_get_rx_pdu(struct iscsit_conn *conn)
 {
 	struct cxgbit_sock *csk = conn->context;
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 4d71eb8fa6ab..2c4f94b76061 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -472,15 +472,15 @@ int iscsit_del_np(struct iscsi_np *np)
 	return 0;
 }
 
-static void iscsit_get_rx_pdu(struct iscsi_conn *);
+static void iscsit_get_rx_pdu(struct iscsit_conn *);
 
-int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+int iscsit_queue_rsp(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	return iscsit_add_cmd_to_response_queue(cmd, cmd->conn, cmd->i_state);
 }
 EXPORT_SYMBOL(iscsit_queue_rsp);
 
-void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
+void iscsit_aborted_task(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
 {
 	spin_lock_bh(&conn->cmd_lock);
 	if (!list_empty(&cmd->i_conn_node))
@@ -493,10 +493,10 @@ EXPORT_SYMBOL(iscsit_aborted_task);
 
 static void iscsit_do_crypto_hash_buf(struct ahash_request *, const void *,
 				      u32, u32, const void *, void *);
-static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *);
+static void iscsit_tx_thread_wait_for_tcp(struct iscsit_conn *);
 
 static int
-iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)cmd->pdu;
@@ -570,7 +570,7 @@ static void iscsit_unmap_iovec(struct iscsit_cmd *);
 static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsit_cmd *,
 				    u32, u32, u32, u8 *);
 static int
-iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_xmit_datain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		       const struct iscsi_datain *datain)
 {
 	struct kvec *iov;
@@ -644,7 +644,7 @@ iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 	return 0;
 }
 
-static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+static int iscsit_xmit_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_datain_req *dr, const void *buf,
 			   u32 buf_len)
 {
@@ -654,7 +654,7 @@ static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		return iscsit_xmit_nondatain_pdu(conn, cmd, buf, buf_len);
 }
 
-static enum target_prot_op iscsit_get_sup_prot_ops(struct iscsi_conn *conn)
+static enum target_prot_op iscsit_get_sup_prot_ops(struct iscsit_conn *conn)
 {
 	return TARGET_PROT_NORMAL;
 }
@@ -796,7 +796,7 @@ static void __exit iscsi_target_cleanup_module(void)
 }
 
 int iscsit_add_reject(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 reason,
 	unsigned char *buf)
 {
@@ -833,7 +833,7 @@ static int iscsit_add_reject_from_cmd(
 	bool add_to_conn,
 	unsigned char *buf)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	const bool do_put = cmd->se_cmd.se_tfo != NULL;
 
 	if (!cmd->conn) {
@@ -957,7 +957,7 @@ static void iscsit_unmap_iovec(struct iscsit_cmd *cmd)
 		kunmap(sg_page(&sg[i]));
 }
 
-static void iscsit_ack_from_expstatsn(struct iscsi_conn *conn, u32 exp_statsn)
+static void iscsit_ack_from_expstatsn(struct iscsit_conn *conn, u32 exp_statsn)
 {
 	LIST_HEAD(ack_list);
 	struct iscsit_cmd *cmd, *cmd_p;
@@ -1000,7 +1000,7 @@ static int iscsit_allocate_iovecs(struct iscsit_cmd *cmd)
 	return 0;
 }
 
-int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			  unsigned char *buf)
 {
 	int data_direction, payload_length;
@@ -1225,7 +1225,7 @@ void iscsit_set_unsolicited_dataout(struct iscsit_cmd *cmd)
 }
 EXPORT_SYMBOL(iscsit_set_unsolicited_dataout);
 
-int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+int iscsit_process_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			    struct iscsi_scsi_req *hdr)
 {
 	int cmdsn_ret = 0;
@@ -1349,7 +1349,7 @@ iscsit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_handle_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)buf;
@@ -1455,7 +1455,7 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
 }
 
 int
-__iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
+__iscsit_check_dataout_hdr(struct iscsit_conn *conn, void *buf,
 			   struct iscsit_cmd *cmd, u32 payload_length,
 			   bool *success)
 {
@@ -1559,7 +1559,7 @@ __iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
 EXPORT_SYMBOL(__iscsit_check_dataout_hdr);
 
 int
-iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
+iscsit_check_dataout_hdr(struct iscsit_conn *conn, void *buf,
 			 struct iscsit_cmd **out_cmd)
 {
 	struct iscsi_data *hdr = buf;
@@ -1594,7 +1594,7 @@ iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
 EXPORT_SYMBOL(iscsit_check_dataout_hdr);
 
 static int
-iscsit_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_get_dataout(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_data *hdr)
 {
 	struct kvec *iov;
@@ -1665,7 +1665,7 @@ int
 iscsit_check_dataout_payload(struct iscsit_cmd *cmd, struct iscsi_data *hdr,
 			     bool data_crc_failed)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	int rc, ooo_cmdsn;
 	/*
 	 * Increment post receive data and CRC values or perform
@@ -1700,7 +1700,7 @@ iscsit_check_dataout_payload(struct iscsit_cmd *cmd, struct iscsi_data *hdr,
 }
 EXPORT_SYMBOL(iscsit_check_dataout_payload);
 
-static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
+static int iscsit_handle_data_out(struct iscsit_conn *conn, unsigned char *buf)
 {
 	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
@@ -1722,7 +1722,7 @@ static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
 	return iscsit_check_dataout_payload(cmd, hdr, data_crc_failed);
 }
 
-int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+int iscsit_setup_nop_out(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			 struct iscsi_nopout *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -1789,7 +1789,7 @@ int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_setup_nop_out);
 
-int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+int iscsit_process_nop_out(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_nopout *hdr)
 {
 	struct iscsit_cmd *cmd_p = NULL;
@@ -1851,7 +1851,7 @@ int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_process_nop_out);
 
-static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+static int iscsit_handle_nop_out(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 				 unsigned char *buf)
 {
 	unsigned char *ping_data = NULL;
@@ -1978,7 +1978,7 @@ static enum tcm_tmreq_table iscsit_convert_tmf(u8 iscsi_tmf)
 }
 
 int
-iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_handle_task_mgt_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct se_tmr_req *se_tmr;
@@ -2159,7 +2159,7 @@ EXPORT_SYMBOL(iscsit_handle_task_mgt_cmd);
 
 /* #warning FIXME: Support Text Command parameters besides SendTargets */
 int
-iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_setup_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		      struct iscsi_text *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -2199,7 +2199,7 @@ iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 EXPORT_SYMBOL(iscsit_setup_text_cmd);
 
 int
-iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_process_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			struct iscsi_text *hdr)
 {
 	unsigned char *text_in = cmd->text_in_ptr, *text_ptr;
@@ -2258,7 +2258,7 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 EXPORT_SYMBOL(iscsit_process_text_cmd);
 
 static int
-iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		       unsigned char *buf)
 {
 	struct iscsi_text *hdr = (struct iscsi_text *)buf;
@@ -2347,9 +2347,9 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 	return iscsit_reject_cmd(cmd, ISCSI_REASON_PROTOCOL_ERROR, buf);
 }
 
-int iscsit_logout_closesession(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closesession(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
-	struct iscsi_conn *conn_p;
+	struct iscsit_conn *conn_p;
 	struct iscsi_session *sess = conn->sess;
 
 	pr_debug("Received logout request CLOSESESSION on CID: %hu"
@@ -2377,9 +2377,9 @@ int iscsit_logout_closesession(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_logout_closeconnection(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closeconnection(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
-	struct iscsi_conn *l_conn;
+	struct iscsit_conn *l_conn;
 	struct iscsi_session *sess = conn->sess;
 
 	pr_debug("Received logout request CLOSECONNECTION for CID:"
@@ -2425,7 +2425,7 @@ int iscsit_logout_closeconnection(struct iscsit_cmd *cmd, struct iscsi_conn *con
 	return 0;
 }
 
-int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 
@@ -2455,7 +2455,7 @@ int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *cmd, struct iscsi_con
 }
 
 int
-iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+iscsit_handle_logout_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf)
 {
 	int cmdsn_ret, logout_remove = 0;
@@ -2536,7 +2536,7 @@ iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 EXPORT_SYMBOL(iscsit_handle_logout_cmd);
 
 int iscsit_handle_snack(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	unsigned char *buf)
 {
 	struct iscsi_snack *hdr;
@@ -2590,7 +2590,7 @@ int iscsit_handle_snack(
 }
 EXPORT_SYMBOL(iscsit_handle_snack);
 
-static void iscsit_rx_thread_wait_for_tcp(struct iscsi_conn *conn)
+static void iscsit_rx_thread_wait_for_tcp(struct iscsit_conn *conn)
 {
 	if ((conn->sock->sk->sk_shutdown & SEND_SHUTDOWN) ||
 	    (conn->sock->sk->sk_shutdown & RCV_SHUTDOWN)) {
@@ -2607,7 +2607,7 @@ static int iscsit_handle_immediate_data(
 {
 	int iov_ret, rx_got = 0, rx_size = 0;
 	u32 checksum, iov_count = 0, padding = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct kvec *iov;
 	void *overflow_buf = NULL;
 
@@ -2708,10 +2708,10 @@ static int iscsit_handle_immediate_data(
 
 /* #warning iscsi_build_conn_drop_async_message() only sends out on connections
 	with active network interface */
-static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
+static void iscsit_build_conn_drop_async_message(struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd;
-	struct iscsi_conn *conn_p;
+	struct iscsit_conn *conn_p;
 	bool found = false;
 
 	lockdep_assert_held(&conn->sess->conn_lock);
@@ -2751,7 +2751,7 @@ static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
 
 static int iscsit_send_conn_drop_async_message(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_async *hdr;
 
@@ -2779,7 +2779,7 @@ static int iscsit_send_conn_drop_async_message(
 	return conn->conn_transport->iscsit_xmit_pdu(conn, cmd, NULL, NULL, 0);
 }
 
-static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *conn)
+static void iscsit_tx_thread_wait_for_tcp(struct iscsit_conn *conn)
 {
 	if ((conn->sock->sk->sk_shutdown & SEND_SHUTDOWN) ||
 	    (conn->sock->sk->sk_shutdown & RCV_SHUTDOWN)) {
@@ -2790,7 +2790,7 @@ static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_datain_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_datain_pdu(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 			struct iscsi_datain *datain, struct iscsi_data_rsp *hdr,
 			bool set_statsn)
 {
@@ -2835,7 +2835,7 @@ iscsit_build_datain_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_datain_pdu);
 
-static int iscsit_send_datain(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_datain(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_data_rsp *hdr = (struct iscsi_data_rsp *)&cmd->pdu[0];
 	struct iscsi_datain datain;
@@ -2896,10 +2896,10 @@ static int iscsit_send_datain(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 }
 
 int
-iscsit_build_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_logout_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 			struct iscsi_logout_rsp *hdr)
 {
-	struct iscsi_conn *logout_conn = NULL;
+	struct iscsit_conn *logout_conn = NULL;
 	struct iscsi_conn_recovery *cr = NULL;
 	struct iscsi_session *sess = conn->sess;
 	/*
@@ -2991,7 +2991,7 @@ iscsit_build_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_logout_rsp);
 
 static int
-iscsit_send_logout(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_logout(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	int rc;
 
@@ -3004,7 +3004,7 @@ iscsit_send_logout(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_nopin_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_nopin_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 		       struct iscsi_nopin *hdr, bool nopout_response)
 {
 	hdr->opcode		= ISCSI_OP_NOOP_IN;
@@ -3036,7 +3036,7 @@ EXPORT_SYMBOL(iscsit_build_nopin_rsp);
  */
 static int iscsit_send_unsolicited_nopin(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	int want_response)
 {
 	struct iscsi_nopin *hdr = (struct iscsi_nopin *)&cmd->pdu[0];
@@ -3060,7 +3060,7 @@ static int iscsit_send_unsolicited_nopin(
 }
 
 static int
-iscsit_send_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_nopin(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_nopin *hdr = (struct iscsi_nopin *)&cmd->pdu[0];
 
@@ -3079,7 +3079,7 @@ iscsit_send_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 
 static int iscsit_send_r2t(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_r2t *r2t;
 	struct iscsi_r2t_rsp *hdr;
@@ -3135,7 +3135,7 @@ static int iscsit_send_r2t(
  *		connection recovery.
  */
 int iscsit_build_r2ts_for_cmd(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsit_cmd *cmd,
 	bool recovery)
 {
@@ -3218,7 +3218,7 @@ int iscsit_build_r2ts_for_cmd(
 }
 EXPORT_SYMBOL(iscsit_build_r2ts_for_cmd);
 
-void iscsit_build_rsp_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+void iscsit_build_rsp_pdu(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 			bool inc_stat_sn, struct iscsi_scsi_rsp *hdr)
 {
 	if (inc_stat_sn)
@@ -3252,7 +3252,7 @@ void iscsit_build_rsp_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_rsp_pdu);
 
-static int iscsit_send_response(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_response(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_scsi_rsp *hdr = (struct iscsi_scsi_rsp *)&cmd->pdu[0];
 	bool inc_stat_sn = (cmd->i_state == ISTATE_SEND_STATUS);
@@ -3309,7 +3309,7 @@ static u8 iscsit_convert_tcm_tmr_rsp(struct se_tmr_req *se_tmr)
 }
 
 void
-iscsit_build_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 			  struct iscsi_tm_rsp *hdr)
 {
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -3332,7 +3332,7 @@ iscsit_build_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_task_mgt_rsp);
 
 static int
-iscsit_send_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_tm_rsp *hdr = (struct iscsi_tm_rsp *)&cmd->pdu[0];
 
@@ -3349,7 +3349,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 				  int skip_bytes, bool *completed)
 {
 	char *payload = NULL;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_portal_group *tpg;
 	struct iscsi_tiqn *tiqn;
 	struct iscsi_tpg_np *tpg_np;
@@ -3494,7 +3494,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 }
 
 int
-iscsit_build_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_text_rsp(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 		      struct iscsi_text_rsp *hdr,
 		      enum iscsit_transport_type network_transport)
 {
@@ -3545,7 +3545,7 @@ EXPORT_SYMBOL(iscsit_build_text_rsp);
 
 static int iscsit_send_text_rsp(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_text_rsp *hdr = (struct iscsi_text_rsp *)cmd->pdu;
 	int text_length;
@@ -3561,7 +3561,7 @@ static int iscsit_send_text_rsp(
 }
 
 void
-iscsit_build_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_reject(struct iscsit_cmd *cmd, struct iscsit_conn *conn,
 		    struct iscsi_reject *hdr)
 {
 	hdr->opcode		= ISCSI_OP_REJECT;
@@ -3579,7 +3579,7 @@ EXPORT_SYMBOL(iscsit_build_reject);
 
 static int iscsit_send_reject(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_reject *hdr = (struct iscsi_reject *)&cmd->pdu[0];
 
@@ -3593,7 +3593,7 @@ static int iscsit_send_reject(
 						     ISCSI_HDR_LEN);
 }
 
-void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
+void iscsit_thread_get_cpumask(struct iscsit_conn *conn)
 {
 	int ord, cpu;
 	cpumask_t conn_allowed_cpumask;
@@ -3624,7 +3624,7 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 	cpumask_setall(conn->conn_cpumask);
 }
 
-static void iscsit_thread_reschedule(struct iscsi_conn *conn)
+static void iscsit_thread_reschedule(struct iscsit_conn *conn)
 {
 	/*
 	 * If iscsit_global->allowed_cpumask modified, reschedule iSCSI
@@ -3641,7 +3641,7 @@ static void iscsit_thread_reschedule(struct iscsi_conn *conn)
 }
 
 void iscsit_thread_check_cpumask(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct task_struct *p,
 	int mode)
 {
@@ -3681,7 +3681,7 @@ void iscsit_thread_check_cpumask(
 EXPORT_SYMBOL(iscsit_thread_check_cpumask);
 
 int
-iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
+iscsit_immediate_queue(struct iscsit_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3725,7 +3725,7 @@ iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int stat
 EXPORT_SYMBOL(iscsit_immediate_queue);
 
 static int
-iscsit_handle_immediate_queue(struct iscsi_conn *conn)
+iscsit_handle_immediate_queue(struct iscsit_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
@@ -3748,7 +3748,7 @@ iscsit_handle_immediate_queue(struct iscsi_conn *conn)
 }
 
 int
-iscsit_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
+iscsit_response_queue(struct iscsit_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3854,7 +3854,7 @@ iscsit_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state
 }
 EXPORT_SYMBOL(iscsit_response_queue);
 
-static int iscsit_handle_response_queue(struct iscsi_conn *conn)
+static int iscsit_handle_response_queue(struct iscsit_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
@@ -3878,7 +3878,7 @@ static int iscsit_handle_response_queue(struct iscsi_conn *conn)
 int iscsi_target_tx_thread(void *arg)
 {
 	int ret = 0;
-	struct iscsi_conn *conn = arg;
+	struct iscsit_conn *conn = arg;
 	bool conn_freed = false;
 
 	/*
@@ -3933,7 +3933,7 @@ int iscsi_target_tx_thread(void *arg)
 	return 0;
 }
 
-static int iscsi_target_rx_opcode(struct iscsi_conn *conn, unsigned char *buf)
+static int iscsi_target_rx_opcode(struct iscsit_conn *conn, unsigned char *buf)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)buf;
 	struct iscsit_cmd *cmd;
@@ -4010,7 +4010,7 @@ static int iscsi_target_rx_opcode(struct iscsi_conn *conn, unsigned char *buf)
 	return iscsit_add_reject(conn, ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 }
 
-static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
+static bool iscsi_target_check_conn_state(struct iscsit_conn *conn)
 {
 	bool ret;
 
@@ -4021,7 +4021,7 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
 	return ret;
 }
 
-static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
+static void iscsit_get_rx_pdu(struct iscsit_conn *conn)
 {
 	int ret;
 	u8 *buffer, opcode;
@@ -4106,7 +4106,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 int iscsi_target_rx_thread(void *arg)
 {
 	int rc;
-	struct iscsi_conn *conn = arg;
+	struct iscsit_conn *conn = arg;
 	bool conn_freed = false;
 
 	/*
@@ -4141,7 +4141,7 @@ int iscsi_target_rx_thread(void *arg)
 	return 0;
 }
 
-static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
+static void iscsit_release_commands_from_conn(struct iscsit_conn *conn)
 {
 	LIST_HEAD(tmp_list);
 	struct iscsit_cmd *cmd = NULL, *cmd_tmp = NULL;
@@ -4185,7 +4185,7 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 }
 
 static void iscsit_stop_timers_for_cmds(
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd;
 
@@ -4198,7 +4198,7 @@ static void iscsit_stop_timers_for_cmds(
 }
 
 int iscsit_close_connection(
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	int conn_logout = (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT);
 	struct iscsi_session	*sess = conn->sess;
@@ -4214,7 +4214,7 @@ int iscsit_close_connection(
 	 * However for iser-target, isert_wait4logout() is using conn_logout_comp
 	 * to signal logout response TX interrupt completion.  Go ahead and skip
 	 * this for iser since isert_rx_opcode() does not wait on logout failure,
-	 * and to avoid iscsi_conn pointer dereference in iser-target code.
+	 * and to avoid iscsit_conn pointer dereference in iser-target code.
 	 */
 	if (!conn->conn_transport->rdma_shutdown)
 		complete(&conn->conn_logout_comp);
@@ -4506,7 +4506,7 @@ int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 }
 
 static void iscsit_logout_post_handler_closesession(
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	int sleep = 1;
@@ -4535,7 +4535,7 @@ static void iscsit_logout_post_handler_closesession(
 }
 
 static void iscsit_logout_post_handler_samecid(
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	int sleep = 1;
 
@@ -4553,10 +4553,10 @@ static void iscsit_logout_post_handler_samecid(
 }
 
 static void iscsit_logout_post_handler_diffcid(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u16 cid)
 {
-	struct iscsi_conn *l_conn;
+	struct iscsit_conn *l_conn;
 	struct iscsi_session *sess = conn->sess;
 	bool conn_found = false;
 
@@ -4593,7 +4593,7 @@ static void iscsit_logout_post_handler_diffcid(
  */
 int iscsit_logout_post_handler(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	int ret = 0;
 
@@ -4651,7 +4651,7 @@ EXPORT_SYMBOL(iscsit_logout_post_handler);
 
 void iscsit_fail_session(struct iscsi_session *sess)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 
 	spin_lock_bh(&sess->conn_lock);
 	list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
@@ -4670,7 +4670,7 @@ void iscsit_stop_session(
 	int connection_sleep)
 {
 	u16 conn_count = atomic_read(&sess->nconn);
-	struct iscsi_conn *conn, *conn_tmp = NULL;
+	struct iscsit_conn *conn, *conn_tmp = NULL;
 	int is_last;
 
 	spin_lock_bh(&sess->conn_lock);
diff --git a/drivers/target/iscsi/iscsi_target.h b/drivers/target/iscsi/iscsi_target.h
index bfa3559cf823..314e29fcaa5a 100644
--- a/drivers/target/iscsi/iscsi_target.h
+++ b/drivers/target/iscsi/iscsi_target.h
@@ -6,7 +6,7 @@
 #include <linux/spinlock.h>
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_np;
 struct iscsi_portal_group;
 struct iscsi_session;
@@ -32,15 +32,15 @@ extern int iscsit_reset_np_thread(struct iscsi_np *, struct iscsi_tpg_np *,
 extern int iscsit_del_np(struct iscsi_np *);
 extern int iscsit_reject_cmd(struct iscsit_cmd *cmd, u8, unsigned char *);
 extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
-extern int iscsit_logout_closesession(struct iscsit_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_closeconnection(struct iscsit_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *, struct iscsi_conn *);
-extern int iscsit_send_async_msg(struct iscsi_conn *, u16, u8, u8);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *, bool recovery);
-extern void iscsit_thread_get_cpumask(struct iscsi_conn *);
+extern int iscsit_logout_closesession(struct iscsit_cmd *, struct iscsit_conn *);
+extern int iscsit_logout_closeconnection(struct iscsit_cmd *, struct iscsit_conn *);
+extern int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *, struct iscsit_conn *);
+extern int iscsit_send_async_msg(struct iscsit_conn *, u16, u8, u8);
+extern int iscsit_build_r2ts_for_cmd(struct iscsit_conn *, struct iscsit_cmd *, bool recovery);
+extern void iscsit_thread_get_cpumask(struct iscsit_conn *);
 extern int iscsi_target_tx_thread(void *);
 extern int iscsi_target_rx_thread(void *);
-extern int iscsit_close_connection(struct iscsi_conn *);
+extern int iscsit_close_connection(struct iscsit_conn *);
 extern int iscsit_close_session(struct iscsi_session *, bool can_sleep);
 extern void iscsit_fail_session(struct iscsi_session *);
 extern void iscsit_stop_session(struct iscsi_session *, int, int);
diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 62d912b79c61..6e5611d8f51b 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -35,7 +35,7 @@ static char *chap_get_digest_name(const int digest_type)
 }
 
 static int chap_gen_challenge(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	int caller,
 	char *c_str,
 	unsigned int *c_len)
@@ -128,14 +128,14 @@ static int chap_check_algorithm(const char *a_str)
 	return r;
 }
 
-static void chap_close(struct iscsi_conn *conn)
+static void chap_close(struct iscsit_conn *conn)
 {
 	kfree(conn->auth_protocol);
 	conn->auth_protocol = NULL;
 }
 
 static struct iscsi_chap *chap_server_open(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_node_auth *auth,
 	const char *a_str,
 	char *aic_str,
@@ -206,7 +206,7 @@ static struct iscsi_chap *chap_server_open(
 }
 
 static int chap_server_compute_hash(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_node_auth *auth,
 	char *nr_in_ptr,
 	char *nr_out_ptr,
@@ -497,7 +497,7 @@ static int chap_server_compute_hash(
 }
 
 u32 chap_main_loop(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_node_auth *auth,
 	char *in_text,
 	char *out_text,
diff --git a/drivers/target/iscsi/iscsi_target_auth.h b/drivers/target/iscsi/iscsi_target_auth.h
index fc75c1c20e23..ceb9b7754770 100644
--- a/drivers/target/iscsi/iscsi_target_auth.h
+++ b/drivers/target/iscsi/iscsi_target_auth.h
@@ -27,9 +27,9 @@
 #define CHAP_STAGE_SERVER_NR	5
 
 struct iscsi_node_auth;
-struct iscsi_conn;
+struct iscsit_conn;
 
-extern u32 chap_main_loop(struct iscsi_conn *, struct iscsi_node_auth *, char *, char *,
+extern u32 chap_main_loop(struct iscsit_conn *, struct iscsi_node_auth *, char *, char *,
 				int *, int *);
 
 struct iscsi_chap {
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0c1f4ad3e04a..aadc855f67fa 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -499,7 +499,7 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
 {
 	struct se_node_acl *se_nacl = acl_to_nacl(item);
 	struct iscsi_session *sess;
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	struct se_session *se_sess;
 	ssize_t rb = 0;
 	u32 max_cmd_sn;
@@ -1367,7 +1367,7 @@ static u32 lio_sess_get_initiator_sid(
 static int lio_queue_data_in(struct se_cmd *se_cmd)
 {
 	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_DATAIN;
 	return conn->conn_transport->iscsit_queue_data_in(conn, cmd);
@@ -1376,7 +1376,7 @@ static int lio_queue_data_in(struct se_cmd *se_cmd)
 static int lio_write_pending(struct se_cmd *se_cmd)
 {
 	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	if (!cmd->immediate_data && !cmd->unsolicited_data)
 		return conn->conn_transport->iscsit_get_dataout(conn, cmd, false);
@@ -1387,7 +1387,7 @@ static int lio_write_pending(struct se_cmd *se_cmd)
 static int lio_queue_status(struct se_cmd *se_cmd)
 {
 	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_STATUS;
 
diff --git a/drivers/target/iscsi/iscsi_target_datain_values.c b/drivers/target/iscsi/iscsi_target_datain_values.c
index 091a710eadb0..2d44781be3c6 100644
--- a/drivers/target/iscsi/iscsi_target_datain_values.c
+++ b/drivers/target/iscsi/iscsi_target_datain_values.c
@@ -80,7 +80,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_yes(
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 
 	dr = iscsit_get_datain_req(cmd);
@@ -178,7 +178,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_yes(
 	struct iscsi_datain *datain)
 {
 	u32 offset, read_data_done, read_data_left, seq_send_order;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 	struct iscsi_seq *seq;
 
@@ -299,7 +299,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_no(
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 	struct iscsi_pdu *pdu;
 
@@ -398,7 +398,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_no(
 	struct iscsi_datain *datain)
 {
 	u32 read_data_done, read_data_left, seq_send_order;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 	struct iscsi_pdu *pdu;
 	struct iscsi_seq *seq = NULL;
@@ -499,7 +499,7 @@ struct iscsi_datain_req *iscsit_get_datain_values(
 	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	if (conn->sess->sess_ops->DataSequenceInOrder &&
 	    conn->sess->sess_ops->DataPDUInOrder)
diff --git a/drivers/target/iscsi/iscsi_target_erl0.c b/drivers/target/iscsi/iscsi_target_erl0.c
index 8ca910571ed3..e21f6c6dfd99 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.c
+++ b/drivers/target/iscsi/iscsi_target_erl0.c
@@ -31,7 +31,7 @@
 void iscsit_set_dataout_sequence_values(
 	struct iscsit_cmd *cmd)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	/*
 	 * Still set seq_start_offset and seq_end_offset for Unsolicited
 	 * DataOUT, even if DataSequenceInOrder=No.
@@ -66,7 +66,7 @@ static int iscsit_dataout_within_command_recovery_check(
 	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
 
@@ -133,7 +133,7 @@ static int iscsit_dataout_check_unsolicited_sequence(
 	unsigned char *buf)
 {
 	u32 first_burst_len;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
 
@@ -208,7 +208,7 @@ static int iscsit_dataout_check_sequence(
 	unsigned char *buf)
 {
 	u32 next_burst_len;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_seq *seq = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -337,7 +337,7 @@ static int iscsit_dataout_check_datasn(
 	unsigned char *buf)
 {
 	u32 data_sn = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
 
@@ -388,7 +388,7 @@ static int iscsit_dataout_pre_datapduinorder_yes(
 	unsigned char *buf)
 {
 	int dump = 0, recovery = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
 
@@ -534,7 +534,7 @@ static int iscsit_dataout_post_crc_passed(
 	unsigned char *buf)
 {
 	int ret, send_r2t = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_seq *seq = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -644,7 +644,7 @@ static int iscsit_dataout_post_crc_failed(
 	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *pdu;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -683,7 +683,7 @@ int iscsit_check_pre_dataout(
 	unsigned char *buf)
 {
 	int ret;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	ret = iscsit_dataout_within_command_recovery_check(cmd, buf);
 	if ((ret == DATAOUT_WITHIN_COMMAND_RECOVERY) ||
@@ -721,7 +721,7 @@ int iscsit_check_post_dataout(
 	unsigned char *buf,
 	u8 data_crc_failed)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->dataout_timeout_retries = 0;
 
@@ -819,7 +819,7 @@ int iscsit_stop_time2retain_timer(struct iscsi_session *sess)
 	return 0;
 }
 
-void iscsit_connection_reinstatement_rcfr(struct iscsi_conn *conn)
+void iscsit_connection_reinstatement_rcfr(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->state_lock);
 	if (atomic_read(&conn->connection_exit)) {
@@ -843,7 +843,7 @@ void iscsit_connection_reinstatement_rcfr(struct iscsi_conn *conn)
 	complete(&conn->conn_post_wait_comp);
 }
 
-void iscsit_cause_connection_reinstatement(struct iscsi_conn *conn, int sleep)
+void iscsit_cause_connection_reinstatement(struct iscsit_conn *conn, int sleep)
 {
 	spin_lock_bh(&conn->state_lock);
 	if (atomic_read(&conn->connection_exit)) {
@@ -888,7 +888,7 @@ void iscsit_fall_back_to_erl0(struct iscsi_session *sess)
 	atomic_set(&sess->session_fall_back_to_erl0, 1);
 }
 
-static void iscsit_handle_connection_cleanup(struct iscsi_conn *conn)
+static void iscsit_handle_connection_cleanup(struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 
@@ -904,7 +904,7 @@ static void iscsit_handle_connection_cleanup(struct iscsi_conn *conn)
 	}
 }
 
-void iscsit_take_action_for_connection_exit(struct iscsi_conn *conn, bool *conn_freed)
+void iscsit_take_action_for_connection_exit(struct iscsit_conn *conn, bool *conn_freed)
 {
 	*conn_freed = false;
 
diff --git a/drivers/target/iscsi/iscsi_target_erl0.h b/drivers/target/iscsi/iscsi_target_erl0.h
index d23a3041c325..9d34c1cd6b57 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.h
+++ b/drivers/target/iscsi/iscsi_target_erl0.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_session;
 
 extern void iscsit_set_dataout_sequence_values(struct iscsit_cmd *);
@@ -14,9 +14,9 @@ extern int iscsit_check_post_dataout(struct iscsit_cmd *, unsigned char *, u8);
 extern void iscsit_start_time2retain_handler(struct iscsi_session *);
 extern void iscsit_handle_time2retain_timeout(struct timer_list *t);
 extern int iscsit_stop_time2retain_timer(struct iscsi_session *);
-extern void iscsit_connection_reinstatement_rcfr(struct iscsi_conn *);
-extern void iscsit_cause_connection_reinstatement(struct iscsi_conn *, int);
+extern void iscsit_connection_reinstatement_rcfr(struct iscsit_conn *);
+extern void iscsit_cause_connection_reinstatement(struct iscsit_conn *, int);
 extern void iscsit_fall_back_to_erl0(struct iscsi_session *);
-extern void iscsit_take_action_for_connection_exit(struct iscsi_conn *, bool *);
+extern void iscsit_take_action_for_connection_exit(struct iscsit_conn *, bool *);
 
 #endif   /*** ISCSI_TARGET_ERL0_H ***/
diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index d348a9af7789..2c3ac5986b45 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -36,7 +36,7 @@
  *	to be dumped.
  */
 int iscsit_dump_data_payload(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u32 buf_len,
 	int dump_padding_digest)
 {
@@ -173,7 +173,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
 	u32 data_sn = 0, data_sn_count = 0;
 	u32 pdu_start = 0, seq_no = 0;
 	u32 begrun = dr->begrun;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	while (begrun > data_sn++) {
 		data_sn_count++;
@@ -220,7 +220,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 	u32 data_sn, read_data_done = 0, seq_send_order = 0;
 	u32 begrun = dr->begrun;
 	u32 runlength = dr->runlength;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_seq *first_seq = NULL, *seq = NULL;
 
 	if (!cmd->seq_list) {
@@ -376,7 +376,7 @@ static int iscsit_handle_recovery_datain(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 
@@ -432,7 +432,7 @@ static int iscsit_handle_recovery_datain(
 }
 
 int iscsit_handle_recovery_datain_or_r2t(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	unsigned char *buf,
 	itt_t init_task_tag,
 	u32 targ_xfer_tag,
@@ -465,7 +465,7 @@ int iscsit_handle_recovery_datain_or_r2t(
 
 /* #warning FIXME: Status SNACK needs to be dependent on OPCODE!!! */
 int iscsit_handle_status_snack(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	itt_t init_task_tag,
 	u32 targ_xfer_tag,
 	u32 begrun,
@@ -529,7 +529,7 @@ int iscsit_handle_status_snack(
 }
 
 int iscsit_handle_data_ack(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u32 targ_xfer_tag,
 	u32 begrun,
 	u32 runlength)
@@ -584,7 +584,7 @@ int iscsit_dataout_datapduinorder_no_fbit(
 {
 	int i, send_recovery_r2t = 0, recovery = 0;
 	u32 length = 0, offset = 0, pdu_count = 0, xfer_len = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *first_pdu = NULL;
 
 	/*
@@ -662,7 +662,7 @@ static int iscsit_recalculate_dataout_values(
 	u32 *r2t_length)
 {
 	int i;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *pdu = NULL;
 
 	if (conn->sess->sess_ops->DataSequenceInOrder) {
@@ -825,7 +825,7 @@ void iscsit_remove_ooo_cmdsn(
 	kmem_cache_free(lio_ooo_cache, ooo_cmdsn);
 }
 
-void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
+void iscsit_clear_ooo_cmdsns_for_conn(struct iscsit_conn *conn)
 {
 	struct iscsi_ooo_cmdsn *ooo_cmdsn;
 	struct iscsi_session *sess = conn->sess;
@@ -887,7 +887,7 @@ int iscsit_execute_ooo_cmdsns(struct iscsi_session *sess)
 int iscsit_execute_cmd(struct iscsit_cmd *cmd, int ooo)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	int lr = 0;
 
 	spin_lock_bh(&cmd->istate_lock);
@@ -1053,7 +1053,7 @@ static int iscsit_set_dataout_timeout_values(
 	u32 *offset,
 	u32 *length)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_r2t *r2t;
 
 	if (cmd->unsolicited_data) {
@@ -1096,7 +1096,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 	u32 pdu_length = 0, pdu_offset = 0;
 	u32 r2t_length = 0, r2t_offset = 0;
 	struct iscsit_cmd *cmd = from_timer(cmd, t, dataout_timer);
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_session *sess = NULL;
 	struct iscsi_node_attrib *na;
 
@@ -1181,7 +1181,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 
 void iscsit_mod_dataout_timer(struct iscsit_cmd *cmd)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_attrib *na = iscsit_tpg_get_node_attrib(sess);
 
@@ -1200,7 +1200,7 @@ void iscsit_mod_dataout_timer(struct iscsit_cmd *cmd)
 
 void iscsit_start_dataout_timer(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_attrib *na = iscsit_tpg_get_node_attrib(sess);
diff --git a/drivers/target/iscsi/iscsi_target_erl1.h b/drivers/target/iscsi/iscsi_target_erl1.h
index 48a13fc32e93..b1e60fb26d5f 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.h
+++ b/drivers/target/iscsi/iscsi_target_erl1.h
@@ -6,25 +6,25 @@
 #include <scsi/iscsi_proto.h> /* itt_t */
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_datain_req;
 struct iscsi_ooo_cmdsn;
 struct iscsi_pdu;
 struct iscsi_session;
 
-extern int iscsit_dump_data_payload(struct iscsi_conn *, u32, int);
+extern int iscsit_dump_data_payload(struct iscsit_conn *, u32, int);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
 			struct iscsit_cmd *, struct iscsi_datain_req *);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 			struct iscsit_cmd *, struct iscsi_datain_req *);
-extern int iscsit_handle_recovery_datain_or_r2t(struct iscsi_conn *, unsigned char *,
+extern int iscsit_handle_recovery_datain_or_r2t(struct iscsit_conn *, unsigned char *,
 			itt_t, u32, u32, u32);
-extern int iscsit_handle_status_snack(struct iscsi_conn *, itt_t, u32,
+extern int iscsit_handle_status_snack(struct iscsit_conn *, itt_t, u32,
 			u32, u32);
-extern int iscsit_handle_data_ack(struct iscsi_conn *, u32, u32, u32);
+extern int iscsit_handle_data_ack(struct iscsit_conn *, u32, u32, u32);
 extern int iscsit_dataout_datapduinorder_no_fbit(struct iscsit_cmd *, struct iscsi_pdu *);
 extern int iscsit_recover_dataout_sequence(struct iscsit_cmd *, u32, u32);
-extern void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *);
+extern void iscsit_clear_ooo_cmdsns_for_conn(struct iscsit_conn *);
 extern void iscsit_free_all_ooo_cmdsns(struct iscsi_session *);
 extern int iscsit_execute_ooo_cmdsns(struct iscsi_session *);
 extern int iscsit_execute_cmd(struct iscsit_cmd *, int);
@@ -32,7 +32,7 @@ extern int iscsit_handle_ooo_cmdsn(struct iscsi_session *, struct iscsit_cmd *,
 extern void iscsit_remove_ooo_cmdsn(struct iscsi_session *, struct iscsi_ooo_cmdsn *);
 extern void iscsit_handle_dataout_timeout(struct timer_list *t);
 extern void iscsit_mod_dataout_timer(struct iscsit_cmd *);
-extern void iscsit_start_dataout_timer(struct iscsit_cmd *, struct iscsi_conn *);
+extern void iscsit_start_dataout_timer(struct iscsit_cmd *, struct iscsit_conn *);
 extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 
 #endif /* ISCSI_TARGET_ERL1_H */
diff --git a/drivers/target/iscsi/iscsi_target_erl2.c b/drivers/target/iscsi/iscsi_target_erl2.c
index f19ac2dbc062..1dbdf7937e29 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.c
+++ b/drivers/target/iscsi/iscsi_target_erl2.c
@@ -30,7 +30,7 @@ void iscsit_create_conn_recovery_datain_values(
 	__be32 exp_data_sn)
 {
 	u32 data_sn = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->next_burst_len = 0;
 	cmd->read_data_done = 0;
@@ -57,7 +57,7 @@ void iscsit_create_conn_recovery_dataout_values(
 	struct iscsit_cmd *cmd)
 {
 	u32 write_data_done = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->data_sn = 0;
 	cmd->next_burst_len = 0;
@@ -263,7 +263,7 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 	}
 }
 
-int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
+int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsit_conn *conn)
 {
 	u32 dropped_count = 0;
 	struct iscsit_cmd *cmd, *cmd_tmp;
@@ -304,7 +304,7 @@ int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
+int iscsit_prepare_cmds_for_reallegiance(struct iscsit_conn *conn)
 {
 	u32 cmd_count = 0;
 	struct iscsit_cmd *cmd, *cmd_tmp;
@@ -418,7 +418,7 @@ int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_connection_recovery_transport_reset(struct iscsi_conn *conn)
+int iscsit_connection_recovery_transport_reset(struct iscsit_conn *conn)
 {
 	atomic_set(&conn->connection_recovery, 1);
 
diff --git a/drivers/target/iscsi/iscsi_target_erl2.h b/drivers/target/iscsi/iscsi_target_erl2.h
index cf411375ad4c..5b311ed9ebc4 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.h
+++ b/drivers/target/iscsi/iscsi_target_erl2.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
@@ -19,8 +19,8 @@ extern int iscsit_remove_active_connection_recovery_entry(
 extern int iscsit_remove_cmd_from_connection_recovery(struct iscsit_cmd *,
 			struct iscsi_session *);
 extern void iscsit_discard_cr_cmds_by_expstatsn(struct iscsi_conn_recovery *, u32);
-extern int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *);
-extern int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *);
-extern int iscsit_connection_recovery_transport_reset(struct iscsi_conn *);
+extern int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsit_conn *);
+extern int iscsit_prepare_cmds_for_reallegiance(struct iscsit_conn *);
+extern int iscsit_connection_recovery_transport_reset(struct iscsit_conn *);
 
 #endif /*** ISCSI_TARGET_ERL2_H ***/
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 9c01fb864585..a303ba7d20c3 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -35,7 +35,7 @@
 
 #include <target/iscsi/iscsi_transport.h>
 
-static struct iscsi_login *iscsi_login_init_conn(struct iscsi_conn *conn)
+static struct iscsi_login *iscsi_login_init_conn(struct iscsit_conn *conn)
 {
 	struct iscsi_login *login;
 
@@ -73,9 +73,9 @@ static struct iscsi_login *iscsi_login_init_conn(struct iscsi_conn *conn)
 
 /*
  * Used by iscsi_target_nego.c:iscsi_target_locate_portal() to setup
- * per struct iscsi_conn libcrypto contexts for crc32c and crc32-intel
+ * per struct iscsit_conn libcrypto contexts for crc32c and crc32-intel
  */
-int iscsi_login_setup_crypto(struct iscsi_conn *conn)
+int iscsi_login_setup_crypto(struct iscsit_conn *conn)
 {
 	struct crypto_ahash *tfm;
 
@@ -112,7 +112,7 @@ int iscsi_login_setup_crypto(struct iscsi_conn *conn)
 }
 
 static int iscsi_login_check_initiator_version(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 version_max,
 	u8 version_min)
 {
@@ -128,7 +128,7 @@ static int iscsi_login_check_initiator_version(
 	return 0;
 }
 
-int iscsi_check_for_session_reinstatement(struct iscsi_conn *conn)
+int iscsi_check_for_session_reinstatement(struct iscsit_conn *conn)
 {
 	int sessiontype;
 	struct iscsi_param *initiatorname_param = NULL, *sessiontype_param = NULL;
@@ -205,7 +205,7 @@ int iscsi_check_for_session_reinstatement(struct iscsi_conn *conn)
 
 static int iscsi_login_set_conn_values(
 	struct iscsi_session *sess,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	__be16 cid)
 {
 	int ret;
@@ -226,7 +226,7 @@ static int iscsi_login_set_conn_values(
 }
 
 __printf(2, 3) int iscsi_change_param_sprintf(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	const char *fmt, ...)
 {
 	va_list args;
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(iscsi_change_param_sprintf);
  *	or session reinstatement.
  */
 static int iscsi_login_zero_tsih_s1(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	unsigned char *buf)
 {
 	struct iscsi_session *sess = NULL;
@@ -337,7 +337,7 @@ static int iscsi_login_zero_tsih_s1(
 }
 
 static int iscsi_login_zero_tsih_s2(
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_node_attrib *na;
 	struct iscsi_session *sess = conn->sess;
@@ -458,7 +458,7 @@ static int iscsi_login_zero_tsih_s2(
 }
 
 static int iscsi_login_non_zero_tsih_s1(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	unsigned char *buf)
 {
 	struct iscsi_login_req *pdu = (struct iscsi_login_req *)buf;
@@ -470,7 +470,7 @@ static int iscsi_login_non_zero_tsih_s1(
  *	Add a new connection to an existing session.
  */
 static int iscsi_login_non_zero_tsih_s2(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	unsigned char *buf)
 {
 	struct iscsi_portal_group *tpg = conn->tpg;
@@ -546,11 +546,11 @@ static int iscsi_login_non_zero_tsih_s2(
 }
 
 int iscsi_login_post_auth_non_zero_tsih(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u16 cid,
 	u32 exp_statsn)
 {
-	struct iscsi_conn *conn_ptr = NULL;
+	struct iscsit_conn *conn_ptr = NULL;
 	struct iscsi_conn_recovery *cr = NULL;
 	struct iscsi_session *sess = conn->sess;
 
@@ -612,7 +612,7 @@ int iscsi_login_post_auth_non_zero_tsih(
 	return 0;
 }
 
-static void iscsi_post_login_start_timers(struct iscsi_conn *conn)
+static void iscsi_post_login_start_timers(struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	/*
@@ -625,7 +625,7 @@ static void iscsi_post_login_start_timers(struct iscsi_conn *conn)
 		iscsit_start_nopin_timer(conn);
 }
 
-int iscsit_start_kthreads(struct iscsi_conn *conn)
+int iscsit_start_kthreads(struct iscsit_conn *conn)
 {
 	int ret = 0;
 
@@ -673,7 +673,7 @@ int iscsit_start_kthreads(struct iscsi_conn *conn)
 
 void iscsi_post_login_handler(
 	struct iscsi_np *np,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 zero_tsih)
 {
 	int stop_timer = 0;
@@ -730,7 +730,7 @@ void iscsi_post_login_handler(
 		conn->conn_tx_reset_cpumask = 1;
 		/*
 		 * Wakeup the sleeping iscsi_target_rx_thread() now that
-		 * iscsi_conn is in TARG_CONN_STATE_LOGGED_IN state.
+		 * iscsit_conn is in TARG_CONN_STATE_LOGGED_IN state.
 		 */
 		complete(&conn->rx_login_comp);
 		iscsit_dec_conn_usage_count(conn);
@@ -792,7 +792,7 @@ void iscsi_post_login_handler(
 	conn->conn_tx_reset_cpumask = 1;
 	/*
 	 * Wakeup the sleeping iscsi_target_rx_thread() now that
-	 * iscsi_conn is in TARG_CONN_STATE_LOGGED_IN state.
+	 * iscsit_conn is in TARG_CONN_STATE_LOGGED_IN state.
 	 */
 	complete(&conn->rx_login_comp);
 	iscsit_dec_conn_usage_count(conn);
@@ -944,7 +944,7 @@ int iscsi_target_setup_login_socket(
 	return 0;
 }
 
-int iscsit_accept_np(struct iscsi_np *np, struct iscsi_conn *conn)
+int iscsit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 {
 	struct socket *new_sock, *sock = np->np_socket;
 	struct sockaddr_in sock_in;
@@ -1005,7 +1005,7 @@ int iscsit_accept_np(struct iscsi_np *np, struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
+int iscsit_get_login_rx(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	struct iscsi_login_req *login_req;
 	u32 padding = 0, payload_length;
@@ -1050,7 +1050,7 @@ int iscsit_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
 	return 0;
 }
 
-int iscsit_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
+int iscsit_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 			u32 length)
 {
 	if (iscsi_login_tx_data(conn, login->rsp, login->rsp_buf, length) < 0)
@@ -1060,7 +1060,7 @@ int iscsit_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
 }
 
 static int
-iscsit_conn_set_transport(struct iscsi_conn *conn, struct iscsit_transport *t)
+iscsit_conn_set_transport(struct iscsit_conn *conn, struct iscsit_transport *t)
 {
 	int rc;
 
@@ -1079,11 +1079,11 @@ iscsit_conn_set_transport(struct iscsi_conn *conn, struct iscsit_transport *t)
 	return 0;
 }
 
-static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
+static struct iscsit_conn *iscsit_alloc_conn(struct iscsi_np *np)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 
-	conn = kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	conn = kzalloc(sizeof(struct iscsit_conn), GFP_KERNEL);
 	if (!conn) {
 		pr_err("Could not allocate memory for new connection\n");
 		return NULL;
@@ -1147,7 +1147,7 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
 	return NULL;
 }
 
-void iscsit_free_conn(struct iscsi_conn *conn)
+void iscsit_free_conn(struct iscsit_conn *conn)
 {
 	free_cpumask_var(conn->allowed_cpumask);
 	free_cpumask_var(conn->conn_cpumask);
@@ -1156,7 +1156,7 @@ void iscsit_free_conn(struct iscsi_conn *conn)
 	kfree(conn);
 }
 
-void iscsi_target_login_sess_out(struct iscsi_conn *conn,
+void iscsi_target_login_sess_out(struct iscsit_conn *conn,
 				 bool zero_tsih, bool new_sess)
 {
 	if (!new_sess)
@@ -1228,7 +1228,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 {
 	u8 *buffer, zero_tsih = 0;
 	int ret = 0, rc;
-	struct iscsi_conn *conn = NULL;
+	struct iscsit_conn *conn = NULL;
 	struct iscsi_login *login;
 	struct iscsi_portal_group *tpg = NULL;
 	struct iscsi_login_req *pdu;
@@ -1371,7 +1371,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 
 	tpg = conn->tpg;
 	if (!tpg) {
-		pr_err("Unable to locate struct iscsi_conn->tpg\n");
+		pr_err("Unable to locate struct iscsit_conn->tpg\n");
 		goto new_sess_out;
 	}
 
diff --git a/drivers/target/iscsi/iscsi_target_login.h b/drivers/target/iscsi/iscsi_target_login.h
index fc95e6150253..3ca2f232b387 100644
--- a/drivers/target/iscsi/iscsi_target_login.h
+++ b/drivers/target/iscsi/iscsi_target_login.h
@@ -4,25 +4,25 @@
 
 #include <linux/types.h>
 
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_login;
 struct iscsi_np;
 struct sockaddr_storage;
 
-extern int iscsi_login_setup_crypto(struct iscsi_conn *);
-extern int iscsi_check_for_session_reinstatement(struct iscsi_conn *);
-extern int iscsi_login_post_auth_non_zero_tsih(struct iscsi_conn *, u16, u32);
+extern int iscsi_login_setup_crypto(struct iscsit_conn *);
+extern int iscsi_check_for_session_reinstatement(struct iscsit_conn *);
+extern int iscsi_login_post_auth_non_zero_tsih(struct iscsit_conn *, u16, u32);
 extern int iscsit_setup_np(struct iscsi_np *,
 				struct sockaddr_storage *);
 extern int iscsi_target_setup_login_socket(struct iscsi_np *,
 				struct sockaddr_storage *);
-extern int iscsit_accept_np(struct iscsi_np *, struct iscsi_conn *);
-extern int iscsit_get_login_rx(struct iscsi_conn *, struct iscsi_login *);
-extern int iscsit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-extern void iscsit_free_conn(struct iscsi_conn *);
-extern int iscsit_start_kthreads(struct iscsi_conn *);
-extern void iscsi_post_login_handler(struct iscsi_np *, struct iscsi_conn *, u8);
-extern void iscsi_target_login_sess_out(struct iscsi_conn *, bool, bool);
+extern int iscsit_accept_np(struct iscsi_np *, struct iscsit_conn *);
+extern int iscsit_get_login_rx(struct iscsit_conn *, struct iscsi_login *);
+extern int iscsit_put_login_tx(struct iscsit_conn *, struct iscsi_login *, u32);
+extern void iscsit_free_conn(struct iscsit_conn *);
+extern int iscsit_start_kthreads(struct iscsit_conn *);
+extern void iscsi_post_login_handler(struct iscsi_np *, struct iscsit_conn *, u8);
+extern void iscsi_target_login_sess_out(struct iscsit_conn *, bool, bool);
 extern int iscsi_target_login_thread(void *);
 extern void iscsi_handle_login_thread_timeout(struct timer_list *t);
 
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index b0cc8e0a10e8..b65c73fc6073 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -95,7 +95,7 @@ int extract_param(
 }
 
 static u32 iscsi_handle_authentication(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	char *in_buf,
 	char *out_buf,
 	int in_length,
@@ -151,13 +151,13 @@ static u32 iscsi_handle_authentication(
 	return 2;
 }
 
-static void iscsi_remove_failed_auth_entry(struct iscsi_conn *conn)
+static void iscsi_remove_failed_auth_entry(struct iscsit_conn *conn)
 {
 	kfree(conn->auth_protocol);
 }
 
 int iscsi_target_check_login_request(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	int req_csg, req_nsg;
@@ -248,7 +248,7 @@ int iscsi_target_check_login_request(
 EXPORT_SYMBOL(iscsi_target_check_login_request);
 
 static int iscsi_target_check_first_request(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	struct iscsi_param *param = NULL;
@@ -315,7 +315,7 @@ static int iscsi_target_check_first_request(
 	return 0;
 }
 
-static int iscsi_target_do_tx_login_io(struct iscsi_conn *conn, struct iscsi_login *login)
+static int iscsi_target_do_tx_login_io(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	u32 padding = 0;
 	struct iscsi_login_rsp *login_rsp;
@@ -382,7 +382,7 @@ static int iscsi_target_do_tx_login_io(struct iscsi_conn *conn, struct iscsi_log
 
 static void iscsi_target_sk_data_ready(struct sock *sk)
 {
-	struct iscsi_conn *conn = sk->sk_user_data;
+	struct iscsit_conn *conn = sk->sk_user_data;
 	bool rc;
 
 	pr_debug("Entering iscsi_target_sk_data_ready: conn: %p\n", conn);
@@ -421,7 +421,7 @@ static void iscsi_target_sk_data_ready(struct sock *sk)
 
 static void iscsi_target_sk_state_change(struct sock *);
 
-static void iscsi_target_set_sock_callbacks(struct iscsi_conn *conn)
+static void iscsi_target_set_sock_callbacks(struct iscsit_conn *conn)
 {
 	struct sock *sk;
 
@@ -443,7 +443,7 @@ static void iscsi_target_set_sock_callbacks(struct iscsi_conn *conn)
 	sk->sk_rcvtimeo = TA_LOGIN_TIMEOUT * HZ;
 }
 
-static void iscsi_target_restore_sock_callbacks(struct iscsi_conn *conn)
+static void iscsi_target_restore_sock_callbacks(struct iscsit_conn *conn)
 {
 	struct sock *sk;
 
@@ -467,7 +467,7 @@ static void iscsi_target_restore_sock_callbacks(struct iscsi_conn *conn)
 	sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
 }
 
-static int iscsi_target_do_login(struct iscsi_conn *, struct iscsi_login *);
+static int iscsi_target_do_login(struct iscsit_conn *, struct iscsi_login *);
 
 static bool __iscsi_target_sk_check_close(struct sock *sk)
 {
@@ -479,7 +479,7 @@ static bool __iscsi_target_sk_check_close(struct sock *sk)
 	return false;
 }
 
-static bool iscsi_target_sk_check_close(struct iscsi_conn *conn)
+static bool iscsi_target_sk_check_close(struct iscsit_conn *conn)
 {
 	bool state = false;
 
@@ -494,7 +494,7 @@ static bool iscsi_target_sk_check_close(struct iscsi_conn *conn)
 	return state;
 }
 
-static bool iscsi_target_sk_check_flag(struct iscsi_conn *conn, unsigned int flag)
+static bool iscsi_target_sk_check_flag(struct iscsit_conn *conn, unsigned int flag)
 {
 	bool state = false;
 
@@ -508,7 +508,7 @@ static bool iscsi_target_sk_check_flag(struct iscsi_conn *conn, unsigned int fla
 	return state;
 }
 
-static bool iscsi_target_sk_check_and_clear(struct iscsi_conn *conn, unsigned int flag)
+static bool iscsi_target_sk_check_and_clear(struct iscsit_conn *conn, unsigned int flag)
 {
 	bool state = false;
 
@@ -525,7 +525,7 @@ static bool iscsi_target_sk_check_and_clear(struct iscsi_conn *conn, unsigned in
 	return state;
 }
 
-static void iscsi_target_login_drop(struct iscsi_conn *conn, struct iscsi_login *login)
+static void iscsi_target_login_drop(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	bool zero_tsih = login->zero_tsih;
 
@@ -536,13 +536,13 @@ static void iscsi_target_login_drop(struct iscsi_conn *conn, struct iscsi_login
 
 struct conn_timeout {
 	struct timer_list timer;
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 };
 
 static void iscsi_target_login_timeout(struct timer_list *t)
 {
 	struct conn_timeout *timeout = from_timer(timeout, t, timer);
-	struct iscsi_conn *conn = timeout->conn;
+	struct iscsit_conn *conn = timeout->conn;
 
 	pr_debug("Entering iscsi_target_login_timeout >>>>>>>>>>>>>>>>>>>\n");
 
@@ -555,8 +555,8 @@ static void iscsi_target_login_timeout(struct timer_list *t)
 
 static void iscsi_target_do_login_rx(struct work_struct *work)
 {
-	struct iscsi_conn *conn = container_of(work,
-				struct iscsi_conn, login_work.work);
+	struct iscsit_conn *conn = container_of(work,
+				struct iscsit_conn, login_work.work);
 	struct iscsi_login *login = conn->login;
 	struct iscsi_np *np = login->np;
 	struct iscsi_portal_group *tpg = conn->tpg;
@@ -662,7 +662,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 
 static void iscsi_target_sk_state_change(struct sock *sk)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	void (*orig_state_change)(struct sock *);
 	bool state;
 
@@ -741,7 +741,7 @@ static void iscsi_target_sk_state_change(struct sock *sk)
  *	ISID/TSIH combinations.
  */
 static int iscsi_target_check_for_existing_instances(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	if (login->checked_for_existing)
@@ -757,7 +757,7 @@ static int iscsi_target_check_for_existing_instances(
 }
 
 static int iscsi_target_do_authentication(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	int authret;
@@ -816,7 +816,7 @@ static int iscsi_target_do_authentication(
 }
 
 static int iscsi_target_handle_csg_zero(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	int ret;
@@ -906,7 +906,7 @@ static int iscsi_target_handle_csg_zero(
 	return iscsi_target_do_authentication(conn, login);
 }
 
-static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_login *login)
+static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	int ret;
 	u32 payload_length;
@@ -968,7 +968,7 @@ static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_log
 	return 0;
 }
 
-static int iscsi_target_do_login(struct iscsi_conn *conn, struct iscsi_login *login)
+static int iscsi_target_do_login(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	int pdu_count = 0;
 	struct iscsi_login_req *login_req;
@@ -1054,7 +1054,7 @@ static void iscsi_initiatorname_tolower(
  */
 int iscsi_target_locate_portal(
 	struct iscsi_np *np,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_login *login)
 {
 	char *i_buf = NULL, *s_buf = NULL, *t_buf = NULL;
@@ -1287,7 +1287,7 @@ int iscsi_target_locate_portal(
 
 int iscsi_target_start_negotiation(
 	struct iscsi_login *login,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	int ret;
 
@@ -1323,7 +1323,7 @@ int iscsi_target_start_negotiation(
 	return ret;
 }
 
-void iscsi_target_nego_release(struct iscsi_conn *conn)
+void iscsi_target_nego_release(struct iscsit_conn *conn)
 {
 	struct iscsi_login *login = conn->conn_login;
 
diff --git a/drivers/target/iscsi/iscsi_target_nego.h b/drivers/target/iscsi/iscsi_target_nego.h
index 835e1b769b3f..ed30b9ee75e6 100644
--- a/drivers/target/iscsi/iscsi_target_nego.h
+++ b/drivers/target/iscsi/iscsi_target_nego.h
@@ -5,21 +5,21 @@
 #define DECIMAL         0
 #define HEX             1
 
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_login;
 struct iscsi_np;
 
 extern void convert_null_to_semi(char *, int);
 extern int extract_param(const char *, const char *, unsigned int, char *,
 		unsigned char *);
-extern int iscsi_target_check_login_request(struct iscsi_conn *,
+extern int iscsi_target_check_login_request(struct iscsit_conn *,
 		struct iscsi_login *);
-extern int iscsi_target_get_initial_payload(struct iscsi_conn *,
+extern int iscsi_target_get_initial_payload(struct iscsit_conn *,
 		struct iscsi_login *);
-extern int iscsi_target_locate_portal(struct iscsi_np *, struct iscsi_conn *,
+extern int iscsi_target_locate_portal(struct iscsi_np *, struct iscsit_conn *,
 		struct iscsi_login *);
 extern int iscsi_target_start_negotiation(
-		struct iscsi_login *, struct iscsi_conn *);
-extern void iscsi_target_nego_release(struct iscsi_conn *);
+		struct iscsi_login *, struct iscsit_conn *);
+extern void iscsi_target_nego_release(struct iscsit_conn *);
 
 #endif /* ISCSI_TARGET_NEGO_H */
diff --git a/drivers/target/iscsi/iscsi_target_nodeattrib.c b/drivers/target/iscsi/iscsi_target_nodeattrib.c
index e3ac247bffe8..36671af6332f 100644
--- a/drivers/target/iscsi/iscsi_target_nodeattrib.c
+++ b/drivers/target/iscsi/iscsi_target_nodeattrib.c
@@ -97,7 +97,7 @@ int iscsit_na_nopin_timeout(
 {
 	struct iscsi_node_attrib *a = &acl->node_attrib;
 	struct iscsi_session *sess;
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	struct se_node_acl *se_nacl = &a->nacl->se_node_acl;
 	struct se_session *se_sess;
 	u32 orig_nopin_timeout = a->nopin_timeout;
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 6bc3aaf655fc..2317fb077db0 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -15,7 +15,7 @@
 #include "iscsi_target_parameters.h"
 
 int iscsi_login_rx_data(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	char *buf,
 	int length)
 {
@@ -37,7 +37,7 @@ int iscsi_login_rx_data(
 }
 
 int iscsi_login_tx_data(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	char *pdu_buf,
 	char *text_buf,
 	int text_length)
@@ -955,7 +955,7 @@ static char *iscsi_check_valuelist_for_support(
 }
 
 static int iscsi_check_acceptor_state(struct iscsi_param *param, char *value,
-				struct iscsi_conn *conn)
+				struct iscsit_conn *conn)
 {
 	u8 acceptor_boolean_value = 0, proposer_boolean_value = 0;
 	char *negotiated_value = NULL;
@@ -1352,7 +1352,7 @@ int iscsi_decode_text_input(
 	u8 sender,
 	char *textbuf,
 	u32 length,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_param_list *param_list = conn->param_list;
 	char *tmpbuf, *start = NULL, *end = NULL;
diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index 240c4c4344f6..00fbbebb8c75 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -25,13 +25,13 @@ struct iscsi_param {
 	struct list_head p_list;
 } ____cacheline_aligned;
 
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_conn_ops;
 struct iscsi_param_list;
 struct iscsi_sess_ops;
 
-extern int iscsi_login_rx_data(struct iscsi_conn *, char *, int);
-extern int iscsi_login_tx_data(struct iscsi_conn *, char *, char *, int);
+extern int iscsi_login_rx_data(struct iscsit_conn *, char *, int);
+extern int iscsi_login_tx_data(struct iscsit_conn *, char *, char *, int);
 extern void iscsi_dump_conn_ops(struct iscsi_conn_ops *);
 extern void iscsi_dump_sess_ops(struct iscsi_sess_ops *);
 extern void iscsi_print_params(struct iscsi_param_list *);
@@ -45,7 +45,7 @@ extern void iscsi_release_param_list(struct iscsi_param_list *);
 extern struct iscsi_param *iscsi_find_param_from_key(char *, struct iscsi_param_list *);
 extern int iscsi_extract_key_value(char *, char **, char **);
 extern int iscsi_update_param_value(struct iscsi_param *, char *);
-extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsi_conn *);
+extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsit_conn *);
 extern int iscsi_encode_text_output(u8, u8, char *, u32 *,
 			struct iscsi_param_list *, bool);
 extern int iscsi_check_negotiated_keys(struct iscsi_param_list *);
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
index 98aee976d79c..326efd762db0 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
@@ -208,7 +208,7 @@ static void iscsit_determine_counts_for_list(
 	u32 burstlength = 0, offset = 0;
 	u32 unsolicited_data_length = 0;
 	u32 mdsl;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	if (cmd->se_cmd.data_direction == DMA_TO_DEVICE)
 		mdsl = cmd->conn->conn_ops->MaxXmitDataSegmentLength;
@@ -289,7 +289,7 @@ static int iscsit_do_build_pdu_and_seq_lists(
 	int check_immediate = 0, datapduinorder, datasequenceinorder;
 	u32 burstlength = 0, offset = 0, i = 0, mdsl;
 	u32 pdu_count = 0, seq_no = 0, unsolicited_data_length = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *pdu = cmd->pdu_list;
 	struct iscsi_seq *seq = cmd->seq_list;
 
@@ -489,7 +489,7 @@ int iscsit_build_pdu_and_seq_lists(
 {
 	struct iscsi_build_list bl;
 	u32 pdu_count = 0, seq_count = 1;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *pdu = NULL;
 	struct iscsi_seq *seq = NULL;
 
@@ -587,7 +587,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
 	struct iscsi_seq *seq)
 {
 	u32 i;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *pdu = NULL;
 
 	if (!cmd->pdu_list) {
diff --git a/drivers/target/iscsi/iscsi_target_tmr.c b/drivers/target/iscsi/iscsi_target_tmr.c
index aa062c3166c2..e3c3a08db1e0 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.c
+++ b/drivers/target/iscsi/iscsi_target_tmr.c
@@ -32,7 +32,7 @@ u8 iscsit_tmr_abort_task(
 	unsigned char *buf)
 {
 	struct iscsit_cmd *ref_cmd;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
 	struct iscsi_tm *hdr = (struct iscsi_tm *) buf;
@@ -63,7 +63,7 @@ u8 iscsit_tmr_abort_task(
  *	Called from iscsit_handle_task_mgt_cmd().
  */
 int iscsit_tmr_task_warm_reset(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_tmr_req *tmr_req,
 	unsigned char *buf)
 {
@@ -83,7 +83,7 @@ int iscsit_tmr_task_warm_reset(
 }
 
 int iscsit_tmr_task_cold_reset(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct iscsi_tmr_req *tmr_req,
 	unsigned char *buf)
 {
@@ -107,7 +107,7 @@ u8 iscsit_tmr_task_reassign(
 	unsigned char *buf)
 {
 	struct iscsit_cmd *ref_cmd = NULL;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_conn_recovery *cr = NULL;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -193,7 +193,7 @@ static void iscsit_task_reassign_remove_cmd(
 
 static int iscsit_task_reassign_complete_nop_out(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
@@ -229,7 +229,7 @@ static int iscsit_task_reassign_complete_write(
 {
 	int no_build_r2ts = 0;
 	u32 length = 0, offset = 0;
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	/*
 	 * The Initiator must not send a R2T SNACK with a Begrun less than
@@ -299,7 +299,7 @@ static int iscsit_task_reassign_complete_read(
 	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_datain_req *dr;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	/*
@@ -352,7 +352,7 @@ static int iscsit_task_reassign_complete_none(
 	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_STATUS;
 	iscsit_add_cmd_to_response_queue(cmd, conn, cmd->i_state);
@@ -361,7 +361,7 @@ static int iscsit_task_reassign_complete_none(
 
 static int iscsit_task_reassign_complete_scsi_cmnd(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
@@ -410,7 +410,7 @@ static int iscsit_task_reassign_complete_scsi_cmnd(
 
 static int iscsit_task_reassign_complete(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd;
 	int ret = 0;
@@ -451,7 +451,7 @@ static int iscsit_task_reassign_complete(
  *	Right now the only one that its really needed for is
  *	connection recovery releated TASK_REASSIGN.
  */
-int iscsit_tmr_post_handler(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_tmr_post_handler(struct iscsit_cmd *cmd, struct iscsit_conn *conn)
 {
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -469,14 +469,14 @@ EXPORT_SYMBOL(iscsit_tmr_post_handler);
  */
 static int iscsit_task_reassign_prepare_read(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	return 0;
 }
 
 static void iscsit_task_reassign_prepare_unsolicited_dataout(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	int i, j;
 	struct iscsi_pdu *pdu = NULL;
@@ -544,7 +544,7 @@ static void iscsit_task_reassign_prepare_unsolicited_dataout(
 
 static int iscsit_task_reassign_prepare_write(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_pdu *pdu = NULL;
@@ -777,7 +777,7 @@ static int iscsit_task_reassign_prepare_write(
  */
 int iscsit_check_task_reassign_expdatasn(
 	struct iscsi_tmr_req *tmr_req,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsit_cmd *ref_cmd = tmr_req->ref_cmd;
 
diff --git a/drivers/target/iscsi/iscsi_target_tmr.h b/drivers/target/iscsi/iscsi_target_tmr.h
index 60aac3a8f3c0..3413d0f596c8 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.h
+++ b/drivers/target/iscsi/iscsi_target_tmr.h
@@ -5,17 +5,17 @@
 #include <linux/types.h>
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_tmr_req;
 
 extern u8 iscsit_tmr_abort_task(struct iscsit_cmd *, unsigned char *);
-extern int iscsit_tmr_task_warm_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
+extern int iscsit_tmr_task_warm_reset(struct iscsit_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
-extern int iscsit_tmr_task_cold_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
+extern int iscsit_tmr_task_cold_reset(struct iscsit_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
 extern u8 iscsit_tmr_task_reassign(struct iscsit_cmd *, unsigned char *);
-extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsit_conn *);
 extern int iscsit_check_task_reassign_expdatasn(struct iscsi_tmr_req *,
-			struct iscsi_conn *);
+			struct iscsit_conn *);
 
 #endif /* ISCSI_TARGET_TMR_H */
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 39b705c34f95..be50f857d1b1 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -152,7 +152,7 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
  * May be called from software interrupt (timer) context for allocating
  * iSCSI NopINs.
  */
-struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
+struct iscsit_cmd *iscsit_allocate_cmd(struct iscsit_conn *conn, int state)
 {
 	struct iscsit_cmd *cmd;
 	struct se_session *se_sess = conn->sess->se_sess;
@@ -282,7 +282,7 @@ static inline int iscsit_check_received_cmdsn(struct iscsi_session *sess, u32 cm
  * Commands may be received out of order if MC/S is in use.
  * Ensure they are executed in CmdSN order.
  */
-int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+int iscsit_sequence_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf, __be32 cmdsn)
 {
 	int ret, cmdsn_ret;
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(iscsit_sequence_cmd);
 
 int iscsit_check_unsolicited_dataout(struct iscsit_cmd *cmd, unsigned char *buf)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct iscsi_data *hdr = (struct iscsi_data *) buf;
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -378,7 +378,7 @@ int iscsit_check_unsolicited_dataout(struct iscsit_cmd *cmd, unsigned char *buf)
 }
 
 struct iscsit_cmd *iscsit_find_cmd_from_itt(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	itt_t init_task_tag)
 {
 	struct iscsit_cmd *cmd;
@@ -399,7 +399,7 @@ struct iscsit_cmd *iscsit_find_cmd_from_itt(
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt);
 
 struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	itt_t init_task_tag,
 	u32 length)
 {
@@ -426,7 +426,7 @@ struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt_or_dump);
 
 struct iscsit_cmd *iscsit_find_cmd_from_ttt(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u32 targ_xfer_tag)
 {
 	struct iscsit_cmd *cmd = NULL;
@@ -499,7 +499,7 @@ int iscsit_find_cmd_for_recovery(
 
 void iscsit_add_cmd_to_immediate_queue(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 state)
 {
 	struct iscsi_queue_req *qr;
@@ -524,7 +524,7 @@ void iscsit_add_cmd_to_immediate_queue(
 }
 EXPORT_SYMBOL(iscsit_add_cmd_to_immediate_queue);
 
-struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *conn)
+struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsit_conn *conn)
 {
 	struct iscsi_queue_req *qr;
 
@@ -546,7 +546,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *c
 
 static void iscsit_remove_cmd_from_immediate_queue(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
 
@@ -575,7 +575,7 @@ static void iscsit_remove_cmd_from_immediate_queue(
 
 int iscsit_add_cmd_to_response_queue(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 state)
 {
 	struct iscsi_queue_req *qr;
@@ -599,7 +599,7 @@ int iscsit_add_cmd_to_response_queue(
 	return 0;
 }
 
-struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *conn)
+struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsit_conn *conn)
 {
 	struct iscsi_queue_req *qr;
 
@@ -622,7 +622,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *co
 
 static void iscsit_remove_cmd_from_response_queue(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
 
@@ -650,7 +650,7 @@ static void iscsit_remove_cmd_from_response_queue(
 	}
 }
 
-bool iscsit_conn_all_queues_empty(struct iscsi_conn *conn)
+bool iscsit_conn_all_queues_empty(struct iscsit_conn *conn)
 {
 	bool empty;
 
@@ -668,7 +668,7 @@ bool iscsit_conn_all_queues_empty(struct iscsi_conn *conn)
 	return empty;
 }
 
-void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *conn)
+void iscsit_free_queue_reqs_for_conn(struct iscsit_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
 
@@ -722,7 +722,7 @@ EXPORT_SYMBOL(iscsit_release_cmd);
 
 void __iscsit_free_cmd(struct iscsit_cmd *cmd, bool check_queues)
 {
-	struct iscsi_conn *conn = cmd->conn;
+	struct iscsit_conn *conn = cmd->conn;
 
 	WARN_ON(!list_empty(&cmd->i_conn_node));
 
@@ -798,9 +798,9 @@ void iscsit_inc_session_usage_count(struct iscsi_session *sess)
 	spin_unlock_bh(&sess->session_usage_lock);
 }
 
-struct iscsi_conn *iscsit_get_conn_from_cid(struct iscsi_session *sess, u16 cid)
+struct iscsit_conn *iscsit_get_conn_from_cid(struct iscsi_session *sess, u16 cid)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 
 	spin_lock_bh(&sess->conn_lock);
 	list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
@@ -816,9 +816,9 @@ struct iscsi_conn *iscsit_get_conn_from_cid(struct iscsi_session *sess, u16 cid)
 	return NULL;
 }
 
-struct iscsi_conn *iscsit_get_conn_from_cid_rcfr(struct iscsi_session *sess, u16 cid)
+struct iscsit_conn *iscsit_get_conn_from_cid_rcfr(struct iscsi_session *sess, u16 cid)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 
 	spin_lock_bh(&sess->conn_lock);
 	list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
@@ -836,7 +836,7 @@ struct iscsi_conn *iscsit_get_conn_from_cid_rcfr(struct iscsi_session *sess, u16
 	return NULL;
 }
 
-void iscsit_check_conn_usage_count(struct iscsi_conn *conn)
+void iscsit_check_conn_usage_count(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->conn_usage_lock);
 	if (conn->conn_usage_count != 0) {
@@ -849,7 +849,7 @@ void iscsit_check_conn_usage_count(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->conn_usage_lock);
 }
 
-void iscsit_dec_conn_usage_count(struct iscsi_conn *conn)
+void iscsit_dec_conn_usage_count(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->conn_usage_lock);
 	conn->conn_usage_count--;
@@ -860,14 +860,14 @@ void iscsit_dec_conn_usage_count(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->conn_usage_lock);
 }
 
-void iscsit_inc_conn_usage_count(struct iscsi_conn *conn)
+void iscsit_inc_conn_usage_count(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->conn_usage_lock);
 	conn->conn_usage_count++;
 	spin_unlock_bh(&conn->conn_usage_lock);
 }
 
-static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
+static int iscsit_add_nopin(struct iscsit_conn *conn, int want_response)
 {
 	u8 state;
 	struct iscsit_cmd *cmd;
@@ -895,7 +895,7 @@ static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
 
 void iscsit_handle_nopin_response_timeout(struct timer_list *t)
 {
-	struct iscsi_conn *conn = from_timer(conn, t, nopin_response_timer);
+	struct iscsit_conn *conn = from_timer(conn, t, nopin_response_timer);
 	struct iscsi_session *sess = conn->sess;
 
 	iscsit_inc_conn_usage_count(conn);
@@ -919,7 +919,7 @@ void iscsit_handle_nopin_response_timeout(struct timer_list *t)
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void iscsit_mod_nopin_response_timer(struct iscsi_conn *conn)
+void iscsit_mod_nopin_response_timer(struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_attrib *na = iscsit_tpg_get_node_attrib(sess);
@@ -935,7 +935,7 @@ void iscsit_mod_nopin_response_timer(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->nopin_timer_lock);
 }
 
-void iscsit_start_nopin_response_timer(struct iscsi_conn *conn)
+void iscsit_start_nopin_response_timer(struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_attrib *na = iscsit_tpg_get_node_attrib(sess);
@@ -956,7 +956,7 @@ void iscsit_start_nopin_response_timer(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->nopin_timer_lock);
 }
 
-void iscsit_stop_nopin_response_timer(struct iscsi_conn *conn)
+void iscsit_stop_nopin_response_timer(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->nopin_timer_lock);
 	if (!(conn->nopin_response_timer_flags & ISCSI_TF_RUNNING)) {
@@ -975,7 +975,7 @@ void iscsit_stop_nopin_response_timer(struct iscsi_conn *conn)
 
 void iscsit_handle_nopin_timeout(struct timer_list *t)
 {
-	struct iscsi_conn *conn = from_timer(conn, t, nopin_timer);
+	struct iscsit_conn *conn = from_timer(conn, t, nopin_timer);
 
 	iscsit_inc_conn_usage_count(conn);
 
@@ -992,7 +992,7 @@ void iscsit_handle_nopin_timeout(struct timer_list *t)
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void __iscsit_start_nopin_timer(struct iscsi_conn *conn)
+void __iscsit_start_nopin_timer(struct iscsit_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_attrib *na = iscsit_tpg_get_node_attrib(sess);
@@ -1016,14 +1016,14 @@ void __iscsit_start_nopin_timer(struct iscsi_conn *conn)
 		" interval\n", conn->cid, na->nopin_timeout);
 }
 
-void iscsit_start_nopin_timer(struct iscsi_conn *conn)
+void iscsit_start_nopin_timer(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->nopin_timer_lock);
 	__iscsit_start_nopin_timer(conn);
 	spin_unlock_bh(&conn->nopin_timer_lock);
 }
 
-void iscsit_stop_nopin_timer(struct iscsi_conn *conn)
+void iscsit_stop_nopin_timer(struct iscsit_conn *conn)
 {
 	spin_lock_bh(&conn->nopin_timer_lock);
 	if (!(conn->nopin_timer_flags & ISCSI_TF_RUNNING)) {
@@ -1042,7 +1042,7 @@ void iscsit_stop_nopin_timer(struct iscsi_conn *conn)
 
 int iscsit_send_tx_data(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	int use_misc)
 {
 	int tx_sent, tx_size;
@@ -1075,7 +1075,7 @@ int iscsit_send_tx_data(
 
 int iscsit_fe_sendpage_sg(
 	struct iscsit_cmd *cmd,
-	struct iscsi_conn *conn)
+	struct iscsit_conn *conn)
 {
 	struct scatterlist *sg = cmd->first_data_sg;
 	struct kvec iov;
@@ -1179,7 +1179,7 @@ int iscsit_fe_sendpage_sg(
  *      Parameters:     iSCSI Connection, Status Class, Status Detail.
  *      Returns:        0 on success, -1 on error.
  */
-int iscsit_tx_login_rsp(struct iscsi_conn *conn, u8 status_class, u8 status_detail)
+int iscsit_tx_login_rsp(struct iscsit_conn *conn, u8 status_class, u8 status_detail)
 {
 	struct iscsi_login_rsp *hdr;
 	struct iscsi_login *login = conn->conn_login;
@@ -1200,7 +1200,7 @@ int iscsit_tx_login_rsp(struct iscsi_conn *conn, u8 status_class, u8 status_deta
 
 void iscsit_print_session_params(struct iscsi_session *sess)
 {
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 
 	pr_debug("-----------------------------[Session Params for"
 		" SID: %u]-----------------------------\n", sess->sid);
@@ -1213,7 +1213,7 @@ void iscsit_print_session_params(struct iscsi_session *sess)
 }
 
 int rx_data(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct kvec *iov,
 	int iov_count,
 	int data)
@@ -1243,7 +1243,7 @@ int rx_data(
 }
 
 int tx_data(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	struct kvec *iov,
 	int iov_count,
 	int data)
@@ -1279,7 +1279,7 @@ int tx_data(
 }
 
 void iscsit_collect_login_stats(
-	struct iscsi_conn *conn,
+	struct iscsit_conn *conn,
 	u8 status_class,
 	u8 status_detail)
 {
@@ -1334,7 +1334,7 @@ void iscsit_collect_login_stats(
 	spin_unlock(&ls->lock);
 }
 
-struct iscsi_tiqn *iscsit_snmp_get_tiqn(struct iscsi_conn *conn)
+struct iscsi_tiqn *iscsit_snmp_get_tiqn(struct iscsit_conn *conn)
 {
 	struct iscsi_portal_group *tpg;
 
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index dec142ed4704..dcdcdfe4fd7e 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -8,7 +8,7 @@
 #define MARKER_SIZE	8
 
 struct iscsit_cmd;
-struct iscsi_conn;
+struct iscsit_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
@@ -17,56 +17,56 @@ extern struct iscsi_r2t *iscsit_get_r2t_for_eos(struct iscsit_cmd *, u32, u32);
 extern struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsit_cmd *);
 extern void iscsit_free_r2t(struct iscsi_r2t *, struct iscsit_cmd *);
 extern void iscsit_free_r2ts_from_list(struct iscsit_cmd *);
-extern struct iscsit_cmd *iscsit_alloc_cmd(struct iscsi_conn *, gfp_t);
-extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
+extern struct iscsit_cmd *iscsit_alloc_cmd(struct iscsit_conn *, gfp_t);
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsit_conn *, int);
 extern struct iscsi_seq *iscsit_get_seq_holder_for_datain(struct iscsit_cmd *, u32);
 extern struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsit_cmd *);
 extern struct iscsi_r2t *iscsit_get_holder_for_r2tsn(struct iscsit_cmd *, u32);
-extern int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
+extern int iscsit_sequence_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			       unsigned char * ,__be32 cmdsn);
 extern int iscsit_check_unsolicited_dataout(struct iscsit_cmd *, unsigned char *);
-extern struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *,
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsit_conn *,
 			itt_t, u32);
-extern struct iscsit_cmd *iscsit_find_cmd_from_ttt(struct iscsi_conn *, u32);
+extern struct iscsit_cmd *iscsit_find_cmd_from_ttt(struct iscsit_conn *, u32);
 extern int iscsit_find_cmd_for_recovery(struct iscsi_session *, struct iscsit_cmd **,
 			struct iscsi_conn_recovery **, itt_t);
-extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
-extern struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *);
-extern int iscsit_add_cmd_to_response_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
-extern struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *);
-extern void iscsit_remove_cmd_from_tx_queues(struct iscsit_cmd *, struct iscsi_conn *);
-extern bool iscsit_conn_all_queues_empty(struct iscsi_conn *);
-extern void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *);
+extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *, struct iscsit_conn *, u8);
+extern struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsit_conn *);
+extern int iscsit_add_cmd_to_response_queue(struct iscsit_cmd *, struct iscsit_conn *, u8);
+extern struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsit_conn *);
+extern void iscsit_remove_cmd_from_tx_queues(struct iscsit_cmd *, struct iscsit_conn *);
+extern bool iscsit_conn_all_queues_empty(struct iscsit_conn *);
+extern void iscsit_free_queue_reqs_for_conn(struct iscsit_conn *);
 extern void iscsit_release_cmd(struct iscsit_cmd *);
 extern void __iscsit_free_cmd(struct iscsit_cmd *, bool);
 extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
 extern bool iscsit_check_session_usage_count(struct iscsi_session *sess, bool can_sleep);
 extern void iscsit_dec_session_usage_count(struct iscsi_session *);
 extern void iscsit_inc_session_usage_count(struct iscsi_session *);
-extern struct iscsi_conn *iscsit_get_conn_from_cid(struct iscsi_session *, u16);
-extern struct iscsi_conn *iscsit_get_conn_from_cid_rcfr(struct iscsi_session *, u16);
-extern void iscsit_check_conn_usage_count(struct iscsi_conn *);
-extern void iscsit_dec_conn_usage_count(struct iscsi_conn *);
-extern void iscsit_inc_conn_usage_count(struct iscsi_conn *);
+extern struct iscsit_conn *iscsit_get_conn_from_cid(struct iscsi_session *, u16);
+extern struct iscsit_conn *iscsit_get_conn_from_cid_rcfr(struct iscsi_session *, u16);
+extern void iscsit_check_conn_usage_count(struct iscsit_conn *);
+extern void iscsit_dec_conn_usage_count(struct iscsit_conn *);
+extern void iscsit_inc_conn_usage_count(struct iscsit_conn *);
 extern void iscsit_handle_nopin_response_timeout(struct timer_list *t);
-extern void iscsit_mod_nopin_response_timer(struct iscsi_conn *);
-extern void iscsit_start_nopin_response_timer(struct iscsi_conn *);
-extern void iscsit_stop_nopin_response_timer(struct iscsi_conn *);
+extern void iscsit_mod_nopin_response_timer(struct iscsit_conn *);
+extern void iscsit_start_nopin_response_timer(struct iscsit_conn *);
+extern void iscsit_stop_nopin_response_timer(struct iscsit_conn *);
 extern void iscsit_handle_nopin_timeout(struct timer_list *t);
-extern void __iscsit_start_nopin_timer(struct iscsi_conn *);
-extern void iscsit_start_nopin_timer(struct iscsi_conn *);
-extern void iscsit_stop_nopin_timer(struct iscsi_conn *);
-extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsi_conn *, int);
-extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsi_conn *);
-extern int iscsit_tx_login_rsp(struct iscsi_conn *, u8, u8);
+extern void __iscsit_start_nopin_timer(struct iscsit_conn *);
+extern void iscsit_start_nopin_timer(struct iscsit_conn *);
+extern void iscsit_stop_nopin_timer(struct iscsit_conn *);
+extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsit_conn *, int);
+extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsit_conn *);
+extern int iscsit_tx_login_rsp(struct iscsit_conn *, u8, u8);
 extern void iscsit_print_session_params(struct iscsi_session *);
 extern int iscsit_print_dev_to_proc(char *, char **, off_t, int);
 extern int iscsit_print_sessions_to_proc(char *, char **, off_t, int);
 extern int iscsit_print_tpg_to_proc(char *, char **, off_t, int);
-extern int rx_data(struct iscsi_conn *, struct kvec *, int, int);
-extern int tx_data(struct iscsi_conn *, struct kvec *, int, int);
-extern void iscsit_collect_login_stats(struct iscsi_conn *, u8, u8);
-extern struct iscsi_tiqn *iscsit_snmp_get_tiqn(struct iscsi_conn *);
+extern int rx_data(struct iscsit_conn *, struct kvec *, int, int);
+extern int tx_data(struct iscsit_conn *, struct kvec *, int, int);
+extern void iscsit_collect_login_stats(struct iscsit_conn *, u8, u8);
+extern struct iscsi_tiqn *iscsit_snmp_get_tiqn(struct iscsit_conn *);
 extern void iscsit_fill_cxn_timeout_err_stats(struct iscsi_session *);
 
 #endif /*** ISCSI_TARGET_UTIL_H ***/
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 4f9ef2899488..76581e0f3d98 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -478,7 +478,7 @@ struct iscsit_cmd {
 	/* TMR Request when iscsi_opcode == ISCSI_OP_SCSI_TMFUNC */
 	struct iscsi_tmr_req	*tmr_req;
 	/* Connection this command is alligient to */
-	struct iscsi_conn	*conn;
+	struct iscsit_conn	*conn;
 	/* Pointer to connection recovery entry */
 	struct iscsi_conn_recovery *cr;
 	/* Session the command is part of,  used for connection recovery */
@@ -508,7 +508,7 @@ struct iscsi_tmr_req {
 	struct se_tmr_req	*se_tmr_req;
 };
 
-struct iscsi_conn {
+struct iscsit_conn {
 	wait_queue_head_t	queues_wq;
 	/* Authentication Successful for this connection */
 	u8			auth_complete;
@@ -710,7 +710,7 @@ struct iscsi_login {
 	char rsp[ISCSI_HDR_LEN];
 	char *req_buf;
 	char *rsp_buf;
-	struct iscsi_conn *conn;
+	struct iscsit_conn *conn;
 	struct iscsi_np *np;
 } ____cacheline_aligned;
 
@@ -898,9 +898,9 @@ static inline u32 session_get_next_ttt(struct iscsi_session *session)
 	return ttt;
 }
 
-extern struct iscsit_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt(struct iscsit_conn *, itt_t);
 
-extern void iscsit_thread_check_cpumask(struct iscsi_conn *conn,
+extern void iscsit_thread_check_cpumask(struct iscsit_conn *conn,
 					struct task_struct *p,
 					int mode);
 
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index 645de3542022..2ab26bb6f808 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -12,26 +12,26 @@ struct iscsit_transport {
 	struct module *owner;
 	struct list_head t_node;
 	int (*iscsit_setup_np)(struct iscsi_np *, struct sockaddr_storage *);
-	int (*iscsit_accept_np)(struct iscsi_np *, struct iscsi_conn *);
+	int (*iscsit_accept_np)(struct iscsi_np *, struct iscsit_conn *);
 	void (*iscsit_free_np)(struct iscsi_np *);
-	void (*iscsit_wait_conn)(struct iscsi_conn *);
-	void (*iscsit_free_conn)(struct iscsi_conn *);
-	int (*iscsit_get_login_rx)(struct iscsi_conn *, struct iscsi_login *);
-	int (*iscsit_put_login_tx)(struct iscsi_conn *, struct iscsi_login *, u32);
-	int (*iscsit_immediate_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
-	int (*iscsit_response_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
-	int (*iscsit_get_dataout)(struct iscsi_conn *, struct iscsit_cmd *, bool);
-	int (*iscsit_queue_data_in)(struct iscsi_conn *, struct iscsit_cmd *);
-	int (*iscsit_queue_status)(struct iscsi_conn *, struct iscsit_cmd *);
-	void (*iscsit_aborted_task)(struct iscsi_conn *, struct iscsit_cmd *);
-	int (*iscsit_xmit_pdu)(struct iscsi_conn *, struct iscsit_cmd *,
+	void (*iscsit_wait_conn)(struct iscsit_conn *);
+	void (*iscsit_free_conn)(struct iscsit_conn *);
+	int (*iscsit_get_login_rx)(struct iscsit_conn *, struct iscsi_login *);
+	int (*iscsit_put_login_tx)(struct iscsit_conn *, struct iscsi_login *, u32);
+	int (*iscsit_immediate_queue)(struct iscsit_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_response_queue)(struct iscsit_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_get_dataout)(struct iscsit_conn *, struct iscsit_cmd *, bool);
+	int (*iscsit_queue_data_in)(struct iscsit_conn *, struct iscsit_cmd *);
+	int (*iscsit_queue_status)(struct iscsit_conn *, struct iscsit_cmd *);
+	void (*iscsit_aborted_task)(struct iscsit_conn *, struct iscsit_cmd *);
+	int (*iscsit_xmit_pdu)(struct iscsit_conn *, struct iscsit_cmd *,
 			       struct iscsi_datain_req *, const void *, u32);
-	void (*iscsit_unmap_cmd)(struct iscsi_conn *, struct iscsit_cmd *);
-	void (*iscsit_get_rx_pdu)(struct iscsi_conn *);
-	int (*iscsit_validate_params)(struct iscsi_conn *);
-	void (*iscsit_get_r2t_ttt)(struct iscsi_conn *, struct iscsit_cmd *,
+	void (*iscsit_unmap_cmd)(struct iscsit_conn *, struct iscsit_cmd *);
+	void (*iscsit_get_rx_pdu)(struct iscsit_conn *);
+	int (*iscsit_validate_params)(struct iscsit_conn *);
+	void (*iscsit_get_r2t_ttt)(struct iscsit_conn *, struct iscsit_cmd *,
 				   struct iscsi_r2t *);
-	enum target_prot_op (*iscsit_get_sup_prot_ops)(struct iscsi_conn *);
+	enum target_prot_op (*iscsit_get_sup_prot_ops)(struct iscsit_conn *);
 };
 
 static inline void *iscsit_priv_cmd(struct iscsit_cmd *cmd)
@@ -51,57 +51,57 @@ extern void iscsit_put_transport(struct iscsit_transport *);
 /*
  * From iscsi_target.c
  */
-extern int iscsit_setup_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_setup_scsi_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				unsigned char *);
 extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
-extern int iscsit_process_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_process_scsi_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				struct iscsi_scsi_req *);
 extern int
-__iscsit_check_dataout_hdr(struct iscsi_conn *, void *,
+__iscsit_check_dataout_hdr(struct iscsit_conn *, void *,
 			   struct iscsit_cmd *, u32, bool *);
 extern int
-iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
+iscsit_check_dataout_hdr(struct iscsit_conn *conn, void *buf,
 			 struct iscsit_cmd **out_cmd);
 extern int iscsit_check_dataout_payload(struct iscsit_cmd *, struct iscsi_data *,
 				bool);
-extern int iscsit_setup_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_setup_nop_out(struct iscsit_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_process_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_process_nop_out(struct iscsit_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_handle_logout_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_handle_logout_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_handle_task_mgt_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_handle_task_mgt_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_setup_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_setup_text_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				 struct iscsi_text *);
-extern int iscsit_process_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_process_text_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				   struct iscsi_text *);
-extern void iscsit_build_rsp_pdu(struct iscsit_cmd *, struct iscsi_conn *,
+extern void iscsit_build_rsp_pdu(struct iscsit_cmd *, struct iscsit_conn *,
 				bool, struct iscsi_scsi_rsp *);
-extern void iscsit_build_nopin_rsp(struct iscsit_cmd *, struct iscsi_conn *,
+extern void iscsit_build_nopin_rsp(struct iscsit_cmd *, struct iscsit_conn *,
 				struct iscsi_nopin *, bool);
-extern void iscsit_build_task_mgt_rsp(struct iscsit_cmd *, struct iscsi_conn *,
+extern void iscsit_build_task_mgt_rsp(struct iscsit_cmd *, struct iscsit_conn *,
 				struct iscsi_tm_rsp *);
-extern int iscsit_build_text_rsp(struct iscsit_cmd *, struct iscsi_conn *,
+extern int iscsit_build_text_rsp(struct iscsit_cmd *, struct iscsit_conn *,
 				struct iscsi_text_rsp *,
 				enum iscsit_transport_type);
-extern void iscsit_build_reject(struct iscsit_cmd *, struct iscsi_conn *,
+extern void iscsit_build_reject(struct iscsit_cmd *, struct iscsit_conn *,
 				struct iscsi_reject *);
-extern int iscsit_build_logout_rsp(struct iscsit_cmd *, struct iscsi_conn *,
+extern int iscsit_build_logout_rsp(struct iscsit_cmd *, struct iscsit_conn *,
 				struct iscsi_logout_rsp *);
-extern int iscsit_logout_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
-extern int iscsit_queue_rsp(struct iscsi_conn *, struct iscsit_cmd *);
-extern void iscsit_aborted_task(struct iscsi_conn *, struct iscsit_cmd *);
-extern int iscsit_add_reject(struct iscsi_conn *, u8, unsigned char *);
+extern int iscsit_logout_post_handler(struct iscsit_cmd *, struct iscsit_conn *);
+extern int iscsit_queue_rsp(struct iscsit_conn *, struct iscsit_cmd *);
+extern void iscsit_aborted_task(struct iscsit_conn *, struct iscsit_cmd *);
+extern int iscsit_add_reject(struct iscsit_conn *, u8, unsigned char *);
 extern int iscsit_reject_cmd(struct iscsit_cmd *, u8, unsigned char *);
-extern int iscsit_handle_snack(struct iscsi_conn *, unsigned char *);
-extern void iscsit_build_datain_pdu(struct iscsit_cmd *, struct iscsi_conn *,
+extern int iscsit_handle_snack(struct iscsit_conn *, unsigned char *);
+extern void iscsit_build_datain_pdu(struct iscsit_cmd *, struct iscsit_conn *,
 				    struct iscsi_datain *,
 				    struct iscsi_data_rsp *, bool);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern int iscsit_build_r2ts_for_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 				     bool);
-extern int iscsit_immediate_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
-extern int iscsit_response_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
+extern int iscsit_immediate_queue(struct iscsit_conn *, struct iscsit_cmd *, int);
+extern int iscsit_response_queue(struct iscsit_conn *, struct iscsit_cmd *, int);
 /*
  * From iscsi_target_device.c
  */
@@ -109,7 +109,7 @@ extern void iscsit_increment_maxcmdsn(struct iscsit_cmd *, struct iscsi_session
 /*
  * From iscsi_target_erl0.c
  */
-extern void iscsit_cause_connection_reinstatement(struct iscsi_conn *, int);
+extern void iscsit_cause_connection_reinstatement(struct iscsit_conn *, int);
 /*
  * From iscsi_target_erl1.c
  */
@@ -118,33 +118,33 @@ extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 /*
  * From iscsi_target_tmr.c
  */
-extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsit_conn *);
 
 /*
  * From iscsi_target_util.c
  */
-extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
-extern int iscsit_sequence_cmd(struct iscsi_conn *, struct iscsit_cmd *,
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsit_conn *, int);
+extern int iscsit_sequence_cmd(struct iscsit_conn *, struct iscsit_cmd *,
 			       unsigned char *, __be32);
 extern void iscsit_release_cmd(struct iscsit_cmd *);
 extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
 extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *,
-					      struct iscsi_conn *, u8);
+					      struct iscsit_conn *, u8);
 extern struct iscsit_cmd *
-iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *conn,
+iscsit_find_cmd_from_itt_or_dump(struct iscsit_conn *conn,
 				 itt_t init_task_tag, u32 length);
 
 /*
  * From iscsi_target_nego.c
  */
-extern int iscsi_target_check_login_request(struct iscsi_conn *,
+extern int iscsi_target_check_login_request(struct iscsit_conn *,
 					    struct iscsi_login *);
 
 /*
  * From iscsi_target_login.c
  */
 extern __printf(2, 3) int iscsi_change_param_sprintf(
-	struct iscsi_conn *, const char *, ...);
+	struct iscsit_conn *, const char *, ...);
 
 /*
  * From iscsi_target_parameters.c
-- 
2.18.2

