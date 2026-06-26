Return-Path: <linux-scsi+bounces-25276-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+I5CyzZPWpv7AgAu9opvQ
	(envelope-from <linux-scsi+bounces-25276-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 03:43:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F806C986A
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 03:43:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=DKH91sZi;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25276-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25276-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95A830A7882
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE52BE644;
	Fri, 26 Jun 2026 01:36:01 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14421CFEF;
	Fri, 26 Jun 2026 01:35:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437761; cv=none; b=OdSxSrx9MgToZM5ZaXcGiD/8ClcPElTKA8JbH6iRVNnYXDLLPTNI/FDDBSkSQTYfIJ2aGiUdEbPpzhnOgzGsPINrWiso351OBD2+3I4zjsZ9tHHZ2OFIcAfDvgWFcOPq5upd4hc4ekJgxhCObxMw/5dIkIqOH2uOUgG9JDJHJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437761; c=relaxed/simple;
	bh=SxHwblFPXKYF9Siw060wjNKx/SJuOMCfaWSe2qyEJ5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLQE3pTjvyUAR/hqlYFghWUFRZEuZtumay2jNhH78LdxMgMUXxmO7rlhuI2Mo4o64WphTBurM8NFxjJfv9FaeP0XXulE90INDB0kpZFX/nTidtZNU0LQ0I22vv9nzYDhoy1YcamRSHeXYnXuqz6AZfbceDRkEvr/dyXhwH+xHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DKH91sZi; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=SxHwblFPXKYF9Siw060wjNKx/SJuOMCfaWSe2qyEJ5A=;
	b=DKH91sZi0HvV8uJNJ9Xo6KpCC6G4TCnlHAC8DGR/s8xL4OYBXbWQ/uVOguF+Cl
	3kgaRZtvW1vCaZQlv2FIqfbOPo+o4Ymeeeyi4WL5lU6AWFQQ+RoGXYaoxlL3ZjwW
	RhZ7VGFxkHJohD1qLhESbONeJbGtu8dgcK2BqTBRuMDVQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXH5lC1z1q9pVeFw--.45073S2;
	Fri, 26 Jun 2026 09:34:58 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Yang Xiuwei <yangxiuwei@kylinos.cn>,
	Rahul Chandelkar <rc@rexion.ai>,
	Jens Axboe <axboe@kernel.dk>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2] scsi: bsg: read io_uring command fields once
Date: Fri, 26 Jun 2026 09:34:42 +0800
Message-Id: <20260626040000.0000000-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <55f36cc5-a013-4960-8787-fbdf4b4d0c20@kernel.dk>
References: <20260527191817.142769-1-rc@rexion.ai> <20260626020000.0000000-1-yangxiuwei@kylinos.cn> <55f36cc5-a013-4960-8787-fbdf4b4d0c20@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXH5lC1z1q9pVeFw--.45073S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUogAwDUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6gLvgGo910KYZAAA35
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:yangxiuwei@kylinos.cn,m:rc@rexion.ai,m:axboe@kernel.dk,m:fujita.tomonori@lab.ntt.co.jp,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:io-uring@vger.kernel.org,m:bvanassche@acm.org,m:csander@purestorage.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25276-lists,linux-scsi=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14F806C986A

Hi James, Martin,

Following Jens's feedback — would you prefer picking up v2 as-is, or
a narrowed follow-up? Happy to help Rahul with the latter if useful.

I also have a separate GFP_NOWAIT fix for the same path. Happy to
rebase once this lands, or send a combined series if you prefer.

Thanks,
Yang Xiuwei


