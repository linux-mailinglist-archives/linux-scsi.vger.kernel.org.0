Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4708FD0E8
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Nov 2019 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKNWZs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Nov 2019 17:25:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWZs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Nov 2019 17:25:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id l7so8662680wrp.6;
        Thu, 14 Nov 2019 14:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LCRmSHXQ6fd0/08i2+2axIrSb/OOjGhvuV19oUa9iAk=;
        b=opx6b3qqK0zewsWJaPJO/a3lDUQ6/DlGffntdGhDOsofHzJnMXqtVFUcdOGd3gjcwO
         NiMKzFpALgfcw/RkLjRHyW0zvPUxLEOIbkwKGU6KtnveYiTPUkJQCeB0YpVLCtCKTBEE
         Nz4QM+MrmwVlwRy9iJtfd0srTYIYdsFoam+H2vf0+eU1djxLAp4zLfevr9GNfXQfhGJN
         s0B6pD64TN+BY6U/EKByVl6d2pUz4XUMKV7bvzlniN/DEcmjyjgWt4zdzo09phHCexsB
         /T0eAgrXZ+urJ2TxYc5KD6jpv5PSz6ZvHI+jDzAjoCOC0r9FnI1f4kwhXTRwYUyCdtuH
         ANOQ==
X-Gm-Message-State: APjAAAWW6iwqrYYSUuzjNYFIi6ssYsTuhnd0DoWhovWIdmgzWzof6w3c
        4YsaWW1Y06upcuF5bdCEBRFqLavJ018=
X-Google-Smtp-Source: APXvYqzG1mn2xhVtpRaUHOvWvGbxfIsG6AXOJPqdrZyPmiFmiV0yOIa2vy6eDiV47zI7W0JQPCOasQ==
X-Received: by 2002:adf:c449:: with SMTP id a9mr1132082wrg.240.1573770345172;
        Thu, 14 Nov 2019 14:25:45 -0800 (PST)
Received: from localhost.localdomain (2001-1c06-18c6-e000-0cda-4949-05a4-23b4.cable.dynamic.v6.ziggo.nl. [2001:1c06:18c6:e000:cda:4949:5a4:23b4])
        by smtp.gmail.com with ESMTPSA id d11sm8814903wrn.28.2019.11.14.14.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:25:44 -0800 (PST)
From:   Kars de Jong <jongk@linux-m68k.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-scsi@vger.kernel.org, linux-m68k@vger.kernel.org,
        schmitzmic@gmail.com, fthain@telegraphics.com.au,
        Kars de Jong <jongk@linux-m68k.org>
Subject: [PATCH v3 2/2] esp_scsi: Add support for FSC chip
Date:   Thu, 14 Nov 2019 23:25:18 +0100
Message-Id: <20191114222518.2441-3-jongk@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114222518.2441-1-jongk@linux-m68k.org>
References: <20191114215956.21767-1-jongk@linux-m68k.org>
 <20191114222518.2441-1-jongk@linux-m68k.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The FSC (NCR53CF9x-2 / SYM53CF9x-2) has a different family code than QLogic
or Emulex parts. This caused it to be detected as a FAS100A.

Unforunately, this meant the configuration of the CONFIG3 register was
incorrect. This causes data transfer issues with FAST-SCSI targets.

