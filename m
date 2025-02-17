Return-Path: <linux-scsi+bounces-12254-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC2FA33B32
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB617A1C72
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1A201006;
	Thu, 13 Feb 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="aFIG63FB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A39201276
	for <linux-scsi@vger.kernel.org>; Thu, 13 Feb 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438831; cv=none; b=sVP91VKaVsS8B7J5RCHTrBvEhZypLXjVm+uf12xJQ2SK9SOlfu1pklUKBJQUvcfBkuh+HD2tUhaXXyJb9Q1BWPWNq1kc9IiVXh68nQGEUehtSSOmgfFYl2nUSnbErATjiDkEwaEkGn9439YHLAamtqtuPlEq82j22qYKMR3f3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438831; c=relaxed/simple;
	bh=VUHJFk0CnezStKBELk6FTw7Sa2MfJOjjVzD8OOp8LME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLZE4RfeTR83YBbH0jPf42XWUKMvYm2BVBxOniyOLwq/iby3tmkCOmzHfGnHMsWO4zUGUZJ7Bjf05EYIkIX3jbBtERpzDiSYTXMG7m7fAxaf/mAN5aCoXxKujkilSgfM34mlYW1lSlke8/2EBs8sjDIDDhJj5AGXd7VFTDuoKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=aFIG63FB; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from:to:cc:reply-to:subject:date:
	 in-reply-to:references:list-archive:list-subscribe:list-unsubscribe:
	 content-type:content-transfer-encoding:message-id;
	bh=bci7daIHKcaYex+A2BpJE9y5Fc6Z3majs0k6+84i1lY=;
	b=aFIG63FBknclvbwPH0YpdERf+SUcuIWsnRW9wsK5Z34Y/jodVWMUzbP4kUxiG3gVMSY/j55KeMx43
	 c63whLbdlLYPD5cyat2sNT8JWStTLjJ78xDOP0kgJJmHdz7IQy6hXupL+apzzuaPVFWIQx5Af47vLr
	 IoNcq/0cLEHgMfln9Te/o6bnCoCNLa3o+gih08OZzZ985efYxlC/prgcVFeFjAhD1AJZ+kwjxgydfM
	 wg1sCdwtC4JKpnWBh/DuAHK774iqGVpC7evJZNTWc+fozMstKD7SmDLOzmXqsE+a7qDIgUr436gurG
	 j/OwOZ/SuxF/ugs9qFSkX5uk+8qPo5A==
Received: from kaipn1.makisara.private (85-156-116-90.elisa-laajakaista.fi [85.156.116.90])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTPSA
	id aa74bedb-e9ec-11ef-838a-005056bdf889;
	Thu, 13 Feb 2025 11:26:55 +0200 (EET)
From: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
To: linux-scsi@vger.kernel.org,
	dgilbert@interlog.com
Cc: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	jmeneghi@redhat.com,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Subject: [PATCH v2 3/7] scsi: scsi_debug: Add write support with block lengths and 4 bytes of data
Date: Thu, 13 Feb 2025 11:26:32 +0200
Message-ID: <20250213092636.2510-4-Kai.Makisara@kolumbus.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213092636.2510-1-Kai.Makisara@kolumbus.fi>
References: <20250213092636.2510-1-Kai.Makisara@kolumbus.fi>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tape is implemented as fixed number (10 000) of 8-byte units.
The first four bytes of a unit contains the type of the unit (data
block, filemark or end-of-data mark). If the units is a data block,
the first four bytes contain the block length and the remaining
four bytes the first bytes of written data. This allows the user
to use tags to see that the read block is what it was supposed to be.

The tape can contain two partitions. Initially it is formatted as one
partition consisting of all 10 000 units.

