Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478AD420621
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Oct 2021 08:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJDHBB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Oct 2021 03:01:01 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57718 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232579AbhJDHBA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Oct 2021 03:01:00 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 193Msask002324;
        Sun, 3 Oct 2021 23:59:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=qhEtSRoQo00KrzQr+YZLwGTiDcLARpPWmJq+7pSgcSI=;
 b=gLmmimMoeeb968P0CJ0uMcaqvS/KsQgaG/hj8T7E9GP5qbgz3GVqIN3MOK7wgBuMDxg/
 f46YO0/3M+UmgvPSBvAqaHrhVpAQuwDY5n8cS9C63jQp1GdwEAozca8Zc28D7W4nZ0hE
 yKlN8I+67eWrVFzns/xcuLSJwUyUBiSE74snzqOyS8DKQqGbmJzq9PVPmaJ6jBatCUFG
 1xvOn4xsKmBtkCrlxSRBELglKSOi9mTGx6gl4LteV7hX2MsdM1BgdKyGD2+Ekscup2XV
 dWGMvYz/gJ+9ZGk/yvJAEfEgqF+i1HJUAPl6/w0Xca4OtiGxyxe9Cfg4sQVpxgaC9TwR +A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bfc9y9uh8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 23:59:04 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 3 Oct
 2021 23:59:02 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Sun, 3 Oct 2021 23:58:59 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH v2 01/13] qed: Fix kernel-doc warnings
Date:   Mon, 4 Oct 2021 09:58:39 +0300
Message-ID: <20211004065851.1903-2-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20211004065851.1903-1-pkushwaha@marvell.com>
References: <20211004065851.1903-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: xo-yESl0chsmQ7EJMWIKwem-bVmsE4Ic
X-Proofpoint-ORIG-GUID: xo-yESl0chsmQ7EJMWIKwem-bVmsE4Ic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_02,2021-10-01_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes all the qed and qede kernel-doc warnings
according to the guidelines that are described in
Documentation/doc-guide/kernel-doc.rst.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |   9 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.h     | 138 +--
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h | 343 ++++---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     | 956 +++++++++---------
 drivers/net/ethernet/qlogic/qed/qed_hw.h      | 222 ++--
 .../net/ethernet/qlogic/qed/qed_init_ops.h    |  58 +-
 drivers/net/ethernet/qlogic/qed/qed_int.h     | 284 +++---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.h   |   9 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h      | 134 +--
 drivers/net/ethernet/qlogic/qed/qed_ll2.h     | 130 +--
 drivers/net/ethernet/qlogic/qed/qed_mcp.h     | 757 +++++++-------
 .../net/ethernet/qlogic/qed/qed_selftest.h    |  30 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h      | 215 ++--
 drivers/net/ethernet/qlogic/qed/qed_sriov.h   |  99 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.h      | 301 +++---
 drivers/net/ethernet/qlogic/qede/qede_main.c  |   5 +-
 include/linux/qed/qed_chain.h                 |  97 +-
 include/linux/qed/qed_if.h                    | 255 ++---
 include/linux/qed/qed_iscsi_if.h              |   2 +-
 include/linux/qed/qed_ll2_if.h                |  42 +-
 include/linux/qed/qed_nvmetcp_if.h            |  17 +
 21 files changed, 2186 insertions(+), 1917 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index d58e021614cd..b656408b9d70 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -877,12 +877,13 @@ u32 qed_get_hsi_def_val(struct qed_dev *cdev, enum qed_hsi_def_type type);
 
 
 /**
- * @brief qed_concrete_to_sw_fid - get the sw function id from
- *        the concrete value.
+ * qed_concrete_to_sw_fid(): Get the sw function id from
+ *                           the concrete value.
  *
- * @param concrete_fid
+ * @cdev: Qed dev pointer.
+ * @concrete_fid: Concrete fid.
  *
- * @return inline u8
+ * Return: inline u8.
  */
 static inline u8 qed_concrete_to_sw_fid(struct qed_dev *cdev,
 					u32 concrete_fid)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.h b/drivers/net/ethernet/qlogic/qed/qed_cxt.h
index 8adb7ed0c12d..d31196db7bdd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.h
@@ -28,24 +28,23 @@ struct qed_tid_mem {
 };
 
 /**
- * @brief qedo_cid_get_cxt_info - Returns the context info for a specific cid
+ * qed_cxt_get_cid_info(): Returns the context info for a specific cidi.
  *
+ * @p_hwfn: HW device data.
+ * @p_info: In/out.
  *
- * @param p_hwfn
- * @param p_info in/out
- *
- * @return int
+ * Return: Int.
  */
 int qed_cxt_get_cid_info(struct qed_hwfn *p_hwfn,
 			 struct qed_cxt_info *p_info);
 
 /**
- * @brief qed_cxt_get_tid_mem_info
+ * qed_cxt_get_tid_mem_info(): Returns the tid mem info.
  *
- * @param p_hwfn
- * @param p_info
+ * @p_hwfn: HW device data.
+ * @p_info: in/out.
  *
- * @return int
+ * Return: int.
  */
 int qed_cxt_get_tid_mem_info(struct qed_hwfn *p_hwfn,
 			     struct qed_tid_mem *p_info);
@@ -64,142 +63,155 @@ u32 qed_cxt_get_proto_cid_count(struct qed_hwfn *p_hwfn,
 				enum protocol_type type, u32 *vf_cid);
 
 /**
- * @brief qed_cxt_set_pf_params - Set the PF params for cxt init
+ * qed_cxt_set_pf_params(): Set the PF params for cxt init.
+ *
+ * @p_hwfn: HW device data.
+ * @rdma_tasks: Requested maximum.
  *
- * @param p_hwfn
- * @param rdma_tasks - requested maximum
- * @return int
+ * Return: int.
  */
 int qed_cxt_set_pf_params(struct qed_hwfn *p_hwfn, u32 rdma_tasks);
 
 /**
- * @brief qed_cxt_cfg_ilt_compute - compute ILT init parameters
+ * qed_cxt_cfg_ilt_compute(): Compute ILT init parameters.
  *
- * @param p_hwfn
- * @param last_line
+ * @p_hwfn: HW device data.
+ * @last_line: Last_line.
  *
- * @return int
+ * Return: Int
  */
 int qed_cxt_cfg_ilt_compute(struct qed_hwfn *p_hwfn, u32 *last_line);
 
 /**
- * @brief qed_cxt_cfg_ilt_compute_excess - how many lines can be decreased
+ * qed_cxt_cfg_ilt_compute_excess(): How many lines can be decreased.
+ *
+ * @p_hwfn: HW device data.
+ * @used_lines: Used lines.
  *
- * @param p_hwfn
- * @param used_lines
+ * Return: Int.
  */
 u32 qed_cxt_cfg_ilt_compute_excess(struct qed_hwfn *p_hwfn, u32 used_lines);
 
 /**
- * @brief qed_cxt_mngr_alloc - Allocate and init the context manager struct
+ * qed_cxt_mngr_alloc(): Allocate and init the context manager struct.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_cxt_mngr_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_cxt_mngr_free
+ * qed_cxt_mngr_free() - Context manager free.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_cxt_mngr_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_cxt_tables_alloc - Allocate ILT shadow, Searcher T2, acquired map
+ * qed_cxt_tables_alloc(): Allocate ILT shadow, Searcher T2, acquired map.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_cxt_tables_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_cxt_mngr_setup - Reset the acquired CIDs
+ * qed_cxt_mngr_setup(): Reset the acquired CIDs.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  */
 void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_cxt_hw_init_common - Initailze ILT and DQ, common phase, per path.
