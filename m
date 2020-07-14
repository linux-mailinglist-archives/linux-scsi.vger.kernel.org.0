Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41021F670
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGNPtd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 11:49:33 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:29462 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgGNPtc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Jul 2020 11:49:32 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06EFnQa3007041;
        Tue, 14 Jul 2020 08:49:27 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, dan.carpenter@oracle.com,
        dt@chelsio.com, ganji.aravind@chelsio.com, varun@chelsio.com
Subject: [next] scsi: cxgb4i: remove an unnecessary NULL check for 'cconn' pointer
Date:   Tue, 14 Jul 2020 21:19:11 +0530
Message-Id: <1594741751-3323-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

'cconn' will never be NULL in cxgbi_conn_alloc_pdu() so
remove NULL check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/scsi/cxgbi/libcxgbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 1fb101c..8756482 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -1889,7 +1889,7 @@ int cxgbi_conn_alloc_pdu(struct iscsi_task *task, u8 op)
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	struct cxgbi_conn *cconn = tcp_conn->dd_data;
 	struct cxgbi_device *cdev = cconn->chba->cdev;
-	struct cxgbi_sock *csk = (cconn && cconn->cep) ? cconn->cep->csk : NULL;
+	struct cxgbi_sock *csk = cconn->cep ? cconn->cep->csk : NULL;
 	struct iscsi_tcp_task *tcp_task = task->dd_data;
 	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
 	struct scsi_cmnd *sc = task->sc;
-- 
2.0.2

