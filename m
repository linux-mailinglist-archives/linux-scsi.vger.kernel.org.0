Return-Path: <linux-scsi+bounces-11852-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6FDA21E5C
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jan 2025 15:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7791626EF
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jan 2025 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD210A1F;
	Wed, 29 Jan 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXcHq36K"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03127130A7D;
	Wed, 29 Jan 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159300; cv=none; b=uDl9V53g6bXgARIzVLx2rGsNNgXYcnNPrx89NmGoh00chD/Amz7kUJF2+a1EoMEf2UadFvEitLNOZD50zFwVpIA0AXAYcC6ELHWj6rmDAMEjYIPlz5zXUWVRVZL3rgOS7donP1iSicNeoZAX+EQdcAgyDxZf9L0coaY8QdKxXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159300; c=relaxed/simple;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iuQ0LbHlvgSOiuv50YUcXwYDTwEeDJFqwfcMDIK23pxAHg5DO9bzbtKza+PhwNzwlQdJZ8ZwIvQuTOJunWfzg/4e+9/w0Usk5K65nf2/6to4Bz7qvLTMSByGluwHh7sO1xu8kdbZa4THQF09Vg46QWluej4K2V4nn9RH0mGUzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXcHq36K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B0C4CED3;
	Wed, 29 Jan 2025 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159299;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:From;
	b=DXcHq36K+6SCeBVsjafQbYjfEhhL4R2p85/VRCF/Y9WYj6+zIBy7CuAvJrd5UsJp5
	 VGQ6azOEexy1N0w4bqOHUwLsoT5QgqZMn2sQcZtk+m2nyss98OgRCLfDZmDamGBagJ
	 3oMf9CL0cxKpm7l6CM0y4Q3HS4UH/2wdsqfdqmJKtLKFCTle1O9OkZ1PWN+4qDiGuu
	 v3xCWMVx6UOCqOBf1DKTsIpq9joUnvX62b8mM37G/Ik/KiQ1pinseY7Yk2C9JIFh70
	 j7e3LXWs7HJlNFt+VieWl8XA0lVHfnlgQpsiWccteWyEo/Z969cPDzxtTYYXPqA6jl
	 cydlTyDdwdcoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/4] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Wed, 29 Jan 2025 07:57:54 -0500
Message-Id: <20250129125757.1272713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <eahariha@linux.microsoft.com>

[ Upstream commit d2138eab8cde61e0e6f62d0713e45202e8457d6d ]

If there's a persistent error in the hypervisor, the SCSI warning for
failed I/O can flood the kernel log and max out CPU utilization,
preventing troubleshooting from the VM side. Ratelimit the warning so
it doesn't DoS the VM.

Closes: https://github.com/microsoft/WSL/issues/9173
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d0b55c1fa908a..b3c588b102d90 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -171,6 +171,12 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
+do {										\
+	if (do_logging(level))							\
+		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -1177,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
-- 
2.39.5


