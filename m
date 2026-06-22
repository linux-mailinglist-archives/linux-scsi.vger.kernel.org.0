Return-Path: <linux-scsi+bounces-25103-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gj0oLr3qOGo4kAcAu9opvQ
	(envelope-from <linux-scsi+bounces-25103-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 09:56:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B76AD725
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 09:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leap-io-kernel.com header.s=default header.b=TrNCwoUe;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25103-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25103-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=leap-io-kernel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 941C53006036
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67163382398;
	Mon, 22 Jun 2026 07:56:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97328504D
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jun 2026 07:56:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114998; cv=none; b=Jtsm7ON6wkNDaQCJQtcGF8gsuJGDDtNNSq98OPfC1SERn+LyXh0J1y23OaiKpE3x2sw2J98sXEEwHQMyJt8Sr/0Ibd+WhFfwPGUpX/AzScHDLCzpGubq9wQJbcOVaMKreCIeKzEYEs/Uzx2an5OHx5o3N4cQsUsndvRk9eRLPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114998; c=relaxed/simple;
	bh=LMp9+LV5kgFE5HEIh2L9W9npgmYUZ0JoLJjZ0okf1TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pv5oo3LLyjol5HQ69kQh0FhNs+Y+mHggwpqI7t88cSG55tEt8NgASLW+2UBcnw7wajk1Gjj+IU4pUoiwLni+O4gW5o+ZRlDmt8lHwy+zSRzGLIOpcg+6x12j9qu+W3qccXMz43wYaL9xSMfMSkbQL+btXK33Iqiy4qZQwWD8xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com; spf=pass smtp.mailfrom=leap-io-kernel.com; dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b=TrNCwoUe; arc=none smtp.client-ip=220.197.31.102
Received: from localhost.localdomain (unknown [222.130.22.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 433ea5bd2;
	Mon, 22 Jun 2026 15:51:15 +0800 (GMT+08:00)
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
Subject: [PATCH v4 0/2] scsi: Add LeapRAID driver support
Date: Mon, 22 Jun 2026 15:51:13 +0800
Message-Id: <cover.1782110784.git.doubled@leap-io-kernel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eee4fec8c03aekunm2c2703fa82288c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGR5OVkJPGR1OGUgaGh8dHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkhLVUlJVUlPSVlXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=TrNCwoUee2jk1shGAiTjE2I6+xcvSYRSUSlQbUPJqaERerIoy8su8Af5HF+ab1OPpLZ+/Vhq8dFpc7ZPIt64tpicolp9RxAW/scpkTPqhFylbOsCVKYpfPe04DLCNBzXkH4T9Ca0FEH7R5QVzw7oI/dc1X1Pa50VLFdXW9BJscmYQcnmzBQyacijgNvf7I87IsJXkAW9baaqiLlIhKEWLmn0RogI7pqw9ac03m2BouyyOfbD9XwZO8eSeXGRRL6uKaF48zzKkn+bH54PBxeg62FR2HMeRyFbRA5b2kiDE2rDS9S7Nl5MT8xEO0UbcBn0hib+kRXutxQuX0/uVKD/SA==; c=relaxed/relaxed; s=default; d=leap-io-kernel.com; v=1;
	bh=L2sIV1RXXuVRqJJLVhIs2jf8QfgMw7CvWnL3a0Hh5TM=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[leap-io-kernel.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[leap-io-kernel.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25103-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,leap-io-kernel.com:dkim,leap-io-kernel.com:mid,leap-io-kernel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC5B76AD725

This series adds the LeapRAID driver and its documentation.

Changes in v4:
 - Fix the documented multipath module parameter name to enable_mp
 - Polish documentation wording and naming consistency

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


