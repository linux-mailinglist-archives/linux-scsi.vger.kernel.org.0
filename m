Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCB32CC67
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 07:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhCDGJb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 01:09:31 -0500
Received: from m12-18.163.com ([220.181.12.18]:47327 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234570AbhCDGJW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 4 Mar 2021 01:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YdZwc
        rJTH3iIZQJI63wd2sP5yWzzgQ0d6i0V1hBWzHM=; b=Y0pK3n7ICSf3lOfxo1YjK
        BuiPInFJd1Tbz1oyjDNlFPLrwWESaDOKGEMYMpO27L6Q4+Ucj+aDP0KzRK32WX+W
        3J4nmG7PmRCC2fdI4hILN+8sCiLgtk8hYDp1AfTwQx0/E6OeusLxXFIwaArUdOiU
        HHO3Ev/LTOYigV14ZZh610=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACHgO5adUBgKkPcWw--.28143S2;
        Thu, 04 Mar 2021 13:51:27 +0800 (CST)
From:   zuoqilin1@163.com
To:     khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scsi: FlashPoint: Fix typo issue
Date:   Thu,  4 Mar 2021 13:51:20 +0800
Message-Id: <20210304055120.2221-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHgO5adUBgKkPcWw--.28143S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8Aw1rGF18Kw4Dtr1fJFb_yoW3ZFg_uF
        Z5JF47uFy5Zwn7Jrn3tF4DGryFv3WUXF1kuFnIqrW3Cr9rXwn3Ja4kXrWUXr1UZw45JF9x
        Jw1UXr4Yyw17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQdKiV8ZM-29QwABsW
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'defualt' to 'default'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/scsi/FlashPoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 24ace18..f479c54 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -4534,7 +4534,7 @@ static void FPT_phaseBusFree(u32 port, unsigned char p_card)
  *
  * Function: Auto Load Default Map
  *
- * Description: Load the Automation RAM with the defualt map values.
+ * Description: Load the Automation RAM with the default map values.
  *
  *---------------------------------------------------------------------*/
 static void FPT_autoLoadDefaultMap(u32 p_port)
-- 
1.9.1


