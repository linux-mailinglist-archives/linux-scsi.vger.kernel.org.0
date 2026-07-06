Return-Path: <linux-scsi+bounces-25620-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AwliJYhjS2pgQgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25620-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:12:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB51770DF6F
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:12:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rq2mKXsd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25620-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25620-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A1713213BA6
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B44C9574;
	Mon,  6 Jul 2026 06:56:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85019481648;
	Mon,  6 Jul 2026 06:56:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320988; cv=none; b=FiWSrQL89Chin/kXyMl4l/2/hsU5t2k3Pw3W7gxruSlG0mI7BodsM+2TI0w+t72UvfYpUjfTWyyQyFamQ7uky6gtO5uAWIYcOfehx9y78/uwD1rRnS4Tlb4R/YelJS22u1tWWRiIxIZHMnERGcFux8qNX1bfhozDr45L5JYHHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320988; c=relaxed/simple;
	bh=r6PABZt7ILwhpo+ZIZ26JMI2EtSIjYao7FKvKAliuqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QCKseZDsliVLkwKZ/mcWZXDXceRg6ffDVlnZGuUX60+va6wjswhKDAuFixemcav79r6VRQPqiAx1DP25vNvEk/Z7G/edyRGY5PhgrsKL8MeRJoE4GPPuNmywQNpoGrQgpzdRYC1WU0uZAetD9VWsFg6kN0y43WfLT6BS2dy29d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq2mKXsd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A031F000E9;
	Mon,  6 Jul 2026 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320981;
	bh=zTdCcxi6QeqNZVUmL/kMNNdgXQn+3026HQntWeXcHwA=;
	h=From:To:Subject:Date;
	b=Rq2mKXsdBYAt2c7MsuhLTKYv+LHnD1kJCgPEZwGmZyKJw0e2WUsLmdx4+I5LcBr9d
	 o6ReiWycs6F5ayv7bYkO+mFzDWQXcXbLRh5PnvhuDkZcRcDrwLsqmTjVicSf6nU8M4
	 yaWRsvqQRcrE573YyFe8gtvqE4lp40VvihSI1FFyTeoV7rBz3xJaKVo1OqMKBTioEF
	 diTUWHg7BSCm9AEArJWutw7DXxPDbs66iPgkarJ2+APrS7vRvI8IikCKLq6+o6L8/a
	 LN1BPlHCHdLvUJUCweE7fOctkreJhZIdsZmJ0X6aA04C2XZKB/qS3ItMCNM1jfvPJ/
	 mlWEUPiCZX4Fw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 0/9] ATA support for storage element management commands
Date: Mon,  6 Jul 2026 15:56:01 +0900
Message-ID: <20260706065610.3559692-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-25620-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB51770DF6F

This patch series adds support to libata for translating all storage
element management commands:
 - GET PHYSICAL ELEMENT STATUS
 - REMOVE ELEMENT AND TRUNCATE
 - RESTORE ELEMENTS AND REBUILD
 - REMOVE ELEMENT AND MODIFY ZONES

The first 2 patches add definitions to scsi_proto.h related to the
depopulation feature. The remaining patches modify libata to detect
support for this feature and add command translation support.

Martin,

I have more patches for sd and scsi_debug (depop emulation) that depend on
patch 1 & 2. So I am not sure how we should handle this series. Maybe we
should create a "depop" topic branch in the scsi or libata tree ? I am
open to suggestions.

Damien Le Moal (9):
  scsi: scsi_debug: move ASC and ASCQ definitions to scsi_proto.h
  scsi: define depopulation capabilities related service actions
  ata: libata: improve the definition of device flags
  ata: libata-scsi: improve ata_get_xlat_func
  ata: libata-core: detect support for depopulation capabilities
  ata: libata-scsi: add support for the GET PHYSICAL ELEMENT STATUS
    command
  ata: libata-scsi: add support for the REMOVE ELEMENT AND TRUNCATE
    command
  ata: libata-scsi: add support for the RESTORE ELEMENTS AND REBUILD
    command
  ata: libata-scsi: add support for the REMOVE ELEMENT AND MODIFY ZONES
    command

 drivers/ata/libata-core.c |  73 +++++++++-
 drivers/ata/libata-scsi.c | 300 +++++++++++++++++++++++++++++++++++++-
 drivers/scsi/scsi_debug.c |  46 ------
 include/linux/ata.h       |   4 +
 include/linux/libata.h    |  90 +++++++-----
 include/scsi/scsi_proto.h |  74 ++++++++++
 6 files changed, 493 insertions(+), 94 deletions(-)

-- 
2.54.0


