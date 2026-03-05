Return-Path: <linux-scsi+bounces-21501-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCnJAyF4qWl77wAAu9opvQ
	(envelope-from <linux-scsi+bounces-21501-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:33:37 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC26211BB1
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 583953008D12
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1635F601;
	Thu,  5 Mar 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="atNUn+O1"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0D4F881;
	Thu,  5 Mar 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713871; cv=none; b=b5A22wfYWz4B0afozqzJJGzqpFyDN2TUjj1lqBRFd4qx4DT9EgnZrEeUpVWT+ESWsbattyhs2DKBMUnAj/n1BT7iJ5uhDWp50aiuES2PCLooFRA50JsP/Wicyne9BeBPwvt+WBrTdAfpyEjw0csU7/H2ktFnmFm52JaZ6S/+llM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713871; c=relaxed/simple;
	bh=+YeLJY58B7+pcl8xMqR+rJcQOMbzGOnjxG7Vu2LF3uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGc2Tukm+4yoWyxi3RUhKYqLAMLFoOunl2dq9rwLgKwBqwax8rYgXiilP0dsiVqX2gckrgRhVusNhqf+F8kyudGwToAFKkDLjnNy3uxEBxUn5oZ1DN1U+8FJYYQaYesdkXC8/T0yVskivFajImVomzicFQ6veaJnmmkfkaiZ/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=atNUn+O1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fRTRL0zQWz1XM0pP;
	Thu,  5 Mar 2026 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772713861; x=1775305862; bh=+YeLJY58B7+pcl8xMqR+rJcQ
	OMbzGOnjxG7Vu2LF3uY=; b=atNUn+O1JW8el1ZhiDWQlGt3DbS1tHrirjNGqbbO
	1ua2Wa/TOMXAHOPqtfRc8ztkg49xtxLWfJT18bLTUYdq/h5K48HMOsMuJkdanB33
	q1QS/fSmVqKFbU0JFc1YvjBkxlzKi3oV7rlUjPVkKgYYkfPa5PVfn4qenEaAv8Nw
	pa9E0MB+fzh7AK+FCjGqo2PwIEwpKIo97ONypvYLydv+JhogiJiHX4AwAtnt1ubR
	6BuDI5cHwl76uxovdQSMOH65eg5jcP56Uke82BoA57ZcWmkezMgQb6UiPI9pH02X
	Fnz3QddyMFQEynpVjvb+yKLwdWcixMVIu9X1bVmNFe7duA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iZskj15PISh6; Thu,  5 Mar 2026 12:31:01 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fRTR03tRLz1XM0p9;
	Thu,  5 Mar 2026 12:30:52 +0000 (UTC)
Message-ID: <a079077d-ad7f-4dba-a72c-411740553529@acm.org>
Date: Thu, 5 Mar 2026 06:30:50 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] scsi: ufs: core: Add support to notify userspace
 of UniPro QoS events
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Peter Wang <peter.wang@mediatek.com>, Huan Tang <tanghuan@vivo.com>,
 Lu Hongfei <luhongfei@vivo.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Yangtao Li <frank.li@vivo.com>, Keoseong Park <keosung.park@samsung.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Liu Song <liu.song13@zte.com.cn>,
 Ram Kumar Dwivedi <ram.dwivedi@oss.qualcomm.com>,
 Daniel Lee <chullee@google.com>, Bean Huo <huobean@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260305110856.959211-1-can.guo@oss.qualcomm.com>
 <20260305110856.959211-2-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260305110856.959211-2-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ECC26211BB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,samsung.com,HansenPartnership.com,mediatek.com,vivo.com,quicinc.com,oss.qualcomm.com,zte.com.cn,google.com,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-21501-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:email,acm.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 5:08 AM, Can Guo wrote:
> The UniPro stack manages to repair many potential Link problems without the
> need to notify the Application Layer. Repair mechanisms of the stack
> include L2 re-transmission and successful handling of PA_INIT.req.
> Nevertheless, any successful repair sequence requires Link bandwidth that
> is no longer vailable for the Application. Therefore, it may be useful for
> an Application to understand how often such repair attempts are made.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


