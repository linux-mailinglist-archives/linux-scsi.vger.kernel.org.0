Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48125EDB08
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Sep 2022 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiI1LCr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Sep 2022 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiI1LBJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Sep 2022 07:01:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51117586
        for <linux-scsi@vger.kernel.org>; Wed, 28 Sep 2022 04:01:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f193so11935175pgc.0
        for <linux-scsi@vger.kernel.org>; Wed, 28 Sep 2022 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=12/QEQF+BwVobS753asE5bo7My6pu++XkhjihYluM/U=;
        b=ylUBkOHrXVCiVDYNqzAecj5Tgjkvw+cE0/9EzW/8OorIK+wmHOBe8s2mZthiecCoX7
         h2/znTxFcnRx1Nd1XLNOyLjS8dp6D4viq8TT+w+/KQXEKMg1AF9g++loERZl4xUIQuoS
         9FtlFH4BhKrKdWwxrCWW3glFzJGOIbOHGntC4fsKQr6dfZINu5DDsKgf9EvDDybZA7vz
         dATUqdYROGnnMWPHihePzFxkNakt/lRZnLQrwXM88NPWR+5UwKFaXAMGOQtuqqQMn3Vw
         w28H/DeHTXlnfmUoCScy658oVXmxhhLtBLPC4I67dUiSQliSKD++W7do0TlzH+omeuzb
         gkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=12/QEQF+BwVobS753asE5bo7My6pu++XkhjihYluM/U=;
        b=Vqc1UcLy0GZM6W0j6mYVrRgyNGOGLVf6xcEtdPwc9qKhan9mQjAZsbHmphuhDzO4Os
         al9EPv6pPoc7n0WQ9/kl21EmPRWTDkasrIt8HuC2Y/xK68WvkD650ISMSbhWqSc8b8wM
         bfCL5I8IeFrYj1sqBoG5TJlT+0K5p4TZ5Q7nrp0g9GPtQVt8JXxDt8smmSx88WW4Vk5z
         Zfw9zrFqQtqS3GX5e2ihu6eW9ucg9vhNdLru20ZfY/fJO+TyUkZDOhHaL/gv1yo0a1rI
         O44vkUFhUV6VAOexH3sbrSful7tPZY7i7ZxS4aG9QatYJU9cnbyWOhKrWg7KF2YyJB1u
         +88w==
X-Gm-Message-State: ACrzQf1a1zzfIO95gS6NhNVetaiRliF8Ji/jqcVudxUVSgpbfQA+7hyy
        cFu6aJxIcVHuGO77HnHqxRfEkQ==
X-Google-Smtp-Source: AMsMyM50BCiH86ggXPLWUfIQc+gUAX+cRHE9ayEwYUTUJi+KXbUWt9yJvjCgEoBpJZOSC2QNZgXdrA==
X-Received: by 2002:a63:4f19:0:b0:43b:ddc9:387c with SMTP id d25-20020a634f19000000b0043bddc9387cmr28159950pgb.333.1664362867464;
        Wed, 28 Sep 2022 04:01:07 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:01:07 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 9/9] PCI/AER: Refine status clearing process with api
Date:   Wed, 28 Sep 2022 18:59:46 +0800
Message-Id: <20220928105946.12469-10-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Statements clearing status in aer_enable_rootport() is functionally
equivalent with pcie_clear_device_status() and pci_aer_clear_status().
So replace them, which has no functional changes.

After commit 20e15e673b05 ("PCI/AER: Add pci_aer_raw_clear_status()
to unconditionally clear Error Status"), pci_aer_raw_clear_status()
is only used by the EDR path, so we add note in function comment.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a6d29269ccf2..bd5ecfa4860f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -306,6 +306,8 @@ EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
  * Clearing AER error status registers unconditionally, regardless of
  * whether they're owned by firmware or the OS.
  *
+ * Used only by the EDR path. Other paths should use pci_aer_clear_status().
+ *
  * Returns 0 on success, or negative on failure.
  */
 int pci_aer_raw_clear_status(struct pci_dev *dev)
@@ -1277,24 +1279,17 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 {
 	struct pci_dev *pdev = rpc->rpd;
 	int aer = pdev->aer_cap;
-	u16 reg16;
 	u32 reg32;
 
 	/* Clear PCIe Capability's Device Status */
-	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
+	pcie_clear_device_status(pdev);
 
 	/* Disable system error generation in response to error messages */
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_aer_clear_status(pdev);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
-- 
2.30.1 (Apple Git-130)

