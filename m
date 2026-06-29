Return-Path: <linux-scsi+bounces-25320-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 32HbE9zHQWo8uQkAu9opvQ
	(envelope-from <linux-scsi+bounces-25320-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 03:18:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA716D5643
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 03:18:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="h/xBnhvo";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25320-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25320-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29F2300AB01
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3CD1991CB;
	Mon, 29 Jun 2026 01:18:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEB17745
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 01:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782695896; cv=none; b=C+WL/kXjmYyRNaIhzBIQzkO3l3KytqbKoV74IOB7lFIsyNqU2Enjzf91sZ9k2rC7bI3Tl6Q0Q2iyPTyALGZED21fANdLwSekeg7N/FjGpDjZXvPYOQEGPsbE58LeUDh7z4tBWfyS8qr1BQ6WBAehxdiUvfvYvOLrTOHoaz2NbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782695896; c=relaxed/simple;
	bh=FAxSvtdshfkiJ1HR9NdRVIqZNmb5ki1HYsQEqnQDjys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxO4rbppgB53wW3DBDT70UQKnOOiSj7AjTK04wBtfRtSJXtlQ4qEi7rQLPRdAlKChrkbCox2v7EXxTPG/ebVOIUrQ8GHq28VHgM7EzGbhyiMyMg4z6buBxandCUlG/Grw5rcpJx4u0AlbUplnWIM20cwT4cVomKxW/rrLGRQ9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h/xBnhvo; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FA
	xSvtdshfkiJ1HR9NdRVIqZNmb5ki1HYsQEqnQDjys=; b=h/xBnhvoIlo5loUlXl
	qLBXKyYO8Oxh7VqJtDuFtmomJUsMKWTNXurPHiwbXVlRAfUJgTbJ/P3nCXR6NIuK
	7cI5DCL6u4CtCe6ZB9f9RyTu5b2d+QmEYYF6ma1L4+7EmJlp/N13MVgbBNp/CKAw
	/Mzoyx4VafxcCn+9Z3oDN4BmY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vK6Gx0Fq2hKtGQ--.48295S2;
	Mon, 29 Jun 2026 09:16:54 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: dlemoal@kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	hare@suse.de,
	linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com,
	p.raghav@samsung.com,
	sw.prabhu6@gmail.com,
	tom.leiming@gmail.com
Subject: Re: [PATCH v1 2/4] scsi: sd: unify sd_probe() error cleanup through out_put
Date: Mon, 29 Jun 2026 09:16:53 +0800
Message-Id: <20260629011653.2238665-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <00c16485-fc4b-43bd-a420-89b3b5eebaeb@kernel.org>
References: <20260623100159.4018066-1-yangxiuwei@kylinos.cn> <20260623100159.4018066-3-yangxiuwei@kylinos.cn> <00c16485-fc4b-43bd-a420-89b3b5eebaeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vK6Gx0Fq2hKtGQ--.48295S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYeOJDUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6gb9jmpBx4bU3QAA38
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25320-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[HansenPartnership.com,suse.de,vger.kernel.org,oracle.com,samsung.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:tom.leiming@gmail.com,m:swprabhu6@gmail.com,m:tomleiming@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DA716D5643

---

Hi Damien,

On Sat, Jun 27, 2026 at 06:54:44AM +0900, Damien Le Moal wrote:
> device_unregister() is called here and in the next error path too. So what about
> a "goto out_unregister;" to avoid repeating this pattern ?

I tried that too, but out_unregister cannot fall through to out_free_index:
scsi_disk_release() already calls ida_free(). So it needs a second
goto out_put after unregister, which is why v1 kept the explicit paths.

If that out_unregister + goto out_put pattern is fine here, I will use
it in v2.

Thanks,
Yang Xiuwei


