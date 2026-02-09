Return-Path: <linux-scsi+bounces-20743-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHAtBUsRimnZGQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20743-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 17:54:35 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF81112BBB
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54F9302E933
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Feb 2026 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3D3816EC;
	Mon,  9 Feb 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="si1BLDeK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078621257B
	for <linux-scsi@vger.kernel.org>; Mon,  9 Feb 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655803; cv=none; b=A1E3m6WvBCWdWu18gxZbfNF7Z82vKMozf1CclTm8cw4xAK8PabPvkhxBwxCI0gmJk4vDj8J82apZK7lkmD+070qqX46AMceufvmBRsXi+BWxSDynNLvyQicUKu0uhmgdOtYDIkqxDfOvurLokClzGrNAF2kdFURSrcmEH2KkTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655803; c=relaxed/simple;
	bh=6qk2yqHR6SFYvuOEGRMO9L9ww9x4E9jul+W45tr/glM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GavTc/cILYscDSQKR7vZSdmkOBGljd1qhy/Z97yJmO/HbFDjSZK+yxHP141XcY/b+FVtnSHKWuPuP9Ettdlg+iA4F2KzkjU+alIAUhHV2FHv3eZJy7PgbeSmwM7nKk1f93HN3lHsPYft0hHpyqRTJnjEJkEZQY1iKLqTK8pBprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=si1BLDeK; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8rK62kHMzlfddr;
	Mon,  9 Feb 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770655799; x=1773247800; bh=Dk4BwK/9RO402mwDbbLyYl5d
	bYCrt0aBAKPtqoxqwm0=; b=si1BLDeK8NSOpeykrJ/ZgA5fEX/10zz1KncA0tdj
	5WdhpbQDcbVoLlh3kIMapGNbxZFTmtJ/T9WQJGyAaTyoYemOpAWzctdKtttGb3pl
	HSmq6tww8jxaGHm3BjutAXIYiK9Kw26X8uoMPYXksRUjunuW3Djx48FWZhIbu94M
	j9QtRkPeg4t2uuJSBrDnjIVCrfiNs0sbnSrxJVuNuC2TYs7oSM1I2P8+I1McVwsy
	Ms1ElEfepFw4+hVE7PY9FPtX3WJ1C6dgL/pvpA/fQvccYLgCwfklgQTMiaX4mcGB
	yTdTYAppod82LzWemD2Yl9iPFWeHHh0B8Le/M6y0KNTDjg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jCYjlTVgbSTq; Mon,  9 Feb 2026 16:49:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8rJz6YLJzlfvq7;
	Mon,  9 Feb 2026 16:49:55 +0000 (UTC)
Message-ID: <19842000-3d35-4585-903b-2c194efce209@acm.org>
Date: Mon, 9 Feb 2026 08:49:54 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: support UFS 4.1 CQ entry tag
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260209122101.1529379-1-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260209122101.1529379-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-20743-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 6BF81112BBB
X-Rspamd-Action: no action

On 2/9/26 4:20 AM, peter.wang@mediatek.com wrote:
> The UFS 4.1 specification introduces a new completion queue(CQ)
> entry format, allowing the tag to be obtained directly.

UFS -> UFSHCI

> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index ad0ada57959a..d8b5cf18a01c 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -273,13 +273,18 @@ void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
>   EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
>   
>   /*
> - * Current MCQ specification doesn't provide a Task Tag or its equivalent in
> + * UFS 4.0 MCQ specification doesn't provide a Task Tag or its equivalent in
>    * the Completion Queue Entry. Find the Task Tag using an indirect method.
> + * UFS 4.1 and above can directly return the Task Tag in the Completion Queue
> + * Entry.
>    */

UFS -> UFSHCI

Otherwise this patch looks good to me.

Thanks,

Bart.

