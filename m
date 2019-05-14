Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9871CDDF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfENRXW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 13:23:22 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:41764 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfENRXS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 13:23:18 -0400
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 930237A03F5;
        Tue, 14 May 2019 19:23:16 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] fdomain: Resurrect driver (core)
Date:   Tue, 14 May 2019 19:23:07 +0200
Message-Id: <20190514172309.12874-2-linux@zary.sk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514172309.12874-1-linux@zary.sk>
References: <20190514172309.12874-1-linux@zary.sk>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Future Domain TMC-16xx/TMC-3260 SCSI driver.

This is the core driver, common for PCI, ISA and PCMCIA cards.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/Kconfig   |   4 +
 drivers/scsi/Makefile  |   1 +
 drivers/scsi/fdomain.c | 586 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/fdomain.h |  53 +++++
 4 files changed, 644 insertions(+)
 create mode 100644 drivers/scsi/fdomain.c
 create mode 100644 drivers/scsi/fdomain.h

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index d528018e6fa8..3d6b1f47cbb5 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -663,6 +663,10 @@ config SCSI_DMX3191D
 	  To compile this driver as a module, choose M here: the
 	  module will be called dmx3191d.
 
+config SCSI_FDOMAIN
+	tristate
+	depends on SCSI
+
 config SCSI_GDTH
 	tristate "Intel/ICP (former GDT SCSI Disk Array) RAID Controller support"
 	depends on PCI && SCSI
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 8826111fdf4a..b8fbc6d2de54 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_SCSI_AIC94XX)	+= aic94xx/
 obj-$(CONFIG_SCSI_PM8001)	+= pm8001/
 obj-$(CONFIG_SCSI_ISCI)		+= isci/
 obj-$(CONFIG_SCSI_IPS)		+= ips.o
