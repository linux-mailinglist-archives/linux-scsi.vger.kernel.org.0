Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A56B800F
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Mar 2023 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCMSLn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Mar 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCMSL3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Mar 2023 14:11:29 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D87A90F;
        Mon, 13 Mar 2023 11:11:26 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 14A8C342150;
        Mon, 13 Mar 2023 21:11:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=2W+4LtZZa24FHSOs4t
        4NaHZOeSWzlTVXaQitGnl4kns=; b=WDDpQuFOQ03hMhp7XeHPq8R1PEox4fNYP4
        1kcEdTLUu4srmH8IQoHZCw5bG4l6b+NMwfBZ+Bq4O0oX+k+IguWaur+Y12DLVBII
        e4PpVe0ua3a3yw7y1WuRFrbC04fVHnVyE8oL7NVyox+UL5/7R3bigE9/Tu/Ps8dk
        H6F9+Tp7E=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 0AA8A342145;
        Mon, 13 Mar 2023 21:11:20 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.20.11) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 13 Mar 2023 21:11:19 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Chris Boot <bootc@bootc.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v3 05/12] scsi: target: sbp: remove default fabric ops callouts
Date:   Mon, 13 Mar 2023 21:11:03 +0300
Message-ID: <20230313181110.20566-6-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313181110.20566-1-d.bogdanov@yadro.com>
References: <20230313181110.20566-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.20.11]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove callouts that have the implementation like a
default implementation in TCM Core.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/sbp/sbp_target.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 504670994fb4..2a761bc09193 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -1673,11 +1673,6 @@ static int sbp_check_true(struct se_portal_group *se_tpg)
 	return 1;
 }
 
-static int sbp_check_false(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
 static char *sbp_get_fabric_wwn(struct se_portal_group *se_tpg)
 {
 	struct sbp_tpg *tpg = container_of(se_tpg, struct sbp_tpg, se_tpg);
@@ -1692,11 +1687,6 @@ static u16 sbp_get_tag(struct se_portal_group *se_tpg)
 	return tpg->tport_tpgt;
 }
 
-static u32 sbp_tpg_get_inst_index(struct se_portal_group *se_tpg)
-{
-	return 1;
-}
-
 static void sbp_release_cmd(struct se_cmd *se_cmd)
 {
 	struct sbp_target_request *req = container_of(se_cmd,
@@ -1705,11 +1695,6 @@ static void sbp_release_cmd(struct se_cmd *se_cmd)
 	sbp_free_request(req);
 }
 
-static u32 sbp_sess_get_index(struct se_session *se_sess)
-{
-	return 0;
-}
-
 static int sbp_write_pending(struct se_cmd *se_cmd)
 {
 	struct sbp_target_request *req = container_of(se_cmd,
@@ -1733,16 +1718,6 @@ static int sbp_write_pending(struct se_cmd *se_cmd)
 	return 0;
 }
 
-static void sbp_set_default_node_attrs(struct se_node_acl *nacl)
-{
-	return;
-}
-
-static int sbp_get_cmd_state(struct se_cmd *se_cmd)
-{
-	return 0;
-}
-
 static int sbp_queue_data_in(struct se_cmd *se_cmd)
 {
 	struct sbp_target_request *req = container_of(se_cmd,
@@ -2281,14 +2256,8 @@ static const struct target_core_fabric_ops sbp_ops = {
 	.tpg_get_tag			= sbp_get_tag,
 	.tpg_check_demo_mode		= sbp_check_true,
 	.tpg_check_demo_mode_cache	= sbp_check_true,
-	.tpg_check_demo_mode_write_protect = sbp_check_false,
-	.tpg_check_prod_mode_write_protect = sbp_check_false,
-	.tpg_get_inst_index		= sbp_tpg_get_inst_index,
 	.release_cmd			= sbp_release_cmd,
-	.sess_get_index			= sbp_sess_get_index,
 	.write_pending			= sbp_write_pending,
-	.set_default_node_attributes	= sbp_set_default_node_attrs,
-	.get_cmd_state			= sbp_get_cmd_state,
 	.queue_data_in			= sbp_queue_data_in,
 	.queue_status			= sbp_queue_status,
 	.queue_tm_rsp			= sbp_queue_tm_rsp,
-- 
2.25.1


