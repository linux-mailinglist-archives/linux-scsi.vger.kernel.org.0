Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC097598EEC
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Aug 2022 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiHRVJh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Aug 2022 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346552AbiHRVJB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Aug 2022 17:09:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458FD8058
        for <linux-scsi@vger.kernel.org>; Thu, 18 Aug 2022 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=ZiEaQ3rq2K8UtxGRAAvuo4eqxmg
        TC79fZdy10l2+f1U=; b=Jc02JNR4r2dlq3qjOIJ+Rewxz+C4YGZbCOS4zz2boLr
        G0cQw/dGcNBpxGsgjYtTGxkFab3JaZId7EDtc15lcUxEej9oaL8osjvJwCLQWj+R
        hMN6pkJaKQJn1QHIKmtxPE8m06uAoBLidVhh89p0jaLjQifJ1odc5cYa9hhz0ZI0
        =
Received: (qmail 3961846 invoked from network); 18 Aug 2022 23:01:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2022 23:01:23 +0200
X-UD-Smtp-Session: l3s3148p1@MWKtSIrmqq4ucref
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Subject: [PATCH] xen: move from strlcpy with unused retval to strscpy
Date:   Thu, 18 Aug 2022 23:01:22 +0200
Message-Id: <20220818210122.7613-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Follow the advice of the below link and prefer 'strscpy' in this
subsystem. Conversion is 1:1 because the return value is not used.
Generated by a coccinelle script.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/xen/xen-scsiback.c                 | 2 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 7a0c93acc2c5..d3dcda344989 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1121,7 +1121,7 @@ static void scsiback_do_1lun_hotplug(struct vscsibk_info *info, int op,
 				"%s: writing %s", __func__, state);
 		return;
 	}
-	strlcpy(phy, val, VSCSI_NAMELEN);
+	strscpy(phy, val, VSCSI_NAMELEN);
 	kfree(val);
 
 	/* virtual SCSI device */
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 07b010a68fcf..f44d5a64351e 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -40,7 +40,7 @@ static int frontend_bus_id(char bus_id[XEN_BUS_ID_SIZE], const char *nodename)
 		return -EINVAL;
 	}
 
-	strlcpy(bus_id, nodename + 1, XEN_BUS_ID_SIZE);
+	strscpy(bus_id, nodename + 1, XEN_BUS_ID_SIZE);
 	if (!strchr(bus_id, '/')) {
 		pr_warn("bus_id %s no slash\n", bus_id);
 		return -EINVAL;
-- 
2.35.1

