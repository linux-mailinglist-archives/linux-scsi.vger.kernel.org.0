Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC187E1B1
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfHAR51 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:27 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:35019 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbfHAR50 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:26 -0400
Received: by mail-pf1-f171.google.com with SMTP id u14so34524745pfn.2
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUoj7BqoDJSsYwir9qnnHL1JVLCaqRZa6L4SFKUjUlI=;
        b=ck9b4Ycrb4UPHLSlTNiilL0PMkkGq7a8Fi4Zw+R9vuRIENArVTjAe0ZxVAHCdJ4GYx
         Bant3Zl2nuT9NPJ3BBoWCpsBbgEcT2AOsqcOdEOpGEUhTF9BfZOFpLxb9xaIWbdgdtBc
         6aeEoeu8OyPMeusNrfJpOPaKQVcrLSzixwuv5woy+Ub4flh+xviFfz0G+2+W2Lj/I3Ba
         xHxATfRVT+CZMyKcuQrX94G6K5yeCYLjfw5svhmnzZnFzbB87Dc08Rmwac8cNztfHVvo
         e3taehvacFTT2qByk0QU544zR+JRzyeuH2pSvUg0EpN/NS2cKlRW8hYKshM9YeS0XeIq
         ZM4g==
X-Gm-Message-State: APjAAAVWPvy7VvStK8ypYU4aSNbWkXEikAQmkV5WzwG6d2d881hI2Gwz
        njUtMTDb5IP/D3xDzyvRgwI=
X-Google-Smtp-Source: APXvYqwUKk8PO280DQHocNkf5Th8wNpgyU6/IS4QK35wD7c2oz64vcHalz7uLHCvO9TeL3mQOdYZUA==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr63867500pgk.209.1564682245779;
        Thu, 01 Aug 2019 10:57:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 47/59] qla2xxx: Modify NVMe include directives
Date:   Thu,  1 Aug 2019 10:56:02 -0700
Message-Id: <20190801175614.73655-48-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since struct sg_table is used in nvme-fc-driver.h, include
<linux/scatterlist.h> from that header file.

Since no definitions or declarations from <linux/blk-mq.h> are used in
the qla_nvme.h header file, do not include <linux/blk-mq.h> from that
header file.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_nvme.h | 1 -
 include/linux/nvme-fc-driver.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index 25a2b82d5095..ef912902d4e5 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -7,7 +7,6 @@
 #ifndef __QLA_NVME_H
 #define __QLA_NVME_H
 
-#include <linux/blk-mq.h>
 #include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
 #include <linux/nvme-fc-driver.h>
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 98d904961b33..10f81629b9ce 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -6,6 +6,8 @@
 #ifndef _NVME_FC_DRIVER_H
 #define _NVME_FC_DRIVER_H 1
 
+#include <linux/scatterlist.h>
+
 
 /*
  * **********************  LLDD FC-NVME Host API ********************
-- 
2.22.0.770.g0f2c4a37fd-goog

