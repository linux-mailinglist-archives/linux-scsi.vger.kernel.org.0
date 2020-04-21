Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE7589040
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Aug 2022 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiHCQ3i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Aug 2022 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiHCQ3U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Aug 2022 12:29:20 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325F2610A;
        Wed,  3 Aug 2022 09:29:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 32693412D6;
        Wed,  3 Aug 2022 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1659544156; x=1661358557; bh=t0gWfskAxIMNQ8FvZn20aDt2R
        TIXHrsWhyzZRVYohBM=; b=hO+Wf+v6vX+Bb2CxTSA67euN/dcOnRFX49/ZLQu/e
        FQKNKLA15IE+CHE3mpxzZEWtTfKQOa44khhkhCkTzVxoO+K5UBcc1NZK6D+SQmwS
        hCOXmraWliypU+Wk9pMqkb6izUJmS0cHoyatMgQrPMkR3/nadperh//2uQqH0x0Y
        fM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q4ZF-NnPDRzR; Wed,  3 Aug 2022 19:29:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 539154129F;
        Wed,  3 Aug 2022 19:29:13 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 3 Aug 2022 19:29:13 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Wed, 3 Aug 2022 19:29:12 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [RFC PATCH 08/48] scsi: target/core: Add RTPI attribute for target port
Date:   Tue, 21 Apr 2020 17:00:11 +0300
Message-ID: <20220803162857.27770-9-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803162857.27770-1-d.bogdanov@yadro.com>
References: <20220803162857.27770-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

RELATIVE TARGET PORT IDENTIFIER can be read and configured via configfs:
$ echo 0x10 > $TARGET/tpgt_N/attrib/rtpi

RTPI has to be unique among all target ports, otherwise the write fails.

Configuration of a new RTPI value triggers INQUIRY DATA HAS CHANGED unit
attention as defined in SPC-4 "6.6.1 INQUIRY command introduction":

> If INQUIRY data changes for any reason, the device server shall
> establish a unit attention condition for the initiator port associated
> with every I_T nexus (see SAM-5), with the additional sense code set to
> INQUIRY DATA HAS CHANGED.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_tpg.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index 61fad44cf205..a409cf1c4ca0 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -715,6 +715,76 @@ void core_tpg_remove_lun(
 	percpu_ref_exit(&lun->lun_ref);
 }
 
+/* Set a Unit Attention on all I_T nexuses related to the port */
+static void core_tpg_ua(struct se_portal_group *se_tpg, u8 asc, u8 ascq)
+{
+	struct se_lun *lun;
+	struct se_dev_entry *se_deve;
+
+	mutex_lock(&se_tpg->tpg_lun_mutex);
+	hlist_for_each_entry_rcu(lun, &se_tpg->tpg_lun_hlist, link) {
+		spin_lock(&lun->lun_deve_lock);
+		list_for_each_entry(se_deve, &lun->lun_deve_list, lun_link)
+			core_scsi3_ua_allocate(se_deve, asc, ascq);
+		spin_unlock(&lun->lun_deve_lock);
+	}
+	mutex_unlock(&se_tpg->tpg_lun_mutex);
+}
+
+static ssize_t core_tpg_rtpi_show(struct config_item *item, char *page)
+{
+	struct se_portal_group *se_tpg = attrib_to_tpg(item);
+
+	return sprintf(page, "%#x\n", se_tpg->tpg_rtpi);
+}
+
+static ssize_t core_tpg_rtpi_store(struct config_item *item,
+				   const char *page, size_t count)
+{
+	struct se_portal_group *se_tpg = attrib_to_tpg(item);
+	struct se_portal_group *tpg;
+	bool rtpi_changed = false;
+	u16 val;
+	int ret;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val == 0)
+		return -EINVAL;
+
+	/* RTPI shouldn't conflict with values of existing ports */
+	spin_lock(&g_tpg_lock);
+
+	list_for_each_entry(tpg, &g_tpg_list, tpg_list) {
+		if (se_tpg != tpg && val == tpg->tpg_rtpi) {
+			spin_unlock(&g_tpg_lock);
+			pr_err("TARGET_CORE[%s]->TPG[%u] - RTPI %#x conflicts with TARGET_CORE[%s]->TPG[%u]\n",
+			       se_tpg->se_tpg_tfo->fabric_name,
+			       se_tpg->se_tpg_tfo->tpg_get_tag(tpg),
+			       val,
+			       tpg->se_tpg_tfo->fabric_name,
+			       tpg->se_tpg_tfo->tpg_get_tag(tpg));
+			return -EINVAL;
+		}
+	}
+
+	if (se_tpg->tpg_rtpi != val) {
+		se_tpg->tpg_rtpi = val;
+		rtpi_changed = true;
+	}
+	spin_unlock(&g_tpg_lock);
+
+	if (rtpi_changed)
+		core_tpg_ua(se_tpg, 0x3f, ASCQ_3FH_INQUIRY_DATA_HAS_CHANGED);
+	ret = count;
+
+	return ret;
+}
+
+CONFIGFS_ATTR(core_tpg_, rtpi);
+
 struct configfs_attribute *core_tpg_attrib_attrs[] = {
+	&core_tpg_attr_rtpi,
 	NULL,
 };
-- 
2.25.1

