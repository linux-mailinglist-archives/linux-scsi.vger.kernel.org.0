Return-Path: <linux-scsi+bounces-25010-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ht4UBJU0MWrndwUAu9opvQ
	(envelope-from <linux-scsi+bounces-25010-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 13:33:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5868ED08
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 13:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=fgNPcwQH;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25010-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25010-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F08301A41E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C64426D02;
	Tue, 16 Jun 2026 11:33:34 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B0349B19;
	Tue, 16 Jun 2026 11:33:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609613; cv=none; b=lTF9gGJGND4VkmsXOFKK+U0QvzeISv45BScBkrG/JyKqbA80IGopNo5W3FySATD1GWfvYNCSzBU2UERFkH16hRSNqcvU7GwIPShk4rArIUHGpTDDu2/R+/UPDaTvkMIRed+YgWYCFevvjgYBen+vlizcv9/kifDfKWGTXgkf/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609613; c=relaxed/simple;
	bh=jO2EQS1eMENaMxYKwwdaafvhE9VeswxK+Tht650orUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YH6byEjdR7jF6559XlzAIhGSPrcE1aET08PsABmh9eqPLt7Qmy2/Xl52CV+yMHDbt+frxwJxUtkaaVoE/V2o9fIJBCtA4uUbklWa/v3AbI0yrQBOD7g6ZOfqcHH+6ZpYWM10x4ZPuoEJeeENBmPV+Uufp50wzud53Ouz+mHimQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fgNPcwQH; arc=none smtp.client-ip=113.46.200.218
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y5iP/6wM6lXFdwlTmZRHjapFJuc/IMBjLQslUX/pMUg=;
	b=fgNPcwQHlPjEpMFptjKSLMmxbGyFXD/Adc+R8yRCNkNE0bc4pYxTtm7z1FJ6yM2BeAtMhpOG+
	AGwE/0dueTc2aHNMpGuzpXBDaEWsJvWBu9hk4j2OaUJD9EMCA+k05VZ2p7BrW2avNtvCXNdMmWK
	dXrvCRqLktbU5/XOm9R0C0Q=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gfl5w5Y5qzpStZ;
	Tue, 16 Jun 2026 19:25:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F00940363;
	Tue, 16 Jun 2026 19:33:26 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 19:33:25 +0800
Message-ID: <28cd53d2-4b5b-48af-ae20-1fec785a1993@huawei.com>
Date: Tue, 16 Jun 2026 19:33:24 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon hisi_sas driver maintainer
 to Xingui Yang
To: Yihang Li <liyihang9@huawei.com>, <martin.petersen@oracle.com>,
	<James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20260616032051.1268608-1-liyihang9@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260616032051.1268608-1-liyihang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25010-lists,linux-scsi=lfdr.de];
	FORGED_SENDER(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:liyihang9@huawei.com,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:liuyonglong@huawei.com,m:prime.zeng@hisilicon.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8E5868ED08

在 2026/6/16 11:20, Yihang Li 写道:
> Replace myself with Xingui Yang who is very familiar with the HiSilicon
> hisi_sas drivers.
> 
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a068db0ade61..6760865a2bad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11675,7 +11675,7 @@ F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
>   F:	drivers/infiniband/hw/hns/
>   
>   HISILICON SAS Controller
> -M:	Yihang Li <liyihang9@h-partners.com>
> +M:	Xingui Yang <yangxingui@huawei.com>
>   S:	Supported
>   W:	http://www.hisilicon.com
>   F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt


Reviewed-by: Jason Yan <yanaijie@huawei.com>

