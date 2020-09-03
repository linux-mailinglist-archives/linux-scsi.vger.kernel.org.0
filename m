Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB125B958
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Sep 2020 05:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgICDo6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Sep 2020 23:44:58 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45025 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgICDoz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Sep 2020 23:44:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 00EA05C004A;
        Wed,  2 Sep 2020 23:44:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 02 Sep 2020 23:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=cLdXYCjb1PSkR
        /OkRyE3dj5ZaoULm6qCHjNwEVBr8Ho=; b=JYCeObzeWqO6uut9YLltlENmY6DMu
        yvPweKVcEWSKcujkleyE3kHjBorriGtxh1ePK7pCiHIx++uSQVaY+09knOczf1gl
        RGMVS2A9advdJ1hRiF1qFO4b3ulblJ02140z47c4URxw1lVOuO65TVPU1N3KpUax
        YpRwpLI739FzobcqE3wfJFFVJuw6KxJSWYq6v+4Qz1PYHmKwMct8XwBb7iSO1JkM
        deR/MCUUcFISrUqKr3bT5MTLCVUQeg7ec6v1HU4NhnXIBEQcq4OXc/xNK1OV9oew
        gDgQp0i3+Yv7K6jVOBEt/sc+RmgqeaUJ0UXQ4OacAPif2xBu4uzTWJR3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cLdXYCjb1PSkR/OkRyE3dj5ZaoULm6qCHjNwEVBr8Ho=; b=PoecTJJQ
        zyopYBj1vQjRhN2hiLeR8l6EDh9a7tNSvHE9Ec+oVbZ6wPLjWiZscR5pgBR9WgYK
        xtzEqwVOVgnKe1Ay8qLUsoFOi22cm+TseyLVr5HrgvFNrX5aCAvRHBg6iHLz+ps+
        BnZFa8B9O87GgHkCflX0l80yMiZnigLEeYkTHBJ4LEr7QkLShfMPN59ZJnJA8hTE
        Waf5XpY2Yy2kGD6K8W34dcVz71hn9KBSrjSh/oGFovZ5Xuly6M9uYh/SLAYfQGEs
        0kkMGtYdhX1wCuHeo2fD2B5uiPCudOi+oueDoTr3qrhMZOKun/Uo3yxXP+hAWK5e
        xqs7GFhzhgRGXA==
X-ME-Sender: <xms:tGZQX_ODPx6gBoCqAzyZv1zrfjhJ3pEeJGJeg6tMir5hQm_IhjFH0A>
    <xme:tGZQX5-ckZe9L0mvd_iPL1klwGe1hjJBeND4k2t7GtBBPNXjcI3sQ1XzDSvEg6HzM
    23trOAiu8M3Kcc7kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehieffkeehuedtjeekveetjeejffegffegueehfeelieetkefg
    ledtgfffgfenucffohhmrghinhepnhgvfigtohhmmhgrnhgurdhsghenucfkphepjedtrd
    dufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:tGZQX-ThqpeX7E1gM6HzRMmn3094Ja-t0Rdi9RXEaihb_3jFvPpKlg>
    <xmx:tGZQXztyyFUPlPWLbithU42dzKj26vom0hv-JS4HE-owQHosLPV_qQ>
    <xmx:tGZQX3dpoVHCA4QuR0URc6_skq3n6PxEV901Z5UbADr5an9JJ4IlSQ>
    <xmx:tGZQX4E-rSZWhrvhO2t4xDdfnU-r5FbtFFeBkcrsW7Zj5f-d5VJ9VA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 36AF030600A6;
        Wed,  2 Sep 2020 23:44:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 3/3] scsi: 3w-9xxx: Fix endianness issues in command packets
Date:   Wed,  2 Sep 2020 22:44:50 -0500
Message-Id: <20200903034450.5491-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903034450.5491-1-samuel@sholland.org>
References: <20200903034450.5491-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The controller expects all data it sends/receives to be little-endian.
Therefore, the packet struct definitions should use the __le16/32/64
types. Once those are correct, sparse reports several issues with the
driver code, which are fixed here as well.

