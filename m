Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED86C4DC
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 04:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbfGRCJQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jul 2019 22:09:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44418 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfGRCJQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Jul 2019 22:09:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so27232716otl.11
        for <linux-scsi@vger.kernel.org>; Wed, 17 Jul 2019 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBv93M51Cm27uWFOlZ79cXm5tHYDJ8Ehc/VJnl7Bsac=;
        b=cQ50t0e/TYXv0f06gbL54Fp3Yrwg7bN8IkwK1+AnRAadEqm80rjzsuoKYNznG+tFEV
         lGh+daxpY4K8TeweA5JwO46a9l7Is2O+mKX7Sq5XQrkIimbUHVCFTLOeTaXe7/eBPY4r
         TQTAlSAmPhrkOUmlj7HQikodai2rpveJejNlWXcExthtUBOjtttnqiMwcVX0y7uJY2Wp
         8qx/syN6qXlxVfgr9w2ICvgORYcJmpuioHefo7erPDhr43tNevUjv4rWpDd0jQILpcLY
         z2lgLhavqUCKfmhC+3CeRBgCK9HNkHZpe2fQC0tjO48F9nvvnXdBe8hnidI/TDKktU5+
         Y/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBv93M51Cm27uWFOlZ79cXm5tHYDJ8Ehc/VJnl7Bsac=;
        b=NxmkJx5CCx4SynOubAYXOryki3OIwKN+qeVhn35Xqxk1Kb3N+qSMfRBKzNIBNvgTnJ
         SwolkJzrQo3KwxweBeq+EvvjTUiM9uskOGrP7q7m2eKfPCDEi93B5oJSZIHMPDZLMfJO
         aYZiw4N3PPOUEXVT8JfORMjL803uy+z2AG5nhum9t7JI0vD/oP4x01uv73a3e8zHNlxT
         h9VpixGuiyZZ0x6P38p9QS4AwAfsxgODsSWDqfbx/dS7eHX24b0YGnAjDmHrS2hwiIM3
         7CIYcD1asCWGTZZ1lFbVWThHUm+2uLcX8xH5aW38+PVp6DK/NxGNallWg2UDlSEbbiPS
         8Osg==
X-Gm-Message-State: APjAAAU4Q+aU+pd8lH1U2Priv688ZkunOpORHUuS7i07kILHEeHy5+f5
        9dxabLfxeYKU+REnq96g66s=
X-Google-Smtp-Source: APXvYqwkduwNJYTtmbkWXsTJ92I8TPBt+8gY4M4U0jN8M8NZ5AO00WG6WLuOSXVQScDR/ok61UQnvw==
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr30566080otq.104.1563415755427;
        Wed, 17 Jul 2019 19:09:15 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id v203sm10184523oie.5.2019.07.17.19.09.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:14 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] scsi: csiostor: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:43 -0500
Message-Id: <20190718020745.8867-8-fred@fredlawl.com>
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
 drivers/scsi/csiostor/csio_wr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index 03bd896cdbb9..0ca695110f54 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -1316,7 +1316,6 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 	u32 fl_align = clsz < 32 ? 32 : clsz;
 	u32 pack_align;
 	u32 ingpad, ingpack;
-	int pcie_cap;
 
 	csio_wr_reg32(hw, HOSTPAGESIZEPF0_V(s_hps) | HOSTPAGESIZEPF1_V(s_hps) |
 		      HOSTPAGESIZEPF2_V(s_hps) | HOSTPAGESIZEPF3_V(s_hps) |
@@ -1347,8 +1346,7 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 	 * multiple of the Maximum Payload Size.
 	 */
 	pack_align = fl_align;
-	pcie_cap = pci_find_capability(hw->pdev, PCI_CAP_ID_EXP);
-	if (pcie_cap) {
+	if (pci_is_pcie(hw->pdev)) {
 		u32 mps, mps_log;
 		u16 devctl;
 
@@ -1356,9 +1354,7 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 		 * [bits 7:5] encodes sizes as powers of 2 starting at
 		 * 128 bytes.
 		 */
-		pci_read_config_word(hw->pdev,
-				     pcie_cap + PCI_EXP_DEVCTL,
-				     &devctl);
+		pcie_capability_read_word(hw->pdev, PCI_EXP_DEVCTL, &devctl);
 		mps_log = ((devctl & PCI_EXP_DEVCTL_PAYLOAD) >> 5) + 7;
 		mps = 1 << mps_log;
 		if (mps > pack_align)
-- 
2.17.1

