Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B561AF00E
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgDROrZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 10:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgDROoK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DEA21D82;
        Sat, 18 Apr 2020 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221049;
        bh=VRbuhqsaG714iS2RnLYCQRuT3hk409iW9Hd2N+ezko4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGnjdxY95HeK/GPgdOvrmkDWZNnAAPaJF4RqFwoXJtW24Nsppn0wOEfIU1n/XUp8e
         hW9qa5XLEekpE3871vsMG9y/G+Og8XbWCyVdE4Y7g0S85jHAzTj9kZWjxUhAl9N56a
         3FAMT64scNd7rehKC9dlFiqFHM6BixhfriCDNsJM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 03/23] scsi: lpfc: Fix kasan slab-out-of-bounds error in lpfc_unreg_login
Date:   Sat, 18 Apr 2020 10:43:45 -0400
Message-Id: <20200418144405.10565-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144405.10565-1-sashal@kernel.org>
References: <20200418144405.10565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 38503943c89f0bafd9e3742f63f872301d44cbea ]

The following kasan bug was called out:

 BUG: KASAN: slab-out-of-bounds in lpfc_unreg_login+0x7c/0xc0 [lpfc]
 Read of size 2 at addr ffff889fc7c50a22 by task lpfc_worker_3/6676
 ...
 Call Trace:
 dump_stack+0x96/0xe0
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 print_address_description.constprop.6+0x1b/0x220
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 __kasan_report.cold.9+0x37/0x7c
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 kasan_report+0xe/0x20
 lpfc_unreg_login+0x7c/0xc0 [lpfc]
 lpfc_sli_def_mbox_cmpl+0x334/0x430 [lpfc]
 ...

When processing the completion of a "Reg Rpi" login mailbox command in
lpfc_sli_def_mbox_cmpl, a call may be made to lpfc_unreg_login. The vpi is
extracted from the completing mailbox context and passed as an input for
the next. However, the vpi stored in the mailbox command context is an
absolute vpi, which for SLI4 represents both base + offset.  When used with
a non-zero base component, (function id > 0) this results in an
out-of-range access beyond the allocated phba->vpi_ids array.

Fix by subtracting the function's base value to get an accurate vpi number.

Link: https://lore.kernel.org/r/20200322181304.37655-2-jsmart2021@gmail.com
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index cbe808e83f477..1c34dc3355498 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2210,6 +2210,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	    !pmb->u.mb.mbxStatus) {
 		rpi = pmb->u.mb.un.varWords[0];
 		vpi = pmb->u.mb.un.varRegLogin.vpi;
+		if (phba->sli_rev == LPFC_SLI_REV4)
+			vpi -= phba->sli4_hba.max_cfg_param.vpi_base;
 		lpfc_unreg_login(phba, vpi, rpi, pmb);
 		pmb->vport = vport;
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-- 
2.20.1

