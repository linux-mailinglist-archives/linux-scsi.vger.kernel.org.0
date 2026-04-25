Return-Path: <linux-scsi+bounces-23302-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOSOJ+V27GmxYwAAu9opvQ
	(envelope-from <linux-scsi+bounces-23302-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Apr 2026 10:10:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A988E4657EC
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Apr 2026 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB75300D94C
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Apr 2026 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46B347500;
	Sat, 25 Apr 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="BWkjBY2I"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9991D61BC;
	Sat, 25 Apr 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777104609; cv=none; b=Wou/uv4HripL7Rfl4x3bBopMkHG0Cyaoq/bQYiVWiHenmZ+O4BVC3tbPNJh6GpU0kwqhoXgLSKg6u6+Nx/4LwTiw9ADruMLijI08la883nhLvkW10i9LRs4L9vTCJAebq96pgysY4hlRB0VGjX0jZ0EYT5cDFe3wJNW2voAlHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777104609; c=relaxed/simple;
	bh=lf/JtkNu147HiPm6/kqPg+j/5DzDDyPGcNwfbB/POWY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MEB0oofRuM5M5xdrzMwYGkcAlxbujq+u14Lhq/HPKEW2ph2bJMFDOLiWjGwsG4PtGFgX1ZS3Y65MNGtr1O+lO2GudGQuhSWx8JVMnOo0bHWPHQGxHu6rQKhuXcXWqAQpnaRjq9fUsaXa+820W4EPUCadNdBwPoJ0Z74yKoGm6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=BWkjBY2I; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lf/JtkNu147HiPm6/kqPg+j/5DzDDyPGcNwfbB/POWY=;
	b=BWkjBY2IjgSYOG4bFlp8tLo7UuYnREkNHqUgAZjRuQtQ2QZlyHUk/dZ3by1Ic1aUMhfEbYSfl
	FFmqY3zpEncl45rn7P73Klu3G+PwvbSiol8r6EX20ZCvP16tmmYTJtUZVGUf1qKXfHYsIwZ9ZuF
	cDijvp9RmNmx142ucnKwP1U=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g2j536mpFz1prrb;
	Sat, 25 Apr 2026 16:03:35 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 145EE40576;
	Sat, 25 Apr 2026 16:10:03 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Apr 2026 16:10:02 +0800
Subject: Re: [PATCH] scsi: hisi_sas: Add slave_destroy interface for v3 hw
To: Yihang Li <liyihang9@huawei.com>, <martin.petersen@oracle.com>,
	<James.Bottomley@HansenPartnership.com>
References: <20260425065218.2655578-1-liyihang9@huawei.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <prime.zeng@hisilicon.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <e3a2df92-3967-1df0-df0a-7759be700b38@h-partners.com>
Date: Sat, 25 Apr 2026 16:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260425065218.2655578-1-liyihang9@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh200005.china.huawei.com (7.202.181.112)
X-Rspamd-Queue-Id: A988E4657EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[h-partners.com,quarantine];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23302-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyihang9@h-partners.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Please ignore this patch.

