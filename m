Return-Path: <linux-scsi+bounces-23346-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCH4NQVD72lP/QAAu9opvQ
	(envelope-from <linux-scsi+bounces-23346-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 13:05:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304547178E
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87F3530008B8
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F893A169D;
	Mon, 27 Apr 2026 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EUbVq5FN"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249539FCBF
	for <linux-scsi@vger.kernel.org>; Mon, 27 Apr 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287937; cv=none; b=u/pBKRiGDtNiLRz+OQUyt7IC5rVo5n2WFM1CO2J8W2IAGal3K3EXeVas8Tip4e3N++6ewOWYOH+kNOwSs++FD5DA0fGd01rS692zBOqD5zW5ooukS6h8FheY7uxVCVbyTWvYYxTEowzbzv7b5Ie48vDe85j/iqqCsi5wbA/3zBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287937; c=relaxed/simple;
	bh=nHVmscofyLUA3h72V3w4Wiw5weFIr3NDQQmiE8AdAxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkoHhxa8m0ZSko8zSjHvCYuSrKAEseylQPZujnU7AG+sPMiqGtBVtfXLQ7j3BeVwJVXOZjmZhHWUJ6HQ4HuekQIVraeLb6zC7D687uNcHfiPcCxtr+rq/Nq841adsEyMmPKD16XnUxEDSxdCj0JaeazroX1FjrGyaMruILpqY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EUbVq5FN; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202604271055213e4ffaee030002074d
        for <linux-scsi@vger.kernel.org>;
        Mon, 27 Apr 2026 12:55:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P3IMh9zc4XqQrfVWFOK5zzy46NlRww98MNLYe1Fx+BM=;
 b=EUbVq5FNeThmPDQSfh8aKo91HZYE8p7RF4AdjrWartcxXiwJzqu/NIjalCA0+Rqsdawjc+
 aTYLS9cvzoSjt2zhTEZENSfHleFO1n5O/PBYA+jAhakrksykqURhoUDlei7lUTD6ZMlPEc+l
 VPBC3Gbf4V/4y7e8PttGnbhSmf6DHbzGmsjuqFx8J8DB8JqRytDpCUw8cfg93ZtAEwB3Pe5M
 4e7OeJ3gdMnAvzs+wXn7Veo9wXdjTkYCno7jME9wpzSomoGCs/Rebx2eTvLPuTO0Wa0vTfnC
 ZKnXlXn5chALN5siZht7ggRS0nBgpTzJK998EecC3RhiQ7E/tgRofaTA==;
Message-ID: <e350389a5a635660267a7a13f06529da102a95d8.camel@siemens.com>
Subject: Re: [PATCH v12 00/13] blk: honor isolcpus configuration
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com
Cc: aacraid@microsemi.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, liyihang9@h-partners.com,
 kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
 shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com,
 sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
 suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com,
 jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
 bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
 frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
 hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com,
 steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com,
 mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Date: Mon, 27 Apr 2026 12:55:20 +0200
In-Reply-To: <20260422185215.100929-1-atomlin@atomlin.com>
References: <20260422185215.100929-1-atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Rspamd-Queue-Id: 7304547178E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsemi.com,HansenPartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,kernel.org,redhat.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,linutronix.de,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-23346-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]

Hi all,

On Wed, 2026-04-22 at 14:52 -0400, Aaron Tomlin wrote:
> Hi,
>=20
> I have decided to drive this series forward on behalf of Daniel Wagner, t=
he
> original author. The series has been rebased on v7.0-12635-g6596a02b2078.
>=20
> Building upon prior iterations, this series introduces critical
> architectural refinements to the mapping and affinity spreading algorithm=
s
> to guarantee thread safety and resilience against concurrent CPU-hotplug
> operations. Previously, the block layer relied on a shared global static
> mask (i.e., blk_hk_online_mask), which proved vulnerable to race conditio=
ns
> during rapid hotplug events. This vulnerability was highlighted by the
> kernel test robot, which encountered a NULL pointer dereference during
> rcutorture (cpuhotplug) stress testing due to concurrent mask modificatio=
n.
>=20
> To resolve this, the architecture has been fundamentally hardened. The
> global static state has been eradicated. Instead, the IRQ affinity core n=
ow
> employs a newly introduced irq_spread_hk_filter(), which safely intersect=
s
> the natively calculated affinity mask with the HK_TYPE_IO_QUEUE mask.
> Crucially, this is achieved using a local, hotplug-safe snapshot via
> data_race(cpu_online_mask). This approach circumvents the hotplug lock
> deadlocks previously identified by Thomas Gleixner, while explicitly
> avoiding CONFIG_CPUMASK_OFFSTACK stack bloat hazards on high-core-count
> systems. A robust fallback mechanism guarantees that should an interrupt
> vector be assigned exclusively to isolated cores, it is safely re-routed =
to
> the system's online housekeeping CPUs.
>=20
> Following rigorous testing of multiple queue maps (such as NVMe poll
> queues) alongside isolated CPUs, the tenth iteration resolved a critical
> page fault regression. The multi-queue mapping logic has been corrected t=
o
> strictly maintain absolute hardware queue indices, ensuring faultless que=
ue
> initialisation and preventing out-of-bounds memory access.
>=20
> Furthermore, following feedback from Ming Lei, the administrative
> documentation for isolcpus=3Dio_queue has undergone a comprehensive overh=
aul
> to reflect this architectural reality. Previous iterations lacked the
> required technical precision regarding subsystem impact. The expanded
> kernel-parameters.txt now explicitly details that this parameter applies
> strictly to managed IRQs. It thoroughly documents how the block layer
> intercepts multiqueue allocation to match the housekeeping mask, actively
> preventing MSI-X vector exhaustion on massive topologies and forcing queu=
e
> sharing. Most importantly, it cements the structural guarantee: while an
> application on an isolated CPU may freely submit I/O, the hardware
> completion interrupt is strictly and safely offloaded to a housekeeping
> core.
>=20
> Please let me know your thoughts.

This topic reminds me of a discussion started by Tobias [1] some time
ago about IRQ spreading of network drivers. The problem was (and still
is) that network drivers ignore any CPU isolation when spreading out
device IRQs.

In general we have two different CPU isolation mechanisms:
  - The static one, via isolcpus=3D cmdline parameter
  - The dynamic one, via cgroups(v2) cpuset controller

This series is only taking the static "world" into account, right? Are
there any plans to honor the CPU isolations configured the dynamic way?

It has been a while since the last investigations on my end. Last time I
went through the code, the IRQ core was completely decoupled from the
dynamic configuration via cgroups. Are there any plans to fix that gap?

Best regards,
Florian

[1] https://lore.kernel.org/all/a0cad8314124ca98d7c6763e3e08d7192598cf92.ca=
mel@siemens.com/

