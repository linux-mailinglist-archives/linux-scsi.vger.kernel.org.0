Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE326D9529
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Apr 2023 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjDFLb7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Apr 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDFLby (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Apr 2023 07:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241C83F7;
        Thu,  6 Apr 2023 04:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44FAD64636;
        Thu,  6 Apr 2023 11:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9182C4339B;
        Thu,  6 Apr 2023 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680780706;
        bh=x/Y/RLa1aB4fQtD6Xv3SKk6jaP5TlzviO/1+pssIR4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsD1uoX9Q06yp5x+x1dXHQG6faiCFAFwtQVVB6RCgP0iCz5ohdW51tabFYT3ZRDDK
         VyvXZmp3SwAC2pbaiCDAswpYOxscTqmFZc5m6lGGS7ZZK8+tFLiUB9Eijo4wTsiu6I
         ZqUFrVjBzyODyMb+Q8uAO4PkJpi3mEnCqNI0mBy+NIsofb1/y0p9aqNDv/YryhzQi9
         gfGEjCMjnkapU2U6i+0a32GjzsUsXNjACu4jgJKQAiStVbjn6k8dGtix9TNCxg3CKr
         Ay9RfOYyACpttqNqm3iIiSviGFmqxQ9Q1c7n3r66eIoKXZAPh+x2mknVBIg3+IzesM
         NgD6EMdBcPiTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Henzl <thenzl@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 05/17] scsi: megaraid_sas: Fix fw_crash_buffer_show()
Date:   Thu,  6 Apr 2023 07:31:19 -0400
Message-Id: <20230406113131.648213-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113131.648213-1-sashal@kernel.org>
References: <20230406113131.648213-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit 0808ed6ebbc292222ca069d339744870f6d801da ]

If crash_dump_buf is not allocated then crash dump can't be available.
Replace logical 'and' with 'or'.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Link: https://lore.kernel.org/r/20230324135249.9733-1-thenzl@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3ceece9883383..c895189375e2b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3298,7 +3298,7 @@ fw_crash_buffer_show(struct device *cdev,
 
 	spin_lock_irqsave(&instance->crashdump_lock, flags);
 	buff_offset = instance->fw_crash_buffer_offset;
-	if (!instance->crash_dump_buf &&
+	if (!instance->crash_dump_buf ||
 		!((instance->fw_crash_state == AVAILABLE) ||
 		(instance->fw_crash_state == COPYING))) {
 		dev_err(&instance->pdev->dev,
-- 
2.39.2

