Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B346E371C09
	for <lists+linux-scsi@lfdr.de>; Mon,  3 May 2021 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhECQvF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 May 2021 12:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233346AbhECQrr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 May 2021 12:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC19B613F5;
        Mon,  3 May 2021 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620059991;
        bh=t9f/7bHCVTgR+AuzpestGI9KgiTNtjS/ARaBFz0PumU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCoddLkcw4FPmRb1o7DWP6Nb7wYoSV6yNEVz6mInNjt+Us8fKb2obhHUbl0yPfcA3
         GW8MpoZMWNvl3cOEiPLVXkNTCXRvakkkztF6WboTVAdt39NpvC38ozJ/9viDJTxZPh
         RS3ssSwAov6DQyn7Bl1UjRrnWbBr5V79235wxdf02aKO+PY6aAbBSwFjLChZWvpoVO
         cgfx+3NU1pCJn2M/86nmtPhB+Dvvxk6PU9YlzPpLsbJejjHIXuzeHptPUU1Hpgid7w
         Eq+zd/3uXk9CAd+PvZiLJu7xSmXAVBXd8PqQyHXwXRBr8fxEWT8oGexMjQKb/4bd0O
         3HkBAl6kw/yjA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/57] scsi: lpfc: Fix pt2pt connection does not recover after LOGO
Date:   Mon,  3 May 2021 12:38:50 -0400
Message-Id: <20210503163941.2853291-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163941.2853291-1-sashal@kernel.org>
References: <20210503163941.2853291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit bd4f5100424d17d4e560d6653902ef8e49b2fc1f ]

On a pt2pt setup, between 2 initiators, if one side issues a a LOGO, there
is no relogin attempt. The FC specs are grey in this area on which port
(higher wwn or not) is to re-login.

As there is no spec guidance, unconditionally re-PLOGI after the logout to
ensure a login is re-established.

Link: https://lore.kernel.org/r/20210301171821.3427-8-jsmart2021@gmail.com
Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 418d62e94554..ea31711b1aeb 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -888,9 +888,14 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		}
 	} else if ((!(ndlp->nlp_type & NLP_FABRIC) &&
 		((ndlp->nlp_type & NLP_FCP_TARGET) ||
-		!(ndlp->nlp_type & NLP_FCP_INITIATOR))) ||
+		(ndlp->nlp_type & NLP_NVME_TARGET) ||
+		(vport->fc_flag & FC_PT2PT))) ||
 		(ndlp->nlp_state == NLP_STE_ADISC_ISSUE)) {
-		/* Only try to re-login if this is NOT a Fabric Node */
+		/* Only try to re-login if this is NOT a Fabric Node
+		 * AND the remote NPORT is a FCP/NVME Target or we
+		 * are in pt2pt mode. NLP_STE_ADISC_ISSUE is a special
+		 * case for LOGO as a response to ADISC behavior.
+		 */
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000 * 1));
 		spin_lock_irq(shost->host_lock);
-- 
2.30.2