The main issue observed was at the call to scsi_set_resid, where the
byteswapped parameter would eventually trigger the alignment check at
drivers/scsi/sd.c:2009. At that point, the kernel would continuously
complain about an "Unaligned partial completion", and no further I/O
could occur.

This gets the controller working on big endian powerpc64.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes since v3: None.

---
 drivers/scsi/3w-9xxx.c |  56 ++++++++++-----------
 drivers/scsi/3w-9xxx.h | 111 +++++++++++++++++++++--------------------
 2 files changed, 81 insertions(+), 86 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index aad9b3b73e15..593863317dc7 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -303,10 +303,10 @@ static int twa_aen_drain_queue(TW_Device_Extension *tw_dev, int no_check_reset)
 
 	/* Initialize sglist */
 	memset(&sglist, 0, sizeof(TW_SG_Entry));
-	sglist[0].length = TW_SECTOR_SIZE;
-	sglist[0].address = tw_dev->generic_buffer_phys[request_id];
+	sglist[0].length = cpu_to_le32(TW_SECTOR_SIZE);
+	sglist[0].address = TW_CPU_TO_SGL(tw_dev->generic_buffer_phys[request_id]);
 
-	if (sglist[0].address & TW_ALIGNMENT_9000_SGL) {
+	if (tw_dev->generic_buffer_phys[request_id] & TW_ALIGNMENT_9000_SGL) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1, "Found unaligned address during AEN drain");
 		goto out;
 	}
@@ -440,8 +440,8 @@ static int twa_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
 
 	/* Initialize sglist */
 	memset(&sglist, 0, sizeof(TW_SG_Entry));
-	sglist[0].length = TW_SECTOR_SIZE;
-	sglist[0].address = tw_dev->generic_buffer_phys[request_id];
+	sglist[0].length = cpu_to_le32(TW_SECTOR_SIZE);
+	sglist[0].address = TW_CPU_TO_SGL(tw_dev->generic_buffer_phys[request_id]);
 
 	/* Mark internal command */
 	tw_dev->srb[request_id] = NULL;
@@ -501,9 +501,8 @@ static void twa_aen_sync_time(TW_Device_Extension *tw_dev, int request_id)
            Sunday 12:00AM */
 	local_time = (ktime_get_real_seconds() - (sys_tz.tz_minuteswest * 60));
 	div_u64_rem(local_time - (3 * 86400), 604800, &schedulertime);
-	schedulertime = cpu_to_le32(schedulertime % 604800);
 
-	memcpy(param->data, &schedulertime, sizeof(u32));
+	memcpy(param->data, &(__le32){cpu_to_le32(schedulertime)}, sizeof(__le32));
 
 	/* Mark internal command */
 	tw_dev->srb[request_id] = NULL;
@@ -1004,19 +1003,13 @@ static int twa_fill_sense(TW_Device_Extension *tw_dev, int request_id, int copy_
 		if (print_host)
 			printk(KERN_WARNING "3w-9xxx: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
 			       tw_dev->host->host_no,
-			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
-			       full_command_packet->header.status_block.error,
-			       error_str[0] == '\0' ?
-			       twa_string_lookup(twa_error_table,
-						 full_command_packet->header.status_block.error) : error_str,
+			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR, error,
+			       error_str[0] ? error_str : twa_string_lookup(twa_error_table, error),
 			       full_command_packet->header.err_specific_desc);
 		else
 			printk(KERN_WARNING "3w-9xxx: ERROR: (0x%02X:0x%04X): %s:%s.\n",
-			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
-			       full_command_packet->header.status_block.error,
-			       error_str[0] == '\0' ?
-			       twa_string_lookup(twa_error_table,
-						 full_command_packet->header.status_block.error) : error_str,
+			       TW_MESSAGE_SOURCE_CONTROLLER_ERROR, error,
+			       error_str[0] ? error_str : twa_string_lookup(twa_error_table, error),
 			       full_command_packet->header.err_specific_desc);
 	}
 
