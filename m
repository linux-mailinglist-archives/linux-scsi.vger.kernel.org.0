Return-Path: <linux-scsi+bounces-4617-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA18A7204
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Apr 2024 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE94B22989
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Apr 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9571332A7;
	Tue, 16 Apr 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S1LqRI7M"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86357133284
	for <linux-scsi@vger.kernel.org>; Tue, 16 Apr 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287651; cv=none; b=PuYRm80e+hQbT5OTIh/raZSbh6EZ8xIq3FCiJN8ApynaSKS8WZT+LIuGrgVUq11yf22JWNi27WiaGWficaCXQjkllykOaCv+ixBgLD2X2gxwMquMD5WEmqptqDFrxTPVv9JisI7+DcJZ178D+N9oTaIGLWyFekvIeru7JA42BmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287651; c=relaxed/simple;
	bh=T9WrfpuBDHAe4xeZm3YN8pMCpcrsE0CX5iaqAirKMB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgRKfiQhpt6dDl+Jgdh/6gzqKYwupjzjrX3EyM6lBuBTbk8jzm+KzLmDeMbMvqYxYhDnuucGLPo+9JJNw3wDzHzO30gPU/c7JEDIHVXVJN/HhWkK7EtqCq6QrG60boN8v1pqm5q2KnrM2ZUH8sGhX7nGuzWbxxp8yr/lP4WwDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S1LqRI7M; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJrHN6cDkz6Cnk8s;
	Tue, 16 Apr 2024 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1713287645; x=1715879646; bh=0gyQs
	VhGa672wbZSWf6EJ1bspdIdFZwvR0VKtj2LVjM=; b=S1LqRI7McpMTyocVZqQ+7
	8gKSY9kiUvsPmjjEGgDRZ0u7TKOhP9LSfk1EDA5Eg8iRkdqjhE4I+jomzK942N8e
	FteULv73aa1dtej7vIInMF5/2dRQGSNIlkEsRyTCqPrUgfKNf0+zODnwIQ6b4eUB
	vh2amA2UVrxWv31/Cj6K3TU4xu3CRUwVH7gU3hjGjYCE4Tujj71R0hCPap49wJCk
	MTCE9JjW9I4wCYA81MQpcDc74CUBAAcPgAlnZ1ykdpfVnAKz3F3VYMN7Jd0b+34u
	3dc0FMPQsmkFnaoLw4BAP/w7zNX4iQ8ZPk8T1Sf5axPad/aLuzheYEVXTYh2nTBM
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eQ8uOF3uhixU; Tue, 16 Apr 2024 17:14:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJrHJ4VpJz6Cnk8m;
	Tue, 16 Apr 2024 17:14:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>,
	zhanghui <zhanghui31@xiaomi.com>,
	Po-Wen Kao <powen.kao@mediatek.com>,
	Keoseong Park <keosung.park@samsung.com>
Subject: [PATCH v2 1/4] scsi: ufs: Declare ufshcd_mcq_poll_cqe_lock() once
Date: Tue, 16 Apr 2024 10:13:28 -0700
Message-ID: <20240416171357.1062583-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240416171357.1062583-1-bvanassche@acm.org>
References: <20240416171357.1062583-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ufshcd_mcq_poll_cqe_lock() is declared in include/ufs/ufshcd.h and also i=
n
drivers/ufs/core/ufshcd-priv.h. Remove the declaration from the latter fi=
le.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd-priv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-pri=
v.h
index a1add22205db..fb4457a84d11 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -72,8 +72,6 @@ u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
-unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
-				       struct ufs_hw_queue *hwq);
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 				    struct ufs_hw_queue *hwq);
 bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);

