Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A8418207
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Sep 2021 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbhIYMs1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 Sep 2021 08:48:27 -0400
Received: from mx24.baidu.com ([111.206.215.185]:40376 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245193AbhIYMs1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 25 Sep 2021 08:48:27 -0400
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
        by Forcepoint Email with ESMTPS id 2CDDB6943D6882A028E3;
        Sat, 25 Sep 2021 20:46:51 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 25 Sep 2021 20:46:50 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 20:46:50 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: aic7xxx: Fix a function name in comments
Date:   Sat, 25 Sep 2021 20:46:44 +0800
Message-ID: <20210925124645.356-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use dma_alloc_coherent() instead of pci_alloc_consistent(),
because only dma_alloc_coherent() is called here.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/scsi/aic7xxx/aic79xx_osm.h | 2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index 35ec24f28d2c..08dbca690975 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -196,7 +196,7 @@ int	ahd_dmamap_unload(struct ahd_softc *, bus_dma_tag_t, bus_dmamap_t);
 /*
  * XXX
  * ahd_dmamap_sync is only used on buffers allocated with
- * the pci_alloc_consistent() API.  Although I'm not sure how
+ * the dma_alloc_consistent() API.  Although I'm not sure how
  * this works on architectures with a write buffer, Linux does
  * not have an API to sync "coherent" memory.  Perhaps we need
  * to do an mb()?
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 53240f53b654..bd9632a2f681 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -209,7 +209,7 @@ int	ahc_dmamap_unload(struct ahc_softc *, bus_dma_tag_t, bus_dmamap_t);
 /*
  * XXX
  * ahc_dmamap_sync is only used on buffers allocated with
- * the pci_alloc_consistent() API.  Although I'm not sure how
+ * the dma_alloc_consistent() API.  Although I'm not sure how
  * this works on architectures with a write buffer, Linux does
  * not have an API to sync "coherent" memory.  Perhaps we need
  * to do an mb()?
-- 
2.25.1

