Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E266256A1A
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Aug 2020 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgH2U2S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 29 Aug 2020 16:28:18 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:47958 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgH2U2S (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 29 Aug 2020 16:28:18 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2020 16:28:17 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 062EB211BC47
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] scsi: fdomain_isa: merge branches in fdomain_isa_match()
Organization: Open Mobile Platform, LLC
Message-ID: <df68e341-5113-4cf2-b64c-dc1ad0b686ac@omprussia.ru>
Date:   Sat, 29 Aug 2020 23:19:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.133.185]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The *else* branch of the *if* (base) statement in fdomain_isa_match() is
immediately followed by the *if* (!base) statement. Simplify the code by
removing the unneeded *if*...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
The patch is against the 'for-next' branch of Martin Petersen's 'scsi.git'
repo...

 drivers/scsi/fdomain_isa.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: scsi/drivers/scsi/fdomain_isa.c
===================================================================
--- scsi.orig/drivers/scsi/fdomain_isa.c
+++ scsi/drivers/scsi/fdomain_isa.c
@@ -111,12 +111,11 @@ static int fdomain_isa_match(struct devi
 			base = readb(p + sig->base_offset) +
 			      (readb(p + sig->base_offset + 1) << 8);
 		iounmap(p);
-		if (base)
+		if (base) {
 			dev_info(dev, "BIOS at 0x%lx specifies I/O base 0x%x\n",
 				 bios_base, base);
-		else
+		} else { /* no I/O base in BIOS area */
 			dev_info(dev, "BIOS at 0x%lx\n", bios_base);
-		if (!base) {	/* no I/O base in BIOS area */
 			/* save BIOS signature for later use in port probing */
 			saved_sig = sig;
 			return 0;
