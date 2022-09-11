Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B155B5180
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Sep 2022 00:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKWPk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Sep 2022 18:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIKWP1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 11 Sep 2022 18:15:27 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A9175A9
        for <linux-scsi@vger.kernel.org>; Sun, 11 Sep 2022 15:15:21 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i15so5507770qvp.5
        for <linux-scsi@vger.kernel.org>; Sun, 11 Sep 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8ziVCmPswsTN9vpw0/QikQFB0bqZmuNbVJP5cOLeHTA=;
        b=Dx8HTxSzdWO/BDcW+xVj3zDwyY/zyccfM1eLqnD1x3mKx6zSAPEt01E9fnwNEjnTNz
         jj056MLWO3FP+ruAsHbV1tQrNEmG/Lw2TuBEbTEt63PmDMOXopLQ9YGyHe1aCQbyEd2y
         JMWMszGdANrX1xaeeU1S64H354MsPuCZ3Th5CoD9B22O0px7nB4h7DgF489qymjxMioi
         xdLYAtFVy06l+BnyTpMUI+SeOLM3MryDtinAYHkWLVhCVaTD8OUKocgRR2Ff0660xYzA
         9wAlarm+5bq6nnWKGXEwiWQuXN4eu5F80k/AJ/JFi//lxi1vooiAAmKdWm5NTlBKTFfL
         sOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8ziVCmPswsTN9vpw0/QikQFB0bqZmuNbVJP5cOLeHTA=;
        b=1sDtBo5zI/sQOaqnTS93QaXNYAW5/PUmrZltvXpcymFKahWb8Jy3vvN3ikFB9Vwq36
         ijbsywbZZTsNSPq/KoIMT1jZLqW9TLUBoFkU/6sSnaiGkPhkkP0uC8iUUA1EH1faZ1Pi
         PscVTwM6xnpgpMPLpJUHQ8mOhK7ZYSwNGF90s5xM6omoXljaulDtZLZhlO+wuZhx58dn
         ceuepYb3bYEhbgar1KKgbpWQ8guj+B4AFizeewGxH4nUHLfhnJDqUvFon0zatrged2Me
         dyEJVfkkPc8xwD0yyJg7m3CaqM4hpiGIwx1jUn1MCA7h/xTBlOhJZFIoTgn+Sgg81Ihq
         0RRQ==
X-Gm-Message-State: ACgBeo3JNVFQ/ESObBba4QUDU+3GuC8ORgJpORZQjvihhV05H6Rno5s7
        zQKBZ9RZGQbadliZIDY2Pu9+IgrhSLE=
X-Google-Smtp-Source: AA6agR5Dunv4f6Rp+4CFACpRSPE3/eG1VVPLW8qMY+E7H7ji+VD8voEqRR+tRNEIk43Lp6qYKYZtEg==
X-Received: by 2002:a05:6214:1947:b0:4aa:9e87:d032 with SMTP id q7-20020a056214194700b004aa9e87d032mr20272299qvk.114.1662934519664;
        Sun, 11 Sep 2022 15:15:19 -0700 (PDT)
Received: from localhost.localdomain (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id x8-20020a05622a000800b0035a70d82d7bsm5324305qtw.47.2022.09.11.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:15:19 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 10/13] lpfc: Rework FDMI attribute registration for unintential padding
Date:   Sun, 11 Sep 2022 15:15:02 -0700
Message-Id: <20220911221505.117655-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220911221505.117655-1-jsmart2021@gmail.com>
References: <20220911221505.117655-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Removed the lpfc_fdmi_attr_entry and lpfc_fdmi_attr_def structures
that had a union causing unintentional zero padding, which
required the usage of __packed.  They are replaced with explicit
lpfc_fdmi_attr_u32, lpfc_fdmi_attr_wwn, lpfc_fdmi_attr_fc4types,
and lpfc_fdmi_attr_string structure defines instead of living in
a union.  This rids of ambiguous compiler zero padding, and entailed
cleaning up bitwise endian declarations.

As such, all FDMI attribute registration routines are replaced
with generic void *arg and handlers for each of the newly defined
attribute structure types.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_ct.c | 961 ++++++++++++------------------------
 drivers/scsi/lpfc/lpfc_hw.h |  58 ++-
 2 files changed, 350 insertions(+), 669 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 8979e0e164b3..75fd2bfc212b 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2501,420 +2501,298 @@ lpfc_fdmi_change_check(struct lpfc_vport *vport)
 	}
 }
 
-/* Routines for all individual HBA attributes */
-static int
-lpfc_fdmi_hba_attr_wwnn(struct lpfc_vport *vport, struct lpfc_fdmi_attr_def *ad)
+static inline int
+lpfc_fdmi_set_attr_u32(void *attr, uint16_t attrtype, uint32_t attrval)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	struct lpfc_fdmi_attr_u32 *ae = attr;
+	int size = sizeof(*ae);
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	ae->type = cpu_to_be16(attrtype);
+	ae->len = cpu_to_be16(size);
+	ae->value_u32 = cpu_to_be32(attrval);
 
-	memcpy(&ae->un.AttrWWN, &vport->fc_sparam.nodeName,
-	       sizeof(struct lpfc_name));
-	size = FOURBYTES + sizeof(struct lpfc_name);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_NODENAME);
 	return size;
 }
