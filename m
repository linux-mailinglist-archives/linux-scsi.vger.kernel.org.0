Return-Path: <linux-scsi+bounces-24886-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3czCKugDLGqhJgQAu9opvQ
	(envelope-from <linux-scsi+bounces-24886-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:04:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4146799C9
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=FpYv9C40;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24886-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24886-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3373630221E3
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749737BE83;
	Fri, 12 Jun 2026 13:04:36 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AF37D104
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 13:04:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269476; cv=none; b=h3kILHqn8/X5EKxxbjaNNu5Suo/90IHDI8hcGuk6xje5UhWOOp6wUTTYA0tzOKKlTGyC+EPr6CzxpyRdIlG6z6teuePU18rN56oEX0gmFKVHMV337KlIx5lvCe1OvRfld4goiCQzCvldy1Rt21nZQFbObjKMy+LOx5hJXAsty8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269476; c=relaxed/simple;
	bh=trvIFQDxjnx5yhNQiFPf838h1bXUxWXfdh/hop0dymM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5smsaf2Ii60Gy0WMRhR4/oZVJcbXJAZanQoar0e0XAz9kgzNrmuObdoldluh+xQcBEig85YZqqK1DrEApquTojcJF65nxv9dx/3D4jurSkay0GNzpHlgobXLjGMmEKdBoQ/mUozJ+E+qWPyBbkoEuhtn42kPlx4eG40uAd8zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FpYv9C40; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso8753975e9.3
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269471; x=1781874271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75tOISUMOt4SIaXJrlETJ/JtaKpwbrnqeX5thUczVpo=;
        b=FpYv9C40w+IQ3lWzGeB6KjuHMsJ2SbS7lDutvyuJtOnYU2AaGE0Xmr+9NPRBwF0GZW
         zZFA4LzgbE8O6qh6VYKxNfMD24l0wzhC0stbaxmb8zaRjdOfmk9goZozmU8gi6bEfQ5n
         /o6l/Etn+GwufniyZ0m1ZWk/klGunJ3f9atzker3kU8eX8IVqjKGOcqQiLJ7IcGnANwX
         sxXNI0m3nSrk2mHgAQi4KcILPAVhl/hIrnsyNsS7VcwBuCiB5niGKlAxvzGnQxMce9aV
         jqWu9To9htfH87e6ESTeNsa5QqgvsGXigM3JYxeyX1XZZ4OVOJxaMXCFa8oHSjgmtiLm
         3H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269471; x=1781874271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75tOISUMOt4SIaXJrlETJ/JtaKpwbrnqeX5thUczVpo=;
        b=sUeuqjmgyUEg8vGeRQIyGBDNEu+vOFoHm06fhgDgMZ6Do2xW20oQ2cQ4sKCNgwMCPt
         XqFIlwC7sgaPl0BAQtgkLfhcuimeZdFzbmpIwYyR1ibH3RbzpKxDDa2Ye9HsygETgUHN
         JhPPYt7Og9n+zk7ZvFy9hWKozkWIcxcwr+j+EgbOl9MWKWKn2IMaU9Gg2HQ8yP0WYrG9
         v1Ehw6krKtUcrs3MtLNGturNct9OTTGBeFNoaVgIHUtqpkN68iwuzEPk9z/HdabymLt/
         J/yb8k/VfclyvumtnrfvevRLfSRTu1IxvOr8RQapGDPmjr3bxEl4DocTNdaXLGOIPu/U
         cNXw==
X-Gm-Message-State: AOJu0YzNpcEfvzVKxbQ43TtU7ZqkkDvgAOGZcZqik/78pi957jF+J2im
	AraMyaJEJ3V1XsOxb+eHlCYU96OzBP9fYWG4ftuu/ebW+LHwpY0dUvask1FhBNd7Oag=
X-Gm-Gg: Acq92OFMA+8CZkhm7h2d1AFFI3HzXHhZRJ7zKy81BSQuflrEWb6o9+y0OgsgVqcD/p9
	u0BRJzeixVMakoM+GgaYJG4wF3iYIMMgEMvnBH+x25DaAOT4fE6/MsB9GHfFWexYWku4opnT44A
	dBJSD5ijwIEVtg0tz6kj2IaP2EhfGpASob/xRu2upA/yisZeY1mQCMLk/LVGg1vD6n7YSE9i8Aw
	RgnYAy3GKODxSTpK+qhCPhgUTTUgfHipAtxwD3FbDlvLs8vzDqIN2ydFq2p/yJ1WGXNmHU2SRw2
	oVEMKbaeiBj4Piqikn8ESzdx2xs8DuFlarx7+Q64dvjuuu6zKNTcpZr5RdePjmTExD5zLHKEbeD
	/YvHoJJH0u0XWQNoDr8lZs9tMvLvuwn/8lzH5p5hwWqmX9WRmT67bNGD1Dp5lCu6J1YzmoHrtP6
	nhQxTMQxm++U9J1aY4v4oOsshX1CgonJjXCaxVOKDf7Vpw21UWt8SR3S/T
X-Received: by 2002:a05:600c:3105:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-490ec4b5a3cmr39289745e9.7.1781269470854;
        Fri, 12 Jun 2026 06:04:30 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c0d360sm169215885e9.0.2026.06.12.06.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:04:30 -0700 (PDT)
Message-ID: <99864d0b-f376-46da-9700-d476440c0a01@suse.com>
Date: Fri, 12 Jun 2026 15:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 51/60] scsi: qla2xxx: edif: Fix NULL pointer deref in
 RX SA delete check
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-52-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-52-njavali@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-24886-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D4146799C9

On 6/12/26 11:53, Nilesh Javali wrote:
> qla_chk_edif_rx_sa_delete_pending() obtains the SCSI command via
> GET_CMD_SP(sp) and immediately dereferences cmd->sc_data_direction.
> That command pointer can be NULL: the firmware may post a status
> completion for a command that has already been returned or aborted.
> The caller qla2x00_status_entry() acknowledges this on the very same
> status path, re-fetching GET_CMD_SP(sp) and bailing out with the
> "Command already returned" message when it is NULL -- but that check
> runs only after qla_chk_edif_rx_sa_delete_pending() has already
> dereferenced the pointer, so a NULL cmd crashes the kernel in
> interrupt context.
> 
> Return early when cmd is NULL, before touching cmd->sc_data_direction.
> 
> Fixes: dd30706e73b7 ("scsi: qla2xxx: edif: Add key update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_edif.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
> index f8bc248e5d18..c8889ea199d3 100644
> --- a/drivers/scsi/qla2xxx/qla_edif.c
> +++ b/drivers/scsi/qla2xxx/qla_edif.c
> @@ -3543,6 +3543,9 @@ void qla_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha,
>   	uint32_t handle;
>   	uint16_t sa_index;
>   
> +	if (!cmd)
> +		return;
> +
>   	handle = (uint32_t)LSW(sts24->handle);
>   
>   	/* find out if this status iosb is for a scsi read */

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

