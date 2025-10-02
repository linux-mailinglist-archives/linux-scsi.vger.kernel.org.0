Return-Path: <linux-scsi+bounces-17736-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAA3BB4FE4
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Oct 2025 21:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8331A3B3662
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Oct 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBA2848B1;
	Thu,  2 Oct 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeHu5x6h"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5239283FEE
	for <linux-scsi@vger.kernel.org>; Thu,  2 Oct 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433129; cv=none; b=rfWDjLjV9QRYoVcinx4XbuLNpkuAM8kj5rxjCq9Tav9vM4gy6Azolhlk/VUI81bnXXuOgWMviyHKUaLkusie1VfFUW8YSXnB4GUMjQrTN77HBAsX0moBW5taQnkIZ2waHu6fnkaj+mrlExN/CTJ78rUJ/NrNPzQ3dWjS6yV509I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433129; c=relaxed/simple;
	bh=lXHU4dvgEBVDx0Pjkl1wiBQzFZTbwJivYKt+KUyba8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOwf74nnKatf7C66ZjHjSUEjuAE4/dtspWUzeMT2S1cXu7jzRcvD6CQsvPm4EwutS728o73A6b0np7xRqyW0kFV63/UVpt4ztRsmRu5zsXqs22vatIL9O7TA9T1QW/XJMHnxmNRBZb/1JCe2ERW/WvtTRlVsAUS6rA/07Uzkzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeHu5x6h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759433126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsexSMnPC/JXy+fcmlkjaHMgQMigmrk+fOUZzrq+s4E=;
	b=PeHu5x6hOgQWsemIVyIYG8DaSFh/+CWgCqbtNz0FUKVUu8fFc/0f4CnCts3vvtaxJ2t8ZS
	JDkdYTz0TFp2TaUFh/5+SEwEEpKL0/IcGapVP0mvc7vwrAFmwLn37sOBkm438tvkEiMEOA
	JYAuvGmNLpOyRxqiqXvY4FmWadudfys=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-mCg2Bq_vOfuDKVC7gtYbHw-1; Thu,
 02 Oct 2025 15:25:23 -0400
X-MC-Unique: mCg2Bq_vOfuDKVC7gtYbHw-1
X-Mimecast-MFC-AGG-ID: mCg2Bq_vOfuDKVC7gtYbHw_1759433122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB221800372;
	Thu,  2 Oct 2025 19:25:22 +0000 (UTC)
Received: from emilne-na.ibmlowe.csb (unknown [10.17.17.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 201051955F19;
	Thu,  2 Oct 2025 19:25:20 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: michael.christie@oracle.com,
	dgilbert@interlog.com,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	hare@suse.de
Subject: [PATCH v4 6/9] scsi: sd: Check for and retry in case of READ_CAPCITY(10)/(16) returning no data
Date: Thu,  2 Oct 2025 15:25:07 -0400
Message-ID: <20251002192510.1922731-7-emilne@redhat.com>
In-Reply-To: <20251002192510.1922731-1-emilne@redhat.com>
References: <20251002192510.1922731-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

sd_read_capacity_10() and sd_read_capacity_16() do not check for underflow
and can extract invalid (e.g. zero) data when a malfunctioning device does
not actually transfer any data, but returns a good status otherwise.
Check for this and retry the command.  Log a message and return -EINVAL if
we can't get the capacity information.

We encountered a device that did this once but returned good data afterwards.

See similar commit 5cd3bbfad088 ("[SCSI] retry with missing data for INQUIRY")

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/scsi/sd.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index acd79e9a0d82..d1a366c9c99e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2638,6 +2638,7 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 		[13] = RC16_LEN,
 	};
 	struct scsi_sense_hdr sshdr;
+	int count, resid;
 	struct scsi_failure failure_defs[] = {
 		/*
 		 * Do not retry Invalid Command Operation Code or Invalid
@@ -2688,6 +2689,7 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 	};
 	const struct scsi_exec_args exec_args = {
 		.sshdr = &sshdr,
+		.resid = &resid,
 		.failures = &failures,
 	};
 	int sense_valid = 0;
@@ -2699,11 +2701,22 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 	if (sdp->no_read_capacity_16)
 		return -EINVAL;
 
-	memset(buffer, 0, RC16_LEN);
+	for (count = 0; count < 3; ++count) {
+		memset(buffer, 0, RC16_LEN);
 
-	the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN, buffer,
-				      RC16_LEN, SD_TIMEOUT, sdkp->max_retries,
-				      &exec_args);
+		the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN,
+					      buffer, RC16_LEN, SD_TIMEOUT,
+					      sdkp->max_retries, &exec_args);
+
+		if (the_result || resid != RC16_LEN)
+			break;
+
+		/*
+		 * If the status was good but nothing was transferred,
+		 * we retry. It is a workaround for some buggy devices
+		 * or SAT which sometimes do not return any data.
+		 */
+	}
 
 	if (the_result > 0) {
 		if (media_not_present(sdkp, &sshdr))
@@ -2727,6 +2740,12 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 		return -EINVAL;
 	}
 
+	if (resid == RC16_LEN) {
+		sd_printk(KERN_ERR, sdkp,
+			  "Read Capacity(16) returned good status but no data");
+		return -EINVAL;
+	}
+
 	sector_size = get_unaligned_be32(&buffer[8]);
 	lba = get_unaligned_be64(&buffer[0]);
 
@@ -2759,11 +2778,17 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 	return sector_size;
 }
 
+#define RC10_LEN 8
+#if RC10_LEN > SD_BUF_SIZE
+#error RC10_LEN must not be more than SD_BUF_SIZE
+#endif
+
 static int read_capacity_10(struct scsi_disk *sdkp, struct scsi_device *sdp,
 						unsigned char *buffer)
 {
 	static const u8 cmd[10] = { READ_CAPACITY };
 	struct scsi_sense_hdr sshdr;
+	int count, resid;
 	struct scsi_failure failure_defs[] = {
 		/* Do not retry Medium Not Present */
 		{
@@ -2798,17 +2823,29 @@ static int read_capacity_10(struct scsi_disk *sdkp, struct scsi_device *sdp,
 	};
 	const struct scsi_exec_args exec_args = {
 		.sshdr = &sshdr,
+		.resid = &resid,
 		.failures = &failures,
 	};
 	int the_result;
 	sector_t lba;
 	unsigned sector_size;
 
-	memset(buffer, 0, 8);
+	for (count = 0; count < 3; ++count) {
+		memset(buffer, 0, RC10_LEN);
+
+		the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN,
+					      buffer, RC10_LEN, SD_TIMEOUT,
+					      sdkp->max_retries, &exec_args);
+
+		if (the_result || resid != RC10_LEN)
+			break;
 
-	the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN, buffer,
-				      8, SD_TIMEOUT, sdkp->max_retries,
-				      &exec_args);
+		/*
+		 * If the status was good but nothing was transferred,
+		 * we retry. It is a workaround for some buggy devices
+		 * or SAT which sometimes do not return any data.
+		 */
+	}
 
 	if (the_result > 0) {
 		if (media_not_present(sdkp, &sshdr))
@@ -2821,6 +2858,12 @@ static int read_capacity_10(struct scsi_disk *sdkp, struct scsi_device *sdp,
 		return -EINVAL;
 	}
 
+	if (resid == RC10_LEN) {
+		sd_printk(KERN_ERR, sdkp,
+			  "Read Capacity(10) returned good status but no data");
+		return -EINVAL;
+	}
+
 	sector_size = get_unaligned_be32(&buffer[4]);
 	lba = get_unaligned_be32(&buffer[0]);
 
-- 
2.47.1


