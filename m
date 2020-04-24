Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EED1B7334
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Apr 2020 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgDXLhj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Apr 2020 07:37:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43898 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbgDXLhY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Apr 2020 07:37:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 704E2C00DE;
        Fri, 24 Apr 2020 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587728243; bh=1D230Ci18aVCdgpR8Po0X8/xf8eXgqcL1sF98oqUzNE=;
        h=From:To:Cc:Subject:Date:From;
        b=cZm+nhzOwGwHGKKr8K3CUhSZORjAzH8PJD2aFiJehPn/A/jFPKm7n5ehWYutgJFXW
         8ltuPCqkwuey70+HGocoroXAR1jvINclug6WAjCM3DvF329RUz1WoB0JMA4wCIjXe9
         ebcSa4FkBukJPN7TmcVl6jE+WYA97McRw74LGVXmxenExWMfrfU/H1h3xunEBM57EL
         OWHnfx0ZFto8XQSyjYqDYYdOrvfkfNWnL/2keyFWpP7jz7EIJnls1EZrKS+T90CU6D
         pwiw8czoka5eCGVCsUWPOYS/jT9wLeoEQTvp0hDaYKB1OkfO4O0SHq+fuEZn9gaV0s
         TsX0fkyrj7BPA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 45C4BA005B;
        Fri, 24 Apr 2020 11:37:20 +0000 (UTC)
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
Subject: [PATCH 0/5] scsi: ufs: Misc improvements for DesignWare drivers and UFS
Date:   Fri, 24 Apr 2020 13:36:55 +0200
Message-Id: <cover.1587727756.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Misc set of improvements for Synopsys DesignWare drivers and UFS core.

Patch 1/5, allows UFS 3.0 as a valid version for a given Host.

Patch 2/5, removes all mention of G210 to the DesignWare drivers so that we
can use same driver among different Test Chips.

Patch 3/5, re-arranges the initialization sequence of PCI driver to be more
modular.

Patch 4/5, allows MSI as a valid interrupt type.

Finally at 5/5, we change the Maintainers for UFS DesignWare drivers.

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

Jose Abreu (5):
  scsi: ufs: Allow UFS 3.0 as a valid version
  scsi: ufs: Rename tc-dwc-g210 -> tc-dwc
  scsi: ufs: tc-dwc-pci: Use PDI ID to match Test Chip type
  scsi: ufs: tc-dwc-pci: Allow for MSI interrupt type
  MAINTAINERS: Change Maintainers for SCSI UFS DWC Drivers

 MAINTAINERS                                        |   3 +-
 drivers/scsi/ufs/Kconfig                           |   4 +-
 drivers/scsi/ufs/Makefile                          |   4 +-
 drivers/scsi/ufs/tc-dwc-g210-pci.c                 | 176 ------------------
 drivers/scsi/ufs/tc-dwc-pci.c                      | 202 +++++++++++++++++++++
 .../ufs/{tc-dwc-g210-pltfrm.c => tc-dwc-pltfrm.c}  |  37 ++--
 drivers/scsi/ufs/{tc-dwc-g210.c => tc-dwc.c}       |   6 +-
 drivers/scsi/ufs/{tc-dwc-g210.h => tc-dwc.h}       |   6 +-
 drivers/scsi/ufs/ufshcd.c                          |   3 +-
 drivers/scsi/ufs/ufshci.h                          |   1 +
 10 files changed, 236 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/scsi/ufs/tc-dwc-g210-pci.c
 create mode 100644 drivers/scsi/ufs/tc-dwc-pci.c
 rename drivers/scsi/ufs/{tc-dwc-g210-pltfrm.c => tc-dwc-pltfrm.c} (70%)
 rename drivers/scsi/ufs/{tc-dwc-g210.c => tc-dwc.c} (98%)
 rename drivers/scsi/ufs/{tc-dwc-g210.h => tc-dwc.h} (78%)

-- 
2.7.4

