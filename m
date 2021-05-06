Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0708375C45
	for <lists+linux-scsi@lfdr.de>; Thu,  6 May 2021 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhEFUdU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 May 2021 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhEFUdU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 May 2021 16:33:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A590C061574
        for <linux-scsi@vger.kernel.org>; Thu,  6 May 2021 13:32:21 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lekfS-0004Rp-6K; Thu, 06 May 2021 22:32:18 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lekfR-0004J2-1c; Thu, 06 May 2021 22:32:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] scsi: scsi_debug: Drop if with an always false condition
Date:   Thu,  6 May 2021 22:32:06 +0200
Message-Id: <20210506203206.254258-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-scsi@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

to_sdebug_host() is a container_of operation, so it never returns NULL.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/scsi_debug.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 70165be10f00..71ad30172ded 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7676,11 +7676,6 @@ static int sdebug_driver_remove(struct device *dev)
 
 	sdbg_host = to_sdebug_host(dev);
 
-	if (!sdbg_host) {
-		pr_err("Unable to locate host info\n");
-		return -ENODEV;
-	}
-
 	scsi_remove_host(sdbg_host->shost);
 
 	list_for_each_entry_safe(sdbg_devinfo, tmp, &sdbg_host->dev_info_list,

base-commit: 38182162b50aa4e970e5997df0a0c4288147a153
-- 
2.30.2

