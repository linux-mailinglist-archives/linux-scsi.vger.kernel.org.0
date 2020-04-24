Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38611B774A
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Apr 2020 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDXNpF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Apr 2020 09:45:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45420 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbgDXNpE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:45:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D904A4048C;
        Fri, 24 Apr 2020 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587735904; bh=fUGJqawcBEgP+QdRQ/p9SxgMNc2aPtUdTOSFffhfqTo=;
        h=From:To:Cc:Subject:Date:From;
        b=FZDNASM/ehIHTH7vo/YP5DPNxEJA88SAayFd5SdTyZa1pXNAZW/lRnQQ74XrMSszS
         gAx+Bms4xJAHpg6dCgrEoVjWTaWoCE8FgNyWgEQrocgZdFonrFIb+58hOAVrylF8AZ
         FAoILgZCkmUmAfqLMZKVxeFKsXyvFwVMhAflmTPmC/ibRMqdAp9AjUzQMLDu7XiT1u
         fkPZ1n6r1MJ9NF4xWJM34DTYOLFi8F/Qc9vd5ewUpN/ZqxkBIuIFURC90DPmKo0EpF
         83IjE38P0bbGe4+QhMjUANQ3JA2Ln4lzr//pCuQ+FWB2J2w94A5M2i3icv9XYjfymD
         9yHoQ3KsHoKyQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id C561FA005D;
        Fri, 24 Apr 2020 13:45:01 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-scsi@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Joao Lima <Joao.Lima@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] scsi: ufs: Misc improvements for DesignWare drivers and UFS
Date:   Fri, 24 Apr 2020 15:44:44 +0200
Message-Id: <cover.1587735561.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

v2 Address review comments from Tomas and adds r-b tag provided by Alim.

---

Misc set of improvements for Synopsys DesignWare drivers and UFS core.

Patch 1/5, allows UFS 3.0 as a valid version for a given Host.

Patch 2/5, removes all mention of G210 to the DesignWare drivers so that we
can use same driver among different Test Chips.

Patch 3/5, re-arranges the initialization sequence of PCI driver to be more
modular.

Patch 4/5, allows MSI as a valid interrupt type.

Finally at 5/5, we change the Maintainers for UFS DesignWare drivers.

---
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>
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
 drivers/scsi/ufs/tc-dwc-pci.c                      | 204 +++++++++++++++++++++
 .../ufs/{tc-dwc-g210-pltfrm.c => tc-dwc-pltfrm.c}  |  37 ++--
 drivers/scsi/ufs/{tc-dwc-g210.c => tc-dwc.c}       |   6 +-
 drivers/scsi/ufs/{tc-dwc-g210.h => tc-dwc.h}       |   6 +-
 drivers/scsi/ufs/ufshcd.c                          |   3 +-
 drivers/scsi/ufs/ufshci.h                          |   1 +
 10 files changed, 238 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/scsi/ufs/tc-dwc-g210-pci.c
 create mode 100644 drivers/scsi/ufs/tc-dwc-pci.c
 rename drivers/scsi/ufs/{tc-dwc-g210-pltfrm.c => tc-dwc-pltfrm.c} (70%)
 rename drivers/scsi/ufs/{tc-dwc-g210.c => tc-dwc.c} (98%)
 rename drivers/scsi/ufs/{tc-dwc-g210.h => tc-dwc.h} (78%)

-- 
2.7.4

