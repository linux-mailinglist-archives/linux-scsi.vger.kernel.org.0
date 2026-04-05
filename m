Return-Path: <linux-scsi+bounces-22784-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ob2M9Hz0mk0cgcAu9opvQ
	(envelope-from <linux-scsi+bounces-22784-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 01:44:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809163A041E
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0FE3007ACD
	for <lists+linux-scsi@lfdr.de>; Sun,  5 Apr 2026 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC05385507;
	Sun,  5 Apr 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRy7bNIt"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CDD2DB7BD
	for <linux-scsi@vger.kernel.org>; Sun,  5 Apr 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432651; cv=pass; b=mgWn9Z4hCOz7SYhLOvMY/8a8HXbSxESZ/24vCKY0ZX04X3NGiBSsfuzggwWkDQmF8/+Dc0GLTe4Mfn2G8BxQaUu7jgpcEhISnfvGwwiL6LhAkCNGsm76qhAG2Yb9DBI9CK1taf45PTLZbg5nquvfGa3LFwjEXgKN1KLOlzv5Bss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432651; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBLAkqb/noA+Y6zI645v1MRC3GDlW5d1hIWATGivxgjV5KfdGpGTNXPJJOiVfxMdhE/A/L/iovLXlMqPjB8aSuupNQQTu7+1uB3ioiv5OPvB7nuJtu5HTqsHSZuksxfb+JtSw7QZueTiWgo+vAUpUA8fo1PsoHfwZV71uiEsLhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRy7bNIt; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66f1b5e17efso181441a12.2
        for <linux-scsi@vger.kernel.org>; Sun, 05 Apr 2026 16:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775432648; cv=none;
        d=google.com; s=arc-20240605;
        b=X/ztPKQtu3D3O8rPqbZVHlyrwhNerfnRCie39GJZB9tW5OZiifkSmrtjBqlsfDaLdx
         TtVlMaPGhBsDaKOcvoZiFa1oc4x3RVRF7d/0lnawM1aB4ZqNJRDorhfW8Y4u9oQF7Dd+
         HuwS/aEVUe08k7ZN8HzX5gTgL8vr+XPUcvhfpFw5Ez7oApWVng6gclJiMOt6nStvpjES
         U+gje0ACD6TaHpnzGd+L4oz6JXcsfAdEs8GDFzTSEbTAPq44bcCyz5DbDhgsT9xfoPxV
         Ly3ZdWTj+3Bf5c3gb67fzTPI58G8lUcKV4hvsY0Glb2P8BByZHBLMSoxUnF+ZK/1swvR
         G6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=731bzkGejKiWn0AArJt3Lla7/3r8/MQoMnaJI7bVslA=;
        b=coODT2F1uM6XX9B1V+34UtL98TjeIGojx17euuu7FZRakk7K9rSNur59RcOsa2XPBP
         Mvt7WXI8NLOdqHXywrWDqqI3+w24+P00NYArmpPxgC+17KdEg4mC9Oled7v1mwtAG/jB
         wVnc8zdUEzP39Abc5exU621+jUlMixcytWSA4Ge4JXHEeQG5QE4Oh1gC5TfYuow/XBVd
         I2bCjy8twgdAmCsKXLMYvHsPHJ1hkrq8Gg7zO98xf0gQZoC0aUz6YcQ/OQU8hj6C/xnr
         eIdSjgsyeRuaw5DR9JaKQCyVqcWkgGNKj/e4RAYIRaSk/Q+PCfBOWP1wSoFHs/L20W77
         yK/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775432648; x=1776037448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=KRy7bNItuCMjRdhQoDNXmvbrUzsJ/EQuIgectE/2nVrOvHXbxXJ7Qv8UgDHuYfkY1/
         vHf7uRCN0nuZrK5x0OMSNHgPQTpoccJlPwNv9HFLWDmhlARIhVmqRciFrzzDYxifwjL5
         udsGHiQPcPEKcVvraB0avyXDnTsGkpXPkjR+o+kHz/vQ4bGr1wHD4nFPVdU4+IIFachM
         XjFYJoBIkM7dRlAz/LiL/aMthXyxznCmQ6myhdArXSmod+VOkJEP6gcfOXt/JfrPbXdO
         v3WEPlCuKnDFA1J7jZnDHld6xjg2nUtv3ZNb4p2TuBJWNcymrz0vus1KC4orXYifThNO
         ga3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432648; x=1776037448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=q8gRwZk2VhuPYOoA37c/e9/bF9e0iYORA9i8cGIEea8FfzDn4Hd+N4DQWxJQ1Ca0AW
         AdKDB2RGrTS4rho6ItUR/Q6J+yxg8oUKODa00zwIok8D9AabjMdxfQ+sAynnewzJhlbz
         4I0X6yrIvMFPRfyM/+8r+qk60FoqdL0/j/U9v3JR3CUuO08rMzC5+/g0+ZNjn2idKWDA
         rEp+/Kt2U5Sp2UlaVtTnWgGQCgAVkZoKaBb8dAWELrHG0w4N+QwS43tzNvhKdshlnrqn
         txnme2lfgTN9Occakt0yKrn6Mf/CgttQ/EN8j348zD3lBwKcIJAKl0S12N/fXdFqD5se
         4fIA==
X-Forwarded-Encrypted: i=1; AJvYcCUc8FBZqUIiWFk1kdfGIo57iWQFcVOI+8U/wB5KsgaPGz8hJMifBgukHK9olIPduiRSm96ClEo8A9gv@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCaajI8HaAe0glIiD83SLy5Aqd0Gy4X0YVMXGb6nUXDlZeyEL
	QU6XEutGGkVoQHU/Q76qgmuCaoYpjw5Q/q1qeorPkhxAokc61sO80elleEfjCugS7+Masa+GAYH
	Tec1ItzzBFDPWe9OEVlHunD+eLNP4ww==
X-Gm-Gg: AeBDievEpxJ/MkEP6NUe0odWTc+wXMTD+0sC1ZBzi6SI264wIqZPOjqOTxvcSf00QMW
	DEDakyeIHLpbWeNbEr5LaVjEAzdddxIy9liSrdwDFHJV+wezkFUQdDgneIiQwdzcZ7CzFXA3rD9
	sIJh6KjMPwDF6B8YdWDW5j+vdkLsWVWnKhBm/+iM2jWqp2KYGM1IydMmL03QIMgASO3/tEzOciC
	yShjWelaBUhDdXQHPU/UcQRXWcjxwZfNBJkC+c8SpE5zemXDRa+pc8m63Nzo9eCuwj2peEw4RER
	4hN8XH5pF58v7J3FkiQzTva9uZhZnNE4pGcfwIe9tioGx5u59Gf0h0S+V8srYHEL1AOXqA==
X-Received: by 2002:a05:6402:430e:b0:66e:f4c0:c365 with SMTP id
 4fb4d7f45d1cf-66ef4c0c656mr717744a12.10.1775432648191; Sun, 05 Apr 2026
 16:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-6-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-6-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 6 Apr 2026 05:13:30 +0530
X-Gm-Features: AQROBzAe_pR1JdvPMRMED5Vbpy-Io1YSGKtG2B-bIRotwUzCJw2tWzJbmfKAgHw
Message-ID: <CACzX3As8NN6n3uCvOPhejzZCs4fTnXkohKvZw787+OyP=tpnNw@mail.gmail.com>
Subject: Re: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22784-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 809163A041E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

