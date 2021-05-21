Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAC38C2F6
	for <lists+linux-scsi@lfdr.de>; Fri, 21 May 2021 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhEUJX3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 May 2021 05:23:29 -0400
Received: from m12-18.163.com ([220.181.12.18]:54950 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbhEUJX1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 May 2021 05:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XVwWt
        iC6adqCfskl/QyIRQFo+CUg43aid67rB2TlL10=; b=GDOyN1vcmHs2oN4K6dKXi
        rnTqxrkyQw/7t1tASWpsnfWoS4YPHHg+rp/vK8xip0EmCAqlbD7xvqAzv0qxKQxn
        tRyPoAn7u4/cN5W0RJzM92tyBIKrJ2OS1lh6qBc1/1E5YzFI0xzFqbStak/3XPjB
        wuqzrnnQpglobBCwDu7g34=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAC3oN6ne6dgtWPbkg--.21092S2;
        Fri, 21 May 2021 17:21:47 +0800 (CST)
From:   zuoqilin1@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scsi:bfa: Fix typo
Date:   Fri, 21 May 2021 17:21:53 +0800
Message-Id: <20210521092153.379-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3oN6ne6dgtWPbkg--.21092S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy5Xr1UJFyrKF18Cr47XFb_yoW3ZFbE9a
        n3Jw1IgryvvrWxtw1UAFsrurWIvF1xuw1kuF9aqa4Sva1Yvrs5WasrWr17Zws5XF4kC3sr
        Z34qkw13Cr47AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1OtxPUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQSZiV8ZOoXrewABsZ
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'chnage' to 'change'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/scsi/bfa/bfa_defs_svc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_defs_svc.h b/drivers/scsi/bfa/bfa_defs_svc.h
index 8439951..f2c49f0 100644
--- a/drivers/scsi/bfa/bfa_defs_svc.h
+++ b/drivers/scsi/bfa/bfa_defs_svc.h
@@ -871,7 +871,7 @@ enum bfa_port_linkstate_rsn {
 
 /*
  * Initially flash content may be fff. On making LUN mask enable and disable
- * state chnage.  when report lun command is being processed it goes from
+ * state change.  when report lun command is being processed it goes from
  * BFA_LUN_MASK_ACTIVE to BFA_LUN_MASK_FETCH and comes back to
  * BFA_LUN_MASK_ACTIVE.
  */
-- 
1.9.1


