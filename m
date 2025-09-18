Return-Path: <linux-scsi+bounces-17085-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D15B50182
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Sep 2025 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DA31886B51
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Sep 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB5356916;
	Tue,  9 Sep 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Udv5OKaw"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F73570BD
	for <linux-scsi@vger.kernel.org>; Tue,  9 Sep 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431795; cv=none; b=jm8hUyJ80ZZ7CVP06o6mEEFvs7edspRhAved1UybsZijigGlPtmKJTO5paiIMPLfMaasenm3Ou4Xy/D5froRH2vlCkEksR0laLh0+1+ZYFAB34qKSHL8jb+RwzfAuTwdCkK+PdVESAgk2AeNyk0t6fLn5Xl1lIppfV7rh4zIjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431795; c=relaxed/simple;
	bh=/4ecEdJ+qGjfmy9yImHlAlNmO8QiCe+KsB7GVqxPqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxBOgRHQ8WlRwXr2tZSpqvK0apdZOQQhIG5N/gFrT6udDQVt+gQHmrVK0xjDYEmtVm+KnoUYWFtmyn0ZZbK/lIyynMrtcLeN73O6wWjpVPlVTnez8E7Oi4krsKDCvqjOdFOrMqDAucqv3jdMXJd4yZo1nH9muq3ARrhA63CM9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Udv5OKaw; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757431781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GN4o6Rpepn1nYUO5av96IxMhD2q/WJpyOYfgvLYpNxI=;
	b=Udv5OKaw3H1Wbm9wnqhs6hsaaB4FFGvv0GWuqvefXkF1nOTkR0jyeJtv8NWMolxJX7xK/D
	xToMU4p/lWBTyT0qIhREvJqXWPzRQvj670Q7r2MX3QJdu8EVrnwB8dvtfE8C8pKG8jBCZx
	H6FN5vTfx6v7leBgWu4xiNB4bHCJoMs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: Replace kmalloc + copy_from_user with memdup_user
Date: Tue,  9 Sep 2025 17:27:33 +0200
Message-ID: <20250909152732.760975-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify hpsa_passthru_ioctl().

Since memdup_user() already allocates memory, use kzalloc() in the else
branch instead of manually zeroing 'buff' using memset(0).

Return early if an error occurs and remove the 'out_kfree' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c73a71ac3c29..55448238d8ed 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6407,18 +6407,14 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h,
 		return -EINVAL;
 	}
 	if (iocommand->buf_size > 0) {
-		buff = kmalloc(iocommand->buf_size, GFP_KERNEL);
-		if (buff == NULL)
-			return -ENOMEM;
 		if (iocommand->Request.Type.Direction & XFER_WRITE) {
-			/* Copy the data into the buffer we created */
-			if (copy_from_user(buff, iocommand->buf,
-				iocommand->buf_size)) {
-				rc = -EFAULT;
-				goto out_kfree;
-			}
+			buff = memdup_user(iocommand->buf, iocommand->buf_size);
+			if (IS_ERR(buff))
+				return PTR_ERR(buff);
 		} else {
-			memset(buff, 0, iocommand->buf_size);
+			buff = kzalloc(iocommand->buf_size, GFP_KERNEL);
+			if (!buff)
+				return -ENOMEM;
 		}
 	}
 	c = cmd_alloc(h);
@@ -6478,7 +6474,6 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h,
 	}
 out:
 	cmd_free(h, c);
-out_kfree:
 	kfree(buff);
 	return rc;
 }
-- 
2.51.0


