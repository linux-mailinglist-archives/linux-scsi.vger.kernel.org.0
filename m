Return-Path: <linux-scsi+bounces-23848-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO6UO5uHB2r57AIAu9opvQ
	(envelope-from <linux-scsi+bounces-23848-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 22:52:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F321557912
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 22:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79F5D300B46B
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3F390C89;
	Fri, 15 May 2026 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ii3CBIw0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BA3806BE
	for <linux-scsi@vger.kernel.org>; Fri, 15 May 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878358; cv=none; b=dBqfukVhkpchKSgDApsXT0IArxFQwX19sJZIFvjTNxjmOT8ndYMuEm/dledYRtguGe5CoUnGkzdqL5nAo2lvAoEPuOWEjopnKRBVibd0VaYlX061neILI61jwzekMnruJFKtqhqpfG0ziVoQadHrxGT8MWQIp+JB/bLbPGhrppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878358; c=relaxed/simple;
	bh=2W0ysWt/9TPQqoJidGIMTmulwC5xumJ44zcaYAN4gCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKQn9kN+UeE+aQo5yt1rRURzjksmq+h7PoLZ8iL9d45Di9NMui61F7jBcBnB9+gH/qcdxuJRIvR/PYSV9lNxlGiYWLw4NuNuDX+dA7zYRj577uR7b1hJXQGQ8+2hKz6rf4guIa3ZIjXuBJaizZE6hZcHsHdKztHxmpgJG+A6bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ii3CBIw0; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gHKC858YPzlgwNH;
	Fri, 15 May 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1778878353; x=1781470354; bh=mCbWrSsQ/wTRL7c8CJuGu2nSZcT2hp2/bll
	MozmEfm4=; b=ii3CBIw00f4gP3NmUV23/OOPWLKW9To4Nxwb+61o/OET6HTlBli
	OxY7prd2t7/uJx+P5ra3o6wLZ/zxUbmoVoyGOnRmBNNKWM5qdzjAUiXVLrYQuv0i
	xZ9AAGvyE1Wqqj3paa6tDLNa1QNk6Hbss4WVY8yscHI3Kwp1FlcNzNGNsMT5XfmQ
	sdmK8Ym5IEulOm5vRYz8nsIIROgCmQdStaNNZp2Np6HYH2bgZqnCZ/SJ+2yagvOV
	IRrgwaJRy1e/G7Xh6E5+Mx0vDZ7EKkNHoteDTSeesx2E4jZIgpYtEO0BPw0eHb4e
	jluZRY2tRkHQahgFL3Hsi6/jZTgmTkUQyJA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TZiThIjk-lDB; Fri, 15 May 2026 20:52:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gHKC42QCHzlgwND;
	Fri, 15 May 2026 20:52:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Brian Bunker <brian@purestorage.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Rework the struct scsi_device inquiry information
Date: Fri, 15 May 2026 13:52:18 -0700
Message-ID: <20260515205222.1754621-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F321557912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23848-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action

Hi Martin,

The vendor, model and rev members in struct scsi_device are fixed-length
strings that are not NUL-terminated. This patch converts these members in=
to
NUL-terminated character arrays. This makes it less error-prone to deal w=
ith
these structure members. The patches in this series have been implemented=
 such
that the number of lines changed and the risk for regressions is minimize=
d.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Added symbolic constants for the offsets in patch 1/3.
 - Added a new patch 2/3.
 - Converted one strscpy() call into a memcpy() call in patch 3/3 because=
 the
   strscpy() call triggers a KASAN read-out-of-bounds complaint.

Bart Van Assche (3):
  scsi: core, target: Add INQUIRY-related constants into
    <scsi/scsi_common.h>
  scsi: core: Use the INQUIRY-related constants
  scsi: core: Convert INQUIRY information

 drivers/hwmon/drivetemp.c         |  5 +----
 drivers/scsi/scsi_scan.c          | 33 ++++++++++++++++++++-----------
 include/scsi/scsi_common.h        |  8 ++++++++
 include/scsi/scsi_device.h        |  7 ++++---
 include/target/target_core_base.h |  5 +----
 5 files changed, 36 insertions(+), 22 deletions(-)