This patch adds the WRITE(6) command for tapes and the WRITE FILEMARKS (6)
command. The REWIND command is updated.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
---
v1 -> v2:
- changed 'for (;' to 'for (i = 0;' in partition_tape() to fix the bug
  reported by the Kernel Test Robot

 drivers/scsi/scsi_debug.c | 217 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 21c64f79797a..69cae4c1712a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -71,6 +71,10 @@ static const char *sdebug_version_date = "20210520";
 #define NO_ADDITIONAL_SENSE 0x0
 #define OVERLAP_ATOMIC_COMMAND_ASC 0x0
 #define OVERLAP_ATOMIC_COMMAND_ASCQ 0x23
+#define FILEMARK_DETECTED_ASCQ 0x1
+#define EOP_EOM_DETECTED_ASCQ 0x2
+#define BEGINNING_OF_P_M_DETECTED_ASCQ 0x4
+#define EOD_DETECTED_ASCQ 0x5
 #define LOGICAL_UNIT_NOT_READY 0x4
 #define LOGICAL_UNIT_COMMUNICATION_FAILURE 0x8
 #define UNRECOVERED_READ_ERR 0x11
@@ -83,6 +87,7 @@ static const char *sdebug_version_date = "20210520";
 #define UA_READY_ASC 0x28
 #define UA_RESET_ASC 0x29
 #define UA_CHANGED_ASC 0x2a
+#define TOO_MANY_IN_PARTITION_ASC 0x3b
 #define TARGET_CHANGED_ASC 0x3f
 #define LUNS_CHANGED_ASCQ 0x0e
 #define INSUFF_RES_ASC 0x55
@@ -180,7 +185,29 @@ static const char *sdebug_version_date = "20210520";
 #define TAPE_DEF_BLKSIZE  0
 #define TAPE_MIN_BLKSIZE  512
 #define TAPE_MAX_BLKSIZE  1048576
+#define TAPE_EW 20
 #define TAPE_MAX_PARTITIONS 2
+#define TAPE_UNITS 10000
+
+/* The tape block data definitions */
+#define TAPE_BLOCK_FM_FLAG   ((u32)0x1 << 30)
+#define TAPE_BLOCK_EOD_FLAG  ((u32)0x2 << 30)
+#define TAPE_BLOCK_MARK_MASK ((u32)0x3 << 30)
+#define TAPE_BLOCK_SIZE_MASK (~TAPE_BLOCK_MARK_MASK)
+#define TAPE_BLOCK_MARK(a) (a & TAPE_BLOCK_MARK_MASK)
+#define TAPE_BLOCK_SIZE(a) (a & TAPE_BLOCK_SIZE_MASK)
+#define IS_TAPE_BLOCK_FM(a)   ((a & TAPE_BLOCK_FM_FLAG) != 0)
+#define IS_TAPE_BLOCK_EOD(a)  ((a & TAPE_BLOCK_EOD_FLAG) != 0)
+
+struct tape_block {
+	u32 fl_size;
+	unsigned char data[4];
+};
+
+/* Flags for sense data */
+#define SENSE_FLAG_FILEMARK  0x80
+#define SENSE_FLAG_EOM 0x40
+#define SENSE_FLAG_ILI 0x20
 
 #define SDEBUG_LUN_0_VAL 0
 
