Return-Path: <linux-scsi+bounces-373-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAAE7FF2D2
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FE0B20B4A
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D551C2C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m118208.qiye.163.com (mail-m118208.qiye.163.com [115.236.118.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C811B4;
	Thu, 30 Nov 2023 06:38:06 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3271:7f20:45e9:2b16:3419:6e5b])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id A0A592C04E9;
	Thu, 30 Nov 2023 22:28:57 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: zhuwei@sangfor.com.cn,
	thenzl@redhat.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 2/2] scsi: ses: increase default init_alloc_size
Date: Thu, 30 Nov 2023 22:28:35 +0800
Message-Id: <20231130142835.18041-3-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130142835.18041-1-dinghui@sangfor.com.cn>
References: <20231130142835.18041-1-dinghui@sangfor.com.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGksfVkNDTEkaS0hCGEMaQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBTB1JS0FPTh5CQUkZSk1BSE9KQkFNHk4ZWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTklVSktLVUpCWQY+
X-HM-Tid: 0a8c20a20383b249kuuua0a592c04e9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46LRw4LTw#SxcBIzgRLzgY
	Fh4KCQlVSlVKTEtKSE5PTkhDTUJNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxKQUwdSUtBT04eQkFJGUpNQUhPSkJBTR5OGVlXWQgBWUFMSE9KNwY+
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

In 2020, I sent a patch [1] to address crash due to zero component count,
at that time, I did not dig why the ses driver got 0 but sg_ses tool got
the right component count. Now we have the answer.

In ses, when we prepare to receive a full diagnostic page{1,2,7,10},
we first detect the page length by a RECEIVE_DIAGNOSTIC request
with INIT_ALLOC_SIZE buffer len, we expect to get the correct page
length regardless of detecting request buffer len.

But for some storage device (e.g. vendor:DELL product:MD32xxi rev:0784),
its behavior is different. It replies the page length indicating that
it actually filled the buffer size in the response, rather that the
original page length it should be.

In this situation, the device reply hdr_buf[3]=28 since our detecting
request buffer is 32, we will allocate small buffer and save partial diag
page content, when we parse the page content, multiple types OOB reading
could be triggered. This is also the root cause of the OOB handled by
Zhu Wei in the previous patch.

The sg_ses directly invoke SG_IO ioctl with dxfer_len=65535, so it
always can report the right elements and descriptors.

To work well with this kind of devices, I increase the default
init_alloc_size to a relative large enough length for most devices,
and convert it to a module param in case some one need even larger
who warned by the log "Suspicious pageX len Y, try larger
init_alloc_size".

[1]: https://patchwork.kernel.org/patch/11938277

Cc: Zhu Wei <zhuwei@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/scsi/ses.c | 51 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 2a404e51b6db..40069a4b51a8 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -35,6 +35,29 @@ struct ses_component {
 	u64 addr;
 };
 
