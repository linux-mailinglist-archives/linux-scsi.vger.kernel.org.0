Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38779537FBA
	for <lists+linux-scsi@lfdr.de>; Mon, 30 May 2022 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiE3OJ5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 May 2022 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbiE3OEx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 May 2022 10:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B0CE5E8;
        Mon, 30 May 2022 06:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6084960F74;
        Mon, 30 May 2022 13:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9333CC3411F;
        Mon, 30 May 2022 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918048;
        bh=cmZKyuLkuhoQx8U8SjA9Ah7lmHkMh8mv8BlTxKgphtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvjUuXrjt6o7mW7hG4Sf0AM96Wyw9C6Sl1m/rKxPIhvL80zOKmQvwBUZGvpKc1t43
         mlY4wXExamFD3EVg7iQfk0GSQKsWMPmZmDbNKjEBsprqvEms/8Uy6CdjuxgZFO22yN
         cf/+Uz2fm1R3gc/QT8PCLaG3fIKZM0k6BFqLATFyDfb6PZeqfqGPwgfme4Hs1oJpTj
         sbDappHUo4Pzhymfmf8Fx674aM66Yesg/fsqIuohdp4U72CXIkdeMQXDGK9f9RkRSS
         FdGNPguuKQ1On/CgxiqzFWS3EqCQgKMkBeOfquvBtay+1Dby95XzRutIL2L8vwjcd1
         b+kexyFQFjq/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 042/109] scsi: lpfc: Fix resource leak in lpfc_sli4_send_seq_to_ulp()
Date:   Mon, 30 May 2022 09:37:18 -0400
Message-Id: <20220530133825.1933431-42-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 646db1a560f44236b7278b822ca99a1d3b6ea72c ]

If no handler is found in lpfc_complete_unsol_iocb() to match the rctl of a
received frame, the frame is dropped and resources are leaked.

Fix by returning resources when discarding an unhandled frame type.  Update
lpfc_fc_frame_check() handling of NOP basic link service.

Link: https://lore.kernel.org/r/20220426181419.9154-1-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 68d8e55c1205..d8d26cde70b6 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -18455,7 +18455,6 @@ lpfc_fc_frame_check(struct lpfc_hba *phba, struct fc_frame_header *fc_hdr)
 	case FC_RCTL_ELS_REP:	/* extended link services reply */
 	case FC_RCTL_ELS4_REQ:	/* FC-4 ELS request */
 	case FC_RCTL_ELS4_REP:	/* FC-4 ELS reply */
-	case FC_RCTL_BA_NOP:  	/* basic link service NOP */
 	case FC_RCTL_BA_ABTS: 	/* basic link service abort */
 	case FC_RCTL_BA_RMC: 	/* remove connection */
 	case FC_RCTL_BA_ACC:	/* basic accept */
@@ -18476,6 +18475,7 @@ lpfc_fc_frame_check(struct lpfc_hba *phba, struct fc_frame_header *fc_hdr)
 		fc_vft_hdr = (struct fc_vft_header *)fc_hdr;
 		fc_hdr = &((struct fc_frame_header *)fc_vft_hdr)[1];
 		return lpfc_fc_frame_check(phba, fc_hdr);
+	case FC_RCTL_BA_NOP:	/* basic link service NOP */
 	default:
 		goto drop;
 	}
@@ -19288,12 +19288,14 @@ lpfc_sli4_send_seq_to_ulp(struct lpfc_vport *vport,
 	if (!lpfc_complete_unsol_iocb(phba,
 				      phba->sli4_hba.els_wq->pring,
 				      iocbq, fc_hdr->fh_r_ctl,
-				      fc_hdr->fh_type))
+				      fc_hdr->fh_type)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2540 Ring %d handler: unexpected Rctl "
 				"x%x Type x%x received\n",
 				LPFC_ELS_RING,
 				fc_hdr->fh_r_ctl, fc_hdr->fh_type);
+		lpfc_in_buf_free(phba, &seq_dmabuf->dbuf);
+	}
 
 	/* Free iocb created in lpfc_prep_seq */
 	list_for_each_entry_safe(curr_iocb, next_iocb,
-- 
2.35.1

