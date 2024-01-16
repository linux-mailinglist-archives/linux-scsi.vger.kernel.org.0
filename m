Return-Path: <linux-scsi+bounces-1621-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966582E902
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jan 2024 06:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0771D1C22CF6
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jan 2024 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE510A23;
	Tue, 16 Jan 2024 04:58:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx312.baidu.com [180.101.52.108])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2510A05
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jan 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id D5DAE7F00045;
	Tue, 16 Jan 2024 12:58:41 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_scsi: remove duplicate check if queue is broken
Date: Tue, 16 Jan 2024 12:58:36 +0800
Message-Id: <20240116045836.12475-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

virtqueue_enable_cb() will call virtqueue_poll() which will check if
queue is broken at beginning, so remove the virtqueue_is_broken() call

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/scsi/virtio_scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcd..e15b380 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -182,8 +182,6 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
 		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
 			fn(vscsi, buf);
 
-		if (unlikely(virtqueue_is_broken(vq)))
-			break;
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
 }
-- 
2.9.4


