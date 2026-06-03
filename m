Return-Path: <linux-scsi+bounces-24395-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KN9BMRvLH2rwpwAAu9opvQ
	(envelope-from <linux-scsi+bounces-24395-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 08:35:07 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80C634B0C
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 08:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZTHndTIF;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24395-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24395-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 947E7301980C
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jun 2026 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C131A053;
	Wed,  3 Jun 2026 06:34:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C806315D58
	for <linux-scsi@vger.kernel.org>; Wed,  3 Jun 2026 06:34:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468492; cv=pass; b=kSJUYl7c95nsXc36uaUpy3KPdecUern5hQ6/WyA6m72OWc0sF1N30V9fFroyEweeMnticrum8iaZFFOPa55YSNYW9hUwQv/OHETrugf5DKKGGyi0LX56L/PX5A+oxJi0T/gTJkuhdsGzkBBvZ3zjd80bGXRFKY0++puqodmsnnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468492; c=relaxed/simple;
	bh=YyvTiLt0J/DKpFZTCEmXx9obr6lU3wLCKrbISmeZO1o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jdfFCOMTs6NrkUhoESVcsS0a3GgHYI4Ro0pdylFliGDdVNcJ57Pd96RUH5LxnHUlr1dtY4or173Hs9rSVK+ugqq6BLrGbxFegv3Q1aL+WZMSluA9JO76EOfZG0ix0Sz8lUz2xE/ncOXEm8kb03yZQAXOPpP76ILbuyYkYxL7OUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTHndTIF; arc=pass smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dc6fbf3e86so76042247b3.3
        for <linux-scsi@vger.kernel.org>; Tue, 02 Jun 2026 23:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780468490; cv=none;
        d=google.com; s=arc-20240605;
        b=DEtQyUXxqHKRDJILj6MlY/Hfh+hT911K09NO/6+AzkJe9JitpsnKa4NLHvi+IIYy+6
         XGtce1LgoAieT6bizCM84J1dWNsyH0n15uN2ofkttbgVl7icMximY6vYHhquGNOx4rfP
         5G50G9FeI7XQd0929GdLU1mUr8IzM/FSHIx6f1BT9iIiVq4J2inIrrDbA/709zKclPp6
         9at5XW/z9EW4O9rAn2qcO442wcTlJcNIXYFm0nk/ueFuE+YJZFleQ3KJ1spw5AyT57Sj
         NtwX8/3CSovgczj7NCDEeLEwZqVjWcma7nlkVCRPQjJ4BLw4G4lhe/XABVfPQ8sVCG9+
         75CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q5wU9720SNR86QzJdE75/3LUE6rDDQzlaPVDKfaIYuA=;
        fh=7I+XJWPHCRSuhD4z/r3jXa4YmPs94wkMoTzlRZIiWSc=;
        b=PywpVLnZJIHXRoVpOXWP8BAsZCZmx/LMkvy0EeZjlNLDIfPu6T42YL+AQio9fQzBQ3
         y4bUsunMJGx5jzd9LuyQrG9NV5zPDRRe0TiXv4yWkvAC7PlO2uiu3fVGzm1KZmPRgp55
         XoWNkGojU+7S4B+sh51Rkp4HST6Gi3eUSVgDaMIOhmKa9N4is/enxnbEjWZ/Mzm6A3D0
         KMjjCNgJIX4oZscxBRv1TlHonwAYWurnRdZH0QzS9Be34H5Rt8+Wx6H5mjgsjoimhaLF
         MD2/JXcucyWZ1tLCg87OLh3X98/x6+r8MxrGKPpQu8GnHlQnyeYBEV2Guo1Ee8YmaEua
         ZSCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780468490; x=1781073290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5wU9720SNR86QzJdE75/3LUE6rDDQzlaPVDKfaIYuA=;
        b=ZTHndTIFKfqxnA+xTxfxVE/gtkcIH3nJrFleVPckm9d/DvHyf5rz9uZcsv0JGhSYmK
         s9i0hZuKj9FU2gZC0c9t/kn9CAzKhidKo37ExXVKGnkwXRJxquz4aJDasxgiZUUAEMWc
         yC305jgc5alImdXhz1PHSjm12un+iA0APWDtC9+wFHNNu9sjDcblDlPmR8tCOQ2usmpl
         TfOGiIsXBNxOeWR/l55AtLAVc4eQsKxndtHFxDqGrE8K5CrIA+hsB0lOjbzjuwFoc61M
         sFtf0tw4A/kJ5uCFl9SpZ80Z71k7xbPG/BanKAzFiN+92pfntxYAOJClY2kfRLJgz8XC
         /K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468490; x=1781073290;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5wU9720SNR86QzJdE75/3LUE6rDDQzlaPVDKfaIYuA=;
        b=jauGNR2pi1liVXb+Zbu8KhKLcu2Xw/5CKbi+0uiYaN9hpzjiRTfBpQbts/s7sTWBGk
         Bg/kO8a/bXLUHpi1YYCaEE+YccuPJaHMdwBsOOLvtIQ9p9ThDIEp1+z1/ReM/km+P5pE
         osBOHff3yEryffLvcB6ZlRCbfNeH5VzbKrilO8IM9mqVazJChfac9hHhUaQiMlpXy1uK
         Wa1JOXdBJAYgyWlv+xYl2Jx59d9T3bPxVIUM0rI53LbZ5r15vnXuAAS3aaNdKvyKRwWl
         gMiGcIWqNbvatyJ7eRqxZXm9dQMJDOIba9qQKg/887U9fay8nuCm52qxxomKQoAYshwO
         8pfQ==
X-Gm-Message-State: AOJu0YwetWkh0smyti+OT58RkTPSZCXKvlJh2I11f3uymU4ipT+1B2/8
	n4nVZjCqknKjApGNAESf6ubZUxMXI8WkUSIoYp+nX0AN8Rcu2pRWTRjhEU5LNz6o75puJZbJXLp
	LEL04JtZZX92IZxOcZzDTGwofrQEFdM5olaVJ
X-Gm-Gg: Acq92OFTqWQJHq+Z09+NGUt8t3OTLy7qX/p6CQCBRLx5xqQgRl6V5+fAA+F7g36ODFW
	k24K9s1ZRT7+XSN2evhaYOx1c3s6XMkD28pQ9qtRi2eox1uCL1dcz4q9f4CdFo15UP8Wgw6qyKK
	nWHcyPHHsUX062es6Xbw6BXPLYtcecgz+7jBdCFW8ppIqxYIJMx+baTB6F6Tbd29V3VLrsFBSuC
	B6+PwvHqkcH5N4QUkQ5CcFO3Xr3G2mayaVHH/6WK+U/7dEOVzcYRmDY0xjsVgjkg+HAYy5mjLmd
	1VMTPLCMGxyZdmlMnd/J
X-Received: by 2002:a05:690c:62c6:b0:7db:bff4:f0c6 with SMTP id
 00721157ae682-7ea483ce659mr20247867b3.19.1780468490365; Tue, 02 Jun 2026
 23:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Wed, 3 Jun 2026 14:34:39 +0800
X-Gm-Features: AVHnY4IYZUBZ6RcjnwgG7R3Vh63xOxxDmW9YhSK4Q1rhtYXox8DUXBFi6MU0924
Message-ID: <CAGp+u1Z060NX18DG+UiJiHK0uQeaca4L_k_wkw1Ka2JPL94zFw@mail.gmail.com>
Subject: [bug report] potential deadlock bug in 'drivers/scsi/hisi_sas/hisi_sas_v1_hw.c',
 between 'cq_interrupt_v1_hw()' and 'hisi_sas_slot_index_alloc()'
To: linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24395-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gingerjzllee@gmail.com,linux-scsi@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D80C634B0C

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/scsi/hisi_sas' subsystem, more specifically, in
'drivers/scsi/hisi_sas/hisi_sas_v1_hw.c' and
'drivers/scsi/hisi_sas/hisi_sas_main.c'.
This deadlock potentially occurs with the involvement of hard irq.

This potential issue is present as of git commit
eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.

Potential concurrent triggering executions:
T0:
cq_interrupt_v1_hw[t1]
        --> spin_lock(&hisi_hba->lock); [t2]

T1:
hisi_sas_slot_index_alloc
    --> spin_lock(&hisi_hba->lock); [t0]

T1 does not disable hardware irqs in acquiring the spin lock. If T0
(i.e., the hard irq context) occurs after T1 acquires the lock and
both happen within the same CPU, then T0 will not proceed because it
cannot hold the spin lock that has already been possessed by T1, yet
T1 cannot proceed because the hard irq runs disables preempts.

Thank you for your time and consideration.

Best regards,
Ginger

