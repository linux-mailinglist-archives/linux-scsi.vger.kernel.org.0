Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8593B1C810B
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 06:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgEGE25 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 00:28:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35254 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgEGE25 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 00:28:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so1558018plt.2
        for <linux-scsi@vger.kernel.org>; Wed, 06 May 2020 21:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+j1VFm7zraoBf9VCizi9YujpSwTFXDH2vqAaGru1N9g=;
        b=TNcGZaC4Dw89RoVQcQJo3MOKXMcWZ1Lg+P9FF+Ce0ef+Zwk6SJRTHdymZYkjULyCB4
         CB0eseNSv4nrpX56jmIp2NIuz5dl0gUDCSwVadH5pHvn+OlWUlVY/g4Ygh8RLoUG1LyY
         mxjdsQnzzg0BuaFLFOplcN0bKvRkBCUB+ptDHvGeyws8+effaxnVy5Yj3EP5q1mcrM5+
         F+W8BUIjPfycAzUE9mr7/6I0pTJqwbgYH++PU83gpSIf/VmUkcqBTX5SHwH8ab5yxgLn
         mdu045IrdfoSa/83ecLIXNT+mmd0/gknJnBZLeck1mQzIG/7ovBsNsn2fbzweEZttYZd
         MSPQ==
X-Gm-Message-State: AGi0PuYP5gJzLbhL/ORuXYsolxwRGxXjwyM73gQO6t2uUeXPIu2GSbOD
        4R2SFrYWXr38hYG8CkKy6Hg=
X-Google-Smtp-Source: APiQypJ+SYHNGcurzUpWES1K58uynuwZDfCig+BxM1jSN6///UfBE7gZkF1DiisWl154hymtFP5grQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr10969606pll.273.1588825735789;
        Wed, 06 May 2020 21:28:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:246f:3453:e672:e40c])
        by smtp.gmail.com with ESMTPSA id z28sm3471028pfr.3.2020.05.06.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 21:28:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 08/11] qla2xxx: Fix the code that reads from mailbox registers
Date:   Wed,  6 May 2020 21:28:32 -0700
Message-Id: <20200507042835.9135-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507042835.9135-1-bvanassche@acm.org>
References: <20200507042835.9135-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make the MMIO accessors strongly typed such that the compiler checks whether
the accessor function is used that matches the register width. Fix those
MMIO accesses where another number of bits was read or written than the size
of the register.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  | 53 +++++++++++++++++++++++++++------
 drivers/scsi/qla2xxx/qla_init.c |  6 ++--
 drivers/scsi/qla2xxx/qla_iocb.c |  2 +-
 drivers/scsi/qla2xxx/qla_isr.c  |  4 +--
 drivers/scsi/qla2xxx/qla_mbx.c  |  2 +-
 drivers/scsi/qla2xxx/qla_mr.c   | 26 ++++++++--------
 drivers/scsi/qla2xxx/qla_nx.c   |  4 +--
 drivers/scsi/qla2xxx/qla_os.c   |  2 +-
 8 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 172ea4e5887d..87b932cc49a0 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -128,15 +128,50 @@ static inline uint32_t make_handle(uint16_t x, uint16_t y)
  * I/O register
 */
 
