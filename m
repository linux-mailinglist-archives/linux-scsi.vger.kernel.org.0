Return-Path: <linux-scsi+bounces-12284-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC87A35392
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2025 02:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082503AC029
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E653BE;
	Fri, 14 Feb 2025 01:16:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356B2753F4
	for <linux-scsi@vger.kernel.org>; Fri, 14 Feb 2025 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495788; cv=none; b=OjEUdKEhZGHmsGhC0rKiWoglVoqSuWWw5MhaFu49TfTqujUa8/T7eB4xHU6pdo3xaazzn5VoUkwpnfXvVAXXW8O9PtH+b5fLZ0rhcFnq+rUbrEEgwsL0HbQEOr+ZaW77eN4wc1I5RplZWP5tJ7yTh6iZZQBj8s3lYufB+splVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495788; c=relaxed/simple;
	bh=ILarBjDg+9Fy2lgbtdRKgb/jTDljAMAbQt2uCXZpKI4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eeWAoBmmXTQw0XsEMtJIYrhrPUyKT3EJUXIB7Os+iA9UVeyEZvaTqwNWLt4q19GA0cDXNL1wleqxMGw07C8XVcMczmTiJn16tKZC4Qvq/Zc2S/RWM7NkZfC3YU5R8KarMNa2SgJq/Xexj8tbykGzV4o6EmAUU1SwufmtrRDYwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvDdT2P0jz4f3jLG
	for <linux-scsi@vger.kernel.org>; Fri, 14 Feb 2025 09:15:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2069C1A084D
	for <linux-scsi@vger.kernel.org>; Fri, 14 Feb 2025 09:16:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgB32l5ima5nQ8QgDw--.22163S4;
	Fri, 14 Feb 2025 09:16:20 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: core: clear driver private data when retry request
Date: Fri, 14 Feb 2025 09:16:18 +0800
Message-Id: <20250214011618.286238-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l5ima5nQ8QgDw--.22163S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15GFyrWr48uF1xJw4rGrg_yoW8tw45pF
	WYq34qkr1rGFWrAws7XryUXF98K393Aryjga43WwnxWF1vk3yvyryUJFy5Xa4fXr1Iywn8
	tF4qqr9xWFy7ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

After commit 1bad6c4a57ef
("scsi: zero per-cmd private driver data for each MQ I/O"),
xen-scsifront/virtio_scsi/snic driver remove code that zeroes
driver-private command data. If request do retry will lead to
driver-private command data remains. Before commit 464a00c9e0ad
("scsi: core: Kill DRIVER_SENSE") if virtio_scsi do capacity
expansion, first request may return UA then request will do retry,
as driver-private command data remains, request will return UA
again. As a result, the request keeps retrying, and the request
times out and fails.
So zeroes driver-private command data when request do retry.

Fixes: f7de50da1479 ("scsi: xen-scsifront: Remove code that zeroes driver-private command data")
Fixes: c2bb87318baa ("scsi: virtio_scsi: Remove code that zeroes driver-private command data")
Fixes: c3006a926468 ("scsi: snic: Remove code that zeroes driver-private command data")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_lib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index be0890e4e706..c876b1c82153 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1669,13 +1669,6 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 
-	/*
-	 * Only clear the driver-private command data if the LLD does not supply
-	 * a function to initialize that data.
-	 */
-	if (!shost->hostt->init_cmd_priv)
-		memset(cmd + 1, 0, shost->hostt->cmd_size);
-
 	cmd->prot_op = SCSI_PROT_NORMAL;
 	if (blk_rq_bytes(req))
 		cmd->sc_data_direction = rq_dma_dir(req);
@@ -1842,6 +1835,13 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!scsi_host_queue_ready(q, shost, sdev, cmd))
 		goto out_dec_target_busy;
 
+	/*
+	 * Only clear the driver-private command data if the LLD does not supply
+	 * a function to initialize that data.
+	 */
+	if (!shost->hostt->init_cmd_priv && shost->hostt->cmd_size)
+		memset(cmd + 1, 0, shost->hostt->cmd_size);
+
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = scsi_prepare_cmd(req);
 		if (ret != BLK_STS_OK)
-- 
2.34.1


