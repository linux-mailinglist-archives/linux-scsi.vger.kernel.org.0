Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0917032180
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jun 2019 03:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFBB3K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 1 Jun 2019 21:29:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34636 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfFBB3J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 1 Jun 2019 21:29:09 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0698F27EC3; Sat,  1 Jun 2019 21:29:06 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-Id: <666248afffd5a75c3259f06737ddcfb2b833b1f7.1559438652.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1559438652.git.fthain@telegraphics.com.au>
References: <cover.1559438652.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/7] scsi: mac_scsi: Increase PIO/PDMA transfer length
 threshold
Date:   Sun, 02 Jun 2019 11:24:12 +1000
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some targets introduce delays when handshaking the response to certain
commands. For example, a disk may send a 96-byte response to an INQUIRY
command (or a 24-byte response to a MODE SENSE command) too slowly.

Apparently the first 12 or 14 bytes are handshaked okay but then the
system bus error timeout is reached while transferring the next word.

Since the scsi bus phase hasn't changed, the driver then sets the target
borken flag to prevent further PDMA transfers. The driver also logs the
warning, "switching to slow handshake".

Raise the PDMA threshold to 512 bytes so that PIO transfers will be used
for these commands. This default is sufficiently low that PDMA will still
be used for READ and WRITE commands.

The existing threshold (16 bytes) was chosen more or less at random.
However, best performance requires the threshold to be as low as possible.
Those systems that don't need the PIO workaround at all may benefit from
mac_scsi.setup_use_pdma=1

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 3a0f64bfa907 ("mac_scsi: Fix pseudo DMA implementation")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/mac_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 8b4b5b1a13d7..ba1afcaadae8 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -52,7 +52,7 @@ static int setup_cmd_per_lun = -1;
 module_param(setup_cmd_per_lun, int, 0);
 static int setup_sg_tablesize = -1;
 module_param(setup_sg_tablesize, int, 0);
-static int setup_use_pdma = -1;
+static int setup_use_pdma = 512;
 module_param(setup_use_pdma, int, 0);
 static int setup_hostid = -1;
 module_param(setup_hostid, int, 0);
@@ -305,7 +305,7 @@ static int macscsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
                                 struct scsi_cmnd *cmd)
 {
 	if (hostdata->flags & FLAG_NO_PSEUDO_DMA ||
-	    cmd->SCp.this_residual < 16)
+	    cmd->SCp.this_residual < setup_use_pdma)
 		return 0;
 
 	return cmd->SCp.this_residual;
-- 
2.21.0

