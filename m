Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BDD3A2BE
	for <lists+linux-scsi@lfdr.de>; Sun,  9 Jun 2019 03:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFIB1H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 21:27:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59994 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbfFIB0o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 8 Jun 2019 21:26:44 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0344827E6E; Sat,  8 Jun 2019 21:26:42 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Joshua Thompson" <funaho@jurai.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Message-Id: <a0adfc4244ace4e4356a75346f50459a4b0a9b76.1560043151.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1560043151.git.fthain@telegraphics.com.au>
References: <cover.1560043151.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 6/7] scsi: mac_scsi: Enable PDMA on Mac IIfx
Date:   Sun, 09 Jun 2019 11:19:11 +1000
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add support for Apple's custom "SCSI DMA" chip. This patch doesn't make
use of its DMA capability. Just the PDMA capability is sufficient to
improve sequential read throughput by a factor of 5.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Joshua Thompson <funaho@jurai.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c  | 10 +++++++--
 drivers/scsi/mac_scsi.c | 47 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 39835ca5a474..611f73bfc87c 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -911,6 +911,10 @@ static const struct resource mac_scsi_iifx_rsrc[] __initconst = {
 		.flags = IORESOURCE_MEM,
 		.start = 0x50008000,
 		.end   = 0x50009FFF,
+	}, {
+		.flags = IORESOURCE_MEM,
+		.start = 0x50008000,
+		.end   = 0x50009FFF,
 	},
 };
 
@@ -1012,10 +1016,12 @@ int __init mac_platform_init(void)
 	case MAC_SCSI_IIFX:
 		/* Addresses from The Guide to Mac Family Hardware.
 		 * $5000 8000 - $5000 9FFF: SCSI DMA
+		 * $5000 A000 - $5000 BFFF: Alternate SCSI
 		 * $5000 C000 - $5000 DFFF: Alternate SCSI (DMA)
 		 * $5000 E000 - $5000 FFFF: Alternate SCSI (Hsk)
-		 * The SCSI DMA custom IC embeds the 53C80 core. mac_scsi does
-		 * not make use of its DMA or hardware handshaking logic.
+		 * The A/UX header file sys/uconfig.h says $50F0 8000.
+		 * The "SCSI DMA" custom IC embeds the 53C80 core and
+		 * supports Programmed IO, DMA and PDMA (hardware handshake).
 		 */
 		platform_device_register_simple("mac_scsi", 0,
 			mac_scsi_iifx_rsrc, ARRAY_SIZE(mac_scsi_iifx_rsrc));
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 27364b71e833..8fbec1768bbf 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -24,6 +24,7 @@
 
 #include <asm/hwtest.h>
 #include <asm/io.h>
+#include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/setup.h>
 
@@ -262,11 +263,22 @@ static inline int mac_pdma_send(unsigned char *start, void __iomem *io, int n)
 	return addr - start;
 }
 
+/* The "SCSI DMA" chip on the IIfx implements this register. */
+#define CTRL_REG                0x8
+#define CTRL_INTERRUPTS_ENABLE  BIT(1)
+#define CTRL_HANDSHAKE_MODE     BIT(3)
+
+static inline void write_ctrl_reg(struct NCR5380_hostdata *hostdata, u32 value)
+{
+	out_be32(hostdata->io + (CTRL_REG << 4), value);
+}
+
 static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
                                 unsigned char *dst, int len)
 {
 	u8 __iomem *s = hostdata->pdma_io + (INPUT_DATA_REG << 4);
 	unsigned char *d = dst;
+	int result = 0;
 
 	hostdata->pdma_residual = len;
 
@@ -275,6 +287,10 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
 	                              BASR_DRQ | BASR_PHASE_MATCH, HZ / 64)) {
 		int bytes;
 
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
+			                         CTRL_INTERRUPTS_ENABLE);
+
 		bytes = mac_pdma_recv(s, d, min(hostdata->pdma_residual, 512));
 
 		if (bytes > 0) {
@@ -283,7 +299,7 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
 		}
 
 		if (hostdata->pdma_residual == 0)
-			return 0;
+			goto out;
 
 		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
 		                           BUS_AND_STATUS_REG, BASR_ACK,
@@ -291,7 +307,7 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
 			scmd_printk(KERN_DEBUG, hostdata->connected,
 			            "%s: !REQ and !ACK\n", __func__);
 		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
-			return 0;
+			goto out;
 
 		if (bytes == 0)
 			udelay(MAC_PDMA_DELAY);
@@ -302,13 +318,18 @@ static inline int macscsi_pread(struct NCR5380_hostdata *hostdata,
 		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
 		         "%s: bus error (%d/%d)\n", __func__, d - dst, len);
 		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-		return -1;
+		result = -1;
+		goto out;
 	}
 
 	scmd_printk(KERN_ERR, hostdata->connected,
 	            "%s: phase mismatch or !DRQ\n", __func__);
 	NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-	return -1;
+	result = -1;
+out:
+	if (macintosh_config->ident == MAC_MODEL_IIFX)
+		write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
+	return result;
 }
 
 static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
@@ -316,6 +337,7 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 {
 	unsigned char *s = src;
 	u8 __iomem *d = hostdata->pdma_io + (OUTPUT_DATA_REG << 4);
+	int result = 0;
 
 	hostdata->pdma_residual = len;
 
@@ -324,6 +346,10 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 	                              BASR_DRQ | BASR_PHASE_MATCH, HZ / 64)) {
 		int bytes;
 
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			write_ctrl_reg(hostdata, CTRL_HANDSHAKE_MODE |
+			                         CTRL_INTERRUPTS_ENABLE);
+
 		bytes = mac_pdma_send(s, d, min(hostdata->pdma_residual, 512));
 
 		if (bytes > 0) {
@@ -337,7 +363,7 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 			                          TCR_LAST_BYTE_SENT, HZ / 64) < 0)
 				scmd_printk(KERN_ERR, hostdata->connected,
 				            "%s: Last Byte Sent timeout\n", __func__);
-			return 0;
+			goto out;
 		}
 
 		if (NCR5380_poll_politely2(hostdata, STATUS_REG, SR_REQ, SR_REQ,
@@ -346,7 +372,7 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 			scmd_printk(KERN_DEBUG, hostdata->connected,
 			            "%s: !REQ and !ACK\n", __func__);
 		if (!(NCR5380_read(BUS_AND_STATUS_REG) & BASR_PHASE_MATCH))
-			return 0;
+			goto out;
 
 		if (bytes == 0)
 			udelay(MAC_PDMA_DELAY);
@@ -357,13 +383,18 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 		dsprintk(NDEBUG_PSEUDO_DMA, hostdata->host,
 		         "%s: bus error (%d/%d)\n", __func__, s - src, len);
 		NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-		return -1;
+		result = -1;
+		goto out;
 	}
 
 	scmd_printk(KERN_ERR, hostdata->connected,
 	            "%s: phase mismatch or !DRQ\n", __func__);
 	NCR5380_dprint(NDEBUG_PSEUDO_DMA, hostdata->host);
-	return -1;
+	result = -1;
+out:
+	if (macintosh_config->ident == MAC_MODEL_IIFX)
+		write_ctrl_reg(hostdata, CTRL_INTERRUPTS_ENABLE);
+	return result;
 }
 
 static int macscsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
-- 
2.21.0

