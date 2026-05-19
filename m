Return-Path: <linux-scsi+bounces-23924-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCuGHAbVDGqJnAUAu9opvQ
	(envelope-from <linux-scsi+bounces-23924-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 23:24:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DC5852A5
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2A4301B72A
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F33E7BA0;
	Tue, 19 May 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xxbvYSwQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5C3C0619
	for <linux-scsi@vger.kernel.org>; Tue, 19 May 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225710; cv=none; b=C++bUefD4RZDOjOa3GIpsR9QmCFHALJVjpuT8JO5aXvtLfyGrjjg9ntu1JnlPY8w/V5ZJbcxBSSAkB8obm/BqQbIcsayWn8gv8PvOTHeqOZWZiE2RSgBHBUgfqGMhn9OtjFlp40QQrQ4fo9RKQ5+e7ucpQohQ4kTA+isdg7YzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225710; c=relaxed/simple;
	bh=oEj6laNQYXuu533mgAvZC1eM8PjMqZuoF/eMj2LgSTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZaEyASUA2+fUgQnvoAtkEeK8EMgEK3QzeHBjCMb8A/Zeu3BVBsUlJBO8XrreBLveZzSETwOMbO4iGH0hIDDoG+9dCPfAw0RQUmhU8AuIeQpAJ2v0wokNcGQlrZ5Zp2Q4tCC5OZCjIpaCpTdjtL2ODOm36Hk0ocrOLY9H388auuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xxbvYSwQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gKng02K4Mzlgtd1;
	Tue, 19 May 2026 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1779225706; x=1781817707; bh=6CTYaUX69x5nuE3YEUz79WI2LKQ5jIOm48g
	0pNpo9MU=; b=xxbvYSwQc+ZGFk52kBnOssHy0o8FJXtyo19vAr/Sq1nzg654iyJ
	qAGw9W5bTlDTRH0hTFXJRUJEGaIcTyUIBx+i4lhy2fh3lIXdJx4vyVXUnbV5EXnD
	4dYxtsuATpbCBrEy1gOZkKC254FrO/+TPnhu/ABVPOQMmYosYENUKM5hz/Y73Ud1
	Dozu30AVdchYhaHL7+hD5pvTC3Dix0l+6UGG2OufwVEpp7AtsTNBRaTfK2sJ7dJ8
	PMblh/yNcCDqcQ954Jy+OLV9L654z/gJ5UuU3/XxHHfS6FCdINrwop56ENP+yT9i
	WqHGBRDVA7u7uy9igMzsyXiEp+j/3CTQoZg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xqz_zemBRL5o; Tue, 19 May 2026 21:21:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gKnfx2nw6zlgtd3;
	Tue, 19 May 2026 21:21:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] ufs: core: Optimize the UIC command implementation
Date: Tue, 19 May 2026 14:21:26 -0700
Message-ID: <20260519212135.3130556-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
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
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23924-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 017DC5852A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,

This patch series reduces the number of readl() calls while processing UI=
C
commands. Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Reduced the number of changes in patch 3/3.

Bart Van Assche (3):
  ufs: core: Inline two functions related to UIC commands
  ufs: core: Complain if UIC argument 2 is invalid
  ufs: core: Optimize ufshcd_add_uic_command_trace()

 drivers/ufs/core/ufshcd.c | 58 ++++++++++++---------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)


