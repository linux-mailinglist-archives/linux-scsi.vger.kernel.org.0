Return-Path: <linux-scsi+bounces-25415-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pgwdLy34RGoJ4QoAu9opvQ
	(envelope-from <linux-scsi+bounces-25415-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:21:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBB6ECBCB
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:21:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25415-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25415-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935273037E55
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F743DA26;
	Wed,  1 Jul 2026 11:18:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7F44BCB8
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 11:18:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904703; cv=none; b=nEKU8WrYV31o0sEjoDN9rJXZO9He1z5jYiSOo8VfWbUe9KGUMjtuhm+pRIobfsAkWvi8r12XmSKPo6Tb5hAs8aw1Ad1rObal4PrVUa5g4SsAWl+Pwl6qOwF81n/GGu0RmipRPczEzBHDqvx1LTQPxTJXz1oObyrr6tyI+kN24Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904703; c=relaxed/simple;
	bh=DgfHg3JZRfgQcoiEi1X1yI5FN/kUp49vAduSf1EE3UM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=E9j8bXQp8iDyQ5MntOCqLPE/9nrhnpLbx0N3IbVJddjMZBF5zt/TXTew1lmsXI1oPpr5k9GIkgX/YXDhX2FEC12lPdJu/s/Tjdf9EfEHmqjYM3aw6gSz2jemAbC6DpSSY3oHLrSqEpuCJmnvtcqOksYi3VCWWe4voE/15HY8KZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 22109C4EEA;
	Wed, 01 Jul 2026 13:09:57 +0200 (CEST)
Message-ID: <1cbf0f3e-4d6b-40ce-9d7b-3e9ea7e8f03e@proxmox.com>
Date: Wed, 1 Jul 2026 13:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: regressions@leemhuis.info
Cc: Mats.topstad@intility.no, chandrakanth.patil@broadcom.com,
 kashyap.desai@broadcom.com, linux-scsi@vger.kernel.org,
 mail@danielfernau.com, martin.petersen@oracle.com, me@magik.net,
 megaraidlinux.pdl@broadcom.com, regressions@lists.linux.dev,
 shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
 Friedrich Weber <f.weber@proxmox.com>
References: <b8fcdb5e-f2be-4bd0-914d-d03e87af9630@leemhuis.info>
Subject: Re: [PATCH] scsi: megaraid_sas: fix PRP list out-of-bounds write
Content-Language: en-US
From: Mira Limbeck <m.limbeck@proxmox.com>
In-Reply-To: <b8fcdb5e-f2be-4bd0-914d-d03e87af9630@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1782904191622
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:Mats.topstad@intility.no,m:chandrakanth.patil@broadcom.com,m:kashyap.desai@broadcom.com,m:linux-scsi@vger.kernel.org,m:mail@danielfernau.com,m:martin.petersen@oracle.com,m:me@magik.net,m:megaraidlinux.pdl@broadcom.com,m:regressions@lists.linux.dev,m:shivasharan.srikanteshwara@broadcom.com,m:sumit.saxena@broadcom.com,m:f.weber@proxmox.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[proxmox.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[m.limbeck@proxmox.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25415-lists,linux-scsi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.limbeck@proxmox.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,proxmox.com:mid,proxmox.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09FBB6ECBCB

Hi,

We've seen some similar looking logs, but since they didn't mention
`prp` at all, we haven't responded here before. Instead we sent a mail
to the linux-scsi list [0], but got no response so far.

In our case the issue was first introduced by commit:
9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")

This is similar to an issue we previously reported with the mpt3sas
driver [1].

At least for our tests and one of our users we can say with certainty
that reducing the queue sectors back to the previous value fixed the
issue. In our tests this was done manually, and for one of our users
with their root on the disks, it was handled via udev rules.

echo 1280 > /sys/block/<dev>/queue/max_sectors_kb



[0]
https://lore.kernel.org/all/d171cc76-bf25-48ce-b482-d344669dfc24@proxmox.com/
[1]
https://lore.kernel.org/all/7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org/


