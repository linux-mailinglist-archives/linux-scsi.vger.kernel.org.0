Return-Path: <linux-scsi+bounces-25401-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sk7JEKS7RGoRzwoAu9opvQ
	(envelope-from <linux-scsi+bounces-25401-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 09:03:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897E6EA6D3
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 09:02:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Ar2o9mBx;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25401-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25401-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8FD30CE247
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C43B3BF2;
	Wed,  1 Jul 2026 06:58:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F043B2FCC
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 06:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889097; cv=none; b=J793PpN9PIjA/V8W4QUNs0sNw/dpPgZyT9rF+nTyVg00IVeclJAFSuZ9dqJouIxa/1IGoMAmSYJ4azpuUXxUsKO3Meq1dkMHRLbtURU9bx1c7jtlLJStjwHREtxI0YiAXPBnWJq5SePxlPeGcIRZfW4zo8zslgDxngHA+Xw6FK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889097; c=relaxed/simple;
	bh=r5m6bx+1S+UH9/Jug1ZvzJIVBVwid5Doa+5SlCgkwB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOnEUs/Y/RY5NFKLUhWE1Elplay+z6/kb6AqjvRBJDTkMIhtr+VClPbDKgytmUlgxpbH8ScsKr6dq87w0dn2RxyzaP+33eKTxMYD9z+EGAQ7+J2HzlzJRBCiSKxBx4513g/UaYltSJGi+EwqLswH77WXsEhsS5QJ2QO+ucNSask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ar2o9mBx; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45fd464d51fso110293f8f.3
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782889094; x=1783493894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM40CkIKzZOswsbi2LSbdjru0/A7oQAC4WYJATBuHvw=;
        b=Ar2o9mBxYp5gMqTnRq7etf2LP0scht+0GyyXIDK7mkABInc3j8qfZcXl81sH0hJNNB
         NNdDXEc280yQgDVTgKmHoC5tazl09unF/EF1arqknKOoW29eQY3F3J+IV0FoS1mhr0nV
         zQU7N99HBJvpp/0xioOVhSfmgFU02a1aZ0IMRt8WBMrfuiNIc+hh42Gc6Jyan0hKvqmZ
         Q/v0McgCgVDLh/YO+dRgL4mmF8+1wTIDt1Btvtut73YOvnAkxbn9b4M52NqiAjFiWDRp
         PpCt5ipsaIw7bya0p6/HfmJ0t9pF9tQFHrrDT2qIX+kENs9D26IBEkk9IO1ex1CfJzv6
         nh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889094; x=1783493894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uM40CkIKzZOswsbi2LSbdjru0/A7oQAC4WYJATBuHvw=;
        b=KeHOCa9ltFfXlr8DTNLSTTrFFm/A+DfjJhmm0EQ8FsCG729Do6/xAffXrj8iMFejWI
         XttweIPTcOyaGHJUXCKBInt8fsOsTYMwDrDkhzk5zqglXTxscDzsxAquJmHXevZG4cy7
         UI/mVTX2MS4MJStfE8SJXY/FGHC0jtrftFlOksLzAUP4Wds4tRQmZaL7VYoPNY9hbT9o
         anqjdFqDiARj4/f2fj6d05ME8BZFefogtBmXUlVcjyvcV408RvV7IppYBJJPoV1G5Y2E
         0HXgD0rXwMYn+6Pv8710JpDfhdetAgdEQb/gq9s5KaWTGWlLOFmRdN0C86OCpnr8L6mH
         41iA==
X-Forwarded-Encrypted: i=1; AHgh+Rqsb5Q0LifLHX3U5rtszNT+GPd90KYv1jdD8BE8r7exZpkVyOJyrSt9sOjWz5F4V5zUfbgrcyL3gVIB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ze6t7MGhFdMAb5prlXcGhIhQOXrLkbXprABJD1kwCSPsS6gP
	OHxOEeCPG7oUGbg8oeiVWYmc26oD+C6M57DAIViA4x8aoyYIVfxoFOlN/m2Al985JE4=
X-Gm-Gg: AfdE7cnSGX3yYq9CWoKzmHhah39FB9Ekr2sof66q2S3yyGK25f1MovNlhFl8W5VLexJ
	a7KPVk/jvKLH9nMjCxYXxgFnRWmnDPQwMVoG5hXgQ+lrBjxoSjRUJzejKFhmUFDd/PD++r0w1J8
	0x2QvL+BxM4MhgH3GUZMz203ZYtwR8+ZjXj5U1fTLgiV/+sr1YUzgdqLn8WZcnXNWZ3prZKXBAU
	XyUe1g6ed+a7357GW1d9IElb12HL3yDM45SrAu6ViytBI0PyPgVVu8nDUZL3stTTCviWzCTAC6j
	hYk4bBtaE6ApqiiNeiyLpJFpcIsuZiSp4vDPA8VZwIUGOJgIqoMzUhkBqKMTxs43o9hpVVONpBa
	CO3YJckLqTpm7HJSvom6WYOhRxwgu7vSqMZ8j9i4K/ddygguEyTNdBScZgXiDap7/RKS65BsG1X
	oWYCDu1WCPgBz/WBXqwoeru3LC6kJWXxI5Kzrq7h2Qhd2/h1k2+5yfOHS37Q==
X-Received: by 2002:a05:6000:230f:b0:46e:98a7:232b with SMTP id ffacd0b85a97d-477573bbc16mr566600f8f.10.1782889094328;
        Tue, 30 Jun 2026 23:58:14 -0700 (PDT)
Received: from ?IPV6:2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1? ([2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf1asm15708450f8f.18.2026.06.30.23.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:58:13 -0700 (PDT)
Message-ID: <1f9329e4-dbe2-4d46-8387-b3c7fc8faab0@suse.com>
Date: Wed, 1 Jul 2026 08:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: target: file: use kmalloc() to allocate
 temporary protection buffer
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
 <20260630-b4-scsi-v1-1-494fb37ebe7b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260630-b4-scsi-v1-1-494fb37ebe7b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25401-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:martin.petersen@oracle.com,m:brking@us.ibm.com,m:James.Bottomley@HansenPartnership.com,m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9897E6EA6D3

On 6/30/26 12:54 PM, Mike Rapoport (Microsoft) wrote:
> fd_do_prot_unmap() uses __get_free_page() to allocate a temporary buffer
> that is used to invalidate protection info for the unmapped region by
> filling with 0xff pattern.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/target/target_core_file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
> index 62ced9f5102f..ab9824a4852f 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -516,7 +516,7 @@ fd_do_prot_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
>   	void *buf;
>   	int rc;
>   
> -	buf = (void *)__get_free_page(GFP_KERNEL);
> +	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (!buf) {
>   		pr_err("Unable to allocate FILEIO prot buf\n");
>   		return -ENOMEM;
> @@ -524,7 +524,7 @@ fd_do_prot_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
>   
>   	rc = fd_do_prot_fill(cmd->se_dev, lba, nolb, buf, PAGE_SIZE);
>   
> -	free_page((unsigned long)buf);
> +	kfree(buf);
>   
>   	return rc;
>   }
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