The FSC also has the CONFIG4 register. It can be used to enable a feature
called Active Negation which should always be enabled according to the data
manual.

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
---
 drivers/scsi/esp_scsi.c | 19 ++++++++++++-------
 drivers/scsi/esp_scsi.h | 24 ++++++++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 4fc3eee3138b..e887ea3e514a 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -243,7 +243,7 @@ static void esp_set_all_config3(struct esp *esp, u8 val)
 /* Reset the ESP chip, _not_ the SCSI bus. */
 static void esp_reset_esp(struct esp *esp)
 {
-	u8 family_code, version;
+	u8 family_code;
 
 	/* Now reset the ESP chip */
 	scsi_esp_cmd(esp, ESP_CMD_RC);
@@ -257,13 +257,16 @@ static void esp_reset_esp(struct esp *esp)
 	 */
 	esp->max_period = ((35 * esp->ccycle) / 1000);
 	if (esp->rev == FAST) {
-		version = esp_read8(ESP_UID);
-		family_code = (version & 0xf8) >> 3;
-		if (family_code == 0x02)
+		family_code = ESP_FAMILY(esp_read8(ESP_UID));
+		if (family_code == ESP_UID_F236)
 			esp->rev = FAS236;
-		else if (family_code == 0x0a)
+		else if (family_code == ESP_UID_HME)
 			esp->rev = FASHME; /* Version is usually '5'. */
-		else
+		else if (family_code == ESP_UID_FSC) {
+			esp->rev = FSC;
+			/* Enable Active Negation */
+			esp_write8(ESP_CONFIG4_RADE, ESP_CFG4);
+		} else
 			esp->rev = FAS100A;
 		esp->min_period = ((4 * esp->ccycle) / 1000);
 	} else {
@@ -308,7 +311,8 @@ static void esp_reset_esp(struct esp *esp)
 
 	case FAS236:
 	case PCSCSI:
-		/* Fast 236, AM53c974 or HME */
+	case FSC:
+		/* Fast 236, AM53c974, FSC or HME */
 		esp_write8(esp->config2, ESP_CFG2);
 		if (esp->rev == FASHME) {
 			u8 cfg3 = esp->target[0].esp_config3;
@@ -2374,6 +2378,7 @@ static const char *esp_chip_names[] = {
 	"ESP236",
 	"FAS236",
 	"AM53C974",
+	"FSC",
 	"FAS100A",
 	"FAST",
 	"FASHME",
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index f764d64e1f25..a673dec1b8a1 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -78,12 +78,14 @@
 #define ESP_CONFIG3_IMS       0x80     /* ID msg chk'ng        (esp/fas236)  */
 #define ESP_CONFIG3_OBPUSH    0x80     /* Push odd-byte to dma (hme)         */
 
-/* ESP config register 4 read-write, found only on am53c974 chips */
-#define ESP_CONFIG4_RADE      0x04     /* Active negation */
-#define ESP_CONFIG4_RAE       0x08     /* Active negation on REQ and ACK */
-#define ESP_CONFIG4_PWD       0x20     /* Reduced power feature */
-#define ESP_CONFIG4_GE0       0x40     /* Glitch eater bit 0 */
-#define ESP_CONFIG4_GE1       0x80     /* Glitch eater bit 1 */
+/* ESP config register 4 read-write, found on am53c974 and FSC chips */
+#define ESP_CONFIG4_BBTE      0x01     /* Back-to-back transfers     (fsc)   */
+#define ESP_CONGIG4_TEST      0x02     /* Transfer counter test mode (fsc)   */
+#define ESP_CONFIG4_RADE      0x04     /* Active negation   (am53c974/fsc)   */
+#define ESP_CONFIG4_RAE       0x08     /* Act. negation REQ/ACK (am53c974)   */
+#define ESP_CONFIG4_PWD       0x20     /* Reduced power feature (am53c974)   */
+#define ESP_CONFIG4_GE0       0x40     /* Glitch eater bit 0    (am53c974)   */
+#define ESP_CONFIG4_GE1       0x80     /* Glitch eater bit 1    (am53c974)   */
 
 #define ESP_CONFIG_GE_12NS    (0)
 #define ESP_CONFIG_GE_25NS    (ESP_CONFIG_GE1)
@@ -209,10 +211,15 @@
 #define ESP_TEST_TS           0x04     /* Tristate test mode */
 
 /* ESP unique ID register read-only, found on fas236+fas100a only */
+#define ESP_UID_FAM           0xf8     /* ESP family bitmask */
+
+#define ESP_FAMILY(uid) (((uid) & ESP_UID_FAM) >> 3)
+
+/* Values for the ESP family bits */
 #define ESP_UID_F100A         0x00     /* ESP FAS100A  */
 #define ESP_UID_F236          0x02     /* ESP FAS236   */
-#define ESP_UID_REV           0x07     /* ESP revision */
-#define ESP_UID_FAM           0xf8     /* ESP family   */
+#define ESP_UID_HME           0x0a     /* FAS HME      */
+#define ESP_UID_FSC           0x14     /* NCR/Symbios Logic FSC */
 
 /* ESP fifo flags register read-only */
 /* Note that the following implies a 16 byte FIFO on the ESP. */
@@ -264,6 +271,7 @@ enum esp_rev {
 	ESP236,
 	FAS236,
 	PCSCSI,  /* AM53c974 */
+	FSC,     /* NCR/Symbios Logic FSC */
 	FAS100A,
 	FAST,
 	FASHME,
-- 
2.17.1

