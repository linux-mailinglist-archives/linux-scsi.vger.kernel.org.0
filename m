Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBA156EE
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEGA1n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34322 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGA1m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so7212312plb.1
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EOuQ1mXywclD5Eh4Bp/C7St3epMNvpJyEDSAzL8Wf9c=;
        b=diEQOkAbQ2eEx+MntswHY0brDotCmU5qWBPpsnSByzLIswUGaJZp4Zwf97ueGTF7Oh
         eZr6uhgZyA+Ua8XANChyjn3b5z7ph8cLLGiSFuLTAKJPmP8AhsK0pbhSxa6ILUP1pnei
         YoyuT2ebB71noUBl+KmSoiZJcVtRxLPxz85G86V4scH4nMzIXa5TMfM6yEseodOEkHsg
         N0clNeI5ncsKnc4QZLQZtOobkPtzdQosoolU8N2m0hkml0nqU6ly/iv2Y4+MaPD0wl2G
         jqNsXdNH1twbjEsYTBpFhm7FZuUoDB1yVr4u/1yybhHA/rqT+b7+8p9R3Vpm/Ij7GJPR
         mK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EOuQ1mXywclD5Eh4Bp/C7St3epMNvpJyEDSAzL8Wf9c=;
        b=SizDJnjFiz80JZodw3hjIITqIWk/ZS+Sai56BTox9Q63OkofPfhup8LK3c+rJKKhW+
         ToTYDpf+gDNtRRzQihVYkbBFcLtCwN+Io3Y6bO0b7nsCOxKamJk1ikA7tPwNXOr2no2u
         WRqmyiUemfniTk+/DQeNUf0IbVU5816Adb6kBX5nipKpyTkn6Fj8eRi2HD4vIJJ2p6ER
         XgbALxjIa0WMl0D/Zja7ghjJ/qVfC0VUAXWhS/4roInVgFqypkUlnojgfEG+AVvqaCD9
         etdD/VrphNHf2J1c015mrjzABtTMfHVXFNs++oPDUPz8G0Zy/DqVsxMA3A76zMoL2+kz
         nt5g==
X-Gm-Message-State: APjAAAVGpupabRnOS9D9VFdxdTt69GhGLWWwhccO8lXb8o83dmk3XY52
        Nl1vJzQDLcw2P4PCL8dyPLX5XG3d
X-Google-Smtp-Source: APXvYqxzZc73khP2FVp2iCAr//p2iuqIkDlHCqynlEQq+qxjj6mHd7+IBsDbfQAmB4TFUsVTI4grSQ==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr29610658pla.158.1557188862108;
        Mon, 06 May 2019 17:27:42 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm14756623pfn.11.2019.05.06.17.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 17:27:41 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH v2 3/4] lpfc: add check for loss of ndlp when sending RRQ
Date:   Mon,  6 May 2019 17:26:49 -0700
Message-Id: <20190507002650.23210-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com>
References: <20190507002650.23210-1-jsmart2021@gmail.com>
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

