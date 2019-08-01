Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8835D7E184
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfHAR41 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34850 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR41 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so34523240pfn.2
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFzV7Kvg8Uw5fa7LanQcnbP+Gj9DVg7PP7nPXhGCMhM=;
        b=hLEFjVsa1RBT1GnqStPF8mspc3Fqgge3KYm/9BS2evZEveOSf0Qu0gt7RIvQDJskfA
         36ygL9pd1qHdzZPjUOFdneS/npIJVsC3juWhruRo19ycGlJwv49LdTZjtmsDnagGJ66e
         rNb+e5ImBrN5C7PYllWMXiMeSqeWEnqYFrK5eX/2UpDRR7uG9m6SGHi8UGmsVozRzu/w
         Oenxfcb5NifDkL2F+q5IiWnagVsWMV++ffjZXSeSznXyBMvKSKQGrDsNlOZZwQg4zqXK
         cjzgHqEZoMyPDUmosDprqihvysnH1SUhKpBJ9tjSxzwCG9Ad53Sg4xQjN7KoMlN9xSvf
         6WTQ==
X-Gm-Message-State: APjAAAXljCRe+XOEC3ttBlrmsCOJjK/BqWx1n2bZ6y2CbdZwpXrKj7V8
        hPFZGYk6wz+MC0YGbrUUhyY=
X-Google-Smtp-Source: APXvYqwQ4mANnZFr9/xXGgTk4zqA+a9SqYZGchHA6CwkdKJ1t88E7MLpoAoESBrNpj16OaxJUWLU6g==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr54169662pfr.36.1564682186337;
        Thu, 01 Aug 2019 10:56:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 03/59] qla2xxx: Improve Linux kernel coding style conformance
Date:   Thu,  1 Aug 2019 10:55:18 -0700
Message-Id: <20190801175614.73655-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Insert a space where required, surround complex expressions in macros
with parentheses, use the UL suffix instead of the (unsigned long) cast,
do not use line continuations when not necessary and do not explicitly
initialize static variables to zero.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  | 10 +++++-----
 drivers/scsi/qla2xxx/qla_init.c |  2 +-
 drivers/scsi/qla2xxx/qla_iocb.c |  1 +
 drivers/scsi/qla2xxx/qla_nvme.c |  1 -
 drivers/scsi/qla2xxx/qla_nx.c   | 10 +++++-----
 drivers/scsi/qla2xxx/qla_nx.h   | 14 +++++++-------
 drivers/scsi/qla2xxx/qla_os.c   |  6 +++---
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index b91ef7b75e8d..a94b0d440f0f 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -117,9 +117,9 @@
 #define RD_REG_BYTE_RELAXED(addr)	readb_relaxed(addr)
 #define RD_REG_WORD_RELAXED(addr)	readw_relaxed(addr)
 #define RD_REG_DWORD_RELAXED(addr)	readl_relaxed(addr)
-#define WRT_REG_BYTE(addr, data)	writeb(data,addr)
-#define WRT_REG_WORD(addr, data)	writew(data,addr)
-#define WRT_REG_DWORD(addr, data)	writel(data,addr)
+#define WRT_REG_BYTE(addr, data)	writeb(data, addr)
+#define WRT_REG_WORD(addr, data)	writew(data, addr)
+#define WRT_REG_DWORD(addr, data)	writel(data, addr)
 
 /*
  * ISP83XX specific remote register addresses
@@ -207,7 +207,7 @@
  * 133Mhz slot.
  */
 #define RD_REG_WORD_PIO(addr)		(inw((unsigned long)addr))
-#define WRT_REG_WORD_PIO(addr, data)	(outw(data,(unsigned long)addr))
+#define WRT_REG_WORD_PIO(addr, data)	(outw(data, (unsigned long)addr))
 
 /*
  * Fibre Channel device definitions.
@@ -3851,7 +3851,7 @@ struct qla_hw_data {
 
 	/* NVRAM configuration data */
 #define MAX_NVRAM_SIZE  4096
-#define VPD_OFFSET      MAX_NVRAM_SIZE / 2
+#define VPD_OFFSET      (MAX_NVRAM_SIZE / 2)
 	uint16_t	nvram_size;
 	uint16_t	nvram_base;
 	void		*nvram;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index d82d1a2b3543..3585eb7b87b5 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5397,7 +5397,7 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
 	    "%s %8phN. rport %p is %s mode\n",
 	    __func__, fcport->port_name, rport,
 	    (fcport->port_type == FCT_TARGET) ? "tgt" :
-	    ((fcport->port_type & FCT_NVME) ? "nvme" :"ini"));
+	    ((fcport->port_type & FCT_NVME) ? "nvme" : "ini"));
 
 	fc_remote_port_rolechg(rport, rport_ids.roles);
 }
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 1886de92034c..b514ab4d243e 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1364,6 +1364,7 @@ qla24xx_walk_and_build_prot_sglist(struct qla_hw_data *ha, srb_t *sp,
 	cur_dsd++;
 	return 0;
 }
+
 /**
  * qla24xx_build_scsi_crc_2_iocbs() - Build IOCB command utilizing Command
  *							Type 6 IOCB types.
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index af7919a5acdc..16028ee8c7a7 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -267,7 +267,6 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	schedule_work(&priv->abort_work);
 }
 
-
 static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
     struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
 {
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index c760ae354174..c1c832271ccb 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -1985,7 +1985,7 @@ qla82xx_check_rcvpeg_state(struct qla_hw_data *ha)
 }
 
 /* ISR related functions */
