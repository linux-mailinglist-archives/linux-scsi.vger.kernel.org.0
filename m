Return-Path: <linux-scsi+bounces-24823-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bWRDEFXkK2rcHAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24823-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:49:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18D678C9E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:49:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Cu+joLcV;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24823-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24823-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612D6314914A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A458347505;
	Fri, 12 Jun 2026 10:49:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE726CE2D
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:49:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261393; cv=none; b=BJoJObGEqIJLjgyk5Qj9o+FZRJ1mkhNMf/HARWnHQ6i/vZiwPVc8FaNCNegAORlIaziJTrkYqDG6Fn9298AgCQo3FUAtXSSdeyuEHSfqLBwU/CJt4gD7YeWVA69IidHXlRk2NBygg6t0evmMjureByKS3WzcP5qxTGhk4t73Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261393; c=relaxed/simple;
	bh=bO+GVJRIA38rrymkEpul/edobMffXgHiCRscV8EncrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGxRsCKnrma86/s8c3QZ7wp+D/MaTJptlM1mcYvhIIBIv2N8OwJUDurqtl5yEa+UWrSuDtYyh9eTGeG8p0gmmTZzcnF7H+7fVRUpXy5FgSKGBS048d8T7oKopjNqqiWW6IKQzZQs+qT/hMnj4GYl1DvfrWkFzhgPlrMr8o4FqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cu+joLcV; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46013161068so396401f8f.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781261391; x=1781866191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwbOMXEj+LVyBMNvTH1UcOewbJeU2hOwyEKuq/jqbUw=;
        b=Cu+joLcVysQPkV5cQUMPrHjUINiXclb2nEEvELcGq3k+qCk3Qjtihc3F3ihkPfLNWw
         gcWl+CGUxm5dosG/hRPhZzBMrI9IZdliOAfYfVlSaLEpdzM1L7TX9VWEFPzvaEatSkQz
         pDTG5ytBjXdVtYJt/vV2ApKkWnMkIYYFpwrP9bUPB9JKcK7EZmf6bKXkZfnG13ck32/w
         vYvsELyxPtc+FZyly+QeUtfEnBQGti+GXy82m1Sgi5opkNuCL2/t40RVjIbc/dQjJWX0
         0eQ18kve7uqIs9E9eBwWX3sOICnN+Ca51XacfCYXM/HVDe6dyXh5781UDfOcsbm1YXxQ
         ipHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261391; x=1781866191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwbOMXEj+LVyBMNvTH1UcOewbJeU2hOwyEKuq/jqbUw=;
        b=dIGjJmkFVeNNejynjjLnsh5StH7MFP8aGZYlfvE1jqO85rO/9x2d7ZRoChGqS+HpDx
         lj+rMFP/aRvsL8k1yQONSdxk1hxrgMNNSzqUSqXUPLVmNj/1/nEAULKRKb1B8QaLSv32
         Qc8czZZFudDIQTWHPAK5W3CEtNMHfgOsu1wQb9cB+Rim99XQ970cG8+exqCztrMF7nRI
         vPuV2tYQNThNLUNkS031a4F9nnRcSt1L2XVXWcfWfRFfVG591dBpDwVuhZZlDaa2+SeT
         zecWPAjMHD1MENq0so53ABTncdUHj0nA34flNgBkWNfV6rROwNU8suKP81MgUMCFwURx
         l9gQ==
X-Gm-Message-State: AOJu0YylfZ/Au7kBeCQHyVEN1/8s0xpjECC94y9WlqPcP0WVgRiZPQRe
	osMBs91/8fTCrdbGQn89C/MSdHFrOVCeYw+KRClcm00zIm9h0JnKEuA/5ciLErzriv0=
X-Gm-Gg: Acq92OGO/MNvo9T/at3wR2fbN9+v8IYX7IJ0nfGg6U9PgqkjbbJXKEKiaDw7QWSveSY
	xGiXekncfoUagPsxDDFEgD0FbrG9XMyNL6FsIjVGSC+qSOvibTnuowBPQr1Ct9z6r+nbwoDzDoW
	SYbp5Z6WMma1fFJKU7F/uVV+ixN5MaAhQRSdOBldETUSuYexkv4NzqYe0VLWp3VXKnFLaEdEHJ+
	4/PTp7v237fcD4CmKykej70VI/s+I+DFHceuOWl45iAQdnbC1SZW62CLK9uJzw8Sm5/F42PatpZ
	FjWK1qPfnNLRy4EfuHeXVVXQbJ+F/AkqMfQDQKtcJERV6JMSot8ORBRUTyC/38w1EsT1MEOfBwO
	PJU5sVjW4rWf9Mcpw3OnSmckVA1e2jYWHTG3YIzX+Zbu9BPQeM58zfrx7MLK22JROco4oZLvyqw
	sQRjWboqExeZ62MO8KfNmTpBSe3enSozt6IRerxx1klpWp4YCD66vjuq+J
X-Received: by 2002:a05:6000:430a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4606dbd79bamr3399063f8f.33.1781261390754;
        Fri, 12 Jun 2026 03:49:50 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c35sm4830252f8f.22.2026.06.12.03.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 03:49:50 -0700 (PDT)
Message-ID: <8aa74fe9-5f6f-4e4b-8a10-1946628be27a@suse.com>
Date: Fri, 12 Jun 2026 12:49:49 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/60] scsi: qla2xxx: Add 29xx support in queue
 initialisation path
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-6-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-6-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24823-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E18D678C9E

On 6/12/26 11:52, Nilesh Javali wrote:
> From: Manish Rangankar <mrangankar@marvell.com>
> 
> Extend the queue initialisation and multi-queue management mailbox
> commands to include IS_QLA29XX() checks, following the same mailbox
> interface as 27xx/28xx.
> 
> Unlike earlier adapters that use 64-byte request/response ring entries
> (request_t / response_t), 29xx uses 128-byte entries.  Add struct
> request_ext and struct response_ext, which extend the legacy 64-byte
> layout with a 64-byte reserved area.  The first 64 bytes are
> layout-compatible with the legacy structures, so common header
> accesses remain valid.
> 
> The enlarged entry stride doubles the DMA ring memory allocated for
> both request and response queues on 29xx, and all ring pointer
> arithmetic must account for the wider entries (handled by later
> patches in this series).
> 
> Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_def.h | 30 ++++++++++++++++++++++++++++++
>   drivers/scsi/qla2xxx/qla_mbx.c | 20 +++++++++++++-------
>   drivers/scsi/qla2xxx/qla_mid.c | 25 +++++++++++++++++++++----
>   3 files changed, 64 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

