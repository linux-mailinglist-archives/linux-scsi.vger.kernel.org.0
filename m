Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FD371B78
	for <lists+linux-scsi@lfdr.de>; Mon,  3 May 2021 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhECQp7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 May 2021 12:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhECQo3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 May 2021 12:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5558A613DF;
        Mon,  3 May 2021 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620059928;
        bh=lKWxNTOWjPG44IWEhdFXKE9eCDYo0NONZEZVahLVNNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBAUxZaV2cgiD6q3nu566B33FqYHL0wlRg69bedDJGIBc88RwafgzFP34mG5fQfXt
         e7czJiVQcXe3cMHTT0ZAiuzuYq0zkOn6Ffgj2ziiViinCnyRmQ192ZvRaQosAX37hi
         9rH7SqoiCPUdKQP66aKu4J9ChhVgVobgpbGaidPUUteSQmj1h+Qxc982QfoA/SUW2o
         WeIXLjbejPfcZbHtq1Q8MLJ6DNoeoZ1PjeBaAqswIr2DcXKKYXkZOofM8o+xlqMyp4
         VtytNWKRyz2ilqtH4pVdZY3klmYPKQhlIUxcF9LdsyurHHcsyL6Whtxe8pTnnV24cm
         KMvNfLEc/jcmQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 012/100] scsi: lpfc: Fix pt2pt connection does not recover after LOGO
Date:   Mon,  3 May 2021 12:37:01 -0400
Message-Id: <20210503163829.2852775-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163829.2852775-1-sashal@kernel.org>
References: <20210503163829.2852775-1-sashal@kernel.org>
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
index 92d6e7b98770..17be94496110 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -903,9 +903,14 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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

