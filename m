Return-Path: <linux-scsi+bounces-371-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8E7FF2D0
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C391C20CED
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A6151C2C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
X-Greylist: delayed 522 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 06:37:53 PST
Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFF85;
	Thu, 30 Nov 2023 06:37:52 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3271:7f20:45e9:2b16:3419:6e5b])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 84FCE2C0305;
	Thu, 30 Nov 2023 22:28:54 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: zhuwei@sangfor.com.cn,
	thenzl@redhat.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 1/2] scsi: ses: Fix slab-out-of-bounds in ses_get_power_status()
Date: Thu, 30 Nov 2023 22:28:34 +0800
Message-Id: <20231130142835.18041-2-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130142835.18041-1-dinghui@sangfor.com.cn>
References: <20231130142835.18041-1-dinghui@sangfor.com.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh8dVktPHkodQx9DHh1CHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBTB1JS0FPTh5CQUkZSk1BSE9KQkFNHk4ZWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTklVSktLVUpCWQY+
X-HM-Tid: 0a8c20a1f75bb249kuuu84fce2c0305
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Eio5Ojw3MBdLSjhNLzEi
	Gh9PCRZVSlVKTEtKSE5PTkhOSUJIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxKQUwdSUtBT04eQkFJGUpNQUhPSkJBTR5OGVlXWQgBWUFJQ0JNNwY+
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

From: Zhu Wei <zhuwei@sangfor.com.cn>

A fix for:

BUG: KASAN: slab-out-of-bounds in ses_get_power_status+0x178/0x1a8 [ses]
Read of size 1 at addr ffffa5e3f9466a2b by task grep/102588
Call trace:
 ses_get_power_status+0x178/0x1a8 [ses]
 get_component_power_status+0x94/0x1f0 [enclosure]
 dev_attr_show+0x5c/0xc8
 sysfs_kf_seq_show+0x1b0/0x350
 kernfs_seq_show+0x10c/0x160
 seq_read+0x250/0xe28

If the page2 buffer is less than the number of elements indicated by page1,
that will cause desc_ptr to point to out-of-bounds.

The report occurs when we read sg power_status which iscsi target is a Dell
PowerVault MD3200i storage server.

Signed-off-by: Zhu Wei <zhuwei@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/scsi/ses.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index d7d0c35c58b8..2a404e51b6db 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -165,6 +165,8 @@ static int ses_set_page2_descriptor(struct enclosure_device *edev,
 	for (i = 0; i < ses_dev->page1_num_types; i++, type_ptr += 4) {
 		for (j = 0; j < type_ptr[1]; j++) {
 			desc_ptr += 4;
+			if (desc_ptr - ses_dev->page2 + 4 > ses_dev->page2_len)
+				break;
 			if (type_ptr[0] != ENCLOSURE_COMPONENT_DEVICE &&
 			    type_ptr[0] != ENCLOSURE_COMPONENT_ARRAY_DEVICE)
 				continue;
@@ -196,6 +198,8 @@ static unsigned char *ses_get_page2_descriptor(struct enclosure_device *edev,
 	for (i = 0; i < ses_dev->page1_num_types; i++, type_ptr += 4) {
 		for (j = 0; j < type_ptr[1]; j++) {
 			desc_ptr += 4;
+			if (desc_ptr - ses_dev->page2 + 4 > ses_dev->page2_len)
+				return NULL;
 			if (type_ptr[0] != ENCLOSURE_COMPONENT_DEVICE &&
 			    type_ptr[0] != ENCLOSURE_COMPONENT_ARRAY_DEVICE)
 				continue;
-- 
2.17.1


