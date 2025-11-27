Return-Path: <linux-scsi+bounces-19368-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D37C8F5F0
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Nov 2025 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603933ABCCC
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Nov 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF2336EC0;
	Thu, 27 Nov 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+nZWWyS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF23337B9B
	for <linux-scsi@vger.kernel.org>; Thu, 27 Nov 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258883; cv=none; b=akJbU2hkKAI7ogxr2jgupSkkdgbQCEJiTP8m1JxMzCzwq8oIPBuC2PKTHGOUm97I2OPrBca2wKBO1H3qt/lzcXgqzpjRaD9ewgiX2+V9F3ApX5nXml9xphitgb6YbxpJfPgQd7qmZK2aSyqEuUBHi+wHavMFbN+6ul7CBBAeOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258883; c=relaxed/simple;
	bh=CG0WCXs5GtINbmf9Z6msAYJS70/y7x1p3+LE85tX23I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYTtO6AAF5YqWQl4LzWtzMXOwADmAshAtihRIIUmtTj9gBYN2CyICwL/cOymQWHDNbmWO9mOCPcLAuGfUAuSztPodN8TLtnNv+0JdTQHPyBy3/woorktks19f/rCWwGrQzejdM6SD1FIaeuvof3W9liaEnzx2LxLDHwlJ3B+Xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+nZWWyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764258880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yiEqdjZP2pjR5NE43rCMghlmUF6oy2t/sXcmabl5AU=;
	b=K+nZWWySo9rGuE7+jBvBqCVG9nn3DHNf5e9xMtZF1zdViosPjsyAiSjB4K1s+5fj+sWYm5
	Zt+6qpxThRhUXqrJ6CHUDCcoyJtO3nplwiYPCK+PbHesQi9xH1A2HUw0ShKyrY3r6lTWh6
	L++bLA9TDcpEjcUTEWrjPJFueILOLNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-TZXPpSsGNVuPgZswTFV2mw-1; Thu,
 27 Nov 2025 10:54:35 -0500
X-MC-Unique: TZXPpSsGNVuPgZswTFV2mw-1
X-Mimecast-MFC-AGG-ID: TZXPpSsGNVuPgZswTFV2mw_1764258873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D98D180034D;
	Thu, 27 Nov 2025 15:54:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D126180047F;
	Thu, 27 Nov 2025 15:54:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/4] nvme: reject invalid pr_read_keys() num_keys values
Date: Thu, 27 Nov 2025 10:54:22 -0500
Message-ID: <20251127155424.617569-3-stefanha@redhat.com>
In-Reply-To: <20251127155424.617569-1-stefanha@redhat.com>
References: <20251127155424.617569-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
Reservation Report command has a u32 maximum length. Reject num_keys
values that are too large to fit.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/nvme/host/pr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b139..156a2ae1fac2e 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -233,6 +233,10 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	int ret, i;
 	bool eds;
 
+	/* Check that keys fit into u32 rse_len */
+	if (num_keys > (U32_MAX - sizeof(*rse)) / sizeof(rse->regctl_eds[0]))
+		return -EINVAL;
+
 	/*
 	 * Assume we are using 128-bit host IDs and allocate a buffer large
 	 * enough to get enough keys to fill the return keys buffer.
-- 
2.52.0