@@ -1133,12 +1126,11 @@ static int twa_initconnection(TW_Device_Extension *tw_dev, int message_credits,
 	tw_initconnect->opcode__reserved = TW_OPRES_IN(0, TW_OP_INIT_CONNECTION);
 	tw_initconnect->request_id = request_id;
 	tw_initconnect->message_credits = cpu_to_le16(message_credits);
-	tw_initconnect->features = set_features;
 
 	/* Turn on 64-bit sgl support if we need to */
-	tw_initconnect->features |= sizeof(dma_addr_t) > 4 ? 1 : 0;
+	set_features |= sizeof(dma_addr_t) > 4 ? 1 : 0;
 
-	tw_initconnect->features = cpu_to_le32(tw_initconnect->features);
+	tw_initconnect->features = cpu_to_le32(set_features);
 
 	if (set_features & TW_EXTENDED_INIT_CONNECT) {
 		tw_initconnect->size = TW_INIT_COMMAND_PACKET_SIZE_EXTENDED;
@@ -1351,8 +1343,10 @@ static irqreturn_t twa_interrupt(int irq, void *dev_instance)
 
 				/* Report residual bytes for single sgl */
 				if ((scsi_sg_count(cmd) <= 1) && (full_command_packet->command.newcommand.status == 0)) {
-					if (full_command_packet->command.newcommand.sg_list[0].length < scsi_bufflen(tw_dev->srb[request_id]))
-						scsi_set_resid(cmd, scsi_bufflen(cmd) - full_command_packet->command.newcommand.sg_list[0].length);
+					u32 length = le32_to_cpu(full_command_packet->command.newcommand.sg_list[0].length);
+
+					if (length < scsi_bufflen(cmd))
+						scsi_set_resid(cmd, scsi_bufflen(cmd) - length);
 				}
 
 				/* Now complete the io */
@@ -1394,13 +1388,13 @@ static void twa_load_sgl(TW_Device_Extension *tw_dev, TW_Command_Full *full_comm
 	if (TW_OP_OUT(full_command_packet->command.newcommand.opcode__reserved) == TW_OP_EXECUTE_SCSI) {
 		newcommand = &full_command_packet->command.newcommand;
 		newcommand->request_id__lunl =
-			cpu_to_le16(TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->request_id__lunl), request_id));
+			TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->request_id__lunl), request_id);
 		if (length) {
 			newcommand->sg_list[0].address = TW_CPU_TO_SGL(dma_handle + sizeof(TW_Ioctl_Buf_Apache));
 			newcommand->sg_list[0].length = cpu_to_le32(length);
 		}
 		newcommand->sgl_entries__lunh =
-			cpu_to_le16(TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->sgl_entries__lunh), length ? 1 : 0));
+			TW_REQ_LUN_IN(TW_LUN_OUT(newcommand->sgl_entries__lunh), length ? 1 : 0);
 	} else {
 		oldcommand = &full_command_packet->command.oldcommand;
 		oldcommand->request_id = request_id;
@@ -1841,10 +1835,10 @@ static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 	if (srb) {
 		command_packet->unit = srb->device->id;
 		command_packet->request_id__lunl =
-			cpu_to_le16(TW_REQ_LUN_IN(srb->device->lun, request_id));
+			TW_REQ_LUN_IN(srb->device->lun, request_id);
 	} else {
 		command_packet->request_id__lunl =
-			cpu_to_le16(TW_REQ_LUN_IN(0, request_id));
+			TW_REQ_LUN_IN(0, request_id);
 		command_packet->unit = 0;
 	}
 
@@ -1876,19 +1870,19 @@ static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 					}
 				}
 			}
