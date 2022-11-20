Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A47631604
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Nov 2022 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKTTtw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Nov 2022 14:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKTTtq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Nov 2022 14:49:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B862E9DD;
        Sun, 20 Nov 2022 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668973778;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H68GQeaf2XGUVFcEuy5695f5fl8n2LfBO8R3Gb9smTQ=;
    b=f0DR2aydrxHEQ2aA651xdyRRj61M0+voPKclCioCmGYikSlcuy/woryMYUA6eK/oUo
    fqNMNHg/D7L8R7YhDYfCJIsV9mj6xrQZQVjebiiMIZnURUj3HdhhIB+W6zMCJkojCOzJ
    0ZAYKOw/I9zvtO/BfJfzo4QdfSxKyj/HM1k0pjg80eP0MPcmqi+oZQ/3mv6OH7kJ3Nzk
    yZPdBFaCrT8yLOQAgjC3rBYDaLJXvMQo2Y5HT9nMCmshFS6dm+T54IbavGgHNpnSDOMj
    +4np8JGD0CDETYHLEMNZ8XNO84GrCt6l+1T01Ip+btNrnY67LMKH/f7/OfbEfoFRoi3J
    NG6w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIfZ/7Q8ZGqEBlwxF4QH61wYa9UK/y81Dg=="
X-RZG-CLASS-ID: mo01
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAKJncWNW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 20 Nov 2022 20:49:38 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] ufs: ufs_bsg: Remove unnecessary length checkup
Date:   Sun, 20 Nov 2022 20:49:25 +0100
Message-Id: <20221120194930.90283-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221120194930.90283-1-beanhuo@iokpp.de>
References: <20221120194930.90283-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Remove checks on job->request_len and job->reply_len because
The following msgcode checks will rule out malicious requests.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs_bsg.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index b99e3f3dc4ef..9ac8204f1ee6 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -30,21 +30,6 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 	return 0;
 }
 
-static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
-				     unsigned int request_len,
-				     unsigned int reply_len)
-{
-	int min_req_len = sizeof(struct ufs_bsg_request);
-	int min_rsp_len = sizeof(struct ufs_bsg_reply);
-
-	if (min_req_len > request_len || min_rsp_len > reply_len) {
-		dev_err(hba->dev, "not enough space assigned\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 				     uint8_t **desc_buff, int *desc_len,
 				     enum query_opcode desc_op)
@@ -88,8 +73,6 @@ static int ufs_bsg_request(struct bsg_job *job)
 	struct ufs_bsg_request *bsg_request = job->request;
 	struct ufs_bsg_reply *bsg_reply = job->reply;
 	struct ufs_hba *hba = shost_priv(dev_to_shost(job->dev->parent));
-	unsigned int req_len = job->request_len;
-	unsigned int reply_len = job->reply_len;
 	struct uic_command uc = {};
 	int msgcode;
 	uint8_t *desc_buff = NULL;
@@ -97,10 +80,6 @@ static int ufs_bsg_request(struct bsg_job *job)
 	enum query_opcode desc_op = UPIU_QUERY_OPCODE_NOP;
 	int ret;
 
-	ret = ufs_bsg_verify_query_size(hba, req_len, reply_len);
-	if (ret)
-		goto out;
-
 	bsg_reply->reply_payload_rcv_len = 0;
 
 	ufshcd_rpm_get_sync(hba);
-- 
2.25.1

