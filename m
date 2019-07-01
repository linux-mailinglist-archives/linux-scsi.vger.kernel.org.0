Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3142342840
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439517AbfFLN7H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 09:59:07 -0400
Received: from ns.iliad.fr ([212.27.33.1]:53546 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437126AbfFLN7H (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 09:59:07 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 7CF0420E10;
        Wed, 12 Jun 2019 15:59:05 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 6512720514;
        Wed, 12 Jun 2019 15:59:05 +0200 (CEST)
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
Message-ID: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
Date:   Wed, 12 Jun 2019 15:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Jun 12 15:59:05 2019 +0200 (CEST)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

According to the option's help message, SCSI_PROC_FS has been
superseded for ~15 years. Don't select it by default anymore.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/scsi/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 73bce9b6d037..8c95e9ad6470 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -54,14 +54,11 @@ config SCSI_NETLINK
 config SCSI_PROC_FS
 	bool "legacy /proc/scsi/ support"
 	depends on SCSI && PROC_FS
-	default y
 	---help---
 	  This option enables support for the various files in
 	  /proc/scsi.  In Linux 2.6 this has been superseded by
 	  files in sysfs but many legacy applications rely on this.
 
-	  If unsure say Y.
-
 comment "SCSI support type (disk, tape, CD-ROM)"
 	depends on SCSI
 
-- 
2.17.1
