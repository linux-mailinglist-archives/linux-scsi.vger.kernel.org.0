Return-Path: <linux-scsi+bounces-23887-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHNzEqlZC2oCGAUAu9opvQ
	(envelope-from <linux-scsi+bounces-23887-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 18 May 2026 20:25:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78A572380
	for <lists+linux-scsi@lfdr.de>; Mon, 18 May 2026 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3338F308668E
	for <lists+linux-scsi@lfdr.de>; Mon, 18 May 2026 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A7382296;
	Mon, 18 May 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S9z2BGaI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3871380FF2
	for <linux-scsi@vger.kernel.org>; Mon, 18 May 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128293; cv=none; b=ZMq89K/4mf196o+JBK3Ulw5/yAzz++74aMkHRNrR/s1fZq4Tx6OMtMzDOQwR579bO80GRDE/eqryMHsWLIxY+lG5mIWYRTcHLsrZwnhVKIfcKPuwWxlFLxOg1nQCUiDt2rzDkgWMkDFLJTaVRmgc6ezdbLHtHO1hG3Ui+PpZ1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128293; c=relaxed/simple;
	bh=LQHASLfc/8ST+1AvaJo2ffAiHssKfKIADuKMj+QoUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyaEUURSx4T7ZqjTAyaIovHhGGHM61MJzbe/rFfD45ObwSljjC1/lID3mM21wjBrYys/czQ8sCr5UHE38UbqnKeNcsIv//W1gCbnl+J20AYpSW9fVVySja/aFEXztZTZhzxztshsnGb7ARhe7OjGsTEmS4YDppcCMMQkAJZAKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S9z2BGaI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso35600485e9.1
        for <linux-scsi@vger.kernel.org>; Mon, 18 May 2026 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779128290; x=1779733090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m1g+ATuKbyZilaojQCyLOTppKcy5nuS1r/nHlpDz9o=;
        b=S9z2BGaIoGT70+9dti6remcxLvWMjQ45gFuIWelr5vFjk0ny0403UxqmQVAlzQOvms
         iweb2Oiw05MDwGh4M36Kv1NrzYnOif6TiSLlpJu1YWKhbOz8Hs7+RkWDHLIF9jjCYoGd
         vWJNt5m4OYABFomCJ2Ad+id/kRuisdLxRQn3bEYMbM5ibfMK5Cx+1gIB7T0i4OgSRlnF
         kvIPydSdkfa2WkPhwW5Y1GXwiv5DOmZjISJ4yexYHJEb7hVX861LvGVRJVAWgv2WU/tz
         3V3brU+Fvax6jlzMIZatYPK+LGXIrnes/oTW/XZXlyiXIMoK5lEwp8+lN8cqUlMWpDUn
         Ey8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128290; x=1779733090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4m1g+ATuKbyZilaojQCyLOTppKcy5nuS1r/nHlpDz9o=;
        b=Y9NsmDU6yrqQCOWLKItIB97YegrsQdZSq4Voy1LVCRKJJYrmbkOciJBOllHO6ojB4Q
         Ioo9lhrYzFLQ3R4J0DSKVU3BkYdsncwTflVToTQgtV4+ehNQys9feYcYvvlSliyuidKY
         nF0Gr55itE3MsnxecxG+Y3wvffz0r78n+pC471JL5dmxeJ6gF4112d1WLLp7mc8jNRLb
         2KRz7sjL76Q5/CK7tecBmaQPzjjoqA/sy5giGAxrhyloq72sGj+P/a/RdJEZXEmVEwhl
         Jx+P5iWm/EbluaYW0YawbXOsB2wEqM+h+6SeG07/CFfbpVBvKuNjR6/XNcv/wAKsl894
         CVKw==
X-Forwarded-Encrypted: i=1; AFNElJ8w6B6VNqOqzMjxojLYckSJBFDUFel6ikdPQLM6ghyAkkv/gx/PrLDigSi64xIAZFuTnDeL+FZBZaFF@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTn/EsCTJ0AmXhtX86hKB0LCWXcZfE4xLcfKC4zfjeYNSGtOR
	qbVLRfMng/bJT1Od+dCPBLSGlxpB/rkPVdMJD6snzz2TLzc6YGtg1TKSGO7mfUNon7w=
X-Gm-Gg: Acq92OEIVuZ1f6AgT711+113K+Hhghsjvhugy99nxkC5ipeStG+xOWxSjLFWB/0IebP
	aLLNJCrBEvW7/eyVuqUzeJUiz3QLQEI4RxD+LeM3hkfxrWbxRhGDZVDOd/+5ysEZgQUp4p6X+Gn
	0/vMM6WFBWgGkIYrOoFzDEPGZTCVVZYymWfZI1it1D1+DruK2SvP7w3O/ldfKCNGhLGU7OC1c0v
	odN2arTk7Thhmj8IaRmfXFn6W4z3NPofULlooWPOToPtw27Q8g9HF+5j5sGG4MhS4dcQTXj9svR
	C4wLyjCSwT0L7fpH4DqUeOpzg7dXKbpYi0GsMeGOj32E3YUuIaNwkL4mtIbTkZlhJTvzbpaic5E
	vjtmxuhEN+YfdPO9s4liV6WOEnfln4PzWrNCZQQmTWH1Y13AbCHYflEr0UgIBQElYB8eC3pnfAZ
	7zBfEAIaw8wghLORyM8fUagnRXUuwXx2ioUuGzlJqr6/vTLAIraMLbpwDvfMLEbJtcLXofiTHaG
	aie0QKHFs93xwKpHs/c3tam6c0255rNrRfDFrf0iFfpfvA7xAlSQCvEJ5rME5a2eV8FP13iFtJN
	jF7UdU+eyWzEMWtp+edKXDhA
X-Received: by 2002:a05:600c:858d:b0:48f:99a9:bbd6 with SMTP id 5b1f17b1804b1-48fe6514d1amr200206795e9.24.1779128289866;
        Mon, 18 May 2026 11:18:09 -0700 (PDT)
Received: from brian--MacBookPro18.purestorage.com ([136.226.65.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm38377796f8f.16.2026.05.18.11.18.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 11:18:08 -0700 (PDT)
From: Brian Bunker <brian@purestorage.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2 0/3] Rework the struct scsi_device inquiry information
Date: Mon, 18 May 2026 11:17:49 -0700
Message-ID: <20260518181749.28686-1-brian@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515205222.1754621-1-bvanassche@acm.org>
References: <20260515205222.1754621-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23887-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brian@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD78A572380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested this series on top of v7.1-rc3 on a host attached to a
Pure FlashArray, with 10 LUNs presented over 4 paths each (40 sd
nodes total):

  - Build clean.
  - SCSI scan completes normally; dmesg clean.
  - /sys/class/scsi_device/H:C:T:L/device/{vendor,model,rev} are
    byte-identical to the pre-patch kernel.
  - Multipath continues to enumerate and bind devices correctly.

Tested-by: Brian Bunker <brian@purestorage.com>

Thanks for taking this on.

Brian

