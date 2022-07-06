Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC156965F
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jul 2022 01:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiGFXiO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 19:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGFXiJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 19:38:09 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3282CCBD;
        Wed,  6 Jul 2022 16:38:09 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3C41740787;
        Wed,  6 Jul 2022 23:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150689; bh=H49rpr1BNaC58aPVdMWuYpKSmmZsypu9brrKmZKOH5w=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=lyEsNpnil19gsAEbdRYuOZ9AtA0Svha2UEwXgvOs/vbfC35gkf2NcdigS1viH5BfW
         q9Agwl5dkXUQy8A5ofAXdUwPF6s9wn3j3dZfCwgDKdPM8c1h/OkPDyad8ZjAoRoAa/
         ytzaAHM5YPnw9Vy/sKq+ZUu1TIN2EfROerB5Xy4scXqZ/csLJsKvU3QP7VnrHc3Zys
         eYXWu7Yh9PTEV9kkENn9FaxER6q2/xh4wce33pdsovspB1ku7rehst0HOUp6rtafvb
         kR7h944tIfV99zFDdgtPqGuxPt0jmYWtTNv+s+09ulsZkxSJISwtNh/nr/lAsF1Y69
         Bk/yxyFFOFOOg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 16337A0063;
        Wed,  6 Jul 2022 23:38:08 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:38:08 -0700
Date:   Wed, 06 Jul 2022 16:38:08 -0700
Message-Id: <ae1a03985d68fb936a75dc1f443d608b87a7858d.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 36/36] usb: gadget: f_tcm: Comply with UAS Task Management requirement
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

The UASP driver must support all the task management functions listed in
Table 20 of UAS-r04. However, not all of them are implemented in the
Target core. To remain compliant while indicate that the TMR did not go
through, report RC_TMF_FAILED instead of RC_TMF_NOT_SUPPORTED and print
a warning to the user.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index a68436f97f91..da9e6e07cfb8 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -635,6 +635,30 @@ static void uasp_prepare_response(struct usbg_cmd *cmd)
 		rsp_iu->response_code =
 			tcm_to_uasp_response(se_cmd->se_tmr_req->response);
 
+	/*
+	 * The UASP driver must support all the task management functions listed
+	 * in Table 20 of UAS-r04. To remain compliant while indicate that the
+	 * TMR did not go through, report RC_TMF_FAILED instead of
+	 * RC_TMF_NOT_SUPPORTED and print a warning to the user.
+	 */
+	switch (cmd->tmr_func) {
+	case TMR_ABORT_TASK:
+	case TMR_ABORT_TASK_SET:
+	case TMR_CLEAR_TASK_SET:
+	case TMR_LUN_RESET:
+	case TMR_I_T_NEXUS_RESET:
+	case TMR_CLEAR_ACA:
+	case TMR_QUERY_TASK:
+	case TMR_QUERY_TASK_SET:
+	case TMR_QUERY_ASYNC_EVENT:
+		if (rsp_iu->response_code == RC_TMF_NOT_SUPPORTED) {
+			pr_warn("TMR function %d not supported\n",
+				cmd->tmr_func);
+			rsp_iu->response_code = RC_TMF_FAILED;
+		}
+		break;
+	}
+
 	stream->req_status->is_last = 1;
 	stream->req_status->stream_id = cmd->tag;
 	stream->req_status->context = cmd;
-- 
2.28.0

