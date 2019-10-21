Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40059DE8FC
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJUKFr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 06:05:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbfJUKFr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 06:05:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05EA3B17C;
        Mon, 21 Oct 2019 10:05:45 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        James Smart <James.Smart@emulex.com>,
        Alex Iannicelli <alex.iannicelli@emulex.com>
Subject: [PATCH] scsi: lpfc: Honor module parameter lpfc_use_adisc
Date:   Mon, 21 Oct 2019 12:05:42 +0200
Message-Id: <20191021100542.24136-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The initial lpfc_desc_set_adisc implementation dea3101e0a5c ("lpfc:
add Emulex FC driver version 8.0.28") enabled ADISC if

	cfg_use_adisc && RSCN_MODE && FCP_2_DEVICE

In commit 92d7f7b0cde3 ("[SCSI] lpfc: NPIV: add NPIV support on top of
SLI-3") this changed to

	(cfg_use_adisc && RSC_MODE) || FCP_2_DEVICE

and later in ffc954936b13 ("[SCSI] lpfc 8.3.13: FC Discovery Fixes and
enhancements.") to

	(cfg_use_adisc && RSC_MODE) || (FCP_2_DEVICe && FCP_TARGET)

A customer reports that after a Devlos, an ADISC failure is logged. It
turns out the ADISC flag is set even the user explicitly set
lpfc_use_adisc = 0.

[Sat Dec 22 22:55:58 2018] lpfc 0000:82:00.0: 2:(0):0203 Devloss timeout on WWPN 50:01:43:80:12:8e:40:20 NPort x05df00 Data: x82000000 x8 xa
[Sat Dec 22 23:08:20 2018] lpfc 0000:82:00.0: 2:(0):2755 ADISC failure DID:05DF00 Status:x9/x70000

Fixes: 92d7f7b0cde3 ("[SCSI] lpfc: NPIV: add NPIV support on top of SLI-3")
Cc: James Smart <James.Smart@emulex.com>
Cc: Alex Iannicelli <alex.iannicelli@emulex.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

Unfortunatly, I don't really know all the procotols involved. So this
is just a rough guess what is wrong. 

Thanks,
Daniel

 drivers/scsi/lpfc/lpfc_nportdisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index cc6b1b0bae83..d27ae84326df 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -940,9 +940,9 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 	if (!(vport->fc_flag & FC_PT2PT)) {
 		/* Check config parameter use-adisc or FCP-2 */
-		if ((vport->cfg_use_adisc && (vport->fc_flag & FC_RSCN_MODE)) ||
+		if (vport->cfg_use_adisc && ((vport->fc_flag & FC_RSCN_MODE) ||
 		    ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) &&
-		     (ndlp->nlp_type & NLP_FCP_TARGET))) {
+		     (ndlp->nlp_type & NLP_FCP_TARGET)))) {
 			spin_lock_irq(shost->host_lock);
 			ndlp->nlp_flag |= NLP_NPR_ADISC;
 			spin_unlock_irq(shost->host_lock);
-- 
2.16.4