-			command_packet->sgl_entries__lunh = cpu_to_le16(TW_REQ_LUN_IN((srb->device->lun >> 4), scsi_sg_count(tw_dev->srb[request_id])));
+			command_packet->sgl_entries__lunh = TW_REQ_LUN_IN((srb->device->lun >> 4), scsi_sg_count(tw_dev->srb[request_id]));
 		}
 	} else {
 		/* Internal cdb post */
 		for (i = 0; i < use_sg; i++) {
-			command_packet->sg_list[i].address = TW_CPU_TO_SGL(sglistarg[i].address);
-			command_packet->sg_list[i].length = cpu_to_le32(sglistarg[i].length);
+			command_packet->sg_list[i].address = sglistarg[i].address;
+			command_packet->sg_list[i].length = sglistarg[i].length;
 			if (command_packet->sg_list[i].address & TW_CPU_TO_SGL(TW_ALIGNMENT_9000_SGL)) {
 				TW_PRINTK(tw_dev->host, TW_DRIVER, 0x2f, "Found unaligned sgl address during internal post");
 				goto out;
 			}
 		}
-		command_packet->sgl_entries__lunh = cpu_to_le16(TW_REQ_LUN_IN(0, use_sg));
+		command_packet->sgl_entries__lunh = TW_REQ_LUN_IN(0, use_sg);
 	}
 
 	if (srb) {
@@ -2113,7 +2107,7 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 				     TW_PARAM_FWVER, TW_PARAM_FWVER_LENGTH),
 	       (char *)twa_get_param(tw_dev, 1, TW_VERSION_TABLE,
 				     TW_PARAM_BIOSVER, TW_PARAM_BIOSVER_LENGTH),
