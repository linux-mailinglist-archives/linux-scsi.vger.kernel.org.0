Return-Path: <linux-scsi+bounces-20754-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPalIxecimmVMQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20754-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 03:46:47 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E1116765
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 03:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31EA302E402
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C72E06ED;
	Tue, 10 Feb 2026 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="01RtO4xW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB262DC339
	for <linux-scsi@vger.kernel.org>; Tue, 10 Feb 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691468; cv=none; b=MxosyAHJyptGNCK7udjg1atGNxjxzW1GL0PYi/OvvvOjqS+9FsFclGOWpxzUuB0CFGU5H0tzgCoyjuVqF3fsJYIEVkGc6+gOb26zFCUjblCQ3D0oWsjFrEjTb5aUE3rZ+END3pMjvJjQjHBGsX9aUXXLiV0kggiBxLQcV2nvvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691468; c=relaxed/simple;
	bh=qLzBRIPmbJArHFpzya+ZbyzLUKo7DlwbYNKJKKJK19g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RjwiD2YEyGiCJmSH8HmKEbz3aNsw0iKmuIpCdWr2njUyQZJsWNc7zhnh9rV6puWgtBDxD92HcH9hlZ1ceUy74r/FPT1LSqkjRNMuEjRCgujnpidiHKhA67LobSvurcEjZj/YSYeEPtcY8GL0zmHEBQsb4O2Xu6/3SOj/nhG4aNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=01RtO4xW; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0ghBlJQT9LelAoC+5uHiCKkbNnnfh3yeC+85WvMzyvg=;
	b=01RtO4xWm8GGl9f+y919K/84Q9HSZXlT0Ogu0gDD94Tz/s2hHbnANNvi4MBE6Fx+y12Eq4yFd
	fvb1jpRd68YyqCtD6bWEeqFRoWP63zIvSyNAAf28A7wxrAvm/2nNOhIqCMiFpc1L0ZRsZUsLDRL
	1WTP7Ig+63xggTJStHhCXho=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f95Ph2gF8z1T4JV;
	Tue, 10 Feb 2026 10:39:52 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id B769B4036C;
	Tue, 10 Feb 2026 10:44:22 +0800 (CST)
Received: from [10.174.176.137] (10.174.176.137) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Feb 2026 10:44:22 +0800
Message-ID: <e959f667-1703-45a4-98fb-4b42b7b27a4a@huawei.com>
Date: Tue, 10 Feb 2026 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] scsi: sg: minor bugfix and cleanup
To: Bart Van Assche <bvanassche@acm.org>, <dgilbert@interlog.com>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<linux-scsi@vger.kernel.org>
CC: <yangerkun@huaweicloud.com>
References: <20260127062044.3034148-1-yangerkun@huawei.com>
 <b40028c0-910b-4228-8ed9-9843e3db394e@acm.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <b40028c0-910b-4228-8ed9-9843e3db394e@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,acm.org:email];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20754-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 109E1116765
X-Rspamd-Action: no action

Thanks a lot for your review!

在 2026/2/10 1:47, Bart Van Assche 写道:
> On 1/26/26 10:20 PM, Yang Erkun wrote:
>> [ ... ]
> 
> For the entire series:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>


