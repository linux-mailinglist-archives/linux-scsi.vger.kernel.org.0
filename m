Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1CC5B5AA1
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Sep 2022 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiILMzn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Sep 2022 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiILMzY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Sep 2022 08:55:24 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82BD399F2;
        Mon, 12 Sep 2022 05:55:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5216457E76;
        Mon, 12 Sep 2022 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1662987310; x=1664801711; bh=fojJGlrbMpafdEpzUZ7GHIPhm
        83/A8ZLgn6a2a+qF3k=; b=cT0rZ7G5gDukGjRYTCjahjr7zGJr50G4GYiPBuvFZ
        CO4s20ZcfrVFv2XOmqew4fjxB/50T+/+2BJr2XP5C/LS7RNYYH6GmTbyKK0gOFAb
        W8KCaQKc614OCQhJtMh7fqoYJZmOC8yWC4gnNCLijimvxFunCua/hjs09pSlVUYk
        p4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w_PkirvhruDB; Mon, 12 Sep 2022 15:55:10 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2DA0957E9F;
        Mon, 12 Sep 2022 15:55:10 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 12 Sep 2022 15:55:10 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 12 Sep 2022 15:55:09 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        "Dmitry Bogdanov" <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v2] scsi: target: core: Set MULTIP bit for se_device with multiple ports
Date:   Mon, 12 Sep 2022 15:54:57 +0300
Message-ID: <20220912125457.22573-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912125457.22573-1-d.bogdanov@yadro.com>
References: <20220912125457.22573-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SAM-5 4.8.3 (SCSI target device with multiple SCSI ports structure)
obligates to set MULTIP bit when there's multiple SCSI target ports:

> Each device server shall indicate the presence of multiple SCSI target
> ports by setting the MULTIP bit to one in its standard INQUIRY data
> (see SPC-4).

The change sets MULTIP bit automatically to indicate the presence of
multiple SCSI target ports within standard inquiry response data if
there are multiple target ports in all target port groups of the
se_device.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
v2:
  use existing counter dev->export_count
---
 drivers/target/target_core_spc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index c14441c89bed..7cca3b15472b 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -115,6 +115,12 @@ spc_emulate_inquiry_std(struct se_cmd *cmd, unsigned char *buf)
 			buf[5] |= 0x1;
 	}
 
+	/*
+	 * Set MULTIP bit to indicate presence of multiple SCSI target ports
+	 */
+	if (dev->export_count > 1)
+		buf[6] |= 0x10;
+
 	buf[7] = 0x2; /* CmdQue=1 */
 
 	/*
-- 
2.25.1