-static struct qla82xx_legacy_intr_set legacy_intr[] = \
+static struct qla82xx_legacy_intr_set legacy_intr[] =
 	QLA82XX_LEGACY_INTR_CONFIG;
 
 /*
@@ -3286,7 +3286,7 @@ qla82xx_device_state_handler(scsi_qla_host_t *vha)
 		case QLA8XXX_DEV_NEED_QUIESCENT:
 			qla82xx_need_qsnt_handler(vha);
 			/* Reset timeout value after quiescence handler */
-			dev_init_timeout = jiffies + (ha->fcoe_dev_init_timeout\
+			dev_init_timeout = jiffies + (ha->fcoe_dev_init_timeout
 							 * HZ);
 			break;
 		case QLA8XXX_DEV_QUIESCENT:
@@ -3301,7 +3301,7 @@ qla82xx_device_state_handler(scsi_qla_host_t *vha)
 			qla82xx_idc_lock(ha);
 
 			/* Reset timeout value after quiescence handler */
-			dev_init_timeout = jiffies + (ha->fcoe_dev_init_timeout\
+			dev_init_timeout = jiffies + (ha->fcoe_dev_init_timeout
 							 * HZ);
 			break;
 		case QLA8XXX_DEV_FAILED:
@@ -4232,7 +4232,7 @@ qla82xx_md_collect(scsi_qla_host_t *vha)
 		goto md_failed;
 	}
 
-	entry_hdr = (qla82xx_md_entry_hdr_t *) \
+	entry_hdr = (qla82xx_md_entry_hdr_t *)
 	    (((uint8_t *)ha->md_tmplt_hdr) + tmplt_hdr->first_entry_offset);
 
 	/* Walk through the entry headers */
@@ -4339,7 +4339,7 @@ qla82xx_md_collect(scsi_qla_host_t *vha)
 		data_collected = (uint8_t *)data_ptr -
 		    (uint8_t *)ha->md_dump;
 skip_nxt_entry:
-		entry_hdr = (qla82xx_md_entry_hdr_t *) \
+		entry_hdr = (qla82xx_md_entry_hdr_t *)
 		    (((uint8_t *)entry_hdr) + entry_hdr->entry_size);
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_nx.h b/drivers/scsi/qla2xxx/qla_nx.h
index 3c7beef92c35..230abee10598 100644
--- a/drivers/scsi/qla2xxx/qla_nx.h
+++ b/drivers/scsi/qla2xxx/qla_nx.h
@@ -486,13 +486,13 @@
 #define QLA82XX_ADDR_QDR_NET		(0x0000000300000000ULL)
 #define QLA82XX_P3_ADDR_QDR_NET_MAX	(0x0000000303ffffffULL)
 
-#define QLA82XX_PCI_CRBSPACE		(unsigned long)0x06000000
-#define QLA82XX_PCI_DIRECT_CRB		(unsigned long)0x04400000
-#define QLA82XX_PCI_CAMQM		(unsigned long)0x04800000
-#define QLA82XX_PCI_CAMQM_MAX		(unsigned long)0x04ffffff
-#define QLA82XX_PCI_DDR_NET		(unsigned long)0x00000000
-#define QLA82XX_PCI_QDR_NET		(unsigned long)0x04000000
-#define QLA82XX_PCI_QDR_NET_MAX		(unsigned long)0x043fffff
+#define QLA82XX_PCI_CRBSPACE		0x06000000UL
+#define QLA82XX_PCI_DIRECT_CRB		0x04400000UL
+#define QLA82XX_PCI_CAMQM		0x04800000UL
+#define QLA82XX_PCI_CAMQM_MAX		0x04ffffffUL
+#define QLA82XX_PCI_DDR_NET		0x00000000UL
+#define QLA82XX_PCI_QDR_NET		0x04000000UL
+#define QLA82XX_PCI_QDR_NET_MAX		0x043fffffUL
 
 /*
  *   Register offsets for MN
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a0ab47082238..23ca3e74770c 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(ql2xplogiabsentdevice,
 		"a Fabric scan.  This is needed for several broken switches. "
 		"Default is 0 - no PLOGI. 1 - perform PLOGI.");
 
-int ql2xloginretrycount = 0;
+int ql2xloginretrycount;
 module_param(ql2xloginretrycount, int, S_IRUGO);
 MODULE_PARM_DESC(ql2xloginretrycount,
 		"Specify an alternate value for the NVRAM login retry count.");
@@ -234,7 +234,7 @@ MODULE_PARM_DESC(ql2xmdenable,
 		"0 - MiniDump disabled. "
 		"1 (Default) - MiniDump enabled.");
 
-int ql2xexlogins = 0;
+int ql2xexlogins;
 module_param(ql2xexlogins, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xexlogins,
 		 "Number of extended Logins. "
@@ -250,7 +250,7 @@ module_param(ql2xiniexchg, uint, 0644);
 MODULE_PARM_DESC(ql2xiniexchg,
 	"Number of initiator exchanges.");
 
-int ql2xfwholdabts = 0;
+int ql2xfwholdabts;
 module_param(ql2xfwholdabts, int, S_IRUGO);
 MODULE_PARM_DESC(ql2xfwholdabts,
 		"Allow FW to hold status IOCB until ABTS rsp received. "
-- 
2.22.0.770.g0f2c4a37fd-goog

