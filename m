Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240B278088
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Jul 2019 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfG1Qvg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 12:51:36 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:34542 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1Qvg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 28 Jul 2019 12:51:36 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id x6SGmLjl007695
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jul 2019 01:48:21 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6SGl8D5014222;
        Mon, 29 Jul 2019 01:47:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6SGl8D5014222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564332429;
        bh=mpYHa7s6QzNrys/LyWTOOn2taSGGO863b5EDmcRvPjs=;
        h=From:To:Cc:Subject:Date:From;
        b=TvRaYBwCMHeP0TwOcouBqcrCv7LVMt57qIX3aCICxRQJalnxM5a5UEeFY53Z45THH
         Q3Z1+zXUlosMC8SscI0dw6v+PGOONeko9pouiH1WJ0KWUPJIIeaXdqU4i8xbPOAOH+
         wUOk3CXpX4ujLsOiSE1I8LvuX+FqrrOz1B87oI1rhiZh0timbgV9YU45u6WfHU5PDr
         Reg4SoUbRk4cmLQ+2rQSaDmzPPTpauPGgX53ve5n40Y9D0kIAjqmxUXrum9PqDvmAQ
         OC8hGHkVEnqUiBg8QDiY8bc8FFzhSvuaULlMsLpdQJFJpxw7KCdWTGq+eh6GGc9T8B
         lB/QH4h9C3GJQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: raid_class: add include guard to raid_class.h
Date:   Mon, 29 Jul 2019 01:47:06 +0900
Message-Id: <20190728164706.16558-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/raid_class.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 5cdfcb873a8f..b62e42d8bb17 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -4,6 +4,10 @@
  *
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  */
+
+#ifndef _LINUX_RAID_CLASS_H
+#define _LINUX_RAID_CLASS_H
+
 #include <linux/transport_class.h>
 
 struct raid_template {
@@ -81,3 +85,4 @@ void raid_class_release(struct raid_template *);
 int __must_check raid_component_add(struct raid_template *, struct device *,
 				    struct device *);
 
+#endif /* _LINUX_RAID_CLASS_H */
-- 
2.17.1