-static int
-lpfc_fdmi_hba_attr_manufacturer(struct lpfc_vport *vport,
-				struct lpfc_fdmi_attr_def *ad)
+
+static inline int
+lpfc_fdmi_set_attr_wwn(void *attr, uint16_t attrtype, struct lpfc_name *wwn)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_fdmi_attr_wwn *ae = attr;
+	int size = sizeof(*ae);
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	ae->type = cpu_to_be16(attrtype);
+	ae->len = cpu_to_be16(size);
+	/* WWN's assumed to be bytestreams - Big Endian presentation */
+	memcpy(ae->name, wwn,
+	       min_t(size_t, sizeof(struct lpfc_name), sizeof(__be64)));
 
-	/* This string MUST be consistent with other FC platforms
-	 * supported by Broadcom.
-	 */
-	strncpy(ae->un.AttrString,
-		"Emulex Corporation",
-		       sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_MANUFACTURER);
 	return size;
 }
 
-static int
-lpfc_fdmi_hba_attr_sn(struct lpfc_vport *vport, struct lpfc_fdmi_attr_def *ad)
+static inline int
+lpfc_fdmi_set_attr_fullwwn(void *attr, uint16_t attrtype,
+			   struct lpfc_name *wwnn, struct lpfc_name *wwpn)
 {
-	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_fdmi_attr_fullwwn *ae = attr;
+	u8 *nname = ae->nname;
+	u8 *pname = ae->pname;
+	int size = sizeof(*ae);
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	ae->type = cpu_to_be16(attrtype);
+	ae->len = cpu_to_be16(size);
+	/* WWN's assumed to be bytestreams - Big Endian presentation */
+	memcpy(nname, wwnn,
+	       min_t(size_t, sizeof(struct lpfc_name), sizeof(__be64)));
+	memcpy(pname, wwpn,
+	       min_t(size_t, sizeof(struct lpfc_name), sizeof(__be64)));
 
-	strncpy(ae->un.AttrString, phba->SerialNumber,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_SERIAL_NUMBER);
 	return size;
 }
 
-static int
-lpfc_fdmi_hba_attr_model(struct lpfc_vport *vport,
-			 struct lpfc_fdmi_attr_def *ad)
+static inline int
+lpfc_fdmi_set_attr_string(void *attr, uint16_t attrtype, char *attrstring)
 {
-	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_fdmi_attr_string *ae = attr;
+	int len, size;
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	/*
+	 * We are trusting the caller that if a fdmi string field
+	 * is capped at 64 bytes, the caller passes in a string of
+	 * 64 bytes or less.
+	 */
 
-	strncpy(ae->un.AttrString, phba->ModelName,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString, sizeof(ae->un.AttrString));
+	strncpy(ae->value_string, attrstring, sizeof(ae->value_string));
+	len = strnlen(ae->value_string, sizeof(ae->value_string));
+	/* round string length to a 32bit boundary. Ensure there's a NULL */
 	len += (len & 3) ? (4 - (len & 3)) : 4;
+	/* size is Type/Len (4 bytes) plus string length */
 	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_MODEL);
+
+	ae->type = cpu_to_be16(attrtype);
+	ae->len = cpu_to_be16(size);
+
 	return size;
 }
 
