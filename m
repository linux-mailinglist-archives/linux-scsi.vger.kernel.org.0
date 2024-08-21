Return-Path: <linux-scsi+bounces-7527-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9F959489
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Aug 2024 08:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FD81F24386
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Aug 2024 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6A16DC11;
	Wed, 21 Aug 2024 06:28:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47E16D9A7
	for <linux-scsi@vger.kernel.org>; Wed, 21 Aug 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221735; cv=none; b=CRLZ0S2PQ+OwlWChYH4nEbugNOkCofgw4d6UrkKhIARTlPRHCH81gmawj+RpUWAt5fNSyLvTqFqNk0r0/vu5Ns/eikcAgRBB18NzH0iYVUgZDgsJdYR3VKIpdzXpl8qMH0pXhyrp4iSGWLNOj7/UK5YWzME697Ci4N67wYwPHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221735; c=relaxed/simple;
	bh=AT+h+PMJv3iLk4GrKR1icil37rWOLljV/+sZS2N+/E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOzpzvY2I/Yl4s3NqPDrZVC4JAdkJQp0a+D3U13q0hchc1pbRZsTwYBXy/PIkn70uuwDq2lvUaQL/AIk+uFrs8B/gHOg9uZ/+WgF6Hz56U01RI4qT+WwJMUN3PIOGKwqXHncL/+f9y2TYdQBmTparcams3vbywtxjf63vF2j9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WpbxP63byzpT0b;
	Wed, 21 Aug 2024 14:28:09 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D7F851401F4;
	Wed, 21 Aug 2024 14:28:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:28:48 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 1/2] driver: scsi: Make use of the helper macro LIST_HEAD()
Date: Wed, 21 Aug 2024 14:36:09 +0800
Message-ID: <20240821063609.2292672-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821063609.2292672-1-lihongbo22@huawei.com>
References: <20240821063609.2292672-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index bc3b2aea3f8b..6af37c337070 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6478,7 +6478,7 @@ qla24xx_free_purex_item(struct purex_item *item)
 
 void qla24xx_process_purex_list(struct purex_list *list)
 {
-	struct list_head head = LIST_HEAD_INIT(head);
+	LIST_HEAD(head);
 	struct purex_item *item, *next;
 	ulong flags;
 
-- 
2.34.1


