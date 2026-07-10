Return-Path: <linux-scsi+bounces-25942-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L956Aq5QUGprwgIAu9opvQ
	(envelope-from <linux-scsi+bounces-25942-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 03:53:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43E7368EF
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 03:53:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=VoyOVKzu;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25942-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25942-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EF26301F98A
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D84F5E0;
	Fri, 10 Jul 2026 01:53:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB434F474;
	Fri, 10 Jul 2026 01:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648420; cv=none; b=aWnAoGPPob6dKcIcm4q1M0S/yhKHE2TC9qQP4JCMi4jpSGKXuLwoyA1rw33L1fP3DWD62rE8EeqlAZotbeWS7ObiMVbW0ju7MQP2kJz/g3MVjr8Dmx60kGHAYmcklx4k6ezywt7WWW6hkIjkClZoE9Px0+zFZz0ASPkDRyxjPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648420; c=relaxed/simple;
	bh=sVcLg8mBbOlcU7U2S17/eem27V26Re7M4ChY0wfV64I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fh8672U2lFknUqGg6ZZRuGKp3MA1wp4h3W3devCWNl8iaDV/wjkeuA85ONwJAj6+qIWD9+bbL4/dr4iiRODbNjUVe4cPENVdcVXy+30nDtcpAQ8Rbt4BEaXKPyFJJmkh0P6h10Eri0RgRg1cD0/BNCLV0Cf7QRC2OjDGPlp//a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VoyOVKzu; arc=none smtp.client-ip=113.46.200.222
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tTjDvA366Z+mwtBEU1qTetAUB8oC2LXClWANoJ9MZGc=;
	b=VoyOVKzu2SCHmb+og/z7zyOm875JtyVYk7twNQ+AFWjvAiE+THAnr1XFj7cEUrDWtZ6pjAHbC
	XGtuCCMv3kVX3EDqBfdkehkPQSq7MkyJvxaKU2FsGweb6L/ed9hyU7s0o/piGoqreJvkqywqdkl
	SMVE+P+R5DTf6T5FWk3bGjs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gxF493lgdzLlTZ;
	Fri, 10 Jul 2026 09:44:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9573340563;
	Fri, 10 Jul 2026 09:53:24 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jul 2026 09:53:23 +0800
Message-ID: <1687e42a-7d28-4189-a261-975a8289c680@huawei.com>
Date: Fri, 10 Jul 2026 09:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] scsi: libsas: terminate deferred commands on time
 out
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>, <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
CC: Igor Pylypiv <ipylypiv@google.com>, John Garry <john.g.garry@oracle.com>
References: <20260710000646.1202200-1-dlemoal@kernel.org>
 <20260710000646.1202200-3-dlemoal@kernel.org>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260710000646.1202200-3-dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25942-lists,linux-scsi=lfdr.de];
	FORGED_SENDER(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanaijie@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A43E7368EF

在 2026/7/10 8:06, Damien Le Moal 写道:
> If a command timeout occurs while we have a deferred non-NCQ command
> waiting to be issued, the scsi EH task is never woken up as the waiting
> deferred command is never issued nor completed, thus leaving this command
> to always be counted as "busy" for the SCSI host. This results in the
> scsi_error_handler() function test "shost->host_failed !=
> scsi_host_busy(shost))" to always be true, keeping the SCSI EH task
> sleeping. Eventually, when the deferred command also times out, the EH
> task is woken up and the timeout processing starts.
> 
> Avoid this unnecessary additional EH trigger wait time with the same
> method as implemented in libata-scsi, using the eh_timed_out SCSI host
> template operation. The function sas_eh_timed_out() implements this
> operation and executes the helper function ata_scsi_port_eh_timed_out()
> if the device is a sata one.
> 
> Co-developed-by: Igor Pylypiv<ipylypiv@google.com>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Cc:stable@vger.kernel.org
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c           |  5 +++--
>   drivers/scsi/libsas/sas_scsi_host.c | 17 +++++++++++++++++
>   include/linux/libata.h              |  2 ++
>   include/scsi/libsas.h               |  2 ++
>   4 files changed, 24 insertions(+), 2 deletions(-)

Looks good to me,

Reviewed-by: Jason Yan <yanaijie@huawei.com>

