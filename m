Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70E3C3163
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Jul 2021 04:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhGJClQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 22:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235603AbhGJCji (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 9 Jul 2021 22:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B29BC61404;
        Sat, 10 Jul 2021 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884522;
        bh=rHxthK1+Cw4VJf1piyGcFFv6xnz2BwQWElOink4w288=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3wnIX9Z5N6fNzoVDbKso61oBU24XRM7AdVR5Yv6zZiNsnVr/Syql4FcbNTrcgErK
         nmIsdhiyUYpzb5GmqqHkibOLro6zbtB+zaQG/52T8oJ480Gm5OvDgD6EVUX9en9Wkh
         S+uVrR7PjDmrsAEBchy7BBYDubiVyyfG5odOHoAilRk+/FUrc6prSocUBlToKOPWPf
         zcZuBlvxs18PJTvmv3lOMHRpbKPeml+V9l0TrMMTC/1ku5AUTV+0UjYQTq2BPeJVY/
         QURkZ2TboWRcs50OjTa1+HonRxv+5rPYZm6pTqdkL8rwbZCx2I8S3as/eohWl5Ei10
         9vCe+T5Fm2zWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/33] scsi: hisi_sas: Propagate errors in interrupt_init_v1_hw()
Date:   Fri,  9 Jul 2021 22:34:47 -0400
Message-Id: <20210710023516.3172075-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710023516.3172075-1-sashal@kernel.org>
References: <20210710023516.3172075-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit ab17122e758ef68fb21033e25c041144067975f5 ]

After commit 6c11dc060427 ("scsi: hisi_sas: Fix IRQ checks") we have the
error codes returned by platform_get_irq() ready for the propagation
upsream in interrupt_init_v1_hw() -- that will fix still broken deferred
probing. Let's propagate the error codes from devm_request_irq() as well
since I don't see the reason to override them with -ENOENT...

Link: https://lore.kernel.org/r/49ba93a3-d427-7542-d85a-b74fe1a33a73@omp.ru
Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 08eca20b0b81..8b41545ff8d9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1746,7 +1746,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 				dev_err(dev,
 					"irq init: fail map phy interrupt %d\n",
 					idx);
-				return -ENOENT;
+				return irq;
 			}
 
 			rc = devm_request_irq(dev, irq, phy_interrupts[j], 0,
@@ -1755,7 +1755,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 				dev_err(dev, "irq init: could not request "
 					"phy interrupt %d, rc=%d\n",
 					irq, rc);
-				return -ENOENT;
+				return rc;
 			}
 		}
 	}
@@ -1766,7 +1766,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 		if (!irq) {
 			dev_err(dev, "irq init: could not map cq interrupt %d\n",
 				idx);
-			return -ENOENT;
+			return irq;
 		}
 
 		rc = devm_request_irq(dev, irq, cq_interrupt_v1_hw, 0,
@@ -1774,7 +1774,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 		if (rc) {
 			dev_err(dev, "irq init: could not request cq interrupt %d, rc=%d\n",
 				irq, rc);
-			return -ENOENT;
+			return rc;
 		}
 	}
 
@@ -1784,7 +1784,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 		if (!irq) {
 			dev_err(dev, "irq init: could not map fatal interrupt %d\n",
 				idx);
-			return -ENOENT;
+			return irq;
 		}
 
 		rc = devm_request_irq(dev, irq, fatal_interrupts[i], 0,
@@ -1793,7 +1793,7 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev,
 				"irq init: could not request fatal interrupt %d, rc=%d\n",
 				irq, rc);
-			return -ENOENT;
+			return rc;
 		}
 	}
 
-- 
2.30.2

