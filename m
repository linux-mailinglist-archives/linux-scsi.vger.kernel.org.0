Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2E62F9F
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 06:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGIE30 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 00:29:26 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:40610 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIE30 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 00:29:26 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-09.nifty.com with ESMTP id x694PgRH031832
        for <linux-scsi@vger.kernel.org>; Tue, 9 Jul 2019 13:25:42 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x694OqVn009969;
        Tue, 9 Jul 2019 13:24:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x694OqVn009969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562646296;
        bh=5nWs7/nqfQz6GjAJbPPMqdQM8R/kzVjvDPkmY/vF878=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXhQ5tftVYFpZ3lwtqgdh7MBeEKfaX9BSHQKGyw1DEnmO8OXtJTFbPqvG8/8hw5o5
         07xfbmZn5Ru+y04MCFDJB8tlsHrbhZN0iCPXmrjmGURx00kvqohJ7/7eIrP8kNmg9W
         8RxmYnir1mJi5/opP23NRm7sIfg83gXdQ0M4dJQ9MosSMKCdaH39mKfqPydkVCIQlN
         1SNhq5KfdG9ZJHiPLwYU87xZv+xycc6mOD0OAc7TJKsuJGFqz6UaZsbsORU0UJh3gw
         BZeDj+19fnAPk+GANqVdnaIaNPVzojMMwr3Vft1pS8UP76cnUw2+AK5qkvk5srVJ6x
         qzMkAOfa2WTSQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicolas Pitre <nico@fluxnic.net>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] scsi: remove pointless $(MODVERDIR)/$(obj)/53c700.ver
Date:   Tue,  9 Jul 2019 13:24:08 +0900
Message-Id: <20190709042416.27554-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709042416.27554-1-yamada.masahiro@socionext.com>
References: <20190709042416.27554-1-yamada.masahiro@socionext.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Nothing depends on this, so it is dead code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will apply this to kbuild tree since it is trivial.


 drivers/scsi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 8826111fdf4a..acdd57e647f8 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -183,7 +183,7 @@ zalon7xx-objs	:= zalon.o ncr53c8xx.o
 # Files generated that shall be removed upon make clean
 clean-files :=	53c700_d.h 53c700_u.h scsi_devinfo_tbl.c
 
-$(obj)/53c700.o $(MODVERDIR)/$(obj)/53c700.ver: $(obj)/53c700_d.h
+$(obj)/53c700.o: $(obj)/53c700_d.h
 
 $(obj)/scsi_sysfs.o: $(obj)/scsi_devinfo_tbl.c
 
-- 
2.17.1

