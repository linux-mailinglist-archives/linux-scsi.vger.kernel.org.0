Return-Path: <linux-scsi+bounces-23174-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLXLCP3R52k4BAIAu9opvQ
	(envelope-from <linux-scsi+bounces-23174-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 21:37:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6D43F056
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D73B302490A
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A193DBD72;
	Tue, 21 Apr 2026 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y6V6EKxL"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE8282F20
	for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800249; cv=none; b=SMuG2izQ0vxbsqTUQbt+TtFWu8Echa/uOUW1aXLcyDBV8IaXtTJOnQBw13ZiDvQx4/t5tzKU70FnVcgja22Kwjw8r5CoXrjRNrHhfWPfHz+sC18joRbXYqTBFa6PYYzWVZRxTW0igTVs6Vf1IlK6dPTdj+EwLc3Orn8nav8W8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800249; c=relaxed/simple;
	bh=LmHJCQE81gDA4eIuh7342wnbcDdwHRa2fESSfLS2vJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp8HUHl9lzjVwh/a15IaEF4OzfofpIqT9sN/UJR1g3qXUZ3kZKRSwfIFjue8pPCfM+6OZFkRJQXt9jWeWownLlNQU71kcb/hNHCJ+U25Wb0p5OreLURt+4dt5bbbP83huGWb3gh+VbF7twK6g8A6PpzK8yEJqIHvJ//hAD7eX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y6V6EKxL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g0XgQ3H9vzlfl8L;
	Tue, 21 Apr 2026 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776800238; x=1779392239; bh=q000bMpbrPKvirNnJbsCgREC
	5Keqafr4ICnwKpWxnd8=; b=y6V6EKxLCZz+JoCrvNPdKgP4Nl5vyF9/qCDw2574
	+nVJJchTSDfzC8jLepSXZ0eBbJagXcpoNsw0OaIdxYyA0Z+yit2bvcF+b6Z+2na4
	AAVHXVvtxGSOrofyTA+r4jgCq6RNpXuhl40jbD9KpeB743wwJZt5RzkVuVPwCsFr
	57nuWLfgLwuN2USI4g8mKPeJfZMb4gF3LNst9NH6ChtHusL3IMP7fWgnTB5O0Y+D
	+1cNfQ2NCyYoMiAW1tOqWomSeGlGiLG/i7OhGTTLvfTsd07ryaYsq6pi0t8UOvmy
	ESrqb9uHvE/fXe5EvQbdjDl/6VynhMUpZYRYqmQUMwPokQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YAF4c7Bw4IdZ; Tue, 21 Apr 2026 19:37:18 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g0XgK0YmtzlfpM6;
	Tue, 21 Apr 2026 19:37:16 +0000 (UTC)
Message-ID: <31c4e534-80e1-455d-8057-8b71a7616de5@acm.org>
Date: Tue, 21 Apr 2026 12:37:16 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ufs: core: Optimize ufshcd_add_uic_command_trace()
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "beanhuo@micron.com" <beanhuo@micron.com>,
 "can.guo@oss.qualcomm.com" <can.guo@oss.qualcomm.com>,
 "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
References: <20260417213027.3506742-1-bvanassche@acm.org>
 <20260417213027.3506742-4-bvanassche@acm.org>
 <a186b02b00694be3e89cd49d477c050df4bb1cf5.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a186b02b00694be3e89cd49d477c050df4bb1cf5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23174-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 67E6D43F056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 1:45 AM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> In the complete case, all these commands and arguments 1 to 3
> are filled by hardware. If we do not read them from the hardware,
> how can we be sure of the actual values written by the hardware?

Hi Peter,

Are we perhaps each interpreting the UFSHCI standard in a different way?
My understanding is that the UFSHCI command flow is as follows:
* First, UICCMDARG1, UICCMDARG2 and UICCMDARG3 are written by the host.
* Next, UICCMD is written by the host. This causes the host controller
   to execute the UIC command.
* Upon completion of the command, the host controller updates the lowest
   byte of UICCMDARG2. UICCMDARG3 is only updated after execution of the
   following commands has finished: DME_GET, DME_SET, DME_PEER_GET and
   DME_PEER_SET.

Thanks,

Bart.

