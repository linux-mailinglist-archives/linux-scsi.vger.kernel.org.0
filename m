Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6029838C1C9
	for <lists+linux-scsi@lfdr.de>; Fri, 21 May 2021 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhEUI3m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 May 2021 04:29:42 -0400
Received: from m12-16.163.com ([220.181.12.16]:41450 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhEUI3l (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 May 2021 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=S2Aqv
        fimJwk19/jxLaWoFTY8zWl28dhMVj/NQdnFLb8=; b=WtcnqoNG/yBjHN2zgw5mm
        oXRzKna4PbXnuFy5yeyQ+Vqung++L3buTUxh4BVZ0sEl1TD5fTLxP7qyUCguk+v6
        wskN9BTadntKLS255sgon1xzLNBzDPDqOE6lHh4G86UX8l2yqbUIeeR6sc/J+6eN
        Si2vLTBu1wMuxyzHnmKKC8=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowAAnLloOb6dgvLrGsQ--.31617S2;
        Fri, 21 May 2021 16:28:02 +0800 (CST)
From:   zuoqilin1@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scsi: Fix typo
Date:   Fri, 21 May 2021 16:28:08 +0800
Message-Id: <20210521082808.1925-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAnLloOb6dgvLrGsQ--.31617S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8ZF4DXF1fuF4Duw1kGrg_yoWfWrg_Gw
        1DX3s7WF12vFn2yF13JwsxZrZY93Z7uws5Ca90qayfu3yxZw4rWwnrWFnrZwsxGF45u3sx
        Zw1vqF9Iyr4DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81xRDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiThuXiVUDJkBsQwACsW
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change "avaibale" and "avaible" to "available".

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/scsi/pmcraid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index 6d36deb..bbb7531 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -47,8 +47,8 @@
 /*
  * MAX_CMD          : maximum commands that can be outstanding with IOA
  * MAX_IO_CMD       : command blocks available for IO commands
- * MAX_HCAM_CMD     : command blocks avaibale for HCAMS
- * MAX_INTERNAL_CMD : command blocks avaible for internal commands like reset
+ * MAX_HCAM_CMD     : command blocks available for HCAMS
+ * MAX_INTERNAL_CMD : command blocks available for internal commands like reset
  */
 #define PMCRAID_MAX_CMD				1024
 #define PMCRAID_MAX_IO_CMD			1020
-- 
1.9.1


