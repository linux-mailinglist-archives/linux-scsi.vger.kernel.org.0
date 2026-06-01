Return-Path: <linux-scsi+bounces-24324-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HbNEWF9HWrEbAkAu9opvQ
	(envelope-from <linux-scsi+bounces-24324-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 14:38:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58261F632
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F3A301B929
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33036165C;
	Mon,  1 Jun 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b="LAbqAubo"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m15591.qiye.163.com (mail-m15591.qiye.163.com [101.71.155.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F32E9730
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316843; cv=none; b=ao0zmB26iANKCt7yvKYto9BOqZi62gYtRGLqqWXYKYLWS8YLqsePLzuQ9TrODaMsA9TCxSlfrOQEc9tVJ6EGQYmk2R9G74VtrSELz2tQ/uZzblzAxdizJWoKvpBaw5xGzTTUir2BBUEdnPYMXh+BAtYFviRXXtWLK4whfxJeW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316843; c=relaxed/simple;
	bh=b8sikl8mGUh0lYKMnMqJbgwqFYGSZZrRtuCfgbcx3Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjSIbwFc3tYvkg3OV5VcNviw/SPva5ciF6WoRf6lYUqBl6riokx5O+jTQA66cVU5S6NjFBM3OcvNK0bi2wp/L/7HDXFtn/QchjlFMzMUClO4UXc7F0SsxfhmJ0E5l17HzYeOwev9wPrNe8POoI5CQvdlUWfGVU+v/HOtALqJboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com; spf=pass smtp.mailfrom=leap-io-kernel.com; dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b=LAbqAubo; arc=none smtp.client-ip=101.71.155.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leap-io-kernel.com
Received: from localhost.localdomain (unknown [222.130.22.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 409944e5d;
	Mon, 1 Jun 2026 19:51:48 +0800 (GMT+08:00)
From: Dongdong Hao <doubled@leap-io-kernel.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: doubled@leap-io-kernel.com,
	yjzhang@leap-io-kernel.com,
	kezijie@leap-io-kernel.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] scsi: leapraid: Add new scsi driver
Date: Mon,  1 Jun 2026 19:51:45 +0800
Message-Id: <cover.1780312123.git.doubled@leap-io-kernel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8306986103aekunmd071acc9634e0e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGhhDVhoeGUJKHktMGkJISlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkhLVUlJVUlPSVlXWRYaDxIVHRRZQVlPS0hVSk
	tISk9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=LAbqAubo332NEeIdob0AvaiEMNBaiUG604dnq5HeJTief8XMzFons5cJ+/rNVBAzgMbQqAqSxoxd2o+qFhLbJW+AFz6qUNtcWYsJap/i2wDMpVEDYW//q1Y0jmy1Fi0EPfeZqkcXhwHErvP+uKbitgVnl+q3O8h/pUxQ3mcqTVcyVyb3ok46VZfWqEUaSXY1oHznbDWLJOEuV0Z4gVIIwGXwo+FWVscqRiFdnZGlXhwpoOLkBA/Fha3aQThlWVdSlM/9PmrycwxRVwlAr6tfEG/cHMaTQI/er5NmqFcdCbkXKSlFxy7L7s3WSMY3gOmlt4jmFzDcdDkByZ30M5yM8w==; c=relaxed/relaxed; s=default; d=leap-io-kernel.com; v=1;
	bh=GayGnWova0n+aBZrxwyFw0C3bbHcinI+vkKohLa5hzw=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[leap-io-kernel.com,quarantine];
	R_DKIM_ALLOW(-0.20)[leap-io-kernel.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24324-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[leap-io-kernel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[doubled@leap-io-kernel.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leap-io-kernel.com:mid,leap-io-kernel.com:dkim]
X-Rspamd-Queue-Id: 4F58261F632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dongdong Hao (2):
  scsi: leapraid: Add new scsi driver
  scsi: leapraid: Add driver documentation

 Documentation/scsi/index.rst               |    1 +
 Documentation/scsi/leapraid.rst            |  139 +
 MAINTAINERS                                |    7 +
 drivers/scsi/Kconfig                       |    1 +
 drivers/scsi/Makefile                      |    1 +
 drivers/scsi/leapraid/Kconfig              |   14 +
 drivers/scsi/leapraid/Makefile             |   10 +
 drivers/scsi/leapraid/leapraid.h           | 2071 +++++
 drivers/scsi/leapraid/leapraid_app.c       |  705 ++
 drivers/scsi/leapraid/leapraid_func.c      | 9053 ++++++++++++++++++++
 drivers/scsi/leapraid/leapraid_func.h      | 1566 ++++
 drivers/scsi/leapraid/leapraid_os.c        | 2516 ++++++
 drivers/scsi/leapraid/leapraid_transport.c | 1387 +++
 13 files changed, 17471 insertions(+)
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


