Return-Path: <linux-scsi+bounces-4253-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DD89B1D4
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Apr 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6613280D0B
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Apr 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00A12F5A7;
	Sun,  7 Apr 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ6Njp8x"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8712F59D;
	Sun,  7 Apr 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495612; cv=none; b=tttFRr2VKslRgoHzf6q1CTRJAgInY77Atdbvs1Kob8bx0xlNeFYE04wMDhJY8yXezYtLJGVWts1p0m1kA1dpWD/vTRxQS03dsK65owiATiToNCwpTy6hcWIQZzwLc3iQnaoP89ljD+vI/23jpiZ39DQyRLSvyTo7rcYKRsBh7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495612; c=relaxed/simple;
	bh=dxHqT1sfAId+v0An9ZOqygV5S3eIHfH7m1RFc0VLw1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGMm+xGwFQbABt0fKTs4+9sQJZVxL+0Qz0U7DTzuYuHdi7wFoKN6X0OT3TYx2+rG83JBSRlUhT8KmrttOrro6VcUaFOcTLbBxLa0j7MlkwumsKR+sDVwKkpYdsgZIm8ZMRgdtnneC2utr6pO6DCfvP72xIpm8kYaUYhGIFgFMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ6Njp8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A677EC433A6;
	Sun,  7 Apr 2024 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495612;
	bh=dxHqT1sfAId+v0An9ZOqygV5S3eIHfH7m1RFc0VLw1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQ6Njp8xFpSDR+P0iR5vQidfx03bzdcQs89QHc6535wePb0ETdiNDenHtoSndMWJY
	 qgaoh7eOtb793aU0JIP0t3z7HfY+5JumBnKnL0/T5K2O0GuiZghOtSe4s2YSHabqdB
	 +yBTdavWhN0ZHcQdh2+smTImUzp99YE5gGb+7NE6mUYvk890Jsq/1EzzNXtMRK1236
	 KkUs674Y5uHsIHY6ATvbZRWtxCC2fYm3tDmSEG1HTcuGEsA2q123RuAaXKwrKJRrS6
	 jpNQ5pA+dj74obCEp65D3L1ewKDfVHk9ZaZfY6LBTpOa1NgaQ1wwa/5vfSNYSAmEfM
	 o+vJSxCVRnmLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	sreekanth.reddy@broadcom.com,
	jejb@linux.ibm.com,
	chandrakanth.patil@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/13] scsi: mpi3mr: Avoid memcpy field-spanning write WARNING
Date: Sun,  7 Apr 2024 09:13:08 -0400
Message-ID: <20240407131316.1052393-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 429846b4b6ce9853e0d803a2357bb2e55083adf0 ]

When the "storcli2 show" command is executed for eHBA-9600, mpi3mr driver
prints this WARNING message:

  memcpy: detected field-spanning write (size 128) of single field "bsg_reply_buf->reply_buf" at drivers/scsi/mpi3mr/mpi3mr_app.c:1658 (size 1)
  WARNING: CPU: 0 PID: 12760 at drivers/scsi/mpi3mr/mpi3mr_app.c:1658 mpi3mr_bsg_request+0x6b12/0x7f10 [mpi3mr]

The cause of the WARN is 128 bytes memcpy to the 1 byte size array "__u8
replay_buf[1]" in the struct mpi3mr_bsg_in_reply_buf. The array is intended
to be a flexible length array, so the WARN is a false positive.

To suppress the WARN, remove the constant number '1' from the array
declaration and clarify that it has flexible length. Also, adjust the
memory allocation size to match the change.

Suggested-by: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20240323084155.166835-1-shinichiro.kawasaki@wdc.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_app.c    | 2 +-
 include/uapi/scsi/scsi_bsg_mpi3mr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 8c662d08706f1..42600e5c457a1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1344,7 +1344,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job, unsigned int *reply
 	if ((mpirep_offset != 0xFF) &&
 	    drv_bufs[mpirep_offset].bsg_buf_len) {
 		drv_buf_iter = &drv_bufs[mpirep_offset];
-		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) - 1 +
+		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) +
 					   mrioc->reply_sz);
 		bsg_reply_buf = kzalloc(drv_buf_iter->kern_buf_len, GFP_KERNEL);
 
diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
index fdc3517f9e199..c48c5d08c0fa0 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -382,7 +382,7 @@ struct mpi3mr_bsg_in_reply_buf {
 	__u8	mpi_reply_type;
 	__u8	rsvd1;
 	__u16	rsvd2;
-	__u8	reply_buf[1];
+	__u8	reply_buf[];
 };
 
 /**
-- 
2.43.0