-#define RD_REG_BYTE(addr)		readb(addr)
-#define RD_REG_WORD(addr)		readw(addr)
-#define RD_REG_DWORD(addr)		readl(addr)
-#define RD_REG_BYTE_RELAXED(addr)	readb_relaxed(addr)
-#define RD_REG_WORD_RELAXED(addr)	readw_relaxed(addr)
-#define RD_REG_DWORD_RELAXED(addr)	readl_relaxed(addr)
-#define WRT_REG_BYTE(addr, data)	writeb(data, addr)
-#define WRT_REG_WORD(addr, data)	writew(data, addr)
-#define WRT_REG_DWORD(addr, data)	writel(data, addr)
+static inline u8 RD_REG_BYTE(const volatile u8 __iomem *addr)
+{
+	return readb(addr);
+}
+
+static inline u16 RD_REG_WORD(const volatile __le16 __iomem *addr)
+{
+	return readw(addr);
+}
+
+static inline u32 RD_REG_DWORD(const volatile __le32 __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline u8 RD_REG_BYTE_RELAXED(const volatile u8 __iomem *addr)
+{
+	return readb_relaxed(addr);
+}
+
+static inline u16 RD_REG_WORD_RELAXED(const volatile __le16 __iomem *addr)
+{
+	return readw_relaxed(addr);
+}
+
+static inline u32 RD_REG_DWORD_RELAXED(const volatile __le32 __iomem *addr)
+{
+	return readl_relaxed(addr);
+}
+
+static inline void WRT_REG_BYTE(volatile u8 __iomem *addr, u8 data)
+{
+	return writeb(data, addr);
+}
+
+static inline void WRT_REG_WORD(volatile __le16 __iomem *addr, u16 data)
+{
+	return writew(data, addr);
+}
+
+static inline void WRT_REG_DWORD(volatile __le32 __iomem *addr, u32 data)
+{
+	return writel(data, addr);
+}
 
 /*
  * ISP83XX specific remote register addresses
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f8fe0334571f..a1018f5f53de 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2219,7 +2219,7 @@ qla2x00_initialize_adapter(scsi_qla_host_t *vha)
 
 	/* Check for secure flash support */
 	if (IS_QLA28XX(ha)) {
-		if (RD_REG_DWORD(&reg->mailbox12) & BIT_0)
+		if (RD_REG_WORD(&reg->mailbox12) & BIT_0)
 			ha->flags.secure_adapter = 1;
 		ql_log(ql_log_info, vha, 0xffff, "Secure Adapter: %s\n",
 		    (ha->flags.secure_adapter) ? "Yes" : "No");
@@ -2780,7 +2780,7 @@ qla24xx_reset_risc(scsi_qla_host_t *vha)
 	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x017f,
 	    "HCCR: 0x%x, MailBox0 Status 0x%x\n",
 	    RD_REG_DWORD(&reg->hccr),
-	    RD_REG_DWORD(&reg->mailbox0));
+	    RD_REG_WORD(&reg->mailbox0));
 
 	/* Wait for soft-reset to complete. */
 	RD_REG_DWORD(&reg->ctrl_status);
@@ -4098,7 +4098,7 @@ qla24xx_config_rings(struct scsi_qla_host *vha)
 	}
 
 	/* PCI posting */
-	RD_REG_DWORD(&ioreg->hccr);
+	RD_REG_WORD(&ioreg->hccr);
 }
 
 /**
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 182bd68c79ac..4d8039fc02e7 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2268,7 +2268,7 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 		    IS_QLA28XX(ha))
 			cnt = RD_REG_DWORD(&reg->isp25mq.req_q_out);
 		else if (IS_P3P_TYPE(ha))
-			cnt = RD_REG_DWORD(&reg->isp82.req_q_out);
+			cnt = RD_REG_DWORD(reg->isp82.req_q_out);
 		else if (IS_FWI2_CAPABLE(ha))
 			cnt = RD_REG_DWORD(&reg->isp24.req_q_out);
 		else if (IS_QLAFX00(ha))
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a9e8513e1cf1..438b123fb73e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -452,7 +452,7 @@ qla81xx_idc_event(scsi_qla_host_t *vha, uint16_t aen, uint16_t descr)
 	int rval;
 	struct device_reg_24xx __iomem *reg24 = &vha->hw->iobase->isp24;
 	struct device_reg_82xx __iomem *reg82 = &vha->hw->iobase->isp82;
-	uint16_t __iomem *wptr;
+	__le16 __iomem *wptr;
 	uint16_t cnt, timeout, mb[QLA_IDC_ACK_REGS];
 
 	/* Seed data -- mailbox1 -> mailbox7. */
