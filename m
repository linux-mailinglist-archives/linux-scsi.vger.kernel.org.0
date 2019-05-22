Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7427009
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfEVTWr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 May 2019 15:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbfEVTWq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 May 2019 15:22:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CD9217D4;
        Wed, 22 May 2019 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552965;
        bh=+ox4NppzbtphFNUl2fXhn2ijzOe1B7toVQh07jdcXFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooClm0M3pp9nl4ENUINoHLQrML+aG9r42SL//HGwR+AbbwaNbvGhYaDps93yD8loH
         7aGsnbR4ob1roKR2RkmFSvt5OidLFWZ1+5Rn9pHg3cQY5ZsQqfaxLctR2ChwVKq/uc
         PaEmNvIvt0HgfoR6S/EDrcJpSHmu6oyjMPz91MsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 051/375] scsi: qla2xxx: Fix a qla24xx_enable_msix() error path
Date:   Wed, 22 May 2019 15:15:51 -0400
Message-Id: <20190522192115.22666-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 24afabdbd0b3553963a2bbf465895492b14d1107 ]

Make sure that the allocated interrupts are freed if allocating memory for
the msix_entries array fails.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 69bbea9239cc8..add17843148dd 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3475,7 +3475,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 		ql_log(ql_log_fatal, vha, 0x00c8,
 		    "Failed to allocate memory for ha->msix_entries.\n");
 		ret = -ENOMEM;
-		goto msix_out;
+		goto free_irqs;
 	}
 	ha->flags.msix_enabled = 1;
 
@@ -3558,6 +3558,10 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 
 msix_out:
 	return ret;
+
+free_irqs:
+	pci_free_irq_vectors(ha->pdev);
+	goto msix_out;
 }
 
 int
-- 
2.20.1

