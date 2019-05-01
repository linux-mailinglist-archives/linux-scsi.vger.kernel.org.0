Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7B10C85
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEAR7m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 13:59:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAR7m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 13:59:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so4343472pfa.3
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EOuQ1mXywclD5Eh4Bp/C7St3epMNvpJyEDSAzL8Wf9c=;
        b=O/n5lLSGAi6BaYOeIqgEgi6Y2N3kqXOFZG+mNA1t+XIG0yri6AGsJzg9xr6CGMuD7H
         ko/aptCXfwCbaSA5RMa0xMhj2fAT9yQYtX3864USDCLbpTudrcG9jLW9kffCaRJ6ab7B
         S3DrBddox4rxyEl3JOOWF5HMAUUxgxdooluBx/r5xmvmCzHXF01Jtf67v8eh1w6QDre1
         oPtggmi7hIHA+4G49ci+mpEa5C6Bmogf2RVuZMBThFhEJTVnqajPyTIJRIGbwzA+WSjF
         GMQ+UTpGjfkwnXKpXOp2A4gVjiguch3jnVEczwVQbgU9oJZPs8HTP+pVO9PCSSQomHsC
         3xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EOuQ1mXywclD5Eh4Bp/C7St3epMNvpJyEDSAzL8Wf9c=;
        b=SaMq7KWjnstLseUuh3TQNF27HafXku4lnsSzQgxVclPCR/gUVfS+BlXR+UrCEQeTLP
         coprjVR6V90wGvSrVQo3UxknUJfaTtQLip1eXZfQgTYpcRl1kMbUgpaIloQ0x+JTYi/f
         nSSx5pwMPhR7OF6iJvcIkMOEPKllUhBzRB3J78lnJO3sZ0aL3iZ7waLkOgQqEwMroAj4
         uIRvULH7bwfZWlGOwm5t8gTABz56hNpM1PvxcMGt5UozWg7iHt0f5omHuDW2Qpan0Bpx
         OOy9Qb6gw3s7z1M5UalYmuwi6NBd3eGCKc+ARDoLzRt5OwCtwGNoP/1gamL9BCaIIU7C
         kycw==
X-Gm-Message-State: APjAAAVQngi3qvsUCCW7oVkmEydg1c1+PFSFfMG/+ws6XI+BBWEw51Tl
        4I33H/2D1K0M1vOyTLL1OGCDRtGC
X-Google-Smtp-Source: APXvYqzu5zJTGrUHF3vtqnSjoyUOkja55JIgtJbag83ak7X0//ydyIGhIrewTOwAf/BqOs77+z7cgQ==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr77003857pga.37.1556733581503;
        Wed, 01 May 2019 10:59:41 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm72906679pgh.81.2019.05.01.10.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:59:41 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 3/4] lpfc: add check for loss of ndlp when sending RRQ
Date:   Wed,  1 May 2019 10:59:25 -0700
Message-Id: <20190501175926.4551-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190501175926.4551-1-jsmart2021@gmail.com>
References: <20190501175926.4551-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There was a missing qualification of a valid ndlp structure
when calling to send an RRQ for an abort.  Add the check.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c8fb0b455f2a..5ac4f8d76b91 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7334,7 +7334,10 @@ int
 lpfc_send_rrq(struct lpfc_hba *phba, struct lpfc_node_rrq *rrq)
 {
 	struct lpfc_nodelist *ndlp = lpfc_findnode_did(rrq->vport,
-							rrq->nlp_DID);
+						       rrq->nlp_DID);
+	if (!ndlp)
+		return 1;
+
 	if (lpfc_test_rrq_active(phba, ndlp, rrq->xritag))
 		return lpfc_issue_els_rrq(rrq->vport, ndlp,
 					 rrq->nlp_DID, rrq);
-- 
2.13.7

