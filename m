Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E697667493
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Jan 2023 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjALOJq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Jan 2023 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjALOIk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Jan 2023 09:08:40 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DAE52C6F;
        Thu, 12 Jan 2023 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673532299; x=1705068299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udBzXd/IavY1W2ZwHk17GUi/St/IdRIo1THFRJU+cdc=;
  b=OrahpBn5q/1+AEkyQI5ZOcFRINwqll3OIwCS5Ifk/BywJa4rqWiYRDl2
   pwdqDIOezGs1DcKlkg6fiAEKUekE9o6NQ6Qmz1Alx3y99Wl66MabRowdo
   WbXX5Us759hpF14fVTbDcVkZyiOowyQyNj8LiqQkyS0K/rje/HVQbUGkJ
   feJp7cwujjSIMueqAoXt99dbYQdZzYBPYSdLVjk415wpy/dypkpwa4S+a
   8ulGBVp6Ag/aSA1twmFDvQp8qeMzW8FE5AiOrR7roozgBm7ZAQQf3ogfY
   PBNDeNgZeUpKIk94s5SXNBGeY/kGUybeB0Kd+2+Dq/EMxPFvLqUIODBUu
   A==;
X-IronPort-AV: E=Sophos;i="5.97,211,1669046400"; 
   d="scan'208";a="332632714"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 22:04:50 +0800
IronPort-SDR: 4sS05T9KzlPfyP2yBRJTJn7X02GudxNxg7PHcY3wzTo5xN5EmKdsMbvo4qRSkDmPzXSKiULTN6
 I0lMENBR66Ia86BTixuPJizVWNS7WSo4z7hJn/YC6uyB83+l6zgkNujk2YAm6W6ZYhVFDaqiBp
 yGeaxXaklieYH1P6qW6ctoZ/qsZSoQPLwqXOyjk30THkQs3GV/gq5devYHocbniKUxJtE6pGS2
 xEjHRMZi18jO/x1dNtY9zS5gI+iEKadkVRorzDrLLMXXYOfBO3PbxXIWHk4SQoXwDsbvOXf/gH
 CwY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2023 05:16:53 -0800
IronPort-SDR: fjgiBVGVYxWYAPHxR+wrN/fCcXiKc9pny9ARL9v/PuX1RrtqSBVMFq+Lwq42e1b6micgzNFaaQ
 ZWGQj2qnfL/D5tdz4kwmbzRZ5qRDhAmL/BgYMy/gv0XB3ptc+Ke2Ynwj84IWjAEabsQU/fPBmx
 W8Ob4O/TKV//peiRDTZCanOeO6zqyvWfKLEFewEEkq54zb3xTysIfUwKjyVKt9wiZI2FjIIMFJ
 w6XWqPUfKLEwNbEMtWhrSUbCF0Qkk5UxuHoKLoi+Vze9oOCiEzeXYmYMiPWrqPyfUPYPdfuqh/
 rTY=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.12])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2023 06:04:49 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 11/18] ata: libata-scsi: add support for CDL pages mode sense
Date:   Thu, 12 Jan 2023 15:04:00 +0100
Message-Id: <20230112140412.667308-12-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112140412.667308-1-niklas.cassel@wdc.com>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Modify ata_scsiop_mode_sense() and ata_msense_control() to support mode
sense access to the T2A and T2B sub-pages of the control mode page.
ata_msense_control() is modified to support sub-pages. The T2A sub-page
is generated using the read descriptors of the command duration limits
log page 18h. The T2B sub-page is generated using the write descriptors
of the same log page. With the addition of these sub-pages, getting all
sub-pages of the control mode page is also supported by increasing the
value of ATA_SCSI_RBUF_SIZE from 576B up to 2048B to ensure that all
sub-pages fit in the fill buffer.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-scsi.c | 150 ++++++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b0a6778e852f..91fb19e72856 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -37,7 +37,7 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	576
+#define ATA_SCSI_RBUF_SIZE	2048
 
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
@@ -55,6 +55,9 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 #define CONTROL_MPAGE_LEN		12
 #define ALL_MPAGES			0x3f
 #define ALL_SUB_MPAGES			0xff
