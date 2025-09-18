Return-Path: <linux-scsi+bounces-17146-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59DB52389
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Sep 2025 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2647B3CB8
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Sep 2025 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43092311582;
	Wed, 10 Sep 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YHa6yxSU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814ED2DCC1C;
	Wed, 10 Sep 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540120; cv=none; b=LqArvH4cMF8w4Rh52Cws+PxkisYdVkHCmvfSJi7TA+BWP2RLmMhNT6uR2DAZPBYH4oPfMEct8n5M1kTXOGMO2Lath1RSju6is31aTh267JaVo+pi5YM1dW5mtRimtaBtAweKsSjpoGjrc0lKHXQ1UCgb2ii0GgNIbhT+fTkRUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540120; c=relaxed/simple;
	bh=GM38qfjlcSli+F+tk9eNSatF1+DiLwvDttpGCfPl3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzSOytplWx48jgWV1Q5BpjuffHGHA6S8mRf6tK6b6FCXjJDFLLX6AtvdXwc7E/a5tHexkQOv2nBAckNg5I61bLYBAyx6ZgnpIXhqKHQdIGIr72jcYVg2rtLVK+hJSVlRNLtcG1PWL6lRM+E82AN63oizd7IyIO12Wgpqvq8Vit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YHa6yxSU; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cMYny5Wljzm174L;
	Wed, 10 Sep 2025 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1757539989; x=1760131990; bh=yTPwXLiXWS2l7qOP+m2/ID68Lp+8TedPOm3
	HugbZR38=; b=YHa6yxSUu+AZIhl4vY3d9CD7Hhjen33cayO+gHgXAnI1H7CW8UZ
	3hPTlPHMGdpdKxF9mPWHFDRQDlTZ3KhEptyBoTG6NeTel/SABQRF+/tBuOTU6hlv
	Ys2CoO7DA+zCA0K9NRdYG32gPG8trtp/yt1DAKVIvyu3gIVTbihB1TCrXqeevo/h
	8dtrobAqq3212PWum/UAOSc8Rpg3nj3Xa4enF+ddXrFGxubrHnV0cDGnYSRmkz8y
	jmd7x+TvsVArVLdKe6sMcba1CbYHJX03Z1SVCvsxvOCL69rfUyffDwZWEOI0dseh
	7MVvnnbi5VnF+IQTAIx5pC8C0YujPawSR7Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msweF8L1cTiH; Wed, 10 Sep 2025 21:33:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cMYnv1YPpzm0ySg;
	Wed, 10 Sep 2025 21:33:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Improve host-wide tag IOPS
Date: Wed, 10 Sep 2025 14:32:48 -0700
Message-ID: <20250910213254.1215318-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

The more UFS device IOPS increase, the more SCSI budget management become=
s a
bottleneck. Hence this patch series that disables SCSI budget management =
for
host drivers that don't need it. Please consider this patch series for th=
e next
merge window.

Thanks,

Bart.

Bart Van Assche (3):
  block: Export blk_mq_all_tag_iter()
  ufs: core: Use scsi_device_busy()
  scsi: core: Improve IOPS in case of host-wide tags

 block/blk-mq-tag.c         |  1 +
 block/blk-mq.h             |  2 --
 drivers/scsi/scsi.c        |  7 ++++-
 drivers/scsi/scsi_lib.c    | 60 +++++++++++++++++++++++++++++++++-----
 drivers/scsi/scsi_scan.c   | 11 ++++++-
 drivers/ufs/core/ufshcd.c  |  4 +--
 include/linux/blk-mq.h     |  2 ++
 include/scsi/scsi_device.h |  5 +---
 8 files changed, 75 insertions(+), 17 deletions(-)

