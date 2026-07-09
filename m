Return-Path: <linux-scsi+bounces-25932-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RFsbIkDcT2olpQIAu9opvQ
	(envelope-from <linux-scsi+bounces-25932-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 19:37:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2346733DCD
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 19:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=X1uFHFxt;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25932-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25932-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF3B304305E
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059D4D9900;
	Thu,  9 Jul 2026 17:37:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFD4D990C
	for <linux-scsi@vger.kernel.org>; Thu,  9 Jul 2026 17:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618622; cv=none; b=cQ115sTbkMgLysKmJKHpY1Ur2LM+U8JjRhFCDdvMGol8rsFrACzps2CsuyhOrZrlaeaRnw7km8jgYjtokBtMKNQbceLB6IvH9r0+TJHk+R/uHtA8/u3STpRevM8vG1SMidkgz40K5iN/wqF+1UkbEmJx7xm4vQT1aijg/zHVJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618622; c=relaxed/simple;
	bh=AMWaGRmKSfCxL0tgNPNGGOAUuljK757M7jjYG6cQdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZjK2dt6ydp62dYFw4sLRSOpcbQpnnPWTVjRAY9flCV1WE7LxYsKRfjR28OhT0leqO5yXwsD2HlBFlSwelpGa/MYTt8AuKt+2KeKXI9wptEKZd0/rEOCugXrW+/ZG1Q1hvgON+2E803o+oGTtAFjakgTQlbqUcluSBBm6SsaWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1uFHFxt; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cb59f6ba26so5855ad.0
        for <linux-scsi@vger.kernel.org>; Thu, 09 Jul 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783618620; x=1784223420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2MP1VcZ+pxNnebvnEoAeY6zE9OtvqI5FLv0zCgNS0M4=;
        b=X1uFHFxtpMl4BkZ1bnb4eRl1vD3D7ZcAtiSb+eVQEENMDgVp6bpvI4RXzDChOePjvL
         kWKG5j+7P2ArKO3Jjvl+bZZHTJ2cuOjUtAszY5Uu/BtXf/7D5JPJ67Ge1ODYSKSe98kM
         ElqVqVn1r5KAjwxvwgXtKtRtb721d6t69BkUvdn/ueS/4yuTX9eA4y8r98nCymv3n/s3
         3um3grSK1bwaUU0G3Rr/bRuf2eagyTaYRoZLOWPHAWZTL9ign0yBVN7n4zsYGGaA0i3A
         TIm0afPnMHIRzhnqi8cUQp93qAlEFVX+T68mlHgd8R6AkL1dzu0NsCZ4ljOnt841fISf
         ch/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618620; x=1784223420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MP1VcZ+pxNnebvnEoAeY6zE9OtvqI5FLv0zCgNS0M4=;
        b=YYUNnJt+tHKskhZ5rcCbeYL6jEatxYPw5mtNHXDwPHeIiOdncKMnByAVabfodiATlK
         5rvzYMiV1vhdbgMzseKPz5OdNPtDf5VXTa0z2sfWSUIlVKboiFacG2BBxrxIaVIsUGI2
         6wjue9DLUTstZrf4q7Ij661eZlxoCg7t8aQD9UoLZ3o7tfvrM6f5+nIo0WlxDZcksICJ
         jWmiLXk8G1EOw8uNUYNHgpXnMy+MDMxqKfs6e0pHy83CQcjZzSSGI78yEkXXArEBY4ze
         m4UbCgxaeCCCRNT/7mPW4RoQwOdqgLmDBHpsVUPfKGi3pfhgixlZJlZHS6dx5jUwJ2FO
         yMsw==
X-Forwarded-Encrypted: i=1; AHgh+RoCtrqniprw5/NGPvcE/qZVzdgTSBJHKtC6J7EhY5vXVAe+1XmQql+0JetHrnghsp8SVjcuB2Nkdpt2@vger.kernel.org
X-Gm-Message-State: AOJu0YysrzyYUJHgicxhz8T2ACFiQawtPKmahpqL4NQyM/UQma7U3lfT
	4kF4wcb693ysS5da2QQiq+TF7LkVbf+XBD8g5M6qm45uGt3HtZ58IAytsz+alg7HYQ==
X-Gm-Gg: AfdE7cmPCg1TKeMlPhZJdksloOyVCub2YWUdN3h9X29pPCyNTYcPXplrmrc+IoExHAW
	Tw46UMlhVaCKEaWtb9FEv0h/vZ4YzWJIXMRRVWuDQPR2ZRjICxUcq6kkfiTtEWI5jSrFH2WOSuY
	Nc937voP2C5gro2xyMHiXm2Hhn40g21xwEyg+bkPNNtZ4wpER4Mj7iEyvXVexS4B/+QQDRd41Qa
	VuIHXmRRqoKiThQlazm1VT4ktSMo2Oa4R+duE2L5AD969PQUMQziVj/d8r/5dPdWEzr7SD/m+o1
	0fY+wbobWrYy3uDIwY5U4a3ZbZ4bz5vwlwraCxHRM79ahljw5OfIrWkqMOJeC45vLMoNV++htK3
	h8JIOb4bBBYxYNla1oonrKEhvcrdz1+vocLP9FgphNCqNh44SFy+nAaC9USZF5QIOqkbgRVXtp1
	ShIF1sP5Q/HTC8jIW1868jyxN2CEDtwYQLfAREEAPn83reFPQmmGM=
X-Received: by 2002:a17:902:ec8c:b0:2cc:a859:d404 with SMTP id d9443c01a7336-2ce82e994acmr141705ad.23.1783618619000;
        Thu, 09 Jul 2026 10:36:59 -0700 (PDT)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d11c83112sm70723a91.0.2026.07.09.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:36:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:36:55 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v1 0/2] fixup handling of timeouts with deferred QCs
Message-ID: <ak_cNxd_Kow0lWoe@google.com>
References: <20260709083934.1116862-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709083934.1116862-1-dlemoal@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-25932-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ipylypiv@google.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ipylypiv@google.com,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2346733DCD

On Thu, Jul 09, 2026 at 05:39:32PM +0900, Damien Le Moal wrote:
> This patch series fixes libata and libsas to correctly handles deferred
> queued commands in case of a timeout error, to avoid excessive delays in
> waking up the scsi EH task.
> 
> Igor,
> 
> Please retest !

Looks good! Thank you, Damien!

Tested-by: Igor Pylypiv <ipylypiv@google.com>

> 
> Martin,
> 
> Once reviewed, I or you can take both patches ?
> 
> Damien Le Moal (2):
>   ata: libata-scsi: terminate deferred commands on time out
>   scsi: libsas: terminate deferred commands on time out
> 
>  drivers/ata/libata-eh.c             |  2 +-
>  drivers/ata/libata-scsi.c           | 54 +++++++++++++++++++++++++----
>  drivers/ata/libata.h                |  3 +-
>  drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++
>  include/linux/libata.h              |  4 +++
>  include/scsi/libsas.h               |  2 ++
>  6 files changed, 73 insertions(+), 9 deletions(-)
> 
> -- 
> 2.55.0
> 

