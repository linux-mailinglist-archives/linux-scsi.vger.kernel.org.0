Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C517F782FB
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 03:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfG2BKJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 21:10:09 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.80]:42135 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfG2BKI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 28 Jul 2019 21:10:08 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 21:10:07 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E4FE53261
        for <linux-scsi@vger.kernel.org>; Sun, 28 Jul 2019 19:21:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rtPlhyfoTYTGMrtPlhmqiU; Sun, 28 Jul 2019 19:21:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bXUaQIkFn1ob05i5yZWQ0l4u9V6eV7CvkbWu9DwnfqI=; b=rwSfYfiW+osq5OkX4mocxl/AD0
        vQzbVj8FKtz1OYh0qlGDStVaDZUxvA+Q4gxBuaikMfAgQ9aTm/gkUb0sKs3k0BpV3zgEzydXb/QOP
        UX82WdlhOzdX2IUH7zxbcH1gRmzZ+Co1w9z7+ZoE6ZYY4Au7+/SltPAVSDD6jI2U74dyKEiysz3Fm
        4qrGxDUkgK2e1Y4ecK/5iOL/EsS1jp6lqC2c8DlOFcDSK0LZTJoB58CuThfu26EsqMRF0FxSm48wO
        nri3Tigg4Qd9p67ZefyehkLvQG3rJF/LaNVn2ENb89JraJ/qoMmK5uCUymeB3He0qZgOXMB/h7Y6g
        EtdgOwqQ==;
Received: from [187.192.11.120] (port=40036 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrtPj-003wOb-QG; Sun, 28 Jul 2019 19:21:19 -0500
Date:   Sun, 28 Jul 2019 19:21:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: cxlflash: Mark expected switch fall-throughs
Message-ID: <20190729002119.GA25068@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrtPj-003wOb-QG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:40036
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 34
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/scsi/cxlflash/main.c: In function 'send_afu_cmd':
drivers/scsi/cxlflash/main.c:2347:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (rc) {
      ^
drivers/scsi/cxlflash/main.c:2357:2: note: here
  case -EAGAIN:
  ^~~~
drivers/scsi/cxlflash/main.c: In function 'term_intr':
drivers/scsi/cxlflash/main.c:754:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (index == PRIMARY_HWQ)
      ^
drivers/scsi/cxlflash/main.c:756:2: note: here
  case UNMAP_TWO:
  ^~~~
drivers/scsi/cxlflash/main.c:757:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:758:2: note: here
  case UNMAP_ONE:
  ^~~~
drivers/scsi/cxlflash/main.c:759:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:760:2: note: here
  case FREE_IRQ:
  ^~~~
drivers/scsi/cxlflash/main.c: In function 'cxlflash_remove':
drivers/scsi/cxlflash/main.c:975:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cxlflash_release_chrdev(cfg);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:976:2: note: here
  case INIT_STATE_SCSI:
  ^~~~
drivers/scsi/cxlflash/main.c:978:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   scsi_remove_host(cfg->host);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:979:2: note: here
  case INIT_STATE_AFU:
  ^~~~
drivers/scsi/cxlflash/main.c:980:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   term_afu(cfg);
   ^~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:981:2: note: here
  case INIT_STATE_PCI:
  ^~~~
drivers/scsi/cxlflash/main.c:983:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   pci_disable_device(pdev);
   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:984:2: note: here
  case INIT_STATE_NONE:
  ^~~~
drivers/scsi/cxlflash/main.c: In function 'num_hwqs_store':
drivers/scsi/cxlflash/main.c:3018:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (cfg->state == STATE_NORMAL)
      ^
drivers/scsi/cxlflash/main.c:3020:2: note: here
  default:
  ^~~~~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/cxlflash/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index b1f4724efde2..93ef97af22df 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -753,10 +753,13 @@ static void term_intr(struct cxlflash_cfg *cfg, enum undo_level level,
 		/* SISL_MSI_ASYNC_ERROR is setup only for the primary HWQ */
 		if (index == PRIMARY_HWQ)
 			cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 3, hwq);
+		/* fall through */
 	case UNMAP_TWO:
 		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
+		/* fall through */
 	case UNMAP_ONE:
 		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
+		/* fall through */
 	case FREE_IRQ:
 		cfg->ops->free_afu_irqs(hwq->ctx_cookie);
 		/* fall through */
@@ -973,14 +976,18 @@ static void cxlflash_remove(struct pci_dev *pdev)
 	switch (cfg->init_state) {
 	case INIT_STATE_CDEV:
 		cxlflash_release_chrdev(cfg);
+		/* fall through */
 	case INIT_STATE_SCSI:
 		cxlflash_term_local_luns(cfg);
 		scsi_remove_host(cfg->host);
+		/* fall through */
 	case INIT_STATE_AFU:
 		term_afu(cfg);
+		/* fall through */
 	case INIT_STATE_PCI:
 		cfg->ops->destroy_afu(cfg->afu_cookie);
 		pci_disable_device(pdev);
+		/* fall through */
 	case INIT_STATE_NONE:
 		free_mem(cfg);
 		scsi_host_put(cfg->host);
@@ -2353,11 +2360,11 @@ static int send_afu_cmd(struct afu *afu, struct sisl_ioarcb *rcb)
 			cxlflash_schedule_async_reset(cfg);
 			break;
 		}
-		/* fall through to retry */
+		/* fall through - to retry */
 	case -EAGAIN:
 		if (++nretry < 2)
 			goto retry;
-		/* fall through to exit */
+		/* fall through - to exit */
 	default:
 		break;
 	}
@@ -3017,6 +3024,7 @@ static ssize_t num_hwqs_store(struct device *dev,
 		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET);
 		if (cfg->state == STATE_NORMAL)
 			goto retry;
+		/* else, fall through */
 	default:
 		/* Ideally should not happen */
 		dev_err(dev, "%s: Device is not ready, state=%d\n",
-- 
2.22.0

