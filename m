Return-Path: <linux-scsi+bounces-22678-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJt0OPN/zWnqeAYAu9opvQ
	(envelope-from <linux-scsi+bounces-22678-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 22:28:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDC380277
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B1F2301E6F8
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2026 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA530C62D;
	Wed,  1 Apr 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="07aA509c"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683733F58A
	for <linux-scsi@vger.kernel.org>; Wed,  1 Apr 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075121; cv=none; b=h4+R3diDAg8piMqojBl9oPL3UZCdN4vLhTCgduM/9YiNzCYDmtlzJ4tsBVGvhn7FQkpM4YBrOLk1moLw/TXEfhnxBQ6vgGEN0rmu0rkaxeqiZoi6vZjMvM6OmLGWy/btj23jMhJUUlXR0yDKtvenLYgkdlEUoTsV5sQdJYJedAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075121; c=relaxed/simple;
	bh=IHPx4c2ReiByBhD53JMbWRj3RKjU/Nb/FmM6HuxcVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhIReo1kXqTzvMBzlYlwyWC8bcB6Fuh+HNOqdHk9pV/Pgp6a8l7ZjcjQImPobvbU8VeYggiZ4F9aPiVvp9FFMhy3DRy0atKLjs+77Mum3x/esjfc+QbkYLEUk0aBlDQJEvayZU0zt0t0ZGNAQY0D3qUQKFgLjjc3yEMkw+8Qqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=07aA509c; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fmGgz3jHxz1XM6JJ;
	Wed,  1 Apr 2026 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1775075117; x=1777667118; bh=hGtQCgf4Svg3r5Xy+yQlki+7hyvCisD17TN
	F2IRQ9wI=; b=07aA509cVp/+7tDxy3aPV3eoRg+asUCtK5gMbRlOhjX8NOBZ2WN
	WYbIktWJOoWLWv2ve2rhAzCZTOFBSnuuf7I5GiXlPvV4exp9AZyr4FRWDkH2DiFB
	o3x1Ka26X2RSiyw73pgTV2fgB0p6QURUqtYCWkJQSbQeaRgWWjfBSXpxih8Dyk0m
	KIniUAS6kQ9lBqj2jibcChch60t5lJLeeplGVlp+C1CXmxD3lABmuzjWb97JAxx7
	IFQ8BktOiDMqlm3uFbH8JNyyl6iEZSLkko2GI19nzIVBdHfeiylXWy3aEQ1FAz2s
	Lrrb887XohPhDLQp/2i90vZCo63X+mrx6Dw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gchbe2XvIx0s; Wed,  1 Apr 2026 20:25:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fmGgx02vVz1XM31H;
	Wed,  1 Apr 2026 20:25:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Three small UFS driver patches
Date: Wed,  1 Apr 2026 13:24:58 -0700
Message-ID: <20260401202506.1445324-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22678-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 44CDC380277
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,

Please consider this series of three small patches for the next merge win=
dow.

Thanks,

Bart.

Bart Van Assche (3):
  ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
  ufs: core: Remove an include directive from ufshcd-crypto.h
  ufs: core: Make the header files self-contained

 drivers/ufs/core/ufs-debugfs.h         | 3 +++
 drivers/ufs/core/ufs-fault-injection.h | 2 ++
 drivers/ufs/core/ufs-mcq.c             | 8 ++++++++
 drivers/ufs/core/ufshcd-crypto.h       | 1 -
 4 files changed, 13 insertions(+), 1 deletion(-)


