Return-Path: <linux-scsi+bounces-24865-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ClAHRT4K2oSIwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24865-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:14:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA667948F
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=DqVFgzbs;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24865-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24865-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98793008E20
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399E3B6C11;
	Fri, 12 Jun 2026 12:14:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C97368D73
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:14:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266449; cv=none; b=dPIztA1jMBmFW2/0d92Jnb6TgeB5ae1mpsUF7ZmdKqzjVLHYZOS7cVHYzsWpOYSisrj4foZYc/EqSsmtwf8HvpucG8FUdcc/5spoQKyplvd9iQUJHhHz+jXQscmYrfXTP1ls2KRj7iTAOPeaLBNSljQX+kS+72MuAbOv7OBBMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266449; c=relaxed/simple;
	bh=LOheufCcSmJ2BkOmPYustZuWfpDN0iFu5JTRSh+4GmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6geLaRHZD1sZ1yzI8bG9vZK8sU+YcyiArl9Yc/ETjpHKwO6OUIvBg8+wtCpYhTvima958QoxIxOM+6o8ONzrs8CenTk8NMzoIlW+VjrMa8MB0p2jUrjY0s39YCGQls3rJMf8v7+6dWsbzTbzZ0nkJS0A5im9Hh9TKHIjD7iQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DqVFgzbs; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cdae130cso4751425e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781266447; x=1781871247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI+yf8HoEMKT+hUdix9JhzXrvVzSKAqZkp5rHY5A2Ik=;
        b=DqVFgzbsT7Oyk1jLd7MAdMJbwsGot95CdEvGU7+c2plsj+CwbuHnoHCR7n3Fl9G1pR
         2CPvMcNChrpc8RUFX/OGHSv1mTUWynC3nqr4ZedozVu/hWnAyM+0q2kjU8UgstJEXgNy
         LczqfagTfmAFB0sLRyqnJWVMPw0TKio2HSZyQw3Bk1Eubxu1P10Scx4sTztX8bCalaVs
         HgVNUXj09earnjYxLlg3D04fdpfgwTXCNPOuEJEF9cRdG9nOCDZo3tdSpl3Wa/zsPudE
         C3HcIjqDSY6rGQbXsPOSiOjv6ThdZYm2ypEJN1aeD+P4N8Z29pdLRR0ZcK+/0t6BGhh3
         T/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781266447; x=1781871247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI+yf8HoEMKT+hUdix9JhzXrvVzSKAqZkp5rHY5A2Ik=;
        b=P/fA9ggPZ/J+EzKGT8LIfnSjvfttxEnsf4xG6FWT/aTS6+yzPc4Hr6aJ+t/5H91OCV
         Na4teZyWEEaNTnp8dl5ppDNiyRSvsze/VWzV6K1iFQR4Zk+ZkLymDxUQbmNcQnTXaGwV
         Aa0gZVn1b/g+zP21o8vP2Lc8Gj7r2sknbqpzn5ThjpOjjvJnfgosGyxTq1AVWD8Encbb
         68toZfUxr9v90ziJ9RfCyaRDHrztP4p+OgYRL0bS0ShHMON2KDPg4EMB9oW/U3tqP+wT
         EeXQ+UM0mlj/v+s5uVfLu/a56R4eNkDzpNmzjT/nxPcx5KOPBcy/YGMiYMGnwBXTYYwm
         y55w==
X-Gm-Message-State: AOJu0Yy5lRBHHwjvtsSOpj//8L5F4z6EH9SOqizg3pO5AhJWKJ1FdlKP
	tp/zIlAK1gY/ILYFrlCfRj5rBuXWwm0rhm4esuBSvkxlQLehhGkNh3GLZqIHPeh9Uco=
X-Gm-Gg: Acq92OEBRDRlw7DTgeUwmZfIuzdJvfserQRRmvD5i0ufDZQWFp0ubybe9ZRk2/es04E
	Ct9MOATAtcRy1OWvJtIPyMLMou89y4UbGrlMdMRpt4qkPGePNnjPRzWtjVI5Is2SqXzgoQSBJIg
	1arlke3qyH+L8oBTEzS6oIxiaaGuPyJ1tui+d1V1jLvSCY2M+2ZBJvK7WsO7mBJ1dqq6UAmugPU
	2Vkr2+XFdAnpJjzeqHMhcSQDN41fgl31/8f+1uqUYP8+Qzwiw4uu2UQcTThCSExy6PoTFm9BRnY
	7O87R85Ti3GFhY7JwDpRrKqZc610y4riFPv43fSQIMkFZZ0e/yRQEDgafqJQvAQTG9obNgHV/7A
	+ezdxk3t4fNGprAsyJQrPuCeJvQy7+/tQlsaHIAphR1185wS1X1g/vfydgyqAXAXct2GaIANHZ+
	qPiQjtZRpTBHa01u/SBfUYSqFi3+gZy2hUgHHsY1hH4gAlMdcJ/RK5u/5V
X-Received: by 2002:a05:600c:1d03:b0:490:ec86:ad4e with SMTP id 5b1f17b1804b1-490ec86bf8fmr30025925e9.31.1781266446698;
        Fri, 12 Jun 2026 05:14:06 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm65125325e9.0.2026.06.12.05.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:14:06 -0700 (PDT)
Message-ID: <b4f23690-8ac5-41b6-b66a-d02cdf045554@suse.com>
Date: Fri, 12 Jun 2026 14:14:05 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/60] scsi: qla2xxx: Enhance ct_entry_24xx_ext iocb
 handling for 29xx series
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-31-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-31-njavali@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-24865-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FFA667948F

On 6/12/26 11:53, Nilesh Javali wrote:
> Refine the handling of I/O control blocks (IOCBs) for the 29xx series
> by introducing support for the extended structure ct_entry_24xx_ext.
> Update function signatures to accept a generic pointer for IOCB packets,
> differentiating between standard and extended structures, and ensuring
> proper initialization and processing of command and response data.
> Additionally, the size check for the extended structure is added to
> maintain integrity.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_gs.c   | 156 ++++++++++++++++++++++++--------
>   drivers/scsi/qla2xxx/qla_iocb.c |  78 ++++++++++------
>   drivers/scsi/qla2xxx/qla_os.c   |   1 +
>   3 files changed, 168 insertions(+), 67 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

