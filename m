Return-Path: <linux-scsi+bounces-3704-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8388FAAD
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 10:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEC8B22F06
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1154664;
	Thu, 28 Mar 2024 09:06:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151A39FD8;
	Thu, 28 Mar 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616793; cv=none; b=qwMiK7tlE7LzHNOsv7huvciS7EN9irQJ3NcFUcXWpFXsLE4GI6iNwpJGZLL7eJcMwJ0qwSI13EcYAG++aOlhQPPDkQMOZFuMd8/VbJ5wHt38fIXgdLDjUdb7wq2HhmeT/1G+6AJaFGUasw6TFhkZNN+6A6I2ECoDvdXQW2LPcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616793; c=relaxed/simple;
	bh=Lc0IotqXw2gAX1b8tilNy6g3z9IyZ4SY1RLG5vS3eQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rqfj1TwkM35KB2PbtBoBPXqpMkoXip4KxzXWyp2qCfFb2rY0kMYgATplE+g8hDWNgJ0gh8Y5zV8wIzHIBcJVHs0HbSrcS9Lu51LFLG/VDg7/XVaVATKjuFj7YXYTtviakUoTziCnpz+SmiAlheeyOt92fz1LYyHLw91zfSpy9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V4yLq5VfGz1GDKr;
	Thu, 28 Mar 2024 17:05:55 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ECC514011F;
	Thu, 28 Mar 2024 17:06:27 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 17:06:26 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <dlemoal@kernel.org>,
	<chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>,
	<liyihang9@huawei.com>
Subject: [PATCH v4] scsi: libsas: Allocation SMP request is aligned to ARCH_DMA_MINALIGN
Date: Thu, 28 Mar 2024 17:06:26 +0800
Message-ID: <20240328090626.621147-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)

This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
(from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
through kmalloc() allocation. However, for the hisi_sas hardware, all
commands address must be 16-byte-aligned. Otherwise, the commands fail to
be executed.

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.

Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
Signed-off-by: Yihang Li <liyihang9@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes since v3:
- Still aligned to ARCH_DMA_MINALIGN for safe DMA operations.

Changes since v2:
- Use 16B as alignment for SMP requests instead of ARCH_DMA_MINALIGN.

Changes since v1:
- Directly modify alloc_smp_req() instead of using handler callback.
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..c989d182fc75 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 static inline void *alloc_smp_req(int size)
 {
-	u8 *p = kzalloc(size, GFP_KERNEL);
+	u8 *p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
 	if (p)
 		p[0] = SMP_REQUEST;
 	return p;
-- 
2.33.0


