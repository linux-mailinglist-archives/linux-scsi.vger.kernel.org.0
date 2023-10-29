Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6D7DB0ED
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Oct 2023 00:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjJ2XXb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 29 Oct 2023 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjJ2XXU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 29 Oct 2023 19:23:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7220EA5D8;
        Sun, 29 Oct 2023 16:03:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3249C4167E;
        Sun, 29 Oct 2023 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620517;
        bh=qRIgjQfLbsV9Qh3eHJRvU8mHqGFe89XtdJc16BPBs5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVdCcZcQoAN+33bxMnm85KBLpl1oJsLlCUZZLofc+AJbmF7DnUhAg+IehuUdAq2RL
         9zo6r3hAbYlbVRqR9rQPsj33V5byyjGe/hNQGYSnBm2AS25mqbiFcTrNy7JPjoQ8Nk
         28nhQjgygU4/lr/jU5uTr8MPr24d5Xw4DPgfZdy89CbuFETp2MZApYw3JwvUYTtW08
         nH3kKtTdbFL302r0G3hhzs/cyUAdcxu9fYxSyxInBIp+IGWf6P8gbl5KuIkAzWXqAA
         bsUBtbsa95AvdTfWlXoaO1ITA3Fi8NNFpWzMQ3tXg28fwc5FhcvXhKu9fRCIQSvegg
         asktI0a0Q5SCg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Henzl <thenzl@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/12] scsi: mpt3sas: Fix in error path
Date:   Sun, 29 Oct 2023 19:01:23 -0400
Message-ID: <20231029230135.793281-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230135.793281-1-sashal@kernel.org>
References: <20231029230135.793281-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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
index c8d97dc2ca63d..bf659bc466dcc 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11182,8 +11182,10 @@ _mpt3sas_init(void)
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

