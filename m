Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B8569642
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jul 2022 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiGFXhW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiGFXhV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 19:37:21 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359B2CDC0;
        Wed,  6 Jul 2022 16:37:20 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3EEB5C06E7;
        Wed,  6 Jul 2022 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150640; bh=dA2YHCwSJAcz5AMgI1fqU2N3tyrdZDQD1ZO/Td92ZvQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bdzRmZTHphuShNJUHu1XzuV8qt3YtU9eTBa/vdaK0/BV/vazmJ/Mqjnsq8GdCmQdS
         ebpKOT0X70qikChv8FzWNqJTcsi16LcZmCbbjCxGw6hypuhVUIet/q7G1Dzex1oH+/
         RQGnxz/UKeg/VxE+N+0mNo5+uVSXcZp1VwDG1jhZZ8cSq7lJ/KAPjrFqbpC4QTsjfw
         JzHX3krbhcNicaYxagT6M1yGJiH3yjD8c7wVNDVdD4qoPBEUKF9J18Wmfg0tkRH+yY
         GvlrvxGVSY6wPjdoTFktC47WDutS5ZItyn89kOCWjpCJ5jYsn9MUCIkte+wPVIq/uf
         /4FNYGyDIsg4A==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id F3ED8A0096;
        Wed,  6 Jul 2022 23:37:18 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:37:18 -0700
Date:   Wed, 06 Jul 2022 16:37:18 -0700
Message-Id: <5c0de82cc09fdca096aca491843918355faceb33.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 28/36] usb: gadget: f_tcm: Cleanup unused variable
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

se_cmd is not used anywhere. Remove it.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 28b560ab44fd..1e7d29f8aecb 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -675,7 +675,6 @@ static int uasp_send_read_response(struct usbg_cmd *cmd)
 static int uasp_send_write_request(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
-	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct uas_stream *stream = cmd->stream;
 	struct sense_iu *iu = &cmd->sense_iu;
 	int ret;
-- 
2.28.0

