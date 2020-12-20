Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636462DF6CB
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Dec 2020 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLTUhd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Dec 2020 15:37:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgLTUhd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Dec 2020 15:37:33 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608496611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1Tq+vKn3zogodZ1Ha32Khnj/Q3NSikwulOM53VWqvg=;
        b=tnT36zHODpXbUp7I0N6RB/2slS2ZrZT6x5CyR80cfmMe8MHoi01mB2b30diKxhHLQNM0gv
        DVuvxr2opShIjztF9LZBmxa1dIM0ikUJyEvmKg9BpMJkVZsYd8axLWFfvJtxaIbzGkrwcu
        lRlyiAHqmZMdnVmfvyJnrFkdLkRnY3kXQYYF5IwcehZ9cydvgUgrTQ+LDffrWfJ0lJoB26
        n/JCCLVooGVO7bFBTv+zJwRUgboCTawPEximTNgwSyrBU8U6rCygz6H2aomaYg2F2qFD+N
        jaG8SSbtuE+Vs1sqQIQ3e5MxQtJGs8oP0c2v5G793bG6yyz33WZQXUCULRNIQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608496611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1Tq+vKn3zogodZ1Ha32Khnj/Q3NSikwulOM53VWqvg=;
        b=h+U104yUsgEM7FtwOzOfkqAmIxLV7l5j1c1rVBucZlc1Z30BgzTqi4d7Qwg7IJ/Vbyg2mx
        pQ+xruDydjIk+IAA==
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/6] scsi: target: Remove in_interrupt() usage in core_alua_check_nonop_delay()
Date:   Sun, 20 Dec 2020 21:36:36 +0100
Message-Id: <20201220203638.43615-5-bigeasy@linutronix.de>
In-Reply-To: <20201220203638.43615-1-bigeasy@linutronix.de>
References: <20201220203638.43615-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

core_alua_check_nonop_delay() uses in_interrupt() to decide if it is
safe to sleep.

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

core_alua_check_nonop_delay() has two callers:
- target_submit_cmd_map_sgls()
  Kernel doc says it that it must be called from process context. Also
  has a BUG_ON(in_interrupt()).

- iscsit_setup_scsi_cmd()
  Invokes iscsit_add_reject_cmd() which does GFP_KERNEL allocation and
  target_cmd_init_cdb() which may do GFP_KERNEL allocations.

Remove the in_interrupt() check because all callers are from preemptible
context.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/target/target_core_alua.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core=
_alua.c
index 6b72afee2f8b7..5517c7dd51441 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -860,8 +860,6 @@ int core_alua_check_nonop_delay(
 {
 	if (!(cmd->se_cmd_flags & SCF_ALUA_NON_OPTIMIZED))
 		return 0;
-	if (in_interrupt())
-		return 0;
 	/*
 	 * The ALUA Active/NonOptimized access state delay can be disabled
 	 * in via configfs with a value of zero
--=20
2.29.2

