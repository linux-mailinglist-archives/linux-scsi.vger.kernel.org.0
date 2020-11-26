Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EAE2C5552
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbgKZNac (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Nov 2020 08:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbgKZNab (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Nov 2020 08:30:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE74C0613D4
        for <linux-scsi@vger.kernel.org>; Thu, 26 Nov 2020 05:30:31 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606397429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAPMvJwZmNtmAWRutyXilXN5I9e5gBSqyvoXiwLJWcs=;
        b=jjM+rY5rOgFTB1sn+Rvl965x9DveZ0L3RQHvZWN/hutxhAiqhTcpBWhIY0u029oCCy94gz
        35JlETmKajxRr6k/Uxzs/Jb2AssdZYO8eHUCmspJiAHIOMnSrgNeqm2L+eN0MFEQXSyU+Y
        5GyP5f8SRf+kDiynJ/2U+vjRK8/P8AdZNHY8IGxoJqqDX5jq1dL7kJVbAwncQeftDWcJeo
        qdOIVnrtYPtdPjsInRhSvI+bxPHZxztl51MfNcK7SyrMxedN7QSd9hNbWT6J5F8YXld6RQ
        dsEnbtmbKyepPiweR3PyA2EpFyJnQwL++V8+XLs129nCUIuE4ql/ZaGmpNYQFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606397429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAPMvJwZmNtmAWRutyXilXN5I9e5gBSqyvoXiwLJWcs=;
        b=Sjm02VUmCAqhWj/5R+sVWw3XNIxGn5WuVdXPW6tEXmdDE7d5I/pbXiFJCx5XfSwXtqjUcx
        /FVhp1TSXrZ2WwAw==
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
Subject: [PATCH 01/14] scsi: pm80xx: Do not sleep in atomic context.
Date:   Thu, 26 Nov 2020 14:29:39 +0100
Message-Id: <20201126132952.2287996-2-bigeasy@linutronix.de>
In-Reply-To: <20201126132952.2287996-1-bigeasy@linutronix.de>
References: <20201126132952.2287996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

hw_event_sas_phy_up() is used in hardirq/softirq context:

 pm8001_interrupt_handler_msix() || pm8001_interrupt_handler_intx() || pm80=
01_tasklet
   =3D> PM8001_CHIP_DISP->isr() =3D pm80xx_chip_isr()
     =3D> process_oq() [spin_lock_irqsave(&pm8001_ha->lock,)]
       =3D> process_one_iomb()
         =3D> mpi_hw_event()
           =3D> hw_event_sas_phy_up()
             =3D> msleep(200)

Revert the msleep() back to an mdelay() to avoid sleeping in atomic
context.

Fixes: 4daf1ef3c681 ("scsi: pm80xx: Convert 'long' mdelay to msleep")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vikram Auradkar <auradkar@google.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_=
hwi.c
index 69f8244539e04..7d838e316657c 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3296,7 +3296,7 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha=
, void *piomb)
 	pm8001_get_attached_sas_addr(phy, phy->sas_phy.attached_sas_addr);
 	spin_unlock_irqrestore(&phy->sas_phy.frame_rcvd_lock, flags);
 	if (pm8001_ha->flags =3D=3D PM8001F_RUN_TIME)
-		msleep(200);/*delay a moment to wait disk to spinup*/
+		mdelay(200);/*delay a moment to wait disk to spinup*/
 	pm8001_bytes_dmaed(pm8001_ha, phy_id);
 }
=20
--=20
2.29.2

