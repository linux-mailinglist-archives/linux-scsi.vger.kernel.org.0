Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E63268E1C
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Sep 2020 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgINOoL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Sep 2020 10:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgINNF3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:05:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A0321D1B;
        Mon, 14 Sep 2020 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600088680;
        bh=2W8ILAH18vdDf9MUgMMH7AyhM9naODICx6xjOelBttA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zH20E2aKxOZgZVBFselzmNShFApNykXJvFqghVte+sJ1hw4au5mozAztLMNiULfBw
         oIQbtKdbGWEfV/Sy9/gQ/b0lpCVBzhZXuex5MBk2McTPsOrLFJxhAWv5byFJJvi2L4
         zcM8oiGQUoJmoR8msp1OrLAfaobPK7+QYI3QuFiU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/22] scsi: lpfc: Fix FLOGI/PLOGI receive race condition in pt2pt discovery
Date:   Mon, 14 Sep 2020 09:04:16 -0400
Message-Id: <20200914130434.1804478-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130434.1804478-1-sashal@kernel.org>
References: <20200914130434.1804478-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <james.smart@broadcom.com>

[ Upstream commit 7b08e89f98cee9907895fabb64cf437bc505ce9a ]

The driver is unable to successfully login with remote device. During pt2pt
login, the driver completes its FLOGI request with the remote device having
WWN precedence.  The remote device issues its own (delayed) FLOGI after
accepting the driver's and, upon transmitting the FLOGI, immediately
recognizes it has already processed the driver's FLOGI thus it transitions
to sending a PLOGI before waiting for an ACC to its FLOGI.

In the driver, the FLOGI is received and an ACC sent, followed by the PLOGI
being received and an ACC sent. The issue is that the PLOGI reception
occurs before the response from the adapter from the FLOGI ACC is
received. Processing of the PLOGI sets state flags to perform the REG_RPI
mailbox command and proceed with the rest of discovery on the port. The
same completion routine used by both FLOGI and PLOGI is generic in
nature. One of the things it does is clear flags, and those flags happen to
drive the rest of discovery.  So what happened was the PLOGI processing set
the flags, the FLOGI ACC completion cleared them, thus when the PLOGI ACC
completes it doesn't see the flags and stops.

Fix by modifying the generic completion routine to not clear the rest of
discovery flag (NLP_ACC_REGLOGIN) unless the completion is also associated
with performing a mailbox command as part of its handling.  For things such
as FLOGI ACC, there isn't a subsequent action to perform with the adapter,
thus there is no mailbox cmd ptr. PLOGI ACC though will perform REG_RPI
upon completion, thus there is a mailbox cmd ptr.

Link: https://lore.kernel.org/r/20200828175332.130300-3-james.smart@broadcom.com
Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 94d8f28341009..4e994a693e3f5 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4442,7 +4442,9 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 out:
 	if (ndlp && NLP_CHK_NODE_ACT(ndlp) && shost) {
 		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag &= ~(NLP_ACC_REGLOGIN | NLP_RM_DFLT_RPI);
+		if (mbox)
+			ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
+		ndlp->nlp_flag &= ~NLP_RM_DFLT_RPI;
 		spin_unlock_irq(shost->host_lock);
 
 		/* If the node is not being used by another discovery thread,
-- 
2.25.1

