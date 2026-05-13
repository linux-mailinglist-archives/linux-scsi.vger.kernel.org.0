Return-Path: <linux-scsi+bounces-23771-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPzGCp0wBGo/FAIAu9opvQ
	(envelope-from <linux-scsi+bounces-23771-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 10:04:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAE52F4C1
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97D2F300F289
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F536F91C;
	Wed, 13 May 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWzZd00R"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8D25B0AB
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659469; cv=none; b=E562qx4zgNrXJw+7uxp7SWkluXNgCrG5n5Snw+pNHmTSQntV6vcteX8/SAiP+GEVMIkPhRlC7swK2VfQJl/jey6yq7J4iAQy0Nz2zG8fPghL9V/n9oohe+rNmhlS9s6QbN/h5K4XeJlWJJJK9yKhJpN0qcNonSt52L7APTkRpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659469; c=relaxed/simple;
	bh=NQ6mQgTeAlE9mhVVS9WmfQabMkyRm87OA9PnambOJqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYjWNJMoYD9xbiFl/tKOLmCr0RlkJVxpjvXAPR0YHK2YZPN0lZp7RdBtVdOS7Hb07T2JXXo9P/QQHi+DX5D69hM+laQOMVgCUvTvfmVjXlZ2aatOg2raWixZwxW/XIatq3vQlfrqYIbSrgxLlBpbNlVsSGRVc2SfB0wI8jtF4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWzZd00R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BA3C2BCB7;
	Wed, 13 May 2026 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778659468;
	bh=NQ6mQgTeAlE9mhVVS9WmfQabMkyRm87OA9PnambOJqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tWzZd00RJbSrEQmGvEd4tx46AaIpGB4/TC22rwrN3FjMzF14P+Gi82g7FAMVmx73D
	 BCEC0BQopmoYgaGFjDIKN3eoHqqh5FLYRx34v+/6W34bMt8Ma6d2QA1H9V2xXaiQIC
	 oCwdA7VQKFKSEqoJX3d7qhB/EiCNjkwW5jPsIWj8E6e3UBS4v51oC4if3paGT03rBr
	 qONe/PBt01/CyM5iLpw5I2WKfgW/+ysrmYlYiWjlmhlmDYDqf31V8EgkyLg/wSUHuA
	 CZ75nWFbFov27UK/dni0mx/hOZTaFDU+XIO8E8k+ctWP34Go1+vaFmrSuyPg8PfES/
	 pQQp1+p2tPeGQ==
Message-ID: <cdc642dc-7396-4a73-b49a-dd98698f6785@kernel.org>
Date: Wed, 13 May 2026 17:04:26 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: core, target: Move three constants into
 <scsi/scsi_common.h>
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Brian Bunker <brian@purestorage.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20260512194634.58145-1-bvanassche@acm.org>
 <20260512194634.58145-2-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260512194634.58145-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B6CAE52F4C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23771-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SEM_FAIL(0.00)[104.64.211.4:query timed out];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[acm.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Action: no action

On 5/13/26 04:46, Bart Van Assche wrote:
> Prepare for using these constants in the SCSI core.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

