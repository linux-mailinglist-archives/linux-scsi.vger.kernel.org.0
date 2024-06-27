Return-Path: <linux-scsi+bounces-6362-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB791B000
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2024 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3507B20DE6
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E4199EAB;
	Thu, 27 Jun 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="w63NLn6S"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA562A02
	for <linux-scsi@vger.kernel.org>; Thu, 27 Jun 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518412; cv=none; b=kgXDHZ90xNF8n3+ClaKNHiPIdLw2G8tqrFqc/RzFHDjR79PB9ZjQlChWHVw9jhRKdyPQCdHeETrE7Cj5id2v4eL1vVWxBxfkBLtfjhI1/MdfzmDpmBbbhyL25kQaMJ4HP3CmUSxnGP88lZQNKMKr79jGcB1uqw2eXKV2mptaPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518412; c=relaxed/simple;
	bh=5cGJsHSeh+YBbfyjM71UDpTY5fxQ32Z14bkbXCL3yVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2uQxPQZScJuFuPJtJVKcUcypkynriVZjSB01eRMjS4BZeGg+AY9iAp74KCmwog5/i82+Z/BiZk3Y7bxquj/isp1NcVv0gT9dUc2deuN3QHJ494AlSkIKIjdqgwRJkCGayxOOKaFpe0zy0UBW/l5zy+uhW+2H6FWV6oLyI4uzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=w63NLn6S; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W98Yk0dNqzlgMVW;
	Thu, 27 Jun 2024 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1719518408; x=1722110409; bh=4Ih/A/lC8l1UTzZ4KnY21xtBiMGIautpZW6
	uY7UTkZ4=; b=w63NLn6SudXFp3yvs7JzBRnDPtGYRaloa9YTxe2LjmLL4PK3uzR
	WfbrZN9lGrvyIgPHgmRJgpb3E5Mo7g3x3bo53eLcNm0VSFMJm4fm3RXJO9d5hV0A
	n+k8Oxr3P4yimIw0syvi3TusTDFcB/AFEqGnTtU7uipwfZsKAt+oNhUjbpZxLoPC
	4poXwVXIQ7c9DDtIYAiZd/suSr49nm/mxNbIkhyoJtE8EqgWmNok2wsLTHE+ApL5
	guDYsyGzNGQNPM0aBLjALy6tYltSij+3NIPO/dx0aY4PO97AeGAYJh1CcBcSJdzx
	GryI+rAQQDhIupDXZZQLWHRTmmZNM6AVRVA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QJJN2g-loHQG; Thu, 27 Jun 2024 20:00:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W98Yg2yNGzll9br;
	Thu, 27 Jun 2024 20:00:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/7] UFS patches for kernel 6.11
Date: Thu, 27 Jun 2024 12:58:26 -0700
Message-ID: <20240627195918.2709502-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Please consider this series of UFS driver patches for the next merge wind=
ow.

Thank you,

Bart.

Changes compared to v1:
 - Based upon reviewer feedback, a new patch that renames the
   MASK_TRANSFER_REQUESTS_SLOTS constant has been added.
 - Because there is no agreement about these patches, the following three
   patches have been left out: "Make ufshcd_poll() complain about unsuppo=
rted
   arguments", "Make the polling code report which command has been compl=
eted"
   and also "Check for completion from the timeout handler".

Bart Van Assche (7):
  scsi: ufs: Declare ufshcd_mcq_poll_cqe_lock() once
  scsi: ufs: Initialize struct uic_command once
  scsi: ufs: Remove two constants
  scsi: ufs: Rename the MASK_TRANSFER_REQUESTS_SLOTS constant
  scsi: ufs: Initialize hba->reserved_slot earlier
  scsi: ufs: Inline ufshcd_mcq_vops_get_hba_mac()
  scsi: ufs: Make .get_hba_mac() optional

 drivers/ufs/core/ufs-mcq.c     | 19 ++++++---
 drivers/ufs/core/ufshcd-priv.h | 10 -----
 drivers/ufs/core/ufshcd.c      | 73 ++++++++++++++++------------------
 include/ufs/ufshcd.h           |  8 ++--
 include/ufs/ufshci.h           |  3 +-
 5 files changed, 55 insertions(+), 58 deletions(-)

