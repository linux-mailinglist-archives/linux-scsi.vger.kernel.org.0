Return-Path: <linux-scsi+bounces-25923-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7v4iGgZgT2rKfQIAu9opvQ
	(envelope-from <linux-scsi+bounces-25923-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 10:47:02 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015F72E72D
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 10:47:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VsGSIjYp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25923-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25923-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A1C302C5F0
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9F3F65FC;
	Thu,  9 Jul 2026 08:39:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A83F44F9;
	Thu,  9 Jul 2026 08:39:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586388; cv=none; b=Ny0a/OesfVc/YT5PiDLRO7CJRqtADlvEJd8ypR2xTLN9jTebZhYV8hXQa0Ca04ZkBBsmLoLSmv7EofTAhB1yfHTmxDFHk09qcUlAk4Lx9RTzU1gBgCGG7zqkhTeKKWzbT8zV5/AQIf0aEowGxE1rO0avKEfdELtJT5mz9plk4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586388; c=relaxed/simple;
	bh=od5POB1oq7Vb9QM9xXwPAFl+S0K1hqG6OU0GA6YOpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qldgmcZljOmwpBusoI6tC0bcyEzMGMLnNmHm7bCXtxawOiAhp5LRUJvkEGo/5ViYaSz2+wfnVye1z4lA1ag71EaveBnBcFGDynsJvOAosJHDGeaTjKbjLW7ClwEob5UMKzysB9bsxwStx68DJwIt8LyPvI2b1k2wQQ87lXL2r6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsGSIjYp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6B1F000E9;
	Thu,  9 Jul 2026 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586386;
	bh=wvXmSseieV6A7ZJeML9swtXB0QPe9U12rLYvxr9FdbQ=;
	h=From:To:Cc:Subject:Date;
	b=VsGSIjYpFXqHkscjQAxqX2DDyGJVFxcYP8qdx8No3vnIXsvTax8Ki8tzoAFDNBxJl
	 Gz3ZRnIwBLqh6bdmfqtGRyz2s7v9DTvEGmfwcNlALUIr2uSXnFYAuZJpfIBr2BS3qu
	 2Tspn5rhmgFhV64lqPkIQJzH/gXkP0Wj2hMAR8ZEUtfZNZohLCKZIb0smeiJ5elfv2
	 VzIQzKk78S11EWMD4GQlMIHecqU6I8yXEzyojcsk0q8ODaVhOg6H/yumhf30Ec5eq/
	 VXEh82VNf0o2EiAuiK4B0Q/tuf4OwFiLmhkQyDW65EkWhKuVrEK09gIqKNtFb6dJQG
	 9l24q8AoimuOQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v1 0/2] fixup handling of timeouts with deferred QCs
Date: Thu,  9 Jul 2026 17:39:32 +0900
Message-ID: <20260709083934.1116862-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25923-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2015F72E72D

This patch series fixes libata and libsas to correctly handles deferred
queued commands in case of a timeout error, to avoid excessive delays in
waking up the scsi EH task.

Igor,

Please retest !

Martin,

Once reviewed, I or you can take both patches ?

Damien Le Moal (2):
  ata: libata-scsi: terminate deferred commands on time out
  scsi: libsas: terminate deferred commands on time out

 drivers/ata/libata-eh.c             |  2 +-
 drivers/ata/libata-scsi.c           | 54 +++++++++++++++++++++++++----
 drivers/ata/libata.h                |  3 +-
 drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++
 include/linux/libata.h              |  4 +++
 include/scsi/libsas.h               |  2 ++
 6 files changed, 73 insertions(+), 9 deletions(-)

-- 
2.55.0


