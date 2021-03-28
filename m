Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161A734BF3D
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Mar 2021 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhC1VS5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Mar 2021 17:18:57 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:60134 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1VSh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 28 Mar 2021 17:18:37 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru AC6BC2097869
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] scsi: sun3x_esp: add IRQ check
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <3e184b93-083a-bfe6-2d11-9c81203ec935@omprussia.ru>
Date:   Mon, 29 Mar 2021 00:10:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver neglects to check the result of platform_get_irq()'s call and
blithely passes the negative error codes to request_irq() (which takes
*unsigned* IRQ #), causing it to fail with -EINVAL, masking the actual
error code.  Propagate the negative IRQ error codes upstream instead.

Fixes: 0bb67f181834 ("[SCSI] sun3x_esp: convert to esp_scsi")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/scsi/sun3x_esp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: scsi/drivers/scsi/sun3x_esp.c
===================================================================
--- scsi.orig/drivers/scsi/sun3x_esp.c
+++ scsi/drivers/scsi/sun3x_esp.c
@@ -206,7 +206,9 @@ static int esp_sun3x_probe(struct platfo
 	if (!esp->command_block)
 		goto fail_unmap_regs_dma;
 
-	host->irq = platform_get_irq(dev, 0);
+	host->irq = err = platform_get_irq(dev, 0);
+	if (err < 0)
+		goto fail_unmap_command_block;
 	err = request_irq(host->irq, scsi_esp_intr, IRQF_SHARED,
 			  "SUN3X ESP", esp);
 	if (err < 0)
