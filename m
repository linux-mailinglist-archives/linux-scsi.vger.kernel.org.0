Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180334EFFE
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhC3Rn6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 13:43:58 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:50558 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhC3Rna (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Mar 2021 13:43:30 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru D2D1C207D58E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v3 1/3] scsi: jazz_esp: add IRQ check
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
References: <137b9e4d-391f-3163-2e6f-9e21aeb6bf34@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <594aa9ae-2215-49f6-f73c-33bd38989912@omprussia.ru>
Date:   Tue, 30 Mar 2021 20:43:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <137b9e4d-391f-3163-2e6f-9e21aeb6bf34@omprussia.ru>
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
*unsigned* IRQ #), causing it to fail with -EINVAL, overriding the real
error code.  Stop  calling request_irq() with the invalid IRQ #s.

Fixes: 352e921f0dd4 ("[SCSI] jazz_esp: converted to use esp_core")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
Changes in version 2:
- clarified the description.

 drivers/scsi/jazz_esp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: scsi/drivers/scsi/jazz_esp.c
===================================================================
--- scsi.orig/drivers/scsi/jazz_esp.c
+++ scsi/drivers/scsi/jazz_esp.c
@@ -143,7 +143,9 @@ static int esp_jazz_probe(struct platfor
 	if (!esp->command_block)
 		goto fail_unmap_regs;
 
-	host->irq = platform_get_irq(dev, 0);
+	host->irq = err = platform_get_irq(dev, 0);
+	if (err < 0)
+		goto fail_unmap_command_block;
 	err = request_irq(host->irq, scsi_esp_intr, IRQF_SHARED, "ESP", esp);
 	if (err < 0)
 		goto fail_unmap_command_block;
