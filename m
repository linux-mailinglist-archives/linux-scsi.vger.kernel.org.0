Return-Path: <linux-scsi+bounces-24870-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btmlC6T9K2qCJAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24870-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:37:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49771679635
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ZFSF7TWc;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24870-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24870-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0268D3004C91
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57943DC4CE;
	Fri, 12 Jun 2026 12:37:47 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B33C942E
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:37:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267867; cv=none; b=uwtxislIkQQFjqoJc79JGek8Lghb1B058vPBaYcnJj6F96g6x0T1iz4V/Vt0E1S0kknt+oM4r/RlUCUyYVWW/w8ZsNNf4P/fIRJoI/WAzVB22//O5hUb+LLM7Noe+0SDkv69zGnUT2B2AFL62LIinSYdixh/KPh5/Tl2K8m8+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267867; c=relaxed/simple;
	bh=GbPmf7RubxcF5Eit0mop28dEhZpRGBhq8W3ksmlFAI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyLBPSQzjj9wQ8QVn+BOwbhWuN6B3sKB24pGod1wN7Y6FSg0pY+2QKfBTNVM2GaooCb2nfEadC1bOsPAMEJ23rHrGFWQ8CKzgwsTpBgGucruevc4JYn3iEFchv7hC/8GLv4o+r6uGzuyW+Q2AT/ndphvxoIwMR7Evv9I9aU2FRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZFSF7TWc; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3637b90so7079485e9.3
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781267865; x=1781872665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1kaU2qJASgNCIGFShmTbzfOd7845sgronUE19/aoSI=;
        b=ZFSF7TWcTY9+SbJG1W+X3SkV3qR+aFTBfDdp2fjXefGU6SViU7W2cHHgO9CffrJF9w
         7WNjdiT6xWkmDXblPjWESVhhLFj/01P6CgDQOUnJx3vtxgOS291NafV8hJaAwCUCVPEE
         bgtpQ4/A8o3nD8ftoi+qrTkhWeVbMoNltZyIP7dO7f/eNoQon8x6K2z6ctqZ4VEm7qCw
         2EU+o1D+8OHIutzeBi0aXxoDYBcDS3RX4UOwwuhl1AvVjy6sH3Veqtf99QW8+WHn42wU
         9Ebe5a0Uenk76U7BkNTrLctDXr4VbXZrs6Me+OSSuLQLemcf7UpZXzmLPXwxx/H6Whcs
         02QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267865; x=1781872665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1kaU2qJASgNCIGFShmTbzfOd7845sgronUE19/aoSI=;
        b=YpqXLo7sJOJapZyGyKV2B5CCBTr0QNoz8b++SmYqSNFFpoz20V/NMlhS43ZrOEF7+X
         vfoWUZ2NzshTQX2mJ3xVRFTApNw8n8hYhY9Qs6uNeW9UPfVPln061Hlx8+mamQg/sDBy
         x5YDJTWlzVR4Cl+S2lCqSugJ/hPSJh8Pl/FoHwBvwXc+YI4Mkzx3jLFnkXIb4oDzlbmf
         JwY6TOPXPSfnJL4hEcAOBXJ4WggVkBSZKASyd+PHh6gX3bntVCoR0ODKb9xjbZmcf/Bc
         E9J3Nk9D6C1clerUMkq2UnFZpKKorssqDPb868BWDIkoIP/Epev7mgVaMeJHt4BpA8sF
         mPEA==
X-Gm-Message-State: AOJu0YyaNnrH3LDAjyV2x6hO/QykXkQWOeSiath/sY/+n/Jloe3FNIUX
	nWlIZZSok1+GsR1wSOuNGGv5Eq8MFlJQ1L30CkieRpr/ri6wDaMo+/HDJwT0blMUZl+Fwzg3YX9
	na3yi
X-Gm-Gg: Acq92OGB3ibPl2uwzF/AEuF9BzaJ7VlvBQHh6+0YvF45W4JTs4/1aLmecykPSem9wcO
	O8CEYbLnPRE1VNk1rRbDK1NVPjuuFV75t17CAR3t3kYxXAZSyuFujjvCRHr/Bskc/lfIzCXQFme
	peaF7jCGNdXo/QOZrrrw4oMa1qeL9ucyJIRA0wXaSDVhUDsCpjjX4jtS4Yoo2qqr/GgbhIqaTrT
	8MNUAb/yWqmEA4g6VSsGUKGs/ZUKCxI1lcfDMY8psFpVGt0ctmm8UxwVHhP9Kj6R75fHoQFOt7G
	wT4xhurYtXRZGO1wGz6x/a2EObykCjabjO3ZV91PfjNLNNdz2NIQJ7os2tXNZhCmjZRRfRZInjQ
	+9WAADqR5fSQRInDnY7Cchk9LMus0wkwuWJdCNhnlkwHppDJSggUOcL1ASAeDlhYXtt37wercsz
	L0SPI5LIOvd3HkEvnKttcGlD/sXxEbbw/8dlObUIpLgaxMgXzRs7Dg5p8A3xDxHJV3yyo=
X-Received: by 2002:a05:600c:4fc8:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-490ec5058d3mr34827835e9.33.1781267864675;
        Fri, 12 Jun 2026 05:37:44 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea84cc32sm59537585e9.15.2026.06.12.05.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:37:44 -0700 (PDT)
Message-ID: <49b9d617-f879-4694-8a2c-f28aff43ec2d@suse.com>
Date: Fri, 12 Jun 2026 14:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/60] scsi: qla2xxx: Enhance task management IOCB
 handling for 29xx series
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-36-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-36-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24870-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49771679635

On 6/12/26 11:53, Nilesh Javali wrote:
> Update qla24xx_tm_iocb() and __qla24xx_issue_tmf() to support the
> extended task management structure (tsk_mgmt_entry_ext) for 29xx
> adapters.
> 
> tsk_mgmt_entry_ext overlays tsk_mgmt_entry through control_flags
> (offsets 0-27 are byte-identical): entry_type, entry_count, handle,
> nport_handle, timeout, lun and control_flags sit at the same offsets
> and widths.  The layouts diverge only after that point:
> 
>    - the 24xx layout has port_id[3] + u8 vp_index;
>    - the ext layout has __le16 vp_index and no port_id.
> 
> Factor the common IOCB header writes through a single tsk_mgmt_entry *
> view and branch on IS_QLA29XX() only for the diverging port_id /
> vp_index assignments.  Change qla24xx_tm_iocb() to accept void *pkt
> to allow casting to either structure type.
> 
> Add tsk_ext member to the tsk_mgmt_cmd union and a BUILD_BUG_ON size
> check for the 128-byte extended structure.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_iocb.c | 31 ++++++++++++++++++++++---------
>   drivers/scsi/qla2xxx/qla_mbx.c  | 18 ++++++++++++++----
>   drivers/scsi/qla2xxx/qla_os.c   |  1 +
>   3 files changed, 37 insertions(+), 13 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

