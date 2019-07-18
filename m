Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460B56C4DE
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 04:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfGRCJW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jul 2019 22:09:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45572 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfGRCJW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Jul 2019 22:09:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so20212454oib.12
        for <linux-scsi@vger.kernel.org>; Wed, 17 Jul 2019 19:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0K2Z781kWZftcdr+fy0S02sOXmXEkTKag2oui4WKC4=;
        b=wxHn5m/l4pEwrhbdmndVI58aqGgHTl7X9zIo8VK/6zhtqtPZLS1Po7I+kd5XcRE57f
         hBc7QhAMpL5Gbn8XxhvbBmLxbO8wnjB6/DOJwZ7VRy05zVI1JLxfNEFJ/10OdPurUDP+
         RvFgE99hdRrmJ6sNEILwemVw+9y9h+hBySGPYPAZpXRNjG4lf9ZczzkB29DrOb6+gHQG
         ew4WEnAvBNEUUm4ph2P9M00b37J9Fb1CLRMzO+6M8IImBOKRp5Z+iN0PJhjSubkumcUt
         EV6pQxYDFscoQzE+dknk4WFWPOO25/785aeXbjLeoMwyyl9wv4XZ183Uc57G/ExZ4BF4
         Poow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0K2Z781kWZftcdr+fy0S02sOXmXEkTKag2oui4WKC4=;
        b=WWYMQZqO//zLJy0oDRqFUl9Fx60wRoyHgVzuk7kyO81rrRXt4ydMzcxxfIaHOEj5Vg
         vVKIdgTByEMBkMhv//WGUyvgfwRKU81Yiee1u9+TvIelJDz8cOKLFKyGniP4ut3kUhk8
         Ups7v8/uWD1vdlVJW3C9mEbS5F4RRKYSwKHbH7Npf5uIMj2cONvBOEQt9Vus0lQiC/OJ
         3X4R/PKBvFZV1EvAKZCcgXIuz2BtacKdOpZIGPPZgytGpFumuQe63cIl4YdxmNkLj1I7
         W4vudSPCw+i4PbnRT/9g7BGJboeOuVKh+HCDb8jn6oc2ZKTOIZ86sHkvuIDQbBl/AAYU
         2OYA==
X-Gm-Message-State: APjAAAVcf6hHQljbW05eHjfQo0qShh6GsTzxPzi32ONbjuVjwwd4TOKk
        0imNB2zh6Mw9DJgNNV78oMY=
X-Google-Smtp-Source: APXvYqwk4sfq9cv64SvpwitEFlWzkERSLEQAHK/Lk/JYvwKQhDepMQB6gk83IzfFklxrnxFp5EBXYg==
X-Received: by 2002:aca:55c2:: with SMTP id j185mr23543959oib.100.1563415760966;
        Wed, 17 Jul 2019 19:09:20 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id a21sm8639497otr.4.2019.07.17.19.09.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:20 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] scsi: esas2r: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:44 -0500
Message-Id: <20190718020745.8867-9-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/scsi/esas2r/esas2r_init.c  | 13 ++++---------
 drivers/scsi/esas2r/esas2r_ioctl.c | 14 +++++---------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 950cd92df2ff..eb7d139ffc00 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -762,14 +762,10 @@ u32 esas2r_get_uncached_size(struct esas2r_adapter *a)
 
 static void esas2r_init_pci_cfg_space(struct esas2r_adapter *a)
 {
-	int pcie_cap_reg;
-
-	pcie_cap_reg = pci_find_capability(a->pcid, PCI_CAP_ID_EXP);
-	if (pcie_cap_reg) {
+	if (pci_is_pcie(a->pcid)) {
 		u16 devcontrol;
 
-		pci_read_config_word(a->pcid, pcie_cap_reg + PCI_EXP_DEVCTL,
-				     &devcontrol);
+		pcie_capability_read_word(a->pcid, PCI_EXP_DEVCTL, &devcontrol);
 
 		if ((devcontrol & PCI_EXP_DEVCTL_READRQ) >
 		     PCI_EXP_DEVCTL_READRQ_512B) {
@@ -778,9 +774,8 @@ static void esas2r_init_pci_cfg_space(struct esas2r_adapter *a)
 
 			devcontrol &= ~PCI_EXP_DEVCTL_READRQ;
 			devcontrol |= PCI_EXP_DEVCTL_READRQ_512B;
-			pci_write_config_word(a->pcid,
-					      pcie_cap_reg + PCI_EXP_DEVCTL,
-					      devcontrol);
+			pcie_capability_write_word(a->pcid, PCI_EXP_DEVCTL,
+						   devcontrol);
 		}
 	}
 }
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 3d130523c288..442c5e70a7b4 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -757,7 +757,6 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 
 		struct atto_hba_get_adapter_info *gai =
 			&hi->data.get_adap_info;
-		int pcie_cap_reg;
 
 		if (hi->flags & HBAF_TUNNEL) {
 			hi->status = ATTO_STS_UNSUPPORTED;
@@ -784,17 +783,14 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 		gai->pci.dev_num = PCI_SLOT(a->pcid->devfn);
 		gai->pci.func_num = PCI_FUNC(a->pcid->devfn);
 
-		pcie_cap_reg = pci_find_capability(a->pcid, PCI_CAP_ID_EXP);
-		if (pcie_cap_reg) {
+		if (pci_is_pcie(a->pcid)) {
 			u16 stat;
 			u32 caps;
 
-			pci_read_config_word(a->pcid,
-					     pcie_cap_reg + PCI_EXP_LNKSTA,
-					     &stat);
-			pci_read_config_dword(a->pcid,
-					      pcie_cap_reg + PCI_EXP_LNKCAP,
-					      &caps);
+			pcie_capability_read_word(a->pcid, PCI_EXP_LNKSTA,
+						  &stat);
+			pcie_capability_read_dword(a->pcid, PCI_EXP_LNKCAP,
+						   &caps);
 
 			gai->pci.link_speed_curr =
 				(u8)(stat & PCI_EXP_LNKSTA_CLS);
-- 
2.17.1

