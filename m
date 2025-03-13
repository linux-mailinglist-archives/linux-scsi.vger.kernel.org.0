Return-Path: <linux-scsi+bounces-12784-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53662A5E988
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Mar 2025 02:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2982A189CEFF
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Mar 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3F2AD31;
	Thu, 13 Mar 2025 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aucU6+6c"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E227713;
	Thu, 13 Mar 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830465; cv=none; b=Pxy4zXe6zhO52pI0IczcsKuKSuds/ZR85Nb3jK2T8nODegKjQED6zKbR3w1hSam+TTd8CTgqP55m8cmYmjLp1Y+Uhvyg7KUhk9VD8pBV8/xZeyK//nJP6RscUAbPMPnP20SLZZc2S3OJQmvKbcxAQvUXiGS3G5yUQ256pc/+OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830465; c=relaxed/simple;
	bh=mxiyGagTYx3oxb2DQeCRcATKzegNBuElrgI9KqfVNvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+HUu6SZ10rNCykPu5CXAJudz3cK/bkdLaoULjGwwOa9cn6CTiXQff+KeXiOpxgf+h5iV6aOBGZUfg2u7J18yJKMwwor/kZDrC/C/afFEtfLScL5QB9hoq6zfx+Fd/XSHiYmzccVDE8b9qNF6AJqgrBvg6ojKp39ixHqv6J+vUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aucU6+6c; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741830453; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GZUhXpt0pv+o4mjZJENtHqFui2vF5F/TjzpAuhFsWOE=;
	b=aucU6+6cn36L8cjFUtYJg76ef6QT22AtWF3nswhX4dQ9ysX4AGCPQZsI4XL4Nrk1A8yORI6Rc0iX5djlJk4CKuE3M5hf8BPxny7h/77yP6Hv4+6/rjmFkYal8QOF5DZXaz6tmeh9zN7NaFjt+AlA+CzazmvWpgNnzinZAb76yug=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WREb3bM_1741830448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 09:47:32 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH] scsi: target: tcm_loop: fix wrong abort tag
Date: Thu, 13 Mar 2025 09:47:27 +0800
Message-ID: <20250313014728.105849-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the tcm_loop_nr_hw_queues is set to a value greater than 1, the
tags of requests in the block layer are no longer unique. This may lead
to erroneous aborting of commands with the same tag. The issue can be
resolved by using blk_mq_unique_tag to generate globally unique
identifiers by combining the hardware queue index and per-queue tags.

Fixes: 6375f8908255 ("tcm_loop: Fixup tag handling")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/target/loopback/tcm_loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 761c511aea07..c7b7da629741 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -176,7 +176,7 @@ static int tcm_loop_queuecommand(struct Scsi_Host *sh, struct scsi_cmnd *sc)
 
 	memset(tl_cmd, 0, sizeof(*tl_cmd));
 	tl_cmd->sc = sc;
-	tl_cmd->sc_cmd_tag = scsi_cmd_to_rq(sc)->tag;
+	tl_cmd->sc_cmd_tag = blk_mq_unique_tag(scsi_cmd_to_rq(sc));
 
 	tcm_loop_target_queue_cmd(tl_cmd);
 	return 0;
@@ -242,7 +242,8 @@ static int tcm_loop_abort_task(struct scsi_cmnd *sc)
 	tl_hba = *(struct tcm_loop_hba **)shost_priv(sc->device->host);
 	tl_tpg = &tl_hba->tl_hba_tpgs[sc->device->id];
 	ret = tcm_loop_issue_tmr(tl_tpg, sc->device->lun,
-				 scsi_cmd_to_rq(sc)->tag, TMR_ABORT_TASK);
+				 blk_mq_unique_tag(scsi_cmd_to_rq(sc)),
+				 TMR_ABORT_TASK);
 	return (ret == TMR_FUNCTION_COMPLETE) ? SUCCESS : FAILED;
 }
 
-- 
2.43.0


