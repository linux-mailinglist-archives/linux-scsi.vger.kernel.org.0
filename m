Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1035B9F5
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Apr 2021 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhDLF7c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Apr 2021 01:59:32 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49062 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhDLF7c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 12 Apr 2021 01:59:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVD1scv_1618207148;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVD1scv_1618207148)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Apr 2021 13:59:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: message: fusion: remove useless variable
Date:   Mon, 12 Apr 2021 13:59:06 +0800
Message-Id: <1618207146-96542-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following gcc warning:

drivers/message/fusion/mptsas.c:783:14: warning: variable ‘vtarget’ set
but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/message/fusion/mptsas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 5eb0b33..c54e823 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -780,13 +780,11 @@ static inline MPT_ADAPTER *rphy_to_ioc(struct sas_rphy *rphy)
 mptsas_add_device_component_starget(MPT_ADAPTER *ioc,
 	struct scsi_target *starget)
 {
-	VirtTarget	*vtarget;
 	struct sas_rphy	*rphy;
 	struct mptsas_phyinfo	*phy_info = NULL;
 	struct mptsas_enclosure	enclosure_info;
 
 	rphy = dev_to_rphy(starget->dev.parent);
-	vtarget = starget->hostdata;
 	phy_info = mptsas_find_phyinfo_by_sas_address(ioc,
 			rphy->identify.sas_address);
 	if (!phy_info)
-- 
1.8.3.1

