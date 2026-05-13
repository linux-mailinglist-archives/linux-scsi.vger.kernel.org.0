Return-Path: <linux-scsi+bounces-23766-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABYNGa8YBGpLDgIAu9opvQ
	(envelope-from <linux-scsi+bounces-23766-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 08:22:39 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C652E0CD
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 08:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36FAF305805C
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 06:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1E3A63E4;
	Wed, 13 May 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JdhY1kDC"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7D38E8B8;
	Wed, 13 May 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653352; cv=none; b=KPJNw5nNvtBCOZalIUE0owto2tvMUs/Ex5Z8u3XQkJCEYy1GydbTYjNTP0DqSpCs5GNlJzBAz4H2Myso7Htb3gryFto6nRSjn7cHjH3MNemqXg4IjUUQkcy9kluZGr7Ks2YQXLwSNMdsqyMPu3rvRkUCDRTpM8KmiVrcFrZYkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653352; c=relaxed/simple;
	bh=KJCLePWN1iIFsRxfxHKRTez17KYwzTPWOSIIT3g6gkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u/wZ4UOhGGxxHlz6VMZGCGQlgzywWRGbiOEdOt/RNnXEfKxbE9tSvZ74D2ofF37kWX76tchHLdVmMRn1EO5pDdjeaBnI2fSEWkEVL6pgQ7WdLM300kEarDcm6CnO85SyRgTWQHU6xFPvpwJQuQfvXdhPfdPYu2Iy2wzrlQldyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JdhY1kDC; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M7aGRJ8qsTLf+YYe3QhF0x12sEwMf1V7lt1CiRyZiG0=;
	b=JdhY1kDCh5fyX64JM3JEaCbAfT+74uh6x4owBsGK+gxcjNByMDKkLWpwNOpgpZX1rfvNj5i4D
	gk4aa002HHLr3jN1XmdsqL8ar4lE6+VrUEIX+rblqI+FiY6xJ6BpRqCObWa9+vsfJm3XJbTmYLO
	Vxd/m1hZHZhJL3ZGKEc+4Ww=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gFjqD3J68z1prLv;
	Wed, 13 May 2026 14:14:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 097FB20104;
	Wed, 13 May 2026 14:22:28 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 14:22:27 +0800
Message-ID: <10a157bd-78aa-4b8e-9587-4e89afd85ea2@huawei.com>
Date: Wed, 13 May 2026 14:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] scsi: libsas: add lldd_dev_info_update callback
 for device info changes
To: Xingui Yang <yangxingui@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260513021603.3023329-1-yangxingui@huawei.com>
 <20260513021603.3023329-3-yangxingui@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260513021603.3023329-3-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Queue-Id: D00C652E0CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23766-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

在 2026/5/13 10:16, Xingui Yang 写道:
> When a device attached to an expander phy experiences a linkrate change
> (e.g., due to cable reconnection or negotiation), the current code in
> sas_rediscover_dev() treats it as "broadcast flutter" and takes no action
> if the SAS address and device type remain unchanged.
> 
> However, for drivers like hisi_sas, the ITCT entry needs to be updated
> to reflect the new linkrate. Without this update, the hardware continues
> using stale linkrate information, which can cause performance issues or
> protocol errors.
> 
> Introduce a new LLDD callback lldd_dev_info_update() to notify the
> low-level driver when a device's information changes (such as linkrate),
> allowing the driver to update its hardware structures accordingly. This
> callback is designed to be extensible for future device information
> updates.
> 
> Signed-off-by: Xingui Yang<yangxingui@huawei.com>
> ---
>   drivers/scsi/libsas/sas_discover.c | 12 ++++++++++++
>   drivers/scsi/libsas/sas_expander.c | 13 +++++++++++--
>   drivers/scsi/libsas/sas_internal.h |  1 +
>   include/scsi/libsas.h              |  1 +
>   4 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

