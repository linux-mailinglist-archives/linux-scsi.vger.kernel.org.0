Return-Path: <linux-scsi+bounces-24819-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1jWK9XiK2ozHAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24819-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:43:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522C678C1C
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=bJNoHoYK;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24819-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24819-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A1D305114E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B7373BE9;
	Fri, 12 Jun 2026 10:43:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD3374187
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:43:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261006; cv=none; b=Z226iiEm5gIm5IM16Q2vLSbLCXW9lg32SranCoLlc/si1PGmpidj3x9oQog6Cc5pBr+kJAzaL7Is3UvaT+2ZvsCW1RdYg4qE1rv4L9AqfIx8kyLtylN+QLKG+obyYjz8u5WVoaGvP4t0UF8dKuBFhgFgfEiy04pz1O3WHLtMh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261006; c=relaxed/simple;
	bh=FaYvyCXZMb+e6mn2RZLrzSBTqQ8Y1l0EC8N3X1y1aj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWJtQqPutJGqR2vVhp98/2gsc6nEjazG+dCOUj1dGHh4WF/fWTVn8N/141NMA5ct6zZOZgd5qgPdoKSUQSFdWtHu2OkykS31TRjyd7p0PA54T3AG5Qvho0TbQ7ArZYmaZjqkvtQs6cC9ypkTGBpCKGIe1iOvo11byIIoS5atczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bJNoHoYK; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4905529b933so8236125e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781261001; x=1781865801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8dZQ7ChqkXtKaL0uOt+XpbZj0qTCmU7bqRo6csz44Q=;
        b=bJNoHoYKR5A/+5cZ9WmWTQ6bK6l+JjPwPBvQwKEMTxamnpfuY1rj991jGFZQSOhuxd
         cRdscpjzqkgNahrzfcAUJ2Cp3xqTvdA/jFKkCe9K7AuI6bmYu9duv+tOQVV5GLaXiKxs
         3kI+Tdsma6q9m4Rvy2fqKMPC5ok9gtiS6eWvkwKYJjByKtZSUWL3cfWH/8ab3ONsuF8U
         I3gTgjUSna76/mm9ESMFxi6NUt8WNenCGJIJUtZYZj2SJiCms+2/7fBOYTJUwmIeSRZZ
         vGDUO6fjW6N+tJC68KrTWrjlehVvACyHpovELV3t2d3C8pPmsz9YX/NpCMCOvG0SVD99
         SgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261001; x=1781865801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8dZQ7ChqkXtKaL0uOt+XpbZj0qTCmU7bqRo6csz44Q=;
        b=jAhck12yBWMXw8Nfo+kdtcx18LXIzuwuctSasLBAxCYquPeW36l2NHl0EBsfOMVqM9
         ZjNPGA6J26/InhdiynJQEcjYKLBH7GUKUCEFHcEsfNPdveSggyNsjDXzCuXyKhmY4oAa
         4l8b6aVe6OaDS1hXSsoXhj8wMVEs+I/H+0n0x3fdpdeu+ZYc8I7knJC5WFagGwTQ/NxB
         3FgYLVm5LSuN1Xt21HsEIHPzUHf3EEPSEEMuVqya3WTZ+ju/Z6egUjojXepEXY42X3vA
         r6hkTNEVek1zxyDqxIQd8r62O1Cq27SJZOUbbI5W9ICAC/vd91JlQbTLnau5OMqF4NPz
         rKxg==
X-Gm-Message-State: AOJu0YzKSBLe94fO6/ysQv0bkhERkV78dTm+MOrsxoAXDQkQDU331lC5
	EtmZbeYth8m0sIWOeSCKxVSSiJz5aM1k93finSKSYgojy5UbWBudBc83OKFvw/9nz+4=
X-Gm-Gg: Acq92OFsuXJYLNKIuKRIZLiFTs7yvLtZzoyKmAtiloxHMTKmKK7LgI3kJyYQ9cHWPn5
	NrghUioAWSmOL6jf+ZSEWpvadzPuD2dAhIRcCEfD+M/yr4YLEhFxSWkTORhM8IgpYhrYFK4Vi1G
	/HBkWtqykxTwtV4+/KV7/c0Udujow3AdO7kCf4bVd418fKduPa7WxK8T9bjr//7LWvXiBWuzPMr
	HSPOGICmWN8SVcDeXw1cjR77GQE6OFM1w9mFErmocxzpsLBrksTBm1dfMKrUbA+M4pygSiXVF5w
	e1tocKJtZrs2AfU1t7xvGVSmWmy2vQYzckoq4SBS+zJf0TFpmT0rflfb5D9zN8bNwIkBsHuN89B
	bWMB9IfU16QwfXNWipGtJMBgpKcpMQLfysdWnji9RCIRcWMinjvoeU9ttDFtuHUqPZ6LxhqEH2g
	ohy1m/xl1Fap3ufNSSZNYDOSK4anmzureoVplnk/AMPSPlXkvCw5745sN4
X-Received: by 2002:a05:600c:a0d:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490ec4e6ddfmr27471275e9.16.1781261001613;
        Fri, 12 Jun 2026 03:43:21 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm4932447f8f.3.2026.06.12.03.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 03:43:21 -0700 (PDT)
Message-ID: <9a41758c-2756-4eae-bf91-44533b5d86bf@suse.com>
Date: Fri, 12 Jun 2026 12:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/60] scsi: qla2xxx: Add flash read/write interface
 for 29xx
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-3-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-3-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24819-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1522C678C1C

On 6/12/26 11:52, Nilesh Javali wrote:
> From: Manish Rangankar <mrangankar@marvell.com>
> 
> The 29xx series uses a different flash access mechanism than
> earlier adapters.  Add the mailbox wrappers and qla_sup helpers
> needed for flash read and write operations, including the
> necessary hooks in isp_ops so that the existing flash
> infrastructure can drive the new hardware.
> 
> Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_def.h |  20 +
>   drivers/scsi/qla2xxx/qla_fw.h  |  54 +++
>   drivers/scsi/qla2xxx/qla_gbl.h |  15 +-
>   drivers/scsi/qla2xxx/qla_mbx.c | 144 +++++++
>   drivers/scsi/qla2xxx/qla_os.c  |  18 +-
>   drivers/scsi/qla2xxx/qla_sup.c | 661 ++++++++++++++++++++++++++++++++-
>   6 files changed, 905 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

