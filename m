Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A973C311F
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Jul 2021 04:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhGJCkM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 22:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235886AbhGJCju (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 9 Jul 2021 22:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253CB6143E;
        Sat, 10 Jul 2021 02:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884575;
        bh=UPcY7p/xBM474osapEx9fb+98A24OINPFDQEPCC2jIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtpmLKaaGSsUAeYMCa17CqHeB8hQ10CDxKCHjvcyOMJDyQtpG3AFDbwlGrKJw8DSy
         rlKEXDdE+BUB6uQp5xOoqMIHPUguWT+GhnqH+AW945qTIcMr9QPvLPlWYkIjOp4uKP
         2TtsjXrG/wDLWEvKQDgX1/ywwiH/nNQdAo+nXKipHbJm2G+k/+RyWzycd4Btp5FhPd
         GJ2V59ekMzcYegMStdENOqRUTGaiNy0ujVIqa9kIf6e0CGwqBvT1FmNDerjL+DprZn
         aOiHCLOakl5i4v4n6MnW2mgwL22L+YkTglSZvl20pdwGiWJvZDoyjtu9GA3gY3aAzx
         TKw3bWsC3U2sw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/26] scsi: iscsi: Add iscsi_cls_conn refcount helpers
Date:   Fri,  9 Jul 2021 22:35:46 -0400
Message-Id: <20210710023604.3172486-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023604.3172486-1-sashal@kernel.org>
References: <20210710023604.3172486-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit b1d19e8c92cfb0ded180ef3376c20e130414e067 ]

There are a couple places where we could free the iscsi_cls_conn while it's
still in use. This adds some helpers to get/put a refcount on the struct
and converts an exiting user. Subsequent commits will then use the helpers
to fix 2 bugs in the eh code.

Link: https://lore.kernel.org/r/20210525181821.7617-11-michael.christie@oracle.com
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libiscsi.c             |  7 ++-----
 drivers/scsi/scsi_transport_iscsi.c | 12 ++++++++++++
 include/scsi/scsi_transport_iscsi.h |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 50e2943c3337..30e954bb6c81 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1384,7 +1384,6 @@ void iscsi_session_failure(struct iscsi_session *session,
 			   enum iscsi_err err)
 {
 	struct iscsi_conn *conn;
-	struct device *dev;
 
 	spin_lock_bh(&session->frwd_lock);
 	conn = session->leadconn;
@@ -1393,10 +1392,8 @@ void iscsi_session_failure(struct iscsi_session *session,
 		return;
 	}
 
-	dev = get_device(&conn->cls_conn->dev);
+	iscsi_get_conn(conn->cls_conn);
 	spin_unlock_bh(&session->frwd_lock);
-	if (!dev)
-	        return;
 	/*
 	 * if the host is being removed bypass the connection
 	 * recovery initialization because we are going to kill
@@ -1406,7 +1403,7 @@ void iscsi_session_failure(struct iscsi_session *session,
 		iscsi_conn_error_event(conn->cls_conn, err);
 	else
 		iscsi_conn_failure(conn, err);
-	put_device(dev);
+	iscsi_put_conn(conn->cls_conn);
 }
 EXPORT_SYMBOL_GPL(iscsi_session_failure);
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 4f4d2d65a4a7..337aad0660fa 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2327,6 +2327,18 @@ int iscsi_destroy_conn(struct iscsi_cls_conn *conn)
 }
 EXPORT_SYMBOL_GPL(iscsi_destroy_conn);
 
+void iscsi_put_conn(struct iscsi_cls_conn *conn)
+{
+	put_device(&conn->dev);
+}
+EXPORT_SYMBOL_GPL(iscsi_put_conn);
+
+void iscsi_get_conn(struct iscsi_cls_conn *conn)
+{
+	get_device(&conn->dev);
+}
+EXPORT_SYMBOL_GPL(iscsi_get_conn);
+
 /*
  * iscsi interface functions
  */
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 6183d20a01fb..e673c7c9c5fb 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -437,6 +437,8 @@ extern void iscsi_free_session(struct iscsi_cls_session *session);
 extern int iscsi_destroy_session(struct iscsi_cls_session *session);
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 						int dd_size, uint32_t cid);
+extern void iscsi_put_conn(struct iscsi_cls_conn *conn);
+extern void iscsi_get_conn(struct iscsi_cls_conn *conn);
 extern int iscsi_destroy_conn(struct iscsi_cls_conn *conn);
 extern void iscsi_unblock_session(struct iscsi_cls_session *session);
 extern void iscsi_block_session(struct iscsi_cls_session *session);
-- 
2.30.2

