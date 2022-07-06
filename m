Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEABD569627
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jul 2022 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiGFXgh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGFXga (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 19:36:30 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642612CDC0;
        Wed,  6 Jul 2022 16:36:29 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 44E7940CB0;
        Wed,  6 Jul 2022 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150589; bh=4SmiljU/B5qo4IXZ7glKCXdA5yUHCmpz6d2nsJHU6pE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=iRm3cadgMmDHf2tqQ2n6cpnAxxxwP3rO3oMj+wLvAENpMZLFuHgo1KczfrHEmHg5r
         aK/ytIIJvXp37k+9isNN3l8mj/3+ysr549FMSgsxH2vZiJYdidiOxcGai/mVLGCBg6
         Vh00sGh7KWnhmj6AA9Vh4UPamxUoK+uB4SEaiWjowstPKOizFGP0SWUnWQNEljkWSM
         nr1Qdt2CyYO0NPgR6nrRJq8A5MIQaDb3CShJgdgmwl7NKV8TN49V+9VSfugJicYQyY
         B5mwNumPLQzi6/uzNQSp/c5vHgJTGM5RFRJPQMkHG7yggTdY/DWczhfF0inmwWWfGz
         64NhStKNmHsrQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 271D4A0096;
        Wed,  6 Jul 2022 23:36:28 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:36:28 -0700
Date:   Wed, 06 Jul 2022 16:36:28 -0700
Message-Id: <d344403eb32d950eafacf616ccc19ce742a6b3b6.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 20/36] usb: gadget: f_tcm: Limit number of sessions
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Only allocate up to USBG_NUM_CMDS number of sessions.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index bcbe35bb5015..df768559fb60 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -26,7 +26,7 @@ enum {
 #define USB_G_ALT_INT_BBB       0
 #define USB_G_ALT_INT_UAS       1
 
-#define USB_G_DEFAULT_SESSION_TAGS	128
+#define USB_G_DEFAULT_SESSION_TAGS	USBG_NUM_CMDS
 
 struct tcm_usbg_nexus {
 	struct se_session *tvn_se_sess;
-- 
2.28.0

