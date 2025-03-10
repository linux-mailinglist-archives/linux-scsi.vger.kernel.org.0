Return-Path: <linux-scsi+bounces-12701-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25220A59A73
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Mar 2025 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C273166053
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Mar 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7922DFE5;
	Mon, 10 Mar 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="jAUFGgDH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7441DFF0
	for <linux-scsi@vger.kernel.org>; Mon, 10 Mar 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622219; cv=none; b=TI8B2g/lsUDuZ56KhvLDvgmRuAuR1If8TlYRP+WZjtLixAuPadYehr2jMRFen4z0tCfjxNUOwJszMzf7+/xN0RpkQZZ1zZGql889OK/3/jRQbLryl6n4aaja8ByvBLOPPw4uuAt88z23JLZ7xZOMxqlYHtdEmgLUKBQLsDPnnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622219; c=relaxed/simple;
	bh=HuW8m8d2hCWDC1mXtGXE8Hx97qE4mEd1p9EMNck7fTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr5vtnM5XejGxoWYHWwDmimeDIASQdcwoed6VYw1b7i6laNHXcZEbaLnVarWCL6Lc7z+OwoaeKlT2VQUSTkyGLcWK6c4BzGG18nhWSy1dbOK+dsMacAkFOTdb4JDcDwEPkGioYFTkaNxHHd2f99isM3S6GTlby7EvY3Cm0KaSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=jAUFGgDH; arc=none smtp.client-ip=62.142.5.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from:to:cc:reply-to:subject:date:
	 in-reply-to:references:list-archive:list-subscribe:list-unsubscribe:
	 content-type:content-transfer-encoding:message-id;
	bh=lYPQl/mC/gTSiz/Q3/SH6Azyagw7VZYcdVBpYqF7stY=;
	b=jAUFGgDHY34oc0dzXm8PY/W+D474ds9jqa9FuQShGRA/ShL4nOKWzWUtyhyh4qtwcJYH04UUuhFzM
	 2UoQ99Q6LJyzxMR/B4hy6yVlP152Fl0BPVKShW1M4f5yywSCns1rDLIcrQkSTbLUggYInZmnl4EZ2V
	 TEYjv8DUOKyn+b3h2rwW4yjsELl2XJuO+SiAFjh1+Tju2oUp8EJZjfGzmoSOvUU2S0J0sbj3NxWfjq
	 iKEdAwk40HVsljClIjvAq1GqXCh5HQpdKjWlznciB8eeYipBQw9jBo4kSvfUbakV+oDOq7oPYrEev5
	 6MLpKlsxSIM7PSUGvYeR2tjRi0A26tQ==
Received: from kaipn1.makisara.private (85-156-116-90.elisa-laajakaista.fi [85.156.116.90])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
	id 4798dbc6-fdc8-11ef-839f-005056bdd08f;
	Mon, 10 Mar 2025 17:56:50 +0200 (EET)
From: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
To: linux-scsi@vger.kernel.org,
	dgilbert@interlog.com
Cc: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Subject: [PATCH v2 2/5] scsi: scsi_debug: Enable different command definitions for different device types
Date: Mon, 10 Mar 2025 17:55:54 +0200
Message-ID: <20250310155557.2872-3-Kai.Makisara@kolumbus.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310155557.2872-1-Kai.Makisara@kolumbus.fi>
References: <20250310155557.2872-1-Kai.Makisara@kolumbus.fi>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add mask field devsel to the struct opcode_info_t to enable different
definitions for different device types. Add checking of device mask to
command queuing and reporting of supported opcodes.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>

---
v2:
- make sure that devsel is u32 in all functions
  Reported by the Kernel Test Robot:
