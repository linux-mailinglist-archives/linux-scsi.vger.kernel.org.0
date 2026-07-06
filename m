Return-Path: <linux-scsi+bounces-25617-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/unOLFHS2pROgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25617-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 08:14:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68670CCF6
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 08:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baidu.com header.s=selector1 header.b=NZlmfhLf;
	dmarc=pass (policy=quarantine) header.from=baidu.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25617-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25617-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DD8300210D
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A43AEF59;
	Mon,  6 Jul 2026 06:09:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B79F8213254;
	Mon,  6 Jul 2026 06:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318148; cv=none; b=aIsHtvjM5VhA2EF5B8pz8hzNmQP7mJ6Qtre2J7UI+IKrxgV+fjar5LPhevkMWb640p+N21OXqY8vI3aj53VDVMoEPGkoLoMKb+gKHZ984ZxdmkMYTehIETGhLFL9mWAp454NawrMgWjz5w2UZFY8JJKzZZQnXjcGsMxVa4ku1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318148; c=relaxed/simple;
	bh=89UxSNmJbwus+1T6LL2Jdtv0hEZWDLSbpVditxGK+Uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKMhhArOm/OCEjn9wMFamTVmROLIuVWgQmndYf/yGFctXKzYhE02Hw8VgzMWYTSgwvebfUDuk59vCAE1SN0K7sij4BiAnxZrmZIkqZ0F9x34DRP3+gSIdAIJvDazksPsZXUqQC4OjIXvJsnr8j8dmsfOhKpSvWygcXVpWyRXr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=NZlmfhLf; arc=none smtp.client-ip=220.181.3.85
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>, Sreekanth Reddy
	<sreekanth.reddy@broadcom.com>, Suganath Prabu Subramani
	<suganath-prabu.subramani@broadcom.com>, Ranjan Kumar
	<ranjan.kumar@broadcom.com>, "James E . J . Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <MPT-FusionLinux.pdl@broadcom.com>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] scsi: mpt3sas: fix invalid kfree of embedded event_data in event callback
Date: Mon, 6 Jul 2026 14:08:40 +0800
Message-ID: <20260706060840.2287-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1783318132;
	bh=fY4JfJBuHxJGe2G1UwjbtBb33neK5Eh3TVkeu9PNsJA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=NZlmfhLfzmxBSATvsK/69BeYyH2xh6AsJPuHVQCF/KQjMCuBG5Vph+KkKMGMox6Uv
	 nsc/Q/LRaU+SvPb+gWmVtR1j22Cj1BbsKjegGV+lvFAoVNP9qLFYn3zuuE7EiohMc/
	 gvPAr6nh/4FoJgnljVnZ+xScaztWp9wNXDvlllVe1zW8ndTve32wZ+Imeo7KSZL0iB
	 XIxcu0rKXc0Wq1Yz5zsmn/2r0MrL2H4pZHnMVj5KgZsJjiw0SuOgqQkB7ItMRhDiSk
	 pe9bo4r9YYXj2mS53bE8ZrgrHdxRHmAxprYQKZVTfC7IU6zboJVLtqqUegsu1VV426
	 fuEf2kaobK60A==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25617-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:MPT-FusionLinux.pdl@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lirongqing@baidu.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lirongqing@baidu.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baidu.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC68670CCF6

From: Li RongQing <lirongqing@baidu.com>

fw_event->event_data is a flexible array member embedded within the
fw_event_work structure (allocated as a single kzalloc). Calling
kfree(fw_event->event_data) on it is invalid and can corrupt the heap,
since it is not a separately allocated pointer.

The subsequent fw_event_work_put() will decrement the refcount to zero
and call fw_event_work_free(), which frees the entire fw_event_work
structure (including the embedded event_data). The extra kfree() is
therefore both wrong and redundant.

Remove the erroneous kfree(fw_event->event_data) call in the
MPI2_EVENT_SAS_TOPOLOGY_CHANGE_LIST error path. The PCIE topology
change list handler already handles this correctly without the extra
kfree.

Fixes: ad59571931072e6f ("scsi: mpt3sas: Add firmware event requeue support for busy devices")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 12caffe..ca01a49 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12267,7 +12267,6 @@ mpt3sas_scsih_event_callback(struct MPT3SAS_ADAPTER *ioc, u8 msix_index,
 		if (!fw_event->retries) {
 
 			ioc_err(ioc, "failure at %s:%d/%s()!\n",  __FILE__, __LINE__, __func__);
-			kfree(fw_event->event_data);
 			fw_event_work_put(fw_event);
 			return 1;
 		}
-- 
2.9.4


