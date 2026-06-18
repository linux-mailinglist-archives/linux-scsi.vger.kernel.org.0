Return-Path: <linux-scsi+bounces-25062-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DQ6lERCzM2rSFAYAu9opvQ
	(envelope-from <linux-scsi+bounces-25062-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 10:57:52 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B125C69EA64
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 10:57:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leap-io-kernel.com header.s=default header.b=kVLExkhs;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25062-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25062-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=leap-io-kernel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EFC1307AFCF
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830C3B19AA;
	Thu, 18 Jun 2026 08:52:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F54343881
	for <linux-scsi@vger.kernel.org>; Thu, 18 Jun 2026 08:52:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772764; cv=none; b=fHcpK8fb815N1OGm8goMui1HqHlNx0sKnkODRIomgG3Txl1mPuAe6BMIy/kWGJugLNgqVAdSw7jV99GhwwbpMdV5AVgcYHZ9gglny5PyIqCmR5HhgCSpQ/XPN3CCwE7oSfcGDzyV0Rspl6gRnR2xyjnnIg0Sds9GKT3lJeXdO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772764; c=relaxed/simple;
	bh=pssY519DKTBGVNaa97dXXik4Vmc2GTVAy35jwA6R+qM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wd8Qw3Est3kMRteiVrUvemPC+N9yEJu0IvyzeKTsLfqiWrpFzCOZeJ5ZsfRG2aBU80yUnMayryQWhvff5EBeRpLaouZ+8TBnU86weNYzzuLr3V6pn/urTIgUMtcptu5yyztHdaBUZSaiGTAQA4g+vwwjHPo3uM+PIe+QwDauFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com; spf=pass smtp.mailfrom=leap-io-kernel.com; dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b=kVLExkhs; arc=none smtp.client-ip=45.254.49.208
Received: from localhost.localdomain (unknown [222.130.22.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42e501431;
	Thu, 18 Jun 2026 16:37:13 +0800 (GMT+08:00)
From: Dongdong Hao <doubled@leap-io-kernel.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: dlemoal@kernel.org,
	doubled@leap-io-kernel.com,
	yjzhang@leap-io-kernel.com,
	kezijie@leap-io-kernel.com,
	qtian@leap-io-kernel.com,
	jzzhang@leap-io-kernel.com,
	baikefan@leap-io-kernel.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v3 0/2] scsi: Add LeapRAID driver support
Date: Thu, 18 Jun 2026 16:37:11 +0800
Message-Id: <cover.1781767278.git.doubled@leap-io-kernel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed9e091c603aekunmd3a9a65045f47e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEkZVk5NHh0fGBlMTUhMQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkhLVUlJVUlPSVlXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=kVLExkhsxiqA9T7xihxa4waUXE6K1ZPlgihQtsTZMyTTnysFGn03uneeu2spfHbKSPa371ZHMyOKUWS/yttwp2bd9V2I4Hhm0Ppj+Fq/5RO1+5BKTC+I2HGOG1Yu40faoQJ59zNSOz4+sne6xsp+L1XjPEf6XbEicdUrxblh/DVKmTIaJwobHjlxGWu1jkysTVbWWXvsHV1OdKTl64Ymx2NsAsahW46NenmFwxNcDbhUsFXi81gfBrDQV4dS/AOCkZQojukHcTV6TKL2OThCX1sfm47svANWRqpO9/qkI03XIt5JMsezIvXKmOKmk227dUEF39jJq5VyaZnN4oXtuQ==; c=relaxed/relaxed; s=default; d=leap-io-kernel.com; v=1;
	bh=lPeFLCGWpgs78ThG2T60KCzueYjr47trXOmmAGQMAYg=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[leap-io-kernel.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[leap-io-kernel.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25062-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:dlemoal@kernel.org,m:doubled@leap-io-kernel.com,m:yjzhang@leap-io-kernel.com,m:kezijie@leap-io-kernel.com,m:qtian@leap-io-kernel.com,m:jzzhang@leap-io-kernel.com,m:baikefan@leap-io-kernel.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[doubled@leap-io-kernel.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doubled@leap-io-kernel.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[leap-io-kernel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leap-io-kernel.com:dkim,leap-io-kernel.com:mid,leap-io-kernel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B125C69EA64

This series adds the LeapRAID driver and its documentation.

Changes in v3:
 - Simplify bool return, drop redundant assignment and noisy logs
 - Fix byte alignment issues for fw_event mask and pd_hdls on ARM64
 - Added Reviewed-by tags from Damien for both patches.

Dongdong Hao (2):
  scsi: leapraid: Add new SCSI driver
  scsi: leapraid: Add driver documentation

 Documentation/scsi/index.rst               |    1 +
 Documentation/scsi/leapraid.rst            |  139 +
 MAINTAINERS                                |    7 +
 drivers/scsi/Kconfig                       |    1 +
 drivers/scsi/Makefile                      |    1 +
 drivers/scsi/leapraid/Kconfig              |   14 +
 drivers/scsi/leapraid/Makefile             |   10 +
 drivers/scsi/leapraid/leapraid.h           | 2050 +++++
 drivers/scsi/leapraid/leapraid_app.c       |  699 ++
 drivers/scsi/leapraid/leapraid_func.c      | 8980 ++++++++++++++++++++
 drivers/scsi/leapraid/leapraid_func.h      | 1558 ++++
 drivers/scsi/leapraid/leapraid_os.c        | 2516 ++++++
 drivers/scsi/leapraid/leapraid_transport.c | 1387 +++
 13 files changed, 17363 insertions(+)
 create mode 100644 Documentation/scsi/leapraid.rst
 create mode 100644 drivers/scsi/leapraid/Kconfig
 create mode 100644 drivers/scsi/leapraid/Makefile
 create mode 100644 drivers/scsi/leapraid/leapraid.h
 create mode 100644 drivers/scsi/leapraid/leapraid_app.c
 create mode 100644 drivers/scsi/leapraid/leapraid_func.c
 create mode 100644 drivers/scsi/leapraid/leapraid_func.h
 create mode 100644 drivers/scsi/leapraid/leapraid_os.c
 create mode 100644 drivers/scsi/leapraid/leapraid_transport.c

-- 
2.25.1


