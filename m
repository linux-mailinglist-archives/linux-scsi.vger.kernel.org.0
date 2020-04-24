Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20BF1B732D
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Apr 2020 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDXLhZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Apr 2020 07:37:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43916 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbgDXLhY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Apr 2020 07:37:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77B99C00E0;
        Fri, 24 Apr 2020 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587728243; bh=hFru8LZBc46qgU3/SBVkJocidWlFzfoaiEu/7j+x3SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hK8sgt3xWQn3prukyE5/jXSGyK1iZrqIYE/e37JJLV3/s0S7798AzSFJHr65Lh45u
         LGfal4VByg2s+4Sc4Cm24rG4A3j83qqlbMuZ4H5sQisH+kp/PqHpQcvyzYYPmL+fer
         FoLjP89/TWHG7wh6kd7FCpj5oo4tpV0sSlKHGP95PosLkbwpA+Byk6PZ8G5XWewtjh
         ujiWxXWqhCPNWffeCwf3AOAFB2A3W6qKkc9eSaNJK0FVW4F2+V3TIgb0W9pbTcZcRi
         I1w+iabg36zNfnZ5idEwX/LRGGGVwcrTna+bXRNfP/HZoPZZGk4gZNHrfwgu63EX9Q
         Ntin1YN9UQNcw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 32736A005C;
        Fri, 24 Apr 2020 11:37:21 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-scsi@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Lima <Joao.Lima@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] scsi: ufs: Allow UFS 3.0 as a valid version
Date:   Fri, 24 Apr 2020 13:36:56 +0200
Message-Id: <5c4281080538b74ca39cedb9112ffe71bf7a80b5.1587727756.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587727756.git.Jose.Abreu@synopsys.com>
References: <cover.1587727756.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1587727756.git.Jose.Abreu@synopsys.com>
References: <cover.1587727756.git.Jose.Abreu@synopsys.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a define for UFS version 3.0 and do not print an error message upon
probe when using this version.

Signed-off-by: Joao Lima <Joao.Lima@synopsys.com>
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Joao Lima <Joao.Lima@synopsys.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 drivers/scsi/ufs/ufshci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 7d1fa1349d40..2e5c200e915b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8441,7 +8441,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	if ((hba->ufs_version != UFSHCI_VERSION_10) &&
 	    (hba->ufs_version != UFSHCI_VERSION_11) &&
 	    (hba->ufs_version != UFSHCI_VERSION_20) &&
-	    (hba->ufs_version != UFSHCI_VERSION_21))
+	    (hba->ufs_version != UFSHCI_VERSION_21) &&
+	    (hba->ufs_version != UFSHCI_VERSION_30))
 		dev_err(hba->dev, "invalid UFS version 0x%x\n",
 			hba->ufs_version);
 
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index c2961d37cc1c..f2ee81669b00 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -104,6 +104,7 @@ enum {
 	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
 	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
+	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
 };
 
 /*
-- 
2.7.4

