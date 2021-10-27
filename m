Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0343C731
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Oct 2021 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhJ0KCo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Oct 2021 06:02:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:11988 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241345AbhJ0KCJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 27 Oct 2021 06:02:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R6I99G032380
        for <linux-scsi@vger.kernel.org>; Wed, 27 Oct 2021 02:59:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=/4sgOmsXjdM2VVpSekC43/tggCsunp4HAhPGvkQOgRQ=;
 b=GhEHI6teeehVe51iuYHb617wqSeO7Vhah59jCROkUdSpa9v0RziU/1VXtr2c0wcOKngy
 Ki98/JmGgdqDcTF5ss9HNbeE44SiGc3AM4tQo2uHrpf4vO9Zp7Q5KGp39j/j3REfzfoU
 TcdWm2FaBxVBJYhSxVmSc3VgC9uRirApyVY66wZwJblv32Losg01rOkCRhdEyY9x+8PL
 EM0342j6vGKerJ7oZoYiyUNnYmWYEyStwhLC9i6x+ETGZ3M8zXrnX281v0NSxKEqTJTx
 fd9qdL3fQiJVUOqik/6ojQ0n//2GDa7YiTCWqijlWx374lkKSGmdFCBadnuU6SEjrRr2 /w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3by1ca8tjs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 27 Oct 2021 02:59:43 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Oct
 2021 02:59:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 27 Oct 2021 02:59:40 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C1DC03F7075;
        Wed, 27 Oct 2021 02:59:40 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 19R9xe0d016425;
        Wed, 27 Oct 2021 02:59:40 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 19R9xeGq016424;
        Wed, 27 Oct 2021 02:59:40 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v4 07/13] qla2xxx: edif: replace list_for_each_safe with list_for_each_entry_safe
Date:   Wed, 27 Oct 2021 02:58:45 -0700
Message-ID: <20211027095851.16362-8-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20211027095851.16362-1-njavali@marvell.com>
References: <20211027095851.16362-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: f-K74ThIa1BFcwwp8LABC8M6rCPTTeT3
X-Proofpoint-ORIG-GUID: f-K74ThIa1BFcwwp8LABC8M6rCPTTeT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_03,2021-10-26_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

This patch is per review comment by Hannes Reinecke from
previous submission to replace list_for_each_safe with
list_for_each_entry_safe.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_edif.c | 39 ++++++++-------------------------
 drivers/scsi/qla2xxx/qla_edif.h |  1 -
 drivers/scsi/qla2xxx/qla_os.c   |  8 +++----
 3 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 5de1464c62b2..30f33065d114 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1668,41 +1668,25 @@ static struct enode *
 qla_enode_find(scsi_qla_host_t *vha, uint32_t ntype, uint32_t p1, uint32_t p2)
 {
 	struct enode		*node_rtn = NULL;
-	struct enode		*list_node = NULL;
+	struct enode		*list_node, *q;
 	unsigned long		flags;
-	struct list_head	*pos, *q;
 	uint32_t		sid;
-	uint32_t		rw_flag;
 	struct purexevent	*purex;
 
 	/* secure the list from moving under us */
 	spin_lock_irqsave(&vha->pur_cinfo.pur_lock, flags);
 
-	list_for_each_safe(pos, q, &vha->pur_cinfo.head) {
-		list_node = list_entry(pos, struct enode, list);
+	list_for_each_entry_safe(list_node, q, &vha->pur_cinfo.head, list) {
 
 		/* node type determines what p1 and p2 are */
 		purex = &list_node->u.purexinfo;
 		sid = p1;
-		rw_flag = p2;
 
 		if (purex->pur_info.pur_sid.b24 == sid) {
-			if (purex->pur_info.pur_pend == 1 &&
-			    rw_flag == PUR_GET) {
-				/*
-				 * if the receive is in progress
-				 * and its a read/get then can't
-				 * transfer yet
-				 */
-				ql_dbg(ql_dbg_edif, vha, 0x9106,
-				    "%s purex xfer in progress for sid=%x\n",
-				    __func__, sid);
-			} else {
-				/* found it and its complete */
-				node_rtn = list_node;
-				list_del(pos);
-				break;
-			}
+			/* found it and its complete */
+			node_rtn = list_node;
+			list_del(&list_node->list);
+			break;
 		}
 	}
 
@@ -2411,7 +2395,6 @@ void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp)
 
 	purex = &ptr->u.purexinfo;
 	purex->pur_info.pur_sid = a.did;
-	purex->pur_info.pur_pend = 0;
 	purex->pur_info.pur_bytes_rcvd = totlen;
 	purex->pur_info.pur_rx_xchg_address = le32_to_cpu(p->rx_xchg_addr);
 	purex->pur_info.pur_nphdl = le16_to_cpu(p->nport_handle);
@@ -3163,18 +3146,14 @@ static uint16_t qla_edif_sadb_get_sa_index(fc_port_t *fcport,
 /* release any sadb entries -- only done at teardown */
 void qla_edif_sadb_release(struct qla_hw_data *ha)
 {
-	struct list_head *pos;
-	struct list_head *tmp;
-	struct edif_sa_index_entry *entry;
+	struct edif_sa_index_entry *entry, *tmp;
 
-	list_for_each_safe(pos, tmp, &ha->sadb_rx_index_list) {
-		entry = list_entry(pos, struct edif_sa_index_entry, next);
+	list_for_each_entry_safe(entry, tmp, &ha->sadb_rx_index_list, next) {
 		list_del(&entry->next);
 		kfree(entry);
 	}
 
-	list_for_each_safe(pos, tmp, &ha->sadb_tx_index_list) {
-		entry = list_entry(pos, struct edif_sa_index_entry, next);
+	list_for_each_entry_safe(entry, tmp, &ha->sadb_tx_index_list, next) {
 		list_del(&entry->next);
 		kfree(entry);
 	}
diff --git a/drivers/scsi/qla2xxx/qla_edif.h b/drivers/scsi/qla2xxx/qla_edif.h
index 9e8f28d0caa1..cd54c1dfe3cb 100644
--- a/drivers/scsi/qla2xxx/qla_edif.h
+++ b/drivers/scsi/qla2xxx/qla_edif.h
@@ -102,7 +102,6 @@ struct dinfo {
 };
 
 struct pur_ninfo {
-	unsigned int	pur_pend:1;
 	port_id_t       pur_sid;
 	port_id_t	pur_did;
 	uint8_t		vp_idx;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3fca6b8bb23f..df0e46ef3e96 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3885,13 +3885,13 @@ qla2x00_remove_one(struct pci_dev *pdev)
 static inline void
 qla24xx_free_purex_list(struct purex_list *list)
 {
-	struct list_head *item, *next;
+	struct purex_item *item, *next;
 	ulong flags;
 
 	spin_lock_irqsave(&list->lock, flags);
-	list_for_each_safe(item, next, &list->head) {
-		list_del(item);
-		kfree(list_entry(item, struct purex_item, list));
+	list_for_each_entry_safe(item, next, &list->head, list) {
+		list_del(&item->list);
+		kfree(item);
 	}
 	spin_unlock_irqrestore(&list->lock, flags);
 }
-- 
2.19.0.rc0

