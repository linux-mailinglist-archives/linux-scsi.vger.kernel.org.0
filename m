Return-Path: <linux-scsi+bounces-372-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF57FF2D1
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 15:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B42813E9
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829E38DDD
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0BBD;
	Thu, 30 Nov 2023 06:37:54 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3271:7f20:45e9:2b16:3419:6e5b])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 034032C064F;
	Thu, 30 Nov 2023 22:28:46 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: zhuwei@sangfor.com.cn,
	thenzl@redhat.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 0/2] scsi: ses: Fix out-of-bounds accesses
Date: Thu, 30 Nov 2023 22:28:33 +0800
Message-Id: <20231130142835.18041-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkJDVkNPGUIZQk4YHUMZGlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBTB1JS0FPTh5CQUkZSk1BSE9KQkFNHk4ZWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTklVSktLVUpCWQY+
X-HM-Tid: 0a8c20a1d9f1b249kuuu034032c064f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Szo*Tzw1QxcYFTg*LzcY
	LREKCSpVSlVKTEtKSE5PTklMTEJOVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxKQUwdSUtBT04eQkFJGUpNQUhPSkJBTR5OGVlXWQgBWUFKSkhNNwY+
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

This series includes a few OOB fixes for ses driver

Ding Hui (1):
  scsi: ses: increase default init_alloc_size

Zhu Wei (1):
  scsi: ses: Fix slab-out-of-bounds in ses_get_power_status()

 drivers/scsi/ses.c | 55 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

-- 
2.17.1


