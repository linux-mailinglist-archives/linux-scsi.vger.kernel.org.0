Return-Path: <linux-scsi+bounces-22883-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MOkCWDy2GnrjwgAu9opvQ
	(envelope-from <linux-scsi+bounces-22883-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Apr 2026 14:51:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D63D7B9F
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Apr 2026 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9883056D3E
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Apr 2026 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB241DF256;
	Fri, 10 Apr 2026 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NjXY5OkJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEA8F4A
	for <linux-scsi@vger.kernel.org>; Fri, 10 Apr 2026 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824912; cv=none; b=ujKnlFy1GUmDRia9vvw2M6SA5bPH3MmbTO8kzX8hvJ3Bg/DZTgC5csNF6AVubbc6OKWqwlDqYJbGwb/ytpuzgANxQr2fIaSmarSU5ySwvJmKcT6TvJxwSNYH/bi5TG3BanB5wj3ATpdUK0tVe9QkFqyorVTxCdlKtz2fz83+MMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824912; c=relaxed/simple;
	bh=fUTvlatld455rE026QHohXmYqmcoXXtgAIxQDnIzF7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KQnKNaGz7RJd6BS6ab4quINnzK+KHJYCfLISimpK2ox4coZ00G2Ds2kSKgWgOZektNU8DhPorUHTdtWxRWsBXlzorol9mstBSv0N/NbJnVqKjVEFhQY9U4LSyRnbAPUEW5C+GXn+uhFgz1SvdRCnsKK2eTgN3zGQhKxUZG4xEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NjXY5OkJ; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1fcce8f8so749483c88.1
        for <linux-scsi@vger.kernel.org>; Fri, 10 Apr 2026 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775824910; x=1776429710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiALXUGoApaH1OBcmKA7Ty9vDWz9xc/ZD0RE3/YEPdE=;
        b=NjXY5OkJvB8z0f/FqhUMNHHKq3XevCmjHu7TAFY7HVkfC6baRTI8PBl2FlsrNZLTgY
         CSFN9dS8UX/8vDh59M9PJY4SplPsAqCD26C+xFBXRAwg2jjGDaMNRLgLghGgDhfugcIf
         hUv2VL4mXQenIU1rEAbt7krHJkfOOLOC30ObzAsnFHOVmHdWyg4DpNdVrSvAHsUITAQ7
         FBHSR5FJWn/vZc15YPOGKsS83OSHdq+/VcjIMrjn8ZvedxvlcVDli2fvA6YFcXS9mya2
         XXTJgt9uJegeAIb1M5jBEciu8ZbPjshfgW2shVnw2nFNyedUCIGl8IbMWSs5ef43PVr1
         KCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824910; x=1776429710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiALXUGoApaH1OBcmKA7Ty9vDWz9xc/ZD0RE3/YEPdE=;
        b=IyslTOv3gmWmR4jeDRbHZTuD5oiKM1CljqzzLoiDCRPSxqq2bpUfik2tbmG8wYsfe1
         4LUCz/xDYBtQplakElXCrMunJw6RxNLgOW+MWKKealrigGqUUusixarzhlfCVgWXiPMY
         PYnpFw2ekkqqeneakHFqqfugh/l8Qb+ZXp04qsrf0/bExoTlzCTAopYvvMT47V0X1yAC
         QixmyhYADG+BXEaN8qMtES40Na2rPoe2Jdw0WvrJLgovKIIQjzx8OXROHjgMYCKKEEJm
         VK+cZKM1H5iVn2Kq1QRVVbFfMdM2dno6itpOh5S3UsKAHkNKYwQDPNZyK7Kls1+hqybn
         KTqA==
X-Forwarded-Encrypted: i=1; AJvYcCXqtbq5aseGly/91AiY37uYfkYnpi3SQH7qmhy4a8kuyvVMGUWKCLIYxveCtLSrYAFttJhNIAeYDJjT@vger.kernel.org
X-Gm-Message-State: AOJu0YybQxWHzrxA4Mhzat+kgfpru3C5mUdg7oFGmaw/JWqDmJhlOYwO
	8lFwGrdqM/Jdv5HWrkXmLpHubxVZX3CZMRp4bzd+TcbI6iO02jKvboaXujOVa3FKEbH/3+fAAMM
	Ia0cM
X-Gm-Gg: AeBDieux8SOMPKZV7R8UmMdy2D/VctZqGtg2YSN7Wq+hRAyfrU/xQoTrUUYtT2s+yZk
	QtIIaSpGRcOw1KhfJjwbftyO7KWsBDYicI6A2eKKRiCmnE+NFBYVCNx9cK9RH3pA6n6JoKIYA+I
	Qu/SaEZ/qWKiyPY3nIPRqQxcdcxyJwlHJhWjZQH/OUpO2uo9yTvlNnZTr1nMAg80lg/dx4RBBai
	vSp6GoreFmPznUyimx6+R7aOGOGLY22PePBKMxCLmMOyk1h+EBXcCDpw5hAv3YpNmvsBFJqlDDJ
	LVG/p0QsZOx5FUPFfikqWkUXREnNNYq9jjCZkfVLl81Ed/5PpAXJ3wUJhaOv9qSfaOtbQl5UuKi
	0dMV9dMycK6tT9+m4hZqEvDyf6gZpfFnaayBqZYvV91qeK9V96rk29ISGkI6EcqkbRPJQhWUnKF
	XIhkR3zY8hsrt14SLldT9kragKX7OrqO2Q5/WtCSIA+SNSw0JvNjdOrzmiECijxSIchDykMatir
	4xEjmM/ZPHzZ6qYfhBb6S+/ajqgiGSMf3YB
X-Received: by 2002:a05:7022:e19:b0:128:d714:3ca2 with SMTP id a92af1059eb24-12c34e3f4e9mr1754028c88.2.1775824910269;
        Fri, 10 Apr 2026 05:41:50 -0700 (PDT)
Received: from [127.0.0.1] (239.sub-75-226-114.myvzw.com. [75.226.114.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb031sm3061572c88.13.2026.04.10.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 05:41:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, Dan Carpenter <error27@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <adjNnMYK7A7KMNkA@stanley.mountain>
References: <adjNnMYK7A7KMNkA@stanley.mountain>
Subject: Re: [PATCH next] scsi: bsg: fix buffer overflow in
 scsi_bsg_uring_cmd()
Message-Id: <177582490925.498357.11572099652786235764.b4-ty@b4>
Date: Fri, 10 Apr 2026 06:41:49 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22883-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kylinos.cn,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7E2D63D7B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 10 Apr 2026 13:14:52 +0300, Dan Carpenter wrote:
> The bounds checking in scsi_bsg_uring_cmd() does not work because
> cmd->request_len is a u32 and scmd->cmd_len is a u16.  We check that
> scmd->cmd_len is valid but if the cmd->request_len is more than
> USHRT_MAX it would still lead to a buffer overflow when we do the
> copy_from_user().
> 
> 
> [...]

Applied, thanks!

[1/1] scsi: bsg: fix buffer overflow in scsi_bsg_uring_cmd()
      commit: 0a42ca4d2bff6306dd574a7897258fd02c2e6930

Best regards,
-- 
Jens Axboe




