Return-Path: <linux-scsi+bounces-24873-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZPPVEkkALGpgJQQAu9opvQ
	(envelope-from <linux-scsi+bounces-24873-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:49:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA546797BF
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:49:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="d/owRLJC";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24873-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24873-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72EBE301832D
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45853DA5A5;
	Fri, 12 Jun 2026 12:45:09 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D023090C1
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:45:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268309; cv=none; b=boDuzxCO9Os5lUTQOH6G/jyisyshvBRSlPLO5AKORfOji0hhtBeZKlTbGwYjReZxeKke7T1so8KH+m8RQu6yEf8GKr6Svc8V46YsQIZm6l4yy0ONS+MNc+tS2ypIgac9bu/tY/aRsU1SS7h5k/GkbMyzzGCi3T/fFe1klFI9ulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268309; c=relaxed/simple;
	bh=2LGblJJhsCrSQuVnoYdBEnFebz7xdlMuRsS4Nv0ran8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lex2EDzEr3p21q13KPegvNqypYT6gmLS+sccW1y5OUFi/57TK/Xo1KU9P4spMMT3Gz8oL+JUGyWy4trCofkCmSPZC23D/UJuEX1luYKQpmNNgaEBtBHQ0RmoLIvAP7OOmy5blP8/XhpRPog8jNPIr7UxXla1IWz8uJM5ls9ypaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d/owRLJC; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso484965f8f.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781268306; x=1781873106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWYd9X8unsVCeUaMiXx6vclCeOYJMr/LtcvKZa0YmwA=;
        b=d/owRLJCH7/mQi4IGbnABvT3lmcDKKk6+mKZGLt8E4xRAIN/DqDKxd1jIN/Cic7ZDx
         SiQzhDmfgaMXCz3u3Tn+aPoGAHYPOxSqFSTLV5g4hLdK9/6zvWALU5GfNGPCY1YA+mXI
         zmPLzAUcWk3HJSp1UNlekcLWN1ZM6Qk3Ok1ixdDabNpD/ni1BjWJs1V/9exOIoTt/2Ii
         O2r0F/s5ouW3iVzUfnpwHY2ZUIfsWL/o2Jbk5DY/ktCZs34UgiPENeB+TwH5miJoAYu5
         oTeAC/6ybQ5bONXzr4V12CYmEy3/nR8zj1dSrVtBDMIhrreXIf2DRmfTkH1JDnKAt3Sb
         3F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268306; x=1781873106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWYd9X8unsVCeUaMiXx6vclCeOYJMr/LtcvKZa0YmwA=;
        b=MlNA97hSTonQxbs5NphYTBMbJE+AvBIULYY1iyB/wXWGvncIdiXiw9BAcvhDRwOZbz
         s7QvK9Y9oXJGzPcmB4wOqYHWeiiBDXZawuIANdlbl8MafhqK/QnAl5V8cbf3n9L034fZ
         96kj6Ka1MoYXuCjGgDCAYWHg0T5SDi+VfaxKRNlpvQ1kO4+AzS4TN1e1Fu49468fElFX
         UtTOJ/82GsffsLE+JhZYIUEgoKSkN9BeFECPRzri3/q5AkFHHxQxn7IHCbUladf4B79Z
         s6YcRunWVyZfgEYTz2/mGgHgaGN8c9t34+7wgHWJahJLEGguGBLEjNxuJhDiPYGmccXu
         iY0w==
X-Gm-Message-State: AOJu0YxPSNzBLMtOLCRfk7GLkGAjIeOafg5LPC3BRoqXx7ou5b2lv6pA
	AxfbnRC0uMw6lUok94nO65HNdV3Ag2m4y4ME9K9vFBbnmX/rZ2nC34zvjvYkXieVsfw=
X-Gm-Gg: Acq92OEJeSyq1G2uD6Y3zOKujbDyOSXFQqtlu0sGIJshpMu32cE1XxMkzQVBv3eMeSR
	b7Tz6YJv8H9WtdzXgdhspp7qX4U/B8vHBn24ejTN8K+/PlDL6ybzZ7DRlYYAyMgV8cPrsl0qfnG
	fVf/WHh64tiBtX/rX0fkicoRi+peZiafYhmqOHVp+7HkNpTIuthhJI5JQX8Vyxye1pnfn1MQOZA
	S6Kpb1KEDBp95M+Efh+5zvBbBwkf2SfSWaJKEqE14GlFLPoUC5rw3bKGEMpmsvQj+VPTyBGfrEv
	tN6KQ56q3opl66Doxp1NRUGRX2hGECE5dM3/OwJTfXWxM3YoqtIe2Je3Y53jH3eaC8f8kw1wD50
	H0lF5xDHFGRrn/hUz699GGZNe3FeR7L0Qkm+kiuTxbhu6aaEktC7++44N4pxEKbst/88gIU7wcX
	mNxbU+MPKoJb/p3R7XBPuMOvJbjRXPE1Y4+kIdnn4M9fE1XmtACkHVB4je
X-Received: by 2002:a05:6000:2087:b0:45e:ee50:d066 with SMTP id ffacd0b85a97d-4606da57193mr4151671f8f.6.1781268306360;
        Fri, 12 Jun 2026 05:45:06 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm5577038f8f.30.2026.06.12.05.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:45:06 -0700 (PDT)
Message-ID: <afa9a9ba-8462-49fc-9309-a873f484ce28@suse.com>
Date: Fri, 12 Jun 2026 14:45:05 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/60] scsi: qla2xxx: Update VP control IOCB handling
 for 29xx series
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-39-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-39-njavali@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-24873-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EA546797BF

On 6/12/26 11:53, Nilesh Javali wrote:
> Update VP control IOCB command and response handling to support the
> 29xx series adapters, which use the 128-byte vp_ctrl_entry_24xx_ext
> layout.
> 
> Change the qla25xx_ctrlvp_iocb() and qla_ctrlvp_completed() function
> signatures from typed struct pointers to void *, since callers already
> pass a generic ring-slot pointer.  Both the standard 64-byte
> vp_ctrl_entry_24xx and the 128-byte vp_ctrl_entry_24xx_ext are
> layout-identical for every field touched in these helpers (entry_type,
> handle, entry_count, command, vp_count, vp_idx_map, entry_status,
> comp_status, vp_idx_failed), so a single struct vp_ctrl_entry_24xx *
> view handles both adapter families without an IS_QLA29XX() branch.
> 
> Add a BUILD_BUG_ON size check for the extended structure.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_iocb.c | 23 ++++++++++++++++-------
>   drivers/scsi/qla2xxx/qla_isr.c  | 13 +++++++++----
>   drivers/scsi/qla2xxx/qla_os.c   |  1 +
>   3 files changed, 26 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

