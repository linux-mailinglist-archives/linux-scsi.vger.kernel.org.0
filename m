Return-Path: <linux-scsi+bounces-23736-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJvGIYc3A2ow1wEAu9opvQ
	(envelope-from <linux-scsi+bounces-23736-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 16:21:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6755224D0
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA6535549AF
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6032349CF7;
	Tue, 12 May 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vJ16uOdH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0868397B08;
	Tue, 12 May 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591913; cv=none; b=nPULKLiwxHY8lHZTXaMnLatDlHupn3KrddEcZp9TnyhIkXwVfkdjG0wJ2W+j+yDoZk/6YBRPsh8jsrkXdh43PcRUVbI3WnijW2YkjnvYZhenOjbns7N5M+kaTgMWbeDOnnIlkZUMrDM3y8Cwa0WOmrQojf1XJgOOp0RmFqDvcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591913; c=relaxed/simple;
	bh=Uqvi7mTQOjfbF8LvcWgP0J/HCrtQ7KOAxVhybe6+720=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ivH/pFJ5hj6zZGcYtrZkESytpnRrDiF+QhP0eE1sVA9p337wVz2Xo8CDiVgHlKdQmueVxKnR8odsSAzdBGIxfD9Z5x+5mzSfA4Jofb3Oj3QRSA5aa/Wo9WCGuEdyxj8Wq1g/Bvo6kaW/JIZtZU4r7yIyE4bAHqCDAC8PoKN/Oi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vJ16uOdH; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=31tYX4+VG7i4jQXxMONKUGCq02DhrTsTCvk8PT4+ePE=;
	b=vJ16uOdHVP3Gs/Vtho4V6WXhq8Gvd0sIOH+OaWgDPifgKM24su00jn/YvWz6OupHBDKDqs2Ji
	3NByShl1jBl1TdRsDENXytkvQBPUb17GgryIYm6d8h8CFJF8wCheydPERrJC8Ifh7SeTnYZRW30
	PqACzN6ldiyfpEsDZ1eA7O4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gFH5h1Fkgz1T4Mb;
	Tue, 12 May 2026 21:10:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B17240538;
	Tue, 12 May 2026 21:18:28 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 21:18:27 +0800
Message-ID: <9c4a1438-bd8f-4107-a519-a222e20f5da6@huawei.com>
Date: Tue, 12 May 2026 21:18:26 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: handle linkrate change in
 sas_rediscover_dev
To: Xingui Yang <yangxingui@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260512071226.2299741-1-yangxingui@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260512071226.2299741-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Queue-Id: 2D6755224D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23736-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

在 2026/5/12 15:12, Xingui Yang 写道:
> When a device attached to an expander phy experiences a linkrate change
> (e.g., due to cable reconnection or negotiation), the current code in
> sas_rediscover_dev() treats it as "broadcast flutter" and takes no action
> if the SAS address and device type remain unchanged.
> 
> However, for drivers like hisi_sas, the ITCT entry needs to be updated to
> reflect the new linkrate. Without this update, the hardware continues
> using stale linkrate information, which can cause performance issues or
> protocol errors.
> 
> This patch introduces a new LLDD callback lldd_dev_info_update() to notify
> the low-level driver when a device's linkrate changes, allowing the driver
> to update its hardware structures accordingly.
> 
> Additionally, refactor sas_ex_to_ata() to use a new helper function
> sas_ex_to_dev() which returns any device type attached to an expander phy,
> improving code reuse.

Could you split this refactor to another patch? This makes it easier to 
review.

祝一切顺利
Jason