@@ -377,7 +404,10 @@ struct sdebug_dev_info {
 	unsigned int tape_blksize;
 	unsigned int tape_density;
 	unsigned char tape_partition;
+	unsigned char tape_nbr_partitions;
 	unsigned int tape_location[TAPE_MAX_PARTITIONS];
+	unsigned int tape_eop[TAPE_MAX_PARTITIONS];
+	struct tape_block *tape_blocks[TAPE_MAX_PARTITIONS];
 
 	struct dentry *debugfs_entry;
 	struct spinlock list_lock;
@@ -501,7 +531,8 @@ enum sdeb_opcode_index {
 	SDEB_I_ATOMIC_WRITE_16 = 32,
 	SDEB_I_READ_BLOCK_LIMITS = 33,
 	SDEB_I_LOCATE = 34,
-	SDEB_I_LAST_ELEM_P1 = 35,	/* keep this last (previous + 1) */
+	SDEB_I_WRITE_FILEMARKS = 35,
+	SDEB_I_LAST_ELEM_P1 = 36,	/* keep this last (previous + 1) */
 };
 
 
@@ -510,8 +541,8 @@ static const unsigned char opcode_ind_arr[256] = {
 	SDEB_I_TEST_UNIT_READY, SDEB_I_REZERO_UNIT, 0, SDEB_I_REQUEST_SENSE,
 	    0, SDEB_I_READ_BLOCK_LIMITS, 0, 0,
 	SDEB_I_READ, 0, SDEB_I_WRITE, 0, 0, 0, 0, 0,
-	0, 0, SDEB_I_INQUIRY, 0, 0, SDEB_I_MODE_SELECT, SDEB_I_RESERVE,
-	    SDEB_I_RELEASE,
+	SDEB_I_WRITE_FILEMARKS, 0, SDEB_I_INQUIRY, 0, 0,
+	    SDEB_I_MODE_SELECT, SDEB_I_RESERVE, SDEB_I_RELEASE,
 	0, 0, SDEB_I_MODE_SENSE, SDEB_I_START_STOP, 0, SDEB_I_SEND_DIAG,
 	    SDEB_I_ALLOW_REMOVAL, 0,
 /* 0x20; 0x20->0x3f: 10 byte cdbs */
@@ -593,6 +624,8 @@ static int resp_finish_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rwp_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_read_blklimits(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_locate(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_write_filemarks(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_rewind(struct scsi_cmnd *, struct sdebug_dev_info *);
 
 static int sdebug_do_add_host(bool mk_new_store);
 static int sdebug_add_host_helper(int per_host_idx);
@@ -793,7 +826,7 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 /* 20 */
 	{0, 0x1e, 0, 0, NULL, NULL, /* ALLOW REMOVAL */
 	    {6,  0, 0, 0, 0x3, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x1, 0, 0, NULL, NULL, /* REWIND ?? */
+	{0, 0x1, 0, 0, resp_rewind, NULL,
 	    {6,  0x1, 0, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 	{0, 0, 0, F_INV_OP | FF_RESPOND, NULL, NULL, /* ATA_PT */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
@@ -841,6 +874,8 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	{0, 0x2b, 0, F_D_UNKN, resp_locate, NULL,    /* LOCATE (10) */
 	    {10,  0x2, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },
+	{0, 0x10, 0, F_D_IN, resp_write_filemarks, NULL,    /* WRITE FILEMARKS (6) */
+	    {6,  0x01, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 
 /* sentinel */
 	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
@@ -1358,6 +1393,30 @@ static void mk_sense_buffer(struct scsi_cmnd *scp, int key, int asc, int asq)
 			    my_name, key, asc, asq);
 }
 
+/* Sense data that has information fields for tapes */
+static void mk_sense_info_tape(struct scsi_cmnd *scp, int key, int asc, int asq,
+			unsigned int information, unsigned char tape_flags)
+{
+	if (!scp->sense_buffer) {
+		sdev_printk(KERN_ERR, scp->device,
+			    "%s: sense_buffer is NULL\n", __func__);
+		return;
+	}
+	memset(scp->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
+
+	scsi_build_sense(scp, /*sdebug_dsense*/ 0, key, asc, asq);
+	/* only fixed format so far */
+
+	scp->sense_buffer[0] |= 0x80; /* valid */
+	scp->sense_buffer[2] |= tape_flags;
+	put_unaligned_be32(information, &scp->sense_buffer[3]);
+
+	if (sdebug_verbose)
+		sdev_printk(KERN_INFO, scp->device,
+			    "%s:  [sense_key,asc,ascq]: [0x%x,0x%x,0x%x]\n",
+			    my_name, key, asc, asq);
+}
+
 static void mk_sense_invalid_opcode(struct scsi_cmnd *scp)
 {
 	mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_OPCODE, 0);
@@ -3252,7 +3311,7 @@ static int resp_locate(struct scsi_cmnd *scp,
 	unsigned char *cmd = scp->cmnd;
 
 	if ((cmd[1] & 0x02) != 0) {
-		if (cmd[8] >= TAPE_MAX_PARTITIONS) {
+		if (cmd[8] >= devip->tape_nbr_partitions) {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 8, -1);
 			return check_condition_result;
 		}
@@ -3264,6 +3323,71 @@ static int resp_locate(struct scsi_cmnd *scp,
 	return 0;
 }
 
+static int resp_write_filemarks(struct scsi_cmnd *scp,
+		struct sdebug_dev_info *devip)
+{
+	unsigned char *cmd = scp->cmnd;
+	unsigned int i, count, pos;
+	u32 data;
+	int partition = devip->tape_partition;
+
+	if ((cmd[1] & 0xfe) != 0) { /* probably write setmarks, not in >= SCSI-3 */
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 1, 1);
+		return check_condition_result;
+	}
+	count = get_unaligned_be24(cmd + 2);
+	data = TAPE_BLOCK_FM_FLAG;
+	for (i = 0, pos = devip->tape_location[partition]; i < count; i++, pos++) {
+		if (pos >= devip->tape_eop[partition] - 1) { /* don't overwrite EOD */
+			devip->tape_location[partition] = devip->tape_eop[partition] - 1;
+			mk_sense_info_tape(scp, VOLUME_OVERFLOW, NO_ADDITIONAL_SENSE,
+					EOP_EOM_DETECTED_ASCQ, count, SENSE_FLAG_EOM);
+			return check_condition_result;
+		}
+		(devip->tape_blocks[partition] + pos)->fl_size = data;
+	}
+	(devip->tape_blocks[partition] + pos)->fl_size =
+		TAPE_BLOCK_EOD_FLAG;
+	devip->tape_location[partition] = pos;
+
+	return 0;
+}
+
+static int resp_rewind(struct scsi_cmnd *scp,
+		struct sdebug_dev_info *devip)
+{
+	devip->tape_location[devip->tape_partition] = 0;
+
+	return 0;
+}
+
+static int partition_tape(struct sdebug_dev_info *devip, int nbr_partitions,
+			int part_0_size, int part_1_size)
+{
+	int i;
+
+	if (part_0_size + part_1_size > TAPE_UNITS)
+		return -1;
+	devip->tape_eop[0] = part_0_size;
+	devip->tape_blocks[0]->fl_size = TAPE_BLOCK_EOD_FLAG;
+	devip->tape_eop[1] = part_1_size;
+	devip->tape_blocks[1] = devip->tape_blocks[0] +
+			devip->tape_eop[0];
+	devip->tape_blocks[1]->fl_size = TAPE_BLOCK_EOD_FLAG;
+
+	for (i = 0 ; i < TAPE_MAX_PARTITIONS; i++)
+		devip->tape_location[i] = 0;
+
+	devip->tape_nbr_partitions = nbr_partitions;
+	devip->tape_partition = 0;
+
+	partition_pg[3] = nbr_partitions - 1;
+	put_unaligned_be16(devip->tape_eop[0], partition_pg + 8);
+	put_unaligned_be16(devip->tape_eop[1], partition_pg + 10);
+
+	return nbr_partitions;
+}
+
 static inline bool sdebug_dev_is_zoned(struct sdebug_dev_info *devip)
 {
 	return devip->nr_zones != 0;
@@ -4304,6 +4428,67 @@ static void unmap_region(struct sdeb_store_info *sip, sector_t lba,
 	}
 }
 
+static int resp_write_tape(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
+{
+	u32 i, num, transfer, size, written = 0;
+	u8 *cmd = scp->cmnd;
+	struct scsi_data_buffer *sdb = &scp->sdb;
+	int partition = devip->tape_partition;
+	int pos = devip->tape_location[partition];
+	struct tape_block *blp;
+	bool fixed, ew;
+
+	if (cmd[0] != WRITE_6) { /* Only Write(6) supported */
+		mk_sense_invalid_opcode(scp);
+		return illegal_condition_result;
+	}
+
+	fixed = (cmd[1] & 1) != 0;
+	transfer = get_unaligned_be24(cmd + 2);
+	if (fixed) {
+		num = transfer;
+		size = devip->tape_blksize;
+	} else {
+		if (transfer < TAPE_MIN_BLKSIZE ||
+			transfer > TAPE_MAX_BLKSIZE) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
+			return check_condition_result;
+		}
+		num = 1;
+		size = transfer;
+	}
+
+	scsi_set_resid(scp, num * transfer);
+	for (i = 0, blp = devip->tape_blocks[partition] + pos, ew = false;
+	     i < num && pos < devip->tape_eop[partition] - 1; i++, pos++, blp++) {
+		blp->fl_size = size;
+		sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
+			&(blp->data), 4, i * size, true);
+		written += size;
+		scsi_set_resid(scp, num * transfer - written);
+		ew |= (pos == devip->tape_eop[partition] - TAPE_EW);
+	}
+
+	devip->tape_location[partition] = pos;
+	blp->fl_size = TAPE_BLOCK_EOD_FLAG;
+	if (pos >= devip->tape_eop[partition] - 1) {
+		mk_sense_info_tape(scp, VOLUME_OVERFLOW,
+				NO_ADDITIONAL_SENSE, EOP_EOM_DETECTED_ASCQ,
+				fixed ? num - i : transfer,
+				SENSE_FLAG_EOM);
+		return check_condition_result;
+	}
+	if (ew) { /* early warning */
+		mk_sense_info_tape(scp, NO_SENSE,
+				NO_ADDITIONAL_SENSE, EOP_EOM_DETECTED_ASCQ,
+				fixed ? num - i : transfer,
+				SENSE_FLAG_EOM);
+		return check_condition_result;
+	}
+
+	return 0;
+}
+
 static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
@@ -4316,6 +4501,9 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u8 *cmd = scp->cmnd;
 	bool meta_data_locked = false;
 
+	if (sdebug_ptype == TYPE_TAPE)
+		return resp_write_tape(scp, devip);
+
 	switch (cmd[0]) {
 	case WRITE_16:
 		ei_lba = 0;
@@ -6063,6 +6251,20 @@ static int scsi_debug_sdev_configure(struct scsi_device *sdp,
 		if (devip == NULL)
 			return 1;  /* no resources, will be marked offline */
 	}
+	if (sdebug_ptype == TYPE_TAPE) {
+		if (!devip->tape_blocks[0]) {
+			devip->tape_blocks[0] =
+				kcalloc(TAPE_UNITS, sizeof(struct tape_block),
+					GFP_KERNEL);
+			if (!devip->tape_blocks[0])
+				return 1;
+		}
+		if (partition_tape(devip, 1, TAPE_UNITS, 0) < 0) {
+			kfree(devip->tape_blocks[0]);
+			devip->tape_blocks[0] = NULL;
+			return 1;
+		}
+	}
 	sdp->hostdata = devip;
 	if (sdebug_no_uld)
 		sdp->no_uld_attach = 1;
@@ -6108,6 +6310,11 @@ static void scsi_debug_sdev_destroy(struct scsi_device *sdp)
 
 	debugfs_remove(devip->debugfs_entry);
 
+	if (sdebug_ptype == TYPE_TAPE) {
+		kfree(devip->tape_blocks[0]);
+		devip->tape_blocks[0] = NULL;
+	}
+
 	/* make this slot available for re-use */
 	devip->used = false;
 	sdp->hostdata = NULL;
-- 
2.43.0


