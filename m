Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7C24DCE1
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Aug 2020 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHURJW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Aug 2020 13:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbgHUQRi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC4722C9F;
        Fri, 21 Aug 2020 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026654;
        bh=wljQwHlpf9bp/QI7uHx7YkLy4gyPMzPnNX2OUYwUAy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mA4kdGxh9d7kkSPUrTme4sK21FJsGkX9CI1qS0DIsBBc32WhJghxgPleZDXZLSGfN
         CLkFO8XB18JGzLQGgNPwAMEOvS7N1MTq2BHYUxEnj8PR4X+D+QlQCjPJ9uDzhTE9Mg
         s/meq0HzGVllADpwklARU1fBMj3NytZYz/MNrrRU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 24/48] scsi: target: Fix xcopy sess release leak
Date:   Fri, 21 Aug 2020 12:16:40 -0400
Message-Id: <20200821161704.348164-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 3c006c7d23aac928279f7cbe83bbac4361255d53 ]

transport_init_session can allocate memory via percpu_ref_init, and
target_xcopy_release_pt never frees it. This adds a
transport_uninit_session function to handle cleanup of resources allocated
in the init function.

Link: https://lore.kernel.org/r/1593654203-12442-3-git-send-email-michael.christie@oracle.com
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_internal.h  |  1 +
 drivers/target/target_core_transport.c |  7 ++++++-
 drivers/target/target_core_xcopy.c     | 11 +++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index 8533444159635..e7b3c6e5d5744 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -138,6 +138,7 @@ int	init_se_kmem_caches(void);
 void	release_se_kmem_caches(void);
 u32	scsi_get_new_index(scsi_index_t);
 void	transport_subsystem_check_init(void);
+void	transport_uninit_session(struct se_session *);
 unsigned char *transport_dump_cmd_direction(struct se_cmd *);
 void	transport_dump_dev_state(struct se_device *, char *, int *);
 void	transport_dump_dev_info(struct se_device *, struct se_lun *,
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7c78a5d02c083..b1f4be055f838 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -236,6 +236,11 @@ int transport_init_session(struct se_session *se_sess)
 }
 EXPORT_SYMBOL(transport_init_session);
 
+void transport_uninit_session(struct se_session *se_sess)
+{
+	percpu_ref_exit(&se_sess->cmd_count);
+}
+
 /**
  * transport_alloc_session - allocate a session object and initialize it
  * @sup_prot_ops: bitmask that defines which T10-PI modes are supported.
@@ -579,7 +584,7 @@ void transport_free_session(struct se_session *se_sess)
 		sbitmap_queue_free(&se_sess->sess_tag_pool);
 		kvfree(se_sess->sess_cmd_map);
 	}
-	percpu_ref_exit(&se_sess->cmd_count);
+	transport_uninit_session(se_sess);
 	kmem_cache_free(se_sess_cache, se_sess);
 }
 EXPORT_SYMBOL(transport_free_session);
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index b9b1e92c6f8db..9d24e85b08631 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -479,7 +479,7 @@ int target_xcopy_setup_pt(void)
 	memset(&xcopy_pt_sess, 0, sizeof(struct se_session));
 	ret = transport_init_session(&xcopy_pt_sess);
 	if (ret < 0)
-		return ret;
+		goto destroy_wq;
 
 	xcopy_pt_nacl.se_tpg = &xcopy_pt_tpg;
 	xcopy_pt_nacl.nacl_sess = &xcopy_pt_sess;
@@ -488,12 +488,19 @@ int target_xcopy_setup_pt(void)
 	xcopy_pt_sess.se_node_acl = &xcopy_pt_nacl;
 
 	return 0;
+
+destroy_wq:
+	destroy_workqueue(xcopy_wq);
+	xcopy_wq = NULL;
+	return ret;
 }
 
 void target_xcopy_release_pt(void)
 {
-	if (xcopy_wq)
+	if (xcopy_wq) {
 		destroy_workqueue(xcopy_wq);
+		transport_uninit_session(&xcopy_pt_sess);
+	}
 }
 
 /*
-- 
2.25.1

