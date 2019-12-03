Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E99110555
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Dec 2019 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLCTlO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Dec 2019 14:41:14 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40380 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfLCTlO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Dec 2019 14:41:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 538823F79C;
        Tue,  3 Dec 2019 20:31:10 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=jUDRzMDs;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hehyB8a_Sx59; Tue,  3 Dec 2019 20:31:09 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id A66153F4CF;
        Tue,  3 Dec 2019 20:31:08 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2375B362501;
        Tue,  3 Dec 2019 20:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575401468; bh=GgpXsnJVZPKyPe+h+0gIt+VQkmGTuW5nmRdMrtnMCT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUDRzMDsGPJvk0017GCqWL8w/RwWA/9L3q2eiH3OKffW6LTeyvYqK2UFvt561ftiN
         wasrY82tz2l++RDhSJKGJbIhKugSzN9YtRvhKCaaVEFsvvagkkJ+o/SZEyF3ve9iUe
         edTj+I5iYtmQCNd02pOlVcQTXfeGs3fZE13W2wOQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jim Gill <jgill@vmware.com>
Subject: [PATCH RESEND 2/2] scsi: vmw_pvscsi: Silence dma mapping errors
Date:   Tue,  3 Dec 2019 20:30:52 +0100
Message-Id: <20191203193052.7583-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203193052.7583-1-thomas_os@shipmail.org>
References: <20191203193052.7583-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

These errors typically occur with swiotlb when the swiotlb buffer is full.
But they are transient and would typically unnecessarily worry a user.
Instead of errors, print debug messages.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Jim Gill <jgill@vmware.com>
---
 drivers/scsi/vmw_pvscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 8a09d184a320..c3f010df641e 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -365,7 +365,7 @@ static int pvscsi_map_buffers(struct pvscsi_adapter *adapter,
 		int segs = scsi_dma_map(cmd);
 
 		if (segs == -ENOMEM) {
-			scmd_printk(KERN_ERR, cmd,
+			scmd_printk(KERN_DEBUG, cmd,
 				    "vmw_pvscsi: Failed to map cmd sglist for DMA.\n");
 			return -ENOMEM;
 		} else if (segs > 1) {
@@ -392,7 +392,7 @@ static int pvscsi_map_buffers(struct pvscsi_adapter *adapter,
 		ctx->dataPA = dma_map_single(&adapter->dev->dev, sg, bufflen,
 					     cmd->sc_data_direction);
 		if (dma_mapping_error(&adapter->dev->dev, ctx->dataPA)) {
-			scmd_printk(KERN_ERR, cmd,
+			scmd_printk(KERN_DEBUG, cmd,
 				    "vmw_pvscsi: Failed to map direct data buffer for DMA.\n");
 			return -ENOMEM;
 		}
@@ -725,7 +725,7 @@ static int pvscsi_queue_ring(struct pvscsi_adapter *adapter,
 				cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE,
 				DMA_FROM_DEVICE);
 		if (dma_mapping_error(&adapter->dev->dev, ctx->sensePA)) {
-			scmd_printk(KERN_ERR, cmd,
+			scmd_printk(KERN_DEBUG, cmd,
 				    "vmw_pvscsi: Failed to map sense buffer for DMA.\n");
 			ctx->sensePA = 0;
 			return -ENOMEM;
-- 
2.21.0