- *
+ * qed_cxt_hw_init_common(): Initailze ILT and DQ, common phase, per path.
  *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_cxt_hw_init_common(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_cxt_hw_init_pf - Initailze ILT and DQ, PF phase, per path.
+ * qed_cxt_hw_init_pf(): Initailze ILT and DQ, PF phase, per path.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Void.
  */
 void qed_cxt_hw_init_pf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_qm_init_pf - Initailze the QM PF phase, per path
+ * qed_qm_init_pf(): Initailze the QM PF phase, per path.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @is_pf_loading: Is pf pending.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param is_pf_loading
+ * Return: Void.
  */
 void qed_qm_init_pf(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt, bool is_pf_loading);
 
 /**
- * @brief Reconfigures QM pf on the fly
+ * qed_qm_reconf(): Reconfigures QM pf on the fly.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int
+ * Return: Int.
  */
 int qed_qm_reconf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 #define QED_CXT_PF_CID (0xff)
 
 /**
- * @brief qed_cxt_release - Release a cid
+ * qed_cxt_release_cid(): Release a cid.
  *
- * @param p_hwfn
- * @param cid
+ * @p_hwfn: HW device data.
+ * @cid: Cid.
+ *
+ * Return: Void.
  */
 void qed_cxt_release_cid(struct qed_hwfn *p_hwfn, u32 cid);
 
 /**
- * @brief qed_cxt_release - Release a cid belonging to a vf-queue
+ * _qed_cxt_release_cid(): Release a cid belonging to a vf-queue.
+ *
+ * @p_hwfn: HW device data.
+ * @cid: Cid.
+ * @vfid: Engine relative index. QED_CXT_PF_CID if belongs to PF.
  *
- * @param p_hwfn
- * @param cid
- * @param vfid - engine relative index. QED_CXT_PF_CID if belongs to PF
+ * Return: Void.
  */
 void _qed_cxt_release_cid(struct qed_hwfn *p_hwfn, u32 cid, u8 vfid);
 
 /**
- * @brief qed_cxt_acquire - Acquire a new cid of a specific protocol type
+ * qed_cxt_acquire_cid(): Acquire a new cid of a specific protocol type.
  *
- * @param p_hwfn
- * @param type
- * @param p_cid
+ * @p_hwfn: HW device data.
+ * @type: Type.
+ * @p_cid: Pointer cid.
  *
- * @return int
+ * Return: Int.
  */
 int qed_cxt_acquire_cid(struct qed_hwfn *p_hwfn,
 			enum protocol_type type, u32 *p_cid);
 
 /**
- * @brief _qed_cxt_acquire - Acquire a new cid of a specific protocol type
- *                           for a vf-queue
+ * _qed_cxt_acquire_cid(): Acquire a new cid of a specific protocol type
+ *                         for a vf-queue.
  *
- * @param p_hwfn
- * @param type
- * @param p_cid
- * @param vfid - engine relative index. QED_CXT_PF_CID if belongs to PF
+ * @p_hwfn: HW device data.
+ * @type: Type.
+ * @p_cid: Pointer cid.
+ * @vfid: Engine relative index. QED_CXT_PF_CID if belongs to PF.
  *
- * @return int
+ * Return: Int.
  */
 int _qed_cxt_acquire_cid(struct qed_hwfn *p_hwfn,
 			 enum protocol_type type, u32 *p_cid, u8 vfid);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
index d3c1f3879be8..f0a825b985a4 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
@@ -15,44 +15,52 @@
 #include "qed_int.h"
 
 /**
- * @brief qed_init_dp - initialize the debug level
+ * qed_init_dp(): Initialize the debug level.
  *
- * @param cdev
- * @param dp_module
- * @param dp_level
+ * @cdev: Qed dev pointer.
+ * @dp_module: Module debug parameter.
+ * @dp_level: Module debug level.
+ *
+ * Return: Void.
  */
 void qed_init_dp(struct qed_dev *cdev,
 		 u32 dp_module,
 		 u8 dp_level);
 
 /**
- * @brief qed_init_struct - initialize the device structure to
- *        its defaults
+ * qed_init_struct(): Initialize the device structure to
+ *                    its defaults.
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Void.
  */
 void qed_init_struct(struct qed_dev *cdev);
 
 /**
- * @brief qed_resc_free -
+ * qed_resc_free: Free device resources.
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Void.
  */
 void qed_resc_free(struct qed_dev *cdev);
 
 /**
- * @brief qed_resc_alloc -
+ * qed_resc_alloc(): Alloc device resources.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_resc_alloc(struct qed_dev *cdev);
 
 /**
- * @brief qed_resc_setup -
+ * qed_resc_setup(): Setup device resources.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
+ *
+ * Return: Void.
  */
 void qed_resc_setup(struct qed_dev *cdev);
 
@@ -105,94 +113,97 @@ struct qed_hw_init_params {
 };
 
 /**
- * @brief qed_hw_init -
+ * qed_hw_init(): Init Qed hardware.
  *
- * @param cdev
- * @param p_params
+ * @cdev: Qed dev pointer.
+ * @p_params: Pointers to params.
  *
- * @return int
+ * Return: Int.
  */
 int qed_hw_init(struct qed_dev *cdev, struct qed_hw_init_params *p_params);
 
 /**
- * @brief qed_hw_timers_stop_all - stop the timers HW block
+ * qed_hw_timers_stop_all(): Stop the timers HW block.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return void
+ * Return: void.
  */
 void qed_hw_timers_stop_all(struct qed_dev *cdev);
 
 /**
- * @brief qed_hw_stop -
+ * qed_hw_stop(): Stop Qed hardware.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: int.
  */
 int qed_hw_stop(struct qed_dev *cdev);
 
 /**
- * @brief qed_hw_stop_fastpath -should be called incase
- *		slowpath is still required for the device,
- *		but fastpath is not.
+ * qed_hw_stop_fastpath(): Should be called incase
+ *		           slowpath is still required for the device,
+ *		           but fastpath is not.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_hw_stop_fastpath(struct qed_dev *cdev);
 
 /**
- * @brief qed_hw_start_fastpath -restart fastpath traffic,
- *		only if hw_stop_fastpath was called
+ * qed_hw_start_fastpath(): Restart fastpath traffic,
+ *		            only if hw_stop_fastpath was called.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_hw_start_fastpath(struct qed_hwfn *p_hwfn);
 
 
 /**
- * @brief qed_hw_prepare -
+ * qed_hw_prepare(): Prepare Qed hardware.
  *
- * @param cdev
- * @param personality - personality to initialize
+ * @cdev: Qed dev pointer.
+ * @personality: Personality to initialize.
  *
- * @return int
+ * Return: Int.
  */
 int qed_hw_prepare(struct qed_dev *cdev,
 		   int personality);
 
 /**
- * @brief qed_hw_remove -
+ * qed_hw_remove(): Remove Qed hardware.
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Void.
  */
 void qed_hw_remove(struct qed_dev *cdev);
 
 /**
- * @brief qed_ptt_acquire - Allocate a PTT window
+ * qed_ptt_acquire(): Allocate a PTT window.
  *
- * Should be called at the entry point to the driver (at the beginning of an
- * exported function)
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: struct qed_ptt.
  *
- * @return struct qed_ptt
+ * Should be called at the entry point to the driver (at the beginning of an
+ * exported function).
  */
 struct qed_ptt *qed_ptt_acquire(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ptt_release - Release PTT Window
+ * qed_ptt_release(): Release PTT Window.
  *
- * Should be called at the end of a flow - at the end of the function that
- * acquired the PTT.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
+ * Return: Void.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Should be called at the end of a flow - at the end of the function that
+ * acquired the PTT.
  */
 void qed_ptt_release(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt);
@@ -205,15 +216,17 @@ enum qed_dmae_address_type_t {
 };
 
 /**
- * @brief qed_dmae_host2grc - copy data from source addr to
- * dmae registers using the given ptt
+ * qed_dmae_host2grc(): Copy data from source addr to
+ *                      dmae registers using the given ptt.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @source_addr: Source address.
+ * @grc_addr: GRC address (dmae_data_offset).
+ * @size_in_dwords: Size.
+ * @p_params: (default parameters will be used in case of NULL).
  *
- * @param p_hwfn
- * @param p_ptt
- * @param source_addr
- * @param grc_addr (dmae_data_offset)
- * @param size_in_dwords
- * @param p_params (default parameters will be used in case of NULL)
+ * Return: Int.
  */
 int
 qed_dmae_host2grc(struct qed_hwfn *p_hwfn,
@@ -224,29 +237,34 @@ qed_dmae_host2grc(struct qed_hwfn *p_hwfn,
 		  struct qed_dmae_params *p_params);
 
  /**
- * @brief qed_dmae_grc2host - Read data from dmae data offset
- * to source address using the given ptt
+ * qed_dmae_grc2host(): Read data from dmae data offset
+ *                      to source address using the given ptt.
+ *
+ * @p_ptt: P_ptt.
+ * @grc_addr: GRC address (dmae_data_offset).
+ * @dest_addr: Destination Address.
+ * @size_in_dwords: Size.
+ * @p_params: (default parameters will be used in case of NULL).
  *
- * @param p_ptt
- * @param grc_addr (dmae_data_offset)
- * @param dest_addr
- * @param size_in_dwords
- * @param p_params (default parameters will be used in case of NULL)
+ * Return: Int.
  */
 int qed_dmae_grc2host(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 		      u32 grc_addr, dma_addr_t dest_addr, u32 size_in_dwords,
 		      struct qed_dmae_params *p_params);
 
 /**
- * @brief qed_dmae_host2host - copy data from to source address
- * to a destination adress (for SRIOV) using the given ptt
+ * qed_dmae_host2host(): Copy data from to source address
+ *                       to a destination adrress (for SRIOV) using the given
+ *                       ptt.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param source_addr
- * @param dest_addr
- * @param size_in_dwords
- * @param p_params (default parameters will be used in case of NULL)
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @source_addr: Source address.
+ * @dest_addr: Destination address.
+ * @size_in_dwords: size.
+ * @p_params: (default parameters will be used in case of NULL).
+ *
+ * Return: Int.
  */
 int qed_dmae_host2host(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
@@ -259,51 +277,51 @@ int qed_chain_alloc(struct qed_dev *cdev, struct qed_chain *chain,
 void qed_chain_free(struct qed_dev *cdev, struct qed_chain *chain);
 
 /**
- * @@brief qed_fw_l2_queue - Get absolute L2 queue ID
+ * qed_fw_l2_queue(): Get absolute L2 queue ID.
  *
- *  @param p_hwfn
- *  @param src_id - relative to p_hwfn
- *  @param dst_id - absolute per engine
+ * @p_hwfn: HW device data.
+ * @src_id: Relative to p_hwfn.
+ * @dst_id: Absolute per engine.
  *
- *  @return int
+ * Return: Int.
  */
 int qed_fw_l2_queue(struct qed_hwfn *p_hwfn,
 		    u16 src_id,
 		    u16 *dst_id);
 
 /**
- * @@brief qed_fw_vport - Get absolute vport ID
+ * qed_fw_vport(): Get absolute vport ID.
  *
- *  @param p_hwfn
- *  @param src_id - relative to p_hwfn
- *  @param dst_id - absolute per engine
+ * @p_hwfn: HW device data.
+ * @src_id: Relative to p_hwfn.
+ * @dst_id: Absolute per engine.
  *
- *  @return int
+ * Return: Int.
  */
 int qed_fw_vport(struct qed_hwfn *p_hwfn,
 		 u8 src_id,
 		 u8 *dst_id);
 
 /**
- * @@brief qed_fw_rss_eng - Get absolute RSS engine ID
+ * qed_fw_rss_eng(): Get absolute RSS engine ID.
  *
- *  @param p_hwfn
- *  @param src_id - relative to p_hwfn
- *  @param dst_id - absolute per engine
+ * @p_hwfn: HW device data.
+ * @src_id: Relative to p_hwfn.
+ * @dst_id: Absolute per engine.
  *
- *  @return int
+ * Return: Int.
  */
 int qed_fw_rss_eng(struct qed_hwfn *p_hwfn,
 		   u8 src_id,
 		   u8 *dst_id);
 
 /**
- * @brief qed_llh_get_num_ppfid - Return the allocated number of LLH filter
- *	banks that are allocated to the PF.
+ * qed_llh_get_num_ppfid(): Return the allocated number of LLH filter
+ *	                    banks that are allocated to the PF.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return u8 - Number of LLH filter banks
+ * Return: u8 Number of LLH filter banks.
  */
 u8 qed_llh_get_num_ppfid(struct qed_dev *cdev);
 
@@ -314,45 +332,50 @@ enum qed_eng {
 };
 
 /**
- * @brief qed_llh_set_ppfid_affinity - Set the engine affinity for the given
- *	LLH filter bank.
+ * qed_llh_set_ppfid_affinity(): Set the engine affinity for the given
+ *	                         LLH filter bank.
  *
- * @param cdev
- * @param ppfid - relative within the allocated ppfids ('0' is the default one).
- * @param eng
+ * @cdev: Qed dev pointer.
+ * @ppfid: Relative within the allocated ppfids ('0' is the default one).
+ * @eng: Engine.
  *
- * @return int
+ * Return: Int.
  */
 int qed_llh_set_ppfid_affinity(struct qed_dev *cdev,
 			       u8 ppfid, enum qed_eng eng);
 
 /**
- * @brief qed_llh_set_roce_affinity - Set the RoCE engine affinity
+ * qed_llh_set_roce_affinity(): Set the RoCE engine affinity.
  *
- * @param cdev
- * @param eng
+ * @cdev: Qed dev pointer.
+ * @eng: Engine.
  *
- * @return int
+ * Return: Int.
  */
 int qed_llh_set_roce_affinity(struct qed_dev *cdev, enum qed_eng eng);
 
 /**
- * @brief qed_llh_add_mac_filter - Add a LLH MAC filter into the given filter
- *	bank.
+ * qed_llh_add_mac_filter(): Add a LLH MAC filter into the given filter
+ *	                     bank.
+ *
+ * @cdev: Qed dev pointer.
+ * @ppfid: Relative within the allocated ppfids ('0' is the default one).
+ * @mac_addr: MAC to add.
  *
- * @param cdev
- * @param ppfid - relative within the allocated ppfids ('0' is the default one).
- * @param mac_addr - MAC to add
+ * Return: Int.
  */
 int qed_llh_add_mac_filter(struct qed_dev *cdev,
 			   u8 ppfid, u8 mac_addr[ETH_ALEN]);
 
 /**
- * @brief qed_llh_remove_mac_filter - Remove a LLH MAC filter from the given
- *	filter bank.
+ * qed_llh_remove_mac_filter(): Remove a LLH MAC filter from the given
+ *	                        filter bank.
  *
- * @param p_ptt
- * @param p_filter - MAC to remove
+ * @cdev: Qed dev pointer.
+ * @ppfid: Ppfid.
+ * @mac_addr: MAC to remove
+ *
+ * Return: Void.
  */
 void qed_llh_remove_mac_filter(struct qed_dev *cdev,
 			       u8 ppfid, u8 mac_addr[ETH_ALEN]);
@@ -368,15 +391,16 @@ enum qed_llh_prot_filter_type_t {
 };
 
 /**
- * @brief qed_llh_add_protocol_filter - Add a LLH protocol filter into the
- *	given filter bank.
+ * qed_llh_add_protocol_filter(): Add a LLH protocol filter into the
+ *	                          given filter bank.
+ *
+ * @cdev: Qed dev pointer.
+ * @ppfid: Relative within the allocated ppfids ('0' is the default one).
+ * @type: Type of filters and comparing.
+ * @source_port_or_eth_type: Source port or ethertype to add.
+ * @dest_port: Destination port to add.
  *
- * @param cdev
- * @param ppfid - relative within the allocated ppfids ('0' is the default one).
- * @param type - type of filters and comparing
- * @param source_port_or_eth_type - source port or ethertype to add
- * @param dest_port - destination port to add
- * @param type - type of filters and comparing
+ * Return: Int.
  */
 int
 qed_llh_add_protocol_filter(struct qed_dev *cdev,
@@ -385,14 +409,14 @@ qed_llh_add_protocol_filter(struct qed_dev *cdev,
 			    u16 source_port_or_eth_type, u16 dest_port);
 
 /**
- * @brief qed_llh_remove_protocol_filter - Remove a LLH protocol filter from
- *	the given filter bank.
+ * qed_llh_remove_protocol_filter(): Remove a LLH protocol filter from
+ *	                             the given filter bank.
  *
- * @param cdev
- * @param ppfid - relative within the allocated ppfids ('0' is the default one).
- * @param type - type of filters and comparing
- * @param source_port_or_eth_type - source port or ethertype to add
- * @param dest_port - destination port to add
+ * @cdev: Qed dev pointer.
+ * @ppfid: Relative within the allocated ppfids ('0' is the default one).
+ * @type: Type of filters and comparing.
+ * @source_port_or_eth_type: Source port or ethertype to add.
+ * @dest_port: Destination port to add.
  */
 void
 qed_llh_remove_protocol_filter(struct qed_dev *cdev,
@@ -401,31 +425,31 @@ qed_llh_remove_protocol_filter(struct qed_dev *cdev,
 			       u16 source_port_or_eth_type, u16 dest_port);
 
 /**
- * *@brief Cleanup of previous driver remains prior to load
+ * qed_final_cleanup(): Cleanup of previous driver remains prior to load.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param id - For PF, engine-relative. For VF, PF-relative.
- * @param is_vf - true iff cleanup is made for a VF.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @id: For PF, engine-relative. For VF, PF-relative.
+ * @is_vf: True iff cleanup is made for a VF.
  *
- * @return int
+ * Return: Int.
  */
 int qed_final_cleanup(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt, u16 id, bool is_vf);
 
 /**
- * @brief qed_get_queue_coalesce - Retrieve coalesce value for a given queue.
+ * qed_get_queue_coalesce(): Retrieve coalesce value for a given queue.
  *
- * @param p_hwfn
- * @param p_coal - store coalesce value read from the hardware.
- * @param p_handle
+ * @p_hwfn: HW device data.
+ * @coal: Store coalesce value read from the hardware.
+ * @handle: P_handle.
  *
- * @return int
+ * Return: Int.
  **/
 int qed_get_queue_coalesce(struct qed_hwfn *p_hwfn, u16 *coal, void *handle);
 
 /**
- * @brief qed_set_queue_coalesce - Configure coalesce parameters for Rx and
+ * qed_set_queue_coalesce(): Configure coalesce parameters for Rx and
  *    Tx queue. The fact that we can configure coalescing to up to 511, but on
  *    varying accuracy [the bigger the value the less accurate] up to a mistake
  *    of 3usec for the highest values.
@@ -433,37 +457,38 @@ int qed_get_queue_coalesce(struct qed_hwfn *p_hwfn, u16 *coal, void *handle);
  *    should be in same range [i.e., either 0-0x7f, 0x80-0xff or 0x100-0x1ff]
  *    otherwise configuration would break.
  *
+ * @rx_coal: Rx Coalesce value in micro seconds.
+ * @tx_coal: TX Coalesce value in micro seconds.
+ * @p_handle: P_handle.
  *
- * @param rx_coal - Rx Coalesce value in micro seconds.
- * @param tx_coal - TX Coalesce value in micro seconds.
- * @param p_handle
- *
- * @return int
+ * Return: Int.
  **/
 int
 qed_set_queue_coalesce(u16 rx_coal, u16 tx_coal, void *p_handle);
 
 /**
- * @brief qed_pglueb_set_pfid_enable - Enable or disable PCI BUS MASTER
+ * qed_pglueb_set_pfid_enable(): Enable or disable PCI BUS MASTER.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param b_enable - true/false
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @b_enable: True/False.
  *
- * @return int
+ * Return: Int.
  */
 int qed_pglueb_set_pfid_enable(struct qed_hwfn *p_hwfn,
 			       struct qed_ptt *p_ptt, bool b_enable);
 
 /**
- * @brief db_recovery_add - add doorbell information to the doorbell
- * recovery mechanism.
+ * qed_db_recovery_add(): add doorbell information to the doorbell
+ *                    recovery mechanism.
  *
- * @param cdev
- * @param db_addr - doorbell address
- * @param db_data - address of where db_data is stored
- * @param db_width - doorbell is 32b pr 64b
- * @param db_space - doorbell recovery addresses are user or kernel space
+ * @cdev: Qed dev pointer.
+ * @db_addr: Doorbell address.
+ * @db_data: Address of where db_data is stored.
+ * @db_width: Doorbell is 32b pr 64b.
+ * @db_space: Doorbell recovery addresses are user or kernel space.
+ *
+ * Return: Int.
  */
 int qed_db_recovery_add(struct qed_dev *cdev,
 			void __iomem *db_addr,
@@ -472,13 +497,15 @@ int qed_db_recovery_add(struct qed_dev *cdev,
 			enum qed_db_rec_space db_space);
 
 /**
- * @brief db_recovery_del - remove doorbell information from the doorbell
+ * qed_db_recovery_del() - remove doorbell information from the doorbell
  * recovery mechanism. db_data serves as key (db_addr is not unique).
  *
- * @param cdev
- * @param db_addr - doorbell address
- * @param db_data - address where db_data is stored. Serves as key for the
+ * @cdev: Qed dev pointer.
+ * @db_addr: doorbell address.
+ * @db_data: address where db_data is stored. Serves as key for the
  *                  entry to delete.
+ *
+ * Return: Int.
  */
 int qed_db_recovery_del(struct qed_dev *cdev,
 			void __iomem *db_addr, void *db_data);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index fb1baa2da2d0..744c82a10875 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -3012,96 +3012,102 @@ struct iro {
 /***************************** Public Functions *******************************/
 
 /**
- * @brief qed_dbg_set_bin_ptr - Sets a pointer to the binary data with debug
- *	arrays.
+ * qed_dbg_set_bin_ptr(): Sets a pointer to the binary data with debug
+ *                        arrays.
  *
- * @param p_hwfn -	    HW device data
- * @param bin_ptr - a pointer to the binary data with debug arrays.
+ * @p_hwfn: HW device data.
+ * @bin_ptr: A pointer to the binary data with debug arrays.
+ *
+ * Return: enum dbg status.
  */
 enum dbg_status qed_dbg_set_bin_ptr(struct qed_hwfn *p_hwfn,
 				    const u8 * const bin_ptr);
 
 /**
- * @brief qed_read_regs - Reads registers into a buffer (using GRC).
+ * qed_read_regs(): Reads registers into a buffer (using GRC).
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf: Destination buffer.
+ * @addr: Source GRC address in dwords.
+ * @len: Number of registers to read.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf - Destination buffer.
- * @param addr - Source GRC address in dwords.
- * @param len - Number of registers to read.
+ * Return: Void.
  */
 void qed_read_regs(struct qed_hwfn *p_hwfn,
 		   struct qed_ptt *p_ptt, u32 *buf, u32 addr, u32 len);
 
 /**
- * @brief qed_read_fw_info - Reads FW info from the chip.
+ * qed_read_fw_info(): Reads FW info from the chip.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @fw_info: (Out) a pointer to write the FW info into.
+ *
+ * Return: True if the FW info was read successfully from one of the Storms,
+ * or false if all Storms are in reset.
  *
  * The FW info contains FW-related information, such as the FW version,
  * FW image (main/L2B/kuku), FW timestamp, etc.
  * The FW info is read from the internal RAM of the first Storm that is not in
  * reset.
- *
- * @param p_hwfn -	    HW device data
- * @param p_ptt -	    Ptt window used for writing the registers.
- * @param fw_info -	Out: a pointer to write the FW info into.
- *
- * @return true if the FW info was read successfully from one of the Storms,
- * or false if all Storms are in reset.
  */
 bool qed_read_fw_info(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt, struct fw_info *fw_info);
 /**
- * @brief qed_dbg_grc_config - Sets the value of a GRC parameter.
+ * qed_dbg_grc_config(): Sets the value of a GRC parameter.
  *
- * @param p_hwfn -	HW device data
- * @param grc_param -	GRC parameter
- * @param val -		Value to set.
+ * @p_hwfn: HW device data.
+ * @grc_param: GRC parameter.
+ * @val: Value to set.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- grc_param is invalid
- *	- val is outside the allowed boundaries
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *         - Grc_param is invalid.
+ *         - Val is outside the allowed boundaries.
  */
 enum dbg_status qed_dbg_grc_config(struct qed_hwfn *p_hwfn,
 				   enum dbg_grc_params grc_param, u32 val);
 
 /**
- * @brief qed_dbg_grc_set_params_default - Reverts all GRC parameters to their
- *	default value.
+ * qed_dbg_grc_set_params_default(): Reverts all GRC parameters to their
+ *                                   default value.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn		- HW device data
+ * Return: Void.
  */
 void qed_dbg_grc_set_params_default(struct qed_hwfn *p_hwfn);
 /**
- * @brief qed_dbg_grc_get_dump_buf_size - Returns the required buffer size for
- *	GRC Dump.
+ * qed_dbg_grc_get_dump_buf_size(): Returns the required buffer size for
+ *                                  GRC Dump.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the GRC Dump
- *	data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) required buffer size (in dwords) for the GRC Dump
+ *             data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_grc_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 					      struct qed_ptt *p_ptt,
 					      u32 *buf_size);
 
 /**
- * @brief qed_dbg_grc_dump - Dumps GRC data into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the collected GRC data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified dump buffer is too small
- * Otherwise, returns ok.
+ * qed_dbg_grc_dump(): Dumps GRC data into the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the collected GRC data into.
+ * @buf_size_in_dwords:Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *        - The version wasn't set.
+ *        - The specified dump buffer is too small.
+ *          Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_grc_dump(struct qed_hwfn *p_hwfn,
 				 struct qed_ptt *p_ptt,
@@ -3110,36 +3116,36 @@ enum dbg_status qed_dbg_grc_dump(struct qed_hwfn *p_hwfn,
 				 u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_idle_chk_get_dump_buf_size - Returns the required buffer size
- *	for idle check results.
+ * qed_dbg_idle_chk_get_dump_buf_size(): Returns the required buffer size
+ *                                       for idle check results.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the idle check
- *	data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) required buffer size (in dwords) for the idle check
+ *             data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * return: Error if one of the following holds:
+ *        - The version wasn't set.
+ *          Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_idle_chk_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 						   struct qed_ptt *p_ptt,
 						   u32 *buf_size);
 
 /**
- * @brief qed_dbg_idle_chk_dump - Performs idle check and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the idle check data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- * Otherwise, returns ok.
+ * qed_dbg_idle_chk_dump: Performs idle check and writes the results
+ *                        into the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the idle check data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *         - The specified buffer is too small.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_idle_chk_dump(struct qed_hwfn *p_hwfn,
 				      struct qed_ptt *p_ptt,
@@ -3148,42 +3154,42 @@ enum dbg_status qed_dbg_idle_chk_dump(struct qed_hwfn *p_hwfn,
 				      u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_mcp_trace_get_dump_buf_size - Returns the required buffer size
- *	for mcp trace results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for mcp trace data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the trace data in MCP scratchpad contain an invalid signature
- *	- the bundle ID in NVRAM is invalid
- *	- the trace meta data cannot be found (in NVRAM or image file)
- * Otherwise, returns ok.
+ * qed_dbg_mcp_trace_get_dump_buf_size(): Returns the required buffer size
+ *                                        for mcp trace results.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) Required buffer size (in dwords) for mcp trace data.
+ *
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *         - The trace data in MCP scratchpad contain an invalid signature.
+ *         - The bundle ID in NVRAM is invalid.
+ *         - The trace meta data cannot be found (in NVRAM or image file).
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_mcp_trace_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 						    struct qed_ptt *p_ptt,
 						    u32 *buf_size);
 
 /**
- * @brief qed_dbg_mcp_trace_dump - Performs mcp trace and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the mcp trace data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- the trace data in MCP scratchpad contain an invalid signature
- *	- the bundle ID in NVRAM is invalid
- *	- the trace meta data cannot be found (in NVRAM or image file)
- *	- the trace meta data cannot be read (from NVRAM or image file)
- * Otherwise, returns ok.
+ * qed_dbg_mcp_trace_dump(): Performs mcp trace and writes the results
+ *                           into the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the mcp trace data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *        - The version wasn't set.
+ *        - The specified buffer is too small.
+ *        - The trace data in MCP scratchpad contain an invalid signature.
+ *        - The bundle ID in NVRAM is invalid.
+ *        - The trace meta data cannot be found (in NVRAM or image file).
+ *        - The trace meta data cannot be read (from NVRAM or image file).
+ *          Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_mcp_trace_dump(struct qed_hwfn *p_hwfn,
 				       struct qed_ptt *p_ptt,
@@ -3192,36 +3198,36 @@ enum dbg_status qed_dbg_mcp_trace_dump(struct qed_hwfn *p_hwfn,
 				       u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_reg_fifo_get_dump_buf_size - Returns the required buffer size
- *	for grc trace fifo results.
+ * qed_dbg_reg_fifo_get_dump_buf_size(): Returns the required buffer size
+ *                                       for grc trace fifo results.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for reg fifo data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) Required buffer size (in dwords) for reg fifo data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_reg_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 						   struct qed_ptt *p_ptt,
 						   u32 *buf_size);
 
 /**
- * @brief qed_dbg_reg_fifo_dump - Reads the reg fifo and writes the results into
- *	the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the reg fifo data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
+ * qed_dbg_reg_fifo_dump(): Reads the reg fifo and writes the results into
+ *                          the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the reg fifo data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *        - The version wasn't set.
+ *        - The specified buffer is too small.
+ *        - DMAE transaction failed.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_reg_fifo_dump(struct qed_hwfn *p_hwfn,
 				      struct qed_ptt *p_ptt,
@@ -3230,37 +3236,37 @@ enum dbg_status qed_dbg_reg_fifo_dump(struct qed_hwfn *p_hwfn,
 				      u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_igu_fifo_get_dump_buf_size - Returns the required buffer size
- *	for the IGU fifo results.
+ * qed_dbg_igu_fifo_get_dump_buf_size(): Returns the required buffer size
+ *                                       for the IGU fifo results.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the IGU fifo
- *	data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) Required buffer size (in dwords) for the IGU fifo
+ *            data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_igu_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 						   struct qed_ptt *p_ptt,
 						   u32 *buf_size);
 
 /**
- * @brief qed_dbg_igu_fifo_dump - Reads the IGU fifo and writes the results into
- *	the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the IGU fifo data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
+ * qed_dbg_igu_fifo_dump(): Reads the IGU fifo and writes the results into
+ *                          the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the IGU fifo data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set
+ *         - The specified buffer is too small
+ *         - DMAE transaction failed
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_igu_fifo_dump(struct qed_hwfn *p_hwfn,
 				      struct qed_ptt *p_ptt,
@@ -3269,37 +3275,37 @@ enum dbg_status qed_dbg_igu_fifo_dump(struct qed_hwfn *p_hwfn,
 				      u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_protection_override_get_dump_buf_size - Returns the required
- *	buffer size for protection override window results.
+ * qed_dbg_protection_override_get_dump_buf_size(): Returns the required
+ *        buffer size for protection override window results.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for protection
- *	override data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) Required buffer size (in dwords) for protection
+ *             override data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set
+ *           Otherwise, returns ok.
  */
 enum dbg_status
 qed_dbg_protection_override_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 					      struct qed_ptt *p_ptt,
 					      u32 *buf_size);
 /**
- * @brief qed_dbg_protection_override_dump - Reads protection override window
- *	entries and writes the results into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the protection override data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
+ * qed_dbg_protection_override_dump(): Reads protection override window
+ *       entries and writes the results into the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the protection override data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * @return: Error if one of the following holds:
+ *          - The version wasn't set.
+ *          - The specified buffer is too small.
+ *          - DMAE transaction failed.
+ *             Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_protection_override_dump(struct qed_hwfn *p_hwfn,
 						 struct qed_ptt *p_ptt,
@@ -3307,34 +3313,34 @@ enum dbg_status qed_dbg_protection_override_dump(struct qed_hwfn *p_hwfn,
 						 u32 buf_size_in_dwords,
 						 u32 *num_dumped_dwords);
 /**
- * @brief qed_dbg_fw_asserts_get_dump_buf_size - Returns the required buffer
- *	size for FW Asserts results.
+ * qed_dbg_fw_asserts_get_dump_buf_size(): Returns the required buffer
+ *                                         size for FW Asserts results.
  *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for FW Asserts data.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @buf_size: (OUT) Required buffer size (in dwords) for FW Asserts data.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_fw_asserts_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 						     struct qed_ptt *p_ptt,
 						     u32 *buf_size);
 /**
- * @brief qed_dbg_fw_asserts_dump - Reads the FW Asserts and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the FW Asserts data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- * Otherwise, returns ok.
+ * qed_dbg_fw_asserts_dump(): Reads the FW Asserts and writes the results
+ *                            into the specified buffer.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dump_buf: Pointer to write the FW Asserts data into.
+ * @buf_size_in_dwords: Size of the specified buffer in dwords.
+ * @num_dumped_dwords: (OUT) number of dumped dwords.
+ *
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *         - The specified buffer is too small.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_fw_asserts_dump(struct qed_hwfn *p_hwfn,
 					struct qed_ptt *p_ptt,
@@ -3343,19 +3349,19 @@ enum dbg_status qed_dbg_fw_asserts_dump(struct qed_hwfn *p_hwfn,
 					u32 *num_dumped_dwords);
 
 /**
- * @brief qed_dbg_read_attn - Reads the attention registers of the specified
+ * qed_dbg_read_attn(): Reads the attention registers of the specified
  * block and type, and writes the results into the specified buffer.
  *
- * @param p_hwfn -	 HW device data
- * @param p_ptt -	 Ptt window used for writing the registers.
- * @param block -	 Block ID.
- * @param attn_type -	 Attention type.
- * @param clear_status - Indicates if the attention status should be cleared.
- * @param results -	 OUT: Pointer to write the read results into
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @block: Block ID.
+ * @attn_type: Attention type.
+ * @clear_status: Indicates if the attention status should be cleared.
+ * @results:  (OUT) Pointer to write the read results into.
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set
+ *          Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_read_attn(struct qed_hwfn *p_hwfn,
 				  struct qed_ptt *p_ptt,
@@ -3365,15 +3371,15 @@ enum dbg_status qed_dbg_read_attn(struct qed_hwfn *p_hwfn,
 				  struct dbg_attn_block_result *results);
 
 /**
- * @brief qed_dbg_print_attn - Prints attention registers values in the
- *	specified results struct.
+ * qed_dbg_print_attn(): Prints attention registers values in the
+ *                       specified results struct.
  *
- * @param p_hwfn
- * @param results - Pointer to the attention read results
+ * @p_hwfn: HW device data.
+ * @results: Pointer to the attention read results
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *        - The version wasn't set
+ *          Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_print_attn(struct qed_hwfn *p_hwfn,
 				   struct dbg_attn_block_result *results);
@@ -3420,60 +3426,64 @@ struct dbg_tools_user_data {
 /***************************** Public Functions *******************************/
 
 /**
- * @brief qed_dbg_user_set_bin_ptr - Sets a pointer to the binary data with
- *	debug arrays.
+ * qed_dbg_user_set_bin_ptr(): Sets a pointer to the binary data with
+ *                             debug arrays.
  *
- * @param p_hwfn - HW device data
- * @param bin_ptr - a pointer to the binary data with debug arrays.
+ * @p_hwfn: HW device data.
+ * @bin_ptr: a pointer to the binary data with debug arrays.
+ *
+ * Return: dbg_status.
  */
 enum dbg_status qed_dbg_user_set_bin_ptr(struct qed_hwfn *p_hwfn,
 					 const u8 * const bin_ptr);
 
 /**
- * @brief qed_dbg_alloc_user_data - Allocates user debug data.
+ * qed_dbg_alloc_user_data(): Allocates user debug data.
+ *
+ * @p_hwfn: HW device data.
+ * @user_data_ptr: (OUT) a pointer to the allocated memory.
  *
- * @param p_hwfn -		 HW device data
- * @param user_data_ptr - OUT: a pointer to the allocated memory.
+ * Return: dbg_status.
  */
 enum dbg_status qed_dbg_alloc_user_data(struct qed_hwfn *p_hwfn,
 					void **user_data_ptr);
 
 /**
- * @brief qed_dbg_get_status_str - Returns a string for the specified status.
+ * qed_dbg_get_status_str(): Returns a string for the specified status.
  *
- * @param status - a debug status code.
+ * @status: A debug status code.
  *
- * @return a string for the specified status
+ * Return: A string for the specified status.
  */
 const char *qed_dbg_get_status_str(enum dbg_status status);
 
 /**
- * @brief qed_get_idle_chk_results_buf_size - Returns the required buffer size
- *	for idle check results (in bytes).
+ * qed_get_idle_chk_results_buf_size(): Returns the required buffer size
+ *                                      for idle check results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - idle check dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: idle check dump buffer.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                    results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_get_idle_chk_results_buf_size(struct qed_hwfn *p_hwfn,
 						  u32 *dump_buf,
 						  u32  num_dumped_dwords,
 						  u32 *results_buf_size);
 /**
- * @brief qed_print_idle_chk_results - Prints idle check results
+ * qed_print_idle_chk_results(): Prints idle check results
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - idle check dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the idle check results.
- * @param num_errors - OUT: number of errors found in idle check.
- * @param num_warnings - OUT: number of warnings found in idle check.
+ * @p_hwfn: HW device data.
+ * @dump_buf: idle check dump buffer.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf: buffer for printing the idle check results.
+ * @num_errors: (OUT) number of errors found in idle check.
+ * @num_warnings: (OUT) number of warnings found in idle check.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_idle_chk_results(struct qed_hwfn *p_hwfn,
 					   u32 *dump_buf,
@@ -3483,28 +3493,30 @@ enum dbg_status qed_print_idle_chk_results(struct qed_hwfn *p_hwfn,
 					   u32 *num_warnings);
 
 /**
- * @brief qed_dbg_mcp_trace_set_meta_data - Sets the MCP Trace meta data.
+ * qed_dbg_mcp_trace_set_meta_data(): Sets the MCP Trace meta data.
+ *
+ * @p_hwfn: HW device data.
+ * @meta_buf: Meta buffer.
+ *
+ * Return: Void.
  *
  * Needed in case the MCP Trace dump doesn't contain the meta data (e.g. due to
  * no NVRAM access).
- *
- * @param data - pointer to MCP Trace meta data
- * @param size - size of MCP Trace meta data in dwords
  */
 void qed_dbg_mcp_trace_set_meta_data(struct qed_hwfn *p_hwfn,
 				     const u32 *meta_buf);
 
 /**
- * @brief qed_get_mcp_trace_results_buf_size - Returns the required buffer size
- *	for MCP Trace results (in bytes).
+ * qed_get_mcp_trace_results_buf_size(): Returns the required buffer size
+ *                                       for MCP Trace results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - MCP Trace dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: MCP Trace dump buffer.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                    results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Rrror if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_get_mcp_trace_results_buf_size(struct qed_hwfn *p_hwfn,
 						   u32 *dump_buf,
@@ -3512,14 +3524,14 @@ enum dbg_status qed_get_mcp_trace_results_buf_size(struct qed_hwfn *p_hwfn,
 						   u32 *results_buf_size);
 
 /**
- * @brief qed_print_mcp_trace_results - Prints MCP Trace results
+ * qed_print_mcp_trace_results(): Prints MCP Trace results
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - mcp trace dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the mcp trace results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: MCP trace dump buffer, starting from the header.
+ * @num_dumped_dwords: Member of dwords that were dumped.
+ * @results_buf: Buffer for printing the mcp trace results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
 					    u32 *dump_buf,
@@ -3527,30 +3539,30 @@ enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
 					    char *results_buf);
 
 /**
- * @brief qed_print_mcp_trace_results_cont - Prints MCP Trace results, and
+ * qed_print_mcp_trace_results_cont(): Prints MCP Trace results, and
  * keeps the MCP trace meta data allocated, to support continuous MCP Trace
  * parsing. After the continuous parsing ends, mcp_trace_free_meta_data should
  * be called to free the meta data.
  *
- * @param p_hwfn -	      HW device data
- * @param dump_buf -	      mcp trace dump buffer, starting from the header.
- * @param results_buf -	      buffer for printing the mcp trace results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: MVP trace dump buffer, starting from the header.
+ * @results_buf: Buffer for printing the mcp trace results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_mcp_trace_results_cont(struct qed_hwfn *p_hwfn,
 						 u32 *dump_buf,
 						 char *results_buf);
 
 /**
- * @brief print_mcp_trace_line - Prints MCP Trace results for a single line
+ * qed_print_mcp_trace_line(): Prints MCP Trace results for a single line
  *
- * @param p_hwfn -	      HW device data
- * @param dump_buf -	      mcp trace dump buffer, starting from the header.
- * @param num_dumped_bytes -  number of bytes that were dumped.
- * @param results_buf -	      buffer for printing the mcp trace results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: MCP trace dump buffer, starting from the header.
+ * @num_dumped_bytes: Number of bytes that were dumped.
+ * @results_buf: Buffer for printing the mcp trace results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
 					 u8 *dump_buf,
@@ -3558,24 +3570,26 @@ enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
 					 char *results_buf);
 
 /**
- * @brief mcp_trace_free_meta_data - Frees the MCP Trace meta data.
+ * qed_mcp_trace_free_meta_data(): Frees the MCP Trace meta data.
  * Should be called after continuous MCP Trace parsing.
  *
- * @param p_hwfn - HW device data
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_mcp_trace_free_meta_data(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_get_reg_fifo_results_buf_size - Returns the required buffer size
- *	for reg_fifo results (in bytes).
+ * qed_get_reg_fifo_results_buf_size(): Returns the required buffer size
+ *                                      for reg_fifo results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - reg fifo dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: Reg fifo dump buffer.
+ * @num_dumped_dwords: Number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                     results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_get_reg_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
 						  u32 *dump_buf,
@@ -3583,14 +3597,14 @@ enum dbg_status qed_get_reg_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
 						  u32 *results_buf_size);
 
 /**
- * @brief qed_print_reg_fifo_results - Prints reg fifo results
+ * qed_print_reg_fifo_results(): Prints reg fifo results.
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - reg fifo dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the reg fifo results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: Reg fifo dump buffer, starting from the header.
+ * @num_dumped_dwords: Number of dwords that were dumped.
+ * @results_buf: Buffer for printing the reg fifo results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_reg_fifo_results(struct qed_hwfn *p_hwfn,
 					   u32 *dump_buf,
@@ -3598,16 +3612,16 @@ enum dbg_status qed_print_reg_fifo_results(struct qed_hwfn *p_hwfn,
 					   char *results_buf);
 
 /**
- * @brief qed_get_igu_fifo_results_buf_size - Returns the required buffer size
- *	for igu_fifo results (in bytes).
+ * qed_get_igu_fifo_results_buf_size(): Returns the required buffer size
+ *                                      for igu_fifo results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - IGU fifo dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: IGU fifo dump buffer.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                    results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_get_igu_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
 						  u32 *dump_buf,
@@ -3615,14 +3629,14 @@ enum dbg_status qed_get_igu_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
 						  u32 *results_buf_size);
 
 /**
- * @brief qed_print_igu_fifo_results - Prints IGU fifo results
+ * qed_print_igu_fifo_results(): Prints IGU fifo results
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - IGU fifo dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the IGU fifo results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: IGU fifo dump buffer, starting from the header.
+ * @num_dumped_dwords: Number of dwords that were dumped.
+ * @results_buf: Buffer for printing the IGU fifo results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_igu_fifo_results(struct qed_hwfn *p_hwfn,
 					   u32 *dump_buf,
@@ -3630,16 +3644,16 @@ enum dbg_status qed_print_igu_fifo_results(struct qed_hwfn *p_hwfn,
 					   char *results_buf);
 
 /**
- * @brief qed_get_protection_override_results_buf_size - Returns the required
- *	buffer size for protection override results (in bytes).
+ * qed_get_protection_override_results_buf_size(): Returns the required
+ *         buffer size for protection override results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - protection override dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: Protection override dump buffer.
+ * @num_dumped_dwords: Number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                    results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status
 qed_get_protection_override_results_buf_size(struct qed_hwfn *p_hwfn,
@@ -3648,15 +3662,15 @@ qed_get_protection_override_results_buf_size(struct qed_hwfn *p_hwfn,
 					     u32 *results_buf_size);
 
 /**
- * @brief qed_print_protection_override_results - Prints protection override
- *	results.
+ * qed_print_protection_override_results(): Prints protection override
+ *                                          results.
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - protection override dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the reg fifo results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: Protection override dump buffer, starting from the header.
+ * @num_dumped_dwords: Number of dwords that were dumped.
+ * @results_buf: Buffer for printing the reg fifo results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_protection_override_results(struct qed_hwfn *p_hwfn,
 						      u32 *dump_buf,
@@ -3664,16 +3678,16 @@ enum dbg_status qed_print_protection_override_results(struct qed_hwfn *p_hwfn,
 						      char *results_buf);
 
 /**
- * @brief qed_get_fw_asserts_results_buf_size - Returns the required buffer size
- *	for FW Asserts results (in bytes).
+ * qed_get_fw_asserts_results_buf_size(): Returns the required buffer size
+ *                                        for FW Asserts results (in bytes).
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - FW Asserts dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: FW Asserts dump buffer.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf_size: (OUT) required buffer size (in bytes) for the parsed
+ *                    results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_get_fw_asserts_results_buf_size(struct qed_hwfn *p_hwfn,
 						    u32 *dump_buf,
@@ -3681,14 +3695,14 @@ enum dbg_status qed_get_fw_asserts_results_buf_size(struct qed_hwfn *p_hwfn,
 						    u32 *results_buf_size);
 
 /**
- * @brief qed_print_fw_asserts_results - Prints FW Asserts results
+ * qed_print_fw_asserts_results(): Prints FW Asserts results.
  *
- * @param p_hwfn - HW device data
- * @param dump_buf - FW Asserts dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the FW Asserts results.
+ * @p_hwfn: HW device data.
+ * @dump_buf: FW Asserts dump buffer, starting from the header.
+ * @num_dumped_dwords: number of dwords that were dumped.
+ * @results_buf: buffer for printing the FW Asserts results.
  *
- * @return error if the parsing fails, ok otherwise.
+ * Return: Error if the parsing fails, ok otherwise.
  */
 enum dbg_status qed_print_fw_asserts_results(struct qed_hwfn *p_hwfn,
 					     u32 *dump_buf,
@@ -3696,15 +3710,15 @@ enum dbg_status qed_print_fw_asserts_results(struct qed_hwfn *p_hwfn,
 					     char *results_buf);
 
 /**
- * @brief qed_dbg_parse_attn - Parses and prints attention registers values in
- * the specified results struct.
+ * qed_dbg_parse_attn(): Parses and prints attention registers values in
+ *                      the specified results struct.
  *
- * @param p_hwfn -  HW device data
- * @param results - Pointer to the attention read results
+ * @p_hwfn: HW device data.
+ * @results: Pointer to the attention read results
  *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
+ * Return: Error if one of the following holds:
+ *         - The version wasn't set.
+ *           Otherwise, returns ok.
  */
 enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
 				   struct dbg_attn_block_result *results);
@@ -3746,18 +3760,18 @@ enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
 #define GTT_BAR0_MAP_REG_PSDM_RAM	0x01a000UL
 
 /**
- * @brief qed_qm_pf_mem_size - prepare QM ILT sizes
+ * qed_qm_pf_mem_size(): Prepare QM ILT sizes.
  *
- * Returns the required host memory size in 4KB units.
- * Must be called before all QM init HSI functions.
+ * @num_pf_cids: Number of connections used by this PF.
+ * @num_vf_cids: Number of connections used by VFs of this PF.
+ * @num_tids: Number of tasks used by this PF.
+ * @num_pf_pqs: Number of PQs used by this PF.
+ * @num_vf_pqs: Number of PQs used by VFs of this PF.
  *
- * @param num_pf_cids - number of connections used by this PF
- * @param num_vf_cids - number of connections used by VFs of this PF
- * @param num_tids - number of tasks used by this PF
- * @param num_pf_pqs - number of PQs used by this PF
- * @param num_vf_pqs - number of PQs used by VFs of this PF
+ * Return: The required host memory size in 4KB units.
  *
- * @return The required host memory size in 4KB units.
+ * Returns the required host memory size in 4KB units.
+ * Must be called before all QM init HSI functions.
  */
 u32 qed_qm_pf_mem_size(u32 num_pf_cids,
 		       u32 num_vf_cids,
@@ -3800,74 +3814,74 @@ int qed_qm_pf_rt_init(struct qed_hwfn *p_hwfn,
 	struct qed_qm_pf_rt_init_params *p_params);
 
 /**
- * @brief qed_init_pf_wfq - Initializes the WFQ weight of the specified PF
+ * qed_init_pf_wfq(): Initializes the WFQ weight of the specified PF.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers
- * @param pf_id - PF ID
- * @param pf_wfq - WFQ weight. Must be non-zero.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers
+ * @pf_id: PF ID
+ * @pf_wfq: WFQ weight. Must be non-zero.
  *
- * @return 0 on success, -1 on error.
+ * Return: 0 on success, -1 on error.
  */
 int qed_init_pf_wfq(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt, u8 pf_id, u16 pf_wfq);
 
 /**
- * @brief qed_init_pf_rl - Initializes the rate limit of the specified PF
+ * qed_init_pf_rl(): Initializes the rate limit of the specified PF
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers
- * @param pf_id - PF ID
- * @param pf_rl - rate limit in Mb/sec units
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @pf_id: PF ID.
+ * @pf_rl: rate limit in Mb/sec units
  *
- * @return 0 on success, -1 on error.
+ * Return: 0 on success, -1 on error.
  */
 int qed_init_pf_rl(struct qed_hwfn *p_hwfn,
 		   struct qed_ptt *p_ptt, u8 pf_id, u32 pf_rl);
 
 /**
- * @brief qed_init_vport_wfq Initializes the WFQ weight of the specified VPORT
+ * qed_init_vport_wfq(): Initializes the WFQ weight of the specified VPORT
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers
- * @param first_tx_pq_id- An array containing the first Tx PQ ID associated
- *	  with the VPORT for each TC. This array is filled by
- *	  qed_qm_pf_rt_init
- * @param vport_wfq - WFQ weight. Must be non-zero.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers
+ * @first_tx_pq_id: An array containing the first Tx PQ ID associated
+ *                  with the VPORT for each TC. This array is filled by
+ *                  qed_qm_pf_rt_init
+ * @wfq: WFQ weight. Must be non-zero.
  *
- * @return 0 on success, -1 on error.
+ * Return: 0 on success, -1 on error.
  */
 int qed_init_vport_wfq(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       u16 first_tx_pq_id[NUM_OF_TCS], u16 wfq);
 
 /**
- * @brief qed_init_global_rl - Initializes the rate limit of the specified
- * rate limiter
+ * qed_init_global_rl():  Initializes the rate limit of the specified
+ * rate limiter.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers
- * @param rl_id - RL ID
- * @param rate_limit - rate limit in Mb/sec units
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @rl_id: RL ID.
+ * @rate_limit: Rate limit in Mb/sec units
  *
- * @return 0 on success, -1 on error.
+ * Return: 0 on success, -1 on error.
  */
 int qed_init_global_rl(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       u16 rl_id, u32 rate_limit);
 
 /**
- * @brief qed_send_qm_stop_cmd  Sends a stop command to the QM
+ * qed_send_qm_stop_cmd(): Sends a stop command to the QM.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param is_release_cmd - true for release, false for stop.
- * @param is_tx_pq - true for Tx PQs, false for Other PQs.
- * @param start_pq - first PQ ID to stop
- * @param num_pqs - Number of PQs to stop, starting from start_pq.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @is_release_cmd: true for release, false for stop.
+ * @is_tx_pq: true for Tx PQs, false for Other PQs.
+ * @start_pq: first PQ ID to stop
+ * @num_pqs: Number of PQs to stop, starting from start_pq.
  *
- * @return bool, true if successful, false if timeout occurred while waiting for
- *	QM command done.
+ * Return: Bool, true if successful, false if timeout occurred while waiting
+ *         for QM command done.
  */
 bool qed_send_qm_stop_cmd(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt,
@@ -3875,53 +3889,64 @@ bool qed_send_qm_stop_cmd(struct qed_hwfn *p_hwfn,
 			  bool is_tx_pq, u16 start_pq, u16 num_pqs);
 
 /**
- * @brief qed_set_vxlan_dest_port - initializes vxlan tunnel destination udp port
+ * qed_set_vxlan_dest_port(): Initializes vxlan tunnel destination udp port.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
- * @param dest_port - vxlan destination udp port.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dest_port: vxlan destination udp port.
+ *
+ * Return: Void.
  */
 void qed_set_vxlan_dest_port(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt, u16 dest_port);
 
 /**
- * @brief qed_set_vxlan_enable - enable or disable VXLAN tunnel in HW
+ * qed_set_vxlan_enable(): Enable or disable VXLAN tunnel in HW.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @vxlan_enable: vxlan enable flag.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
- * @param vxlan_enable - vxlan enable flag.
+ * Return: Void.
  */
 void qed_set_vxlan_enable(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt, bool vxlan_enable);
 
 /**
- * @brief qed_set_gre_enable - enable or disable GRE tunnel in HW
+ * qed_set_gre_enable(): Enable or disable GRE tunnel in HW.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @eth_gre_enable: Eth GRE enable flag.
+ * @ip_gre_enable: IP GRE enable flag.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
- * @param eth_gre_enable - eth GRE enable enable flag.
- * @param ip_gre_enable - IP GRE enable enable flag.
+ * Return: Void.
  */
 void qed_set_gre_enable(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt,
 			bool eth_gre_enable, bool ip_gre_enable);
 
 /**
- * @brief qed_set_geneve_dest_port - initializes geneve tunnel destination udp port
+ * qed_set_geneve_dest_port(): Initializes geneve tunnel destination udp port
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
- * @param dest_port - geneve destination udp port.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @dest_port: Geneve destination udp port.
+ *
+ * Retur: Void.
  */
 void qed_set_geneve_dest_port(struct qed_hwfn *p_hwfn,
 			      struct qed_ptt *p_ptt, u16 dest_port);
 
 /**
- * @brief qed_set_gre_enable - enable or disable GRE tunnel in HW
+ * qed_set_geneve_enable(): Enable or disable GRE tunnel in HW.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @eth_geneve_enable: Eth GENEVE enable flag.
+ * @ip_geneve_enable: IP GENEVE enable flag.
  *
- * @param p_ptt - ptt window used for writing the registers.
- * @param eth_geneve_enable - eth GENEVE enable enable flag.
- * @param ip_geneve_enable - IP GENEVE enable enable flag.
+ * Return: Void.
  */
 void qed_set_geneve_enable(struct qed_hwfn *p_hwfn,
 			   struct qed_ptt *p_ptt,
@@ -3931,25 +3956,29 @@ void qed_set_vxlan_no_l2_enable(struct qed_hwfn *p_hwfn,
 				struct qed_ptt *p_ptt, bool enable);
 
 /**
- * @brief qed_gft_disable - Disable GFT
+ * qed_gft_disable(): Disable GFT.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @pf_id: PF on which to disable GFT.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
- * @param pf_id - pf on which to disable GFT.
+ * Return: Void.
  */
 void qed_gft_disable(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, u16 pf_id);
 
 /**
- * @brief qed_gft_config - Enable and configure HW for GFT
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - ptt window used for writing the registers.
- * @param pf_id - pf on which to enable GFT.
- * @param tcp - set profile tcp packets.
- * @param udp - set profile udp  packet.
- * @param ipv4 - set profile ipv4 packet.
- * @param ipv6 - set profile ipv6 packet.
- * @param profile_type - define packet same fields. Use enum gft_profile_type.
+ * qed_gft_config(): Enable and configure HW for GFT.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @pf_id: PF on which to enable GFT.
+ * @tcp: Set profile tcp packets.
+ * @udp: Set profile udp  packet.
+ * @ipv4: Set profile ipv4 packet.
+ * @ipv6: Set profile ipv6 packet.
+ * @profile_type: Define packet same fields. Use enum gft_profile_type.
+ *
+ * Return: Void.
  */
 void qed_gft_config(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt,
@@ -3959,107 +3988,120 @@ void qed_gft_config(struct qed_hwfn *p_hwfn,
 		    bool ipv4, bool ipv6, enum gft_profile_type profile_type);
 
 /**
- * @brief qed_enable_context_validation - Enable and configure context
- *	validation.
+ * qed_enable_context_validation(): Enable and configure context
+ *                                  validation.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
  *
- * @param p_hwfn
- * @param p_ptt - ptt window used for writing the registers.
+ * Return: Void.
  */
 void qed_enable_context_validation(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_calc_session_ctx_validation - Calcualte validation byte for
- *	session context.
+ * qed_calc_session_ctx_validation(): Calcualte validation byte for
+ *                                    session context.
  *
- * @param p_ctx_mem - pointer to context memory.
- * @param ctx_size - context size.
- * @param ctx_type - context type.
- * @param cid - context cid.
+ * @p_ctx_mem: Pointer to context memory.
+ * @ctx_size: Context size.
+ * @ctx_type: Context type.
+ * @cid: Context cid.
+ *
+ * Return: Void.
  */
 void qed_calc_session_ctx_validation(void *p_ctx_mem,
 				     u16 ctx_size, u8 ctx_type, u32 cid);
 
 /**
- * @brief qed_calc_task_ctx_validation - Calcualte validation byte for task
- *	context.
+ * qed_calc_task_ctx_validation(): Calcualte validation byte for task
+ *                                 context.
+ *
+ * @p_ctx_mem: Pointer to context memory.
+ * @ctx_size: Context size.
+ * @ctx_type: Context type.
+ * @tid: Context tid.
  *
- * @param p_ctx_mem - pointer to context memory.
- * @param ctx_size - context size.
- * @param ctx_type - context type.
- * @param tid - context tid.
+ * Return: Void.
  */
 void qed_calc_task_ctx_validation(void *p_ctx_mem,
 				  u16 ctx_size, u8 ctx_type, u32 tid);
 
 /**
- * @brief qed_memset_session_ctx - Memset session context to 0 while
- *	preserving validation bytes.
+ * qed_memset_session_ctx(): Memset session context to 0 while
+ *                            preserving validation bytes.
+ *
+ * @p_ctx_mem: Pointer to context memory.
+ * @ctx_size: Size to initialzie.
+ * @ctx_type: Context type.
  *
- * @param p_hwfn -
- * @param p_ctx_mem - pointer to context memory.
- * @param ctx_size - size to initialzie.
- * @param ctx_type - context type.
+ * Return: Void.
  */
 void qed_memset_session_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type);
 
 /**
- * @brief qed_memset_task_ctx - Memset task context to 0 while preserving
- *	validation bytes.
+ * qed_memset_task_ctx(): Memset task context to 0 while preserving
+ *                        validation bytes.
  *
- * @param p_ctx_mem - pointer to context memory.
- * @param ctx_size - size to initialzie.
- * @param ctx_type - context type.
+ * @p_ctx_mem: Pointer to context memory.
+ * @ctx_size: size to initialzie.
+ * @ctx_type: context type.
+ *
+ * Return: Void.
  */
 void qed_memset_task_ctx(void *p_ctx_mem, u32 ctx_size, u8 ctx_type);
 
 #define NUM_STORMS 6
 
 /**
- * @brief qed_set_rdma_error_level - Sets the RDMA assert level.
- *                                   If the severity of the error will be
- *                                   above the level, the FW will assert.
- * @param p_hwfn - HW device data
- * @param p_ptt - ptt window used for writing the registers
- * @param assert_level - An array of assert levels for each storm.
+ * qed_set_rdma_error_level(): Sets the RDMA assert level.
+ *                             If the severity of the error will be
+ *                             above the level, the FW will assert.
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @assert_level: An array of assert levels for each storm.
  *
+ * Return: Void.
  */
 void qed_set_rdma_error_level(struct qed_hwfn *p_hwfn,
 			      struct qed_ptt *p_ptt,
 			      u8 assert_level[NUM_STORMS]);
 /**
- * @brief qed_fw_overlay_mem_alloc - Allocates and fills the FW overlay memory.
+ * qed_fw_overlay_mem_alloc(): Allocates and fills the FW overlay memory.
  *
- * @param p_hwfn - HW device data
- * @param fw_overlay_in_buf - the input FW overlay buffer.
- * @param buf_size - the size of the input FW overlay buffer in bytes.
- *		     must be aligned to dwords.
- * @param fw_overlay_out_mem - OUT: a pointer to the allocated overlays memory.
+ * @p_hwfn: HW device data.
+ * @fw_overlay_in_buf: The input FW overlay buffer.
+ * @buf_size_in_bytes: The size of the input FW overlay buffer in bytes.
+ *		        must be aligned to dwords.
  *
- * @return a pointer to the allocated overlays memory,
+ * Return: A pointer to the allocated overlays memory,
  * or NULL in case of failures.
  */
 struct phys_mem_desc *
 qed_fw_overlay_mem_alloc(struct qed_hwfn *p_hwfn,
-			 const u32 * const fw_overlay_in_buf,
+			 const u32 *const fw_overlay_in_buf,
 			 u32 buf_size_in_bytes);
 
 /**
- * @brief qed_fw_overlay_init_ram - Initializes the FW overlay RAM.
+ * qed_fw_overlay_init_ram(): Initializes the FW overlay RAM.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @fw_overlay_mem: the allocated FW overlay memory.
  *
- * @param p_hwfn - HW device data.
- * @param p_ptt - ptt window used for writing the registers.
- * @param fw_overlay_mem - the allocated FW overlay memory.
+ * Return: Void.
  */
 void qed_fw_overlay_init_ram(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt,
 			     struct phys_mem_desc *fw_overlay_mem);
 
 /**
- * @brief qed_fw_overlay_mem_free - Frees the FW overlay memory.
+ * qed_fw_overlay_mem_free(): Frees the FW overlay memory.
+ *
+ * @p_hwfn: HW device data.
+ * @fw_overlay_mem: The allocated FW overlay memory to free.
  *
- * @param p_hwfn - HW device data.
- * @param fw_overlay_mem - the allocated FW overlay memory to free.
+ * Return: Void.
  */
 void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
 			     struct phys_mem_desc *fw_overlay_mem);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.h b/drivers/net/ethernet/qlogic/qed/qed_hw.h
index 2734f49956f7..e535983ce21b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.h
@@ -53,85 +53,94 @@ enum _dmae_cmd_crc_mask {
 #define DMAE_MAX_CLIENTS        32
 
 /**
- * @brief qed_gtt_init - Initialize GTT windows
+ * qed_gtt_init(): Initialize GTT windows.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_gtt_init(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ptt_invalidate - Forces all ptt entries to be re-configured
+ * qed_ptt_invalidate(): Forces all ptt entries to be re-configured
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_ptt_invalidate(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ptt_pool_alloc - Allocate and initialize PTT pool
+ * qed_ptt_pool_alloc(): Allocate and initialize PTT pool.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return struct _qed_status - success (0), negative - error.
+ * Return: struct _qed_status - success (0), negative - error.
  */
 int qed_ptt_pool_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ptt_pool_free -
+ * qed_ptt_pool_free(): Free PTT pool.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_ptt_pool_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ptt_get_hw_addr - Get PTT's GRC/HW address
+ * qed_ptt_get_hw_addr(): Get PTT's GRC/HW address.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt
  *
- * @return u32
+ * Return: u32.
  */
 u32 qed_ptt_get_hw_addr(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_ptt_get_bar_addr - Get PPT's external BAR address
+ * qed_ptt_get_bar_addr(): Get PPT's external BAR address.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_ptt: P_ptt
  *
- * @return u32
+ * Return: u32.
  */
 u32 qed_ptt_get_bar_addr(struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_ptt_set_win - Set PTT Window's GRC BAR address
+ * qed_ptt_set_win(): Set PTT Window's GRC BAR address
  *
- * @param p_hwfn
- * @param new_hw_addr
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @new_hw_addr: New HW address.
+ * @p_ptt: P_Ptt
+ *
+ * Return: Void.
  */
 void qed_ptt_set_win(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt,
 		     u32 new_hw_addr);
 
 /**
- * @brief qed_get_reserved_ptt - Get a specific reserved PTT
+ * qed_get_reserved_ptt(): Get a specific reserved PTT.
  *
- * @param p_hwfn
- * @param ptt_idx
+ * @p_hwfn: HW device data.
+ * @ptt_idx: Ptt Index.
  *
- * @return struct qed_ptt *
+ * Return: struct qed_ptt *.
  */
 struct qed_ptt *qed_get_reserved_ptt(struct qed_hwfn *p_hwfn,
 				     enum reserved_ptts ptt_idx);
 
 /**
- * @brief qed_wr - Write value to BAR using the given ptt
+ * qed_wr(): Write value to BAR using the given ptt.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @val: Val.
+ * @hw_addr: HW address
  *
- * @param p_hwfn
- * @param p_ptt
- * @param val
- * @param hw_addr
+ * Return: Void.
  */
 void qed_wr(struct qed_hwfn *p_hwfn,
 	    struct qed_ptt *p_ptt,
@@ -139,26 +148,28 @@ void qed_wr(struct qed_hwfn *p_hwfn,
 	    u32 val);
 
 /**
- * @brief qed_rd - Read value from BAR using the given ptt
+ * qed_rd(): Read value from BAR using the given ptt.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @hw_addr: HW address
  *
- * @param p_hwfn
- * @param p_ptt
- * @param val
- * @param hw_addr
+ * Return: Void.
  */
 u32 qed_rd(struct qed_hwfn *p_hwfn,
 	   struct qed_ptt *p_ptt,
 	   u32 hw_addr);
 
 /**
- * @brief qed_memcpy_from - copy n bytes from BAR using the given
- *        ptt
- *
- * @param p_hwfn
- * @param p_ptt
- * @param dest
- * @param hw_addr
- * @param n
+ * qed_memcpy_from(): Copy n bytes from BAR using the given ptt.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @dest: Destination.
+ * @hw_addr: HW address.
+ * @n: N
+ *
+ * Return: Void.
  */
 void qed_memcpy_from(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt,
@@ -167,14 +178,15 @@ void qed_memcpy_from(struct qed_hwfn *p_hwfn,
 		     size_t n);
 
 /**
- * @brief qed_memcpy_to - copy n bytes to BAR using the given
- *        ptt
- *
- * @param p_hwfn
- * @param p_ptt
- * @param hw_addr
- * @param src
- * @param n
+ * qed_memcpy_to(): Copy n bytes to BAR using the given  ptt
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @hw_addr: HW address.
+ * @src: Source.
+ * @n: N
+ *
+ * Return: Void.
  */
 void qed_memcpy_to(struct qed_hwfn *p_hwfn,
 		   struct qed_ptt *p_ptt,
@@ -182,83 +194,97 @@ void qed_memcpy_to(struct qed_hwfn *p_hwfn,
 		   void *src,
 		   size_t n);
 /**
- * @brief qed_fid_pretend - pretend to another function when
- *        accessing the ptt window. There is no way to unpretend
- *        a function. The only way to cancel a pretend is to
- *        pretend back to the original function.
- *
- * @param p_hwfn
- * @param p_ptt
- * @param fid - fid field of pxp_pretend structure. Can contain
- *            either pf / vf, port/path fields are don't care.
+ * qed_fid_pretend(): pretend to another function when
+ *                    accessing the ptt window. There is no way to unpretend
+ *                    a function. The only way to cancel a pretend is to
+ *                    pretend back to the original function.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @fid: fid field of pxp_pretend structure. Can contain
+ *        either pf / vf, port/path fields are don't care.
+ *
+ * Return: Void.
  */
 void qed_fid_pretend(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt,
 		     u16 fid);
 
 /**
- * @brief qed_port_pretend - pretend to another port when
- *        accessing the ptt window
+ * qed_port_pretend(): Pretend to another port when accessing the ptt window
  *
- * @param p_hwfn
- * @param p_ptt
- * @param port_id - the port to pretend to
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @port_id: The port to pretend to
+ *
+ * Return: Void.
  */
 void qed_port_pretend(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt,
 		      u8 port_id);
 
 /**
- * @brief qed_port_unpretend - cancel any previously set port
- *        pretend
+ * qed_port_unpretend(): Cancel any previously set port pretend
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Return: Void.
  */
 void qed_port_unpretend(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_port_fid_pretend - pretend to another port and another function
- *        when accessing the ptt window
+ * qed_port_fid_pretend(): Pretend to another port and another function
+ *                         when accessing the ptt window
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @port_id: The port to pretend to
+ * @fid: fid field of pxp_pretend structure. Can contain either pf / vf.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param port_id - the port to pretend to
- * @param fid - fid field of pxp_pretend structure. Can contain either pf / vf.
+ * Return: Void.
  */
 void qed_port_fid_pretend(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt, u8 port_id, u16 fid);
 
 /**
- * @brief qed_vfid_to_concrete - build a concrete FID for a
- *        given VF ID
+ * qed_vfid_to_concrete(): Build a concrete FID for a given VF ID
  *
- * @param p_hwfn
- * @param p_ptt
- * @param vfid
+ * @p_hwfn: HW device data.
+ * @vfid: VFID.
+ *
+ * Return: Void.
  */
 u32 qed_vfid_to_concrete(struct qed_hwfn *p_hwfn, u8 vfid);
 
 /**
- * @brief qed_dmae_idx_to_go_cmd - map the idx to dmae cmd
- * this is declared here since other files will require it.
- * @param idx
+ * qed_dmae_idx_to_go_cmd(): Map the idx to dmae cmd
+ *    this is declared here since other files will require it.
+ *
+ * @idx: Index
+ *
+ * Return: Void.
  */
 u32 qed_dmae_idx_to_go_cmd(u8 idx);
 
 /**
- * @brief qed_dmae_info_alloc - Init the dmae_info structure
- * which is part of p_hwfn.
- * @param p_hwfn
+ * qed_dmae_info_alloc(): Init the dmae_info structure
+ *                        which is part of p_hwfn.
+ *
+ * @p_hwfn: HW device data.
+ *
+ * Return: Int.
  */
 int qed_dmae_info_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_dmae_info_free - Free the dmae_info structure
- * which is part of p_hwfn
+ * qed_dmae_info_free(): Free the dmae_info structure
+ *                       which is part of p_hwfn.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_dmae_info_free(struct qed_hwfn *p_hwfn);
 
@@ -292,14 +318,16 @@ int qed_dmae_sanity(struct qed_hwfn *p_hwfn,
 #define QED_HW_ERR_MAX_STR_SIZE 256
 
 /**
- * @brief qed_hw_err_notify - Notify upper layer driver and management FW
- *	about a HW error.
- *
- * @param p_hwfn
- * @param p_ptt
- * @param err_type
- * @param fmt - debug data buffer to send to the MFW
- * @param ... - buffer format args
+ * qed_hw_err_notify(): Notify upper layer driver and management FW
+ *                      about a HW error.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @err_type: Err Type.
+ * @fmt: Debug data buffer to send to the MFW
+ * @...: buffer format args
+ *
+ * Return void.
  */
 void __printf(4, 5) __cold qed_hw_err_notify(struct qed_hwfn *p_hwfn,
 					     struct qed_ptt *p_ptt,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_ops.h b/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
index a573c8921982..1dbc460c9eec 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
@@ -12,23 +12,24 @@
 #include "qed.h"
 
 /**
- * @brief qed_init_iro_array - init iro_arr.
+ * qed_init_iro_array(): init iro_arr.
  *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Void.
  */
 void qed_init_iro_array(struct qed_dev *cdev);
 
 /**
- * @brief qed_init_run - Run the init-sequence.
+ * qed_init_run(): Run the init-sequence.
  *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @phase: Phase.
+ * @phase_id: Phase ID.
+ * @modes: Mode.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param phase
- * @param phase_id
- * @param modes
- * @return _qed_status_t
+ * Return: _qed_status_t
  */
 int qed_init_run(struct qed_hwfn *p_hwfn,
 		 struct qed_ptt *p_ptt,
@@ -37,30 +38,31 @@ int qed_init_run(struct qed_hwfn *p_hwfn,
 		 int modes);
 
 /**
- * @brief qed_init_hwfn_allocate - Allocate RT array, Store 'values' ptrs.
+ * qed_init_alloc(): Allocate RT array, Store 'values' ptrs.
  *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
- *
- * @return _qed_status_t
+ * Return: _qed_status_t.
  */
 int qed_init_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_init_hwfn_deallocate
+ * qed_init_free(): Init HW function deallocate.
  *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_init_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_init_store_rt_reg - Store a configuration value in the RT array.
+ * qed_init_store_rt_reg(): Store a configuration value in the RT array.
  *
+ * @p_hwfn: HW device data.
+ * @rt_offset: RT offset.
+ * @val: Val.
  *
- * @param p_hwfn
- * @param rt_offset
- * @param val
+ * Return: Void.
  */
 void qed_init_store_rt_reg(struct qed_hwfn *p_hwfn,
 			   u32 rt_offset,
@@ -72,15 +74,6 @@ void qed_init_store_rt_reg(struct qed_hwfn *p_hwfn,
 #define OVERWRITE_RT_REG(hwfn, offset, val) \
 	qed_init_store_rt_reg(hwfn, offset, val)
 
-/**
- * @brief
- *
- *
- * @param p_hwfn
- * @param rt_offset
- * @param val
- * @param size
- */
 void qed_init_store_rt_agg(struct qed_hwfn *p_hwfn,
 			   u32 rt_offset,
 			   u32 *val,
@@ -90,11 +83,12 @@ void qed_init_store_rt_agg(struct qed_hwfn *p_hwfn,
 	qed_init_store_rt_agg(hwfn, offset, (u32 *)&val, sizeof(val))
 
 /**
- * @brief
- *      Initialize GTT global windows and set admin window
- *      related params of GTT/PTT to default values.
+ * qed_gtt_init(): Initialize GTT global windows and set admin window
+ *                 related params of GTT/PTT to default values.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return Void.
  */
 void qed_gtt_init(struct qed_hwfn *p_hwfn);
 #endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.h b/drivers/net/ethernet/qlogic/qed/qed_int.h
index c5550e96bbe1..eb8e0f4242d7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.h
@@ -53,51 +53,54 @@ enum qed_coalescing_fsm {
 };
 
 /**
- * @brief qed_int_igu_enable_int - enable device interrupts
+ * qed_int_igu_enable_int(): Enable device interrupts.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param int_mode - interrupt mode to use
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @int_mode: Interrupt mode to use.
+ *
+ * Return: Void.
  */
 void qed_int_igu_enable_int(struct qed_hwfn *p_hwfn,
 			    struct qed_ptt *p_ptt,
 			    enum qed_int_mode int_mode);
 
 /**
- * @brief qed_int_igu_disable_int - disable device interrupts
+ * qed_int_igu_disable_int():  Disable device interrupts.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Return: Void.
  */
 void qed_int_igu_disable_int(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_int_igu_read_sisr_reg - Reads the single isr multiple dpc
- *        register from igu.
+ * qed_int_igu_read_sisr_reg(): Reads the single isr multiple dpc
+ *                             register from igu.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return u64
+ * Return: u64.
  */
 u64 qed_int_igu_read_sisr_reg(struct qed_hwfn *p_hwfn);
 
 #define QED_SP_SB_ID 0xffff
 /**
- * @brief qed_int_sb_init - Initializes the sb_info structure.
+ * qed_int_sb_init(): Initializes the sb_info structure.
  *
- * once the structure is initialized it can be passed to sb related functions.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @sb_info: points to an uninitialized (but allocated) sb_info structure
+ * @sb_virt_addr: SB Virtual address.
+ * @sb_phy_addr: SB Physial address.
+ * @sb_id: the sb_id to be used (zero based in driver)
+ *           should use QED_SP_SB_ID for SP Status block
  *
- * @param p_hwfn
- * @param p_ptt
- * @param sb_info	points to an uninitialized (but
- *			allocated) sb_info structure
- * @param sb_virt_addr
- * @param sb_phy_addr
- * @param sb_id	the sb_id to be used (zero based in driver)
- *			should use QED_SP_SB_ID for SP Status block
+ * Return: int.
  *
- * @return int
+ * Once the structure is initialized it can be passed to sb related functions.
  */
 int qed_int_sb_init(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt,
@@ -106,82 +109,91 @@ int qed_int_sb_init(struct qed_hwfn *p_hwfn,
 		    dma_addr_t sb_phy_addr,
 		    u16 sb_id);
 /**
- * @brief qed_int_sb_setup - Setup the sb.
+ * qed_int_sb_setup(): Setup the sb.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @sb_info: Initialized sb_info structure.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param sb_info	initialized sb_info structure
+ * Return: Void.
  */
 void qed_int_sb_setup(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt,
 		      struct qed_sb_info *sb_info);
 
 /**
- * @brief qed_int_sb_release - releases the sb_info structure.
+ * qed_int_sb_release(): Releases the sb_info structure.
  *
- * once the structure is released, it's memory can be freed
+ * @p_hwfn: HW device data.
+ * @sb_info: Points to an allocated sb_info structure.
+ * @sb_id: The sb_id to be used (zero based in driver)
+ *         should never be equal to QED_SP_SB_ID
+ *         (SP Status block).
  *
- * @param p_hwfn
- * @param sb_info	points to an allocated sb_info structure
- * @param sb_id		the sb_id to be used (zero based in driver)
- *			should never be equal to QED_SP_SB_ID
- *			(SP Status block)
+ * Return: int.
  *
- * @return int
+ * Once the structure is released, it's memory can be freed.
  */
 int qed_int_sb_release(struct qed_hwfn *p_hwfn,
 		       struct qed_sb_info *sb_info,
 		       u16 sb_id);
 
 /**
- * @brief qed_int_sp_dpc - To be called when an interrupt is received on the
- *        default status block.
+ * qed_int_sp_dpc(): To be called when an interrupt is received on the
+ *                   default status block.
  *
- * @param p_hwfn - pointer to hwfn
+ * @t: Tasklet.
+ *
+ * Return: Void.
  *
  */
 void qed_int_sp_dpc(struct tasklet_struct *t);
 
 /**
- * @brief qed_int_get_num_sbs - get the number of status
- *        blocks configured for this funciton in the igu.
+ * qed_int_get_num_sbs(): Get the number of status blocks configured
+ *                        for this funciton in the igu.
  *
- * @param p_hwfn
- * @param p_sb_cnt_info
+ * @p_hwfn: HW device data.
+ * @p_sb_cnt_info: Pointer to SB count info.
  *
- * @return int - number of status blocks configured
+ * Return: Void.
  */
 void qed_int_get_num_sbs(struct qed_hwfn	*p_hwfn,
 			 struct qed_sb_cnt_info *p_sb_cnt_info);
 
 /**
- * @brief qed_int_disable_post_isr_release - performs the cleanup post ISR
+ * qed_int_disable_post_isr_release(): Performs the cleanup post ISR
  *        release. The API need to be called after releasing all slowpath IRQs
  *        of the device.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
+ * Return: Void.
  */
 void qed_int_disable_post_isr_release(struct qed_dev *cdev);
 
 /**
- * @brief qed_int_attn_clr_enable - sets whether the general behavior is
+ * qed_int_attn_clr_enable: Sets whether the general behavior is
  *        preventing attentions from being reasserted, or following the
  *        attributes of the specific attention.
  *
- * @param cdev
- * @param clr_enable
+ * @cdev: Qed dev pointer.
+ * @clr_enable: Clear enable
+ *
+ * Return: Void.
  *
  */
 void qed_int_attn_clr_enable(struct qed_dev *cdev, bool clr_enable);
 
 /**
- * @brief - Doorbell Recovery handler.
+ * qed_db_rec_handler(): Doorbell Recovery handler.
  *          Run doorbell recovery in case of PF overflow (and flush DORQ if
  *          needed).
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Int.
  */
 int qed_db_rec_handler(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
@@ -223,30 +235,34 @@ struct qed_igu_info {
 };
 
 /**
- * @brief - Make sure the IGU CAM reflects the resources provided by MFW
+ * qed_int_igu_reset_cam(): Make sure the IGU CAM reflects the resources
+ *                          provided by MFW.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Return: Void.
  */
 int qed_int_igu_reset_cam(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Translate the weakly-defined client sb-id into an IGU sb-id
+ * qed_get_igu_sb_id(): Translate the weakly-defined client sb-id into
+ *                      an IGU sb-id
  *
- * @param p_hwfn
- * @param sb_id - user provided sb_id
+ * @p_hwfn: HW device data.
+ * @sb_id: user provided sb_id.
  *
- * @return an index inside IGU CAM where the SB resides
+ * Return: An index inside IGU CAM where the SB resides.
  */
 u16 qed_get_igu_sb_id(struct qed_hwfn *p_hwfn, u16 sb_id);
 
 /**
- * @brief return a pointer to an unused valid SB
+ * qed_get_igu_free_sb(): Return a pointer to an unused valid SB
  *
- * @param p_hwfn
- * @param b_is_pf - true iff we want a SB belonging to a PF
+ * @p_hwfn: HW device data.
+ * @b_is_pf: True iff we want a SB belonging to a PF.
  *
- * @return point to an igu_block, NULL if none is available
+ * Return: Point to an igu_block, NULL if none is available.
  */
 struct qed_igu_block *qed_get_igu_free_sb(struct qed_hwfn *p_hwfn,
 					  bool b_is_pf);
@@ -259,15 +275,15 @@ void qed_int_igu_init_pure_rt(struct qed_hwfn *p_hwfn,
 void qed_int_igu_init_rt(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_int_igu_read_cam - Reads the IGU CAM.
+ * qed_int_igu_read_cam():  Reads the IGU CAM.
  *	This function needs to be called during hardware
  *	prepare. It reads the info from igu cam to know which
  *	status block is the default / base status block etc.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int
+ * Return: Int.
  */
 int qed_int_igu_read_cam(struct qed_hwfn *p_hwfn,
 			 struct qed_ptt *p_ptt);
@@ -275,24 +291,22 @@ int qed_int_igu_read_cam(struct qed_hwfn *p_hwfn,
 typedef int (*qed_int_comp_cb_t)(struct qed_hwfn *p_hwfn,
 				 void *cookie);
 /**
- * @brief qed_int_register_cb - Register callback func for
- *      slowhwfn statusblock.
- *
- *	Every protocol that uses the slowhwfn status block
- *	should register a callback function that will be called
- *	once there is an update of the sp status block.
- *
- * @param p_hwfn
- * @param comp_cb - function to be called when there is an
- *                  interrupt on the sp sb
- *
- * @param cookie  - passed to the callback function
- * @param sb_idx  - OUT parameter which gives the chosen index
- *                  for this protocol.
- * @param p_fw_cons  - pointer to the actual address of the
- *                     consumer for this protocol.
- *
- * @return int
+ * qed_int_register_cb(): Register callback func for slowhwfn statusblock.
+ *
+ * @p_hwfn: HW device data.
+ * @comp_cb: Function to be called when there is an
+ *           interrupt on the sp sb
+ * @cookie: Passed to the callback function
+ * @sb_idx: (OUT) parameter which gives the chosen index
+ *           for this protocol.
+ * @p_fw_cons: Pointer to the actual address of the
+ *             consumer for this protocol.
+ *
+ * Return: Int.
+ *
+ * Every protocol that uses the slowhwfn status block
+ * should register a callback function that will be called
+ * once there is an update of the sp status block.
  */
 int qed_int_register_cb(struct qed_hwfn *p_hwfn,
 			qed_int_comp_cb_t comp_cb,
@@ -301,37 +315,40 @@ int qed_int_register_cb(struct qed_hwfn *p_hwfn,
 			__le16 **p_fw_cons);
 
 /**
- * @brief qed_int_unregister_cb - Unregisters callback
- *      function from sp sb.
- *      Partner of qed_int_register_cb -> should be called
- *      when no longer required.
+ * qed_int_unregister_cb(): Unregisters callback function from sp sb.
+ *
+ * @p_hwfn: HW device data.
+ * @pi: Producer Index.
  *
- * @param p_hwfn
- * @param pi
+ * Return: Int.
  *
- * @return int
+ * Partner of qed_int_register_cb -> should be called
+ * when no longer required.
  */
 int qed_int_unregister_cb(struct qed_hwfn *p_hwfn,
 			  u8 pi);
 
 /**
- * @brief qed_int_get_sp_sb_id - Get the slowhwfn sb id.
+ * qed_int_get_sp_sb_id(): Get the slowhwfn sb id.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return u16
+ * Return: u16.
  */
 u16 qed_int_get_sp_sb_id(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Status block cleanup. Should be called for each status
- *        block that will be used -> both PF / VF
- *
- * @param p_hwfn
- * @param p_ptt
- * @param igu_sb_id	- igu status block id
- * @param opaque	- opaque fid of the sb owner.
- * @param b_set		- set(1) / clear(0)
+ * qed_int_igu_init_pure_rt_single(): Status block cleanup.
+ *                                    Should be called for each status
+ *                                    block that will be used -> both PF / VF.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @igu_sb_id: IGU status block id.
+ * @opaque: Opaque fid of the sb owner.
+ * @b_set: Set(1) / Clear(0).
+ *
+ * Return: Void.
  */
 void qed_int_igu_init_pure_rt_single(struct qed_hwfn *p_hwfn,
 				     struct qed_ptt *p_ptt,
@@ -340,15 +357,16 @@ void qed_int_igu_init_pure_rt_single(struct qed_hwfn *p_hwfn,
 				     bool b_set);
 
 /**
- * @brief qed_int_cau_conf - configure cau for a given status
- *        block
- *
- * @param p_hwfn
- * @param ptt
- * @param sb_phys
- * @param igu_sb_id
- * @param vf_number
- * @param vf_valid
+ * qed_int_cau_conf_sb(): Configure cau for a given status block.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @sb_phys: SB Physical.
+ * @igu_sb_id: IGU status block id.
+ * @vf_number: VF number
+ * @vf_valid: VF valid or not.
+ *
+ * Return: Void.
  */
 void qed_int_cau_conf_sb(struct qed_hwfn *p_hwfn,
 			 struct qed_ptt *p_ptt,
@@ -358,52 +376,58 @@ void qed_int_cau_conf_sb(struct qed_hwfn *p_hwfn,
 			 u8 vf_valid);
 
 /**
- * @brief qed_int_alloc
+ * qed_int_alloc(): QED interrupt alloc.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int
+ * Return: Int.
  */
 int qed_int_alloc(struct qed_hwfn *p_hwfn,
 		  struct qed_ptt *p_ptt);
 
 /**
- * @brief qed_int_free
+ * qed_int_free(): QED interrupt free.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_int_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_int_setup
+ * qed_int_setup(): QED interrupt setup.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Void.
  */
 void qed_int_setup(struct qed_hwfn *p_hwfn,
 		   struct qed_ptt *p_ptt);
 
 /**
- * @brief - Enable Interrupt & Attention for hw function
+ * qed_int_igu_enable(): Enable Interrupt & Attention for hw function.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param int_mode
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @int_mode: Interrut mode
  *
- * @return int
+ * Return: Int.
  */
 int qed_int_igu_enable(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 		       enum qed_int_mode int_mode);
 
 /**
- * @brief - Initialize CAU status block entry
+ * qed_init_cau_sb_entry(): Initialize CAU status block entry.
+ *
+ * @p_hwfn: HW device data.
+ * @p_sb_entry: Pointer SB entry.
+ * @pf_id: PF number
+ * @vf_number: VF number
+ * @vf_valid: VF valid or not.
  *
- * @param p_hwfn
- * @param p_sb_entry
- * @param pf_id
- * @param vf_number
- * @param vf_valid
+ * Return: Void.
  */
 void qed_init_cau_sb_entry(struct qed_hwfn *p_hwfn,
 			   struct cau_sb_entry *p_sb_entry,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.h b/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
index dab7a5d09f87..dec2b00259d4 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
@@ -34,10 +34,13 @@ void qed_iscsi_setup(struct qed_hwfn *p_hwfn);
 void qed_iscsi_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief - Fills provided statistics struct with statistics.
+ * qed_get_protocol_stats_iscsi(): Fills provided statistics
+ *                                 struct with statistics.
  *
- * @param cdev
- * @param stats - points to struct that will be filled with statistics.
+ * @cdev: Qed dev pointer.
+ * @stats: Points to struct that will be filled with statistics.
+ *
+ * Return: Void.
  */
 void qed_get_protocol_stats_iscsi(struct qed_dev *cdev,
 				  struct qed_mcp_iscsi_stats *stats);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.h b/drivers/net/ethernet/qlogic/qed/qed_l2.h
index 8eceeebb1a7b..2ab7f3f0cf6c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.h
@@ -92,18 +92,18 @@ struct qed_filter_mcast {
 };
 
 /**
- * @brief qed_eth_rx_queue_stop - This ramrod closes an Rx queue
+ * qed_eth_rx_queue_stop(): This ramrod closes an Rx queue.
  *
- * @param p_hwfn
- * @param p_rxq			Handler of queue to close
- * @param eq_completion_only	If True completion will be on
- *				EQe, if False completion will be
- *				on EQe if p_hwfn opaque
- *				different from the RXQ opaque
- *				otherwise on CQe.
- * @param cqe_completion	If True completion will be
- *				receive on CQe.
- * @return int
+ * @p_hwfn: HW device data.
+ * @p_rxq: Handler of queue to close
+ * @eq_completion_only: If True completion will be on
+ *                      EQe, if False completion will be
+ *                      on EQe if p_hwfn opaque
+ *                      different from the RXQ opaque
+ *                      otherwise on CQe.
+ * @cqe_completion: If True completion will be receive on CQe.
+ *
+ * Return: Int.
  */
 int
 qed_eth_rx_queue_stop(struct qed_hwfn *p_hwfn,
@@ -111,12 +111,12 @@ qed_eth_rx_queue_stop(struct qed_hwfn *p_hwfn,
 		      bool eq_completion_only, bool cqe_completion);
 
 /**
- * @brief qed_eth_tx_queue_stop - closes a Tx queue
+ * qed_eth_tx_queue_stop(): Closes a Tx queue.
  *
- * @param p_hwfn
- * @param p_txq - handle to Tx queue needed to be closed
+ * @p_hwfn: HW device data.
+ * @p_txq: handle to Tx queue needed to be closed.
  *
- * @return int
+ * Return: Int.
  */
 int qed_eth_tx_queue_stop(struct qed_hwfn *p_hwfn, void *p_txq);
 
@@ -205,16 +205,15 @@ int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
 			struct qed_spq_comp_cb *p_comp_data);
 
 /**
- * @brief qed_sp_vport_stop -
- *
- * This ramrod closes a VPort after all its RX and TX queues are terminated.
- * An Assert is generated if any queues are left open.
+ * qed_sp_vport_stop: This ramrod closes a VPort after all its
+ *                    RX and TX queues are terminated.
+ *                    An Assert is generated if any queues are left open.
  *
- * @param p_hwfn
- * @param opaque_fid
- * @param vport_id VPort ID
+ * @p_hwfn: HW device data.
+ * @opaque_fid: Opaque FID
+ * @vport_id: VPort ID.
  *
- * @return int
+ * Return: Int.
  */
 int qed_sp_vport_stop(struct qed_hwfn *p_hwfn, u16 opaque_fid, u8 vport_id);
 
@@ -225,22 +224,21 @@ int qed_sp_eth_filter_ucast(struct qed_hwfn *p_hwfn,
 			    struct qed_spq_comp_cb *p_comp_data);
 
 /**
- * @brief qed_sp_rx_eth_queues_update -
- *
- * This ramrod updates an RX queue. It is used for setting the active state
- * of the queue and updating the TPA and SGE parameters.
+ * qed_sp_eth_rx_queues_update(): This ramrod updates an RX queue.
+ *                                It is used for setting the active state
+ *                                of the queue and updating the TPA and
+ *                                SGE parameters.
+ * @p_hwfn: HW device data.
+ * @pp_rxq_handlers: An array of queue handlers to be updated.
+ * @num_rxqs: number of queues to update.
+ * @complete_cqe_flg: Post completion to the CQE Ring if set.
+ * @complete_event_flg: Post completion to the Event Ring if set.
+ * @comp_mode: Comp mode.
+ * @p_comp_data: Pointer Comp data.
  *
- * @note At the moment - only used by non-linux VFs.
+ * Return: Int.
  *
- * @param p_hwfn
- * @param pp_rxq_handlers	An array of queue handlers to be updated.
- * @param num_rxqs              number of queues to update.
- * @param complete_cqe_flg	Post completion to the CQE Ring if set
- * @param complete_event_flg	Post completion to the Event Ring if set
- * @param comp_mode
- * @param p_comp_data
- *
- * @return int
+ * Note At the moment - only used by non-linux VFs.
  */
 
 int
@@ -257,30 +255,32 @@ void qed_get_vport_stats(struct qed_dev *cdev, struct qed_eth_stats *stats);
 void qed_reset_vport_stats(struct qed_dev *cdev);
 
 /**
- * *@brief qed_arfs_mode_configure -
- *
- **Enable or disable rfs mode. It must accept atleast one of tcp or udp true
- **and atleast one of ipv4 or ipv6 true to enable rfs mode.
+ * qed_arfs_mode_configure(): Enable or disable rfs mode.
+ *                            It must accept at least one of tcp or udp true
+ *                            and at least one of ipv4 or ipv6 true to enable
+ *                            rfs mode.
  *
- **@param p_hwfn
- **@param p_ptt
- **@param p_cfg_params - arfs mode configuration parameters.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_cfg_params: arfs mode configuration parameters.
  *
+ * Return. Void.
  */
 void qed_arfs_mode_configure(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt,
 			     struct qed_arfs_config_params *p_cfg_params);
 
 /**
- * @brief - qed_configure_rfs_ntuple_filter
+ * qed_configure_rfs_ntuple_filter(): This ramrod should be used to add
+ *                                     or remove arfs hw filter
  *
- * This ramrod should be used to add or remove arfs hw filter
+ * @p_hwfn: HW device data.
+ * @p_cb: Used for QED_SPQ_MODE_CB,where client would initialize
+ *        it with cookie and callback function address, if not
+ *        using this mode then client must pass NULL.
+ * @p_params: Pointer to params.
  *
- * @params p_hwfn
- * @params p_cb - Used for QED_SPQ_MODE_CB,where client would initialize
- *		  it with cookie and callback function address, if not
- *		  using this mode then client must pass NULL.
- * @params p_params
+ * Return: Void.
  */
 int
 qed_configure_rfs_ntuple_filter(struct qed_hwfn *p_hwfn,
@@ -374,16 +374,17 @@ qed_sp_eth_vport_start(struct qed_hwfn *p_hwfn,
 		       struct qed_sp_vport_start_params *p_params);
 
 /**
- * @brief - Starts an Rx queue, when queue_cid is already prepared
+ * qed_eth_rxq_start_ramrod(): Starts an Rx queue, when queue_cid is
+ *                             already prepared
  *
- * @param p_hwfn
- * @param p_cid
- * @param bd_max_bytes
- * @param bd_chain_phys_addr
- * @param cqe_pbl_addr
- * @param cqe_pbl_size
+ * @p_hwfn: HW device data.
+ * @p_cid: Pointer CID.
+ * @bd_max_bytes: Max bytes.
+ * @bd_chain_phys_addr: Chain physcial address.
+ * @cqe_pbl_addr: PBL address.
+ * @cqe_pbl_size: PBL size.
  *
- * @return int
+ * Return: Int.
  */
 int
 qed_eth_rxq_start_ramrod(struct qed_hwfn *p_hwfn,
@@ -393,15 +394,16 @@ qed_eth_rxq_start_ramrod(struct qed_hwfn *p_hwfn,
 			 dma_addr_t cqe_pbl_addr, u16 cqe_pbl_size);
 
 /**
- * @brief - Starts a Tx queue, where queue_cid is already prepared
+ * qed_eth_txq_start_ramrod(): Starts a Tx queue, where queue_cid is
+ *                             already prepared
  *
- * @param p_hwfn
- * @param p_cid
- * @param pbl_addr
- * @param pbl_size
- * @param p_pq_params - parameters for choosing the PQ for this Tx queue
+ * @p_hwfn: HW device data.
+ * @p_cid: Pointer CID.
+ * @pbl_addr: PBL address.
+ * @pbl_size: PBL size.
+ * @pq_id: Parameters for choosing the PQ for this Tx queue.
  *
- * @return int
+ * Return: Int.
  */
 int
 qed_eth_txq_start_ramrod(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index df88d00053a2..f80f7739ff8d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -119,41 +119,41 @@ struct qed_ll2_info {
 extern const struct qed_ll2_ops qed_ll2_ops_pass;
 
 /**
- * @brief qed_ll2_acquire_connection - allocate resources,
- *        starts rx & tx (if relevant) queues pair. Provides
- *        connecion handler as output parameter.
+ * qed_ll2_acquire_connection(): Allocate resources,
+ *                               starts rx & tx (if relevant) queues pair.
+ *                               Provides connecion handler as output
+ *                               parameter.
  *
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @data: Describes connection parameters.
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param data - describes connection parameters
- * @return int
+ * Return: Int.
  */
 int qed_ll2_acquire_connection(void *cxt, struct qed_ll2_acquire_data *data);
 
 /**
- * @brief qed_ll2_establish_connection - start previously
- *        allocated LL2 queues pair
+ * qed_ll2_establish_connection(): start previously allocated LL2 queues pair
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param p_ptt
- * @param connection_handle	LL2 connection's handle obtained from
- *                              qed_ll2_require_connection
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                     qed_ll2_require_connection.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_establish_connection(void *cxt, u8 connection_handle);
 
 /**
- * @brief qed_ll2_post_rx_buffers - submit buffers to LL2 Rx queue.
+ * qed_ll2_post_rx_buffer(): Submit buffers to LL2 Rx queue.
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle	LL2 connection's handle obtained from
- *				qed_ll2_require_connection
- * @param addr			rx (physical address) buffers to submit
- * @param cookie
- * @param notify_fw		produce corresponding Rx BD immediately
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                     qed_ll2_require_connection.
+ * @addr: RX (physical address) buffers to submit.
+ * @buf_len: Buffer Len.
+ * @cookie: Cookie.
+ * @notify_fw: Produce corresponding Rx BD immediately.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_post_rx_buffer(void *cxt,
 			   u8 connection_handle,
@@ -161,15 +161,15 @@ int qed_ll2_post_rx_buffer(void *cxt,
 			   u16 buf_len, void *cookie, u8 notify_fw);
 
 /**
- * @brief qed_ll2_prepare_tx_packet - request for start Tx BD
- *				      to prepare Tx packet submission to FW.
+ * qed_ll2_prepare_tx_packet(): Request for start Tx BD
+ *				to prepare Tx packet submission to FW.
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle
- * @param pkt - info regarding the tx packet
- * @param notify_fw - issue doorbell to fw for this packet
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: Connection handle.
+ * @pkt: Info regarding the tx packet.
+ * @notify_fw: Issue doorbell to fw for this packet.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_prepare_tx_packet(void *cxt,
 			      u8 connection_handle,
@@ -177,81 +177,83 @@ int qed_ll2_prepare_tx_packet(void *cxt,
 			      bool notify_fw);
 
 /**
- * @brief qed_ll2_release_connection -	releases resources
- *					allocated for LL2 connection
+ * qed_ll2_release_connection(): Releases resources allocated for LL2
+ *                               connection.
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle		LL2 connection's handle obtained from
- *					qed_ll2_require_connection
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                     qed_ll2_require_connection.
+ *
+ * Return: Void.
  */
 void qed_ll2_release_connection(void *cxt, u8 connection_handle);
 
 /**
- * @brief qed_ll2_set_fragment_of_tx_packet -	provides fragments to fill
- *						Tx BD of BDs requested by
- *						qed_ll2_prepare_tx_packet
+ * qed_ll2_set_fragment_of_tx_packet(): Provides fragments to fill
+ *                                      Tx BD of BDs requested by
+ *                                      qed_ll2_prepare_tx_packet
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle			LL2 connection's handle
- *						obtained from
- *						qed_ll2_require_connection
- * @param addr
- * @param nbytes
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                     qed_ll2_require_connection.
+ * @addr: Address.
+ * @nbytes: Number of bytes.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_set_fragment_of_tx_packet(void *cxt,
 				      u8 connection_handle,
 				      dma_addr_t addr, u16 nbytes);
 
 /**
- * @brief qed_ll2_terminate_connection -	stops Tx/Rx queues
- *
+ * qed_ll2_terminate_connection(): Stops Tx/Rx queues
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle			LL2 connection's handle
- *						obtained from
- *						qed_ll2_require_connection
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                    qed_ll2_require_connection.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_terminate_connection(void *cxt, u8 connection_handle);
 
 /**
- * @brief qed_ll2_get_stats -	get LL2 queue's statistics
- *
+ * qed_ll2_get_stats(): Get LL2 queue's statistics
  *
- * @param cxt - pointer to the hw-function [opaque to some]
- * @param connection_handle	LL2 connection's handle obtained from
- *				qed_ll2_require_connection
- * @param p_stats
+ * @cxt: Pointer to the hw-function [opaque to some].
+ * @connection_handle: LL2 connection's handle obtained from
+ *                    qed_ll2_require_connection.
+ * @p_stats: Pointer Status.
  *
- * @return 0 on success, failure otherwise
+ * Return: 0 on success, failure otherwise.
  */
 int qed_ll2_get_stats(void *cxt,
 		      u8 connection_handle, struct qed_ll2_stats *p_stats);
 
 /**
- * @brief qed_ll2_alloc - Allocates LL2 connections set
+ * qed_ll2_alloc(): Allocates LL2 connections set.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_ll2_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ll2_setup - Inits LL2 connections set
+ * qed_ll2_setup(): Inits LL2 connections set.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  *
  */
 void qed_ll2_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_ll2_free - Releases LL2 connections set
+ * qed_ll2_free(): Releases LL2 connections set
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  *
  */
 void qed_ll2_free(struct qed_hwfn *p_hwfn);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
index 8edb450d0abf..352b757183e8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -266,97 +266,97 @@ union qed_mfw_tlv_data {
 #define QED_NVM_CFG_OPTION_ENTITY_SEL	BIT(4)
 
 /**
- * @brief - returns the link params of the hw function
+ * qed_mcp_get_link_params(): Returns the link params of the hw function.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @returns pointer to link params
+ * Returns: Pointer to link params.
  */
-struct qed_mcp_link_params *qed_mcp_get_link_params(struct qed_hwfn *);
+struct qed_mcp_link_params *qed_mcp_get_link_params(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief - return the link state of the hw function
+ * qed_mcp_get_link_state(): Return the link state of the hw function.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @returns pointer to link state
+ * Returns: Pointer to link state.
  */
-struct qed_mcp_link_state *qed_mcp_get_link_state(struct qed_hwfn *);
+struct qed_mcp_link_state *qed_mcp_get_link_state(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief - return the link capabilities of the hw function
+ * qed_mcp_get_link_capabilities(): Return the link capabilities of the
+ *                                  hw function.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @returns pointer to link capabilities
+ * Returns: Pointer to link capabilities.
  */
 struct qed_mcp_link_capabilities
 	*qed_mcp_get_link_capabilities(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Request the MFW to set the the link according to 'link_input'.
+ * qed_mcp_set_link(): Request the MFW to set the link according
+ *                     to 'link_input'.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param b_up - raise link if `true'. Reset link if `false'.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @b_up: Raise link if `true'. Reset link if `false'.
  *
- * @return int
+ * Return: Int.
  */
 int qed_mcp_set_link(struct qed_hwfn   *p_hwfn,
 		     struct qed_ptt     *p_ptt,
 		     bool               b_up);
 
 /**
- * @brief Get the management firmware version value
+ * qed_mcp_get_mfw_ver(): Get the management firmware version value.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_mfw_ver    - mfw version value
- * @param p_running_bundle_id	- image id in nvram; Optional.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_mfw_ver: MFW version value.
+ * @p_running_bundle_id: Image id in nvram; Optional.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - operation was successful.
  */
 int qed_mcp_get_mfw_ver(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt,
 			u32 *p_mfw_ver, u32 *p_running_bundle_id);
 
 /**
- * @brief Get the MBI version value
+ * qed_mcp_get_mbi_ver(): Get the MBI version value.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_mbi_ver - A pointer to a variable to be filled with the MBI version.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_mbi_ver: A pointer to a variable to be filled with the MBI version.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - operation was successful.
  */
 int qed_mcp_get_mbi_ver(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt, u32 *p_mbi_ver);
 
 /**
- * @brief Get media type value of the port.
+ * qed_mcp_get_media_type(): Get media type value of the port.
  *
- * @param cdev      - qed dev pointer
- * @param p_ptt
- * @param mfw_ver    - media type value
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @media_type: Media type value
  *
- * @return int -
- *      0 - Operation was successul.
- *      -EBUSY - Operation failed
+ * Return: Int - 0 - Operation was successul.
+ *              -EBUSY - Operation failed
  */
 int qed_mcp_get_media_type(struct qed_hwfn *p_hwfn,
 			   struct qed_ptt *p_ptt, u32 *media_type);
 
 /**
- * @brief Get transceiver data of the port.
+ * qed_mcp_get_transceiver_data(): Get transceiver data of the port.
  *
- * @param cdev      - qed dev pointer
- * @param p_ptt
- * @param p_transceiver_state - transceiver state.
- * @param p_transceiver_type - media type value
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_transceiver_state: Transceiver state.
+ * @p_tranceiver_type: Media type value.
  *
- * @return int -
- *      0 - Operation was successful.
- *      -EBUSY - Operation failed
+ * Return: Int - 0 - Operation was successul.
+ *              -EBUSY - Operation failed
  */
 int qed_mcp_get_transceiver_data(struct qed_hwfn *p_hwfn,
 				 struct qed_ptt *p_ptt,
@@ -364,50 +364,48 @@ int qed_mcp_get_transceiver_data(struct qed_hwfn *p_hwfn,
 				 u32 *p_tranceiver_type);
 
 /**
- * @brief Get transceiver supported speed mask.
+ * qed_mcp_trans_speed_mask(): Get transceiver supported speed mask.
  *
- * @param cdev      - qed dev pointer
- * @param p_ptt
- * @param p_speed_mask - Bit mask of all supported speeds.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_speed_mask: Bit mask of all supported speeds.
  *
- * @return int -
- *      0 - Operation was successful.
- *      -EBUSY - Operation failed
+ * Return: Int - 0 - Operation was successul.
+ *              -EBUSY - Operation failed
  */
 
 int qed_mcp_trans_speed_mask(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt, u32 *p_speed_mask);
 
 /**
- * @brief Get board configuration.
+ * qed_mcp_get_board_config(): Get board configuration.
  *
- * @param cdev      - qed dev pointer
- * @param p_ptt
- * @param p_board_config - Board config.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_board_config: Board config.
  *
- * @return int -
- *      0 - Operation was successful.
- *      -EBUSY - Operation failed
+ * Return: Int - 0 - Operation was successul.
+ *              -EBUSY - Operation failed
  */
 int qed_mcp_get_board_config(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt, u32 *p_board_config);
 
 /**
- * @brief General function for sending commands to the MCP
- *        mailbox. It acquire mutex lock for the entire
- *        operation, from sending the request until the MCP
- *        response. Waiting for MCP response will be checked up
- *        to 5 seconds every 5ms.
+ * qed_mcp_cmd(): General function for sending commands to the MCP
+ *                mailbox. It acquire mutex lock for the entire
+ *                operation, from sending the request until the MCP
+ *                response. Waiting for MCP response will be checked up
+ *                to 5 seconds every 5ms.
  *
- * @param p_hwfn     - hw function
- * @param p_ptt      - PTT required for register access
- * @param cmd        - command to be sent to the MCP.
- * @param param      - Optional param
- * @param o_mcp_resp - The MCP response code (exclude sequence).
- * @param o_mcp_param- Optional parameter provided by the MCP
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @cmd: command to be sent to the MCP.
+ * @param: Optional param
+ * @o_mcp_resp: The MCP response code (exclude sequence).
+ * @o_mcp_param: Optional parameter provided by the MCP
  *                     response
- * @return int - 0 - operation
- * was successul.
+ *
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
 		struct qed_ptt *p_ptt,
@@ -417,37 +415,39 @@ int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
 		u32 *o_mcp_param);
 
 /**
- * @brief - drains the nig, allowing completion to pass in case of pauses.
- *          (Should be called only from sleepable context)
+ * qed_mcp_drain(): drains the nig, allowing completion to pass in
+ *                  case of pauses.
+ *                  (Should be called only from sleepable context)
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ *
+ * Return: Int.
  */
 int qed_mcp_drain(struct qed_hwfn *p_hwfn,
 		  struct qed_ptt *p_ptt);
 
 /**
- * @brief Get the flash size value
+ * qed_mcp_get_flash_size(): Get the flash size value.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_flash_size  - flash size in bytes to be filled.
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @p_flash_size: Flash size in bytes to be filled.
  *
- * @return int - 0 - operation was successul.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_get_flash_size(struct qed_hwfn     *p_hwfn,
 			   struct qed_ptt       *p_ptt,
 			   u32 *p_flash_size);
 
 /**
- * @brief Send driver version to MFW
+ * qed_mcp_send_drv_version(): Send driver version to MFW.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param version - Version value
- * @param name - Protocol driver name
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @p_ver: Version value.
  *
- * @return int - 0 - operation was successul.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_send_drv_version(struct qed_hwfn *p_hwfn,
@@ -455,146 +455,148 @@ qed_mcp_send_drv_version(struct qed_hwfn *p_hwfn,
 			 struct qed_mcp_drv_version *p_ver);
 
 /**
- * @brief Read the MFW process kill counter
+ * qed_get_process_kill_counter(): Read the MFW process kill counter.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
  *
- * @return u32
+ * Return: u32.
  */
 u32 qed_get_process_kill_counter(struct qed_hwfn *p_hwfn,
 				 struct qed_ptt *p_ptt);
 
 /**
- * @brief Trigger a recovery process
+ * qed_start_recovery_process(): Trigger a recovery process.
  *
- *  @param p_hwfn
- *  @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
  *
- * @return int
+ * Return: Int.
  */
 int qed_start_recovery_process(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief A recovery handler must call this function as its first step.
- *        It is assumed that the handler is not run from an interrupt context.
+ * qed_recovery_prolog(): A recovery handler must call this function
+ *                        as its first step.
+ *                        It is assumed that the handler is not run from
+ *                        an interrupt context.
  *
- *  @param cdev
- *  @param p_ptt
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: int.
  */
 int qed_recovery_prolog(struct qed_dev *cdev);
 
 /**
- * @brief Notify MFW about the change in base device properties
+ * qed_mcp_ov_update_current_config(): Notify MFW about the change in base
+ *                                    device properties
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param client - qed client type
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @client: Qed client type.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_current_config(struct qed_hwfn *p_hwfn,
 				     struct qed_ptt *p_ptt,
 				     enum qed_ov_client client);
 
 /**
- * @brief Notify MFW about the driver state
+ * qed_mcp_ov_update_driver_state(): Notify MFW about the driver state.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param drv_state - Driver state
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @drv_state: Driver state.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_driver_state(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt,
 				   enum qed_ov_driver_state drv_state);
 
 /**
- * @brief Send MTU size to MFW
+ * qed_mcp_ov_update_mtu(): Send MTU size to MFW.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param mtu - MTU size
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @mtu: MTU size.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_mtu(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt, u16 mtu);
 
 /**
- * @brief Send MAC address to MFW
+ * qed_mcp_ov_update_mac(): Send MAC address to MFW.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param mac - MAC address
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @mac: MAC address.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_mac(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt, u8 *mac);
 
 /**
- * @brief Send WOL mode to MFW
+ * qed_mcp_ov_update_wol(): Send WOL mode to MFW.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param wol - WOL mode
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @wol: WOL mode.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_wol(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt,
 			  enum qed_ov_wol wol);
 
 /**
- * @brief Set LED status
+ * qed_mcp_set_led(): Set LED status.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param mode - LED mode
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @mode: LED mode.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_set_led(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt,
 		    enum qed_led_mode mode);
 
 /**
- * @brief Read from nvm
+ * qed_mcp_nvm_read(): Read from NVM.
  *
- *  @param cdev
- *  @param addr - nvm offset
- *  @param p_buf - nvm read buffer
- *  @param len - buffer len
+ * @cdev: Qed dev pointer.
+ * @addr: NVM offset.
+ * @p_buf: NVM read buffer.
+ * @len: Buffer len.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_nvm_read(struct qed_dev *cdev, u32 addr, u8 *p_buf, u32 len);
 
 /**
- * @brief Write to nvm
+ * qed_mcp_nvm_write(): Write to NVM.
  *
- *  @param cdev
- *  @param addr - nvm offset
- *  @param cmd - nvm command
- *  @param p_buf - nvm write buffer
- *  @param len - buffer len
+ * @cdev: Qed dev pointer.
+ * @addr: NVM offset.
+ * @cmd: NVM command.
+ * @p_buf: NVM write buffer.
+ * @len: Buffer len.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_nvm_write(struct qed_dev *cdev,
 		      u32 cmd, u32 addr, u8 *p_buf, u32 len);
 
 /**
- * @brief Check latest response
+ * qed_mcp_nvm_resp(): Check latest response.
  *
- *  @param cdev
- *  @param p_buf - nvm write buffer
+ * @cdev: Qed dev pointer.
+ * @p_buf: NVM write buffer.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_nvm_resp(struct qed_dev *cdev, u8 *p_buf);
 
@@ -604,13 +606,13 @@ struct qed_nvm_image_att {
 };
 
 /**
- * @brief Allows reading a whole nvram image
+ * qed_mcp_get_nvm_image_att(): Allows reading a whole nvram image.
  *
- * @param p_hwfn
- * @param image_id - image to get attributes for
- * @param p_image_att - image attributes structure into which to fill data
+ * @p_hwfn: HW device data.
+ * @image_id: Image to get attributes for.
+ * @p_image_att: Image attributes structure into which to fill data.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_get_nvm_image_att(struct qed_hwfn *p_hwfn,
@@ -618,64 +620,65 @@ qed_mcp_get_nvm_image_att(struct qed_hwfn *p_hwfn,
 			  struct qed_nvm_image_att *p_image_att);
 
 /**
- * @brief Allows reading a whole nvram image
+ * qed_mcp_get_nvm_image(): Allows reading a whole nvram image.
  *
- * @param p_hwfn
- * @param image_id - image requested for reading
- * @param p_buffer - allocated buffer into which to fill data
- * @param buffer_len - length of the allocated buffer.
+ * @p_hwfn: HW device data.
+ * @image_id: image requested for reading.
+ * @p_buffer: allocated buffer into which to fill data.
+ * @buffer_len: length of the allocated buffer.
  *
- * @return 0 iff p_buffer now contains the nvram image.
+ * Return: 0 if p_buffer now contains the nvram image.
  */
 int qed_mcp_get_nvm_image(struct qed_hwfn *p_hwfn,
 			  enum qed_nvm_images image_id,
 			  u8 *p_buffer, u32 buffer_len);
 
 /**
- * @brief Bist register test
+ * qed_mcp_bist_register_test(): Bist register test.
  *
- *  @param p_hwfn    - hw function
- *  @param p_ptt     - PTT required for register access
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_bist_register_test(struct qed_hwfn *p_hwfn,
 			       struct qed_ptt *p_ptt);
 
 /**
- * @brief Bist clock test
+ * qed_mcp_bist_clock_test(): Bist clock test.
  *
- *  @param p_hwfn    - hw function
- *  @param p_ptt     - PTT required for register access
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_bist_clock_test(struct qed_hwfn *p_hwfn,
 			    struct qed_ptt *p_ptt);
 
 /**
- * @brief Bist nvm test - get number of images
+ * qed_mcp_bist_nvm_get_num_images(): Bist nvm test - get number of images.
  *
- *  @param p_hwfn       - hw function
- *  @param p_ptt        - PTT required for register access
- *  @param num_images   - number of images if operation was
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @num_images: number of images if operation was
  *			  successful. 0 if not.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_bist_nvm_get_num_images(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt,
 				    u32 *num_images);
 
 /**
- * @brief Bist nvm test - get image attributes by index
+ * qed_mcp_bist_nvm_get_image_att(): Bist nvm test - get image attributes
+ *                                   by index.
  *
- *  @param p_hwfn      - hw function
- *  @param p_ptt       - PTT required for register access
- *  @param p_image_att - Attributes of image
- *  @param image_index - Index of image to get information for
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @p_image_att: Attributes of image.
+ * @image_index: Index of image to get information for.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_bist_nvm_get_image_att(struct qed_hwfn *p_hwfn,
 				   struct qed_ptt *p_ptt,
@@ -683,23 +686,26 @@ int qed_mcp_bist_nvm_get_image_att(struct qed_hwfn *p_hwfn,
 				   u32 image_index);
 
 /**
- * @brief - Processes the TLV request from MFW i.e., get the required TLV info
- *          from the qed client and send it to the MFW.
+ * qed_mfw_process_tlv_req(): Processes the TLV request from MFW i.e.,
+ *                            get the required TLV info
+ *                            from the qed client and send it to the MFW.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mfw_process_tlv_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Send raw debug data to the MFW
+ * qed_mcp_send_raw_debug_data(): Send raw debug data to the MFW
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_buf: raw debug data buffer.
+ * @size: Buffer size.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_buf - raw debug data buffer
- * @param size - buffer size
+ * Return : Int.
  */
 int
 qed_mcp_send_raw_debug_data(struct qed_hwfn *p_hwfn,
@@ -796,47 +802,49 @@ qed_mcp_is_ext_speed_supported(const struct qed_hwfn *p_hwfn)
 }
 
 /**
- * @brief Initialize the interface with the MCP
+ * qed_mcp_cmd_init(): Initialize the interface with the MCP.
  *
- * @param p_hwfn - HW func
- * @param p_ptt - PTT required for register access
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
  *
- * @return int
+ * Return: Int.
  */
 int qed_mcp_cmd_init(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt);
 
 /**
- * @brief Initialize the port interface with the MCP
+ * qed_mcp_cmd_port_init(): Initialize the port interface with the MCP
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Void.
  *
- * @param p_hwfn
- * @param p_ptt
  * Can only be called after `num_ports_in_engines' is set
  */
 void qed_mcp_cmd_port_init(struct qed_hwfn *p_hwfn,
 			   struct qed_ptt *p_ptt);
 /**
- * @brief Releases resources allocated during the init process.
+ * qed_mcp_free(): Releases resources allocated during the init process.
  *
- * @param p_hwfn - HW func
- * @param p_ptt - PTT required for register access
+ * @p_hwfn: HW function.
  *
- * @return int
+ * Return: Int.
  */
 
 int qed_mcp_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief This function is called from the DPC context. After
- * pointing PTT to the mfw mb, check for events sent by the MCP
- * to the driver and ack them. In case a critical event
- * detected, it will be handled here, otherwise the work will be
- * queued to a sleepable work-queue.
+ * qed_mcp_handle_events(): This function is called from the DPC context.
+ *           After pointing PTT to the mfw mb, check for events sent by
+ *           the MCP to the driver and ack them. In case a critical event
+ *           detected, it will be handled here, otherwise the work will be
+ *            queued to a sleepable work-queue.
+ *
+ * @p_hwfn: HW function.
+ * @p_ptt: PTT required for register access.
  *
- * @param p_hwfn - HW function
- * @param p_ptt - PTT required for register access
- * @return int - 0 - operation
- * was successul.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_handle_events(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt);
@@ -858,106 +866,111 @@ struct qed_load_req_params {
 };
 
 /**
- * @brief Sends a LOAD_REQ to the MFW, and in case the operation succeeds,
- *        returns whether this PF is the first on the engine/port or function.
+ * qed_mcp_load_req(): Sends a LOAD_REQ to the MFW, and in case the
+ *                     operation succeeds, returns whether this PF is
+ *                     the first on the engine/port or function.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_params
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_params: Params.
  *
- * @return int - 0 - Operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt,
 		     struct qed_load_req_params *p_params);
 
 /**
- * @brief Sends a LOAD_DONE message to the MFW
+ * qed_mcp_load_done(): Sends a LOAD_DONE message to the MFW.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int - 0 - Operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_load_done(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Sends a UNLOAD_REQ message to the MFW
+ * qed_mcp_unload_req(): Sends a UNLOAD_REQ message to the MFW.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int - 0 - Operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Sends a UNLOAD_DONE message to the MFW
+ * qed_mcp_unload_done(): Sends a UNLOAD_DONE message to the MFW
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int - 0 - Operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_unload_done(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Read the MFW mailbox into Current buffer.
+ * qed_mcp_read_mb(): Read the MFW mailbox into Current buffer.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Void.
  */
 void qed_mcp_read_mb(struct qed_hwfn *p_hwfn,
 		     struct qed_ptt *p_ptt);
 
 /**
- * @brief Ack to mfw that driver finished FLR process for VFs
+ * qed_mcp_ack_vf_flr(): Ack to mfw that driver finished FLR process for VFs
  *
- * @param p_hwfn
- * @param p_ptt
- * @param vfs_to_ack - bit mask of all engine VFs for which the PF acks.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @vfs_to_ack: bit mask of all engine VFs for which the PF acks.
  *
- * @param return int - 0 upon success.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ack_vf_flr(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt, u32 *vfs_to_ack);
 
 /**
- * @brief - calls during init to read shmem of all function-related info.
+ * qed_mcp_fill_shmem_func_info(): Calls during init to read shmem of
+ *                                 all function-related info.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mcp_fill_shmem_func_info(struct qed_hwfn *p_hwfn,
 				 struct qed_ptt *p_ptt);
 
 /**
- * @brief - Reset the MCP using mailbox command.
+ * qed_mcp_reset(): Reset the MCP using mailbox command.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mcp_reset(struct qed_hwfn *p_hwfn,
 		  struct qed_ptt *p_ptt);
 
 /**
- * @brief - Sends an NVM read command request to the MFW to get
- *        a buffer.
+ * qed_mcp_nvm_rd_cmd(): Sends an NVM read command request to the MFW to get
+ *                       a buffer.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param cmd - Command: DRV_MSG_CODE_NVM_GET_FILE_DATA or
- *            DRV_MSG_CODE_NVM_READ_NVRAM commands
- * @param param - [0:23] - Offset [24:31] - Size
- * @param o_mcp_resp - MCP response
- * @param o_mcp_param - MCP response param
- * @param o_txn_size -  Buffer size output
- * @param o_buf - Pointer to the buffer returned by the MFW.
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @cmd: (Command) DRV_MSG_CODE_NVM_GET_FILE_DATA or
+ *            DRV_MSG_CODE_NVM_READ_NVRAM commands.
+ * @param: [0:23] - Offset [24:31] - Size.
+ * @o_mcp_resp: MCP response.
+ * @o_mcp_param: MCP response param.
+ * @o_txn_size: Buffer size output.
+ * @o_buf: Pointer to the buffer returned by the MFW.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mcp_nvm_rd_cmd(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
@@ -967,60 +980,61 @@ int qed_mcp_nvm_rd_cmd(struct qed_hwfn *p_hwfn,
 		       u32 *o_mcp_param, u32 *o_txn_size, u32 *o_buf);
 
 /**
- * @brief Read from sfp
+ * qed_mcp_phy_sfp_read(): Read from sfp.
  *
- *  @param p_hwfn - hw function
- *  @param p_ptt  - PTT required for register access
- *  @param port   - transceiver port
- *  @param addr   - I2C address
- *  @param offset - offset in sfp
- *  @param len    - buffer length
- *  @param p_buf  - buffer to read into
+ * @p_hwfn: HW device data.
+ * @p_ptt: PTT required for register access.
+ * @port: transceiver port.
+ * @addr: I2C address.
+ * @offset: offset in sfp.
+ * @len: buffer length.
+ * @p_buf: buffer to read into.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_phy_sfp_read(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 			 u32 port, u32 addr, u32 offset, u32 len, u8 *p_buf);
 
 /**
- * @brief indicates whether the MFW objects [under mcp_info] are accessible
+ * qed_mcp_is_init(): indicates whether the MFW objects [under mcp_info]
+ *                    are accessible
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return true iff MFW is running and mcp_info is initialized
+ * Return: true if MFW is running and mcp_info is initialized.
  */
 bool qed_mcp_is_init(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief request MFW to configure MSI-X for a VF
+ * qed_mcp_config_vf_msix(): Request MFW to configure MSI-X for a VF.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param vf_id - absolute inside engine
- * @param num_sbs - number of entries to request
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @vf_id: absolute inside engine.
+ * @num: number of entries to request.
  *
- * @return int
+ * Return: Int.
  */
 int qed_mcp_config_vf_msix(struct qed_hwfn *p_hwfn,
 			   struct qed_ptt *p_ptt, u8 vf_id, u8 num);
 
 /**
- * @brief - Halt the MCP.
+ * qed_mcp_halt(): Halt the MCP.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mcp_halt(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief - Wake up the MCP.
+ * qed_mcp_resume: Wake up the MCP.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param return 0 upon success.
+ * Return: 0 upon success.
  */
 int qed_mcp_resume(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
@@ -1038,13 +1052,13 @@ int __qed_configure_pf_min_bandwidth(struct qed_hwfn *p_hwfn,
 int qed_mcp_mask_parities(struct qed_hwfn *p_hwfn,
 			  struct qed_ptt *p_ptt, u32 mask_parities);
 
-/* @brief - Gets the mdump retained data from the MFW.
+/* qed_mcp_mdump_get_retain(): Gets the mdump retained data from the MFW.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_mdump_retain
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_mdump_retain: mdump retain.
  *
- * @param return 0 upon success.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_mdump_get_retain(struct qed_hwfn *p_hwfn,
@@ -1052,15 +1066,15 @@ qed_mcp_mdump_get_retain(struct qed_hwfn *p_hwfn,
 			 struct mdump_retain_data_stc *p_mdump_retain);
 
 /**
- * @brief - Sets the MFW's max value for the given resource
+ * qed_mcp_set_resc_max_val(): Sets the MFW's max value for the given resource.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param res_id
- *  @param resc_max_val
- *  @param p_mcp_resp
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @res_id: RES ID.
+ * @resc_max_val: Resec max val.
+ * @p_mcp_resp: MCP Resp
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_set_resc_max_val(struct qed_hwfn *p_hwfn,
@@ -1069,16 +1083,17 @@ qed_mcp_set_resc_max_val(struct qed_hwfn *p_hwfn,
 			 u32 resc_max_val, u32 *p_mcp_resp);
 
 /**
- * @brief - Gets the MFW allocation info for the given resource
+ * qed_mcp_get_resc_info(): Gets the MFW allocation info for the given
+ *                          resource.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param res_id
- *  @param p_mcp_resp
- *  @param p_resc_num
- *  @param p_resc_start
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @res_id: Res ID.
+ * @p_mcp_resp: MCP resp.
+ * @p_resc_num: Resc num.
+ * @p_resc_start: Resc start.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_get_resc_info(struct qed_hwfn *p_hwfn,
@@ -1087,13 +1102,13 @@ qed_mcp_get_resc_info(struct qed_hwfn *p_hwfn,
 		      u32 *p_mcp_resp, u32 *p_resc_num, u32 *p_resc_start);
 
 /**
- * @brief Send eswitch mode to MFW
+ * qed_mcp_ov_update_eswitch(): Send eswitch mode to MFW.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param eswitch - eswitch mode
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @eswitch: eswitch mode.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_ov_update_eswitch(struct qed_hwfn *p_hwfn,
 			      struct qed_ptt *p_ptt,
@@ -1113,12 +1128,12 @@ enum qed_resc_lock {
 };
 
 /**
- * @brief - Initiates PF FLR
+ * qed_mcp_initiate_pf_flr(): Initiates PF FLR.
  *
- *  @param p_hwfn
- *  @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int qed_mcp_initiate_pf_flr(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 struct qed_resc_lock_params {
@@ -1151,13 +1166,13 @@ struct qed_resc_lock_params {
 };
 
 /**
- * @brief Acquires MFW generic resource lock
+ * qed_mcp_resc_lock(): Acquires MFW generic resource lock.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param p_params
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_params: Params.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_resc_lock(struct qed_hwfn *p_hwfn,
@@ -1175,13 +1190,13 @@ struct qed_resc_unlock_params {
 };
 
 /**
- * @brief Releases MFW generic resource lock
+ * qed_mcp_resc_unlock(): Releases MFW generic resource lock.
  *
- *  @param p_hwfn
- *  @param p_ptt
- *  @param p_params
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_params: Params.
  *
- * @return int - 0 - operation was successful.
+ * Return: Int - 0 - Operation was successul.
  */
 int
 qed_mcp_resc_unlock(struct qed_hwfn *p_hwfn,
@@ -1189,12 +1204,15 @@ qed_mcp_resc_unlock(struct qed_hwfn *p_hwfn,
 		    struct qed_resc_unlock_params *p_params);
 
 /**
- * @brief - default initialization for lock/unlock resource structs
+ * qed_mcp_resc_lock_default_init(): Default initialization for
+ *                                   lock/unlock resource structs.
  *
- * @param p_lock - lock params struct to be initialized; Can be NULL
- * @param p_unlock - unlock params struct to be initialized; Can be NULL
- * @param resource - the requested resource
- * @paral b_is_permanent - disable retries & aging when set
+ * @p_lock: lock params struct to be initialized; Can be NULL.
+ * @p_unlock: unlock params struct to be initialized; Can be NULL.
+ * @resource: the requested resource.
+ * @b_is_permanent: disable retries & aging when set.
+ *
+ * Return: Void.
  */
 void qed_mcp_resc_lock_default_init(struct qed_resc_lock_params *p_lock,
 				    struct qed_resc_unlock_params *p_unlock,
@@ -1202,94 +1220,117 @@ void qed_mcp_resc_lock_default_init(struct qed_resc_lock_params *p_lock,
 				    resource, bool b_is_permanent);
 
 /**
- * @brief - Return whether management firmware support smart AN
+ * qed_mcp_is_smart_an_supported(): Return whether management firmware
+ *                                  support smart AN
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return bool - true if feature is supported.
+ * Return: bool true if feature is supported.
  */
 bool qed_mcp_is_smart_an_supported(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Learn of supported MFW features; To be done during early init
+ * qed_mcp_get_capabilities(): Learn of supported MFW features;
+ *                             To be done during early init.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Int.
  */
 int qed_mcp_get_capabilities(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Inform MFW of set of features supported by driver. Should be done
- * inside the content of the LOAD_REQ.
+ * qed_mcp_set_capabilities(): Inform MFW of set of features supported
+ *                             by driver. Should be done inside the content
+ *                             of the LOAD_REQ.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Return: Int.
  */
 int qed_mcp_set_capabilities(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Read ufp config from the shared memory.
+ * qed_mcp_read_ufp_config(): Read ufp config from the shared memory.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
  *
- * @param p_hwfn
- * @param p_ptt
+ * Return: Void.
  */
 void qed_mcp_read_ufp_config(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Populate the nvm info shadow in the given hardware function
+ * qed_mcp_nvm_info_populate(): Populate the nvm info shadow in the given
+ *                              hardware function.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Int.
  */
 int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Delete nvm info shadow in the given hardware function
+ * qed_mcp_nvm_info_free(): Delete nvm info shadow in the given
+ *                          hardware function.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_mcp_nvm_info_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Get the engine affinity configuration.
+ * qed_mcp_get_engine_config(): Get the engine affinity configuration.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Int.
  */
 int qed_mcp_get_engine_config(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Get the PPFID bitmap.
+ * qed_mcp_get_ppfid_bitmap(): Get the PPFID bitmap.
  *
- * @param p_hwfn
- * @param p_ptt
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ *
+ * Return: Int.
  */
 int qed_mcp_get_ppfid_bitmap(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 
 /**
- * @brief Get NVM config attribute value.
+ * qed_mcp_nvm_get_cfg(): Get NVM config attribute value.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @option_id: Option ID.
+ * @entity_id: Entity ID.
+ * @flags: Flags.
+ * @p_buf: Buf.
+ * @p_len: Len.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param option_id
- * @param entity_id
- * @param flags
- * @param p_buf
- * @param p_len
+ * Return: Int.
  */
 int qed_mcp_nvm_get_cfg(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 			u16 option_id, u8 entity_id, u16 flags, u8 *p_buf,
 			u32 *p_len);
 
 /**
- * @brief Set NVM config attribute value.
+ * qed_mcp_nvm_set_cfg(): Set NVM config attribute value.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param option_id
- * @param entity_id
- * @param flags
- * @param p_buf
- * @param len
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @option_id: Option ID.
+ * @entity_id: Entity ID.
+ * @flags: Flags.
+ * @p_buf: Buf.
+ * @len: Len.
+ *
+ * Return: Int.
  */
 int qed_mcp_nvm_set_cfg(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 			u16 option_id, u8 entity_id, u16 flags, u8 *p_buf,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_selftest.h b/drivers/net/ethernet/qlogic/qed/qed_selftest.h
index e27dd9a4547e..7a3bd749e1e4 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_selftest.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_selftest.h
@@ -6,47 +6,47 @@
 #include <linux/types.h>
 
 /**
- * @brief qed_selftest_memory - Perform memory test
+ * qed_selftest_memory(): Perform memory test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_selftest_memory(struct qed_dev *cdev);
 
 /**
- * @brief qed_selftest_interrupt - Perform interrupt test
+ * qed_selftest_interrupt(): Perform interrupt test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_selftest_interrupt(struct qed_dev *cdev);
 
 /**
- * @brief qed_selftest_register - Perform register test
+ * qed_selftest_register(): Perform register test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_selftest_register(struct qed_dev *cdev);
 
 /**
- * @brief qed_selftest_clock - Perform clock test
+ * qed_selftest_clock(): Perform clock test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_selftest_clock(struct qed_dev *cdev);
 
 /**
- * @brief qed_selftest_nvram - Perform nvram test
+ * qed_selftest_nvram(): Perform nvram test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return int
+ * Return: Int.
  */
 int qed_selftest_nvram(struct qed_dev *cdev);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp.h b/drivers/net/ethernet/qlogic/qed/qed_sp.h
index 60ff3222bf55..c5a38f3c92b0 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp.h
@@ -31,23 +31,18 @@ struct qed_spq_comp_cb {
 };
 
 /**
- * @brief qed_eth_cqe_completion - handles the completion of a
- *        ramrod on the cqe ring
+ * qed_eth_cqe_completion(): handles the completion of a
+ *                           ramrod on the cqe ring.
  *
- * @param p_hwfn
- * @param cqe
+ * @p_hwfn: HW device data.
+ * @cqe: CQE.
  *
- * @return int
+ * Return: Int.
  */
 int qed_eth_cqe_completion(struct qed_hwfn *p_hwfn,
 			   struct eth_slow_path_rx_cqe *cqe);
 
-/**
- *  @file
- *
- *  QED Slow-hwfn queue interface
- */
-
+ /*  QED Slow-hwfn queue interface */
 union ramrod_data {
 	struct pf_start_ramrod_data pf_start;
 	struct pf_update_ramrod_data pf_update;
@@ -207,117 +202,128 @@ struct qed_spq {
 };
 
 /**
- * @brief qed_spq_post - Posts a Slow hwfn request to FW, or lacking that
- *        Pends it to the future list.
+ * qed_spq_post(): Posts a Slow hwfn request to FW, or lacking that
+ *                 Pends it to the future list.
  *
- * @param p_hwfn
- * @param p_req
+ * @p_hwfn: HW device data.
+ * @p_ent: Ent.
+ * @fw_return_code: Return code from firmware.
  *
- * @return int
+ * Return: Int.
  */
 int qed_spq_post(struct qed_hwfn *p_hwfn,
 		 struct qed_spq_entry *p_ent,
 		 u8 *fw_return_code);
 
 /**
- * @brief qed_spq_allocate - Alloocates & initializes the SPQ and EQ.
+ * qed_spq_alloc(): Alloocates & initializes the SPQ and EQ.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_spq_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_spq_setup - Reset the SPQ to its start state.
+ * qed_spq_setup(): Reset the SPQ to its start state.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_spq_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_spq_deallocate - Deallocates the given SPQ struct.
+ * qed_spq_free(): Deallocates the given SPQ struct.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_spq_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_spq_get_entry - Obtain an entrry from the spq
- *        free pool list.
- *
- *
+ * qed_spq_get_entry(): Obtain an entrry from the spq
+ *                      free pool list.
  *
- * @param p_hwfn
- * @param pp_ent
+ * @p_hwfn: HW device data.
+ * @pp_ent: PP ENT.
  *
- * @return int
+ * Return: Int.
  */
 int
 qed_spq_get_entry(struct qed_hwfn *p_hwfn,
 		  struct qed_spq_entry **pp_ent);
 
 /**
- * @brief qed_spq_return_entry - Return an entry to spq free
- *                                 pool list
+ * qed_spq_return_entry(): Return an entry to spq free pool list.
  *
- * @param p_hwfn
- * @param p_ent
+ * @p_hwfn: HW device data.
+ * @p_ent: P ENT.
+ *
+ * Return: Void.
  */
 void qed_spq_return_entry(struct qed_hwfn *p_hwfn,
 			  struct qed_spq_entry *p_ent);
 /**
- * @brief qed_eq_allocate - Allocates & initializes an EQ struct
+ * qed_eq_alloc(): Allocates & initializes an EQ struct.
  *
- * @param p_hwfn
- * @param num_elem number of elements in the eq
+ * @p_hwfn: HW device data.
+ * @num_elem: number of elements in the eq.
  *
- * @return int
+ * Return: Int.
  */
 int qed_eq_alloc(struct qed_hwfn *p_hwfn, u16 num_elem);
 
 /**
- * @brief qed_eq_setup - Reset the EQ to its start state.
+ * qed_eq_setup(): Reset the EQ to its start state.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_eq_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_eq_free - deallocates the given EQ struct.
+ * qed_eq_free(): deallocates the given EQ struct.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_eq_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_eq_prod_update - update the FW with default EQ producer
+ * qed_eq_prod_update(): update the FW with default EQ producer.
+ *
+ * @p_hwfn: HW device data.
+ * @prod: Prod.
  *
- * @param p_hwfn
- * @param prod
+ * Return: Void.
  */
 void qed_eq_prod_update(struct qed_hwfn *p_hwfn,
 			u16 prod);
 
 /**
- * @brief qed_eq_completion - Completes currently pending EQ elements
+ * qed_eq_completion(): Completes currently pending EQ elements.
  *
- * @param p_hwfn
- * @param cookie
+ * @p_hwfn: HW device data.
+ * @cookie: Cookie.
  *
- * @return int
+ * Return: Int.
  */
 int qed_eq_completion(struct qed_hwfn *p_hwfn,
 		      void *cookie);
 
 /**
- * @brief qed_spq_completion - Completes a single event
+ * qed_spq_completion(): Completes a single event.
  *
- * @param p_hwfn
- * @param echo - echo value from cookie (used for determining completion)
- * @param p_data - data from cookie (used in callback function if applicable)
+ * @p_hwfn: HW device data.
+ * @echo: echo value from cookie (used for determining completion).
+ * @fw_return_code: FW return code.
+ * @p_data: data from cookie (used in callback function if applicable).
  *
- * @return int
+ * Return: Int.
  */
 int qed_spq_completion(struct qed_hwfn *p_hwfn,
 		       __le16 echo,
@@ -325,44 +331,43 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 		       union event_ring_data *p_data);
 
 /**
- * @brief qed_spq_get_cid - Given p_hwfn, return cid for the hwfn's SPQ
+ * qed_spq_get_cid(): Given p_hwfn, return cid for the hwfn's SPQ.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return u32 - SPQ CID
+ * Return: u32 - SPQ CID.
  */
 u32 qed_spq_get_cid(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_consq_alloc - Allocates & initializes an ConsQ
- *        struct
+ * qed_consq_alloc(): Allocates & initializes an ConsQ struct.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_consq_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_consq_setup - Reset the ConsQ to its start state.
+ * qed_consq_setup(): Reset the ConsQ to its start state.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return Void.
  */
 void qed_consq_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_consq_free - deallocates the given ConsQ struct.
+ * qed_consq_free(): deallocates the given ConsQ struct.
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return Void.
  */
 void qed_consq_free(struct qed_hwfn *p_hwfn);
 int qed_spq_pend_post(struct qed_hwfn *p_hwfn);
 
-/**
- * @file
- *
- * @brief Slow-hwfn low-level commands (Ramrods) function definitions.
- */
+/* Slow-hwfn low-level commands (Ramrods) function definitions. */
 
 #define QED_SP_EQ_COMPLETION  0x01
 #define QED_SP_CQE_COMPLETION 0x02
@@ -377,12 +382,15 @@ struct qed_sp_init_data {
 };
 
 /**
- * @brief Returns a SPQ entry to the pool / frees the entry if allocated.
- *        Should be called on in error flows after initializing the SPQ entry
- *        and before posting it.
+ * qed_sp_destroy_request(): Returns a SPQ entry to the pool / frees the
+ *                           entry if allocated. Should be called on in error
+ *                           flows after initializing the SPQ entry
+ *                           and before posting it.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ent: Ent.
  *
- * @param p_hwfn
- * @param p_ent
+ * Return: Void.
  */
 void qed_sp_destroy_request(struct qed_hwfn *p_hwfn,
 			    struct qed_spq_entry *p_ent);
@@ -394,7 +402,14 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 			struct qed_sp_init_data *p_data);
 
 /**
- * @brief qed_sp_pf_start - PF Function Start Ramrod
+ * qed_sp_pf_start(): PF Function Start Ramrod.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: P_ptt.
+ * @p_tunn: P_tunn.
+ * @allow_npar_tx_switch: Allow NPAR TX Switch.
+ *
+ * Return: Int.
  *
  * This ramrod is sent to initialize a physical function (PF). It will
  * configure the function related parameters and write its completion to the
@@ -404,12 +419,6 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
  * allocated by the driver on host memory and its parameters are written
  * to the internal RAM of the UStorm by the Function Start Ramrod.
  *
- * @param p_hwfn
- * @param p_ptt
- * @param p_tunn
- * @param allow_npar_tx_switch
- *
- * @return int
  */
 
 int qed_sp_pf_start(struct qed_hwfn *p_hwfn,
@@ -418,47 +427,33 @@ int qed_sp_pf_start(struct qed_hwfn *p_hwfn,
 		    bool allow_npar_tx_switch);
 
 /**
- * @brief qed_sp_pf_update - PF Function Update Ramrod
+ * qed_sp_pf_update(): PF Function Update Ramrod.
  *
- * This ramrod updates function-related parameters. Every parameter can be
- * updated independently, according to configuration flags.
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Int.
  *
- * @return int
+ * This ramrod updates function-related parameters. Every parameter can be
+ * updated independently, according to configuration flags.
  */
 
 int qed_sp_pf_update(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_sp_pf_update_stag - Update firmware of new outer tag
+ * qed_sp_pf_update_stag(): Update firmware of new outer tag.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_sp_pf_update_stag(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_sp_pf_stop - PF Function Stop Ramrod
- *
- * This ramrod is sent to close a Physical Function (PF). It is the last ramrod
- * sent and the last completion written to the PFs Event Ring. This ramrod also
- * deletes the context for the Slowhwfn connection on this PF.
- *
- * @note Not required for first packet.
- *
- * @param p_hwfn
- *
- * @return int
- */
-
-/**
- * @brief qed_sp_pf_update_ufp - PF ufp update Ramrod
+ * qed_sp_pf_update_ufp(): PF ufp update Ramrod.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_sp_pf_update_ufp(struct qed_hwfn *p_hwfn);
 
@@ -470,11 +465,11 @@ int qed_sp_pf_update_tunn_cfg(struct qed_hwfn *p_hwfn,
 			      enum spq_mode comp_mode,
 			      struct qed_spq_comp_cb *p_comp_data);
 /**
- * @brief qed_sp_heartbeat_ramrod - Send empty Ramrod
+ * qed_sp_heartbeat_ramrod(): Send empty Ramrod.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 
 int qed_sp_heartbeat_ramrod(struct qed_hwfn *p_hwfn);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index eacd6457f195..9f81295c6f45 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -250,29 +250,31 @@ extern const struct qed_iov_hv_ops qed_iov_ops_pass;
 
 #ifdef CONFIG_QED_SRIOV
 /**
- * @brief Check if given VF ID @vfid is valid
- *        w.r.t. @b_enabled_only value
- *        if b_enabled_only = true - only enabled VF id is valid
- *        else any VF id less than max_vfs is valid
+ * qed_iov_is_valid_vfid(): Check if given VF ID @vfid is valid
+ *                          w.r.t. @b_enabled_only value
+ *                          if b_enabled_only = true - only enabled
+ *                          VF id is valid.
+ *                          else any VF id less than max_vfs is valid.
  *
- * @param p_hwfn
- * @param rel_vf_id - Relative VF ID
- * @param b_enabled_only - consider only enabled VF
- * @param b_non_malicious - true iff we want to validate vf isn't malicious.
+ * @p_hwfn: HW device data.
+ * @rel_vf_id: Relative VF ID.
+ * @b_enabled_only: consider only enabled VF.
+ * @b_non_malicious: true iff we want to validate vf isn't malicious.
  *
- * @return bool - true for valid VF ID
+ * Return: bool - true for valid VF ID
  */
 bool qed_iov_is_valid_vfid(struct qed_hwfn *p_hwfn,
 			   int rel_vf_id,
 			   bool b_enabled_only, bool b_non_malicious);
 
 /**
- * @brief - Given a VF index, return index of next [including that] active VF.
+ * qed_iov_get_next_active_vf(): Given a VF index, return index of
+ *                               next [including that] active VF.
  *
- * @param p_hwfn
- * @param rel_vf_id
+ * @p_hwfn: HW device data.
+ * @rel_vf_id: VF ID.
  *
- * @return MAX_NUM_VFS in case no further active VFs, otherwise index.
+ * Return: MAX_NUM_VFS in case no further active VFs, otherwise index.
  */
 u16 qed_iov_get_next_active_vf(struct qed_hwfn *p_hwfn, u16 rel_vf_id);
 
@@ -280,83 +282,92 @@ void qed_iov_bulletin_set_udp_ports(struct qed_hwfn *p_hwfn,
 				    int vfid, u16 vxlan_port, u16 geneve_port);
 
 /**
- * @brief Read sriov related information and allocated resources
- *  reads from configuration space, shmem, etc.
+ * qed_iov_hw_info(): Read sriov related information and allocated resources
+ *                    reads from configuration space, shmem, etc.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_iov_hw_info(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_add_tlv - place a given tlv on the tlv buffer at next offset
+ * qed_add_tlv(): place a given tlv on the tlv buffer at next offset
  *
- * @param p_hwfn
- * @param p_iov
- * @param type
- * @param length
+ * @p_hwfn: HW device data.
+ * @offset: offset.
+ * @type: Type
+ * @length: Length.
  *
- * @return pointer to the newly placed tlv
+ * Return: pointer to the newly placed tlv
  */
 void *qed_add_tlv(struct qed_hwfn *p_hwfn, u8 **offset, u16 type, u16 length);
 
 /**
- * @brief list the types and lengths of the tlvs on the buffer
+ * qed_dp_tlv_list(): list the types and lengths of the tlvs on the buffer
  *
- * @param p_hwfn
- * @param tlvs_list
+ * @p_hwfn: HW device data.
+ * @tlvs_list: Tlvs_list.
+ *
+ * Return: Void.
  */
 void qed_dp_tlv_list(struct qed_hwfn *p_hwfn, void *tlvs_list);
 
 /**
- * @brief qed_iov_alloc - allocate sriov related resources
+ * qed_iov_alloc(): allocate sriov related resources
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_iov_alloc(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_iov_setup - setup sriov related resources
+ * qed_iov_setup(): setup sriov related resources
+ *
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
+ * Return: Void.
  */
 void qed_iov_setup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_iov_free - free sriov related resources
+ * qed_iov_free(): free sriov related resources
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
+ *
+ * Return: Void.
  */
 void qed_iov_free(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief free sriov related memory that was allocated during hw_prepare
+ * qed_iov_free_hw_info(): free sriov related memory that was
+ *                          allocated during hw_prepare
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Void.
  */
 void qed_iov_free_hw_info(struct qed_dev *cdev);
 
 /**
- * @brief Mark structs of vfs that have been FLR-ed.
+ * qed_iov_mark_vf_flr(): Mark structs of vfs that have been FLR-ed.
  *
- * @param p_hwfn
- * @param disabled_vfs - bitmask of all VFs on path that were FLRed
+ * @p_hwfn: HW device data.
+ * @disabled_vfs: bitmask of all VFs on path that were FLRed
  *
- * @return true iff one of the PF's vfs got FLRed. false otherwise.
+ * Return: true iff one of the PF's vfs got FLRed. false otherwise.
  */
 bool qed_iov_mark_vf_flr(struct qed_hwfn *p_hwfn, u32 *disabled_vfs);
 
 /**
- * @brief Search extended TLVs in request/reply buffer.
+ * qed_iov_search_list_tlvs(): Search extended TLVs in request/reply buffer.
  *
- * @param p_hwfn
- * @param p_tlvs_list - Pointer to tlvs list
- * @param req_type - Type of TLV
+ * @p_hwfn: HW device data.
+ * @p_tlvs_list: Pointer to tlvs list
+ * @req_type: Type of TLV
  *
- * @return pointer to tlv type if found, otherwise returns NULL.
+ * Return: pointer to tlv type if found, otherwise returns NULL.
  */
 void *qed_iov_search_list_tlvs(struct qed_hwfn *p_hwfn,
 			       void *p_tlvs_list, u16 req_type);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.h b/drivers/net/ethernet/qlogic/qed/qed_vf.h
index 60d2bb64e65f..976201fc7d4a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.h
@@ -688,13 +688,16 @@ struct qed_vf_iov {
 };
 
 /**
- * @brief VF - Set Rx/Tx coalesce per VF's relative queue.
- *             Coalesce value '0' will omit the configuration.
+ * qed_vf_pf_set_coalesce(): VF - Set Rx/Tx coalesce per VF's relative queue.
+ *                                Coalesce value '0' will omit the
+ *                                configuration.
  *
- * @param p_hwfn
- * @param rx_coal - coalesce value in micro second for rx queue
- * @param tx_coal - coalesce value in micro second for tx queue
- * @param p_cid   - queue cid
+ * @p_hwfn: HW device data.
+ * @rx_coal: coalesce value in micro second for rx queue.
+ * @tx_coal: coalesce value in micro second for tx queue.
+ * @p_cid: queue cid.
+ *
+ * Return: Int.
  *
  **/
 int qed_vf_pf_set_coalesce(struct qed_hwfn *p_hwfn,
@@ -702,148 +705,172 @@ int qed_vf_pf_set_coalesce(struct qed_hwfn *p_hwfn,
 			   u16 tx_coal, struct qed_queue_cid *p_cid);
 
 /**
- * @brief VF - Get coalesce per VF's relative queue.
+ * qed_vf_pf_get_coalesce(): VF - Get coalesce per VF's relative queue.
  *
- * @param p_hwfn
- * @param p_coal - coalesce value in micro second for VF queues.
- * @param p_cid  - queue cid
+ * @p_hwfn: HW device data.
+ * @p_coal: coalesce value in micro second for VF queues.
+ * @p_cid: queue cid.
  *
+ * Return: Int.
  **/
 int qed_vf_pf_get_coalesce(struct qed_hwfn *p_hwfn,
 			   u16 *p_coal, struct qed_queue_cid *p_cid);
 
 #ifdef CONFIG_QED_SRIOV
 /**
- * @brief Read the VF bulletin and act on it if needed
+ * qed_vf_read_bulletin(): Read the VF bulletin and act on it if needed.
  *
- * @param p_hwfn
- * @param p_change - qed fills 1 iff bulletin board has changed, 0 otherwise.
+ * @p_hwfn: HW device data.
+ * @p_change: qed fills 1 iff bulletin board has changed, 0 otherwise.
  *
- * @return enum _qed_status
+ * Return: enum _qed_status.
  */
 int qed_vf_read_bulletin(struct qed_hwfn *p_hwfn, u8 *p_change);
 
 /**
- * @brief Get link paramters for VF from qed
+ * qed_vf_get_link_params(): Get link parameters for VF from qed
+ *
+ * @p_hwfn: HW device data.
+ * @params: the link params structure to be filled for the VF.
  *
- * @param p_hwfn
- * @param params - the link params structure to be filled for the VF
+ * Return: Void.
  */
 void qed_vf_get_link_params(struct qed_hwfn *p_hwfn,
 			    struct qed_mcp_link_params *params);
 
 /**
- * @brief Get link state for VF from qed
+ * qed_vf_get_link_state(): Get link state for VF from qed.
+ *
+ * @p_hwfn: HW device data.
+ * @link: the link state structure to be filled for the VF
  *
- * @param p_hwfn
- * @param link - the link state structure to be filled for the VF
+ * Return: Void.
  */
 void qed_vf_get_link_state(struct qed_hwfn *p_hwfn,
 			   struct qed_mcp_link_state *link);
 
 /**
- * @brief Get link capabilities for VF from qed
+ * qed_vf_get_link_caps(): Get link capabilities for VF from qed.
  *
- * @param p_hwfn
- * @param p_link_caps - the link capabilities structure to be filled for the VF
+ * @p_hwfn: HW device data.
+ * @p_link_caps: the link capabilities structure to be filled for the VF
+ *
+ * Return: Void.
  */
 void qed_vf_get_link_caps(struct qed_hwfn *p_hwfn,
 			  struct qed_mcp_link_capabilities *p_link_caps);
 
 /**
- * @brief Get number of Rx queues allocated for VF by qed
+ * qed_vf_get_num_rxqs(): Get number of Rx queues allocated for VF by qed
+ *
+ * @p_hwfn: HW device data.
+ * @num_rxqs: allocated RX queues
  *
- *  @param p_hwfn
- *  @param num_rxqs - allocated RX queues
+ * Return: Void.
  */
 void qed_vf_get_num_rxqs(struct qed_hwfn *p_hwfn, u8 *num_rxqs);
 
 /**
- * @brief Get number of Rx queues allocated for VF by qed
+ * qed_vf_get_num_txqs(): Get number of Rx queues allocated for VF by qed
  *
- *  @param p_hwfn
- *  @param num_txqs - allocated RX queues
+ * @p_hwfn: HW device data.
+ * @num_txqs: allocated RX queues
+ *
+ * Return: Void.
  */
 void qed_vf_get_num_txqs(struct qed_hwfn *p_hwfn, u8 *num_txqs);
 
 /**
- * @brief Get number of available connections [both Rx and Tx] for VF
+ * qed_vf_get_num_cids(): Get number of available connections
+ *                        [both Rx and Tx] for VF
+ *
+ * @p_hwfn: HW device data.
+ * @num_cids: allocated number of connections
  *
- * @param p_hwfn
- * @param num_cids - allocated number of connections
+ * Return: Void.
  */
 void qed_vf_get_num_cids(struct qed_hwfn *p_hwfn, u8 *num_cids);
 
 /**
- * @brief Get port mac address for VF
+ * qed_vf_get_port_mac(): Get port mac address for VF.
  *
- * @param p_hwfn
- * @param port_mac - destination location for port mac
+ * @p_hwfn: HW device data.
+ * @port_mac: destination location for port mac
+ *
+ * Return: Void.
  */
 void qed_vf_get_port_mac(struct qed_hwfn *p_hwfn, u8 *port_mac);
 
 /**
- * @brief Get number of VLAN filters allocated for VF by qed
+ * qed_vf_get_num_vlan_filters(): Get number of VLAN filters allocated
+ *                                for VF by qed.
+ *
+ * @p_hwfn: HW device data.
+ * @num_vlan_filters: allocated VLAN filters
  *
- *  @param p_hwfn
- *  @param num_rxqs - allocated VLAN filters
+ * Return: Void.
  */
 void qed_vf_get_num_vlan_filters(struct qed_hwfn *p_hwfn,
 				 u8 *num_vlan_filters);
 
 /**
- * @brief Get number of MAC filters allocated for VF by qed
+ * qed_vf_get_num_mac_filters(): Get number of MAC filters allocated
+ *                               for VF by qed
  *
- *  @param p_hwfn
- *  @param num_rxqs - allocated MAC filters
+ * @p_hwfn: HW device data.
+ * @num_mac_filters: allocated MAC filters
+ *
+ * Return: Void.
  */
 void qed_vf_get_num_mac_filters(struct qed_hwfn *p_hwfn, u8 *num_mac_filters);
 
 /**
- * @brief Check if VF can set a MAC address
+ * qed_vf_check_mac(): Check if VF can set a MAC address
  *
- * @param p_hwfn
- * @param mac
+ * @p_hwfn: HW device data.
+ * @mac: Mac.
  *
- * @return bool
+ * Return: bool.
  */
 bool qed_vf_check_mac(struct qed_hwfn *p_hwfn, u8 *mac);
 
 /**
- * @brief Set firmware version information in dev_info from VFs acquire response tlv
+ * qed_vf_get_fw_version(): Set firmware version information
+ *                          in dev_info from VFs acquire response tlv
+ *
+ * @p_hwfn: HW device data.
+ * @fw_major: FW major.
+ * @fw_minor: FW minor.
+ * @fw_rev: FW rev.
+ * @fw_eng: FW eng.
  *
- * @param p_hwfn
- * @param fw_major
- * @param fw_minor
- * @param fw_rev
- * @param fw_eng
+ * Return: Void.
  */
 void qed_vf_get_fw_version(struct qed_hwfn *p_hwfn,
 			   u16 *fw_major, u16 *fw_minor,
 			   u16 *fw_rev, u16 *fw_eng);
 
 /**
- * @brief hw preparation for VF
- *      sends ACQUIRE message
+ * qed_vf_hw_prepare(): hw preparation for VF  sends ACQUIRE message
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return int
+ * Return: Int.
  */
 int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief VF - start the RX Queue by sending a message to the PF
- * @param p_hwfn
- * @param p_cid			- Only relative fields are relevant
- * @param bd_max_bytes          - maximum number of bytes per bd
- * @param bd_chain_phys_addr    - physical address of bd chain
- * @param cqe_pbl_addr          - physical address of pbl
- * @param cqe_pbl_size          - pbl size
- * @param pp_prod               - pointer to the producer to be
- *				  used in fastpath
+ * qed_vf_pf_rxq_start(): start the RX Queue by sending a message to the PF
+ *
+ * @p_hwfn: HW device data.
+ * @p_cid: Only relative fields are relevant
+ * @bd_max_bytes: maximum number of bytes per bd
+ * @bd_chain_phys_addr: physical address of bd chain
+ * @cqe_pbl_addr: physical address of pbl
+ * @cqe_pbl_size: pbl size
+ * @pp_prod: pointer to the producer to be used in fastpath
  *
- * @return int
+ * Return: Int.
  */
 int qed_vf_pf_rxq_start(struct qed_hwfn *p_hwfn,
 			struct qed_queue_cid *p_cid,
@@ -853,18 +880,16 @@ int qed_vf_pf_rxq_start(struct qed_hwfn *p_hwfn,
 			u16 cqe_pbl_size, void __iomem **pp_prod);
 
 /**
- * @brief VF - start the TX queue by sending a message to the
- *        PF.
+ * qed_vf_pf_txq_start(): VF - start the TX queue by sending a message to the
+ *                        PF.
  *
- * @param p_hwfn
- * @param tx_queue_id           - zero based within the VF
- * @param sb                    - status block for this queue
- * @param sb_index              - index within the status block
- * @param bd_chain_phys_addr    - physical address of tx chain
- * @param pp_doorbell           - pointer to address to which to
- *                      write the doorbell too..
+ * @p_hwfn: HW device data.
+ * @p_cid: CID.
+ * @pbl_addr: PBL address.
+ * @pbl_size: PBL Size.
+ * @pp_doorbell: pointer to address to which to write the doorbell too.
  *
- * @return int
+ * Return: Int.
  */
 int
 qed_vf_pf_txq_start(struct qed_hwfn *p_hwfn,
@@ -873,90 +898,91 @@ qed_vf_pf_txq_start(struct qed_hwfn *p_hwfn,
 		    u16 pbl_size, void __iomem **pp_doorbell);
 
 /**
- * @brief VF - stop the RX queue by sending a message to the PF
+ * qed_vf_pf_rxq_stop(): VF - stop the RX queue by sending a message to the PF.
  *
- * @param p_hwfn
- * @param p_cid
- * @param cqe_completion
+ * @p_hwfn: HW device data.
+ * @p_cid: CID.
+ * @cqe_completion: CQE Completion.
  *
- * @return int
+ * Return: Int.
  */
 int qed_vf_pf_rxq_stop(struct qed_hwfn *p_hwfn,
 		       struct qed_queue_cid *p_cid, bool cqe_completion);
 
 /**
- * @brief VF - stop the TX queue by sending a message to the PF
+ * qed_vf_pf_txq_stop(): VF - stop the TX queue by sending a message to the PF.
  *
- * @param p_hwfn
- * @param tx_qid
+ * @p_hwfn: HW device data.
+ * @p_cid: CID.
  *
- * @return int
+ * Return: Int.
  */
 int qed_vf_pf_txq_stop(struct qed_hwfn *p_hwfn, struct qed_queue_cid *p_cid);
 
 /**
- * @brief VF - send a vport update command
+ * qed_vf_pf_vport_update(): VF - send a vport update command.
  *
- * @param p_hwfn
- * @param params
+ * @p_hwfn: HW device data.
+ * @p_params: Params
  *
- * @return int
+ * Return: Int.
  */
 int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 			   struct qed_sp_vport_update_params *p_params);
 
 /**
+ * qed_vf_pf_reset(): VF - send a close message to PF.
  *
- * @brief VF - send a close message to PF
+ * @p_hwfn: HW device data.
  *
- * @param p_hwfn
- *
- * @return enum _qed_status
+ * Return: enum _qed_status
  */
 int qed_vf_pf_reset(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief VF - free vf`s memories
+ * qed_vf_pf_release(): VF - free vf`s memories.
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return enum _qed_status
+ * Return: enum _qed_status
  */
 int qed_vf_pf_release(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief qed_vf_get_igu_sb_id - Get the IGU SB ID for a given
+ * qed_vf_get_igu_sb_id(): Get the IGU SB ID for a given
  *        sb_id. For VFs igu sbs don't have to be contiguous
  *
- * @param p_hwfn
- * @param sb_id
+ * @p_hwfn: HW device data.
+ * @sb_id: SB ID.
  *
- * @return INLINE u16
+ * Return: INLINE u16
  */
 u16 qed_vf_get_igu_sb_id(struct qed_hwfn *p_hwfn, u16 sb_id);
 
 /**
- * @brief Stores [or removes] a configured sb_info.
+ * qed_vf_set_sb_info(): Stores [or removes] a configured sb_info.
+ *
+ * @p_hwfn: HW device data.
+ * @sb_id: zero-based SB index [for fastpath]
+ * @p_sb:  may be NULL [during removal].
  *
- * @param p_hwfn
- * @param sb_id - zero-based SB index [for fastpath]
- * @param sb_info - may be NULL [during removal].
+ * Return: Void.
  */
 void qed_vf_set_sb_info(struct qed_hwfn *p_hwfn,
 			u16 sb_id, struct qed_sb_info *p_sb);
 
 /**
- * @brief qed_vf_pf_vport_start - perform vport start for VF.
+ * qed_vf_pf_vport_start(): perform vport start for VF.
  *
- * @param p_hwfn
- * @param vport_id
- * @param mtu
- * @param inner_vlan_removal
- * @param tpa_mode
- * @param max_buffers_per_cqe,
- * @param only_untagged - default behavior regarding vlan acceptance
+ * @p_hwfn: HW device data.
+ * @vport_id: Vport ID.
+ * @mtu: MTU.
+ * @inner_vlan_removal: Innter VLAN removal.
+ * @tpa_mode: TPA mode
+ * @max_buffers_per_cqe: Max buffer pre CQE.
+ * @only_untagged: default behavior regarding vlan acceptance
  *
- * @return enum _qed_status
+ * Return: enum _qed_status
  */
 int qed_vf_pf_vport_start(struct qed_hwfn *p_hwfn,
 			  u8 vport_id,
@@ -966,11 +992,11 @@ int qed_vf_pf_vport_start(struct qed_hwfn *p_hwfn,
 			  u8 max_buffers_per_cqe, u8 only_untagged);
 
 /**
- * @brief qed_vf_pf_vport_stop - stop the VF's vport
+ * qed_vf_pf_vport_stop(): stop the VF's vport
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return enum _qed_status
+ * Return: enum _qed_status
  */
 int qed_vf_pf_vport_stop(struct qed_hwfn *p_hwfn);
 
@@ -981,42 +1007,49 @@ void qed_vf_pf_filter_mcast(struct qed_hwfn *p_hwfn,
 			    struct qed_filter_mcast *p_filter_cmd);
 
 /**
- * @brief qed_vf_pf_int_cleanup - clean the SB of the VF
+ * qed_vf_pf_int_cleanup(): clean the SB of the VF
  *
- * @param p_hwfn
+ * @p_hwfn: HW device data.
  *
- * @return enum _qed_status
+ * Return: enum _qed_status
  */
 int qed_vf_pf_int_cleanup(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief - return the link params in a given bulletin board
+ * __qed_vf_get_link_params(): return the link params in a given bulletin board
  *
- * @param p_hwfn
- * @param p_params - pointer to a struct to fill with link params
- * @param p_bulletin
+ * @p_hwfn: HW device data.
+ * @p_params: pointer to a struct to fill with link params
+ * @p_bulletin: Bulletin.
+ *
+ * Return: Void.
  */
 void __qed_vf_get_link_params(struct qed_hwfn *p_hwfn,
 			      struct qed_mcp_link_params *p_params,
 			      struct qed_bulletin_content *p_bulletin);
 
 /**
- * @brief - return the link state in a given bulletin board
+ * __qed_vf_get_link_state(): return the link state in a given bulletin board
+ *
+ * @p_hwfn: HW device data.
+ * @p_link: pointer to a struct to fill with link state
+ * @p_bulletin: Bulletin.
  *
- * @param p_hwfn
- * @param p_link - pointer to a struct to fill with link state
- * @param p_bulletin
+ * Return: Void.
  */
 void __qed_vf_get_link_state(struct qed_hwfn *p_hwfn,
 			     struct qed_mcp_link_state *p_link,
 			     struct qed_bulletin_content *p_bulletin);
 
 /**
- * @brief - return the link capabilities in a given bulletin board
+ * __qed_vf_get_link_caps(): return the link capabilities in a given
+ *                           bulletin board
  *
- * @param p_hwfn
- * @param p_link - pointer to a struct to fill with link capabilities
- * @param p_bulletin
+ * @p_hwfn: HW device data.
+ * @p_link_caps: pointer to a struct to fill with link capabilities
+ * @p_bulletin: Bulletin.
+ *
+ * Return: Void.
  */
 void __qed_vf_get_link_caps(struct qed_hwfn *p_hwfn,
 			    struct qed_mcp_link_capabilities *p_link_caps,
@@ -1029,9 +1062,13 @@ int qed_vf_pf_tunnel_param_update(struct qed_hwfn *p_hwfn,
 
 u32 qed_vf_hw_bar_size(struct qed_hwfn *p_hwfn, enum BAR_ID bar_id);
 /**
- * @brief - Ask PF to update the MAC address in it's bulletin board
+ * qed_vf_pf_bulletin_update_mac(): Ask PF to update the MAC address in
+ *                                  it's bulletin board
+ *
+ * @p_hwfn: HW device data.
+ * @p_mac: mac address to be updated in bulletin board
  *
- * @param p_mac - mac address to be updated in bulletin board
+ * Return: Int.
  */
 int qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn, u8 *p_mac);
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 75adb71adf18..be33bde0f731 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2800,10 +2800,13 @@ static void qede_get_eth_tlv_data(void *dev, void *data)
 }
 
 /**
- * qede_io_error_detected - called when PCI error is detected
+ * qede_io_error_detected(): Called when PCI error is detected
+ *
  * @pdev: Pointer to PCI device
  * @state: The current pci connection state
  *
+ *Return: pci_ers_result_t.
+ *
  * This function is called after a PCI bus error affecting
  * this device has been detected.
  */
diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
index f34dbd0db795..a84063492c71 100644
--- a/include/linux/qed/qed_chain.h
+++ b/include/linux/qed/qed_chain.h
@@ -268,14 +268,15 @@ static inline dma_addr_t qed_chain_get_pbl_phys(const struct qed_chain *chain)
 }
 
 /**
- * @brief qed_chain_advance_page -
+ * qed_chain_advance_page(): Advance the next element across pages for a
+ *                           linked chain.
  *
- * Advance the next element across pages for a linked chain
+ * @p_chain: P_chain.
+ * @p_next_elem: P_next_elem.
+ * @idx_to_inc: Idx_to_inc.
+ * @page_to_inc: page_to_inc.
  *
- * @param p_chain
- * @param p_next_elem
- * @param idx_to_inc
- * @param page_to_inc
+ * Return: Void.
  */
 static inline void
 qed_chain_advance_page(struct qed_chain *p_chain,
@@ -336,12 +337,14 @@ qed_chain_advance_page(struct qed_chain *p_chain,
 	} while (0)
 
 /**
- * @brief qed_chain_return_produced -
+ * qed_chain_return_produced(): A chain in which the driver "Produces"
+ *                              elements should use this API
+ *                              to indicate previous produced elements
+ *                              are now consumed.
  *
- * A chain in which the driver "Produces" elements should use this API
- * to indicate previous produced elements are now consumed.
+ * @p_chain: Chain.
  *
- * @param p_chain
+ * Return: Void.
  */
 static inline void qed_chain_return_produced(struct qed_chain *p_chain)
 {
@@ -353,15 +356,15 @@ static inline void qed_chain_return_produced(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_produce -
+ * qed_chain_produce(): A chain in which the driver "Produces"
+ *                      elements should use this to get a pointer to
+ *                      the next element which can be "Produced". It's driver
+ *                      responsibility to validate that the chain has room for
+ *                      new element.
  *
- * A chain in which the driver "Produces" elements should use this to get
- * a pointer to the next element which can be "Produced". It's driver
- * responsibility to validate that the chain has room for new element.
+ * @p_chain: Chain.
  *
- * @param p_chain
- *
- * @return void*, a pointer to next element
+ * Return: void*, a pointer to next element.
  */
 static inline void *qed_chain_produce(struct qed_chain *p_chain)
 {
@@ -395,14 +398,11 @@ static inline void *qed_chain_produce(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_get_capacity -
- *
- * Get the maximum number of BDs in chain
+ * qed_chain_get_capacity(): Get the maximum number of BDs in chain
  *
- * @param p_chain
- * @param num
+ * @p_chain: Chain.
  *
- * @return number of unusable BDs
+ * Return: number of unusable BDs.
  */
 static inline u32 qed_chain_get_capacity(struct qed_chain *p_chain)
 {
@@ -410,12 +410,14 @@ static inline u32 qed_chain_get_capacity(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_recycle_consumed -
+ * qed_chain_recycle_consumed(): Returns an element which was
+ *                               previously consumed;
+ *                               Increments producers so they could
+ *                               be written to FW.
  *
- * Returns an element which was previously consumed;
- * Increments producers so they could be written to FW.
+ * @p_chain: Chain.
  *
- * @param p_chain
+ * Return: Void.
  */
 static inline void qed_chain_recycle_consumed(struct qed_chain *p_chain)
 {
@@ -427,14 +429,13 @@ static inline void qed_chain_recycle_consumed(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_consume -
+ * qed_chain_consume(): A Chain in which the driver utilizes data written
+ *                      by a different source (i.e., FW) should use this to
+ *                      access passed buffers.
  *
- * A Chain in which the driver utilizes data written by a different source
- * (i.e., FW) should use this to access passed buffers.
+ * @p_chain: Chain.
  *
- * @param p_chain
- *
- * @return void*, a pointer to the next buffer written
+ * Return: void*, a pointer to the next buffer written.
  */
 static inline void *qed_chain_consume(struct qed_chain *p_chain)
 {
@@ -468,9 +469,11 @@ static inline void *qed_chain_consume(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_reset - Resets the chain to its start state
+ * qed_chain_reset(): Resets the chain to its start state.
+ *
+ * @p_chain: pointer to a previously allocated chain.
  *
- * @param p_chain pointer to a previously allocated chain
+ * Return Void.
  */
 static inline void qed_chain_reset(struct qed_chain *p_chain)
 {
@@ -519,13 +522,12 @@ static inline void qed_chain_reset(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_get_last_elem -
+ * qed_chain_get_last_elem(): Returns a pointer to the last element of the
+ *                            chain.
  *
- * Returns a pointer to the last element of the chain
+ * @p_chain: Chain.
  *
- * @param p_chain
- *
- * @return void*
+ * Return: void*.
  */
 static inline void *qed_chain_get_last_elem(struct qed_chain *p_chain)
 {
@@ -563,10 +565,13 @@ static inline void *qed_chain_get_last_elem(struct qed_chain *p_chain)
 }
 
 /**
- * @brief qed_chain_set_prod - sets the prod to the given value
+ * qed_chain_set_prod(): sets the prod to the given value.
+ *
+ * @p_chain: Chain.
+ * @prod_idx: Prod Idx.
+ * @p_prod_elem: Prod elem.
  *
- * @param prod_idx
- * @param p_prod_elem
+ * Return Void.
  */
 static inline void qed_chain_set_prod(struct qed_chain *p_chain,
 				      u32 prod_idx, void *p_prod_elem)
@@ -610,9 +615,11 @@ static inline void qed_chain_set_prod(struct qed_chain *p_chain,
 }
 
 /**
- * @brief qed_chain_pbl_zero_mem - set chain memory to 0
+ * qed_chain_pbl_zero_mem(): set chain memory to 0.
+ *
+ * @p_chain: Chain.
  *
- * @param p_chain
+ * Return: Void.
  */
 static inline void qed_chain_pbl_zero_mem(struct qed_chain *p_chain)
 {
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 850b98991670..f39451aaaeec 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -819,47 +819,47 @@ struct qed_common_cb_ops {
 
 struct qed_selftest_ops {
 /**
- * @brief selftest_interrupt - Perform interrupt test
+ * selftest_interrupt(): Perform interrupt test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*selftest_interrupt)(struct qed_dev *cdev);
 
 /**
- * @brief selftest_memory - Perform memory test
+ * selftest_memory(): Perform memory test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*selftest_memory)(struct qed_dev *cdev);
 
 /**
- * @brief selftest_register - Perform register test
+ * selftest_register(): Perform register test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*selftest_register)(struct qed_dev *cdev);
 
 /**
- * @brief selftest_clock - Perform clock test
+ * selftest_clock(): Perform clock test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*selftest_clock)(struct qed_dev *cdev);
 
 /**
- * @brief selftest_nvram - Perform nvram test
+ * selftest_nvram(): Perform nvram test.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*selftest_nvram) (struct qed_dev *cdev);
 };
@@ -927,47 +927,53 @@ struct qed_common_ops {
 				  enum qed_hw_err_type err_type);
 
 /**
- * @brief can_link_change - can the instance change the link or not
+ * can_link_change(): can the instance change the link or not.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return true if link-change is allowed, false otherwise.
+ * Return: true if link-change is allowed, false otherwise.
  */
 	bool (*can_link_change)(struct qed_dev *cdev);
 
 /**
- * @brief set_link - set links according to params
+ * set_link(): set links according to params.
  *
- * @param cdev
- * @param params - values used to override the default link configuration
+ * @cdev: Qed dev pointer.
+ * @params: values used to override the default link configuration.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int		(*set_link)(struct qed_dev *cdev,
 				    struct qed_link_params *params);
 
 /**
- * @brief get_link - returns the current link state.
+ * get_link(): returns the current link state.
  *
- * @param cdev
- * @param if_link - structure to be filled with current link configuration.
+ * @cdev: Qed dev pointer.
+ * @if_link: structure to be filled with current link configuration.
+ *
+ * Return: Void.
  */
 	void		(*get_link)(struct qed_dev *cdev,
 				    struct qed_link_output *if_link);
 
 /**
- * @brief - drains chip in case Tx completions fail to arrive due to pause.
+ * drain(): drains chip in case Tx completions fail to arrive due to pause.
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: Int.
  */
 	int		(*drain)(struct qed_dev *cdev);
 
 /**
- * @brief update_msglvl - update module debug level
+ * update_msglvl(): update module debug level.
  *
- * @param cdev
- * @param dp_module
- * @param dp_level
+ * @cdev: Qed dev pointer.
+ * @dp_module: Debug module.
+ * @dp_level: Debug level.
+ *
+ * Return: Void.
  */
 	void		(*update_msglvl)(struct qed_dev *cdev,
 					 u32 dp_module,
@@ -981,70 +987,73 @@ struct qed_common_ops {
 				      struct qed_chain *p_chain);
 
 /**
- * @brief nvm_flash - Flash nvm data.
+ * nvm_flash(): Flash nvm data.
  *
- * @param cdev
- * @param name - file containing the data
+ * @cdev: Qed dev pointer.
+ * @name: file containing the data.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*nvm_flash)(struct qed_dev *cdev, const char *name);
 
 /**
- * @brief nvm_get_image - reads an entire image from nvram
+ * nvm_get_image(): reads an entire image from nvram.
  *
- * @param cdev
- * @param type - type of the request nvram image
- * @param buf - preallocated buffer to fill with the image
- * @param len - length of the allocated buffer
+ * @cdev: Qed dev pointer.
+ * @type: type of the request nvram image.
+ * @buf: preallocated buffer to fill with the image.
+ * @len: length of the allocated buffer.
  *
- * @return 0 on success, error otherwise
+ * Return: 0 on success, error otherwise.
  */
 	int (*nvm_get_image)(struct qed_dev *cdev,
 			     enum qed_nvm_images type, u8 *buf, u16 len);
 
 /**
- * @brief set_coalesce - Configure Rx coalesce value in usec
+ * set_coalesce(): Configure Rx coalesce value in usec.
  *
- * @param cdev
- * @param rx_coal - Rx coalesce value in usec
- * @param tx_coal - Tx coalesce value in usec
- * @param qid - Queue index
- * @param sb_id - Status Block Id
+ * @cdev: Qed dev pointer.
+ * @rx_coal: Rx coalesce value in usec.
+ * @tx_coal: Tx coalesce value in usec.
+ * @handle: Handle.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*set_coalesce)(struct qed_dev *cdev,
 			    u16 rx_coal, u16 tx_coal, void *handle);
 
 /**
- * @brief set_led - Configure LED mode
+ * set_led() - Configure LED mode.
  *
- * @param cdev
- * @param mode - LED mode
+ * @cdev: Qed dev pointer.
+ * @mode: LED mode.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*set_led)(struct qed_dev *cdev,
 		       enum qed_led_mode mode);
 
 /**
- * @brief attn_clr_enable - Prevent attentions from being reasserted
+ * attn_clr_enable(): Prevent attentions from being reasserted.
+ *
+ * @cdev: Qed dev pointer.
+ * @clr_enable: Clear enable.
  *
- * @param cdev
- * @param clr_enable
+ * Return: Void.
  */
 	void (*attn_clr_enable)(struct qed_dev *cdev, bool clr_enable);
 
 /**
- * @brief db_recovery_add - add doorbell information to the doorbell
- * recovery mechanism.
+ * db_recovery_add(): add doorbell information to the doorbell
+ *                    recovery mechanism.
  *
- * @param cdev
- * @param db_addr - doorbell address
- * @param db_data - address of where db_data is stored
- * @param db_is_32b - doorbell is 32b pr 64b
- * @param db_is_user - doorbell recovery addresses are user or kernel space
+ * @cdev: Qed dev pointer.
+ * @db_addr: Doorbell address.
+ * @db_data: Dddress of where db_data is stored.
+ * @db_width: Doorbell is 32b or 64b.
+ * @db_space: Doorbell recovery addresses are user or kernel space.
+ *
+ * Return: Int.
  */
 	int (*db_recovery_add)(struct qed_dev *cdev,
 			       void __iomem *db_addr,
@@ -1053,114 +1062,130 @@ struct qed_common_ops {
 			       enum qed_db_rec_space db_space);
 
 /**
- * @brief db_recovery_del - remove doorbell information from the doorbell
+ * db_recovery_del(): remove doorbell information from the doorbell
  * recovery mechanism. db_data serves as key (db_addr is not unique).
  *
- * @param cdev
- * @param db_addr - doorbell address
- * @param db_data - address where db_data is stored. Serves as key for the
- *		    entry to delete.
+ * @cdev: Qed dev pointer.
+ * @db_addr: Doorbell address.
+ * @db_data: Address where db_data is stored. Serves as key for the
+ *           entry to delete.
+ *
+ * Return: Int.
  */
 	int (*db_recovery_del)(struct qed_dev *cdev,
 			       void __iomem *db_addr, void *db_data);
 
 /**
- * @brief recovery_process - Trigger a recovery process
+ * recovery_process(): Trigger a recovery process.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*recovery_process)(struct qed_dev *cdev);
 
 /**
- * @brief recovery_prolog - Execute the prolog operations of a recovery process
+ * recovery_prolog(): Execute the prolog operations of a recovery process.
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*recovery_prolog)(struct qed_dev *cdev);
 
 /**
- * @brief update_drv_state - API to inform the change in the driver state.
+ * update_drv_state(): API to inform the change in the driver state.
  *
- * @param cdev
- * @param active
+ * @cdev: Qed dev pointer.
+ * @active: Active
  *
+ * Return: Int.
  */
 	int (*update_drv_state)(struct qed_dev *cdev, bool active);
 
 /**
- * @brief update_mac - API to inform the change in the mac address
+ * update_mac(): API to inform the change in the mac address.
  *
- * @param cdev
- * @param mac
+ * @cdev: Qed dev pointer.
+ * @mac: MAC.
  *
+ * Return: Int.
  */
 	int (*update_mac)(struct qed_dev *cdev, u8 *mac);
 
 /**
- * @brief update_mtu - API to inform the change in the mtu
+ * update_mtu(): API to inform the change in the mtu.
  *
- * @param cdev
- * @param mtu
+ * @cdev: Qed dev pointer.
+ * @mtu: MTU.
  *
+ * Return: Int.
  */
 	int (*update_mtu)(struct qed_dev *cdev, u16 mtu);
 
 /**
- * @brief update_wol - update of changes in the WoL configuration
+ * update_wol(): Update of changes in the WoL configuration.
+ *
+ * @cdev: Qed dev pointer.
+ * @enabled: true iff WoL should be enabled.
  *
- * @param cdev
- * @param enabled - true iff WoL should be enabled.
+ * Return: Int.
  */
 	int (*update_wol) (struct qed_dev *cdev, bool enabled);
 
 /**
- * @brief read_module_eeprom
+ * read_module_eeprom(): Read EEPROM.
  *
- * @param cdev
- * @param buf - buffer
- * @param dev_addr - PHY device memory region
- * @param offset - offset into eeprom contents to be read
- * @param len - buffer length, i.e., max bytes to be read
+ * @cdev: Qed dev pointer.
+ * @buf: buffer.
+ * @dev_addr: PHY device memory region.
+ * @offset: offset into eeprom contents to be read.
+ * @len: buffer length, i.e., max bytes to be read.
+ *
+ * Return: Int.
  */
 	int (*read_module_eeprom)(struct qed_dev *cdev,
 				  char *buf, u8 dev_addr, u32 offset, u32 len);
 
 /**
- * @brief get_affin_hwfn_idx
+ * get_affin_hwfn_idx(): Get affine HW function.
+ *
+ * @cdev: Qed dev pointer.
  *
- * @param cdev
+ * Return: u8.
  */
 	u8 (*get_affin_hwfn_idx)(struct qed_dev *cdev);
 
 /**
- * @brief read_nvm_cfg - Read NVM config attribute value.
- * @param cdev
- * @param buf - buffer
- * @param cmd - NVM CFG command id
- * @param entity_id - Entity id
+ * read_nvm_cfg(): Read NVM config attribute value.
+ *
+ * @cdev: Qed dev pointer.
+ * @buf: Buffer.
+ * @cmd: NVM CFG command id.
+ * @entity_id: Entity id.
  *
+ * Return: Int.
  */
 	int (*read_nvm_cfg)(struct qed_dev *cdev, u8 **buf, u32 cmd,
 			    u32 entity_id);
 /**
- * @brief read_nvm_cfg - Read NVM config attribute value.
- * @param cdev
- * @param cmd - NVM CFG command id
+ * read_nvm_cfg_len(): Read NVM config attribute value.
  *
- * @return config id length, 0 on error.
+ * @cdev: Qed dev pointer.
+ * @cmd: NVM CFG command id.
+ *
+ * Return: config id length, 0 on error.
  */
 	int (*read_nvm_cfg_len)(struct qed_dev *cdev, u32 cmd);
 
 /**
- * @brief set_grc_config - Configure value for grc config id.
- * @param cdev
- * @param cfg_id - grc config id
- * @param val - grc config value
+ * set_grc_config(): Configure value for grc config id.
+ *
+ * @cdev: Qed dev pointer.
+ * @cfg_id: grc config id
+ * @val: grc config value
  *
+ * Return: Int.
  */
 	int (*set_grc_config)(struct qed_dev *cdev, u32 cfg_id, u32 val);
 
@@ -1397,18 +1422,16 @@ static inline u16 qed_sb_update_sb_idx(struct qed_sb_info *sb_info)
 }
 
 /**
+ * qed_sb_ack(): This function creates an update command for interrupts
+ *               that is  written to the IGU.
  *
- * @brief This function creates an update command for interrupts that is
- *        written to the IGU.
- *
- * @param sb_info       - This is the structure allocated and
- *                 initialized per status block. Assumption is
- *                 that it was initialized using qed_sb_init
- * @param int_cmd       - Enable/Disable/Nop
- * @param upd_flg       - whether igu consumer should be
- *                 updated.
+ * @sb_info: This is the structure allocated and
+ *           initialized per status block. Assumption is
+ *           that it was initialized using qed_sb_init
+ * @int_cmd: Enable/Disable/Nop
+ * @upd_flg: Whether igu consumer should be updated.
  *
- * @return inline void
+ * Return: inline void.
  */
 static inline void qed_sb_ack(struct qed_sb_info *sb_info,
 			      enum igu_int_cmd int_cmd,
diff --git a/include/linux/qed/qed_iscsi_if.h b/include/linux/qed/qed_iscsi_if.h
index 04180d9af560..494cdc3cd840 100644
--- a/include/linux/qed/qed_iscsi_if.h
+++ b/include/linux/qed/qed_iscsi_if.h
@@ -182,7 +182,7 @@ struct qed_iscsi_cb_ops {
  *			@param stats - pointer to struck that would be filled
  *				we stats
  *			@return 0 on success, error otherwise.
- * @change_mac		Change MAC of interface
+ * @change_mac:		Change MAC of interface
  *			@param cdev
  *			@param handle - the connection handle.
  *			@param mac - new MAC to configure.
diff --git a/include/linux/qed/qed_ll2_if.h b/include/linux/qed/qed_ll2_if.h
index ff808d248883..5b67cd03276e 100644
--- a/include/linux/qed/qed_ll2_if.h
+++ b/include/linux/qed/qed_ll2_if.h
@@ -208,57 +208,57 @@ enum qed_ll2_xmit_flags {
 
 struct qed_ll2_ops {
 /**
- * @brief start - initializes ll2
+ * start(): Initializes ll2.
  *
- * @param cdev
- * @param params - protocol driver configuration for the ll2.
+ * @cdev: Qed dev pointer.
+ * @params: Protocol driver configuration for the ll2.
  *
- * @return 0 on success, otherwise error value.
+ * Return: 0 on success, otherwise error value.
  */
 	int (*start)(struct qed_dev *cdev, struct qed_ll2_params *params);
 
 /**
- * @brief stop - stops the ll2
+ * stop(): Stops the ll2
  *
- * @param cdev
+ * @cdev: Qed dev pointer.
  *
- * @return 0 on success, otherwise error value.
+ * Return: 0 on success, otherwise error value.
  */
 	int (*stop)(struct qed_dev *cdev);
 
 /**
- * @brief start_xmit - transmits an skb over the ll2 interface
+ * start_xmit(): Transmits an skb over the ll2 interface
  *
- * @param cdev
- * @param skb
- * @param xmit_flags - Transmit options defined by the enum qed_ll2_xmit_flags.
+ * @cdev: Qed dev pointer.
+ * @skb: SKB.
+ * @xmit_flags: Transmit options defined by the enum qed_ll2_xmit_flags.
  *
- * @return 0 on success, otherwise error value.
+ * Return: 0 on success, otherwise error value.
  */
 	int (*start_xmit)(struct qed_dev *cdev, struct sk_buff *skb,
 			  unsigned long xmit_flags);
 
 /**
- * @brief register_cb_ops - protocol driver register the callback for Rx/Tx
+ * register_cb_ops(): Protocol driver register the callback for Rx/Tx
  * packets. Should be called before `start'.
  *
- * @param cdev
- * @param cookie - to be passed to the callback functions.
- * @param ops - the callback functions to register for Rx / Tx.
+ * @cdev: Qed dev pointer.
+ * @cookie: to be passed to the callback functions.
+ * @ops: the callback functions to register for Rx / Tx.
  *
- * @return 0 on success, otherwise error value.
+ * Return: 0 on success, otherwise error value.
  */
 	void (*register_cb_ops)(struct qed_dev *cdev,
 				const struct qed_ll2_cb_ops *ops,
 				void *cookie);
 
 /**
- * @brief get LL2 related statistics
+ * get_stats(): Get LL2 related statistics.
  *
- * @param cdev
- * @param stats - pointer to struct that would be filled with stats
+ * @cdev: Qed dev pointer.
+ * @stats: Pointer to struct that would be filled with stats.
  *
- * @return 0 on success, error otherwise.
+ * Return: 0 on success, error otherwise.
  */
 	int (*get_stats)(struct qed_dev *cdev, struct qed_ll2_stats *stats);
 };
diff --git a/include/linux/qed/qed_nvmetcp_if.h b/include/linux/qed/qed_nvmetcp_if.h
index 14671bc19ed1..1d51df347560 100644
--- a/include/linux/qed/qed_nvmetcp_if.h
+++ b/include/linux/qed/qed_nvmetcp_if.h
@@ -171,6 +171,23 @@ struct nvmetcp_task_params {
  *			@param dest_port
  * @clear_all_filters: Clear all filters.
  *			@param cdev
+ * @init_read_io: Init read IO.
+ *			@task_params
+ *			@cmd_pdu_header
+ *			@nvme_cmd
+ *			@sgl_task_params
+ * @init_write_io: Init write IO.
+ *			@task_params
+ *			@cmd_pdu_header
+ *			@nvme_cmd
+ *			@sgl_task_params
+ * @init_icreq_exchange: Exchange ICReq.
+ *			@task_params
+ *			@init_conn_req_pdu_hdr
+ *			@tx_sgl_task_params
+ *			@rx_sgl_task_params
+ * @init_task_cleanup: Init task cleanup.
+ *			@task_params
  */
 struct qed_nvmetcp_ops {
 	const struct qed_common_ops *common;
-- 
2.24.1