-	       le32_to_cpu(*(int *)twa_get_param(tw_dev, 2, TW_INFORMATION_TABLE,
+	       le32_to_cpu(*(__le32 *)twa_get_param(tw_dev, 2, TW_INFORMATION_TABLE,
 				     TW_PARAM_PORTCOUNT, TW_PARAM_PORTCOUNT_LENGTH)));
 
 	/* Try to enable MSI */
diff --git a/drivers/scsi/3w-9xxx.h b/drivers/scsi/3w-9xxx.h
index 36b865eca67d..f71ed3a64aaf 100644
--- a/drivers/scsi/3w-9xxx.h
+++ b/drivers/scsi/3w-9xxx.h
@@ -434,8 +434,8 @@ static twa_message_type twa_error_table[] = {
 #define TW_RESID_OUT(x) ((x >> 4) & 0xff)
 
 /* request_id: 12, lun: 4 */
-#define TW_REQ_LUN_IN(lun, request_id) (((lun << 12) & 0xf000) | (request_id & 0xfff))
-#define TW_LUN_OUT(lun) ((lun >> 12) & 0xf)
+#define TW_REQ_LUN_IN(lun, request_id) cpu_to_le16(((lun << 12) & 0xf000) | (request_id & 0xfff))
+#define TW_LUN_OUT(lun) ((le16_to_cpu(lun) >> 12) & 0xf)
 
 /* Macros */
 #define TW_CONTROL_REG_ADDR(x) (x->base_addr)
@@ -469,74 +469,75 @@ printk(KERN_WARNING "3w-9xxx: ERROR: (0x%02X:0x%04X): %s.\n",a,b,c); \
 #define TW_APACHE_MAX_SGL_LENGTH (sizeof(dma_addr_t) > 4 ? 72 : 109)
 #define TW_ESCALADE_MAX_SGL_LENGTH (sizeof(dma_addr_t) > 4 ? 41 : 62)
 #define TW_PADDING_LENGTH (sizeof(dma_addr_t) > 4 ? 8 : 0)
-#define TW_CPU_TO_SGL(x) (sizeof(dma_addr_t) > 4 ? cpu_to_le64(x) : cpu_to_le32(x))
 
 #if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
-typedef u64 twa_addr_t;
+typedef __le64 twa_addr_t;
+#define TW_CPU_TO_SGL(x) cpu_to_le64(x)
 #else
-typedef u32 twa_addr_t;
+typedef __le32 twa_addr_t;
+#define TW_CPU_TO_SGL(x) cpu_to_le32(x)
 #endif
 
 /* Scatter Gather List Entry */
 typedef struct TAG_TW_SG_Entry {
-	twa_addr_t address;
-	u32 length;
+	twa_addr_t	address;
+	__le32		length;
 } __packed TW_SG_Entry;
 
 /* Command Packet */
 typedef struct TW_Command {
-	unsigned char opcode__sgloffset;
-	unsigned char size;
-	unsigned char request_id;
-	unsigned char unit__hostid;
+	u8	opcode__sgloffset;
+	u8	size;
+	u8	request_id;
+	u8	unit__hostid;
 	/* Second DWORD */
-	unsigned char status;
-	unsigned char flags;
+	u8	status;
+	u8	flags;
 	union {
-		unsigned short block_count;
-		unsigned short parameter_count;
+		__le16	block_count;
+		__le16	parameter_count;
 	} byte6_offset;
 	union {
 		struct {
-			u32 lba;
-			TW_SG_Entry sgl[TW_ESCALADE_MAX_SGL_LENGTH];
-			twa_addr_t padding;
+			__le32		lba;
+			TW_SG_Entry	sgl[TW_ESCALADE_MAX_SGL_LENGTH];
+			twa_addr_t	padding;
 		} io;
 		struct {
-			TW_SG_Entry sgl[TW_ESCALADE_MAX_SGL_LENGTH];
-			u32 padding;
-			twa_addr_t padding2;
+			TW_SG_Entry	sgl[TW_ESCALADE_MAX_SGL_LENGTH];
+			__le32		padding;
+			twa_addr_t	padding2;
 		} param;
 	} byte8_offset;
 } TW_Command;
 
 /* Command Packet for 9000+ controllers */
 typedef struct TAG_TW_Command_Apache {
-	unsigned char opcode__reserved;
-	unsigned char unit;
-	unsigned short request_id__lunl;
-	unsigned char status;
-	unsigned char sgl_offset;
-	unsigned short sgl_entries__lunh;
-	unsigned char cdb[16];
-	TW_SG_Entry sg_list[TW_APACHE_MAX_SGL_LENGTH];
-	unsigned char padding[TW_PADDING_LENGTH];
+	u8		opcode__reserved;
+	u8		unit;
+	__le16		request_id__lunl;
+	u8		status;
+	u8		sgl_offset;
+	__le16		sgl_entries__lunh;
+	u8		cdb[16];
+	TW_SG_Entry	sg_list[TW_APACHE_MAX_SGL_LENGTH];
+	u8		padding[TW_PADDING_LENGTH];
 } TW_Command_Apache;
 
 /* New command packet header */
 typedef struct TAG_TW_Command_Apache_Header {
 	unsigned char sense_data[TW_SENSE_DATA_LENGTH];
 	struct {
-		char reserved[4];
-		unsigned short error;
-		unsigned char padding;
-		unsigned char severity__reserved;
+		u8	reserved[4];
+		__le16	error;
+		u8	padding;
+		u8	severity__reserved;
 	} status_block;
 	unsigned char err_specific_desc[98];
 	struct {
-		unsigned char size_header;
-		unsigned char reserved[2];
-		unsigned char size_sense;
+		u8	size_header;
+		u8	reserved[2];
+		u8	size_sense;
 	} header_desc;
 } TW_Command_Apache_Header;
 
@@ -551,19 +552,19 @@ typedef struct TAG_TW_Command_Full {
 
 /* Initconnection structure */
 typedef struct TAG_TW_Initconnect {
-	unsigned char opcode__reserved;
-	unsigned char size;
-	unsigned char request_id;
-	unsigned char res2;
-	unsigned char status;
-	unsigned char flags;
-	unsigned short message_credits;
-	u32 features;
-	unsigned short fw_srl;
-	unsigned short fw_arch_id;
-	unsigned short fw_branch;
-	unsigned short fw_build;
-	u32 result;
+	u8	opcode__reserved;
+	u8	size;
+	u8	request_id;
+	u8	res2;
+	u8	status;
+	u8	flags;
+	__le16	message_credits;
+	__le32	features;
+	__le16	fw_srl;
+	__le16	fw_arch_id;
+	__le16	fw_branch;
+	__le16	fw_build;
+	__le32	result;
 } TW_Initconnect;
 
 /* Event info structure */
@@ -604,11 +605,11 @@ typedef struct TAG_TW_Lock {
 
 /* GetParam descriptor */
 typedef struct {
-	unsigned short	table_id;
-	unsigned short	parameter_id;
-	unsigned short	parameter_size_bytes;
-	unsigned short  actual_parameter_size_bytes;
-	unsigned char	data[];
+	__le16	table_id;
+	__le16	parameter_id;
+	__le16	parameter_size_bytes;
+	__le16  actual_parameter_size_bytes;
+	u8	data[];
 } TW_Param_Apache, *PTW_Param_Apache;
 
 /* Response queue */
-- 
2.26.2

