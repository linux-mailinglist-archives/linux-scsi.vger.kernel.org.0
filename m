Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6838E223
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhEXIFC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 May 2021 04:05:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3641 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhEXIE6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 May 2021 04:04:58 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpV493gt3zQrKx;
        Mon, 24 May 2021 15:59:53 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:03:28 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 16:03:28 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-scsi@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qla2xxx: Remove the repeated declaration
Date:   Mon, 24 May 2021 16:03:22 +0800
Message-ID: <1621843402-34828-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Functions 'qla2x00_post_uevent_work', 'qla2x00_free_fcport' and
variable 'ql2xexlogins' are declared twice, remove the repeated
declaration.

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com> 
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/scsi/qla2xxx/qla_gbl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index fae5cae6f0a8..418be9a2fcf6 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -173,7 +173,6 @@ extern int ql2xnvmeenable;
 extern int ql2xautodetectsfp;
 extern int ql2xenablemsix;
 extern int qla2xuseresexchforels;
-extern int ql2xexlogins;
 extern int ql2xdifbundlinginternalbuffers;
 extern int ql2xfulldump_on_mpifail;
 extern int ql2xenforce_iocb_limit;
@@ -220,7 +219,6 @@ extern int qla83xx_set_drv_presence(scsi_qla_host_t *vha);
 extern int __qla83xx_set_drv_presence(scsi_qla_host_t *vha);
 extern int qla83xx_clear_drv_presence(scsi_qla_host_t *vha);
 extern int __qla83xx_clear_drv_presence(scsi_qla_host_t *vha);
-extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 
 extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 extern void qla2x00_disable_board_on_pci_error(struct work_struct *);
@@ -687,8 +685,6 @@ extern int qla2x00_chk_ms_status(scsi_qla_host_t *, ms_iocb_entry_t *,
 	struct ct_sns_rsp *, const char *);
 extern void qla2x00_async_iocb_timeout(void *data);
 
-extern void qla2x00_free_fcport(fc_port_t *);
-
 extern int qla24xx_post_gpnid_work(struct scsi_qla_host *, port_id_t *);
 extern int qla24xx_async_gpnid(scsi_qla_host_t *, port_id_t *);
 void qla24xx_handle_gpnid_event(scsi_qla_host_t *, struct event_arg *);
-- 
2.7.4