-static int
-lpfc_fdmi_hba_attr_description(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+/* Bitfields for FC4 Types that can be reported */
+#define ATTR_FC4_CT	0x00000001
+#define ATTR_FC4_FCP	0x00000002
+#define ATTR_FC4_NVME	0x00000004
+
+static inline int
+lpfc_fdmi_set_attr_fc4types(void *attr, uint16_t attrtype, uint32_t typemask)
 {
-	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_fdmi_attr_fc4types *ae = attr;
+	int size = sizeof(*ae);
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	ae->type = cpu_to_be16(attrtype);
+	ae->len = cpu_to_be16(size);
+
+	if (typemask & ATTR_FC4_FCP)
+		ae->value_types[2] = 0x01; /* Type 0x8 - FCP */
+
+	if (typemask & ATTR_FC4_CT)
+		ae->value_types[7] = 0x01; /* Type 0x20 - CT */
+
+	if (typemask & ATTR_FC4_NVME)
+		ae->value_types[6] = 0x01; /* Type 0x28 - NVME */
 
-	strncpy(ae->un.AttrString, phba->ModelDesc,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-				  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_MODEL_DESCRIPTION);
 	return size;
 }
 
+/* Routines for all individual HBA attributes */
 static int
-lpfc_fdmi_hba_attr_hdw_ver(struct lpfc_vport *vport,
-			   struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_wwnn(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_hba *phba = vport->phba;
-	lpfc_vpd_t *vp = &phba->vpd;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t i, j, incr, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	/* Convert JEDEC ID to ascii for hardware version */
-	incr = vp->rev.biuRev;
-	for (i = 0; i < 8; i++) {
-		j = (incr & 0xf);
-		if (j <= 9)
-			ae->un.AttrString[7 - i] =
-			    (char)((uint8_t) 0x30 +
-				   (uint8_t) j);
-		else
-			ae->un.AttrString[7 - i] =
-			    (char)((uint8_t) 0x61 +
-				   (uint8_t) (j - 10));
-		incr = (incr >> 4);
-	}
-	size = FOURBYTES + 8;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_HARDWARE_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_wwn(attr, RHBA_NODENAME,
+			&vport->fc_sparam.nodeName);
 }
 
 static int
-lpfc_fdmi_hba_attr_drvr_ver(struct lpfc_vport *vport,
-			    struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_manufacturer(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	/* This string MUST be consistent with other FC platforms
+	 * supported by Broadcom.
+	 */
+	return lpfc_fdmi_set_attr_string(attr, RHBA_MANUFACTURER,
+			"Emulex Corporation");
+}
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+static int
+lpfc_fdmi_hba_attr_sn(struct lpfc_vport *vport, void *attr)
+{
+	struct lpfc_hba *phba = vport->phba;
 
-	strncpy(ae->un.AttrString, lpfc_release_version,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_DRIVER_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_SERIAL_NUMBER,
+			phba->SerialNumber);
 }
 
 static int
-lpfc_fdmi_hba_attr_rom_ver(struct lpfc_vport *vport,
-			   struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_model(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
 
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		lpfc_decode_firmware_rev(phba, ae->un.AttrString, 1);
-	else
-		strncpy(ae->un.AttrString, phba->OptionROMVersion,
-			sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_OPTION_ROM_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_MODEL,
+			phba->ModelName);
 }
 
 static int
-lpfc_fdmi_hba_attr_fmw_ver(struct lpfc_vport *vport,
-			   struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_description(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
 
-	lpfc_decode_firmware_rev(phba, ae->un.AttrString, 1);
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_FIRMWARE_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_MODEL_DESCRIPTION,
+			phba->ModelDesc);
 }
 
 static int
-lpfc_fdmi_hba_attr_os_ver(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_hdw_ver(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_hba *phba = vport->phba;
+	lpfc_vpd_t *vp = &phba->vpd;
+	char buf[16] = { 0 };
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	snprintf(buf, sizeof(buf), "%08x", vp->rev.biuRev);
 
-	snprintf(ae->un.AttrString, sizeof(ae->un.AttrString), "%s %s %s",
-		 init_utsname()->sysname,
-		 init_utsname()->release,
-		 init_utsname()->version);
+	return lpfc_fdmi_set_attr_string(attr, RHBA_HARDWARE_VERSION, buf);
+}
 
-	len = strnlen(ae->un.AttrString, sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_OS_NAME_VERSION);
-	return size;
+static int
+lpfc_fdmi_hba_attr_drvr_ver(struct lpfc_vport *vport, void *attr)
+{
+	return lpfc_fdmi_set_attr_string(attr, RHBA_DRIVER_VERSION,
+			lpfc_release_version);
 }
 
 static int
-lpfc_fdmi_hba_attr_ct_len(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_rom_ver(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	struct lpfc_hba *phba = vport->phba;
+	char buf[64] = { 0 };
 
-	ae = &ad->AttrValue;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		lpfc_decode_firmware_rev(phba, buf, 1);
 
-	ae->un.AttrInt =  cpu_to_be32(LPFC_MAX_CT_SIZE);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_MAX_CT_PAYLOAD_LEN);
-	return size;
+		return lpfc_fdmi_set_attr_string(attr, RHBA_OPTION_ROM_VERSION,
+				buf);
+	}
+
+	return lpfc_fdmi_set_attr_string(attr, RHBA_OPTION_ROM_VERSION,
+			phba->OptionROMVersion);
 }
 
 static int
-lpfc_fdmi_hba_attr_symbolic_name(struct lpfc_vport *vport,
-				 struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_fmw_ver(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	struct lpfc_hba *phba = vport->phba;
+	char buf[64] = { 0 };
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	lpfc_decode_firmware_rev(phba, buf, 1);
 
-	len = lpfc_vport_symbolic_node_name(vport,
-				ae->un.AttrString, 256);
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_SYM_NODENAME);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_FIRMWARE_VERSION, buf);
 }
 
 static int
-lpfc_fdmi_hba_attr_vendor_info(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_os_ver(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	char buf[256] = { 0 };
+
+	snprintf(buf, sizeof(buf), "%s %s %s",
+		 init_utsname()->sysname,
+		 init_utsname()->release,
+		 init_utsname()->version);
 
-	ae = &ad->AttrValue;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_OS_NAME_VERSION, buf);
+}
 
-	/* Nothing is defined for this currently */
-	ae->un.AttrInt =  cpu_to_be32(0);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_VENDOR_INFO);
-	return size;
+static int
+lpfc_fdmi_hba_attr_ct_len(struct lpfc_vport *vport, void *attr)
+{
+	return lpfc_fdmi_set_attr_u32(attr, RHBA_MAX_CT_PAYLOAD_LEN,
+			LPFC_MAX_CT_SIZE);
 }
 
 static int
-lpfc_fdmi_hba_attr_num_ports(struct lpfc_vport *vport,
-			     struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_symbolic_name(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	char buf[256] = { 0 };
 
-	ae = &ad->AttrValue;
+	lpfc_vport_symbolic_node_name(vport, buf, sizeof(buf));
 
-	/* Each driver instance corresponds to a single port */
-	ae->un.AttrInt =  cpu_to_be32(1);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_NUM_PORTS);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_SYM_NODENAME, buf);
 }
 
 static int
-lpfc_fdmi_hba_attr_fabric_wwnn(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_vendor_info(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	return lpfc_fdmi_set_attr_u32(attr, RHBA_VENDOR_INFO, 0);
+}
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+static int
+lpfc_fdmi_hba_attr_num_ports(struct lpfc_vport *vport, void *attr)
+{
+	/* Each driver instance corresponds to a single port */
+	return lpfc_fdmi_set_attr_u32(attr, RHBA_NUM_PORTS, 1);
+}
 
-	memcpy(&ae->un.AttrWWN, &vport->fabric_nodename,
-	       sizeof(struct lpfc_name));
-	size = FOURBYTES + sizeof(struct lpfc_name);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_FABRIC_WWNN);
-	return size;
+static int
+lpfc_fdmi_hba_attr_fabric_wwnn(struct lpfc_vport *vport, void *attr)
+{
+	return lpfc_fdmi_set_attr_wwn(attr, RHBA_FABRIC_WWNN,
+			&vport->fabric_nodename);
 }
 
 static int
-lpfc_fdmi_hba_attr_bios_ver(struct lpfc_vport *vport,
-			    struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_bios_ver(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
 
-	strlcat(ae->un.AttrString, phba->BIOSVersion,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_BIOS_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_BIOS_VERSION,
+			phba->BIOSVersion);
 }
 
 static int
-lpfc_fdmi_hba_attr_bios_state(struct lpfc_vport *vport,
-			      struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_bios_state(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-
 	/* Driver doesn't have access to this information */
-	ae->un.AttrInt =  cpu_to_be32(0);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_BIOS_STATE);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RHBA_BIOS_STATE, 0);
 }
 
 static int
-lpfc_fdmi_hba_attr_vendor_id(struct lpfc_vport *vport,
-			     struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_hba_attr_vendor_id(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	strncpy(ae->un.AttrString, "EMULEX",
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RHBA_VENDOR_ID);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RHBA_VENDOR_ID, "EMULEX");
 }
 
-/* Routines for all individual PORT attributes */
+/*
+ * Routines for all individual PORT attributes
+ */
+
 static int
-lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport,
-			    struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba   *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	u32 fc4types;
 
-	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
-	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
+	fc4types = (ATTR_FC4_CT | ATTR_FC4_FCP);
 
 	/* Check to see if Firmware supports NVME and on physical port */
 	if ((phba->sli_rev == LPFC_SLI_REV4) && (vport == phba->pport) &&
 	    phba->sli4_hba.pc_sli4_params.nvme)
-		ae->un.AttrTypes[6] = 0x01; /* Type 0x28 - NVME */
+		fc4types |= ATTR_FC4_NVME;
 
-	size = FOURBYTES + 32;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SUPPORTED_FC4_TYPES);
-	return size;
+	return lpfc_fdmi_set_attr_fc4types(attr, RPRT_SUPPORTED_FC4_TYPES,
+			fc4types);
 }
 
 static int
