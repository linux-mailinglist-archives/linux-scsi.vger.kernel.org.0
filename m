Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51473365EF4
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhDTSCp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Apr 2021 14:02:45 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39270 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhDTSCk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 20 Apr 2021 14:02:40 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 161A29200BF; Tue, 20 Apr 2021 20:02:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 11AB69200BC;
        Tue, 20 Apr 2021 20:02:07 +0200 (CEST)
Date:   Tue, 20 Apr 2021 20:02:06 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Nix <nix@esperi.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] scsi: Set allocation length to 255 for ATA Information
 VPD page
In-Reply-To: <alpine.DEB.2.21.2104201934280.44318@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2104201952150.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104201934280.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set the allocation length to 255 for the ATA Information VPD page 
requested in the WRITE SAME handler, so as not to limit information 
examined by `scsi_get_vpd_page' in the supported vital product data 
pages unnecessarily.

Originally it was thought that Areca hardware may have issues with a 
valid allocation length supplied for a VPD inquiry, however older SCSI 
standard revisions[1] consider 255 the maximum length allowed and what 
has later become the high order byte is considered reserved and must be 
zero with the INQUIRY command.  Therefore it was unnecessary to reduce 
the amount of data requested from 512 as far down as to 64, arbitrarily 
chosen, and 255 would as well do.

With commit b3ae8780b429 ("[SCSI] Add EVPD page 0x83 and 0x80 to sysfs") 
we have since got the SCSI_VPD_PG_LEN macro, so use that instead.

References:

[1] "Information technology - Small Computer System Interface - 2",
    WORKING DRAFT, X3T9.2, Project 375D, Revision 10L, 7-SEP-93, Section
    8.2.5 "INQUIRY command", pp.104-108

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: af73623f5f10 ("[SCSI] sd: Reduce buffer size for vpd request")
---
No changes from v1.
---
 drivers/scsi/sd.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-macro-ide/drivers/scsi/sd.c
===================================================================
--- linux-macro-ide.orig/drivers/scsi/sd.c
+++ linux-macro-ide/drivers/scsi/sd.c
@@ -3076,16 +3076,13 @@ static void sd_read_write_same(struct sc
 	}
 
 	if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, INQUIRY) < 0) {
-		/* too large values might cause issues with arcmsr */
-		int vpd_buf_len = 64;
-
 		sdev->no_report_opcodes = 1;
 
 		/* Disable WRITE SAME if REPORT SUPPORTED OPERATION
 		 * CODES is unsupported and the device has an ATA
 		 * Information VPD page (SAT).
 		 */
-		if (!scsi_get_vpd_page(sdev, 0x89, buffer, vpd_buf_len))
+		if (!scsi_get_vpd_page(sdev, 0x89, buffer, SCSI_VPD_PG_LEN))
 			sdev->no_write_same = 1;
 	}
 
