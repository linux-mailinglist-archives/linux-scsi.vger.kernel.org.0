Return-Path: <linux-scsi+bounces-1529-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DE682AD6C
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jan 2024 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3711C23302
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jan 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9614F9C;
	Thu, 11 Jan 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Gb3c5tX/"
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FEE15483;
	Thu, 11 Jan 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=h6fiA7ttQpnXiYdSgC
	uAsCXgr+qLme/2wV2ipqL7cMc=; b=Gb3c5tX/KJM/d5OE7/b2l6wLVmmQZi/JcB
	r8kjyNDNPf4bGgO1pPJyhhhMKND9I65ZBByLtaOEY6XHfsRPjsTMv+o81JpzUjCT
	WvyCClBFMMvQpnJH5LH7443M8iTJCEmWM3dBQniPrxBYYm4/0Gp8TbcL4wAOePk4
	SG74QxYnA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDXf6h10Z9l8Vk5AA--.29322S2;
	Thu, 11 Jan 2024 19:31:01 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	aacraid@microsemi.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: aacraid: Clean up errors in linit.c
Date: Thu, 11 Jan 2024 11:30:59 +0000
Message-Id: <20240111113059.15899-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXf6h10Z9l8Vk5AA--.29322S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1ruw1kJFW5KrW7JF47Arb_yoW8WF45pF
	43Cw1jkr48tF1Uuan8XF43ZFyay348J348Way8J3yF9r1Dt34kJa48XFyUZF1rC3ykGFnx
	tF4qy340kF1vkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRPfHbUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBVixWV2z0ZVqgAAsL
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/aacraid/linit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff49..cd62e95a7c7a 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -676,12 +676,12 @@ static int get_num_of_incomplete_fibs(struct aac_dev *aac)
 	return fcnt.mlcnt + fcnt.llcnt + fcnt.ehcnt + fcnt.fwcnt;
 }
 
-static int aac_eh_abort(struct scsi_cmnd* cmd)
+static int aac_eh_abort(struct scsi_cmnd *cmd)
 {
 	struct aac_cmd_priv *cmd_priv = aac_priv(cmd);
-	struct scsi_device * dev = cmd->device;
-	struct Scsi_Host * host = dev->host;
-	struct aac_dev * aac = (struct aac_dev *)host->hostdata;
+	struct scsi_device *dev = cmd->device;
+	struct Scsi_Host *host = dev->host;
+	struct aac_dev *aac = (struct aac_dev *)host->hostdata;
 	int count, found;
 	u32 bus, cid;
 	int ret = FAILED;
@@ -900,9 +900,9 @@ static void aac_tmf_callback(void *context, struct fib *fibptr)
  */
 static int aac_eh_dev_reset(struct scsi_cmnd *cmd)
 {
-	struct scsi_device * dev = cmd->device;
-	struct Scsi_Host * host = dev->host;
-	struct aac_dev * aac = (struct aac_dev *)host->hostdata;
+	struct scsi_device *dev = cmd->device;
+	struct Scsi_Host *host = dev->host;
+	struct aac_dev *aac = (struct aac_dev *)host->hostdata;
 	struct aac_hba_map_info *info;
 	int count;
 	u32 bus, cid;
-- 
2.17.1