-lpfc_fdmi_port_attr_support_speed(struct lpfc_vport *vport,
-				  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_support_speed(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_hba   *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	struct lpfc_hba *phba = vport->phba;
+	u32 speeds = 0;
 	u32 tcfg;
 	u8 i, cnt;
 
-	ae = &ad->AttrValue;
-
-	ae->un.AttrInt = 0;
 	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
 		cnt = 0;
 		if (phba->sli_rev == LPFC_SLI_REV4) {
@@ -2926,539 +2804,314 @@ lpfc_fdmi_port_attr_support_speed(struct lpfc_vport *vport,
 
 		if (cnt > 2) { /* 4 lane trunk group */
 			if (phba->lmt & LMT_64Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_256GFC;
+				speeds |= HBA_PORTSPEED_256GFC;
 			if (phba->lmt & LMT_32Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_128GFC;
+				speeds |= HBA_PORTSPEED_128GFC;
 			if (phba->lmt & LMT_16Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_64GFC;
+				speeds |= HBA_PORTSPEED_64GFC;
 		} else if (cnt) { /* 2 lane trunk group */
 			if (phba->lmt & LMT_128Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_256GFC;
+				speeds |= HBA_PORTSPEED_256GFC;
 			if (phba->lmt & LMT_64Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_128GFC;
+				speeds |= HBA_PORTSPEED_128GFC;
 			if (phba->lmt & LMT_32Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_64GFC;
+				speeds |= HBA_PORTSPEED_64GFC;
 			if (phba->lmt & LMT_16Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_32GFC;
+				speeds |= HBA_PORTSPEED_32GFC;
 		} else {
 			if (phba->lmt & LMT_256Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_256GFC;
+				speeds |= HBA_PORTSPEED_256GFC;
 			if (phba->lmt & LMT_128Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_128GFC;
+				speeds |= HBA_PORTSPEED_128GFC;
 			if (phba->lmt & LMT_64Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_64GFC;
+				speeds |= HBA_PORTSPEED_64GFC;
 			if (phba->lmt & LMT_32Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_32GFC;
+				speeds |= HBA_PORTSPEED_32GFC;
 			if (phba->lmt & LMT_16Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_16GFC;
+				speeds |= HBA_PORTSPEED_16GFC;
 			if (phba->lmt & LMT_10Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_10GFC;
+				speeds |= HBA_PORTSPEED_10GFC;
 			if (phba->lmt & LMT_8Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_8GFC;
+				speeds |= HBA_PORTSPEED_8GFC;
 			if (phba->lmt & LMT_4Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_4GFC;
+				speeds |= HBA_PORTSPEED_4GFC;
 			if (phba->lmt & LMT_2Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_2GFC;
+				speeds |= HBA_PORTSPEED_2GFC;
 			if (phba->lmt & LMT_1Gb)
-				ae->un.AttrInt |= HBA_PORTSPEED_1GFC;
+				speeds |= HBA_PORTSPEED_1GFC;
 		}
 	} else {
 		/* FCoE links support only one speed */
 		switch (phba->fc_linkspeed) {
 		case LPFC_ASYNC_LINK_SPEED_10GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_10GE;
+			speeds = HBA_PORTSPEED_10GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_25GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_25GE;
+			speeds = HBA_PORTSPEED_25GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_40GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_40GE;
+			speeds = HBA_PORTSPEED_40GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_100GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_100GE;
+			speeds = HBA_PORTSPEED_100GE;
 			break;
 		}
 	}
-	ae->un.AttrInt = cpu_to_be32(ae->un.AttrInt);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SUPPORTED_SPEED);
-	return size;
+
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_SUPPORTED_SPEED, speeds);
 }
 
 static int
-lpfc_fdmi_port_attr_speed(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_speed(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba   *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
+	u32 speeds = 0;
 
 	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
 		switch (phba->fc_linkspeed) {
 		case LPFC_LINK_SPEED_1GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_1GFC;
+			speeds = HBA_PORTSPEED_1GFC;
 			break;
 		case LPFC_LINK_SPEED_2GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_2GFC;
+			speeds = HBA_PORTSPEED_2GFC;
 			break;
 		case LPFC_LINK_SPEED_4GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_4GFC;
+			speeds = HBA_PORTSPEED_4GFC;
 			break;
 		case LPFC_LINK_SPEED_8GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_8GFC;
+			speeds = HBA_PORTSPEED_8GFC;
 			break;
 		case LPFC_LINK_SPEED_10GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_10GFC;
+			speeds = HBA_PORTSPEED_10GFC;
 			break;
 		case LPFC_LINK_SPEED_16GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_16GFC;
+			speeds = HBA_PORTSPEED_16GFC;
 			break;
 		case LPFC_LINK_SPEED_32GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_32GFC;
+			speeds = HBA_PORTSPEED_32GFC;
 			break;
 		case LPFC_LINK_SPEED_64GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_64GFC;
+			speeds = HBA_PORTSPEED_64GFC;
 			break;
 		case LPFC_LINK_SPEED_128GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_128GFC;
+			speeds = HBA_PORTSPEED_128GFC;
 			break;
 		case LPFC_LINK_SPEED_256GHZ:
-			ae->un.AttrInt = HBA_PORTSPEED_256GFC;
+			speeds = HBA_PORTSPEED_256GFC;
 			break;
 		default:
-			ae->un.AttrInt = HBA_PORTSPEED_UNKNOWN;
+			speeds = HBA_PORTSPEED_UNKNOWN;
 			break;
 		}
 	} else {
 		switch (phba->fc_linkspeed) {
 		case LPFC_ASYNC_LINK_SPEED_10GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_10GE;
+			speeds = HBA_PORTSPEED_10GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_25GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_25GE;
+			speeds = HBA_PORTSPEED_25GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_40GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_40GE;
+			speeds = HBA_PORTSPEED_40GE;
 			break;
 		case LPFC_ASYNC_LINK_SPEED_100GBPS:
-			ae->un.AttrInt = HBA_PORTSPEED_100GE;
+			speeds = HBA_PORTSPEED_100GE;
 			break;
 		default:
-			ae->un.AttrInt = HBA_PORTSPEED_UNKNOWN;
+			speeds = HBA_PORTSPEED_UNKNOWN;
 			break;
 		}
 	}
 
-	ae->un.AttrInt = cpu_to_be32(ae->un.AttrInt);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_PORT_SPEED);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_PORT_SPEED, speeds);
 }
 
 static int
-lpfc_fdmi_port_attr_max_frame(struct lpfc_vport *vport,
-			      struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_max_frame(struct lpfc_vport *vport, void *attr)
 {
-	struct serv_parm *hsp;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
+	struct serv_parm *hsp = (struct serv_parm *)&vport->fc_sparam;
 
-	hsp = (struct serv_parm *)&vport->fc_sparam;
-	ae->un.AttrInt = (((uint32_t) hsp->cmn.bbRcvSizeMsb & 0x0F) << 8) |
-			  (uint32_t) hsp->cmn.bbRcvSizeLsb;
-	ae->un.AttrInt = cpu_to_be32(ae->un.AttrInt);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_MAX_FRAME_SIZE);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_MAX_FRAME_SIZE,
+			(((uint32_t)hsp->cmn.bbRcvSizeMsb & 0x0F) << 8) |
+			  (uint32_t)hsp->cmn.bbRcvSizeLsb);
 }
 
 static int
-lpfc_fdmi_port_attr_os_devname(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_os_devname(struct lpfc_vport *vport, void *attr)
 {
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	char buf[64] = { 0 };
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	snprintf(buf, sizeof(buf), "/sys/class/scsi_host/host%d",
+		 shost->host_no);
 
-	snprintf(ae->un.AttrString, sizeof(ae->un.AttrString),
-		 "/sys/class/scsi_host/host%d", shost->host_no);
-	len = strnlen((char *)ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_OS_DEVICE_NAME);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_OS_DEVICE_NAME, buf);
 }
 
 static int
-lpfc_fdmi_port_attr_host_name(struct lpfc_vport *vport,
-			      struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_host_name(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	char buf[64] = { 0 };
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	scnprintf(buf, sizeof(buf), "%s", vport->phba->os_host_name);
 
-	scnprintf(ae->un.AttrString, sizeof(ae->un.AttrString), "%s",
-		  vport->phba->os_host_name);
-
-	len = strnlen(ae->un.AttrString, sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_HOST_NAME);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_HOST_NAME, buf);
 }
 
 static int
-lpfc_fdmi_port_attr_wwnn(struct lpfc_vport *vport,
-			 struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_wwnn(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	memcpy(&ae->un.AttrWWN, &vport->fc_sparam.nodeName,
-	       sizeof(struct lpfc_name));
-	size = FOURBYTES + sizeof(struct lpfc_name);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_NODENAME);
-	return size;
+	return lpfc_fdmi_set_attr_wwn(attr, RPRT_NODENAME,
+			&vport->fc_sparam.nodeName);
 }
 
 static int
-lpfc_fdmi_port_attr_wwpn(struct lpfc_vport *vport,
-			 struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_wwpn(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	memcpy(&ae->un.AttrWWN, &vport->fc_sparam.portName,
-	       sizeof(struct lpfc_name));
-	size = FOURBYTES + sizeof(struct lpfc_name);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_PORTNAME);
-	return size;
+	return lpfc_fdmi_set_attr_wwn(attr, RPRT_PORTNAME,
+			&vport->fc_sparam.portName);
 }
 
 static int
-lpfc_fdmi_port_attr_symbolic_name(struct lpfc_vport *vport,
-				  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_symbolic_name(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
+	char buf[256] = { 0 };
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
+	lpfc_vport_symbolic_port_name(vport, buf, sizeof(buf));
 
-	len = lpfc_vport_symbolic_port_name(vport, ae->un.AttrString, 256);
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SYM_PORTNAME);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_SYM_PORTNAME, buf);
 }
 
 static int
-lpfc_fdmi_port_attr_port_type(struct lpfc_vport *vport,
-			      struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_port_type(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
 
-	ae = &ad->AttrValue;
-	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP)
-		ae->un.AttrInt =  cpu_to_be32(LPFC_FDMI_PORTTYPE_NLPORT);
-	else
-		ae->un.AttrInt =  cpu_to_be32(LPFC_FDMI_PORTTYPE_NPORT);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_PORT_TYPE);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_PORT_TYPE,
+			(phba->fc_topology == LPFC_TOPOLOGY_LOOP) ?
+				LPFC_FDMI_PORTTYPE_NLPORT :
+				LPFC_FDMI_PORTTYPE_NPORT);
 }
 
 static int
-lpfc_fdmi_port_attr_class(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_class(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	ae->un.AttrInt = cpu_to_be32(FC_COS_CLASS2 | FC_COS_CLASS3);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SUPPORTED_CLASS);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_SUPPORTED_CLASS,
+			FC_COS_CLASS2 | FC_COS_CLASS3);
 }
 
 static int
-lpfc_fdmi_port_attr_fabric_wwpn(struct lpfc_vport *vport,
-				struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_fabric_wwpn(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	memcpy(&ae->un.AttrWWN, &vport->fabric_portname,
-	       sizeof(struct lpfc_name));
-	size = FOURBYTES + sizeof(struct lpfc_name);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_FABRICNAME);
-	return size;
+	return lpfc_fdmi_set_attr_wwn(attr, RPRT_FABRICNAME,
+			&vport->fabric_portname);
 }
 
 static int
-lpfc_fdmi_port_attr_active_fc4type(struct lpfc_vport *vport,
-				   struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_active_fc4type(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
+	u32 fc4types;
 
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
-	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
+	fc4types = (ATTR_FC4_CT | ATTR_FC4_FCP);
 
 	/* Check to see if NVME is configured or not */
 	if (vport == phba->pport &&
 	    phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
-		ae->un.AttrTypes[6] = 0x1; /* Type 0x28 - NVME */
+		fc4types |= ATTR_FC4_NVME;
 
-	size = FOURBYTES + 32;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_ACTIVE_FC4_TYPES);
-	return size;
+	return lpfc_fdmi_set_attr_fc4types(attr, RPRT_ACTIVE_FC4_TYPES,
+			fc4types);
 }
 
 static int
-lpfc_fdmi_port_attr_port_state(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_port_state(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	/* Link Up - operational */
-	ae->un.AttrInt =  cpu_to_be32(LPFC_FDMI_PORTSTATE_ONLINE);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_PORT_STATE);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_PORT_STATE,
+			LPFC_FDMI_PORTSTATE_ONLINE);
 }
 
 static int
-lpfc_fdmi_port_attr_num_disc(struct lpfc_vport *vport,
-			     struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_num_disc(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
 	vport->fdmi_num_disc = lpfc_find_map_node(vport);
-	ae->un.AttrInt = cpu_to_be32(vport->fdmi_num_disc);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_DISC_PORT);
-	return size;
+
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_DISC_PORT,
+			vport->fdmi_num_disc);
 }
 
 static int
-lpfc_fdmi_port_attr_nportid(struct lpfc_vport *vport,
-			    struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_port_attr_nportid(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	ae->un.AttrInt =  cpu_to_be32(vport->fc_myDID);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_PORT_ID);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_PORT_ID, vport->fc_myDID);
 }
 
 static int
-lpfc_fdmi_smart_attr_service(struct lpfc_vport *vport,
-			     struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_service(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	strncpy(ae->un.AttrString, "Smart SAN Initiator",
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_SERVICE);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_SMART_SERVICE,
+			"Smart SAN Initiator");
 }
 
 static int
-lpfc_fdmi_smart_attr_guid(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_guid(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	memcpy(&ae->un.AttrString, &vport->fc_sparam.nodeName,
-	       sizeof(struct lpfc_name));
-	memcpy((((uint8_t *)&ae->un.AttrString) +
-		sizeof(struct lpfc_name)),
-		&vport->fc_sparam.portName, sizeof(struct lpfc_name));
-	size = FOURBYTES + (2 * sizeof(struct lpfc_name));
-	ad->AttrLen =  cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_GUID);
-	return size;
+	return lpfc_fdmi_set_attr_fullwwn(attr, RPRT_SMART_GUID,
+			&vport->fc_sparam.nodeName,
+			&vport->fc_sparam.portName);
 }
 
 static int
-lpfc_fdmi_smart_attr_version(struct lpfc_vport *vport,
-			     struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_version(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
-
-	strncpy(ae->un.AttrString, "Smart SAN Version 2.0",
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString,
-			  sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen =  cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_VERSION);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_SMART_VERSION,
+			"Smart SAN Version 2.0");
 }
 
 static int
-lpfc_fdmi_smart_attr_model(struct lpfc_vport *vport,
-			   struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_model(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-
-	ae = &ad->AttrValue;
-	memset(ae, 0, sizeof(*ae));
 
-	strncpy(ae->un.AttrString, phba->ModelName,
-		sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString, sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_MODEL);
-	return size;
+	return lpfc_fdmi_set_attr_string(attr, RPRT_SMART_MODEL,
+			phba->ModelName);
 }
 
 static int
-lpfc_fdmi_smart_attr_port_info(struct lpfc_vport *vport,
-			       struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_port_info(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-
 	/* SRIOV (type 3) is not supported */
-	if (vport->vpi)
-		ae->un.AttrInt =  cpu_to_be32(2);  /* NPIV */
-	else
-		ae->un.AttrInt =  cpu_to_be32(1);  /* Physical */
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_PORT_INFO);
-	return size;
+
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_SMART_PORT_INFO,
+			(vport->vpi) ?  2 /* NPIV */ : 1 /* Physical */);
 }
 
 static int
-lpfc_fdmi_smart_attr_qos(struct lpfc_vport *vport,
-			 struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_qos(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	ae->un.AttrInt =  cpu_to_be32(0);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_QOS);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_SMART_QOS, 0);
 }
 
 static int
-lpfc_fdmi_smart_attr_security(struct lpfc_vport *vport,
-			      struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_smart_attr_security(struct lpfc_vport *vport, void *attr)
 {
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t size;
-
-	ae = &ad->AttrValue;
-	ae->un.AttrInt =  cpu_to_be32(1);
-	size = FOURBYTES + sizeof(uint32_t);
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_SMART_SECURITY);
-	return size;
+	return lpfc_fdmi_set_attr_u32(attr, RPRT_SMART_SECURITY, 1);
 }
 
 static int
-lpfc_fdmi_vendor_attr_mi(struct lpfc_vport *vport,
-			  struct lpfc_fdmi_attr_def *ad)
+lpfc_fdmi_vendor_attr_mi(struct lpfc_vport *vport, void *attr)
 {
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_fdmi_attr_entry *ae;
-	uint32_t len, size;
-	char mibrevision[16];
-
-	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
-	memset(ae, 0, 256);
-	sprintf(mibrevision, "ELXE2EM:%04d",
-		phba->sli4_hba.pc_sli4_params.mi_ver);
-	strncpy(ae->un.AttrString, &mibrevision[0], sizeof(ae->un.AttrString));
-	len = strnlen(ae->un.AttrString, sizeof(ae->un.AttrString));
-	len += (len & 3) ? (4 - (len & 3)) : 4;
-	size = FOURBYTES + len;
-	ad->AttrLen = cpu_to_be16(size);
-	ad->AttrType = cpu_to_be16(RPRT_VENDOR_MI);
-	return size;
+	char buf[32] = { 0 };
+
+	sprintf(buf, "ELXE2EM:%04d", phba->sli4_hba.pc_sli4_params.mi_ver);
+
+	return lpfc_fdmi_set_attr_string(attr, RPRT_VENDOR_MI, buf);
 }
 
 /* RHBA attribute jump table */
 int (*lpfc_fdmi_hba_action[])
-	(struct lpfc_vport *vport, struct lpfc_fdmi_attr_def *ad) = {
+	(struct lpfc_vport *vport, void *attrbuf) = {
 	/* Action routine                 Mask bit     Attribute type */
 	lpfc_fdmi_hba_attr_wwnn,	  /* bit0     RHBA_NODENAME           */
 	lpfc_fdmi_hba_attr_manufacturer,  /* bit1     RHBA_MANUFACTURER       */
@@ -3482,7 +3135,7 @@ int (*lpfc_fdmi_hba_action[])
 
 /* RPA / RPRT attribute jump table */
 int (*lpfc_fdmi_port_action[])
-	(struct lpfc_vport *vport, struct lpfc_fdmi_attr_def *ad) = {
+	(struct lpfc_vport *vport, void *attrbuf) = {
 	/* Action routine                   Mask bit   Attribute type */
 	lpfc_fdmi_port_attr_fc4type,        /* bit0   RPRT_SUPPORT_FC4_TYPES  */
 	lpfc_fdmi_port_attr_support_speed,  /* bit1   RPRT_SUPPORTED_SPEED    */
@@ -3528,16 +3181,16 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct lpfc_sli_ct_request *CtReq;
 	struct ulp_bde64_le *bde;
 	uint32_t bit_pos;
-	uint32_t size;
+	uint32_t size, addsz;
 	uint32_t rsp_size;
 	uint32_t mask;
 	struct lpfc_fdmi_reg_hba *rh;
 	struct lpfc_fdmi_port_entry *pe;
 	struct lpfc_fdmi_reg_portattr *pab = NULL, *base = NULL;
 	struct lpfc_fdmi_attr_block *ab = NULL;
-	int  (*func)(struct lpfc_vport *vport, struct lpfc_fdmi_attr_def *ad);
-	void (*cmpl)(struct lpfc_hba *, struct lpfc_iocbq *,
-		     struct lpfc_iocbq *);
+	int  (*func)(struct lpfc_vport *vport, void *attrbuf);
+	void (*cmpl)(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		     struct lpfc_iocbq *rspiocb);
 
 	if (!ndlp)
 		return 0;
@@ -3623,12 +3276,13 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		while (mask) {
 			if (mask & 0x1) {
 				func = lpfc_fdmi_hba_action[bit_pos];
-				size += func(vport,
-					     (struct lpfc_fdmi_attr_def *)
-					     ((uint8_t *)rh + size));
-				ab->EntryCnt++;
+				addsz = func(vport, ((uint8_t *)rh + size));
+				if (addsz) {
+					ab->EntryCnt++;
+					size += addsz;
+				}
 				/* check if another attribute fits */
-				if ((size + 256) >
+				if ((size + FDMI_MAX_ATTRLEN) >
 				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
 					goto hba_out;
 			}
@@ -3682,12 +3336,13 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		while (mask) {
 			if (mask & 0x1) {
 				func = lpfc_fdmi_port_action[bit_pos];
-				size += func(vport,
-					     (struct lpfc_fdmi_attr_def *)
-					     ((uint8_t *)base + size));
-				pab->ab.EntryCnt++;
+				addsz = func(vport, ((uint8_t *)base + size));
+				if (addsz) {
+					pab->ab.EntryCnt++;
+					size += addsz;
+				}
 				/* check if another attribute fits */
-				if ((size + 256) >
+				if ((size + FDMI_MAX_ATTRLEN) >
 				    (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
 					goto port_out;
 			}
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index cbaf9a0f12c3..5c283936ff08 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -1442,30 +1442,56 @@ struct lpfc_vmid_gallapp_ident_list {
 
 /* Definitions for HBA / Port attribute entries */
 
-/* Attribute Entry */
-struct lpfc_fdmi_attr_entry {
-	union {
-		uint32_t AttrInt;
-		uint8_t  AttrTypes[32];
-		uint8_t  AttrString[256];
-		struct lpfc_name AttrWWN;
-	} un;
+/* Attribute Entry Structures */
+
+struct lpfc_fdmi_attr_u32 {
+	__be16 type;
+	__be16 len;
+	__be32 value_u32;
 };
 
-struct lpfc_fdmi_attr_def { /* Defined in TLV format */
-	/* Structure is in Big Endian format */
-	uint32_t AttrType:16;
-	uint32_t AttrLen:16;
-	/* Marks start of Value (ATTRIBUTE_ENTRY) */
-	struct lpfc_fdmi_attr_entry AttrValue;
-} __packed;
+struct lpfc_fdmi_attr_wwn {
+	__be16 type;
+	__be16 len;
+
+	/* Keep as u8[8] instead of __be64 to avoid accidental zero padding
+	 * by compiler
+	 */
+	u8 name[8];
+};
+
+struct lpfc_fdmi_attr_fullwwn {
+	__be16 type;
+	__be16 len;
+
+	/* Keep as u8[8] instead of __be64 to avoid accidental zero padding
+	 * by compiler
+	 */
+	u8 nname[8];
+	u8 pname[8];
+};
+
+struct lpfc_fdmi_attr_fc4types {
+	__be16 type;
+	__be16 len;
+	u8 value_types[32];
+};
+
+struct lpfc_fdmi_attr_string {
+	__be16 type;
+	__be16 len;
+	char value_string[256];
+};
+
+/* Maximum FDMI attribute length is Type+Len (4 bytes) + 256 byte string */
+#define FDMI_MAX_ATTRLEN	sizeof(struct lpfc_fdmi_attr_string)
 
 /*
  * HBA Attribute Block
  */
 struct lpfc_fdmi_attr_block {
 	uint32_t EntryCnt;		/* Number of HBA attribute entries */
-	struct lpfc_fdmi_attr_entry Entry;	/* Variable-length array */
+	/* Variable Length Attribute Entry TLV's follow */
 };
 
 /*
-- 
2.35.3

