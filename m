Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22B74699
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGYFyR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jul 2019 01:54:17 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:45188 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYFyR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Jul 2019 01:54:17 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 01:54:16 EDT
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 974C71008CBC9;
        Thu, 25 Jul 2019 13:47:10 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 8F20C20424204;
        Thu, 25 Jul 2019 13:47:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XMeZdFXMpGGD; Thu, 25 Jul 2019 13:47:10 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 6B4E820424202;
        Thu, 25 Jul 2019 13:47:10 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] scsi: qla2xxx: replace snprintf with strscpy
Date:   Thu, 25 Jul 2019 13:46:53 +0800
Message-Id: <20190725054653.30729-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As commit a86028f8e3ee ("staging: most: sound: replace snprintf
with strscpy") suggested, using snprintf without a format specifier
is potentially risky if a0->vendor_name or a0->vendor_pn mistakenly
contain format specifiers. In addition, as compared in the
implementation, strscpy looks more light-weight than snprintf.

This patch does not incur any functional change.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 4059655639d9..068b54218ff4 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3461,12 +3461,12 @@ static void qla2xxx_print_sfp_info(struct scsi_qla_host *vha)
 	int leftover, len;
 
 	memset(str, 0, STR_LEN);
-	snprintf(str, SFF_VEN_NAME_LEN+1, a0->vendor_name);
+	strscpy(str, a0->vendor_name, SFF_VEN_NAME_LEN+1);
 	ql_dbg(ql_dbg_init, vha, 0x015a,
 	    "SFP MFG Name: %s\n", str);
 
 	memset(str, 0, STR_LEN);
-	snprintf(str, SFF_PART_NAME_LEN+1, a0->vendor_pn);
+	strscpy(str, a0->vendor_pn, SFF_PART_NAME_LEN+1);
 	ql_dbg(ql_dbg_init, vha, 0x015c,
 	    "SFP Part Name: %s\n", str);
 
-- 
2.11.0