+#define CDL_T2A_SUB_MPAGE		0x07
+#define CDL_T2B_SUB_MPAGE		0x08
+#define CDL_T2_SUB_MPAGE_LEN		232
 
 static const u8 def_rw_recovery_mpage[RW_RECOVERY_MPAGE_LEN] = {
 	RW_RECOVERY_MPAGE,
@@ -2199,10 +2202,98 @@ static unsigned int ata_msense_caching(u16 *id, u8 *buf, bool changeable)
 	return sizeof(def_cache_mpage);
 }
 
+/*
+ * Simulate MODE SENSE control mode page, sub-page 0.
+ */
+static unsigned int ata_msense_control_spg0(struct ata_device *dev, u8 *buf,
+					    bool changeable)
+{
+	modecpy(buf, def_control_mpage,
+		sizeof(def_control_mpage), changeable);
+	if (changeable) {
+		/* ata_mselect_control() */
+		buf[2] |= (1 << 2);
+	} else {
+		bool d_sense = (dev->flags & ATA_DFLAG_D_SENSE);
+
+		/* descriptor format sense data */
+		buf[2] |= (d_sense << 2);
+	}
+
+	return sizeof(def_control_mpage);
+}
+
+/*
+ * Translate an ATA duration limit in microseconds to a SCSI duration limit
+ * using the t2cdlunits 0xa (10ms). Since the SCSI duration limits are 2-bytes
+ * only, take care of overflows.
+ */
+static inline u16 ata_xlat_cdl_limit(u8 *buf)
+{
+	u32 limit = get_unaligned_le32(buf);
+
+	return min_t(u32, limit / 10000, 65535);
+}
+
+/*
+ * Simulate MODE SENSE control mode page, sub-pages 07h and 08h
+ * (command duration limits T2A and T2B mode pages).
+ */
+static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
+					     u8 spg)
+{
+	u8 *b, *cdl = dev->cdl, *desc;
+	u32 policy;
+	int i;
+
+	/*
+	 * Fill the subpage. The first four bytes of the T2A/T2B mode pages
+	 * are a header. The PAGE LENGTH field is the size of the page
+	 * excluding the header.
+	 */
+	buf[0] = CONTROL_MPAGE;
+	buf[1] = spg;
+	put_unaligned_be16(CDL_T2_SUB_MPAGE_LEN - 4, &buf[2]);
+	if (spg == CDL_T2A_SUB_MPAGE) {
+		/*
+		 * Read descriptors map to the T2A page:
+		 * set perf_vs_duration_guidleine.
+		 */
+		buf[7] = (cdl[0] & 0x03) << 4;
+		desc = cdl + 64;
+	} else {
+		/* Write descriptors map to the T2B page */
+		desc = cdl + 288;
+	}
+
+	/* Fill the T2 page descriptors */
+	b = &buf[8];
+	policy = get_unaligned_le32(&cdl[0]);
+	for (i = 0; i < 7; i++, b += 32, desc += 32) {
+		/* t2cdlunits: fixed to 10ms */
+		b[0] = 0x0a;
+
+		/* Max inactive time and its policy */
+		put_unaligned_be16(ata_xlat_cdl_limit(&desc[8]), &b[2]);
+		b[6] = ((policy >> 8) & 0x0f) << 4;
+
+		/* Max active time and its policy */
+		put_unaligned_be16(ata_xlat_cdl_limit(&desc[4]), &b[4]);
+		b[6] |= (policy >> 4) & 0x0f;
+
+		/* Command duration guideline and its policy */
+		put_unaligned_be16(ata_xlat_cdl_limit(&desc[16]), &b[10]);
+		b[14] = policy & 0x0f;
+	}
+
+	return CDL_T2_SUB_MPAGE_LEN;
+}
+
 /**
  *	ata_msense_control - Simulate MODE SENSE control mode page
  *	@dev: ATA device of interest
  *	@buf: output buffer
+ *	@spg: sub-page code
  *	@changeable: whether changeable parameters are requested
  *
  *	Generate a generic MODE SENSE control mode page.
@@ -2211,17 +2302,24 @@ static unsigned int ata_msense_caching(u16 *id, u8 *buf, bool changeable)
  *	None.
  */
 static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
