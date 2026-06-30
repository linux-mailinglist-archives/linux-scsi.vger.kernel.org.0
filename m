Return-Path: <linux-scsi+bounces-25389-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Bi3IkxKRGpHsAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25389-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 00:59:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799F6E88B0
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 00:59:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25389-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25389-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 920623010230
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A878330B07;
	Tue, 30 Jun 2026 22:59:12 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5532FA2E;
	Tue, 30 Jun 2026 22:59:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860352; cv=none; b=ASdNL7OjFFTdUtdXNZe74ZOVolKSAK0kz+UFKaZcBSbPSahAr3tjikhbjJFlcI2AfDh9rvzZoRe3WnlnmAtYSDY8AJut64Z0DyLlcEhTlNc7GIh1THA2lPZj/EkHF4m4kWfWXqMZ6qtsDJamT7IVAV2Gq2asMurbvylTZ+CIIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860352; c=relaxed/simple;
	bh=7Wguo1ZUvqbxvXsicL8g03KZwVIjlp+iRC2iuUcRVlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3p9019VQsw2domdNOkVVD0fL2ZRdxoqb4QiCavR9Qnk9VEW4gQqIPOkwVoO1txlRFKE4h5RWJO8MH+x537JHgKyD6PhhhOUVoKtGB65IdkYaLcvgsWCmKCCvVT2U531HjADqKc2yzIFCUE49pR8E03wGULAL+WWy+s9PbuOlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1064AC077A;
	Tue, 30 Jun 2026 22:59:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 664BF30;
	Tue, 30 Jun 2026 22:58:57 +0000 (UTC)
Date: Tue, 30 Jun 2026 18:58:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@wdc.com, alim.akhtar@samsung.com,
 jejb@linux.ibm.com, sutoshd@codeaurora.org, wsd_upstream@mediatek.com,
 linux-mediatek@lists.infradead.org, chun-hung.wu@mediatek.com,
 alice.chao@mediatek.com, cc.chou@mediatek.com, chaotian.jing@mediatek.com,
 jiajie.hao@mediatek.com, yi-fan.peng@mediatek.com, qilin.tan@mediatek.com,
 lin.gui@mediatek.com, tun-yu.yu@mediatek.com, eddie.huang@mediatek.com,
 naomi.chu@mediatek.com, ed.tsai@mediatek.com, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ufs: core: add hba parameter to trace events
Message-ID: <20260630185857.54c55d97@gandalf.local.home>
In-Reply-To: <16f26ea9-69d6-4f2f-9adc-c576c288a2f5@acm.org>
References: <20250213113707.955255-1-peter.wang@mediatek.com>
	<16f26ea9-69d6-4f2f-9adc-c576c288a2f5@acm.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uwehtoqqednqhf3zyo5jct5fcbfkhzr8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/neeUCV/R9KHhr+SS3nL47b2vY2VzQvkE=
X-HE-Tag: 1782860337-648722
X-HE-Meta: U2FsdGVkX19nYBCqwu9Ixhtn09ay8RBzQ10D02bQ6sj9JfNDHi+XUt/BVZ4gGAaXgyyFLsjh8lbrwf4x+RJUcsbgjLoQE+pFkRBoKhPWJonoTwg32+oRA1Y1xvdg4Em/A6mEJW5v6irtqUi3xX04bR0xjgdImMU3GChz6lRzZlbQjRZgzPmzbJRVi1MhHvAAn0d+3nM7OKrXU0ggWrQ4X3YT7vqhxODo/OFhNtsUStSPx97/RBhxC340pR2yjuNo0ObTldNO+0gp2B05+BunahPio2cMJcm0ZCt9ASPRpbaPnS2jeDiNFb8ZTLXet79cxCGTvH5+zIBllavd2ZRAM1TtlB9R5pfMugudoQQQ8tik9aTC7JvqKQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25389-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:peter.wang@mediatek.com,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:avri.altman@wdc.com,m:alim.akhtar@samsung.com,m:jejb@linux.ibm.com,m:sutoshd@codeaurora.org,m:wsd_upstream@mediatek.com,m:linux-mediatek@lists.infradead.org,m:chun-hung.wu@mediatek.com,m:alice.chao@mediatek.com,m:cc.chou@mediatek.com,m:chaotian.jing@mediatek.com,m:jiajie.hao@mediatek.com,m:yi-fan.peng@mediatek.com,m:qilin.tan@mediatek.com,m:lin.gui@mediatek.com,m:tun-yu.yu@mediatek.com,m:eddie.huang@mediatek.com,m:naomi.chu@mediatek.com,m:ed.tsai@mediatek.com,m:linux-trace-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,goodmis.org:from_mime,acm.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mediatek.com:email,gandalf.local.home:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7799F6E88B0

On Thu, 13 Feb 2025 09:19:42 -0800
Bart Van Assche <bvanassche@acm.org> wrote:

> On 2/13/25 3:35 AM, peter.wang@mediatek.com wrote:
> > diff --git a/drivers/ufs/core/ufs_trace.h b/drivers/ufs/core/ufs_trace.h
> > index 84deca2b841d..2f79982846b6 100644
> > --- a/drivers/ufs/core/ufs_trace.h
> > +++ b/drivers/ufs/core/ufs_trace.h
> > @@ -83,16 +83,18 @@ UFS_CMD_TRACE_TSF_TYPES
> >   
> >   TRACE_EVENT(ufshcd_clk_gating,
> >   
> > -	TP_PROTO(const char *dev_name, int state),
> > +	TP_PROTO(struct ufs_hba *hba, int state),
> >   
> > -	TP_ARGS(dev_name, state),
> > +	TP_ARGS(hba, state),
> >   
> >   	TP_STRUCT__entry(
> > -		__string(dev_name, dev_name)
> > +		__field(struct ufs_hba *, hba)
> > +		__string(dev_name, dev_name(hba->dev))
> >   		__field(int, state)
> >   	),  
> 
> Please reduce the size of the tracing entries by removing dev_name from 
> TP_STRUCT__entry() and by replacing 'dev_name' with 'dev_name(hba->dev)'
> in the TP_printk() calls.

For future references, please do not recommend moving dereferences into the
TP_printk() callers. Those happen when the event is read by the user and
the hba pointer may no longer exist.

-- Steve

