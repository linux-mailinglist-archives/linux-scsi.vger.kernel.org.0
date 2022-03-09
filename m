Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEA4D19D9
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347284AbiCHN7k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 08:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiCHN7h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 08:59:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF8D47060;
        Tue,  8 Mar 2022 05:58:41 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCcMd5YT6zdZwR;
        Tue,  8 Mar 2022 21:57:17 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:58:39 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:58:38 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v2 2/3] scsi:libiscsi: Add iscsi_cls_conn to sysfs after been initialized
Date:   Tue, 8 Mar 2022 22:09:15 -0500
Message-ID: <20220309030916.2932316-3-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220309030916.2932316-1-haowenchao@huawei.com>
References: <20220309030916.2932316-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

iscsi_create_conn() would expose iscsi_cls_conn to sysfs, while the
initialization of iscsi_conn's dd_data is not ready now. When userspace
try to access an attribute such as connect's address, it might cause
a NULL pointer dereference.

So we should add iscsi_cls_conn to sysfs until it has been initialized.

Remove iscsi_create_conn() by hand since it is not used now.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/libiscsi.c             | 13 ++++-
 drivers/scsi/scsi_transport_iscsi.c | 76 -----------------------------
 include/scsi/scsi_transport_iscsi.h |  2 -
 3 files changed, 11 insertions(+), 80 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 059dae8909ee..43f903bce0b8 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3040,8 +3040,9 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 	struct iscsi_conn *conn;
 	struct iscsi_cls_conn *cls_conn;
 	char *data;
+	int err;
 
-	cls_conn = iscsi_create_conn(cls_session, sizeof(*conn) + dd_size,
+	cls_conn = iscsi_alloc_conn(cls_session, sizeof(*conn) + dd_size,
 				     conn_idx);
 	if (!cls_conn)
 		return NULL;
@@ -3078,13 +3079,21 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 		goto login_task_data_alloc_fail;
 	conn->login_task->data = conn->data = data;
 
+	err = iscsi_add_conn(cls_conn);
+	if (err)
+		goto login_task_add_dev_fail;
+
 	return cls_conn;
 
+login_task_add_dev_fail:
+	free_pages((unsigned long) conn->data,
+		   get_order(ISCSI_DEF_MAX_RECV_SEG_LEN));
+
 login_task_data_alloc_fail:
 	kfifo_in(&session->cmdpool.queue, (void*)&conn->login_task,
 		    sizeof(void*));
 login_task_alloc_fail:
-	iscsi_destroy_conn(cls_conn);
+	iscsi_free_conn(cls_conn);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_setup);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 8e97c6f88359..ca724eed4f4d 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2447,82 +2447,6 @@ void iscsi_free_conn(struct iscsi_cls_conn *conn)
 }
 EXPORT_SYMBOL_GPL(iscsi_free_conn);
 
-/**
- * iscsi_create_conn - create iscsi class connection
- * @session: iscsi cls session
- * @dd_size: private driver data size
- * @cid: connection id
- *
- * This can be called from a LLD or iscsi_transport. The connection
- * is child of the session so cid must be unique for all connections
- * on the session.
- *
- * Since we do not support MCS, cid will normally be zero. In some cases
- * for software iscsi we could be trying to preallocate a connection struct
- * in which case there could be two connection structs and cid would be
- * non-zero.
- */
-struct iscsi_cls_conn *
-iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
-{
-	struct iscsi_transport *transport = session->transport;
-	struct iscsi_cls_conn *conn;
-	unsigned long flags;
-	int err;
-
-	conn = kzalloc(sizeof(*conn) + dd_size, GFP_KERNEL);
-	if (!conn)
-		return NULL;
-	if (dd_size)
-		conn->dd_data = &conn[1];
-
-	mutex_init(&conn->ep_mutex);
-	INIT_LIST_HEAD(&conn->conn_list);
-	INIT_WORK(&conn->cleanup_work, iscsi_cleanup_conn_work_fn);
-	conn->transport = transport;
-	conn->cid = cid;
-	conn->state = ISCSI_CONN_DOWN;
-
-	/* this is released in the dev's release function */
-	if (!get_device(&session->dev))
-		goto free_conn;
-
-	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
-	conn->dev.parent = &session->dev;
-	conn->dev.release = iscsi_conn_release;
-	err = device_register(&conn->dev);
-	if (err) {
-		iscsi_cls_session_printk(KERN_ERR, session, "could not "
-					 "register connection's dev\n");
-		goto release_parent_ref;
-	}
-	err = transport_register_device(&conn->dev);
-	if (err) {
-		iscsi_cls_session_printk(KERN_ERR, session, "could not "
-					 "register transport's dev\n");
-		goto release_conn_ref;
-	}
-
-	spin_lock_irqsave(&connlock, flags);
-	list_add(&conn->conn_list, &connlist);
-	spin_unlock_irqrestore(&connlock, flags);
-
-	ISCSI_DBG_TRANS_CONN(conn, "Completed conn creation\n");
-	return conn;
-
-release_conn_ref:
-	device_unregister(&conn->dev);
-	put_device(&session->dev);
-	return NULL;
-release_parent_ref:
-	put_device(&session->dev);
-free_conn:
-	kfree(conn);
-	return NULL;
-}
-
-EXPORT_SYMBOL_GPL(iscsi_create_conn);
-
 /**
  * iscsi_destroy_conn - destroy iscsi class connection
  * @conn: iscsi cls session
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 346f65bc3861..505764942f5e 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -446,8 +446,6 @@ extern struct iscsi_cls_conn *iscsi_alloc_conn(struct iscsi_cls_session *sess,
 extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_remove_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_free_conn(struct iscsi_cls_conn *conn);
-extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
-						int dd_size, uint32_t cid);
 extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_get_conn(struct iscsi_cls_conn *conn);
 extern int iscsi_destroy_conn(struct iscsi_cls_conn *conn);
-- 
2.32.0

