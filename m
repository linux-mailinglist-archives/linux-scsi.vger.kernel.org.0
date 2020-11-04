Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27B2A5F74
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Nov 2020 09:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKDIXh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Nov 2020 03:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIXg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Nov 2020 03:23:36 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4034C0613D3;
        Wed,  4 Nov 2020 00:23:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so648073pfm.13;
        Wed, 04 Nov 2020 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LIxDvdCNMHF1Sj6aH4WOZgFzcxoEZKzeDUYKQv5iNjE=;
        b=pQtkZjQrwE4VES6/btFNDa47w+ukqIxhvZdItdR3d8ee5SypOyaFV/l526mjA0B7V9
         ujiwxpslpTG2r9A2iXqWZuspfTrmmjOAZPLwxHletWlRxIEr3fyu82hegcv+SQa1ztt/
         Vdb+gnQz7G4KPEdxM/rGwvycGnQOTGxOSSlVuQj6ra9HTEjRd1eejB+kOY5M9iiYab6S
         jZTVstt6J9RA9cbOybCg8XcF1JpVZGuhQt9aOP1f/yq1jp745+eey2yxNkt2tPLxcthH
         JcvtddHgZP9poeHHc1qQRvo+ELncsuFB2y6PIiuDE1/iMy0t4q2SVOhHB4B+MDkqQ6TM
         dj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LIxDvdCNMHF1Sj6aH4WOZgFzcxoEZKzeDUYKQv5iNjE=;
        b=KNydf1IUGzm7tRsbhmI7mhG5vLpdtQ/NinUMX8PSChc8dHUYjZPKx3t45+OoTKBR3M
         HmDzJPnj7271IiOVZ3zTaCdlsVkgFp7oQ849+VjIjfkGSwT85hFbh+GzcGAHmIps886J
         qpxcsruoOGLuETZqaUW7Vg5byPYBPon+zRx1ZZJC6vFwYBP8E4Wgb2NnT3gSxMNB5mrL
         P/RgQXEZrESC8PF9S5e89VH1o7l1FwbIs1pTI1QF83KVdxa7mUCEAXfNrGlkKOpmuRmb
         Za81ix5nNmoFHT2f0Dg4mYZmAzH4dDJV52REFFEYW+nS6aU16PN/8n+uvsFR7bs5pC0n
         dgag==
X-Gm-Message-State: AOAM530Mm8pyb/njkJyhgU+uaxfu7aFtJKiDEpXPP8dNlcMpQskjmzmh
        PoeBh/Rgp6UfhQqz9WUxiiSA1HtdJezB
X-Google-Smtp-Source: ABdhPJz/dEgMEa2Lp3rTfidUTC65OsSFHyp1DN5R83ioue5mNBKtNeBwGNjFY78i+D03RdhehZ7mBA==
X-Received: by 2002:a17:90a:134b:: with SMTP id y11mr3149894pjf.182.1604478216419;
        Wed, 04 Nov 2020 00:23:36 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id z3sm1546854pfk.159.2020.11.04.00.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 00:23:35 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        aeasi@marvell.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] scsi: qla2xxx: use the dma_pool_zalloc() instead of dma_pool_alloc/memset
Date:   Wed,  4 Nov 2020 16:23:22 +0800
Message-Id: <1604478202-23750-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Here we could use the dma_pool_zalloc() function instead of
dma_pool_alloc/memset.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index f9c8ae9d669e..cea78d762731 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4226,11 +4226,10 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 
 	/* Get consistent memory allocated for Special Features-CB. */
 	if (IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
-		ha->sf_init_cb = dma_pool_alloc(ha->s_dma_pool, GFP_KERNEL,
+		ha->sf_init_cb = dma_pool_zalloc(ha->s_dma_pool, GFP_KERNEL,
 						&ha->sf_init_cb_dma);
 		if (!ha->sf_init_cb)
 			goto fail_sf_init_cb;
-		memset(ha->sf_init_cb, 0, sizeof(struct init_sf_cb));
 		ql_dbg_pci(ql_dbg_init, ha->pdev, 0x0199,
 			   "sf_init_cb=%p.\n", ha->sf_init_cb);
 	}
-- 
2.20.0

