Return-Path: <linux-scsi+bounces-21981-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLFYFIBzs2kQWgAAu9opvQ
	(envelope-from <linux-scsi+bounces-21981-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 03:16:32 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3D27C9F8
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 03:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36ADD31122F5
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EA12F1FC3;
	Fri, 13 Mar 2026 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fWP88vm6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com [220.197.31.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855F277CA5;
	Fri, 13 Mar 2026 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367972; cv=none; b=A1y+Cu9srMs0enHGoRSCUCbMH9V4QBCqBMhwdQEzoEwAGgAmQJoAC29mytOqDJKGMOL5jzIpRPcZuZninsB8XyST6lQFj4bygT5Kby5Ft5mxn9lz92x/qVl6aReH9uREA9/3DrPJ1W/cjLoI+07eL5wOd3OJYgkZAI4pKEh7Bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367972; c=relaxed/simple;
	bh=mRIB7NhAO1HviqMsvepXs4bIoiPSrEukukXrVHZOYgo=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NrpnzHjsdZf5XbolcU13hjGmuouBsBzzVKqrdB+5i0qjd8u+c6sTbwa1ZE3h4cS4l2rvPL0+sNnbomnPZaTozBAkXvh1Lsxc4H8fP/sBJ68SdYdNRN6QN0wl3ZF/KMs59UUrBktQk6gKATkCDphmP5J1VbTzqlLxTATw3K+OVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fWP88vm6; arc=none smtp.client-ip=220.197.31.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36c7a8923;
	Fri, 13 Mar 2026 10:12:38 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] scsi: ufs: drockchip,rk3576-ufshc: dt-bindings: Add
 new mphy reset item
To: Bart Van Assche <bvanassche@acm.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <1773276707-24857-1-git-send-email-shawn.lin@rock-chips.com>
 <b9024d90-6df7-4a2c-85fe-7f5178e7d1cf@acm.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <32093ab4-28aa-f494-1282-56227bd949e4@rock-chips.com>
Date: Fri, 13 Mar 2026 10:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b9024d90-6df7-4a2c-85fe-7f5178e7d1cf@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ce4f79bfb09cckunm77bce527620e7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhNGVZLT0NIT0xKHh9OSEJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fWP88vm6ML1mQOER8/N1zsRulgr1p0ALo5N3PNrkS0JGMI9iItVrwxdKeuDNcniHXqpkdJTyv+5NzWI/U3QsdpUGNh57Tfze0fIe9gAnt9fd0R+xOUVyNPtW5H3gR1NCgkqx/DdNjdbJr74+dMJc9OvHdnDqV7bhgxsSbYRMz2c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=40EDhtURQ1ujkPw8TBboNKLerCY21VM4ZRXSGa5HpGY=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21981-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:dkim,rock-chips.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1E3D27C9F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/03/12 星期四 22:27, Bart Van Assche 写道:
> 
> On 3/11/26 5:51 PM, Shawn Lin wrote:
>> Add the mphy reset property to the devicetree bindings for the Rockchip
>> RK3576 UFS host controller. The mphy reset signal is used to reset the
>> physical adapter. Resetting other components while leaving the mphy
>> unreset may occasionally prevent the UFS controller from successfully
>> linking up with the device.
> 
> I see "drockchip" in the patch subject instead of "rockchip". Is that 
> perhaps a typo?

Ah, my bad. Thanks for noticing this. Will fix it.

> 
> Bart.
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