-					bool changeable)
+				       u8 spg, bool changeable)
 {
-	modecpy(buf, def_control_mpage, sizeof(def_control_mpage), changeable);
-	if (changeable) {
-		buf[2] |= (1 << 2);	/* ata_mselect_control() */
-	} else {
-		bool d_sense = (dev->flags & ATA_DFLAG_D_SENSE);
-
-		buf[2] |= (d_sense << 2);	/* descriptor format sense data */
+	unsigned int n;
+
+	switch (spg) {
+	case 0:
+		return ata_msense_control_spg0(dev, buf, changeable);
+	case CDL_T2A_SUB_MPAGE:
+	case CDL_T2B_SUB_MPAGE:
+		return ata_msense_control_spgt2(dev, buf, spg);
+	case ALL_SUB_MPAGES:
+		n = ata_msense_control_spg0(dev, buf, changeable);
+		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
+		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
+		return n;
+	default:
+		return 0;
 	}
-	return sizeof(def_control_mpage);
 }
 
 /**
@@ -2294,13 +2392,24 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 
 	pg = scsicmd[2] & 0x3f;
 	spg = scsicmd[3];
+
 	/*
-	 * No mode subpages supported (yet) but asking for _all_
-	 * subpages may be valid
+	 * Supported subpages: all subpages and sub-pages 07h and 08h of
+	 * the control page.
 	 */
-	if (spg && (spg != ALL_SUB_MPAGES)) {
-		fp = 3;
-		goto invalid_fld;
+	if (spg) {
+		switch (spg) {
+		case ALL_SUB_MPAGES:
+			break;
+		case CDL_T2A_SUB_MPAGE:
+		case CDL_T2B_SUB_MPAGE:
+			if (dev->flags & ATA_DFLAG_CDL && pg == CONTROL_MPAGE)
+				break;
+			fallthrough;
+		default:
+			fp = 3;
+			goto invalid_fld;
+		}
 	}
 
 	switch(pg) {
@@ -2313,13 +2422,13 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 		break;
 
 	case CONTROL_MPAGE:
-		p += ata_msense_control(args->dev, p, page_control == 1);
+		p += ata_msense_control(args->dev, p, spg, page_control == 1);
 		break;
 
 	case ALL_MPAGES:
 		p += ata_msense_rw_recovery(p, page_control == 1);
 		p += ata_msense_caching(args->id, p, page_control == 1);
-		p += ata_msense_control(args->dev, p, page_control == 1);
+		p += ata_msense_control(args->dev, p, spg, page_control == 1);
 		break;
 
 	default:		/* invalid page code */
@@ -2338,10 +2447,7 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 			memcpy(rbuf + 4, sat_blk_desc, sizeof(sat_blk_desc));
 		}
 	} else {
-		unsigned int output_len = p - rbuf - 2;
-
-		rbuf[0] = output_len >> 8;
-		rbuf[1] = output_len;
+		put_unaligned_be16(p - rbuf - 2, &rbuf[0]);
 		rbuf[3] |= dpofua;
 		if (ebd) {
 			rbuf[7] = sizeof(sat_blk_desc);
@@ -3640,7 +3746,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
 	/*
 	 * Check that read-only bits are not modified.
 	 */
-	ata_msense_control(dev, mpage, false);
+	ata_msense_control_spg0(dev, mpage, false);
 	for (i = 0; i < CONTROL_MPAGE_LEN - 2; i++) {
 		if (i == 0)
 			continue;
-- 
2.39.0

