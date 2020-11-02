Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D62A3062
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKBQwu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgKBQwq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 11:52:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1BC0617A6;
        Mon,  2 Nov 2020 08:52:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id k9so9590462pgt.9;
        Mon, 02 Nov 2020 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPMjeP+Aj8Y7qYlQVBIVXdIdvsMXyUBB2qOriiIG5lA=;
        b=BFOSE7/jZj6D/hNGPW6Z+IYEY9S+IxabURlympaa+oRyRRbAXjsP9s3RqWZx4J9hsI
         BGEE9Eq70JfosYWPtLomF9SBSuA2HBDZ02GUj+CVWcFUEBT+XVI7n7zaCr7wbCwgw6ka
         3+H7Z9qVtNwMndJMN2vWnlSyc5hAqGyIR5QQN8X+2yhvSRPnaI69RmUxBdbubFTuCUIX
         piy3chi0KamIbGXKBG2UJ2Es5dnVCmLTvftYmI0OmGoR0vMZdTO+zQFhPSeSyRYxhBDJ
         KlfHKfLgq+0S1P+m6dMT7tAXfXoDIUsQHSzhmIinIKqJS2Ln4WWV+wyx2ui1xnLN3d52
         V74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPMjeP+Aj8Y7qYlQVBIVXdIdvsMXyUBB2qOriiIG5lA=;
        b=aSrurqFQWiQ+kB2Dx66kipoTUG+G3EXQyW4/wxKVi9utlut22q/gg54gI9mKR1eN7J
         Y8J57qqNmrX8iU79FYrUJIKHE3Sk/X1X7mqcR37rt1ry+AgmKFym2fS2BF8sFbSex84o
         MzZ22R/HykFQgo7FQ1WY9NzpoL3eat1rW6Y0GJDKCfJj1mES/jeH0ufO8Zw85760SjBf
         dT5mGMfZ+KR08qWJWNP41fxHkdkwQZDhpcnknnzGg0YcgWTJX7Hip49jv2zq0nJ7XGtF
         iD+L86Acvn8KCv+VKSGxbAIIAP3oj5W0QSy+WUFN1Ld61mIHeEbbDX9Dza3NgpApcHUW
         8yWA==
X-Gm-Message-State: AOAM532FctXEUjsNslvOvuiSZlY/+v/mVxMYras0OXfEbY9r3WnUuDYP
        wDVCocXf+86wCMAlKIlPG5E=
X-Google-Smtp-Source: ABdhPJyCrllqbyiFve3kKXuwDFU8Zp7rtUgBCNHNxZtJ2bhsDm1uCIq1J9Y4X4Ue1/8Cl51gz1/Uiw==
X-Received: by 2002:a17:90a:468f:: with SMTP id z15mr17777167pjf.200.1604335966065;
        Mon, 02 Nov 2020 08:52:46 -0800 (PST)
Received: from varodek.localdomain ([223.179.149.110])
        by smtp.gmail.com with ESMTPSA id t74sm4953233pfc.47.2020.11.02.08.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:52:45 -0800 (PST)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Balsundar P <balsundar.p@microchip.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v4 12/29] scsi: hisi_sas_v3_hw: Drop PCI Wakeup calls from .resume
Date:   Mon,  2 Nov 2020 22:17:13 +0530
Message-Id: <20201102164730.324035-13-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
References: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver calls pci_enable_wake(...., false) in hisi_sas_v3_resume(), and
there is no corresponding pci_enable_wake(...., true) in
hisi_sas_v3_suspend(). Either it should do enable-wake the device in
.suspend() or should not invoke pci_enable_wake() at all.

Concluding that this driver doesn't support enable-wake and PCI core calls
pci_enable_wake(pci_dev, PCI_D0, false) during resume, drop it from
hisi_sas_v3_resume().

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7133ca859b5e..f19f3db1ac6d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3492,7 +3492,6 @@ static int _resume_v3_hw(struct device *device)
 	dev_warn(dev, "resuming from operating state [D%d]\n",
 		 device_state);
 	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_wake(pdev, PCI_D0, 0);
 	pci_restore_state(pdev);
 	rc = pci_enable_device(pdev);
 	if (rc) {
-- 
2.28.0

