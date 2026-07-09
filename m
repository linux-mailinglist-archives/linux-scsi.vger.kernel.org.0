Return-Path: <linux-scsi+bounces-25927-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GF9CIo5mT2oLgAIAu9opvQ
	(envelope-from <linux-scsi+bounces-25927-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 11:14:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DA72EC71
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 11:14:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WTybV0xP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25927-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25927-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDE173045C8D
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F73FE650;
	Thu,  9 Jul 2026 09:14:12 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9833F9A1B;
	Thu,  9 Jul 2026 09:14:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588452; cv=none; b=N/u8xMhrKH3nwI+wIaFC6IskswpEb8RO1ncxG5LaQDBTxz6QWBVN12hUZE5TdjwR3wM1Lt1mt7bIflTevngepWgywH1tFoqrAGhKeK+LKHCp5eR+3J9oMzHxFSDdF8fvcvaO5TPjmgvcS7VdWXKZT8zGGkpKdSX+Ertblg7joHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588452; c=relaxed/simple;
	bh=Qrjsa6kNlgtqbcszSbWTM/A2+j5SwnmvBesi2KThD6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFeTdUBl49vcIa7gdCoDm2X0YWiGhcsTTgc0tkM36xz6pzFVm2OFuV6F1EUBu/bT5IzlA/PeuYJRHgqd/oL9cLrbNOX3nuxA5OZ4g+Z9KIXAaSTFZMgMFdyhh3k6d+rIOB8abIFlBtSyuvh+T4QZGQVKrGcszJzJ0s3M1kqBxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTybV0xP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3279B1F000E9;
	Thu,  9 Jul 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588450;
	bh=oacrnyBrpn2K0Y0NRU9kj42nB0krZasHrT3apgcYHzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WTybV0xPYemqWJLocPgwRv1n2vVlWP64G4ERSiMpVBxCvISv8trKSvfeXj4UeqjH2
	 eEl2QR5wHoURSrIq6GQZRCZZ3WT+hakTpPRj9ZTa9BO4C/Ge+1ggD4md58CC5xAQA9
	 dAxXkagHW/OMVtpHyVnEhwsYZDzjD8UtJNSRQsq5fg0mKD4TMk86pfvxMr/9bnKZQG
	 y7nwFfDzl/INI/KMtTu2rE+Pwb1aeFF6N3xCx/U9NKtVpLsNXNeKOUYYEmD6BUiqsr
	 t1sea7mq4pZ/t5bIacLwpeeq096EP9aOShJC85Gh/uaryDUwzDFF+le2YHRCRXlb7v
	 fOiwg9do66Keg==
Message-ID: <dcc4f558-7b6e-4193-a943-036255fc202f@kernel.org>
Date: Thu, 9 Jul 2026 18:14:08 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ata: libata-scsi: terminate deferred commands on
 time out
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, cassel@kernel.org
References: <20260709083934.1116862-1-dlemoal@kernel.org>
 <20260709083934.1116862-2-dlemoal@kernel.org>
 <20260709090006.F317F1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260709090006.F317F1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25927-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:cassel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 093DA72EC71

On 7/9/26 18:00, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does calling ata_scsi_qc_done() here prematurely complete the timed-out
> deferred command and free the libata qc?

Yes it does. But unless it is the deferred QC that suffered the timeout, the
scsi command will be requeued and retried.

> When a deferred command times out, ata_scsi_eh_timed_out() calls this function
> which sets the host byte to DID_TIME_OUT and calls ata_scsi_qc_done().
> ata_scsi_qc_done() then frees the qc and invokes the qc->scsidone callback.
> 
> Later, when the SCSI completion softirq routes the DID_TIME_OUT command to the
> EH queue and the EH thread runs ata_scsi_cmd_error_handler():
> 
> drivers/ata/libata-eh.c:ata_scsi_cmd_error_handler() {
>     ...
>     set_host_byte(scmd, DID_OK);
>     ata_qc_for_each_raw(ap, qc, i) {
>         if (qc->scsicmd != scmd)
>             continue;
>         if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
>             qc == qc->dev->link->deferred_qc)
>             break;
>     }
>     ...
> }
> 
> Because the qc was already freed, the ATA_QCFLAG_ACTIVE flag is cleared
> and deferred_qc is NULL. The loop will fail to find the active command.
> 
> It seems this causes the handler to fall into the 'raced completion' branch:
> 
> drivers/ata/libata-eh.c:ata_scsi_cmd_error_handler() {
>     ...
>     } else {
>         /* Normal completion occurred after
>          * SCSI timeout but before this point.
>          * Successfully complete it.
>          */
>         scmd->retries = scmd->allowed;
>         scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>     }
>     ...
> }

And after this, scsi_eh_flush_done_q() will retry the command.
Tested and I do not see failure of the deferred QC :)


-- 
Damien Le Moal
Western Digital Research

