Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65F2A3093
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgKBQzX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 11:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKBQzX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 11:55:23 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEDDC0617A6;
        Mon,  2 Nov 2020 08:55:23 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 72so4913122pfv.7;
        Mon, 02 Nov 2020 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXCGiZLEfZtvWjQ4e/G4dbiDVH55KoRFUUF32V42VvE=;
        b=X+zOGPT/TSOjE20bmMX712PNBloY0JW3OvLlxo329Ib1Nf2+FbziCV/QGDeTkMtx3D
         Ab6QfTFENhrYD1E/hwYQlE6GPQRAaqwsm3H1gCYd65BpugqByfoG3PnQ4AG4MMPNdBhm
         1FtG6g90mxk2rKio+tEnH6/jKTlWAcNL5g+wjjNzYlzM8idwGsSZ+iCykVZSPWTTqivi
         WZ352otPwDz30BsdcSrChlsHrFNfm1b/w3AHyNdbVSDJoXEa6FU9mnfJNrr295p8orMa
         yKxsCSYOkyY4oE/6MbL82LydkpnzJTbqmN8AwhAm1RYe8+lwWUhiSIV4r4rQUh7gT3TO
         pCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXCGiZLEfZtvWjQ4e/G4dbiDVH55KoRFUUF32V42VvE=;
        b=fpaKd6KpQTVQwPhyV/g68Zvfvb9M7k39T1G6xhknP3by+qdijbmPWUBm5GW3z3tdtj
         VIAh27MMTha3d4/VLRQ0Vw0KQDVLRe3OaA8phltfyGp1e95LqfnCOUlyGj6poPee6m/e
         3nre9h6NJ8ZWBFcdzG80KZebNLrERkZC683gb4+P3mjKbOkDy/So1CnegvZGpfJnq3n6
         yQdWeYNoqRUj/l7zyF2OiPngyu0CIJtAqsFo+E+z1cPr2P6wjaG/9K5cHs0RXsDcB4jb
         rdQJIV5Lnh7YuhKGolCS55gcLA5ysXVLNTzPOIFCm/F4VAB+ML3bdoYls/kKhqBMSQS0
         y0ZA==
X-Gm-Message-State: AOAM530acSaAF2TNXLQlsZ9UWFXc1QVSlwn3zCCwFm+F8bqIwa5PQSW9
        0AOwcF9XscrAHl4OVSziCJ0=
X-Google-Smtp-Source: ABdhPJwzfPgvdSwIBa5QtR9xO4o0HjNoNHKyv4uGH33LCWmGslB9FXZpefstEtLmcHt2vG3qPnXRHw==
X-Received: by 2002:a17:90a:fb8d:: with SMTP id cp13mr7412843pjb.168.1604336122852;
        Mon, 02 Nov 2020 08:55:22 -0800 (PST)
Received: from varodek.localdomain ([223.179.149.110])
        by smtp.gmail.com with ESMTPSA id t74sm4953233pfc.47.2020.11.02.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:55:22 -0800 (PST)
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
Subject: [PATCH v4 27/29] scsi: mvumi: update function description
Date:   Mon,  2 Nov 2020 22:17:28 +0530
Message-Id: <20201102164730.324035-28-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
References: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no "device" parameter in mvumi_shutdown(). Instead there is
"pdev" which is not described.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/scsi/mvumi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index bbf0faac1f05..6c82b0bc391a 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2559,7 +2559,7 @@ static void mvumi_detach_one(struct pci_dev *pdev)
 
 /**
  * mvumi_shutdown -	Shutdown entry point
- * @device:		Generic device structure
+ * @pdev:		PCI device structure
  */
 static void mvumi_shutdown(struct pci_dev *pdev)
 {
-- 
2.28.0

