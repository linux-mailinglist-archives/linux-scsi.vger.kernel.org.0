Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4017DAF32
	for <lists+linux-scsi@lfdr.de>; Sun, 29 Oct 2023 23:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjJ2W5n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 29 Oct 2023 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjJ2W5g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 29 Oct 2023 18:57:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC482D66;
        Sun, 29 Oct 2023 15:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273E1C433C7;
        Sun, 29 Oct 2023 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620167;
        bh=SmAfp3kOohRIg6+CIK84XG6g7rBs2b58xhlju/dX6cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ur6nmGZ9YhxZ28k3wm8sLPGSQ/P/OBE8SIzHTiO1g4KYo/Tkcnqm1Q6/77Nrr1pDT
         kc+J1AxlRBjOFdKgjYQfahsenCknO2g2Xr8yXRRvAxd2EAPBh17TgI2ADV5RNieQFq
         h6TPXKMW9yj2Br70ANxpcxQeKGApaaTWOwS5yxtOcH7JcAasdNbRqnCJFnICfBWIzY
         bBKxRzWBEcHaRp9P+BwYveP7g0w64fB0SvlcUfH91NuCkSqiHdoRMOtIOZnSqU/a7a
         E0D1v83kV638AtXe2inXuYB9yj9Uz3/hZPr4cgqSQZu3DSUFwXdmYxG1B6bUShrDq6
         1yn0Q2IokPn2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Henzl <thenzl@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 36/52] scsi: mpt3sas: Fix in error path
Date:   Sun, 29 Oct 2023 18:53:23 -0400
Message-ID: <20231029225441.789781-36-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit e40c04ade0e2f3916b78211d747317843b11ce10 ]

The driver should be deregistered as misc driver after PCI registration
failure.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Link: https://lore.kernel.org/r/20231015114529.10725-1-thenzl@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01d..605013d3ee83a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12913,8 +12913,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
-- 
2.42.0

