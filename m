Return-Path: <linux-scsi+bounces-25191-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgS0APdZOmpN6wcAu9opvQ
	(envelope-from <linux-scsi+bounces-25191-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 12:03:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D76B60C1
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 12:03:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=bf+gihPl;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25191-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25191-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD18302BE3E
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EA30F938;
	Tue, 23 Jun 2026 10:02:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA352D7DEF
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 10:02:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208962; cv=none; b=kScfRE+BKJ333ljU+R7LBanlia2xCn+Z48mRLcSIc5v0r0MH4cnOADxpO/H+vn9klhC47D7ZTLHaWnNmCeU9HH+uSW26dEFA4aYJfo2WNaFDNW7yZsHqdm2ZG/oUZd/GGtpX8SkGvzEU7z2AeC13eFVpLpg7/oHGr1l2iMzgEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208962; c=relaxed/simple;
	bh=BW0kCQXHKfrByVwquqWdwgijh3uj+PDbF7L6TOxqjt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmtyqZ0o0yQFZVZkLOb7S7+UFTe+ulWrWwSQ4p0Kc+xC9qpovab2NDod2DEMiiQx0NyoZtAhA9YarcMLcDCWXk9CkhDcqiRyOE73D6fvm5dMk8GGiYhZojoUo2xOyf8FsL8cOPtc6NZMdmLEtHNvyqQtQxTgkNXASnygsa7ZNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bf+gihPl; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ow
	ohg+3hswm2r5coLFUPzSP5kd/DikOGPJ7Sp0BX+tQ=; b=bf+gihPl2znBvqI8ea
	Na35SJlQJcnJu2XdxEqU56M+/fJxWCTVaoyXGqeRi5NfiUJh8aeyLLNVEmlNOqrJ
	nZ6gSsc9/3+O38gOcwKIMWdCpru8O+C7F/qNfbfvjT3zjOvKTAVrVmEGrNPShoc9
	kGN6IF2IDZ2JFvVVKDJeuUs+s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAntXCaWTpqUiV6FA--.20165S2;
	Tue, 23 Jun 2026 18:02:03 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: hare@suse.de,
	tom.leiming@gmail.com,
	p.raghav@samsung.com,
	dlemoal@kernel.org,
	sw.prabhu6@gmail.com,
	linux-scsi@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v1 0/4] scsi: sd: fix probe error cleanup, special_vec leak and sd_done() sense gate
Date: Tue, 23 Jun 2026 18:01:55 +0800
Message-Id: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAntXCaWTpqUiV6FA--.20165S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1DXw1UKFyrGrW8XF43Wrg_yoW8Cw1rpF
	WfWwsYyr4UXa4fKrZxu3W8Xa4rur4rJayxGFWxG3yfuan8C34FqrWIqay7Za48CrWxAw1U
	Xr4Ut3WruFyUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1v38UUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hulNmo6WZs90gAA3f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25191-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:tom.leiming@gmail.com,m:p.raghav@samsung.com,m:dlemoal@kernel.org,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:yangxiuwei@kylinos.cn,m:tomleiming@gmail.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,samsung.com,kernel.org,vger.kernel.org,kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5D76B60C1

This series fixes three resource-handling bugs in drivers/scsi/sd.c.

Patch 1/4 fixes sd_probe() when sd_large_pool_create() fails after
device_add(&disk_dev) has already registered the scsi_disk device in
sysfs. The old out_free_index path kfree()s sdkp while disk_dev remains
registered, leaking the sysfs node and risking use-after-free.

Patch 2/4 refactors probe error cleanup as suggested by Ming Lei: after
put_device() or device_unregister() has released sdkp through
scsi_disk_release(), set the local sdkp pointer to NULL and fall through
to out_put so put_disk() and any remaining kfree() are handled in one
place.

Patch 3/4 fixes a special_vec mempool leak in sd_setup_unmap_cmnd() and
sd_setup_write_same{10,16}_cmnd(). sd_set_special_bvec() may succeed
before scsi_alloc_sgtables() fails during command preparation; the SCSI
midlayer does not call uninit_command() in that case because
RQF_DONTPREP is not set yet.

Patch 4/4 fixes the sd_done() sense gate left incomplete by commit
464a00c9e0ad ("scsi: core: Kill DRIVER_SENSE"). Replacing
driver_byte(result) != DRIVER_SENSE with !scsi_status_is_check_condition()
while keeping the old OR-shaped gate allows CHECK CONDITION with invalid
or deferred sense to enter the sense_key switch with an uninitialized
sshdr.

None of these patches are considered stable material: probe failures and
invalid-sense paths are rare edge cases with no crash in common paths.

Yang Xiuwei (4):
  scsi: sd: fix error handling in sd_probe() after large pool creation
    failure
  scsi: sd: unify sd_probe() error cleanup through out_put
  scsi: sd: fix special_vec mempool leak when scsi_alloc_sgtables()
    fails
  scsi: sd: fix sd_done() sense handling condition

 drivers/scsi/sd.c | 65 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

-- 
2.25.1


