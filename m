Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD334EF39B
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiDAO5p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Apr 2022 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352535AbiDAOu1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 10:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73472B3330;
        Fri,  1 Apr 2022 07:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BAD3611E4;
        Fri,  1 Apr 2022 14:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A424C340F2;
        Fri,  1 Apr 2022 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824048;
        bh=CwQowb1XNFLdS/UPwZLTXi+3ITKGQlT2Hr0iMUTfAk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIruksJDz5pqURNaB6YUntqfSY5dBib7htNGK1YEnch2DY1fUyfUqRBLLbOtKuQ7G
         CsXlDYSGRS1LwmUgc8Q10inACxJsqjYNs1jaxaM5KxrSqIqkNvnh0jdvOzWnkQuLnb
         nnazyx50PvssTTaMvn6Dj73ev83JwWbVeUp0L81nl62OvjVhIXEqkAzFMVOiLUrU7L
         u7fjKCiOsOZcZDN0ObnjgZy/qryy9d7d4x3VCeoiaVJOVRyY4O/E25mo+DozWakGF7
         sxQCsrNCIJF2RrTL9iRc5dLeQ3BF1130/zNTyPb0pO/lNlwnzAubEINYYChmrQLH7T
         mvu7fWAe8ypQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 64/98] scsi: hisi_sas: Limit users changing debugfs BIST count value
Date:   Fri,  1 Apr 2022 10:37:08 -0400
Message-Id: <20220401143742.1952163-64-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 286ce4c65fbdf5eb9d4d5f4e4997c4e32bf1b073 ]

Add a file operation for "cnt" file under bist directory, so users can only
read "cnt" or clear "cnt" to zero, but cannot randomly modify.

Link: https://lore.kernel.org/r/1645703489-87194-6-git-send-email-john.garry@huawei.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 52 +++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index fd14f66c71df..299a22ab5bc9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3968,6 +3968,54 @@ static const struct file_operations debugfs_bist_phy_v3_hw_fops = {
 	.owner = THIS_MODULE,
 };
 
+static ssize_t debugfs_bist_cnt_v3_hw_write(struct file *filp,
+					const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	unsigned int cnt;
+	int val;
+
+	if (hisi_hba->debugfs_bist_enable)
+		return -EPERM;
+
+	val = kstrtouint_from_user(buf, count, 0, &cnt);
+	if (val)
+		return val;
+
+	if (cnt)
+		return -EINVAL;
+
+	hisi_hba->debugfs_bist_cnt = 0;
+	return count;
+}
+
+static int debugfs_bist_cnt_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+
+	seq_printf(s, "%u\n", hisi_hba->debugfs_bist_cnt);
+
+	return 0;
+}
+
+static int debugfs_bist_cnt_v3_hw_open(struct inode *inode,
+					  struct file *filp)
+{
+	return single_open(filp, debugfs_bist_cnt_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_cnt_v3_hw_ops = {
+	.open = debugfs_bist_cnt_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_cnt_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static const struct {
 	int		value;
 	char		*name;
@@ -4605,8 +4653,8 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 	debugfs_create_file("phy_id", 0600, hisi_hba->debugfs_bist_dentry,
 			    hisi_hba, &debugfs_bist_phy_v3_hw_fops);
 
-	debugfs_create_u32("cnt", 0600, hisi_hba->debugfs_bist_dentry,
-			   &hisi_hba->debugfs_bist_cnt);
+	debugfs_create_file("cnt", 0600, hisi_hba->debugfs_bist_dentry,
+			    hisi_hba, &debugfs_bist_cnt_v3_hw_ops);
 
 	debugfs_create_file("loopback_mode", 0600,
 			    hisi_hba->debugfs_bist_dentry,
-- 
2.34.1

