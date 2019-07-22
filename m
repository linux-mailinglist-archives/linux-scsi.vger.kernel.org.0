Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD86FF66
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfGVMUH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 08:20:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVMUH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 08:20:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlNcr-1iGa743GlZ-00lmi6; Mon, 22 Jul 2019 14:19:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Ondrej Zary <linux@zary.sk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH A] scsi: fdomain: fix building pcmcia front-end
Date:   Mon, 22 Jul 2019 14:19:07 +0200
Message-Id: <20190722121908.163702-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pih0PRpMLRnsyASveFq762x1B4Pp+tSzefsjFfToNrgjwgXAKNi
 7J0JAsSN/wpygNqUds8RLf3J+YqfnxxCnl1wMsfTlLrfRLmAV6wvw+NeGeUCbLZENTK3pAd
 TBMvWkkbRwlzRLiS+ORAcaSv9ArJ651p573+xUU9SuTj99o8twBENNliTH5HEh4yiiiQtKc
 1eezaSqRPeY8mmyaR0pmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xIV9qNDtFMI=:1LirOuy2Qf9M+mfI/A3dZP
 XxEdzME0d0KlIvg9ZtyJ8zUq/QJcQtmow7JzOhKV9yYtjmrICNZY6smc/SxbIaUigHX2d0Wm5
 iFzTxhgOdNA/OxLY1/XQJkAkubUvve/rOWb7/k7FaMZxp8kofBuAeXrgNxwst6TPz25qfxyaS
 1D2OxsigN/pvmyiweZClMpNdlFwX4cAUhBJzHK+MwXDXk241sBzevlnvukBiB2lB9S/ADNBzf
 Ox6F5ULnJ2aQFDwfFdRwdidhJsHT2MZ5lbJe8AVsBSa5blYwxHEc6w2szrWDFSJqukx0ZD6P0
 L/xHvCxCHSZ1ulRBSOHyNjoG4qTK5NGSaCnVKjEXuGiYTEhStEuk1Wf/ZBSgb8/0/StJjchi7
 ysVUgrCpS0+lqwtsCtow2t6pBhaf/qypseF3wL2VceHpATnXTmjJtxYdoQP+kCbfmhFoiFuNl
 EqQZhp+/PjMt2hjCfgDB9w3gloJzCjs52nciNS7PrsVl/ARYiyb3LDEOZe8vfmz2NiRlQJ85E
 FDsgNJmulYfUqp6iGpdLuXC751Jj4eksA9PbRoQKwN9y8FsxkHFcR7uJYjMPQst6YGx07gjEq
 yjOxwSZS5kPg8a0+wbkLFymYFh774R/NpJlwHJpISDC4NWwOZDeLUpG595Tq2JJPpRmMXUYYe
 26HH8uc16iTbHs1MqC58eBQn08Dpu+eKkOPMuoO5KLLzj2FIkK01sWGrsx98/CE1IsGBzV9l2
 pGzo7FqmeE8ojcDpYYCTY3br3mlOSEYD6fcD1Q==
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We get a warning when CONFIG_SCSI_LOWLEVEL is disabled here:

WARNING: unmet direct dependencies detected for SCSI_FDOMAIN
  Depends on [n]: SCSI_LOWLEVEL [=n] && SCSI [=y]
  Selected by [m]:
  - PCMCIA_FDOMAIN [=m] && SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=y] && m && MODULES [=y]

Move the common support outside of the SCSI_LOWLEVEL section.
Alternatively, we could move all of SCSI_LOWLEVEL_PCMCIA into
SCSI_LOWLEVEL. This would be more sensible, but might cause
surprises for users that have SCSI_LOWLEVEL disabled.

Fixes: 7d47fa065e62 ("scsi: fdomain: Add PCMCIA support")
Link: https://lore.kernel.org/lkml/20190617111937.2355936-1-arnd@arndb.de/t
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
One of two ways to fix the problem, please pick either

There was some confusion about this the first time I posted
it. As Ondrej pointed out, there is no user visible top-level
option here, just a hidden symbol.

 drivers/scsi/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 75f66f8ad3ea..dffe4b31e205 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -642,10 +642,6 @@ config SCSI_DMX3191D
 	  To compile this driver as a module, choose M here: the
 	  module will be called dmx3191d.
 
-config SCSI_FDOMAIN
-	tristate
-	depends on SCSI
-
 config SCSI_FDOMAIN_PCI
 	tristate "Future Domain TMC-3260/AHA-2920A PCI SCSI support"
 	depends on PCI && SCSI
@@ -1527,6 +1523,10 @@ endif # SCSI_LOWLEVEL
 
 source "drivers/scsi/pcmcia/Kconfig"
 
+config SCSI_FDOMAIN
+	tristate
+	depends on SCSI
+
 source "drivers/scsi/device_handler/Kconfig"
 
 endmenu
-- 
2.20.0

