Return-Path: <linux-scsi+bounces-297-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613077FDD67
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174931F209A7
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3134546
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kuj9Ho/D"
X-Original-To: linux-scsi@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA6D6DD;
	Wed, 29 Nov 2023 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/S2A/EeNHbYjLnA0IJ
	VqikibUA8CJdMhN9CjXBD7ITw=; b=kuj9Ho/DifavLASqZBVo0EQMGnWGpdX57G
	Odr/0Fsl2iXVz7D4QHgIQYHwiGa/9H7wTyj3iVpOSKlt3bRXYqwa8VcORu2rBokH
	gpU3pdT+yhFBsE/9p2jqA7JFXlR8ojb7qkMTQWSTrzVy7Oc2lMUPXTZjFnQOiwTZ
	JmjHD8Ks8=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD333ERUGdls+wAAA--.230S2;
	Wed, 29 Nov 2023 22:52:03 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: jejb@linux.ibm.com
Cc: martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [scsi] lasi700: Add error handling in lasi700_probe
Date: Wed, 29 Nov 2023 06:52:00 -0800
Message-Id: <20231129145200.34596-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD333ERUGdls+wAAA--.230S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4UJr4DCry7ur4kXr4kXrb_yoW8Zr1Dpa
	ykGws8Crs8Jr1xCw13Ja1UAF1Yq3yftry7Ka43Z3sIv3W3JFyktr4vyFyruFyrKrWvk3WU
	XF1jqrW293WDCFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pZjqiDUUUUU=
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZRo3gl8ZaQ-qYQADsi
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

This patch introduces improved error handling for the dma_set_mask and
ioremap calls in the lasi700_probe function within drivers/scsi/lasi700.c.
Previously, the function did not properly handle the potential failure of
these calls, which could lead to improper device initialization and
unpredictable behavior.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/scsi/lasi700.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lasi700.c b/drivers/scsi/lasi700.c
index 86fe19e0468d..8d482bee940d 100644
--- a/drivers/scsi/lasi700.c
+++ b/drivers/scsi/lasi700.c
@@ -87,6 +87,7 @@ lasi700_probe(struct parisc_device *dev)
 	unsigned long base = dev->hpa.start + LASI_SCSI_CORE_OFFSET;
 	struct NCR_700_Host_Parameters *hostdata;
 	struct Scsi_Host *host;
+	int err;
 
 	hostdata = kzalloc(sizeof(*hostdata), GFP_KERNEL);
 	if (!hostdata) {
@@ -95,8 +96,20 @@ lasi700_probe(struct parisc_device *dev)
 	}
 
 	hostdata->dev = &dev->dev;
-	dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	err = dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(&dev->dev, "Failed to set DMA mask: %d\n", err);
+		kfree(hostdata);
+		return err;
+	}
+
 	hostdata->base = ioremap(base, 0x100);
+	if (!hostdata->base) {
+		dev_err(&dev->dev, "ioremap failed\n");
+		kfree(hostdata);
+		return -ENOMEM;
+	}
+
 	hostdata->differential = 0;
 
 	if (dev->id.sversion == LASI_700_SVERSION) {
-- 
2.17.1