https://lore.kernel.org/linux-scsi/202503101506.7b02ef4b-lkp@intel.com/

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
---
 drivers/scsi/scsi_debug.c | 204 +++++++++++++++++++++-----------------
 1 file changed, 115 insertions(+), 89 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c5e7264748a8..4c2ee0a79c09 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -294,6 +294,14 @@ struct tape_block {
 #define FF_SA (F_SA_HIGH | F_SA_LOW)
 #define F_LONG_DELAY		(F_SSU_DELAY | F_SYNC_DELAY)
 
+/* Device selection bit mask */
+#define DS_ALL     0xffffffff
+#define DS_SBC     (1 << TYPE_DISK)
+#define DS_SSC     (1 << TYPE_TAPE)
+#define DS_ZBC     (1 << TYPE_ZBC)
+
+#define DS_NO_SSC  (DS_ALL & ~DS_SSC)
+
 #define SDEBUG_MAX_PARTS 4
 
 #define SDEBUG_MAX_CMD_LEN 32
@@ -472,6 +480,7 @@ struct opcode_info_t {
 				/* for terminating element */
 	u8 opcode;		/* if num_attached > 0, preferred */
 	u16 sa;			/* service action */
+	u32 devsel;		/* device type mask for this definition */
 	u32 flags;		/* OR-ed set of SDEB_F_* */
 	int (*pfp)(struct scsi_cmnd *, struct sdebug_dev_info *);
 	const struct opcode_info_t *arrp;  /* num_attached elements or NULL */
@@ -629,113 +638,113 @@ static void sdebug_erase_all_stores(bool apart_from_first);
  * should be placed in opcode_info_arr[], the others should be placed here.
  */
 static const struct opcode_info_t msense_iarr[] = {
-	{0, 0x1a, 0, F_D_IN, NULL, NULL,
+	{0, 0x1a, 0, DS_ALL, F_D_IN, NULL, NULL,
 	    {6,  0xe8, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t mselect_iarr[] = {
-	{0, 0x15, 0, F_D_OUT, NULL, NULL,
+	{0, 0x15, 0, DS_ALL, F_D_OUT, NULL, NULL,
 	    {6,  0xf1, 0, 0, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t read_iarr[] = {
-	{0, 0x28, 0, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL,/* READ(10) */
+	{0, 0x28, 0, DS_NO_SSC, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL,/* READ(10) */
 	    {10,  0xff, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },
-	{0, 0x8, 0, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL, /* READ(6) */
+	{0, 0x8, 0, DS_ALL, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL, /* READ(6) */
 	    {6,  0xff, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0xa8, 0, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL,/* READ(12) */
+	{0, 0xa8, 0, DS_NO_SSC, F_D_IN | FF_MEDIA_IO, resp_read_dt0, NULL,/* READ(12) */
 	    {12,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xbf,
 	     0xc7, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t write_iarr[] = {
-	{0, 0x2a, 0, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,  /* WRITE(10) */
+	{0, 0x2a, 0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,  /* WRITE(10) */
 	    NULL, {10,  0xfb, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7,
 		   0, 0, 0, 0, 0, 0} },
-	{0, 0xa, 0, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,   /* WRITE(6) */
+	{0, 0xa, 0, DS_ALL, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,   /* WRITE(6) */
 	    NULL, {6,  0xff, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0,
 		   0, 0, 0} },
-	{0, 0xaa, 0, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,  /* WRITE(12) */
+	{0, 0xaa, 0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO, resp_write_dt0,  /* WRITE(12) */
 	    NULL, {12,  0xfb, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		   0xbf, 0xc7, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t verify_iarr[] = {
-	{0, 0x2f, 0, F_D_OUT_MAYBE | FF_MEDIA_IO, resp_verify,/* VERIFY(10) */
+	{0, 0x2f, 0, DS_NO_SSC, F_D_OUT_MAYBE | FF_MEDIA_IO, resp_verify,/* VERIFY(10) */
 	    NULL, {10,  0xf7, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xff, 0xff, 0xc7,
 		   0, 0, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t sa_in_16_iarr[] = {
-	{0, 0x9e, 0x12, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
+	{0, 0x9e, 0x12, DS_NO_SSC, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
 	    {16,  0x12, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0, 0xc7} },	/* GET LBA STATUS(16) */
-	{0, 0x9e, 0x16, F_SA_LOW | F_D_IN, resp_get_stream_status, NULL,
+	{0, 0x9e, 0x16, DS_NO_SSC, F_SA_LOW | F_D_IN, resp_get_stream_status, NULL,
 	    {16, 0x16, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff,
 	     0, 0} },	/* GET STREAM STATUS */
 };
 
 static const struct opcode_info_t vl_iarr[] = {	/* VARIABLE LENGTH */
-	{0, 0x7f, 0xb, F_SA_HIGH | F_D_OUT | FF_MEDIA_IO, resp_write_dt0,
+	{0, 0x7f, 0xb, DS_NO_SSC, F_SA_HIGH | F_D_OUT | FF_MEDIA_IO, resp_write_dt0,
 	    NULL, {32,  0xc7, 0, 0, 0, 0, 0x3f, 0x18, 0x0, 0xb, 0xfa,
 		   0, 0xff, 0xff, 0xff, 0xff} },	/* WRITE(32) */
-	{0, 0x7f, 0x11, F_SA_HIGH | F_D_OUT | FF_MEDIA_IO, resp_write_scat,
+	{0, 0x7f, 0x11, DS_NO_SSC, F_SA_HIGH | F_D_OUT | FF_MEDIA_IO, resp_write_scat,
 	    NULL, {32,  0xc7, 0, 0, 0, 0, 0x3f, 0x18, 0x0, 0x11, 0xf8,
 		   0, 0xff, 0xff, 0x0, 0x0} },	/* WRITE SCATTERED(32) */
 };
 
 static const struct opcode_info_t maint_in_iarr[] = {	/* MAINT IN */
-	{0, 0xa3, 0xc, F_SA_LOW | F_D_IN, resp_rsup_opcodes, NULL,
+	{0, 0xa3, 0xc, DS_ALL, F_SA_LOW | F_D_IN, resp_rsup_opcodes, NULL,
 	    {12,  0xc, 0x87, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0,
 	     0xc7, 0, 0, 0, 0} }, /* REPORT SUPPORTED OPERATION CODES */
-	{0, 0xa3, 0xd, F_SA_LOW | F_D_IN, resp_rsup_tmfs, NULL,
+	{0, 0xa3, 0xd, DS_ALL, F_SA_LOW | F_D_IN, resp_rsup_tmfs, NULL,
 	    {12,  0xd, 0x80, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0, 0xc7, 0, 0,
 	     0, 0} },	/* REPORTED SUPPORTED TASK MANAGEMENT FUNCTIONS */
 };
 
 static const struct opcode_info_t write_same_iarr[] = {
-	{0, 0x93, 0, F_D_OUT_MAYBE | FF_MEDIA_IO, resp_write_same_16, NULL,
+	{0, 0x93, 0, DS_NO_SSC, F_D_OUT_MAYBE | FF_MEDIA_IO, resp_write_same_16, NULL,
 	    {16,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0x3f, 0xc7} },		/* WRITE SAME(16) */
 };
 
 static const struct opcode_info_t reserve_iarr[] = {
-	{0, 0x16, 0, F_D_OUT, NULL, NULL,		/* RESERVE(6) */
+	{0, 0x16, 0, DS_ALL, F_D_OUT, NULL, NULL,	/* RESERVE(6) */
 	    {6,  0x1f, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t release_iarr[] = {
-	{0, 0x17, 0, F_D_OUT, NULL, NULL,		/* RELEASE(6) */
+	{0, 0x17, 0, DS_ALL, F_D_OUT, NULL, NULL,	/* RELEASE(6) */
 	    {6,  0x1f, 0xff, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
 static const struct opcode_info_t sync_cache_iarr[] = {
-	{0, 0x91, 0, F_SYNC_DELAY | F_M_ACCESS, resp_sync_cache, NULL,
+	{0, 0x91, 0, DS_NO_SSC, F_SYNC_DELAY | F_M_ACCESS, resp_sync_cache, NULL,
 	    {16,  0x6, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0xff, 0x3f, 0xc7} },	/* SYNC_CACHE (16) */
 };
 
 static const struct opcode_info_t pre_fetch_iarr[] = {
-	{0, 0x90, 0, F_SYNC_DELAY | FF_MEDIA_IO, resp_pre_fetch, NULL,
+	{0, 0x90, 0, DS_NO_SSC, F_SYNC_DELAY | FF_MEDIA_IO, resp_pre_fetch, NULL,
 	    {16,  0x2, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0xff, 0x3f, 0xc7} },	/* PRE-FETCH (16) */
 };
 
 static const struct opcode_info_t zone_out_iarr[] = {	/* ZONE OUT(16) */
-	{0, 0x94, 0x1, F_SA_LOW | F_M_ACCESS, resp_close_zone, NULL,
+	{0, 0x94, 0x1, DS_NO_SSC, F_SA_LOW | F_M_ACCESS, resp_close_zone, NULL,
 	    {16, 0x1, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0, 0, 0xff, 0xff, 0x1, 0xc7} },	/* CLOSE ZONE */
-	{0, 0x94, 0x2, F_SA_LOW | F_M_ACCESS, resp_finish_zone, NULL,
+	{0, 0x94, 0x2, DS_NO_SSC, F_SA_LOW | F_M_ACCESS, resp_finish_zone, NULL,
 	    {16, 0x2, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0, 0, 0xff, 0xff, 0x1, 0xc7} },	/* FINISH ZONE */
-	{0, 0x94, 0x4, F_SA_LOW | F_M_ACCESS, resp_rwp_zone, NULL,
+	{0, 0x94, 0x4, DS_NO_SSC, F_SA_LOW | F_M_ACCESS, resp_rwp_zone, NULL,
 	    {16, 0x4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0, 0, 0xff, 0xff, 0x1, 0xc7} },  /* RESET WRITE POINTER */
 };
 
 static const struct opcode_info_t zone_in_iarr[] = {	/* ZONE IN(16) */
-	{0, 0x95, 0x6, F_SA_LOW | F_D_IN | F_M_ACCESS, NULL, NULL,
+	{0, 0x95, 0x6, DS_NO_SSC, F_SA_LOW | F_D_IN | F_M_ACCESS, NULL, NULL,
 	    {16, 0x6, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0xff, 0x3f, 0xc7} }, /* REPORT ZONES */
 };
@@ -746,130 +755,130 @@ static const struct opcode_info_t zone_in_iarr[] = {	/* ZONE IN(16) */
  * REPORT SUPPORTED OPERATION CODES. */
 static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 /* 0 */
-	{0, 0, 0, F_INV_OP | FF_RESPOND, NULL, NULL,	/* unknown opcodes */
+	{0, 0, 0, DS_ALL, F_INV_OP | FF_RESPOND, NULL, NULL,	/* unknown opcodes */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x12, 0, FF_RESPOND | F_D_IN, resp_inquiry, NULL, /* INQUIRY */
+	{0, 0x12, 0, DS_ALL, FF_RESPOND | F_D_IN, resp_inquiry, NULL, /* INQUIRY */
 	    {6,  0xe3, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0xa0, 0, FF_RESPOND | F_D_IN, resp_report_luns, NULL,
+	{0, 0xa0, 0, DS_ALL, FF_RESPOND | F_D_IN, resp_report_luns, NULL,
 	    {12,  0xe3, 0xff, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0, 0xc7, 0, 0,
 	     0, 0} },					/* REPORT LUNS */
-	{0, 0x3, 0, FF_RESPOND | F_D_IN, resp_requests, NULL,
+	{0, 0x3, 0, DS_ALL, FF_RESPOND | F_D_IN, resp_requests, NULL,
 	    {6,  0xe1, 0, 0, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x0, 0, F_M_ACCESS | F_RL_WLUN_OK, NULL, NULL,/* TEST UNIT READY */
+	{0, 0x0, 0, DS_ALL, F_M_ACCESS | F_RL_WLUN_OK, NULL, NULL,/* TEST UNIT READY */
 	    {6,  0, 0, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 /* 5 */
-	{ARRAY_SIZE(msense_iarr), 0x5a, 0, F_D_IN,	/* MODE SENSE(10) */
+	{ARRAY_SIZE(msense_iarr), 0x5a, 0, DS_ALL, F_D_IN,	/* MODE SENSE(10) */
 	    resp_mode_sense, msense_iarr, {10,  0xf8, 0xff, 0xff, 0, 0, 0,
 		0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0} },
-	{ARRAY_SIZE(mselect_iarr), 0x55, 0, F_D_OUT,	/* MODE SELECT(10) */
+	{ARRAY_SIZE(mselect_iarr), 0x55, 0, DS_ALL, F_D_OUT,	/* MODE SELECT(10) */
 	    resp_mode_select, mselect_iarr, {10,  0xf1, 0, 0, 0, 0, 0, 0xff,
 		0xff, 0xc7, 0, 0, 0, 0, 0, 0} },
-	{0, 0x4d, 0, F_D_IN, resp_log_sense, NULL,	/* LOG SENSE */
+	{0, 0x4d, 0, DS_NO_SSC, F_D_IN, resp_log_sense, NULL,	/* LOG SENSE */
 	    {10,  0xe3, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0,
 	     0, 0, 0} },
-	{0, 0x25, 0, F_D_IN, resp_readcap, NULL,    /* READ CAPACITY(10) */
+	{0, 0x25, 0, DS_NO_SSC, F_D_IN, resp_readcap, NULL,    /* READ CAPACITY(10) */
 	    {10,  0xe1, 0xff, 0xff, 0xff, 0xff, 0, 0, 0x1, 0xc7, 0, 0, 0, 0,
 	     0, 0} },
-	{ARRAY_SIZE(read_iarr), 0x88, 0, F_D_IN | FF_MEDIA_IO, /* READ(16) */
+	{ARRAY_SIZE(read_iarr), 0x88, 0, DS_NO_SSC, F_D_IN | FF_MEDIA_IO, /* READ(16) */
 	    resp_read_dt0, read_iarr, {16,  0xfe, 0xff, 0xff, 0xff, 0xff,
 	    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc7} },
 /* 10 */
-	{ARRAY_SIZE(write_iarr), 0x8a, 0, F_D_OUT | FF_MEDIA_IO,
+	{ARRAY_SIZE(write_iarr), 0x8a, 0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO,
 	    resp_write_dt0, write_iarr,			/* WRITE(16) */
 		{16,  0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xc7} },
-	{0, 0x1b, 0, F_SSU_DELAY, resp_start_stop, NULL,/* START STOP UNIT */
+	{0, 0x1b, 0, DS_ALL, F_SSU_DELAY, resp_start_stop, NULL,/* START STOP UNIT */
 	    {6,  0x1, 0, 0xf, 0xf7, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{ARRAY_SIZE(sa_in_16_iarr), 0x9e, 0x10, F_SA_LOW | F_D_IN,
+	{ARRAY_SIZE(sa_in_16_iarr), 0x9e, 0x10, DS_NO_SSC, F_SA_LOW | F_D_IN,
 	    resp_readcap16, sa_in_16_iarr, /* SA_IN(16), READ CAPACITY(16) */
 		{16,  0x10, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0x1, 0xc7} },
-	{0, 0x9f, 0x12, F_SA_LOW | F_D_OUT | FF_MEDIA_IO, resp_write_scat,
+	{0, 0x9f, 0x12, DS_NO_SSC, F_SA_LOW | F_D_OUT | FF_MEDIA_IO, resp_write_scat,
 	    NULL, {16,  0x12, 0xf9, 0x0, 0xff, 0xff, 0, 0, 0xff, 0xff, 0xff,
 	    0xff, 0xff, 0xff, 0xff, 0xc7} },  /* SA_OUT(16), WRITE SCAT(16) */
-	{ARRAY_SIZE(maint_in_iarr), 0xa3, 0xa, F_SA_LOW | F_D_IN,
+	{ARRAY_SIZE(maint_in_iarr), 0xa3, 0xa, DS_ALL, F_SA_LOW | F_D_IN,
 	    resp_report_tgtpgs,	/* MAINT IN, REPORT TARGET PORT GROUPS */
 		maint_in_iarr, {12,  0xea, 0, 0, 0, 0, 0xff, 0xff, 0xff,
 				0xff, 0, 0xc7, 0, 0, 0, 0} },
 /* 15 */
-	{0, 0, 0, F_INV_OP | FF_RESPOND, NULL, NULL, /* MAINT OUT */
+	{0, 0, 0, DS_ALL, F_INV_OP | FF_RESPOND, NULL, NULL, /* MAINT OUT */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{ARRAY_SIZE(verify_iarr), 0x8f, 0,
+	{ARRAY_SIZE(verify_iarr), 0x8f, 0, DS_NO_SSC,
 	    F_D_OUT_MAYBE | FF_MEDIA_IO, resp_verify,	/* VERIFY(16) */
 	    verify_iarr, {16,  0xf6, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xc7} },
-	{ARRAY_SIZE(vl_iarr), 0x7f, 0x9, F_SA_HIGH | F_D_IN | FF_MEDIA_IO,
+	{ARRAY_SIZE(vl_iarr), 0x7f, 0x9, DS_NO_SSC, F_SA_HIGH | F_D_IN | FF_MEDIA_IO,
 	    resp_read_dt0, vl_iarr,	/* VARIABLE LENGTH, READ(32) */
 	    {32,  0xc7, 0, 0, 0, 0, 0x3f, 0x18, 0x0, 0x9, 0xfe, 0, 0xff, 0xff,
 	     0xff, 0xff} },
-	{ARRAY_SIZE(reserve_iarr), 0x56, 0, F_D_OUT,
+	{ARRAY_SIZE(reserve_iarr), 0x56, 0, DS_ALL, F_D_OUT,
 	    NULL, reserve_iarr,	/* RESERVE(10) <no response function> */
 	    {10,  0xff, 0xff, 0xff, 0, 0, 0, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0,
 	     0} },
-	{ARRAY_SIZE(release_iarr), 0x57, 0, F_D_OUT,
+	{ARRAY_SIZE(release_iarr), 0x57, 0, DS_ALL, F_D_OUT,
 	    NULL, release_iarr, /* RELEASE(10) <no response function> */
 	    {10,  0x13, 0xff, 0xff, 0, 0, 0, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0,
 	     0} },
 /* 20 */
-	{0, 0x1e, 0, 0, NULL, NULL, /* ALLOW REMOVAL */
+	{0, 0x1e, 0, DS_ALL, 0, NULL, NULL, /* ALLOW REMOVAL */
 	    {6,  0, 0, 0, 0x3, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x1, 0, 0, resp_rewind, NULL,
+	{0, 0x1, 0, DS_SSC, 0, resp_rewind, NULL,
 	    {6,  0x1, 0, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0, 0, F_INV_OP | FF_RESPOND, NULL, NULL, /* ATA_PT */
+	{0, 0, 0, DS_NO_SSC, F_INV_OP | FF_RESPOND, NULL, NULL, /* ATA_PT */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x1d, 0, F_D_OUT, NULL, NULL,	/* SEND DIAGNOSTIC */
+	{0, 0x1d, 0, DS_ALL, F_D_OUT, NULL, NULL,      /* SEND DIAGNOSTIC */
 	    {6,  0xf7, 0, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x42, 0, F_D_OUT | FF_MEDIA_IO, resp_unmap, NULL, /* UNMAP */
+	{0, 0x42, 0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO, resp_unmap, NULL, /* UNMAP */
 	    {10,  0x1, 0, 0, 0, 0, 0x3f, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0} },
 /* 25 */
-	{0, 0x3b, 0, F_D_OUT_MAYBE, resp_write_buffer, NULL,
+	{0, 0x3b, 0, DS_NO_SSC, F_D_OUT_MAYBE, resp_write_buffer, NULL,
 	    {10,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },			/* WRITE_BUFFER */
-	{ARRAY_SIZE(write_same_iarr), 0x41, 0, F_D_OUT_MAYBE | FF_MEDIA_IO,
+	{ARRAY_SIZE(write_same_iarr), 0x41, 0, DS_NO_SSC, F_D_OUT_MAYBE | FF_MEDIA_IO,
 	    resp_write_same_10, write_same_iarr,	/* WRITE SAME(10) */
 		{10,  0xff, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7, 0,
 		 0, 0, 0, 0, 0} },
-	{ARRAY_SIZE(sync_cache_iarr), 0x35, 0, F_SYNC_DELAY | F_M_ACCESS,
+	{ARRAY_SIZE(sync_cache_iarr), 0x35, 0, DS_NO_SSC, F_SYNC_DELAY | F_M_ACCESS,
 	    resp_sync_cache, sync_cache_iarr,
 	    {10,  0x7, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },			/* SYNC_CACHE (10) */
-	{0, 0x89, 0, F_D_OUT | FF_MEDIA_IO, resp_comp_write, NULL,
+	{0, 0x89, 0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO, resp_comp_write, NULL,
 	    {16,  0xf8, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0, 0,
 	     0, 0xff, 0x3f, 0xc7} },		/* COMPARE AND WRITE */
-	{ARRAY_SIZE(pre_fetch_iarr), 0x34, 0, F_SYNC_DELAY | FF_MEDIA_IO,
+	{ARRAY_SIZE(pre_fetch_iarr), 0x34, 0, DS_ALL, F_SYNC_DELAY | FF_MEDIA_IO,
 	    resp_pre_fetch, pre_fetch_iarr,
 	    {10,  0x2, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xff, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },			/* PRE-FETCH (10) */
 						/* READ POSITION (10) */
 
 /* 30 */
-	{ARRAY_SIZE(zone_out_iarr), 0x94, 0x3, F_SA_LOW | F_M_ACCESS,
+	{ARRAY_SIZE(zone_out_iarr), 0x94, 0x3, DS_NO_SSC, F_SA_LOW | F_M_ACCESS,
 	    resp_open_zone, zone_out_iarr, /* ZONE_OUT(16), OPEN ZONE) */
 		{16,  0x3 /* SA */, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0x0, 0x0, 0xff, 0xff, 0x1, 0xc7} },
-	{ARRAY_SIZE(zone_in_iarr), 0x95, 0x0, F_SA_LOW | F_M_ACCESS,
+	{ARRAY_SIZE(zone_in_iarr), 0x95, 0x0, DS_NO_SSC, F_SA_LOW | F_M_ACCESS,
 	    resp_report_zones, zone_in_iarr, /* ZONE_IN(16), REPORT ZONES) */
 		{16,  0x0 /* SA */, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xc7} },
 /* 32 */
-	{0, 0x9c, 0x0, F_D_OUT | FF_MEDIA_IO,
+	{0, 0x9c, 0x0, DS_NO_SSC, F_D_OUT | FF_MEDIA_IO,
 	    resp_atomic_write, NULL, /* ATOMIC WRITE 16 */
 		{16,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff} },
-	{0, 0x05, 0, F_D_IN, resp_read_blklimits, NULL,    /* READ BLOCK LIMITS (6) */
+	{0, 0x05, 0, DS_SSC, F_D_IN, resp_read_blklimits, NULL,    /* READ BLOCK LIMITS (6) */
 	    {6,  0, 0, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x2b, 0, F_D_UNKN, resp_locate, NULL,    /* LOCATE (10) */
+	{0, 0x2b, 0, DS_SSC, F_D_UNKN, resp_locate, NULL,	   /* LOCATE (10) */
 	    {10,  0x07, 0, 0xff, 0xff, 0xff, 0xff, 0, 0xff, 0xc7, 0, 0,
 	     0, 0, 0, 0} },
-	{0, 0x10, 0, F_D_IN, resp_write_filemarks, NULL,    /* WRITE FILEMARKS (6) */
+	{0, 0x10, 0, DS_SSC, F_D_IN, resp_write_filemarks, NULL,   /* WRITE FILEMARKS (6) */
 	    {6,  0x01, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x11, 0, F_D_IN, resp_space, NULL,    /* SPACE (6) */
+	{0, 0x11, 0, DS_SSC, F_D_IN, resp_space, NULL,    /* SPACE (6) */
 	    {6,  0x07, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x4, 0, 0, resp_format_medium, NULL,  /* FORMAT MEDIUM (6) */
+	{0, 0x4, 0, DS_SSC, 0, resp_format_medium, NULL,  /* FORMAT MEDIUM (6) */
 	    {6,  0x3, 0x7, 0, 0, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 /* 38 */
 /* sentinel */
-	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
+	{0xff, 0, 0, 0, 0, NULL, NULL,		/* terminating element */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
@@ -1015,6 +1024,19 @@ static const int condition_met_result = SAM_STAT_CONDITION_MET;
 static struct dentry *sdebug_debugfs_root;
 static ASYNC_DOMAIN_EXCLUSIVE(sdebug_async_domain);
 
+static u32 sdebug_get_devsel(struct scsi_device *sdp)
+{
+	unsigned char devtype = sdp->type;
+	u32 devsel;
+
+	if (devtype < 32)
+		devsel = (1 << devtype);
+	else
+		devsel = DS_ALL;
+
+	return devsel;
+}
+
 static void sdebug_err_free(struct rcu_head *head)
 {
 	struct sdebug_err_inject *inject =
@@ -2454,11 +2476,12 @@ static int resp_rsup_opcodes(struct scsi_cmnd *scp,
 	u8 reporting_opts, req_opcode, sdeb_i, supp;
 	u16 req_sa, u;
 	u32 alloc_len, a_len;
-	int k, offset, len, errsts, count, bump, na;
+	int k, offset, len, errsts, bump, na;
 	const struct opcode_info_t *oip;
 	const struct opcode_info_t *r_oip;
 	u8 *arr;
 	u8 *cmd = scp->cmnd;
+	u32 devsel = sdebug_get_devsel(scp->device);
 
 	rctd = !!(cmd[2] & 0x80);
 	reporting_opts = cmd[2] & 0x7;
@@ -2481,34 +2504,30 @@ static int resp_rsup_opcodes(struct scsi_cmnd *scp,
 	}
 	switch (reporting_opts) {
 	case 0:	/* all commands */
-		/* count number of commands */
-		for (count = 0, oip = opcode_info_arr;
-		     oip->num_attached != 0xff; ++oip) {
-			if (F_INV_OP & oip->flags)
-				continue;
-			count += (oip->num_attached + 1);
-		}
 		bump = rctd ? 20 : 8;
-		put_unaligned_be32(count * bump, arr);
 		for (offset = 4, oip = opcode_info_arr;
 		     oip->num_attached != 0xff && offset < a_len; ++oip) {
 			if (F_INV_OP & oip->flags)
 				continue;
+			if ((devsel & oip->devsel) != 0) {
+				arr[offset] = oip->opcode;
+				put_unaligned_be16(oip->sa, arr + offset + 2);
+				if (rctd)
+					arr[offset + 5] |= 0x2;
+				if (FF_SA & oip->flags)
+					arr[offset + 5] |= 0x1;
+				put_unaligned_be16(oip->len_mask[0], arr + offset + 6);
+				if (rctd)
+					put_unaligned_be16(0xa, arr + offset + 8);
+				offset += bump;
+			}
 			na = oip->num_attached;
-			arr[offset] = oip->opcode;
-			put_unaligned_be16(oip->sa, arr + offset + 2);
-			if (rctd)
-				arr[offset + 5] |= 0x2;
-			if (FF_SA & oip->flags)
-				arr[offset + 5] |= 0x1;
-			put_unaligned_be16(oip->len_mask[0], arr + offset + 6);
-			if (rctd)
-				put_unaligned_be16(0xa, arr + offset + 8);
 			r_oip = oip;
 			for (k = 0, oip = oip->arrp; k < na; ++k, ++oip) {
 				if (F_INV_OP & oip->flags)
 					continue;
-				offset += bump;
+				if ((devsel & oip->devsel) == 0)
+					continue;
 				arr[offset] = oip->opcode;
 				put_unaligned_be16(oip->sa, arr + offset + 2);
 				if (rctd)
@@ -2516,14 +2535,15 @@ static int resp_rsup_opcodes(struct scsi_cmnd *scp,
 				if (FF_SA & oip->flags)
 					arr[offset + 5] |= 0x1;
 				put_unaligned_be16(oip->len_mask[0],
-						   arr + offset + 6);
+						arr + offset + 6);
 				if (rctd)
 					put_unaligned_be16(0xa,
 							   arr + offset + 8);
+				offset += bump;
 			}
 			oip = r_oip;
-			offset += bump;
 		}
+		put_unaligned_be32(offset - 4, arr);
 		break;
 	case 1:	/* one command: opcode only */
 	case 2:	/* one command: opcode plus service action */
@@ -2549,13 +2569,15 @@ static int resp_rsup_opcodes(struct scsi_cmnd *scp,
 				return check_condition_result;
 			}
 			if (0 == (FF_SA & oip->flags) &&
-			    req_opcode == oip->opcode)
+				(devsel & oip->devsel) != 0 &&
+				req_opcode == oip->opcode)
 				supp = 3;
 			else if (0 == (FF_SA & oip->flags)) {
 				na = oip->num_attached;
 				for (k = 0, oip = oip->arrp; k < na;
 				     ++k, ++oip) {
-					if (req_opcode == oip->opcode)
+					if (req_opcode == oip->opcode &&
+						(devsel & oip->devsel) != 0)
 						break;
 				}
 				supp = (k >= na) ? 1 : 3;
@@ -2563,7 +2585,8 @@ static int resp_rsup_opcodes(struct scsi_cmnd *scp,
 				na = oip->num_attached;
 				for (k = 0, oip = oip->arrp; k < na;
 				     ++k, ++oip) {
-					if (req_sa == oip->sa)
+					if (req_sa == oip->sa &&
+						(devsel & oip->devsel) != 0)
 						break;
 				}
 				supp = (k >= na) ? 1 : 3;
@@ -9173,6 +9196,7 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	u32 flags;
 	u16 sa;
 	u8 opcode = cmd[0];
+	u32 devsel = sdebug_get_devsel(scp->device);
 	bool has_wlun_rl;
 	bool inject_now;
 	int ret = 0;
@@ -9252,12 +9276,14 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 			else
 				sa = get_unaligned_be16(cmd + 8);
 			for (k = 0; k <= na; oip = r_oip->arrp + k++) {
-				if (opcode == oip->opcode && sa == oip->sa)
+				if (opcode == oip->opcode && sa == oip->sa &&
+					(devsel & oip->devsel) != 0)
 					break;
 			}
 		} else {   /* since no service action only check opcode */
 			for (k = 0; k <= na; oip = r_oip->arrp + k++) {
-				if (opcode == oip->opcode)
+				if (opcode == oip->opcode &&
+					(devsel & oip->devsel) != 0)
 					break;
 			}
 		}
-- 
2.43.0


