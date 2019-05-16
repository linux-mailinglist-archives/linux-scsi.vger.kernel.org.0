Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4845B2108E
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 00:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEPWfs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 May 2019 18:35:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17910 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfEPWfs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 May 2019 18:35:48 -0400
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa4.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa4.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,477,1549954800"; 
   d="scan'208";a="33328245"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2019 15:35:47 -0700
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 May
 2019 17:35:45 -0500
Received: from [127.0.1.1] (10.238.32.34) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 May 2019 17:35:45 -0500
Subject: [PATCH] hpsa-correct-static-checker-issue-in-reset-handler
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Thu, 16 May 2019 17:35:45 -0500
Message-ID: <155804614564.4757.14771886984205910539.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- correct static checker issue in patch
  hpsa-correct-device-resets that is pending in
  Martin Peterson's 5.3/scsi-queue.

  The patch can be found here:
  https://www.spinics.net/lists/linux-scsi/msg130245.html

- Any chance this can be squashed into
  hpsa-correct-device-resets

Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 2db226a6931c..2b4b4f4ff9dc 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5956,7 +5956,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	int rc = SUCCESS;
 	int i;
 	struct ctlr_info *h;
-	struct hpsa_scsi_dev_t *dev;
+	struct hpsa_scsi_dev_t *dev = NULL;
 	u8 reset_type;
 	char msg[48];
 	unsigned long flags;

