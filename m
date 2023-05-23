Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADEA70D5F9
	for <lists+linux-scsi@lfdr.de>; Tue, 23 May 2023 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjEWHsb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 May 2023 03:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbjEWHsB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 May 2023 03:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502710CE
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 00:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44C3863040
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 07:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E24C43443;
        Tue, 23 May 2023 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684828023;
        bh=kAF4R0An2gmPizLgEX0KPLjEXOglwTiXw45u7IO6cew=;
        h=From:To:Subject:Date:From;
        b=f3dXpKN+IxQao10uBGRn2sHbaRYDxH9y/B/Tr1u6+WraQcWza82Usjjmu//wrX+G4
         2BNCQB/0YCgQjqCqmwVSY3T00XaCDtZvHYvSOGzvtx/ELWB6pOxvb2kz7+KVfJSHU5
         vmWM/U3RZHKoGv8W5WVlmDqoPKLbID3Snt8urUvwUACVzfYU7n42t77wCWPPrb6p3n
         /sLYE//lqDTywub1p0KajtSp7K2/+F2KvjzvOxghnxoot8BXn34S1LmYn/EfmB9URj
         QflqRaupLEMFNSZBl7Q6KWkXVm2BNDVGZ+/fE7xND25OderKvIApW2XjGETinKZiU8
         EglMDCoVkGugA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] ata: libata-scsi: fix ata_msense_control kdoc comment
Date:   Tue, 23 May 2023 16:47:01 +0900
Message-Id: <20230523074701.293502-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add missing description of the spg argument of ata_msense_control().

Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 69fc0d2c2123..40d6703e2d07 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3850,6 +3850,7 @@ static unsigned int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 /**
  *	ata_mselect_control - Simulate MODE SELECT for control page
  *	@qc: Storage for translated ATA taskfile
+ *	@spg: target sub-page of the control page
  *	@buf: input buffer
  *	@len: number of valid bytes in the input buffer
  *	@fp: out parameter for the failed field on error
-- 
2.40.1

