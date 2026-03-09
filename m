Return-Path: <linux-scsi+bounces-21663-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S9xfFN9dr2kXWQIAu9opvQ
	(envelope-from <linux-scsi+bounces-21663-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2026 00:55:11 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7D242C20
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2026 00:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F78630571B5
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Mar 2026 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8138F251;
	Mon,  9 Mar 2026 23:55:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DB3D544
	for <linux-scsi@vger.kernel.org>; Mon,  9 Mar 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100507; cv=none; b=lA1tNn0gr+u1JItm/J3HmrSdrRnvqcblJWNe9RixZ33OIaCE+HJiZjyVOahoGLbR/ptxmEUiiOBC9g6Fum2rvOvc4OvBoo1rANu3a9l4daaPbHGy2yjvHJ0KQxj9NabIZ8yN0389AaEqAaxFrrybyyyoNJ7xY6srFvOIT7BZz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100507; c=relaxed/simple;
	bh=6Vofe/6ZWdzfe1bQhwcok7tc5hua1lVSK0g1U2J3b8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My9Qo3NkBxiN9m6kkA4EI13zbzwjfDFc6FTQbt/KYpOQrU69c9AZT9NXmabARGziDU+swww6XImNqwVhIrXxAIb0axlvdU/95UQb2Qujfu1JchObPhnFBAX7RjxYf0ByShsXyir8lo9IVEWGBx3V5C53NlYJl9HaeVj62i6uxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b955351e0a6so358710966b.3
        for <linux-scsi@vger.kernel.org>; Mon, 09 Mar 2026 16:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100504; x=1773705304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=;
        b=K9ecS3qmyAmNPmk3njJz2O5kxs74z72HKEC29BIIqTSAeQGxpRyfj/YEkoeoWHTap3
         bFIJ0I827BmMPeqAQS89zRD/Vj2zyfcErFeTpvUIV/DcHzs2Hi7hRHejJ6kx8QQNJKe4
         bC5VKn5LsGxa2avZRiQlL7vsFQzci2cAnZomsJcVzwNJtKYroAcx7qyjR3Izm3fpCiqC
         0SI3yo5cSHozN6EnyD5G65psiEoeqXp9sR6C5ZUvonUJkj48bNbj/RIRugqeKtu7/tn3
         fv1sg+fptCOgGK4/uJUk//CEah3oE+BkaAUQx+LZP2TUeM5FcbeiShHmkC+I+Et9pXgK
         d2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU0IzgwPGY1vCn+apn6Y28cA6EeLC9jFaOYIBELqiQPaCmPIRzowg/ySzCNuMCDw+OSpZqV/E46y6wD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GpYqNfrZhNfv2tXLpzaTmfZsQIgbn1TDn2wrQmRPy1rX3Es1
	1FYYxreVhkAyVBS7P2w8S4/0nZdpEUdE/NmeaTny7R0g2Np76EGH5AYUg4O0oxiBwkU=
X-Gm-Gg: ATEYQzwgG6IYJE8GWuKsrhRyIcu2NLBU0qrSE+KuF7fSrwGcJbMsKXp/lHcyv/UXL8j
	CxB4+dqgGE2cyPb84honcMUzqwGfwBNB2o2t2cUS1FoaMVdPU5RpfN1qsf1rLCJwPKOEVWZFSUy
	4qv79szqJrL9TOAoRXNEOPJjRoVeIt8+kLWrW4ULJ+5FQkSsnho1itmA7MmdhddhdX6XcoZ5jOo
	JrCnj9pEWbqU6koFzx2vkNsnXUn1BlsycArNaWO7ZyKHQzBqY49/egiFzR3L4GfZXkq99KTZ4gq
	Y/JaZvjPW9XPk/AZEmaR24RGH1RMaXiE8rVSez5kdXxvFHVE4IYYpTRCqhSDHlvaVSbL+/19d9N
	2+jVmgKy7KyUuNDrn4C88eHvfH7XDAjJyRnT7CZpV5WcwLyia5npqKhwR5VD6FLBBX2/hCv65Vy
	u22/K7WbJj48bCaQ8IW4dDodlcld4aWxS+lq1Kc43XPppQ0V9L3PSYZ9o=
X-Received: by 2002:a17:907:720e:b0:b94:2345:3e6a with SMTP id a640c23a62f3a-b942dfa4790mr720199266b.48.1773100503554;
        Mon, 09 Mar 2026 16:55:03 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f18bb33sm432835266b.65.2026.03.09.16.55.03
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 16:55:03 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso6507778f8f.3
        for <linux-scsi@vger.kernel.org>; Mon, 09 Mar 2026 16:55:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7MqwAsOSB+kyCL2EWRyNfukUnj30D0ClYP2SlNbUom8tDvsd4sUCdTHoNDVAeibKiUcgiJyoK+KiF@vger.kernel.org
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id
 ffacd0b85a97d-439da66b72cmr23928350f8f.26.1773100503051; Mon, 09 Mar 2026
 16:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
In-Reply-To: <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:54:47 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
X-Gm-Features: AaiRm53vE5uEinTHUYE1aa6bIvdkwyOpz0dn9fOlsjLR4PN8Z_3w05vllGJ47mw
Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 95A7D242C20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[sung-woo.kim : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21663-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iam@sung-woo.kim,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.837];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purestorage.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result,
> > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
>
> The node argument to blk_mq_alloc_hctx() comes from
> blk_mq_alloc_and_init_hctx(), which is called by
> blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set,
> i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> doesn't find any CPU affinitized to the queue. Is that even possible?

Thanks for your review, Celeb.

blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
exceed the
number of CPUs. Afterward, it is adjusted on the caller side to
numa_node =3D set->numa_node.

set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
proximity information.
But I'm not sure if this is usual in the real machines. We found the
crash in QEMU.

> >  static struct nvme_descriptor_pools *
> > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
> > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> >  {
> > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[=
numa_node];
> > +       struct nvme_descriptor_pools *pools;
> >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> >
> > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > +       else
> > +               pools =3D &dev->descriptor_pools[numa_node];
>
> Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id();
>

Thanks, I will modify it in V2.

Sungwoo.

