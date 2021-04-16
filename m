Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C174361BEC
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Apr 2021 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhDPIlO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Apr 2021 04:41:14 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42030 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238714AbhDPIlH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 16 Apr 2021 04:41:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7751A41390;
        Fri, 16 Apr 2021 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1618562438; x=1620376839; bh=uduGAqCQON2nAWKPqKV7WSGmbjJeL0w7EIG
        R8RS2lwQ=; b=BLF2V5RXtuuZr79+JtmoOdRIJMqvEMn+WUvsr45+GqGtlPlgM10
        YEFlYAQeqosJt8Xj8zpivHbo9fZEJImxQ0Sa6ody301p7YQTusCwq1GcY5cY8ELv
        gBOucACfvtDKNl3tf5Vc/63/DznlhabvlEzTLd0DYKvloqXKHpUaPyn8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MozQ0UYx-rP8; Fri, 16 Apr 2021 11:40:38 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 66F4B41373;
        Fri, 16 Apr 2021 11:40:37 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.0.63) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Apr 2021 11:40:36 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Nilesh Javali <njavali@marvell.com>,
        Chris Boot <bootc@bootc.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v4 4/7] target: sbp: replace enable attr to ops.enable
Date:   Fri, 16 Apr 2021 11:26:29 +0300
Message-ID: <20210416082632.2000-5-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416082632.2000-1-d.bogdanov@yadro.com>
References: <20210416082632.2000-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.63]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove tpg/enable attribute.
Add fabric ops enable_tpg implementation instead.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/sbp/sbp_target.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 2a6165febd3b..72f7c00134d3 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -2128,32 +2128,13 @@ static ssize_t sbp_tpg_directory_id_store(struct config_item *item,
 	return count;
 }
 
-static ssize_t sbp_tpg_enable_show(struct config_item *item, char *page)
+static int sbp_enable_tpg(struct se_portal_group *se_tpg, bool enable)
 {
-	struct se_portal_group *se_tpg = to_tpg(item);
 	struct sbp_tpg *tpg = container_of(se_tpg, struct sbp_tpg, se_tpg);
 	struct sbp_tport *tport = tpg->tport;
-	return sprintf(page, "%d\n", tport->enable);
-}
-
-static ssize_t sbp_tpg_enable_store(struct config_item *item,
-		const char *page, size_t count)
-{
-	struct se_portal_group *se_tpg = to_tpg(item);
-	struct sbp_tpg *tpg = container_of(se_tpg, struct sbp_tpg, se_tpg);
-	struct sbp_tport *tport = tpg->tport;
-	unsigned long val;
 	int ret;
 
-	if (kstrtoul(page, 0, &val) < 0)
-		return -EINVAL;
-	if ((val != 0) && (val != 1))
-		return -EINVAL;
-
-	if (tport->enable == val)
-		return count;
-
-	if (val) {
+	if (enable) {
 		if (sbp_count_se_tpg_luns(&tpg->se_tpg) == 0) {
 			pr_err("Cannot enable a target with no LUNs!\n");
 			return -EINVAL;
@@ -2168,7 +2149,7 @@ static ssize_t sbp_tpg_enable_store(struct config_item *item,
 		spin_unlock_bh(&se_tpg->session_lock);
 	}
 
-	tport->enable = val;
+	tport->enable = enable;
 
 	ret = sbp_update_unit_directory(tport);
 	if (ret < 0) {
@@ -2176,15 +2157,13 @@ static ssize_t sbp_tpg_enable_store(struct config_item *item,
 		return ret;
 	}
 
-	return count;
+	return 0;
 }
 
 CONFIGFS_ATTR(sbp_tpg_, directory_id);
-CONFIGFS_ATTR(sbp_tpg_, enable);
 
 static struct configfs_attribute *sbp_tpg_base_attrs[] = {
 	&sbp_tpg_attr_directory_id,
-	&sbp_tpg_attr_enable,
 	NULL,
 };
 
@@ -2322,6 +2301,7 @@ static const struct target_core_fabric_ops sbp_ops = {
 	.fabric_make_wwn		= sbp_make_tport,
 	.fabric_drop_wwn		= sbp_drop_tport,
 	.fabric_make_tpg		= sbp_make_tpg,
+	.fabric_enable_tpg		= sbp_enable_tpg,
 	.fabric_drop_tpg		= sbp_drop_tpg,
 	.fabric_post_link		= sbp_post_link_lun,
 	.fabric_pre_unlink		= sbp_pre_unlink_lun,
-- 
2.25.1

