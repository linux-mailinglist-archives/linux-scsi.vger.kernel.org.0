Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C39575897
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Jul 2022 02:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiGOAR1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Jul 2022 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiGOAR1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Jul 2022 20:17:27 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C04CC73936
        for <linux-scsi@vger.kernel.org>; Thu, 14 Jul 2022 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lQZc7
        4qvDL7wDfhdGqakL3PiCA0YrzNHgxfo7u78gYk=; b=pEiWXvQKUXcGrja0vnxsH
        +/eGZzIcyXqcfHjiParhCGKzpV7ozEKwRCd42cVr1BTdcRggwRDpH1VHy7RsiVOc
        5JQxkuXCBtYGD0o6/JGQCdI8cUpsNNbdWpZQvV2H0KNTLV8HfhK1MkYoq1ytFwhs
        uROWLMJ8+lUDm66S2cuG90=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAXk9MAstBiyeO3Gg--.3606S2;
        Fri, 15 Jul 2022 08:17:05 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        windhl@126.com, linux-scsi@vger.kernel.org
Subject: [PATCH v2] ufs: host: ufschd-pltfrm: Hold reference returned by  of_parse_phandle()
Date:   Fri, 15 Jul 2022 08:17:03 +0800
Message-Id: <20220715001703.389981-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAXk9MAstBiyeO3Gg--.3606S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry5XrWxKw1DWFykZF13Jwb_yoW8WFWkpF
        WY93y5Zr4xKFWIgayIy3WUC3s3Kw4xGryUGFZ2k34Syrs2qayxXa1kKa45C3WrJFyfZ3W8
        tFs2vF1kuanFvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5WrZUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgE-F18RPfsofAAAs7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In ufshcd_populate_vreg(), we should hold the reference returned by
of_parse_phandle() and then use it to call of_node_put() for refcount
balance.

Fixes: aa4976130934 ("ufs: Add regulator enable support")
Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use a proper helper name advised by Bart Van Assche.
 v1: add a helper to fix the bug

 v1 link: https://lore.kernel.org/all/20220714055413.373449-1-windhl@126.com/


 drivers/ufs/host/ufshcd-pltfrm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index e7332cc65b1f..46ded7813c42 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -108,6 +108,21 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	return ret;
 }
 
+static bool phandle_exists(const struct device_node *np,
+						const char *phandle_name,
+						int index)
+{
+	struct device_node *parse_np = of_parse_phandle(np, phandle_name, index);
+	bool ret = false;
+
+	if (parse_np) {
+		ret = true;
+		of_node_put(parse_np);
+	}
+
+	return ret;
+}
+
 #define MAX_PROP_SIZE 32
 static int ufshcd_populate_vreg(struct device *dev, const char *name,
 		struct ufs_vreg **out_vreg)
@@ -122,7 +137,7 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 	}
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-supply", name);
-	if (!of_parse_phandle(np, prop_name, 0)) {
+	if (!phandle_exists(np, prop_name, 0)) {
 		dev_info(dev, "%s: Unable to find %s regulator, assuming enabled\n",
 				__func__, prop_name);
 		goto out;
-- 
2.25.1

