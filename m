Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9852C6B8011
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Mar 2023 19:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCMSLp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Mar 2023 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCMSL3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Mar 2023 14:11:29 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E97A916;
        Mon, 13 Mar 2023 11:11:26 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id DA92B342151;
        Mon, 13 Mar 2023 21:11:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=/0Z65Te9YumeUEZKFZ
        KB9uaJskGVpt2BXfshxvgV7Ro=; b=t650W2EaKrprkKOuCEz0cJADdFg5Ut8Kc6
        iBR9FGCUTmLDlfbaWS1sBF2m+0iAM/UDCqVLSYydu3d9MPiFxgmQHUyc0uoEtJJN
        DoeBu1M3GIxinptlt9DIF9EnRa2NzRZMtyjL1zYrgwpH+RLjSDwGsqB0boVJTrkZ
        J56u9lgk8=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id CF87B342145;
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
Subject: [PATCH v3 06/12] scsi: target: fcoe: remove default fabric ops callouts
Date:   Mon, 13 Mar 2023 21:11:04 +0300
Message-ID: <20230313181110.20566-7-d.bogdanov@yadro.com>
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
 drivers/target/tcm_fc/tcm_fc.h   |  1 -
 drivers/target/tcm_fc/tfc_cmd.c  |  5 -----
 drivers/target/tcm_fc/tfc_conf.c | 15 ---------------
 3 files changed, 21 deletions(-)

diff --git a/drivers/target/tcm_fc/tcm_fc.h b/drivers/target/tcm_fc/tcm_fc.h
index 2ff716d8cbdd..00e5573c6296 100644
--- a/drivers/target/tcm_fc/tcm_fc.h
+++ b/drivers/target/tcm_fc/tcm_fc.h
@@ -146,7 +146,6 @@ void ft_release_cmd(struct se_cmd *);
 int ft_queue_status(struct se_cmd *);
 int ft_queue_data_in(struct se_cmd *);
 int ft_write_pending(struct se_cmd *);
-int ft_get_cmd_state(struct se_cmd *);
 void ft_queue_tm_resp(struct se_cmd *);
 void ft_aborted_task(struct se_cmd *);
 
diff --git a/drivers/target/tcm_fc/tfc_cmd.c b/drivers/target/tcm_fc/tfc_cmd.c
index 410b723f9d79..21783cd71c15 100644
--- a/drivers/target/tcm_fc/tfc_cmd.c
+++ b/drivers/target/tcm_fc/tfc_cmd.c
@@ -223,11 +223,6 @@ int ft_write_pending(struct se_cmd *se_cmd)
 	return 0;
 }
 
-int ft_get_cmd_state(struct se_cmd *se_cmd)
-{
-	return 0;
-}
-
 /*
  * FC sequence response handler for follow-on sequences (data) and aborts.
  */
diff --git a/drivers/target/tcm_fc/tfc_conf.c b/drivers/target/tcm_fc/tfc_conf.c
index 1a38c98f681b..6ac3fc1a7d39 100644
--- a/drivers/target/tcm_fc/tfc_conf.c
+++ b/drivers/target/tcm_fc/tfc_conf.c
@@ -398,15 +398,6 @@ static u16 ft_get_tag(struct se_portal_group *se_tpg)
 	return ft_tpg(se_tpg)->index;
 }
 
-static int ft_check_false(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
-static void ft_set_default_node_attr(struct se_node_acl *se_nacl)
-{
-}
-
 static u32 ft_tpg_get_inst_index(struct se_portal_group *se_tpg)
 {
 	return ft_tpg(se_tpg)->index;
@@ -418,10 +409,6 @@ static const struct target_core_fabric_ops ft_fabric_ops = {
 	.node_acl_size =		sizeof(struct ft_node_acl),
 	.tpg_get_wwn =			ft_get_fabric_wwn,
 	.tpg_get_tag =			ft_get_tag,
-	.tpg_check_demo_mode =		ft_check_false,
-	.tpg_check_demo_mode_cache =	ft_check_false,
-	.tpg_check_demo_mode_write_protect = ft_check_false,
-	.tpg_check_prod_mode_write_protect = ft_check_false,
 	.tpg_get_inst_index =		ft_tpg_get_inst_index,
 	.check_stop_free =		ft_check_stop_free,
 	.release_cmd =			ft_release_cmd,
@@ -429,8 +416,6 @@ static const struct target_core_fabric_ops ft_fabric_ops = {
 	.sess_get_index =		ft_sess_get_index,
 	.sess_get_initiator_sid =	NULL,
 	.write_pending =		ft_write_pending,
-	.set_default_node_attributes =	ft_set_default_node_attr,
-	.get_cmd_state =		ft_get_cmd_state,
 	.queue_data_in =		ft_queue_data_in,
 	.queue_status =			ft_queue_status,
 	.queue_tm_rsp =			ft_queue_tm_resp,
-- 
2.25.1


