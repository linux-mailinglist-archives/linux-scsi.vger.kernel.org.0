Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50511388FE
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfFGL1k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 07:27:40 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:58088 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfFGL1k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 07:27:40 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id MnTd2000S3XaVaC01nTdMf; Fri, 07 Jun 2019 13:27:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD21-0004F4-Jl; Fri, 07 Jun 2019 13:27:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD21-0003eb-Ib; Fri, 07 Jun 2019 13:27:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] [SCSI] aic7xxx: Spelling s/configuraion/configuration/
Date:   Fri,  7 Jun 2019 13:27:36 +0200
Message-Id: <20190607112736.14004-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/scsi/aic7xxx/aic7xxx.reg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx.reg b/drivers/scsi/aic7xxx/aic7xxx.reg
index ba0b411d03e2e1fa..00fde2243e486cbd 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.reg
+++ b/drivers/scsi/aic7xxx/aic7xxx.reg
@@ -1666,7 +1666,7 @@ scratch_ram {
 	size		6
 	/*
 	 * These are reserved registers in the card's scratch ram on the 2742.
-	 * The EISA configuraiton chip is mapped here.  On Rev E. of the
+	 * The EISA configuration chip is mapped here.  On Rev E. of the
 	 * aic7770, the sequencer can use this area for scratch, but the
 	 * host cannot directly access these registers.  On later chips, this
 	 * area can be read and written by both the host and the sequencer.
-- 
2.17.1

