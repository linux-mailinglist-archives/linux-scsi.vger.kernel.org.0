Return-Path: <linux-scsi+bounces-24817-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DrzXIULiK2oEHAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24817-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:41:06 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA86678BE2
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=WjpIh3SP;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24817-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24817-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00539314D4D7
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42128391512;
	Fri, 12 Jun 2026 10:41:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B936F91F
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:41:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260864; cv=none; b=SETzAh1vukxZJh27w3zcGL9u1rh6FF66AXc/7K+tDFLaUZQCkujzqfc8Eex9YrcQgrSpiq3sYspIvlJpRGEYzea3Ywv1Aep0FR4mTjK90LW194EVf8c3G9Md5qE/sg3Pr+sMhTJgrpNQM2VbUxdgVLGsmsTy1BeUN36EVqnsOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260864; c=relaxed/simple;
	bh=6WAX/BY1sHk/+7dB46Dm7FyBEXp55ETI0OgUhcm8Qd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvlFvxBqKeqbqq6D48NUSFh6HidgultPz5kooifqvUZmNr19strDuLaig/XS7br9ZnvTuWOuHEO3sWS+2s6QAtu53qrkkDXAQjk9sHZFErBpQNP7Yynfqt1cfdM3SlqM9nrRM116CDiYaoJsPQSRwCVg79AJPA0Xhen5p7i3Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WjpIh3SP; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b7866869so7944875e9.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781260861; x=1781865661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKYhDbo/BVbPAG52eCa6j34AzNbuZIzmkWiRm07K9uM=;
        b=WjpIh3SPqOtaAiWFBM/HFmo3fBXl7TrGx9d9Mi47UXKIpd0wCVBCacFTdvZdItA40H
         ogMyqzMxsjoxcysvi7hGKN+okt96eZRrC+0t1kWr3NwTEqXGEKtkXzejCkFgsF+6x86P
         y3C+NsLAvO3e2B+AZAAmkbMkiHxHooik3Am1EC9/FgKEKqFSYAhyvJUtzV+mEPUVb4Lt
         VQiiQ8p2hOLIZWO0eal29IqX8Q4X104ubDs8RWBYImtc32PLPTwd7jgB0dsisf60eqmC
         pKWYHIUDKNSTbyFHGgyXTGUUwljJfrzt0N6H4sjsyjqZ18QK1VLozVdGZ1+iTTYKvW7C
         pWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260861; x=1781865661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKYhDbo/BVbPAG52eCa6j34AzNbuZIzmkWiRm07K9uM=;
        b=nYimiL+p7f2CwMFGKiprvJeYSpt8vgIpGGCL76b5dhoQhgQga/N5Dk0DHQlVRKn5zT
         FNcw6urQ7mL8b5YZO9VYoOq0mgk/MtHv8lp8GDkDH3wgGNgMNc4AlUgkyDR26bqJ/hDe
         w6+3XIEDPOe+xzYy/+3D3T0QpklPpsgAqX+gg9Fb17QyHRpsho9bOpONz29napRrMsqF
         M8zNWZ/7FgY3DuWTDBqZuL0ygD/mXt9+i21FErTutyUSny4zTldZLlGKVAyyYhQVfYhO
         SBQ3tMq18mU930E1ukdz94wlHH8wwA1bwJn1iMw1pSijwnAeZ0//6EQely02RIiAe2xj
         GdXQ==
X-Gm-Message-State: AOJu0YzK7rAL5QnLSsnLFak33s6rqP+w1KqaOMDIAvnGBQPWUEMn0Bo4
	wt/J/bas5VBEIY8qfztMoivMvp/tZ6TPjNtQPZAOG7jiv6hFfbE9Yk8rZhRGa3izrHg=
X-Gm-Gg: Acq92OEWfCpj17yQvzjJ42cMyX1h8ETPClB9roekKrFpiEP1S32/Ike+28vASIQoPgn
	XSB/pG8QwUwmrWOpmn1jgU6u3hFYVLS0X64/BvsmhyCNvw+PUj34lex3SFXOLJWvh4C76aUEF+/
	nT1rYXLp3dg+ioHfNzE2OSoS7LIVifXYRRd4S6sgK86Dqq64GkDq3PmgP5VoTeqaGdMGR3MYPDD
	VXQbrXG0M6heP7r4k3yZzPPn8s5q+PjDTwMk+evx5cI5XXdUNI6KKgDFjDqrOk2rafoKWJkNc4Q
	YPo2+iStkiegENhhiVwPYAswKzMfe+ncinfb/RfgwRneWNtb6FfB920sFgrqKRLnQllgZSjCix2
	eymi7XdFQn50ngJwJuUPjs3O5ZKKP7n9sIK0BvHLJ26pV/QYjsThHaX05QwzTvPTh3iOYhsisQl
	upveqMdbW1MIsvFkl9lo/l3RLTjmUNiV7flnf7FsbadilGwUYe3qkJQBtV
X-Received: by 2002:a05:600c:4514:b0:490:e1e6:8988 with SMTP id 5b1f17b1804b1-490ec4c0327mr28465305e9.7.1781260860813;
        Fri, 12 Jun 2026 03:41:00 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2cf582bsm154474595e9.10.2026.06.12.03.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 03:41:00 -0700 (PDT)
Message-ID: <28469a1e-361b-45d0-9e7c-82a3565e4f45@suse.com>
Date: Fri, 12 Jun 2026 12:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/60] scsi: qla2xxx: Add 29xx series PCI device ID
 support
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-2-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-2-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24817-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAA86678BE2

On 6/12/26 11:52, Nilesh Javali wrote:
> From: Manish Rangankar <mrangankar@marvell.com>
> 
> The QLA29xx is a new generation FC HBA that shares much of its
> architecture with the 27xx/28xx family.  Register the new PCI
> device IDs, wire up IS_QLA29XX() capability checks in the probe
> and ISP-flags paths, and extend speed-capability logic so the
> driver correctly recognises and initialises 29xx adapters.
> 
> Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_def.h  | 33 +++++++++++----
>   drivers/scsi/qla2xxx/qla_init.c |  2 +-
>   drivers/scsi/qla2xxx/qla_isr.c  |  5 ++-
>   drivers/scsi/qla2xxx/qla_os.c   | 74 ++++++++++++++++++++++++++-------
>   4 files changed, 88 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

