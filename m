Return-Path: <linux-scsi+bounces-12151-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53329A2F84B
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0AA188A697
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371831C07F6;
	Mon, 10 Feb 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="s8Ziri2x"
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw20-4.mail.saunalahti.fi (fgw20-4.mail.saunalahti.fi [62.142.5.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053B25E462
	for <linux-scsi@vger.kernel.org>; Mon, 10 Feb 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214810; cv=none; b=uJMsJgg/vl1ndqVev1pTubC05OV0y58nS0PdnOFYtfr9/+RU//Vw8kg4bUCixXGRD43ylON7liJqcxDf0cdrzA2bOkTbr6oI6zOgu8lYpukJzqyc7EWQW2aHF8Jzb5yZ/wtQqzXKL31QlO09giM7IQiPfWcOXGnE9a64IR3xp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214810; c=relaxed/simple;
	bh=Uay3+Ak7kYgYiIXTqpY62DTxR6Fux2vOMtMQnM+m3FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n25KuarUBJjsF/6Xyo+vpzbY+vn/RWJlngm2t+bZkgNmgBcb4xQiiCUEVO9OkVz6l1gM50zoVK90k7SZ4B5foRDSo9DURunPJA+BkVnA1ZRlNuZcZGUe7tgDe6NcxxOf6W4y73x1HM/FSs38Zn8ID0nMAi5lcTP/rsRzUFHRtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=s8Ziri2x; arc=none smtp.client-ip=62.142.5.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from:to:cc:reply-to:subject:date:
	 in-reply-to:references:list-archive:list-subscribe:list-unsubscribe:
	 content-type:content-transfer-encoding:message-id;
	bh=x9VIg+82BJC1J0x63yXdLA12JHTnquXBgqt8VFHkAsQ=;
	b=s8Ziri2xPgIV0ivzzHXSl14DvYcQkSa1IHaKfpTidTYORPBBX1fHDT6qBSZfUiQs8WnM8eAl/rgZw
	 KSPXT/dF9XhqNYhYf+nvNQ0RUuQQw1S7sjbvlOMBbI36/KO87fadbxTH46wun72SRuVEabf5SqVGKC
	 aT7dptt2lQfEKbGNm33xHWkTH1BFaqiV1mNORJLIKyZg9jECBY+VbRPYXRJxjFXucsTQuGm3WrXGEp
	 ETnLnPW8XECunwFR/J2DMm7fVHdtmpSiOyt0QIJUDFVR8gmmSzBYDds5N+buERyxkhprP+5CXyyPf+
	 j85uyKywjDWvHRe+e/QUJXsfpLn/j6Q==
Received: from kaipn1.makisara.private (85-156-116-90.elisa-laajakaista.fi [85.156.116.90])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTPSA
	id 10f9fa6a-e7e3-11ef-a27d-005056bdfda7;
	Mon, 10 Feb 2025 21:13:10 +0200 (EET)
From: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
To: linux-scsi@vger.kernel.org,
	dgilbert@interlog.com
Cc: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	jmeneghi@redhat.com,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Subject: [PATCH v1 7/7] scsi: scsi_debug: Add support for partitioning the tape
Date: Mon, 10 Feb 2025 21:12:32 +0200
Message-ID: <20250210191232.185207-8-Kai.Makisara@kolumbus.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210191232.185207-1-Kai.Makisara@kolumbus.fi>
References: <20250210191232.185207-1-Kai.Makisara@kolumbus.fi>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds support for MEDIUM PARTITION PAGE in MODE SELECT and the
FORMAT MEDIUM command for tapes. After these additions, the virtual tape
can be partitioned containing either one or two partitions. The POFM
flag in the mode page is set, meaning that the FORMAT MEDIUM command
must be used to create the partitioning defined in the mode page.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
---
 drivers/scsi/scsi_debug.c | 108 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b40023dd812b..277385e9b91c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -188,6 +188,7 @@ static const char *sdebug_version_date = "20210520";
 #define TAPE_EW 20
 #define TAPE_MAX_PARTITIONS 2
 #define TAPE_UNITS 10000
+#define TAPE_PARTITION_1_UNITS 1000
 
 /* The tape block data definitions */
 #define TAPE_BLOCK_FM_FLAG   ((u32)0x1 << 30)
@@ -405,6 +406,9 @@ struct sdebug_dev_info {
 	unsigned int tape_density;
 	unsigned char tape_partition;
 	unsigned char tape_nbr_partitions;
+	unsigned char tape_pending_nbr_partitions;
+	unsigned int tape_pending_part_0_size;
+	unsigned int tape_pending_part_1_size;
 	unsigned char tape_dce;
 	unsigned int tape_location[TAPE_MAX_PARTITIONS];
 	unsigned int tape_eop[TAPE_MAX_PARTITIONS];
@@ -534,14 +538,15 @@ enum sdeb_opcode_index {
 	SDEB_I_LOCATE = 34,
 	SDEB_I_WRITE_FILEMARKS = 35,
 	SDEB_I_SPACE = 36,
-	SDEB_I_LAST_ELEM_P1 = 37,	/* keep this last (previous + 1) */
+	SDEB_I_FORMAT_MEDIUM = 37,
+	SDEB_I_LAST_ELEM_P1 = 38,	/* keep this last (previous + 1) */
 };
 
 
 static const unsigned char opcode_ind_arr[256] = {
 /* 0x0; 0x0->0x1f: 6 byte cdbs */
 	SDEB_I_TEST_UNIT_READY, SDEB_I_REZERO_UNIT, 0, SDEB_I_REQUEST_SENSE,
-	    0, SDEB_I_READ_BLOCK_LIMITS, 0, 0,
+	    SDEB_I_FORMAT_MEDIUM, SDEB_I_READ_BLOCK_LIMITS, 0, 0,
 	SDEB_I_READ, 0, SDEB_I_WRITE, 0, 0, 0, 0, 0,
 	SDEB_I_WRITE_FILEMARKS, SDEB_I_SPACE, SDEB_I_INQUIRY, 0, 0,
 	    SDEB_I_MODE_SELECT, SDEB_I_RESERVE, SDEB_I_RELEASE,
@@ -629,6 +634,7 @@ static int resp_locate(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_write_filemarks(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_space(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rewind(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_format_medium(struct scsi_cmnd *, struct sdebug_dev_info *);
 
 static int sdebug_do_add_host(bool mk_new_store);
 static int sdebug_add_host_helper(int per_host_idx);
@@ -867,7 +873,7 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	    resp_report_zones, zone_in_iarr, /* ZONE_IN(16), REPORT ZONES) */
 		{16,  0x0 /* SA */, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xc7} },
-/* 31 */
+/* 32 */
 	{0, 0x0, 0x0, F_D_OUT | FF_MEDIA_IO,
 	    resp_atomic_write, NULL, /* ATOMIC WRITE 16 */
 		{16,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
@@ -881,7 +887,9 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	    {6,  0x01, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 	{0, 0x11, 0, F_D_IN, resp_space, NULL,    /* SPACE (6) */
 	    {6,  0x07, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-
+	{0, 0x4, 0, 0, resp_format_medium, NULL,  /* FORMAT MEDIUM (6) */
+	    {6,  0x3, 0x7, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
+/* 38 */
 /* sentinel */
 	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
@@ -2844,6 +2852,51 @@ static int resp_partition_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(partition_pg);
 }
 
+static int process_medium_part_m_pg(struct sdebug_dev_info *devip,
+				unsigned char *new, int pg_len)
+{
+	int new_nbr, p0_size, p1_size;
+
+	if ((new[4] & 0x80) != 0) { /* FDP */
+		partition_pg[4] |= 0x80;
+		devip->tape_pending_nbr_partitions = TAPE_MAX_PARTITIONS;
+		devip->tape_pending_part_0_size = TAPE_UNITS - TAPE_PARTITION_1_UNITS;
+		devip->tape_pending_part_1_size = TAPE_PARTITION_1_UNITS;
+	} else {
+		new_nbr = new[3] + 1;
+		if (new_nbr > TAPE_MAX_PARTITIONS)
+			return 3;
+		if ((new[4] & 0x40) != 0) { /* SDP */
+			p1_size = TAPE_PARTITION_1_UNITS;
+			p0_size = TAPE_UNITS - p1_size;
+			if (p0_size < 100)
+				return 4;
+		} else if ((new[4] & 0x20) != 0) {
+			if (new_nbr > 1) {
+				p0_size = get_unaligned_be16(new + 8);
+				p1_size = get_unaligned_be16(new + 10);
+				if (p1_size == 0xFFFF)
+					p1_size = TAPE_UNITS - p0_size;
+				else if (p0_size == 0xFFFF)
+					p0_size = TAPE_UNITS - p1_size;
+				if (p0_size < 100 || p1_size < 100)
+					return 8;
+			} else {
+				p0_size = TAPE_UNITS;
+				p1_size = 0;
+			}
+		} else
+			return 6;
+		devip->tape_pending_nbr_partitions = new_nbr;
+		devip->tape_pending_part_0_size = p0_size;
+		devip->tape_pending_part_1_size = p1_size;
+		partition_pg[3] = new_nbr;
+		devip->tape_pending_nbr_partitions = new_nbr;
+	}
+
+	return 0;
+}
+
 static int resp_compression_m_pg(unsigned char *p, int pcontrol, int target,
 	unsigned char dce)
 {	/* Compression page for mode_sense (tape) */
@@ -3172,6 +3225,17 @@ static int resp_mode_select(struct scsi_cmnd *scp,
 			return 0;
 		}
 		break;
+	case 0x11:	/* Medium Partition Mode Page (tape) */
+		if (sdebug_ptype == TYPE_TAPE) {
+			int fld;
+
+			fld = process_medium_part_m_pg(devip, &arr[off], pg_len);
+			if (fld == 0)
+				return 0;
+			mk_sense_invalid_fld(scp, SDEB_IN_DATA, fld, -1);
+			return check_condition_result;
+		}
+		break;
 	case 0x1c:      /* Informational Exceptions Mode page */
 		if (iec_m_pg[1] == arr[off + 1]) {
 			memcpy(iec_m_pg + 2, arr + off + 2,
@@ -3556,6 +3620,39 @@ static int partition_tape(struct sdebug_dev_info *devip, int nbr_partitions,
 	return nbr_partitions;
 }
 
+static int resp_format_medium(struct scsi_cmnd *scp,
+			struct sdebug_dev_info *devip)
+{
+	int res = 0;
+	unsigned char *cmd = scp->cmnd;
+
+	if (sdebug_ptype != TYPE_TAPE) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 0, -1);
+		return check_condition_result;
+	}
+	if (cmd[2] > 2) {
+		mk_sense_invalid_fld(scp, SDEB_IN_DATA, 2, -1);
+		return check_condition_result;
+	}
+	if (cmd[2] != 0) {
+		if (devip->tape_pending_nbr_partitions > 0) {
+			res = partition_tape(devip,
+					devip->tape_pending_nbr_partitions,
+					devip->tape_pending_part_0_size,
+					devip->tape_pending_part_1_size);
+		} else
+			res = partition_tape(devip, devip->tape_nbr_partitions,
+					devip->tape_eop[0], devip->tape_eop[1]);
+	} else
+		res = partition_tape(devip, 1, TAPE_UNITS, 0);
+	if (res < 0)
+		return -EINVAL;
+
+	devip->tape_pending_nbr_partitions = -1;
+
+	return 0;
+}
+
 static inline bool sdebug_dev_is_zoned(struct sdebug_dev_info *devip)
 {
 	return devip->nr_zones != 0;
@@ -6522,6 +6619,7 @@ static int scsi_debug_sdev_configure(struct scsi_device *sdp,
 			if (!devip->tape_blocks[0])
 				return 1;
 		}
+		devip->tape_pending_nbr_partitions = -1;
 		if (partition_tape(devip, 1, TAPE_UNITS, 0) < 0) {
 			kfree(devip->tape_blocks[0]);
 			devip->tape_blocks[0] = NULL;
@@ -6783,6 +6881,8 @@ static void scsi_tape_reset_clear(struct sdebug_dev_info *devip)
 		devip->tape_dce = 0;
 		for (i = 0; i < TAPE_MAX_PARTITIONS; i++)
 			devip->tape_location[i] = 0;
+		devip->tape_pending_nbr_partitions = -1;
+		/* Don't reset partitioning? */
 	}
 }
 
-- 
2.43.0


