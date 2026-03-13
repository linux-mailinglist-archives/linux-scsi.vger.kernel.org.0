Return-Path: <linux-scsi+bounces-22007-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCkdMgyPtGnipwAAu9opvQ
	(envelope-from <linux-scsi+bounces-22007-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:26:20 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 483CB28A643
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 019B3304D1F7
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC73859C2;
	Fri, 13 Mar 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="buFbXKmA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA010332628;
	Fri, 13 Mar 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440777; cv=none; b=oVgAzKendffCcecDUDv0fK6XL/eZ7TdXRtJzl7yffKLhcolQpgwRbzW9Tyj6chD+AQMIruzJq/XO34A7rJvXxBi2mJWbjt2S7C7du3+6iFPIL48qS/yX5Yo9D2gsm716FQW8ffO6+Gx+nISlneLrnrvZoFopHL9gLsgTJa9+7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440777; c=relaxed/simple;
	bh=TvoJ6bEkjj462DmXw4KCwnluqAdmujleDO+4/s8CpW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBtptaLOFdivRC1EvzdKZ7yD4haWQwobsvmL8O/HMvPQgOosawFWPKb9vzwkgJiID2jKP5OHOWyIXUPLXylh71bvtnlYfF/W1HxGodyZ4FTaFR6n+YAxmY5gozJzH5itrjor3fixmkNd0FUCtu22N03NX89Db/qHF/K/EVODU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=buFbXKmA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fXfGJ1rYbzlh1Rc;
	Fri, 13 Mar 2026 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773440770; x=1776032771; bh=ne9C8Rle0F9AiAn/E03Dijlf
	fgy0NaTVop+QkwrkQ0s=; b=buFbXKmAsjlFhn2EysYGsONONCgVIAXHGYQY0etL
	Jn/ue9PXJaoPAtpNeuxug+x0ppdJdPw8RjqC9tZBcsYFgYc95rbX9p+KZJNdw3BO
	uRjqxZQtCJtJ7S2iG1ss/sYnfBBY/5kxiQCG11u1hSltloqWXB38LPjwB9m/50Tf
	bCesgrAanIUkNsGj3DLdE6IEhYFWdas9iJ4/4eXS0z380tW9cwPQuDIlHk5mSNSX
	Ja7qwjZnIsYf6pNJix5V+DEib23TJ5TYvbAmLFg3F0wFk/G7daqO/J1WytSiPeFe
	X9X4mTAkCgRcfQVTXFH0Lb868j+AF4C+cttyiE4Fakr8xQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4FI7S_zZXDIX; Fri, 13 Mar 2026 22:26:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fXfG74K1Vzlfftj;
	Fri, 13 Mar 2026 22:26:07 +0000 (UTC)
Message-ID: <edaac4ff-4d8d-498e-a38d-6474b9d39743@acm.org>
Date: Fri, 13 Mar 2026 15:26:06 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] scsi: ufs: core: Add helpers to pause and resume
 command processing
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Peter Wang <peter.wang@mediatek.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260308151409.3779137-1-can.guo@oss.qualcomm.com>
 <20260308151409.3779137-7-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260308151409.3779137-7-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22007-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 483CB28A643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/8/26 8:14 AM, Can Guo wrote:
> +/**
> + * ufshcd_pause_command_processing - Pause command processing
> + * @hba: per-adapter instance
> + * @timeout_us: timeout in microseconds to wait for pending commands to finish
> + *
> + * This function stops new command submissions and waits for existing commands
> + * to complete.
> + *
> + * Return: 0 on success, %-EBUSY if commands did not finish within @timeout_us.
> + * On failure, all acquired locks are released and the tagset is unquiesced.
> + */
> +int ufshcd_pause_command_processing(struct ufs_hba *hba, u64 timeout_us)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&hba->host->scan_mutex);
> +	blk_mq_quiesce_tagset(&hba->host->tag_set);
> +	down_write(&hba->clk_scaling_lock);
> +
> +	if (ufshcd_wait_for_pending_cmds(hba, timeout_us)) {
> +		ret = -EBUSY;
> +		up_write(&hba->clk_scaling_lock);
> +		blk_mq_unquiesce_tagset(&hba->host->tag_set);
> +		mutex_unlock(&hba->host->scan_mutex);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * ufshcd_resume_command_processing - Resume command processing
> + * @hba: per-adapter instance
> + *
> + * This function resumes command submissions.
> + */
> +void ufshcd_resume_command_processing(struct ufs_hba *hba)
> +{
> +	up_write(&hba->clk_scaling_lock);
> +	blk_mq_unquiesce_tagset(&hba->host->tag_set);
> +	mutex_unlock(&hba->host->scan_mutex);
> +}
> +

This patch duplicates existing code. Please integrate the following
changes in this patch:
- ufshcd_clock_scaling_prepare() calls
   ufshcd_pause_command_processing().
- ufshcd_clock_scaling_unprepare() calls
   ufshcd_resume_command_processing().

Thanks,

Bart.