+#define INIT_ALLOC_SIZE_DEF 4096
+#define INIT_ALLOC_SIZE_MIN 32
+#define INIT_ALLOC_SIZE_MAX 65535
+
+static uint init_alloc_size = INIT_ALLOC_SIZE_DEF;
+
+static int param_set_init_alloc_size(const char *val, const struct kernel_param *kp)
+{
+	uint size;
+	int ret = kstrtouint(val, 0, &size);
+
+	if (ret)
+		return ret;
+
+	init_alloc_size = clamp_t(uint, size, INIT_ALLOC_SIZE_MIN, INIT_ALLOC_SIZE_MAX);
+	return 0;
+}
+
+module_param_call(init_alloc_size, param_set_init_alloc_size, param_get_uint,
+		  &init_alloc_size, 0644);
+MODULE_PARM_DESC(init_alloc_size, "Buffer size for detecting diagnostic pages length. "
+		 "[Default=" __stringify(INIT_ALLOC_SIZE_DEF) "]");
+
 static bool ses_page2_supported(struct enclosure_device *edev)
 {
 	struct ses_device *ses_dev = edev->scratch;
@@ -525,8 +548,6 @@ static int ses_enclosure_find_by_addr(struct enclosure_device *edev,
 	return 0;
 }
 
-#define INIT_ALLOC_SIZE 32
-
 static void ses_enclosure_data_process(struct enclosure_device *edev,
 				       struct scsi_device *sdev,
 				       int create)
@@ -536,7 +557,8 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 	int i, j, page7_len, len, components;
 	struct ses_device *ses_dev = edev->scratch;
 	int types = ses_dev->page1_num_types;
-	unsigned char *hdr_buf = kzalloc(INIT_ALLOC_SIZE, GFP_KERNEL);
+	int hdr_buf_len = init_alloc_size;
+	unsigned char *hdr_buf = kzalloc(hdr_buf_len, GFP_KERNEL);
 
 	if (!hdr_buf)
 		goto simple_populate;
@@ -545,11 +567,14 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 	if (ses_dev->page10)
 		ses_recv_diag(sdev, 10, ses_dev->page10, ses_dev->page10_len);
 	/* Page 7 for the descriptors is optional */
-	result = ses_recv_diag(sdev, 7, hdr_buf, INIT_ALLOC_SIZE);
+	result = ses_recv_diag(sdev, 7, hdr_buf, hdr_buf_len);
 	if (result)
 		goto simple_populate;
 
 	page7_len = len = (hdr_buf[2] << 8) + hdr_buf[3] + 4;
+	if (page7_len == hdr_buf_len)
+		sdev_printk(KERN_WARNING, sdev,
+			    "Suspicious page7 len %d, try larger init_alloc_size\n", page7_len);
 	/* add 1 for trailing '\0' we'll use */
 	buf = kzalloc(len + 1, GFP_KERNEL);
 	if (!buf)
@@ -678,6 +703,7 @@ static int ses_intf_add(struct device *cdev)
 	int num_enclosures;
 	struct enclosure_device *edev;
 	struct ses_component *scomp = NULL;
+	int hdr_buf_len = init_alloc_size;
 
 	if (!scsi_device_enclosure(sdev)) {
 		/* not an enclosure, but might be in one */
@@ -695,16 +721,19 @@ static int ses_intf_add(struct device *cdev)
 		sdev_printk(KERN_NOTICE, sdev, "Embedded Enclosure Device\n");
 
 	ses_dev = kzalloc(sizeof(*ses_dev), GFP_KERNEL);
-	hdr_buf = kzalloc(INIT_ALLOC_SIZE, GFP_KERNEL);
+	hdr_buf = kzalloc(hdr_buf_len, GFP_KERNEL);
 	if (!hdr_buf || !ses_dev)
 		goto err_init_free;
 
 	page = 1;
-	result = ses_recv_diag(sdev, page, hdr_buf, INIT_ALLOC_SIZE);
+	result = ses_recv_diag(sdev, page, hdr_buf, hdr_buf_len);
 	if (result)
 		goto recv_failed;
 
 	len = (hdr_buf[2] << 8) + hdr_buf[3] + 4;
+	if (len == hdr_buf_len)
+		sdev_printk(KERN_WARNING, sdev,
+			    "Suspicious page1 len %d, try larger init_alloc_size\n", len);
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto err_free;
@@ -741,11 +770,14 @@ static int ses_intf_add(struct device *cdev)
 	buf = NULL;
 
 	page = 2;
-	result = ses_recv_diag(sdev, page, hdr_buf, INIT_ALLOC_SIZE);
+	result = ses_recv_diag(sdev, page, hdr_buf, hdr_buf_len);
 	if (result)
 		goto page2_not_supported;
 
 	len = (hdr_buf[2] << 8) + hdr_buf[3] + 4;
+	if (len == hdr_buf_len)
+		sdev_printk(KERN_WARNING, sdev,
+			    "Suspicious page2 len %d, try larger init_alloc_size\n", len);
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto err_free;
@@ -761,10 +793,13 @@ static int ses_intf_add(struct device *cdev)
 	/* The additional information page --- allows us
 	 * to match up the devices */
 	page = 10;
-	result = ses_recv_diag(sdev, page, hdr_buf, INIT_ALLOC_SIZE);
+	result = ses_recv_diag(sdev, page, hdr_buf, hdr_buf_len);
 	if (!result) {
 
 		len = (hdr_buf[2] << 8) + hdr_buf[3] + 4;
+		if (len == hdr_buf_len)
+			sdev_printk(KERN_WARNING, sdev,
+				    "Suspicious page10 len %d, try larger init_alloc_size\n", len);
 		buf = kzalloc(len, GFP_KERNEL);
 		if (!buf)
 			goto err_free;
-- 
2.17.1


