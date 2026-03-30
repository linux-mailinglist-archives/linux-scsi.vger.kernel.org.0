Return-Path: <linux-scsi+bounces-22607-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBLHEYHCymmL/wUAu9opvQ
	(envelope-from <linux-scsi+bounces-22607-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:35:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919E35FC90
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388273010DA8
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A63890FD;
	Mon, 30 Mar 2026 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZwjMwCDp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F11381B16
	for <linux-scsi@vger.kernel.org>; Mon, 30 Mar 2026 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895605; cv=none; b=ITRqsgC2LSTa84g+Gpijxsni/Bhj1NeVa5d6QwNWgNCbOSBLmsYPBAdwsqzhPRq6o0LMHCMBMXw9JJilw5nfBDfPD9bkLoLUxgQ4gg0ZwRe/8ctR1KY4gUl3uyXEmG9nb+XiIM7ZC+thjVitS7rg1AQTgfb80fsxC+RHoJNdazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895605; c=relaxed/simple;
	bh=3itQdQZzbfr5c40TgaDcsKuKFCBp5VLOwLuEq5Ky8KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryyfncQVqp8+mBy0ZX6aUjpHy5VAngynfMTb7rigju3CBm0SgYLJEVuiITKMXmXXgORhQo4T7NHscp0MjOwde7OnUnWuA5sB65I45ZRgeejiuTM3DKYKZ3WTAjErx82FoXWAKC6uWGJIHP1BkVq2ZUOnvQimE4WP0hURoTzm38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZwjMwCDp; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fl0Hl311ZzlfpMB;
	Mon, 30 Mar 2026 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774895601; x=1777487602; bh=iD0aPnieFq2qIhXsYnPvX9ObfWZqc87DTeF
	L+C8czwI=; b=ZwjMwCDpo4WtRPPos6xK0qUCrP2LWFeGe0gfTF8cJ5tlPk/70ge
	btX37LhCkBWSr04hHi7h57q+4brkrJwYcZHP1gaO9Y+VwoZ2mLtNBTaEqXtzmoqT
	nl8bUMy0xcCeHxbEshp65ShuzUND6MCw2XAzT3Ckgiyq6XfshPl89sfkW4z8APmf
	/FVY6z2gs6AuvHVMYZM/4VptGi66wFVsqQxHHferGmgMBimRt1spfCppj/eK8m1y
	Iuom9YHCDULZODdcHcBVF25pI2MhpiSPLbvO2vpivmibcYsG8MxmMpn3FCtUU5w0
	EiZHIZfcv/oBEiwWzsP8TkRDZLONqS398rg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7vpKrw8H26vd; Mon, 30 Mar 2026 18:33:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fl0Hh6LQPzlgtcp;
	Mon, 30 Mar 2026 18:33:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Reduce interrupt latency
Date: Mon, 30 Mar 2026 11:33:02 -0700
Message-ID: <20260330183311.1941942-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22607-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2919E35FC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,

On Android systems it is important to keep the time spent in interrupts s=
hort.
This keeps the user interface responsive and prevents audio stuttering. H=
ence
this patch series to reduce the time spent in the UFS interrupt handler. =
Please
consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  ufs: core: Fix ufshcd_mcq_force_compl_one()
  ufs: core: Introduce ufshcd_mcq_poll_cqe_lock_n()
  ufs: qcom: Reduce interrupt latency

 drivers/ufs/core/ufs-mcq.c     | 32 +++++++++++---------------------
 drivers/ufs/core/ufshcd-priv.h |  2 --
 drivers/ufs/core/ufshcd.c      |  2 +-
 drivers/ufs/host/ufs-qcom.c    | 33 +++++++++++++++++++++++++++++----
 include/ufs/ufshcd.h           |  3 +++
 5 files changed, 44 insertions(+), 28 deletions(-)


