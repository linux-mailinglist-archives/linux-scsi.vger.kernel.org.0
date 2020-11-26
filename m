Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3362C5553
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbgKZNad (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Nov 2020 08:30:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389955AbgKZNad (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Nov 2020 08:30:33 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606397430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCHH+WU06bIildt8jR1f7yAZJ5+Z7ksfyeAxtSEkZIU=;
        b=ymCbyc72lNOJoMf8MAh/+bYJSFOWyhWk4LQDgL0Bf4p0cxZgu/X9P//oLgEvmaE9j1NlAO
        iDejMtK/wOQNxEEdQVcEDjwg9Opugw3bs4Rrne8gmv10tN0DpyeWSwWVdq4op2K2fcNVka
        QsW1YvX5dO6+SohMqlr6BjtyM6r5yPuk7BlHKXcsJSCs2cntkBf2H2/ItzqpUU/EErnkhg
        PdhL5Lvy4HR6OL2FwXyJI7HLIBzpJryCLuEsT5QDYuhftPDnF/X2xAtQllWAAjhHKbIyPq
        xPmCUu1nEb6wEaSkQHedS9O3lCBhOnc24+BTWipWFrBghUAAi8CuD5IoOT1hUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606397430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCHH+WU06bIildt8jR1f7yAZJ5+Z7ksfyeAxtSEkZIU=;
        b=56vEOwTkXDyd7Tk8GeC8Gtc6EyM5DiXVrmPEXaoyCiQugDjuuWpIl8J7nmvRle7ku7VUGm
        VkfdlHk6tRQVJCAg==
To:     linux-scsi@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        John Garry <john.garry@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        Manish Rangankar <mrangankar@marvell.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        Nilesh Javali <njavali@marvell.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Vikram Auradkar <auradkar@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/14] scsi: hisi_sas: Remove preemptible().
Date:   Thu, 26 Nov 2020 14:29:40 +0100
Message-Id: <20201126132952.2287996-3-bigeasy@linutronix.de>
In-Reply-To: <20201126132952.2287996-1-bigeasy@linutronix.de>
References: <20201126132952.2287996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

hisi_sas_task_exec() uses preemptible() to see if it's safe to block.
This does not work for CONFIG_PREEMPT_COUNT=3Dn kernels in which
preemptible() always returns 0.

The problem is masked when enabling some of the common Kconfig.debug
options (like CONFIG_DEBUG_ATOMIC_SLEEP), as they implicitly enable the
preemption counter.

In general, driver leaf functions should not make logic decisions based
on the context they're called from. The caller should be the entity
responsible for explicitly indicating context.

Since hisi_sas_task_exec() already has a gfp_t flags parameter, use it
as the explicit context marker.

Fixes: 214e702d4b70 ("scsi: hisi_sas: Adjust task reject period during host=
 reset")
Fixes: 550c0d89d52d ("scsi: hisi_sas: Replace in_softirq() check in hisi_sa=
s_task_exec()")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: Xiang Chen <chenxiang66@hisilicon.com>
Cc: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/=
hisi_sas_main.c
index c8dd8588f800e..06e65c461f027 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -585,13 +585,7 @@ static int hisi_sas_task_exec(struct sas_task *task, g=
fp_t gfp_flags,
 	dev =3D hisi_hba->dev;
=20
 	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags))) {
-		/*
-		 * For IOs from upper layer, it may already disable preempt
-		 * in the IO path, if disable preempt again in down(),
-		 * function schedule() will report schedule_bug(), so check
-		 * preemptible() before goto down().
-		 */
-		if (!preemptible())
+		if (!gfpflags_allow_blocking(gfp_flags))
 			return -EINVAL;
=20
 		down(&hisi_hba->sem);
--=20
2.29.2

