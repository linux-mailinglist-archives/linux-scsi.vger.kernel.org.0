Return-Path: <linux-scsi+bounces-25937-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e4/tK6k3UGrJvAIAu9opvQ
	(envelope-from <linux-scsi+bounces-25937-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 02:07:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3A7364E4
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 02:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kAcNaq4H;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25937-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25937-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1428D302E7AF
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848C11CA9;
	Fri, 10 Jul 2026 00:06:59 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB12E573;
	Fri, 10 Jul 2026 00:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642019; cv=none; b=YV19KzgTf2Eq5KjWr0Bx8Q+M3WBr5N91YjPCij+vf43ypoL+4psaZjrac26Ogy+koHBQj3GF23nS6JsXDrdQ26CBE4yq1KrwMuAmJwNNbjIxxJXEll8Y5ocBv7ojXT2Oqh3X8H5CH3TNcW3WvOct5UUMhZSC0Wr6JJhGTDSgJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642019; c=relaxed/simple;
	bh=lTwaLinAHSqeLb259F8j1UrmYjmdHoA3SqD0uOsJr44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGNj1WZz/wKrX+ZuhM+ONvk/SgB9RWh/CnzmCQUURMQ1y7NdQjmxA+AeIX1ZqEETNjWL97m9updik1NY0qngNADCV3Taft/e+jwp294Upf+NoQsEEGaoaq5CT1b0H1kOHGgeMhaKOdb0MZjrRPrtRgFYyMqk9DO9zzMD+rE8MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAcNaq4H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C751F00A3D;
	Fri, 10 Jul 2026 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783642018;
	bh=PrdV6GFdrZIUh+K4nr3JOjWt600LeloBZo5gNCn6/iI=;
	h=From:To:Cc:Subject:Date;
	b=kAcNaq4HZjjDiiLhBCM7hXVOINn2XPy+3LRwh5XaO+is90Sb7GkLbTB7Jx7K76jYE
	 yJG9nZR4NnX09OXbmOJWSwMb/B3jSnle9lbA4uKXoS0wbNi5B6n/Ox4WUYaYbuRr9Z
	 QVeD87INauXOnMMXZk9redYw7YykSHBSbi3fcPcwAkRCmOmlYT7RYY3qyjyDhAXGzt
	 sM/+tEs11mI+UYtpM1IYj+9U800dBPd1TMxpxu9IAf+4OLJ3jziUTQuBl9T3ryXFti
	 ldrfLpPP1VS+ryqgckPAk742Dufa7S9sXbaaFbESRs/DDrRDOGagL8HhfPWqydzh7j
	 i7Y+Ikjnnua+g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 0/2] fixup handling of timeouts with deferred QCs
Date: Fri, 10 Jul 2026 09:06:44 +0900
Message-ID: <20260710000646.1202200-1-dlemoal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25937-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: EBD3A7364E4

This patch series fixes libata and libsas to correctly handles deferred
queued commands in case of a timeout error, to avoid excessive delays in
waking up the scsi EH task.

Igor,

My apologies for the churn, but please retest !
Also, I added your Signed-off-by on patch 2 since half of it is yours.

Martin,

Once reviewed, I or you can take both patches ?

Changes from v1:
 - Modified patch 1 to ignore timed out deferred QCs in
   ata_scsi_requeue_deferred_qc() to let ata_scsi_cmd_error_handler()
   correctly handle this case.

Damien Le Moal (2):
  ata: libata-scsi: terminate deferred commands on time out
  scsi: libsas: terminate deferred commands on time out

 drivers/ata/libata-eh.c             |  2 +-
 drivers/ata/libata-scsi.c           | 52 ++++++++++++++++++++++++-----
 drivers/ata/libata.h                |  3 +-
 drivers/scsi/libsas/sas_scsi_host.c | 17 ++++++++++
 include/linux/libata.h              |  4 +++
 include/scsi/libsas.h               |  2 ++
 6 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.55.0


