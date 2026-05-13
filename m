Return-Path: <linux-scsi+bounces-23767-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BqDIPAYBGpLDgIAu9opvQ
	(envelope-from <linux-scsi+bounces-23767-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 08:23:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC352E0DF
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72A9305093A
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E48E399359;
	Wed, 13 May 2026 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vm5FHb2C"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B93145A1F;
	Wed, 13 May 2026 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653418; cv=none; b=ej4r1L9KjbYWhnTbPpFj7Z8hSGFMTgWGuhEM+3pm3Hk5PKSkdfRVZiV9+cWGs2XVtUL5mwnQJ6aMkykq5pdbkUylzzV0j1eqPc7rf19pkDuoY7uuchUkHN8B75dARygOTJEQ69fzL3PqFI0Iws5bJ3drd/ct24e+6xsHnNo8qso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653418; c=relaxed/simple;
	bh=PdmLJ9+8nG64WQycIfFsF45vICCwcpAuIvDAQHoz3R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=it4lkmkJtotJb4HBkGmQkY7uZ24SrTkiCj1Pwoc+VskMVa8n+1zR7iIi0WJoqpwLBTdegA6AAx3FMRR5JBpKtFjoKcjIlpGd/UO3fLz7Mbh05aog6riGqi+iEG1WKn/wxet24ae/px6tzemh6YLnPIjRcnWYoE6Fnf+J43HQkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vm5FHb2C; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/hyPxL9xO96odz5eXSpgxiX5JGILi3Lj/lGP9gQ/oU8=;
	b=Vm5FHb2C7m/5BODFt0iEkkI7OO72+SHwUb55Nm9zAjOKWaxTltrjqp5Ga8kCcRGb+9OGV22kh
	E3EarbhGjSTmpg+l/VNa64UnwfsNSOj9ZZPV8xuEGlhjZQ2FSlZZVUymmQwKwIGzdPrRQMups21
	FikfjWmxQQygiUWPgbZanI4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gFjrZ69vTz1cyPP;
	Wed, 13 May 2026 14:15:58 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CCA640563;
	Wed, 13 May 2026 14:23:34 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 14:23:33 +0800
Message-ID: <af742359-a7d5-4a56-a8e0-2f1e7511928a@huawei.com>
Date: Wed, 13 May 2026 14:23:32 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: hisi_sas: add support for dev info update
 notification
To: Xingui Yang <yangxingui@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260513021603.3023329-1-yangxingui@huawei.com>
 <20260513021603.3023329-4-yangxingui@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260513021603.3023329-4-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Queue-Id: CFEC352E0DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23767-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

在 2026/5/13 10:16, Xingui Yang 写道:
> Implement the lldd_dev_info_update callback for hisi_sas driver. When
> a device's information changes (such as linkrate), clear the old ITCT
> entry and setup a new one to reflect the new settings. This ensures the
> hardware uses the correct information after events like cable reconnection
> or renegotiation.
> 
> Signed-off-by: Xingui Yang<yangxingui@huawei.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