@@ -3164,7 +3164,7 @@ qla24xx_mbx_completion(scsi_qla_host_t *vha, uint16_t mb0)
 {
 	uint16_t	cnt;
 	uint32_t	mboxes;
-	uint16_t __iomem *wptr;
+	__le16 __iomem *wptr;
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 9fd83d1bffe0..c2c30fb70c43 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -106,7 +106,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 	uint8_t		io_lock_on;
 	uint16_t	command = 0;
 	uint16_t	*iptr;
-	uint16_t __iomem *optr;
+	__le16 __iomem  *optr;
 	uint32_t	cnt;
 	uint32_t	mboxes;
 	unsigned long	wait_time;
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index df99911b8bb9..a996ef132174 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -46,7 +46,7 @@ qlafx00_mailbox_command(scsi_qla_host_t *vha, struct mbx_cmd_32 *mcp)
 	uint8_t		io_lock_on;
 	uint16_t	command = 0;
 	uint32_t	*iptr;
-	uint32_t __iomem *optr;
+	__le32 __iomem *optr;
 	uint32_t	cnt;
 	uint32_t	mboxes;
 	unsigned long	wait_time;
@@ -109,7 +109,7 @@ qlafx00_mailbox_command(scsi_qla_host_t *vha, struct mbx_cmd_32 *mcp)
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
 	/* Load mailbox registers. */
-	optr = (uint32_t __iomem *)&reg->ispfx00.mailbox0;
+	optr = &reg->ispfx00.mailbox0;
 
 	iptr = mcp->mb;
 	command = mcp->mb[0];
@@ -2846,13 +2846,13 @@ qlafx00_async_event(scsi_qla_host_t *vha)
 		break;
 
 	default:
-		ha->aenmb[1] = RD_REG_WORD(&reg->aenmailbox1);
-		ha->aenmb[2] = RD_REG_WORD(&reg->aenmailbox2);
-		ha->aenmb[3] = RD_REG_WORD(&reg->aenmailbox3);
-		ha->aenmb[4] = RD_REG_WORD(&reg->aenmailbox4);
-		ha->aenmb[5] = RD_REG_WORD(&reg->aenmailbox5);
-		ha->aenmb[6] = RD_REG_WORD(&reg->aenmailbox6);
-		ha->aenmb[7] = RD_REG_WORD(&reg->aenmailbox7);
+		ha->aenmb[1] = RD_REG_DWORD(&reg->aenmailbox1);
+		ha->aenmb[2] = RD_REG_DWORD(&reg->aenmailbox2);
+		ha->aenmb[3] = RD_REG_DWORD(&reg->aenmailbox3);
+		ha->aenmb[4] = RD_REG_DWORD(&reg->aenmailbox4);
+		ha->aenmb[5] = RD_REG_DWORD(&reg->aenmailbox5);
+		ha->aenmb[6] = RD_REG_DWORD(&reg->aenmailbox6);
+		ha->aenmb[7] = RD_REG_DWORD(&reg->aenmailbox7);
 		ql_dbg(ql_dbg_async, vha, 0x5078,
 		    "AEN:%04x %04x %04x %04x :%04x %04x %04x %04x\n",
 		    ha->aenmb[0], ha->aenmb[1], ha->aenmb[2], ha->aenmb[3],
@@ -2872,7 +2872,7 @@ static void
 qlafx00_mbx_completion(scsi_qla_host_t *vha, uint32_t mb0)
 {
 	uint16_t	cnt;
-	uint32_t __iomem *wptr;
+	__le32 __iomem *wptr;
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_fx00 __iomem *reg = &ha->iobase->ispfx00;
 
@@ -2882,7 +2882,7 @@ qlafx00_mbx_completion(scsi_qla_host_t *vha, uint32_t mb0)
 	/* Load return mailbox registers. */
 	ha->flags.mbox_int = 1;
 	ha->mailbox_out32[0] = mb0;
-	wptr = (uint32_t __iomem *)&reg->mailbox17;
+	wptr = &reg->mailbox17;
 
 	for (cnt = 1; cnt < ha->mbx_count; cnt++) {
 		ha->mailbox_out32[cnt] = RD_REG_DWORD(wptr);
@@ -2939,13 +2939,13 @@ qlafx00_intr_handler(int irq, void *dev_id)
 			break;
 
 		if (stat & QLAFX00_INTR_MB_CMPLT) {
-			mb[0] = RD_REG_WORD(&reg->mailbox16);
+			mb[0] = RD_REG_DWORD(&reg->mailbox16);
 			qlafx00_mbx_completion(vha, mb[0]);
 			status |= MBX_INTERRUPT;
 			clr_intr |= QLAFX00_INTR_MB_CMPLT;
 		}
 		if (intr_stat & QLAFX00_INTR_ASYNC_CMPLT) {
-			ha->aenmb[0] = RD_REG_WORD(&reg->aenmailbox0);
+			ha->aenmb[0] = RD_REG_DWORD(&reg->aenmailbox0);
 			qlafx00_async_event(vha);
 			clr_intr |= QLAFX00_INTR_ASYNC_CMPLT;
 		}
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index 185c5f34d4c1..a1d462b13a4b 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -1996,11 +1996,11 @@ void
 qla82xx_mbx_completion(scsi_qla_host_t *vha, uint16_t mb0)
 {
 	uint16_t	cnt;
-	uint16_t __iomem *wptr;
+	__le16 __iomem *wptr;
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_82xx __iomem *reg = &ha->iobase->isp82;
 
-	wptr = (uint16_t __iomem *)&reg->mailbox_out[1];
+	wptr = &reg->mailbox_out[1];
 
 	/* Load return mailbox registers. */
 	ha->flags.mbox_int = 1;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index c6d25dcceb72..8a3b140d9113 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7557,7 +7557,7 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	if (IS_QLA2100(ha) || IS_QLA2200(ha)){
-		stat = RD_REG_DWORD(&reg->hccr);
+		stat = RD_REG_WORD(&reg->hccr);
 		if (stat & HCCR_RISC_PAUSE)
 			risc_paused = 1;
 	} else if (IS_QLA23XX(ha)) {
