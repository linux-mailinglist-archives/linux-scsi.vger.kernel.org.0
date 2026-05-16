Return-Path: <linux-scsi+bounces-23854-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOs2Mr94CGpvrAMAu9opvQ
	(envelope-from <linux-scsi+bounces-23854-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 16 May 2026 16:01:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE755BFC5
	for <lists+linux-scsi@lfdr.de>; Sat, 16 May 2026 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2137F3010ED4
	for <lists+linux-scsi@lfdr.de>; Sat, 16 May 2026 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE325B094;
	Sat, 16 May 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d571QnWl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C840855
	for <linux-scsi@vger.kernel.org>; Sat, 16 May 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778940092; cv=none; b=YLNty30GPLawj6YBLKqnGO+ChcleKMdSfYFf86bvttk5dUyDXK1kQW/APtfSLdGUbpfCr21hLux5T3LhsCK5asFGfhro6lvYKsMxUEVDGMtM7olf1Cv3lV40dbiOSpQGG/mAMr5HTq/3rKgtY/VhOKE46tMigv740qNl1jKUU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778940092; c=relaxed/simple;
	bh=fG54UekaZZWFVrpZTpnlinwMeIPM5ZtJ28a6denUljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1OeJ2DzeIiP0gSDpVlKSoCivSIL9siHSo1TleE+knzkj18ZNbFGLi+Y1R/TZ8QdGqmmCiQZXrr3KZvwCSt8RphWOo8K9S4j1n88R6DeIIV9piAoB7UKVerY8CqglyeiRNoqe2PWG35p5lNPL0kti5xklA3sFpKAj7UUngZp6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d571QnWl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gHm2L1Rw3zlfddr;
	Sat, 16 May 2026 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778940087; x=1781532088; bh=O4ldiU72HOSe0AjptIRQJ3U3
	LujAR2/k0JctUWu+zI4=; b=d571QnWl/t/o2PbhfwvDdDeZpL8AkNpzIgAejUsN
	bw2jX6ugk3RARcXlNqiXDjfRYcX0tKUhe6Tp7XhBnvTmlhlIZJRknYGkQfdlvpXe
	3lD/gewhFj2ysFOSbFQRv3df8RQMa3347f00ZLsWODxs30DthVNmFnTaHW72nGQz
	HGBlLTRFrDs2CcbfncbJcfYQJdD8PSUDnormMKp5mNg6mPcuYkINEGeZ+cogAe1b
	omMRXkGoj6GvBGgIrdCmHg1AELG5tvH9wDajLASRHBiQFnNcDaynoZc3zkhXmcw4
	3fVMZsjgTPAYBi885zjYnr071IpgUE9ykLjmgKqlXX0CIw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aIt-hU3t81FS; Sat, 16 May 2026 14:01:27 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gHm2F5NLqzlfvpG;
	Sat, 16 May 2026 14:01:25 +0000 (UTC)
Message-ID: <064b4c51-c3e8-4380-b1a2-ce996078efe8@acm.org>
Date: Sat, 16 May 2026 07:01:22 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: decouple CQE processing from spinlock
 critical section
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "quic_asutoshd@guicinc.com" <quic_asutoshd@guicinc.com>
References: <20260514082906.58593-1-peter.wang@mediatek.com>
 <382f6d79-c877-4dc8-813b-ee91ac5489f9@acm.org>
 <3d359319927f808dffa0aef52b03c437f803335e.camel@mediatek.com>
 <2ed721de-0410-413a-bda1-99b5313b072d@acm.org>
 <bcbfd7a71f698f6a3dcf627d3ea76c79b9897ccf.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bcbfd7a71f698f6a3dcf627d3ea76c79b9897ccf.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C9CE755BFC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23854-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 11:24 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> This cannot happen. I think you've missed my point and
> are confusing head with tail, and tag with slot.

Yes, I swapped head and tail but that doesn't alter the conclusion that
your patch can cause data corruption and kernel crashes. Not only for
UFS but also for other storage controllers that use circular queues it
is essential that completions are processed in the order that these have
been pushed onto the completion queue by the storage controller.
Otherwise completion queue entries can get overwritten by the storage
controller before these have been processed.

Additionally, reducing how long hwq->cq_lock is held is not sufficient.
This patch does not alter how much time is spent inside the UFS
completion queue interrupt. According to my measurements more than 10 ms
can be spent inside that interrupt. That is way too much - this can
cause slowness of the user interface and audio glitches.

The patch below reduces the time spent in UFS completion interrupts from
10 ms to 100 microseconds (100x) on my test setup. This patch needs
further refinement but is sufficient to show the root cause and a
potential solution.

Bart.


diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1c47bec101f0..33ddb234eb3d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -320,14 +320,23 @@ static void f2fs_read_end_io(struct bio *bio)
  	f2fs_verify_and_finish_bio(bio, intask);
  }

-static void f2fs_write_end_io(struct bio *bio)
+struct f2fs_write_end_io_work {
+	struct work_struct work;
+	struct bio *bio;
+	bool needs_to_be_freed;
+};
+
+static void f2fs_write_end_io_work(struct work_struct *work)
  {
-	struct f2fs_sb_info *sbi;
+	struct f2fs_write_end_io_work *weiw =3D
+		container_of(work, typeof(*weiw), work);
+	struct bio *bio =3D weiw->bio;
+	struct f2fs_sb_info *sbi =3D bio->bi_private;
  	struct bio_vec *bvec;
  	struct bvec_iter_all iter_all;

-	iostat_update_and_unbind_ctx(bio);
-	sbi =3D bio->bi_private;
+	if (weiw->needs_to_be_freed)
+		kfree(weiw);

  	if (time_to_inject(sbi, FAULT_WRITE_IO))
  		bio->bi_status =3D BLK_STS_IOERR;
@@ -374,6 +383,25 @@ static void f2fs_write_end_io(struct bio *bio)
  	bio_put(bio);
  }

+static void f2fs_write_end_io(struct bio *bio)
+{
+	struct f2fs_write_end_io_work *weiw;
+
+	iostat_update_and_unbind_ctx(bio);
+	weiw =3D kmalloc(sizeof(*weiw), GFP_ATOMIC | __GFP_NOWARN);
+	if (weiw) {
+		INIT_WORK(&weiw->work, f2fs_write_end_io_work);
+		weiw->bio =3D bio;
+		weiw->needs_to_be_freed =3D true;
+		queue_work(system_wq, &weiw->work);
+	} else {
+		struct f2fs_write_end_io_work weiw_on_stack =3D { .bio =3D bio };
+
+		WARN_ON_ONCE(true);
+		f2fs_write_end_io_work(&weiw_on_stack.work);
+	}
+}
+
  #ifdef CONFIG_BLK_DEV_ZONED
  static void f2fs_zone_write_end_io(struct bio *bio)
  {

