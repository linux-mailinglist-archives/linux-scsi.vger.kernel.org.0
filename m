Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0265B7879
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Sep 2022 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiIMRnM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Sep 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiIMRmj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Sep 2022 13:42:39 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF9B864;
        Tue, 13 Sep 2022 09:36:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0B372452C0;
        Tue, 13 Sep 2022 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1663086982; x=
        1664901383; bh=r0CwdQ0aYnZ3almcA+1OnRUGEpZIizTOz5cKY7PpPfg=; b=Z
        aU2vX7qltX1PfLn5owQR7TKvUvfsBqMzeG8TkPFCljAmPbJMDYZsgSp4hCSmiDu6
        Tx/Gjw09x1EdDCo/+zbLln3g+VEpmZ2ey1qda10OgS7qWavXz9LhXx9kEPPtgnse
        AjkpC3+75+L28wVySFfPTg9Xy9S382/Cwpi+/a6teI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hzlHwMt33NPP; Tue, 13 Sep 2022 19:36:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AB5CA452CB;
        Tue, 13 Sep 2022 19:36:21 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 13 Sep 2022 19:36:21 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Tue, 13 Sep 2022 19:36:20 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH] target: core: UA on all luns after reset
Date:   Tue, 13 Sep 2022 19:36:02 +0300
Message-ID: <20220913163602.20597-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Allocate UA "BUS DEVICE RESET OCCURRED" on all LUNs on all
target ports of the device upon reception of TMF LUN RESET.

The patch passes a libiscsi test SCSI.MultipathIO.Reset.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_device.c    | 19 +++++++++++++++++++
 drivers/target/target_core_internal.h  |  1 +
 drivers/target/target_core_transport.c |  3 +--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 2209660261d0..b8ab744783ed 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -284,6 +284,25 @@ void target_pr_kref_release(struct kref *kref)
 	complete(&deve->pr_comp);
 }
 
+/*
+ * Establish UA condition on SCSI device - all LUNs
+ */
+void target_dev_ua_allocate(struct se_device *dev, u8 asc, u8 ascq)
+{
+	struct se_dev_entry *se_deve;
+	struct se_lun *lun;
+
+	spin_lock(&dev->se_port_lock);
+	list_for_each_entry(lun, &dev->dev_sep_list, lun_dev_link) {
+
+		spin_lock(&lun->lun_deve_lock);
+		list_for_each_entry(se_deve, &lun->lun_deve_list, lun_link)
+			core_scsi3_ua_allocate(se_deve, asc, ascq);
+		spin_unlock(&lun->lun_deve_lock);
+	}
+	spin_unlock(&dev->se_port_lock);
+}
+
 static void
 target_luns_data_has_changed(struct se_node_acl *nacl, struct se_dev_entry *new,
 			     bool skip_new)
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index d4ace697edb0..4b608a282579 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -88,6 +88,7 @@ int	target_configure_device(struct se_device *dev);
 void	target_free_device(struct se_device *);
 int	target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 			       void *data);
+void	target_dev_ua_allocate(struct se_device *dev, u8 asc, u8 ascq);
 
 /* target_core_configfs.c */
 extern struct configfs_item_operations target_core_dev_item_ops;
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7838dc20f713..5926316252eb 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3531,8 +3531,7 @@ static void target_tmr_work(struct work_struct *work)
 		tmr->response = (!ret) ? TMR_FUNCTION_COMPLETE :
 					 TMR_FUNCTION_REJECTED;
 		if (tmr->response == TMR_FUNCTION_COMPLETE) {
-			target_ua_allocate_lun(cmd->se_sess->se_node_acl,
-					       cmd->orig_fe_lun, 0x29,
+			target_dev_ua_allocate(dev, 0x29,
 					       ASCQ_29H_BUS_DEVICE_RESET_FUNCTION_OCCURRED);
 		}
 		break;
-- 
2.25.1

