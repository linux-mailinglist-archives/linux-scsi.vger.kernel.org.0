Return-Path: <linux-scsi+bounces-20744-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAPCAfERimlrGAAAu9opvQ
	(envelope-from <linux-scsi+bounces-20744-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 17:57:21 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E7112C2A
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 17:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD42E3006808
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Feb 2026 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029B374162;
	Mon,  9 Feb 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Z+wKuS/x"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16791DFD96
	for <linux-scsi@vger.kernel.org>; Mon,  9 Feb 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656237; cv=none; b=gjNm3S72IebmduGF4ko027EtqRnhaO5qbIgBdqEL0olePswb+0TlrQF43BDhfeS7zv71N2eTygQOWud+4jJwZej/0Fcqn6ExZoyQPWBsNBSNmmWfTABnK77MIAS1NIrH04ZoOECrj9/NTfWo6N8XQMSUX7j+/zQL8mxUACdN+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656237; c=relaxed/simple;
	bh=VQhfH75DmgQQpgZiJ+vTg/ohvwtIKdTJJ7AZRxfQPKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNtLidVFITUlQbfUiTrT4Z8lX6/M61O6WPIM5pbmwSiXk/ivp8nxn2gD0kpf7XALZZUU6UXtA3xVri0Izc19uk6dJTjIDeeAlsJCMQQ+n7AFotG7rYBTqM/+gqnuQuQ3Mvifeub0eK8iGGgwRVfOohridB59WDvAP7gAhTgiMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Z+wKuS/x; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f8rTM05SCz1XM6Jh;
	Mon,  9 Feb 2026 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770656227; x=1773248228; bh=rnV0X6ZG8qLf3L+SsSNDmfQB
	er6hQmYkfHJu6QC8bvQ=; b=Z+wKuS/xgS/2QsTHXeH45SeSyOdZwaBhmwzPGNhV
	rFuMhs930tLrxqDO2NfFtCd6+BS0tJ6XU/l/vklFBiqyVSIC3jPZ6txYnlRulrxy
	1Cdb29mkVsm8hQ5bcc3IMszHxZETvMoYwMfTVOUqDw3I+iWQh7HYh96jE03j6eT8
	akR6subSMIcYxaB6nR2VPlE/iyS4+C/HEkpW8ABfGuusqoGOf8iArRHoPeaPew8P
	h/n7/g5lBHZjdr/cc0aAxyYdlIDIVTQ5LP815EOpX21fXmSIQFy/XOdCwm826kI/
	KXWgsThbyQRepcg/DP8rZ59MU9lOh+Fc1o4iBBl1WmWh3w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kEmNqcuJDYaf; Mon,  9 Feb 2026 16:57:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f8rTD3PZLz1XM5jn;
	Mon,  9 Feb 2026 16:57:04 +0000 (UTC)
Message-ID: <6241685f-fc24-49aa-96f9-c2a69a4cee75@acm.org>
Date: Mon, 9 Feb 2026 08:57:03 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ufs: core: add debug log for uic commnad timoeut
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260209083053.1467647-1-peter.wang@mediatek.com>
 <20260209083053.1467647-2-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260209083053.1467647-2-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-20744-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C8E7112C2A
X-Rspamd-Action: no action

On 2/9/26 12:28 AM, peter.wang@mediatek.com wrote:
 > [ ... ]

Please change "commnad" into "command" in the cover letter of this patch
series and also in the subject of this patch.

> +	if (!cmd) {
> +		dev_err(hba->dev,
> +			"No active_uic_cmd, may timeout and be cleared.\n");
>   		return retval;
> +	}

The new message is incomprehensible to me. Please make it more clear. Is
this perhaps what you want to be reported?

"No active UIC command. Maybe a timeout occurred?"

Thanks,

Bart.

