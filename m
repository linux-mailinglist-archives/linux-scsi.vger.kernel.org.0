Return-Path: <linux-scsi+bounces-26238-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XB5zHOJOV2oJJAEAu9opvQ
	(envelope-from <linux-scsi+bounces-26238-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2026 11:12:02 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6775C494
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2026 11:12:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D2AVips7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26238-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26238-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8AB32494D4
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2026 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311283D6497;
	Wed, 15 Jul 2026 08:58:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF83D8902;
	Wed, 15 Jul 2026 08:58:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105920; cv=none; b=thAMkHYlCXSkINL3ANr26MKcn093pU/pYcL8mtMir99rhe+ZKcZHW0NaxfuC8ptEImVdajiEh9vjkvXAdA7AQ0nPhV+/0ncfPy0stMreHRaWv/HuL+xzyrJ2KvcwuZTx217qTL5WzNZ9L2WVuLoZxK7aYV6FC68u7UWNabyAU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105920; c=relaxed/simple;
	bh=k1p2jnrm7ellBF7Wq2WQsTOdN7VOjfArABSZ3k6aavE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB4r3VobvftqJXLl40XGZTjXYGP/76+KfKfgF8TkfI0xEP5smSQOp79BroD2Xx22B1ASsfJeHTp5Kyi2qlurHZGSplka35Z8xY+M4yzrJ/2gsu72so4s55Tn2BszRz96WAONeWf56S9PzMtpkV+QtM4O+6HWODRdeCysoQ1Rgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2AVips7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D34D1F000E9;
	Wed, 15 Jul 2026 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105916;
	bh=lwzEkkjWNNJy6DFjUqqyHIBbNZHWbg2vlMPqGBlLa+w=;
	h=From:To:Cc:Subject:Date;
	b=D2AVips7vEX/AhAAey0BUmNBTbkbmymelkDr93xZw8ZHhxn9CDyBmvElW/SPqvk1a
	 uC+IhI5LQeObBKCt9/9LP1AFcuI/1ryjfHuH/jkvVmzoJf1yTnTiw0MCs20bA53bzI
	 w+iQBJCD6rpG9CrdgwLdEegcj4MhZocbL8dPdNsSYVh7hvi1o2z3GiBj6XOVa2Q1+b
	 B6Oem6oZJQpMB5wQqKLzWDFtxyqQhGUVzWEu0eBX5WNGBNCyGifw3l7v/kzgyN9dVQ
	 hBGRJEuQndlxQZKIW0iqloCJO2UabdzWmYve+ykaUl3xYliBw2EVIP5Kw/6kMjRKcx
	 nJe0JhXxmk4Pg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 0/2] fixup handling of timeouts with deferred QCs
Date: Wed, 15 Jul 2026 17:58:22 +0900
Message-ID: <20260715085824.854200-1-dlemoal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-26238-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BED6775C494

This patch series fixes libata and libsas to correctly handles deferred
queued commands in case of a timeout error, to avoid excessive delays in
waking up the scsi EH task.

Igor,

My apologies for the churn, but please retest !
Also, I added your Signed-off-by on patch 2 since half of it is yours.

Martin,

Once reviewed, I or you can take both patches ?

Changes from v3:
 - Reimplement ata_scsi_requeue_deferred_qc() in patch 1 as
   ata_eh_retry_deferred_qc() so that all requeue pathes use the same
   function.

Changes from v2:
 - Modified patch 1 to avoid the problem reported by Sashiko that requeued
   deferred QCs may be re-ssued immediately by the block layer, thus
   potentially keeping the device busy. The modification now relies on
   libata-EH to perform the requeue instead of immediately doing it from
   the eh_timed_out operation.
 - Modified patch 2 to use the new helper function defined in patch 1.

Changes from v1:
 - Modified patch 1 to ignore timed out deferred QCs in
   ata_scsi_requeue_deferred_qc() to let ata_scsi_cmd_error_handler()
   correctly handle this case.

Damien Le Moal (2):
  ata: libata-scsi: terminate deferred commands on time out
  scsi: libsas: terminate deferred commands on time out

 drivers/ata/libata-eh.c             | 38 ++++++++++++++++----
 drivers/ata/libata-scsi.c           | 56 +++++++++++++++++------------
 drivers/ata/libata.h                |  2 +-
 drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++
 include/linux/libata.h              |  3 ++
 include/scsi/libsas.h               |  2 ++
 6 files changed, 88 insertions(+), 30 deletions(-)

-- 
2.55.0


