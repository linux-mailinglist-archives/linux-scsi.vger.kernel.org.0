Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E107BA1B
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jul 2019 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGaHGn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Jul 2019 03:06:43 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:45634 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGaHGn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Jul 2019 03:06:43 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 5B9351008CBC3;
        Wed, 31 Jul 2019 15:06:40 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 486E620424204;
        Wed, 31 Jul 2019 15:06:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mK_lKYDd760j; Wed, 31 Jul 2019 15:06:40 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 19D2E20424202;
        Wed, 31 Jul 2019 15:06:40 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] scsi/lpfc: force the string buffer NULL-terminated
Date:   Wed, 31 Jul 2019 15:06:31 +0800
Message-Id: <20190731070631.20744-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

strncpy() does not ensure NULL-termination when the input string
size equals to the destination buffer size LPFC_MAX_DATA_CTRL_LEN.
The output string bucket_data is passed to strsep() which relies
on NULL-termination.

Use strlcpy() instead.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ea62322ffe2b..ca3fdc9857fb 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4197,7 +4197,7 @@ lpfc_stat_data_ctrl_store(struct device *dev, struct device_attribute *attr,
 		if (strlen(buf) > (LPFC_MAX_DATA_CTRL_LEN - 1))
 			return -EINVAL;
 
-		strncpy(bucket_data, buf, LPFC_MAX_DATA_CTRL_LEN);
+		strlcpy(bucket_data, buf, LPFC_MAX_DATA_CTRL_LEN);
 		str_ptr = &bucket_data[0];
 		/* Ignore this token - this is command token */
 		token = strsep(&str_ptr, "\t ");
-- 
2.11.0

