Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690562E620
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2U2x (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32907 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U2x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so1551253plq.0
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR8gKUgoRKy53Hs12JzooNlNG6PiO79B8x11yghh6fY=;
        b=n+O0DeBxsRzJcc5dwkAd0/HOoGLc5p8gl92o2LHSD6AUcdqzWwp8EyfumMF8AHGnpE
         +lv+YBgZdchuQ29kVgnpra/Aig2Sr3D70vRRbYuy6mmXzlDqd3fjfZPaBIe0/c1fKepl
         hhnriJQOnzLQ////hFZBVJ/D1+xBcQ/A1Y3rq3WCsG/32h5LMP4xwxevj8cmB+jh+Snt
         1GoD6WyH1Poo4a4Jd6Vjpdk+RQ+fggk5FJ3JCttCzOY0QrDWZ0VqUVu1fnzUzuwTcCWq
         KqxMpd9CjRoB3F18lAtiCympql4JZdEcHA/xorSBTamuz4Lry1+ImaI1pkAoq2zfYt/r
         B6ew==
X-Gm-Message-State: APjAAAU1BAMTGBPC1GrjpEjIGqUsyjhJBVH8vvVa5GYnoPFeeupcIK6A
        nj7F67AZe+p8a/JtN7B+7Bk=
X-Google-Smtp-Source: APXvYqyRtr3itc9RN92c5oYg7xJQkCd74wJpZCojgpP1440P+jNU64uivoyvxBaLHBNVYnAJxFBLGg==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr16732869plp.139.1559161732501;
        Wed, 29 May 2019 13:28:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 12/20] qla2xxx: Improve Linux kernel coding style conformance
Date:   Wed, 29 May 2019 13:28:18 -0700
Message-Id: <20190529202826.204499-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Insert a space where required, surround complex expressions in macros
with parentheses, do not use line continuations when not necessary and
do not explicitly initialize static variables to zero.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  | 10 +++++-----
 drivers/scsi/qla2xxx/qla_nvme.c |  2 +-
 drivers/scsi/qla2xxx/qla_nx.c   | 10 +++++-----
 drivers/scsi/qla2xxx/qla_nx.h   | 14 +++++++-------
 drivers/scsi/qla2xxx/qla_os.c   |  6 +++---
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 46a260038c30..c787304347d7 100644
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
@@ -3848,7 +3848,7 @@ struct qla_hw_data {
 
 	/* NVRAM configuration data */
 #define MAX_NVRAM_SIZE  4096
-#define VPD_OFFSET      MAX_NVRAM_SIZE / 2
+#define VPD_OFFSET      (MAX_NVRAM_SIZE / 2)
 	uint16_t	nvram_size;
 	uint16_t	nvram_base;
 	void		*nvram;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 22e3fba28e51..7b8ed44874fc 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -596,7 +596,7 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
 		return;
 
 	ql_log(ql_log_warn, NULL, 0x2112,
-	    "%s: unregister remoteport on %p\n",__func__, fcport);
+	    "%s: unregister remoteport on %p\n", __func__, fcport);
 
 	list_for_each_entry_safe(qla_rport, trport,
 	    &fcport->vha->nvme_rport_list, list) {
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
index 0b4673eb1e43..1cba165fa38d 100644
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
2.22.0.rc1

