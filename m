Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D870E791
	for <lists+linux-scsi@lfdr.de>; Tue, 23 May 2023 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjEWVls (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 May 2023 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjEWVlq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 May 2023 17:41:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA40FA
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 14:41:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f201a646so3829577b3.1
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684878104; x=1687470104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zFD/sWJ5X0Do7uK1EvSSeUTvJhq9b59SmXRDn2sIn4=;
        b=TjM3N2YQOZ1c6QUEWJ2gRFeAs13Q1W9t1jDZOdVrzBU6CbUqi7nHykV1m6JwcXHVJP
         5JWnTPKBI1VX76C5DYEhlVsMFIuz5LxoXP5IuEj3gCYjvlCjxityOZY23sT377bDYNzv
         zQ72uUFMHqWBjAEg3vu8biDuzrfuAusAdTRT71/hzPZDV8b55XErO+bgiw/uqgcrII9G
         skZ28g6UxTRxH6tOBABS2nFtvP0j6Yzh53KqL1x/YCA72JA6WXA0Ya8a2q9b/WZ2y1wV
         4xiJiJUN8pJEpwYwKgAf0Q+XU8MMKxd1CDDGWdXqcBHzxPfowQGH/4rjgHCvQCRmR6TI
         DlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878104; x=1687470104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zFD/sWJ5X0Do7uK1EvSSeUTvJhq9b59SmXRDn2sIn4=;
        b=gkPIhDFjmar6NNUUSUu9G7EQRjCyXHo7R8CAEUNhbRE+RAfcXvKq+pg1wniDJNGEcu
         ulcl+RbDkWclwyZyFm+XDdkoj0ov7JO8j+qRgCpqZ1JvXzoUEZdCAQnlx2i42WyzxlNC
         wl86namgkKjb2//VxKIT7JXfmX4xCwEcUgqPxly3PVKOXiHBDQu1oOqs+q12UdP5eJ3j
         KY7YK3cg2JJ2dPOLHhL+p5TGXYJC+8RL31xsWK054c86310ZsGiCFKyk/pn4gfiQGkSB
         rFZ/CyP+XVDy/idBKMewhpBpPREdPkSp2oXbFwlZio+uENwl28rqM0JyPllONNnzg1YY
         N57Q==
X-Gm-Message-State: AC+VfDxjqnW1ojuLEKjZ4O0JxRfHCuqv4Oc8BLZ4wMRZB+Z2zwqv+RMs
        HY1FvQg7eVvaJ5hdqsxwj71FydAnCopD9A==
X-Google-Smtp-Source: ACHHUZ5O+MF+h1p3utfJMCythPh6m4T4DvAAYW9sRJc3IBsXOEI6BvM7U9Pcvymsut/+66qg4gz2Whtf+mzhkA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a81:a704:0:b0:561:bf07:ee28 with SMTP id
 e4-20020a81a704000000b00561bf07ee28mr9728612ywh.5.1684878104664; Tue, 23 May
 2023 14:41:44 -0700 (PDT)
Date:   Tue, 23 May 2023 21:41:26 +0000
In-Reply-To: <20230523214127.4006891-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230523214127.4006891-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523214127.4006891-2-pranavpp@google.com>
Subject: [PATCH 1/2] scsi: pm80xx: Add fatal error check for pm8001_phy_control()
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Changyuan Lyu <changyuanl@google.com>

This patch adds a fatal error check for the pm8001_phy_control() function.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index e5673c774f66..b153f0966e5d 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -167,6 +167,16 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 	pm8001_ha = sas_phy->ha->lldd_ha;
 	phy = &pm8001_ha->phy[phy_id];
 	pm8001_ha->phy[phy_id].enable_completion = &completion;
+
+	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
+		/* If the controller is in fatal error state,
+		 *  we will not get a response from the controller
+		 */
+		pm8001_dbg(pm8001_ha, FAIL,
+				"Phy control failed due to fatal errors\n");
+		return -EFAULT;
+	}
+
 	switch (func) {
 	case PHY_FUNC_SET_LINK_RATE:
 		rates = funcdata;
-- 
2.40.1.698.g37aff9b760-goog

