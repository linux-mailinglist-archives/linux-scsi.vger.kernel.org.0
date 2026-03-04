Return-Path: <linux-scsi+bounces-21405-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB3mLw4AqGnynAAAu9opvQ
	(envelope-from <linux-scsi+bounces-21405-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 10:49:02 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C771FDE06
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250F4302D528
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Mar 2026 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9A39D6F3;
	Wed,  4 Mar 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="WwI+vnV6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out30-76.freemail.mail.aliyun.com (out30-76.freemail.mail.aliyun.com [115.124.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D2390214;
	Wed,  4 Mar 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617423; cv=none; b=IqUb9X++bhSSsyjucHAG697Ov7hEm6Ga7FEt6xVbvodLUzYWVeAMdLmEsLE7hRIRTSVYfNlWGZm82BDWewBrjqCrwKQ/0/zk2lu0fpBkNhJ18mAsi40gvl7ZPzvdWgmn+vAO06chNJTN+LTzNntb0eH80O7NU+p041mfdtec/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617423; c=relaxed/simple;
	bh=oZlX3+22ZLyuC1Ack40OMHQ1E6dKLQwmWaRuhoEXjyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAC1UuO4uOSBPFVjvEIRq5tPc6We2v3AySyXOeVzIMTECgr0iHyWy8eEyPhBLTWkRtUkwavIDPJ/PEqPdG3cTXVRihZ6NzQtKiy+RUSEeY3tBcA/Rj5G2XE1NcIZZlzpPVtPt/V/9xCzu1U8pQF6UA1kOXb6LAT0G2rUPeuRr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=WwI+vnV6; arc=none smtp.client-ip=115.124.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772617419; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=3kUpOQOANoHXp/ZfrIsuYNvlu25k9cuYl7xItGwySRQ=;
	b=WwI+vnV6++h+fXZwFgLk+sCYKYzMKthn0vsdwBJtCEESGfeFWDJ1teKc+c7CfJr3PtHLCyGFK27gSpgLe6xV3gOEX+NcARqIHeMXtADN97vCIVQDh4ndqjFVg5QyTnFtkJGSjLXcHmBdo23Sb8BqviwxzkWUy03jO56G4GQtNWg=
Received: from VM-209-93-tencentos(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-Ec8fd_1772617413 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Mar 2026 17:43:38 +0800
Date: Wed, 4 Mar 2026 17:43:33 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: John Garry <john.g.garry@oracle.com>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	dlemoal@kernel.org, bvanassche@acm.org, hch@infradead.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: core: Fix async_scan race condition with
 READ_ONCE/WRITE_ONCE
Message-ID: <aaf+ucySU/sSN8WZ@VM-209-93-tencentos>
References: <20260304075712.3039960-1-wdhh6@aliyun.com>
 <2885ac50-2326-4548-b92c-c5ae566a8013@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2885ac50-2326-4548-b92c-c5ae566a8013@oracle.com>
X-Rspamd-Queue-Id: 29C771FDE06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21405-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wdhh6@aliyun.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[aliyun.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	FREEMAIL_FROM(0.00)[aliyun.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:20:25AM +0000, John Garry wrote:
> On 04/03/2026 07:57, Chaohai Chen wrote:
> > Previously, host_lock was used to prevent bit-set conflicts in async_scan,
> > but this approach introduced naked reads in some code paths.
> > 
> > Convert async_scan from a bitfield to a bool type to eliminate bit-level
> > conflicts entirely. Use READ_ONCE() and WRITE_ONCE() to ensure proper
> > memory ordering on Alpha and satisfy KCSAN requirements.
> 
> Is the shost->scan_mutex always held when shost->async_scan is read/written?
> 
Yes. In theory, there is no need for READ-ONCE/WRITE-ONCE. Plus, this belongs 
to defensive programming. And it indicates that this is a shared variable, 
which means that this variable will be accessed by multiple threads and 
concurrency issues need to be handled carefully.

