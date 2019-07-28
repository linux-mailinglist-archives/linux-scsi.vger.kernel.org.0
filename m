Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00F78089
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Jul 2019 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfG1QwL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 12:52:11 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:34063 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1QwL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 28 Jul 2019 12:52:11 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-08.nifty.com with ESMTP id x6SGkx1O001355
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jul 2019 01:46:59 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6SGkjTu023020;
        Mon, 29 Jul 2019 01:46:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6SGkjTu023020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564332406;
        bh=Kf4ni2+7vXA+zu0PGCXWsKLl1UCXC9jZRZ/P0itgank=;
        h=From:To:Cc:Subject:Date:From;
        b=PIGa1a1ZNv7dcaLYKaBvgdoisYSc3IfpvgejNlTvjS5Ji8v8AvA2oErRLzCpEEbJg
         7U955bpSCo4E8H1xJVoTYdxsJobTIYUiL4JV46+7604Hf88GGEJH3UhPAlcklYRTke
         1K/LnGPxdRQ3ayYFWAhy/kAMkdblWhbUi5BMjYM8SKDOwm/ZMfBVc6a61JUtiD0+1d
         zmqn8g++U/pS/OxNh3xDPepuKkVucvG1vuoFIJuuHb3Jp27DcN90tk3BLJhY8RhJkH
         ICfaoN3yF+GD5a7T833uuYCJ3KvqdqQ19ePJtmf8Qzw61YVyZ/zCM5AoFCF6VvBLrH
         pqLNZZvwPZeMw==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ch: add include guard to chio.h
Date:   Mon, 29 Jul 2019 01:46:43 +0900
Message-Id: <20190728164643.16335-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/chio.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/chio.h b/include/uapi/linux/chio.h
index 689fc93fafda..e1cad4c319ee 100644
--- a/include/uapi/linux/chio.h
+++ b/include/uapi/linux/chio.h
@@ -3,6 +3,9 @@
  * ioctl interface for the scsi media changer driver
  */
 
+#ifndef _UAPI_LINUX_CHIO_H
+#define _UAPI_LINUX_CHIO_H
+
 /* changer element types */
 #define CHET_MT   0	/* media transport element (robot) */
 #define CHET_ST   1	/* storage element (media slots) */
@@ -160,10 +163,4 @@ struct changer_set_voltag {
 #define CHIOSVOLTAG    _IOW('c',18,struct changer_set_voltag)
 #define CHIOGVPARAMS   _IOR('c',19,struct changer_vendor_params)
 
-/* ---------------------------------------------------------------------- */
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
+#endif /* _UAPI_LINUX_CHIO_H */
-- 
2.17.1

