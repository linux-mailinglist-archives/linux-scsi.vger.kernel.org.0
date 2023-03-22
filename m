Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34726C5580
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCVT66 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCVT6A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:58:00 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57D65054
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:40 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id z19so9877482plo.2
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nPdfaCBfymi9FswOaEhynsUU0AC84LnhTLDzofEm7g=;
        b=O9+vBiyp6cDzqbcpzGae5BbgYrdDs3k7Jd3zzuEtnfftrHPmDjPoxLBFG4fd//D4tt
         aOqiohThnEnFk39FbGaHr1KOU33hIW9gZHTB1U4W/lUfZSLwVyWcxJNkwpkD/QTTnzp4
         FJ0VExhkaCmrVLPDqqs+Zyel+Mv7/RNNJVcPYoR7kxbU0bfLU/m3jVEpoTlprJlalWMf
         fo5yjoF7DLF5kT0vXZEetTZaOT8W858jBTNkjEZnt/5HMm3nuNqRReyPqSpYe7oDNe0a
         GHbJYTZWb8cnMdnnYulyrsia6Hx5G18tEOs45fAfuycF17VMB0d9JeKD3T3X8/Rp6/ad
         1ecA==
X-Gm-Message-State: AO0yUKWR/2Hu7Pz2AcpVjkry/S40RxXoRLrXMyMq4AQba1wm5cKzCT+s
        P9y73/1tJKS8JT9mCBhg7JEoZxX752vy0g==
X-Google-Smtp-Source: AK7set/zv17aL0eCO6NgYzpjzNVEal44X/K5DaBZnxjNj23w3coi6JjgbWe9Kb2qdKM/kcaxT0ct3Q==
X-Received: by 2002:a17:90b:3881:b0:237:3dfb:9095 with SMTP id mu1-20020a17090b388100b002373dfb9095mr5166404pjb.6.1679515060228;
        Wed, 22 Mar 2023 12:57:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:57:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 44/80] scsi: ibmvfc: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:39 -0700
Message-Id: <20230322195515.1267197-45-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322195515.1267197-1-bvanassche@acm.org>
References: <20230322195515.1267197-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it explicit that the SCSI host template is not modified.

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 1a0c0b7289d2..ce9eb00e2ca0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3611,7 +3611,7 @@ static struct attribute *ibmvfc_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(ibmvfc_host);
 
-static struct scsi_host_template driver_template = {
+static const struct scsi_host_template driver_template = {
 	.module = THIS_MODULE,
 	.name = "IBM POWER Virtual FC Adapter",
 	.proc_name = IBMVFC_NAME,