+obj-$(CONFIG_SCSI_FDOMAIN)	+= fdomain.o
 obj-$(CONFIG_SCSI_GENERIC_NCR5380) += g_NCR5380.o
 obj-$(CONFIG_SCSI_QLOGIC_FAS)	+= qlogicfas408.o	qlogicfas.o
 obj-$(CONFIG_PCMCIA_QLOGIC)	+= qlogicfas408.o
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
new file mode 100644
index 000000000000..19af1ae608df
--- /dev/null
+++ b/drivers/scsi/fdomain.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Future Domain TMC-16x0 and TMC-3260 SCSI host adapters
+ * Copyright 2019 Ondrej Zary
+ *
+ * Original driver by
+ * Rickard E. Faith, faith@cs.unc.edu
+ *
+ * Future Domain BIOS versions supported for autodetect:
+ *    2.0, 3.0, 3.2, 3.4 (1.0), 3.5 (2.0), 3.6, 3.61
+ * Chips supported:
+ *    TMC-1800, TMC-18C50, TMC-18C30, TMC-36C70
+ * Boards supported:
+ *    Future Domain TMC-1650, TMC-1660, TMC-1670, TMC-1680, TMC-1610M/MER/MEX
+ *    Future Domain TMC-3260 (PCI)
+ *    Quantum ISA-200S, ISA-250MG
+ *    Adaptec AHA-2920A (PCI) [BUT *NOT* AHA-2920C -- use aic7xxx instead]
+ *    IBM ?
+ *
+ * NOTE:
+ *
+ * The Adaptec AHA-2920C has an Adaptec AIC-7850 chip on it.
+ * Use the aic7xxx driver for this board.
+ *
+ * The Adaptec AHA-2920A has a Future Domain chip on it, so this is the right
+ * driver for that card.  Unfortunately, the boxes will probably just say
+ * "2920", so you'll have to look on the card for a Future Domain logo, or a
+ * letter after the 2920.
+ *
+ * If you have a TMC-8xx or TMC-9xx board, then this is not the driver for
+ * your board.
+ *
+ * DESCRIPTION:
+ *
+ * This is the Linux low-level SCSI driver for Future Domain TMC-1660/1680
+ * TMC-1650/1670, and TMC-3260 SCSI host adapters.  The 1650 and 1670 have a
+ * 25-pin external connector, whereas the 1660 and 1680 have a SCSI-2 50-pin
+ * high-density external connector.  The 1670 and 1680 have floppy disk
+ * controllers built in.  The TMC-3260 is a PCI bus card.
+ *
+ * Future Domain's older boards are based on the TMC-1800 chip, and this
+ * driver was originally written for a TMC-1680 board with the TMC-1800 chip.
+ * More recently, boards are being produced with the TMC-18C50 and TMC-18C30
+ * chips.
+ *
+ * Please note that the drive ordering that Future Domain implemented in BIOS
+ * versions 3.4 and 3.5 is the opposite of the order (currently) used by the
+ * rest of the SCSI industry.
+ *
+ *
+ * REFERENCES USED:
+ *
+ * "TMC-1800 SCSI Chip Specification (FDC-1800T)", Future Domain Corporation,
+ * 1990.
+ *
+ * "Technical Reference Manual: 18C50 SCSI Host Adapter Chip", Future Domain
+ * Corporation, January 1992.
+ *
+ * "LXT SCSI Products: Specifications and OEM Technical Manual (Revision
+ * B/September 1991)", Maxtor Corporation, 1991.
+ *
+ * "7213S product Manual (Revision P3)", Maxtor Corporation, 1992.
+ *
+ * "Draft Proposed American National Standard: Small Computer System
+ * Interface - 2 (SCSI-2)", Global Engineering Documents. (X3T9.2/86-109,
+ * revision 10h, October 17, 1991)
+ *
+ * Private communications, Drew Eckhardt (drew@cs.colorado.edu) and Eric
+ * Youngdale (ericy@cais.com), 1992.
+ *
+ * Private communication, Tuong Le (Future Domain Engineering department),
+ * 1994. (Disk geometry computations for Future Domain BIOS version 3.4, and
+ * TMC-18C30 detection.)
+ *
+ * Hogan, Thom. The Programmer's PC Sourcebook. Microsoft Press, 1988. Page
+ * 60 (2.39: Disk Partition Table Layout).
+ *
+ * "18C30 Technical Reference Manual", Future Domain Corporation, 1993, page
+ * 6-1.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/workqueue.h>
+#include <scsi/scsicam.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+#include "fdomain.h"
+
+/*
+ * FIFO_COUNT: The host adapter has an 8K cache (host adapters based on the
+ * 18C30 chip have a 2k cache).  When this many 512 byte blocks are filled by
+ * the SCSI device, an interrupt will be raised.  Therefore, this could be as
+ * low as 0, or as high as 16.  Note, however, that values which are too high
+ * or too low seem to prevent any interrupts from occurring, and thereby lock
+ * up the machine.
+ */
+#define FIFO_COUNT	2	/* Number of 512 byte blocks before INTR */
+#define PARITY_MASK	0x08	/* Parity enabled, 0x00 = disabled */
+
+enum chip_type {
+	unknown		= 0x00,
+	tmc1800		= 0x01,
+	tmc18c50	= 0x02,
+	tmc18c30	= 0x03,
+};
+
+struct fdomain {
+	int base;
+	struct scsi_cmnd *cur_cmd;
+	enum chip_type chip;
+	struct work_struct work;
+};
+
+static inline void fdomain_make_bus_idle(struct fdomain *fd)
+{
+	outb(0, fd->base + SCSI_Cntl);
+	outb(0, fd->base + SCSI_Mode_Cntl);
+	if (fd->chip == tmc18c50 || fd->chip == tmc18c30)
+		/* Clear forced intr. */
+		outb(0x21 | PARITY_MASK, fd->base + TMC_Cntl);
+	else
+		outb(0x01 | PARITY_MASK, fd->base + TMC_Cntl);
+}
+
+static enum chip_type fdomain_identify(int port)
+{
+	u16 id = inb(port + LSB_ID_Code) | inb(port + MSB_ID_Code) << 8;
+
+	switch (id) {
+	case 0x6127:
+		return tmc1800;
+	case 0x60e9: /* 18c50 or 18c30 */
+		break;
+	default:
+		return unknown;
+	}
+
+	/* Try to toggle 32-bit mode. This only works on an 18c30 chip. */
+	outb(0x80, port + IO_Control);
+	if ((inb(port + Configuration2) & 0x80) == 0x80) {
+		outb(0x00, port + IO_Control);
+		if ((inb(port + Configuration2) & 0x80) == 0x00)
+			return tmc18c30;
+	}
+	/* If that failed, we are an 18c50. */
+	return tmc18c50;
+}
+
+static int fdomain_test_loopback(int base)
+{
+	int i;
+
+	for (i = 0; i < 255; i++) {
+		outb(i, base + Write_Loopback);
+		if (inb(base + Read_Loopback) != i)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void fdomain_reset(int base)
+{
+	outb(1, base + SCSI_Cntl);
+	mdelay(20);
+	outb(0, base + SCSI_Cntl);
+	mdelay(1150);
+	outb(0, base + SCSI_Mode_Cntl);
+	outb(PARITY_MASK, base + TMC_Cntl);
+}
+
+static int fdomain_select(struct Scsi_Host *sh, int target)
+{
+	int status;
+	unsigned long timeout;
+	struct fdomain *fd = shost_priv(sh);
+
+	outb(0x82, fd->base + SCSI_Cntl); /* Bus Enable + Select */
+	outb(BIT(sh->this_id) | BIT(target), fd->base + SCSI_Data_NoACK);
+
+	/* Stop arbitration and enable parity */
+	outb(PARITY_MASK, fd->base + TMC_Cntl);
+
+	timeout = 350;	/* 350 msec */
+
+	do {
+		status = inb(fd->base + SCSI_Status); /* Read adapter status */
+		if (status & 1) {	/* Busy asserted */
+			/* Enable SCSI Bus */
+			/* (on error, should make bus idle with 0) */
+			outb(0x80, fd->base + SCSI_Cntl);
+			return 0;
+		}
+		mdelay(1);
+	} while (--timeout);
+	fdomain_make_bus_idle(fd);
+	return 1;
+}
+
+static void fdomain_finish_cmd(struct fdomain *fd, int result)
+{
+	outb(0x00, fd->base + Interrupt_Cntl);
+	fdomain_make_bus_idle(fd);
+	fd->cur_cmd->result = result;
+	fd->cur_cmd->scsi_done(fd->cur_cmd);
+	fd->cur_cmd = NULL;
+}
+
+static void fdomain_read_data(struct scsi_cmnd *cmd)
+{
+	struct fdomain *fd = shost_priv(cmd->device->host);
+	unsigned char *virt, *ptr;
+	size_t offset, len;
+
+	while ((len = inw(fd->base + FIFO_Data_Count)) > 0) {
+		offset = scsi_bufflen(cmd) - scsi_get_resid(cmd);
+		virt = scsi_kmap_atomic_sg(scsi_sglist(cmd), scsi_sg_count(cmd),
+					   &offset, &len);
+		ptr = virt + offset;
+		if (len & 1)
+			*ptr++ = inb(fd->base + Read_FIFO);
+		if (len > 1)
+			insw(fd->base + Read_FIFO, ptr, len >> 1);
+		scsi_set_resid(cmd, scsi_get_resid(cmd) - len);
+		scsi_kunmap_atomic_sg(virt);
+	}
+}
+
+static void fdomain_write_data(struct scsi_cmnd *cmd)
+{
+	struct fdomain *fd = shost_priv(cmd->device->host);
+	/* 8k FIFO for pre-tmc18c30 chips, 2k FIFO for tmc18c30 */
+	int FIFO_Size = fd->chip == tmc18c30 ? 0x800 : 0x2000;
+	unsigned char *virt, *ptr;
+	size_t offset, len;
+
+	while ((len = FIFO_Size - inw(fd->base + FIFO_Data_Count)) > 512) {
+		offset = scsi_bufflen(cmd) - scsi_get_resid(cmd);
+		if (len + offset > scsi_bufflen(cmd)) {
+			len = scsi_bufflen(cmd) - offset;
+			if (len == 0)
+				break;
+		}
+		virt = scsi_kmap_atomic_sg(scsi_sglist(cmd), scsi_sg_count(cmd),
+					   &offset, &len);
+		ptr = virt + offset;
+		if (len & 1)
+			outb(*ptr++, fd->base + Write_FIFO);
+		if (len > 1)
+			outsw(fd->base + Write_FIFO, ptr, len >> 1);
+		scsi_set_resid(cmd, scsi_get_resid(cmd) - len);
+		scsi_kunmap_atomic_sg(virt);
+	}
+}
+
+static void fdomain_work(struct work_struct *work)
+{
+	struct fdomain *fd = container_of(work, struct fdomain, work);
+	struct Scsi_Host *sh = container_of((void *)fd, struct Scsi_Host,
+					    hostdata);
+	struct scsi_cmnd *cmd = fd->cur_cmd;
+	unsigned long flags;
+	int status;
+	int done = 0;
+
+	spin_lock_irqsave(sh->host_lock, flags);
+
+	if (cmd->SCp.phase & in_arbitration) {
+		status = inb(fd->base + TMC_Status);
+		if (!(status & 0x02)) {
+			fdomain_finish_cmd(fd, DID_BUS_BUSY << 16);
+			goto out;
+		}
+		cmd->SCp.phase = in_selection;
+
+		outb(0x40 | FIFO_COUNT, fd->base + Interrupt_Cntl);
+		outb(0x82, fd->base + SCSI_Cntl); /* Bus Enable + Select */
+		outb(BIT(cmd->device->host->this_id) |
+		     BIT(scmd_id(cmd)), fd->base + SCSI_Data_NoACK);
+		/* Stop arbitration and enable parity */
+		outb(0x10 | PARITY_MASK, fd->base + TMC_Cntl);
+		goto out;
+	} else if (cmd->SCp.phase & in_selection) {
+		status = inb(fd->base + SCSI_Status);
+		if (!(status & 0x01)) {
+			/* Try again, for slow devices */
+			if (fdomain_select(cmd->device->host, scmd_id(cmd))) {
+				fdomain_finish_cmd(fd, DID_NO_CONNECT << 16);
+				goto out;
+			}
+			/* Stop arbitration and enable parity */
+			outb(0x10 | PARITY_MASK, fd->base + TMC_Cntl);
+		}
+		cmd->SCp.phase = in_other;
+		outb(0x90 | FIFO_COUNT, fd->base + Interrupt_Cntl);
+		outb(0x80, fd->base + SCSI_Cntl);
+		goto out;
+	}
+
+	/* cur_cmd->SCp.phase == in_other: this is the body of the routine */
+	status = inb(fd->base + SCSI_Status);
+
+	if (status & 0x10) {	/* REQ */
+		switch (status & 0x0e) {
+		case 0x08:	/* COMMAND OUT */
+			outb(cmd->cmnd[cmd->SCp.sent_command++],
+			     fd->base + Write_SCSI_Data);
+			break;
+		case 0x00:	/* DATA OUT -- tmc18c50/tmc18c30 only */
+			if (fd->chip != tmc1800 && !cmd->SCp.have_data_in) {
+				cmd->SCp.have_data_in = -1;
+				outb(0xd0 | PARITY_MASK, fd->base + TMC_Cntl);
+			}
+			break;
+		case 0x04:	/* DATA IN -- tmc18c50/tmc18c30 only */
+			if (fd->chip != tmc1800 && !cmd->SCp.have_data_in) {
+				cmd->SCp.have_data_in = 1;
+				outb(0x90 | PARITY_MASK, fd->base + TMC_Cntl);
+			}
+			break;
+		case 0x0c:	/* STATUS IN */
+			cmd->SCp.Status = inb(fd->base + Read_SCSI_Data);
+			break;
+		case 0x0a:	/* MESSAGE OUT */
+			outb(MESSAGE_REJECT, fd->base + Write_SCSI_Data);
+			break;
+		case 0x0e:	/* MESSAGE IN */
+			cmd->SCp.Message = inb(fd->base + Read_SCSI_Data);
+			if (!cmd->SCp.Message)
+				++done;
+			break;
+		}
+	}
+
+	if (fd->chip == tmc1800 && !cmd->SCp.have_data_in &&
+	    cmd->SCp.sent_command >= cmd->cmd_len) {
+		if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+			cmd->SCp.have_data_in = -1;
+			outb(0xd0 | PARITY_MASK, fd->base + TMC_Cntl);
+		} else {
+			cmd->SCp.have_data_in = 1;
+			outb(0x90 | PARITY_MASK, fd->base + TMC_Cntl);
+		}
+	}
+
+	if (cmd->SCp.have_data_in == -1) /* DATA OUT */
+		fdomain_write_data(cmd);
+
+	if (cmd->SCp.have_data_in == 1) /* DATA IN */
+		fdomain_read_data(cmd);
+
+	if (done) {
+		fdomain_finish_cmd(fd, (cmd->SCp.Status & 0xff) |
+				   ((cmd->SCp.Message & 0xff) << 8) |
+				   (DID_OK << 16));
+	} else {
+		if (cmd->SCp.phase & disconnect) {
+			outb(0xd0 | FIFO_COUNT, fd->base + Interrupt_Cntl);
+			outb(0x00, fd->base + SCSI_Cntl);
+		} else
+			outb(0x90 | FIFO_COUNT, fd->base + Interrupt_Cntl);
+	}
+out:
+	spin_unlock_irqrestore(sh->host_lock, flags);
+}
+
+static irqreturn_t fdomain_irq(int irq, void *dev_id)
+{
+	struct fdomain *fd = dev_id;
+
+	/* Is it our IRQ? */
+	if ((inb(fd->base + TMC_Status) & 0x01) == 0)
+		return IRQ_NONE;
+
+	outb(0x00, fd->base + Interrupt_Cntl);
+
+	/* We usually have one spurious interrupt after each command. */
+	if (!fd->cur_cmd)	/* Spurious interrupt */
+		return IRQ_NONE;
+
+	schedule_work(&fd->work);
+
+	return IRQ_HANDLED;
+}
+
+static int fdomain_queue(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
+{
+	struct fdomain *fd = shost_priv(cmd->device->host);
+	unsigned long flags;
+
+	cmd->SCp.Status		= 0;
+	cmd->SCp.Message	= 0;
+	cmd->SCp.have_data_in	= 0;
+	cmd->SCp.sent_command	= 0;
+	cmd->SCp.phase		= in_arbitration;
+	scsi_set_resid(cmd, scsi_bufflen(cmd));
+
+	spin_lock_irqsave(sh->host_lock, flags);
+
+	fd->cur_cmd = cmd;
+
+	fdomain_make_bus_idle(fd);
+
+	/* Start arbitration */
+	outb(0x00, fd->base + Interrupt_Cntl);
+	outb(0x00, fd->base + SCSI_Cntl);	/* Disable data drivers */
+	outb(BIT(cmd->device->host->this_id),
+	     fd->base + SCSI_Data_NoACK);	/* Set our id bit */
+	outb(0x20, fd->base + Interrupt_Cntl);
+	outb(0x14 | PARITY_MASK, fd->base + TMC_Cntl);	/* Start arbitration */
+
+	spin_unlock_irqrestore(sh->host_lock, flags);
+
+	return 0;
+}
+
+static int fdomain_abort(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *sh = cmd->device->host;
+	struct fdomain *fd = shost_priv(sh);
+	unsigned long flags;
+
+	if (!fd->cur_cmd)
+		return FAILED;
+
+	spin_lock_irqsave(sh->host_lock, flags);
+
+	fdomain_make_bus_idle(fd);
+	fd->cur_cmd->SCp.phase |= aborted;
+	fd->cur_cmd->result = DID_ABORT << 16;
+
+	/* Aborts are not done well. . . */
+	fdomain_finish_cmd(fd, DID_ABORT << 16);
+	spin_unlock_irqrestore(sh->host_lock, flags);
+	return SUCCESS;
+}
+
+static int fdomain_host_reset(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *sh = cmd->device->host;
+	struct fdomain *fd = shost_priv(sh);
+	unsigned long flags;
+
+	spin_lock_irqsave(sh->host_lock, flags);
+	fdomain_reset(fd->base);
+	spin_unlock_irqrestore(sh->host_lock, flags);
+	return SUCCESS;
+}
+
+static int fdomain_biosparam(struct scsi_device *sdev,
+			     struct block_device *bdev,	sector_t capacity,
+			     int geom[])
+{
+	unsigned char *p = scsi_bios_ptable(bdev);
+
+	if (p && p[65] == 0xaa && p[64] == 0x55 /* Partition table valid */
+	    && p[4]) {	 /* Partition type */
+		geom[0] = p[5] + 1;	/* heads */
+		geom[1] = p[6] & 0x3f;	/* sectors */
+	} else {
+		if (capacity >= 0x7e0000) {
+			geom[0] = 255;	/* heads */
+			geom[1] = 63;	/* sectors */
+		} else if (capacity >= 0x200000) {
+			geom[0] = 128;	/* heads */
+			geom[1] = 63;	/* sectors */
+		} else {
+			geom[0] = 64;	/* heads */
+			geom[1] = 32;	/* sectors */
+		}
+	}
+	geom[2] = sector_div(capacity, geom[0] * geom[1]);
+	kfree(p);
+
+	return 0;
+}
+
+static struct scsi_host_template fdomain_template = {
+	.module			= THIS_MODULE,
+	.name			= "Future Domain TMC-16x0",
+	.proc_name		= "fdomain",
+	.queuecommand		= fdomain_queue,
+	.eh_abort_handler	= fdomain_abort,
+	.eh_host_reset_handler	= fdomain_host_reset,
+	.bios_param		= fdomain_biosparam,
+	.can_queue		= 1,
+	.this_id		= 7,
+	.sg_tablesize		= 64,
+	.dma_boundary		= PAGE_SIZE - 1,
+};
+
+struct Scsi_Host *fdomain_create(int base, int irq, int this_id,
+				 struct device *dev)
+{
+	struct Scsi_Host *sh;
+	struct fdomain *fd;
+	enum chip_type chip;
+	static const char * const chip_names[] = {
+		"Unknown", "TMC-1800", "TMC-18C50", "TMC-18C30"
+	};
+
+	chip = fdomain_identify(base);
+	if (!chip)
+		return NULL;
+
+	fdomain_reset(base);
+
+	if (fdomain_test_loopback(base))
+		return NULL;
+
+	if (!irq) {
+		dev_err(dev, "card has no IRQ assigned");
+		return NULL;
+	}
+
+	sh = scsi_host_alloc(&fdomain_template, sizeof(struct fdomain));
+	if (!sh)
+		return NULL;
+
+	if (this_id)
+		sh->this_id = this_id & 0x07;
+
+	sh->irq = irq;
+	sh->io_port = base;
+	sh->n_io_port = FDOMAIN_REGION_SIZE;
+
+	fd = shost_priv(sh);
+	fd->base = base;
+	fd->chip = chip;
+	INIT_WORK(&fd->work, fdomain_work);
+
+	if (request_irq(irq, fdomain_irq, dev_is_pci(dev) ? IRQF_SHARED : 0,
+			  "fdomain", fd))
+		goto fail_put;
+
+	shost_printk(KERN_INFO, sh, "%s chip at 0x%x irq %d SCSI ID %d\n",
+		     dev_is_pci(dev) ? "TMC-36C70 (PCI bus)" : chip_names[chip],
+		     base, irq, sh->this_id);
+
+	if (scsi_add_host(sh, dev))
+		goto fail_free_irq;
+
+	scsi_scan_host(sh);
+
+	return sh;
+
+fail_free_irq:
+	free_irq(irq, fd);
+fail_put:
+	scsi_host_put(sh);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fdomain_create);
+
+int fdomain_destroy(struct Scsi_Host *sh)
+{
+	struct fdomain *fd = shost_priv(sh);
+
+	cancel_work_sync(&fd->work);
+	scsi_remove_host(sh);
+	if (sh->irq)
+		free_irq(sh->irq, fd);
+	scsi_host_put(sh);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdomain_destroy);
+
+#ifdef CONFIG_PM_SLEEP
+static int fdomain_resume(struct device *dev)
+{
+	struct fdomain *fd = shost_priv(dev_get_drvdata(dev));
+
+	fdomain_reset(fd->base);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(fdomain_pm_ops, NULL, fdomain_resume);
+#endif /* CONFIG_PM_SLEEP */
+
+MODULE_AUTHOR("Ondrej Zary, Rickard E. Faith");
+MODULE_DESCRIPTION("Future Domain TMC-16x0/TMC-3260 SCSI driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/fdomain.h b/drivers/scsi/fdomain.h
new file mode 100644
index 000000000000..fabb2e49461f
--- /dev/null
+++ b/drivers/scsi/fdomain.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define FDOMAIN_REGION_SIZE	0x10
+#define FDOMAIN_BIOS_SIZE	0x2000
+
+enum {
+	in_arbitration	= 0x02,
+	in_selection	= 0x04,
+	in_other	= 0x08,
+	disconnect	= 0x10,
+	aborted		= 0x20,
+	sent_ident	= 0x40,
+};
+
+enum in_port_type {
+	Read_SCSI_Data	 =  0,
+	SCSI_Status	 =  1,
+	TMC_Status	 =  2,
+	FIFO_Status	 =  3,	/* tmc18c50/tmc18c30 only */
+	Interrupt_Cond	 =  4,	/* tmc18c50/tmc18c30 only */
+	LSB_ID_Code	 =  5,
+	MSB_ID_Code	 =  6,
+	Read_Loopback	 =  7,
+	SCSI_Data_NoACK	 =  8,
+	Interrupt_Status =  9,
+	Configuration1	 = 10,
+	Configuration2	 = 11,	/* tmc18c50/tmc18c30 only */
+	Read_FIFO	 = 12,
+	FIFO_Data_Count	 = 14
+};
+
+enum out_port_type {
+	Write_SCSI_Data	=  0,
+	SCSI_Cntl	=  1,
+	Interrupt_Cntl	=  2,
+	SCSI_Mode_Cntl	=  3,
+	TMC_Cntl	=  4,
+	Memory_Cntl	=  5,	/* tmc18c50/tmc18c30 only */
+	Write_Loopback	=  7,
+	IO_Control	= 11,	/* tmc18c30 only */
+	Write_FIFO	= 12
+};
+
+#ifdef CONFIG_PM_SLEEP
+static const struct dev_pm_ops fdomain_pm_ops;
+#define FDOMAIN_PM_OPS	(&fdomain_pm_ops)
+#else
+#define FDOMAIN_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
+struct Scsi_Host *fdomain_create(int base, int irq, int this_id,
+				 struct device *dev);
+int fdomain_destroy(struct Scsi_Host *sh);
-- 
Ondrej Zary

