Return-Path: <linux-scsi+bounces-25321-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ip0zL5n8QWrIxwkAu9opvQ
	(envelope-from <linux-scsi+bounces-25321-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 07:03:21 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 461546D5F66
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 07:03:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25321-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25321-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E67F830062EF
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 05:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79642274FDC;
	Mon, 29 Jun 2026 05:03:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F5273D9F
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 05:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782709397; cv=none; b=rqgfnUlXOgmgyC5NePUMUpGJjETaXZss/uEDmWb/If7tMo26XTAP3NJAr7ebstXR0WwdzudPLyTvhFcsmkjLMbxVONikcBGWUtN/P4tUgrQbfmBrxqDjFvFJVLDEDVWva/UNXfllnohvYic0IMpQrDCC7uzyLUEx+tBYX1+ufME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782709397; c=relaxed/simple;
	bh=90MwQ3mBO1cgWw4OHV4Im/jluGbP6MdaVU8Av/m96A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouBJWVtceWb4uEXkoq39VnROn0ZV+UtGCSO70460Yo1Fzycfv3LoA723MiB+cVOpjfBzaJ+ipdMmjDf7t/bDEkWS19373/D2AHlfu7JDGguKO6V+RlLWpM6Hv5EuwAnQiN3MuTrwOr4JFAvx6Yv2FwRE7GdvSg1YGo9IMzlct6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4461F000E9;
	Mon, 29 Jun 2026 05:03:15 +0000 (UTC)
Message-ID: <0f973be4-aa0d-435c-82f1-edd3925cc926@kernel.org>
Date: Mon, 29 Jun 2026 14:03:03 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] scsi: sd: unify sd_probe() error cleanup through
 out_put
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: James.Bottomley@HansenPartnership.com, hare@suse.de,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 p.raghav@samsung.com, sw.prabhu6@gmail.com, tom.leiming@gmail.com
References: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
 <20260623100159.4018066-3-yangxiuwei@kylinos.cn>
 <00c16485-fc4b-43bd-a420-89b3b5eebaeb@kernel.org>
 <20260629011653.2238665-1-yangxiuwei@kylinos.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260629011653.2238665-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:tom.leiming@gmail.com,m:swprabhu6@gmail.com,m:tomleiming@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25321-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,suse.de,vger.kernel.org,oracle.com,samsung.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 461546D5F66

On 6/29/26 10:16 AM, Yang Xiuwei wrote:
> ---
> 
> Hi Damien,
> 
> On Sat, Jun 27, 2026 at 06:54:44AM +0900, Damien Le Moal wrote:
>> device_unregister() is called here and in the next error path too. So what about
>> a "goto out_unregister;" to avoid repeating this pattern ?
> 
> I tried that too, but out_unregister cannot fall through to out_free_index:
> scsi_disk_release() already calls ida_free(). So it needs a second
> goto out_put after unregister, which is why v1 kept the explicit paths.

Simple solution is best :) If changing the labels makes things more
complicated, then please feel free to ignore my comment.


-- 
Damien Le Moal
Western Digital Research

