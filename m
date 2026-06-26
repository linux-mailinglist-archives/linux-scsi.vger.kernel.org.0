Return-Path: <linux-scsi+bounces-25303-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 02exIKn0PmpGNgkAu9opvQ
	(envelope-from <linux-scsi+bounces-25303-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 23:52:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EDD6D05E6
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 23:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a8RocOcG;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25303-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25303-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9313B301AB81
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180673B1017;
	Fri, 26 Jun 2026 21:52:39 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04224149C6F
	for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 21:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510758; cv=none; b=RJqAcsB/dfvZ1zbxzAFxXjCKsvw0c2kGkzar9DURsywvLuT4AqXHp9L8tpE90gksrRfNEOeyy1UNje/+pW3XtccBij2YJiImwN1o8yixqka6SbPrTUmM2xBiKYH7BxEK7xFtmZqhg9yduJGNQAOGByhpLHA94vntpJLvapa7fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510758; c=relaxed/simple;
	bh=9Oeta3wxqTHs1QJ++9ccfGwG1uukfM+GxOgFVvoIees=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbYjl9Z7+WxyxUU0jP2ELTPjxqTa6GzBOWPrjaOtvpEDfO2iPaaKSN/lDoRzveZZ0CO5CYKmheonfjGYex+ulnKb7jODrm51+4+k1YwCDNuKKGdfXTe+HjMpDxj0bftf8/0OofxpP0hLCIQZ2I+CI3tga0nsmLb4/2iNAs4nTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8RocOcG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C601F00A3A;
	Fri, 26 Jun 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782510757;
	bh=ALjPKz2lMu7o7U4IUPXJUeyPR9n3MgYSnJRSgBg4HKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a8RocOcGS+WucKVj2En+gpaOfsge+ny0zvhrlCQXPvazBtZ/k6YOKZxyEt4J1QqY0
	 oN6kvt3C42f9qM87SscVsU42cmoZ2wpKi+oWOdjKGkOt2sG+cpr/Tc21YyLGwitmsd
	 Tx5dFkvC4yUpLYGgzY4EXfNmCoHtBxw+X9AFmKgYHvmsJF73/Y/mG6tJnyjLhmQBDS
	 d9sVCKF5Q/PGuB0BBAqN9PAnK63bQKkqmX7eNHhXhAg3A5uC1MwGieLK5p2wWGYudX
	 38KsBR7Ucj7pZ1EOmOeaK77OTy0KXOYDUFmrGfDO524zZUbFh8VlwAeq5/DIK8+yFH
	 mLkTCTLVPFXuQ==
Message-ID: <9bb57458-21e1-4e20-8d1f-6b728813f2e3@kernel.org>
Date: Sat, 27 Jun 2026 06:52:34 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] scsi: sd: fix error handling in sd_probe() after
 large pool creation failure
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com
Cc: hare@suse.de, tom.leiming@gmail.com, p.raghav@samsung.com,
 sw.prabhu6@gmail.com, linux-scsi@vger.kernel.org
References: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
 <20260623100159.4018066-2-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260623100159.4018066-2-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25303-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:tom.leiming@gmail.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:tomleiming@gmail.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,samsung.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5EDD6D05E6

On 6/23/26 19:01, Yang Xiuwei wrote:
> After device_add(&sdkp->disk_dev) succeeds, sd_large_pool_create()
> failure must unregister disk_dev and let scsi_disk_release() free
> sdkp. Going through out_free_index kfree()s an already registered
> device and leaks the sysfs entry.
> 
> Fixes: 7179e626b76e ("scsi: sd: Enable sector size > PAGE_SIZE in SCSI sd driver")
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

