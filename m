Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730B7874BA
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Aug 2023 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbjHXP45 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Aug 2023 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjHXP4c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Aug 2023 11:56:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B61996
        for <linux-scsi@vger.kernel.org>; Thu, 24 Aug 2023 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692892590; x=1724428590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YhYj+fHejWbjdHlrejxL/4PPisqGzgxG6VxY9uHpUUE=;
  b=P2hOLaqQjALOXCluck0objQEc4rXYFU4FPp270lZc0vprI5vhPV6UlRz
   3FcKGtRa2Me02TlVNdYuw3MpET05YGUobHRTee+36FEDGz0Qnsw4vl5nB
   Epe20gPRu7KJt9G6Iv3TOnezsZ+4XNFXXtZTuHbV9sl/We+W0OXrwx8qu
   rEaA5/bPQ8J9eG+sgGCVCKSTIJ3N/hvnrxPPflAZ2U36u/Yh+eohbNSJx
   801DdM7kVHQuNeZNvlDiU9McF08nnEFxLIKDePebYhHyFHRqmq34dNXsE
   ZdfEzZgGPg8eHx/Kp/4gbo9YNaTG4S22yjtSGzmhkIBPQVotLUgIwI6cU
   A==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1149059"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2023 08:56:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 24 Aug 2023 08:56:16 -0700
Received: from brunhilda.pdev.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 24 Aug 2023 08:56:15 -0700
From:   Don Brace <don.brace@microchip.com>
To:     <don.brace@microchip.com>, <Kevin.Barnett@microchip.com>,
        <scott.teel@microchip.com>, <Justin.Lindley@microchip.com>,
        <scott.benesh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <mike.mcgowen@microchip.com>,
        <murthy.bhat@microchip.com>, <kumar.meiyappan@microchip.com>,
        <jeremy.reeves@microchip.com>, <david.strahan@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 5/8] smartpqi: enhance shutdown notification
Date:   Thu, 24 Aug 2023 10:58:09 -0500
Message-ID: <20230824155812.789913-6-don.brace@microchip.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824155812.789913-1-don.brace@microchip.com>
References: <20230824155812.789913-1-don.brace@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: David Strahan <David.Strahan@microchip.com>

Provide more detailed information about cache flush errors
during shutdown.

Reviewed-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: David Strahan <David.Strahan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 999bed578138..aacb40cb6b79 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -9161,7 +9161,7 @@ static void pqi_shutdown(struct pci_dev *pci_dev)
 	rc = pqi_flush_cache(ctrl_info, shutdown_event);
 	if (rc)
 		dev_err(&pci_dev->dev,
-			"unable to flush controller cache\n");
+			"unable to flush controller cache during shutdown\n");
 
 	pqi_crash_if_pending_command(ctrl_info);
 	pqi_reset(ctrl_info);
-- 
2.42.0

