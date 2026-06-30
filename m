Return-Path: <linux-scsi+bounces-25378-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZvJaD38tRGpCqAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25378-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 22:56:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F76E7F49
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 22:56:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25378-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25378-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4423F302FAA1
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD134FF78;
	Tue, 30 Jun 2026 20:56:27 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9E47B42F
	for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 20:56:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852987; cv=none; b=F+sCC3INryK8sdRzh2peOCweH+bWQGMyG0bNp+j+T00uO9yx0kwEtikzmuFsOrzsqJP3YVvHiL8ZwNfZwkzWumEtHreZB5I3nFa/2ILht7k2MSrwb+BjU180apvvp95hrAD5Ll5ClFbqr3OMmbW93QObzuUvABdiAsx4HPDKS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852987; c=relaxed/simple;
	bh=dbTB6WdybpoMNFDCTL4oYCOYnIkl9ESxZtIweVBYMYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgMJwn9t9m+p3ge0d8JSHfCSiTa+GV3mWU9DWLs6vAFbs7IuLi36w6TGMGVk8pFy0X/22EYe4Rx107dWXSuIceBVJmJsytqUr+l/edr4+3dRZnI5xE7mx+4hTOFlmEdUZpWHUYNTAkJPYewafU6b43QaS+eaSKknyqgR7AOBvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 13EB0120123;
	Tue, 30 Jun 2026 20:56:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id ADB7F20010;
	Tue, 30 Jun 2026 20:56:12 +0000 (UTC)
Date: Tue, 30 Jun 2026 16:56:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <peter.wang@mediatek.com>
Cc: <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
 <avri.altman@wdc.com>, <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
 <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
 <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
 <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
 <jiajie.hao@mediatek.com>, <yi-fan.peng@mediatek.com>,
 <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>, <tun-yu.yu@mediatek.com>,
 <eddie.huang@mediatek.com>, <naomi.chu@mediatek.com>,
 <ed.tsai@mediatek.com>, <bvanassche@acm.org>
Subject: Re: [PATCH v3] ufs: core: add hba parameter to trace events
Message-ID: <20260630165612.3e21b510@gandalf.local.home>
In-Reply-To: <20250214083026.1177880-1-peter.wang@mediatek.com>
References: <20250214083026.1177880-1-peter.wang@mediatek.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a91khpzt41hbtwnya4hbwi8kk583ma9y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XEdqmnOvCJFHQSlGyLSrMbLdwtYz64Mc=
X-HE-Tag: 1782852972-403709
X-HE-Meta: U2FsdGVkX19O995+yYKSbgc0QBIAYiDlHJb3jzPWpqxs6nLjN/KhphKM9MNIf0B59sVXGhitkyRuCOZZfblmGLb1C+Vy/5NlfVrH3smBU7dll1wHsZN2xPGr57UJBPlvM9c3w3p9hrCYDMi4DhVfT2Zl/405SNem/bnTpsXWt2sX2N5mN7MviYhMMhG4aN0S27S58WxzY4JU9UB5He8ino+NJOG7M3UYun33+NhS+kwLMSXcjqelQ4HKyNlbIuwI+UQ5Bp0rt6fCeFwUU3oyaO6+PM85V9CygJv7o+sehy0rjzEOUwo2x1FsGH0evq6MFiGJgstE4ALxX+/zElQJv0k1V7KbHrm0G2el+6v/gCPeZ+0Di+H81A==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25378-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:peter.wang@mediatek.com,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:avri.altman@wdc.com,m:alim.akhtar@samsung.com,m:jejb@linux.ibm.com,m:wsd_upstream@mediatek.com,m:linux-mediatek@lists.infradead.org,m:chun-hung.wu@mediatek.com,m:alice.chao@mediatek.com,m:cc.chou@mediatek.com,m:chaotian.jing@mediatek.com,m:jiajie.hao@mediatek.com,m:yi-fan.peng@mediatek.com,m:qilin.tan@mediatek.com,m:lin.gui@mediatek.com,m:tun-yu.yu@mediatek.com,m:eddie.huang@mediatek.com,m:naomi.chu@mediatek.com,m:ed.tsai@mediatek.com,m:bvanassche@acm.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gandalf.local.home:mid,goodmis.org:from_mime,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 725F76E7F49

On Fri, 14 Feb 2025 16:29:36 +0800
<peter.wang@mediatek.com> wrote:

> From: Peter Wang <peter.wang@mediatek.com>
> 
> Included the ufs_hba structure as a parameter in various trace events
> to provide more context and improve debugging capabilities.
> Also remove dev_name which can replace by dev_name(hba->dev).
> 
> V3:
>  - Remove dev_name entry form TP_STRUCT__entry() to reduce the size.
> 


> V2:
>  - Remove dev_name and replace it with dev_name(hba->dev).

This patch needs to be reverted, as the above causes a bug.

> 
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> ---
>  drivers/ufs/core/ufs_trace.h | 135 ++++++++++++++++++-----------------
>  drivers/ufs/core/ufshcd.c    |  68 +++++++++---------
>  2 files changed, 103 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs_trace.h b/drivers/ufs/core/ufs_trace.h
> index 84deca2b841d..caa32e23ffa5 100644
> --- a/drivers/ufs/core/ufs_trace.h
> +++ b/drivers/ufs/core/ufs_trace.h
> @@ -83,34 +83,34 @@ UFS_CMD_TRACE_TSF_TYPES
>  
>  TRACE_EVENT(ufshcd_clk_gating,
>  
> -	TP_PROTO(const char *dev_name, int state),
> +	TP_PROTO(struct ufs_hba *hba, int state),
>  
> -	TP_ARGS(dev_name, state),
> +	TP_ARGS(hba, state),
>  
>  	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__field(struct ufs_hba *, hba)
>  		__field(int, state)
>  	),
>  
>  	TP_fast_assign(
> -		__assign_str(dev_name);
> +		__entry->hba = hba;
>  		__entry->state = state;
>  	),
>  
>  	TP_printk("%s: gating state changed to %s",
> -		__get_str(dev_name),
> +		dev_name(__entry->hba->dev),

NO YOU CAN NOT DO THIS!!!!

The TP_fast_assign() happens when the trace event occurs. That is, where
the trace_ufshcd_clk_gating() function is called.

The TP_printk() happens when a user reads the "trace" file. Which could be
seconds, minutes, hours, days, even months later! There is absolutely no
guarantee that the pointer to __entry->hba would be around. This would
cause a crash of the kernel when the "trace" file is read.

I'm adding a boot up test to cause code like this to trigger a warning when
the trace event is registered (how I found this bug):

  https://lore.kernel.org/all/20260630164439.51e61b71@gandalf.local.home/

>  		__print_symbolic(__entry->state, UFSCHD_CLK_GATING_STATES))
>  );

The same goes for the rest of this file.

-- Steve

