Return-Path: <linux-scsi+bounces-22240-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKzRIH81vGl3uwIAu9opvQ
	(envelope-from <linux-scsi+bounces-22240-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 18:42:23 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE842D02CC
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB27930406A4
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC83EAC75;
	Thu, 19 Mar 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hzYU80kQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E55393DE9
	for <linux-scsi@vger.kernel.org>; Thu, 19 Mar 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941954; cv=none; b=kZ3LDFvTV24uzJjDK/6/A4bB17SezhflnK8OJ0gIcUiBNlsvETgLcKf1G800HZv5H2kobhDr0LtCp8Kga/hk5FswyOabUTm81fWPXa6DSDIwekdqo6e7N7kF11U+QF04rD1gSarb4syxFk99iyhMAaQvlC5dOrhmA1ITtP3nCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941954; c=relaxed/simple;
	bh=QDL3G+W4MxqSqEX9M6mr8fifEWbh4rxP6OX32NsjZRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i+aiaFuKxi4BQeRqrTFFTG+BNLv02wxxywM2OTFFokzfZ2sINkZA63PzklhlZSAZH/e1dVQnceUiPpIz6c/s+3WudOdUEAFytbMllDCyxmp91HuO+OVSG2J/ZGTzvUItqdu8LNPlLEcTePJFhLCcHaM/7VDF+gExPDzvadmYZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hzYU80kQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d76a331ebbso541686a34.0
        for <linux-scsi@vger.kernel.org>; Thu, 19 Mar 2026 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773941946; x=1774546746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokKrrzIKLchH2dWQCsaIIGzoszKxTOlL174aQT4Xac=;
        b=hzYU80kQ55rAjPYIBJjYt2k7x/qcoaq98rydImdj0ntZ8xP+I5/hnqpgp6TNQCBfyW
         YTxABpXqLpMATAViAj0jel842tdTw57pNlFsYklpxZTUN3eYcYrQh8mK1phE5tqpqTil
         PdT+qulm2/2UfOQ6gF9t34M7z1O5Ard2aOQfqldHFlOV13jbr4n/DLJIB84hOkgrjo4B
         Jv/f8t/6PZrcSDYcG+du3D24KwDqgEJ5+xV1hywhXIKSp0bkWkTNeIwYUcNF+wLulpzz
         U+ZeOcp0NE5SrNf4TBg/rVzpw1U526a38X5zgbVF/a/0/EixJM7PapTyXey6b6Hzow0j
         ZOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941946; x=1774546746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yokKrrzIKLchH2dWQCsaIIGzoszKxTOlL174aQT4Xac=;
        b=oCSM+pUxYqMQUlfGM7ouZkPhYkyptFnRFfcW+7gZt8hB7VTf3F3i+C3+3o2js/T7k1
         TjAf5S2OG2L8Ox7YKISpptiaWzpgqSgstptxG6kaCf/uTAufYLtXQl6lMmaV+9bUEcM0
         1Z9poqJafuq9bmLEV22d3D4T9FjudK8u0K1dVfkrrbE6UKU4nJ0tQw6aB/RxPZbl9OP1
         8xjW+Kd+uhOITsCQxsTdtx7TgkLpnrtaLhk+3YzG9neaJweUDacUkbEFya4ryJqvCCXK
         V0HUmUV9oK4S11auuWIuP78btlIb0pqFIZBem2kbgwvgZ4aUM1tIVOPVH8Ed4nJoTfr6
         Juew==
X-Forwarded-Encrypted: i=1; AJvYcCX5jaq/0nf0TM2954znx03op6n1Irl7HbFwg+vdpaOUUesukIk2KKN5E9kTXyxYhIt7er27Vfl89+sD@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2PeLZAi9TMIfbC5T2R8yG0Lk6Oyj0sOo3VxMEkO2tIClSlKa
	omTApqiNwkL/wDHMyssiXdRpKjBjFg2Had1usT0cp8+GtJEEBOahg//9IFBgkPLMdig=
X-Gm-Gg: ATEYQzxHYFG5P2MMJSamoud0syd8CizmgBhk7WUDhtFOzIBCERxFCC09tW77X7qM9wK
	pb9YCkwjeDRNG0oBUsacuQZc6yas5P/1qcpaE4NlY+G8A3Iae7NqUjRkPNtEl+zQ8CSNwv4mOqr
	8dOey06SV4462gqFoGV5f/96nyZB2DyIq4yarDBnKsgHpaXtCyNsB5Uyi8xdbewYoLTP16zkPyQ
	8vXhS9OGrL/2fLluNBSft44rNcG+ZIVk80Iqa2h7K6hFVfMF5g76fKNr048ggD164vu4zsr83xG
	+6S+6L1FfJCkEBtrnlYy9Hv8qgeGOPJwwRBE1qRI762kJRV0st2TnueZHTh0kAek9GAUEqBZGqm
	HU+BUpflKIQqtmB+I8EjhkPtGGj+Gd/Qso2684Cz7KVn/cF/19KtSQDYyrDVafmhOc4POhNUM67
	c8tNl+noqTEu5RP1WnBLga+P41Qidu9ygRZaWOtj466mpKvgqb6omSLu7E9gxlJTlm4AK0/UXsr
	04=
X-Received: by 2002:a05:6830:91b:b0:7d7:d4eb:b593 with SMTP id 46e09a7af769-7d7eb028ddemr23688a34.30.1773941945770;
        Thu, 19 Mar 2026 10:39:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eac1747csm73349a34.8.2026.03.19.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:39:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: fujita.tomonori@lab.ntt.co.jp, James.Bottomley@HansenPartnership.com, 
 martin.petersen@oracle.com, Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 bvanassche@acm.org
In-Reply-To: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
References: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH v8 0/3] bsg: add io_uring command support for SCSI
 passthrough
Message-Id: <177394194400.204924.4064617540444301186.b4-ty@kernel.dk>
Date: Thu, 19 Mar 2026 11:39:04 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-22240-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: 3BE842D02CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 17 Mar 2026 15:22:23 +0800, Yang Xiuwei wrote:
> This series adds io_uring command support to the BSG SCSI passthrough path.
> 
> The goal is to allow userspace to submit SCSI passthrough commands via
> IORING_OP_URING_CMD, in addition to the existing sg_io interface.
> The io_uring path mirrors the existing BSG behaviour: it currently only
> supports BSG_PROTOCOL_SCSI + BSG_SUB_PROTOCOL_SCSI_CMD and does not
> support BIDI transfers.
> 
> [...]

Applied, thanks!

[1/3] bsg: add bsg_uring_cmd uapi structure
      commit: 7da9261bab0a82bdbc4aafd2ad4bc3529b7cb772
[2/3] bsg: add io_uring command support to generic layer
      commit: a1e97ce80d9f41d0bb83951d758ff6fe49f3de60
[3/3] scsi: bsg: add io_uring passthrough handler
      commit: 7b6d3255e7f8c6df2d21504c47808e3ce84649ac

Best regards,
-- 
Jens Axboe




