Return-Path: <linux-scsi+bounces-20689-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECiPOAa+gmk4ZgMAu9opvQ
	(envelope-from <linux-scsi+bounces-20689-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Feb 2026 04:33:26 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD6E1484
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Feb 2026 04:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8F830F562E
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Feb 2026 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50B2C0F6F;
	Wed,  4 Feb 2026 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tier4.jp header.i=@tier4.jp header.b="E7hatD3m"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903C29E101
	for <linux-scsi@vger.kernel.org>; Wed,  4 Feb 2026 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175924; cv=none; b=dh/ufgHKaUqMpj2EGs+IH+9r9y5rz+cDVmBNP93MLSKoSIdpb4J0WI2b1LXfpXCxgbyA4rfokgKiwbVXZ+27BH5TiAAsgw6crcCTc03a9dOFnip91IeZoYlzs9uE7cJfB++TZ832iQpnuioQzR/HUWBCK8T+oSmH684Dj99fzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175924; c=relaxed/simple;
	bh=pQbKpNswXJTNi8jP1PSICS1P2ix+Ty3CgZzKqkQPvCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8LfbSSUwRZSB5dR990ftBXHBaX4y51rxMObE5PaqnIGN+1u70gx+ZJSvs0JviK+XsyStNizSbirwkAV6FneQ0n2UBznaReJmf6TCFoW7Rg8LSphNaYchNgCDfLh0OGjKPu158YB+ynqMciTJfyx1ph2QKup1SK3wqv1fO8Ywwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tier4.jp; spf=pass smtp.mailfrom=tier4.jp; dkim=pass (2048-bit key) header.d=tier4.jp header.i=@tier4.jp header.b=E7hatD3m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tier4.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tier4.jp
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso44461195ad.1
        for <linux-scsi@vger.kernel.org>; Tue, 03 Feb 2026 19:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tier4.jp; s=google; t=1770175921; x=1770780721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQbKpNswXJTNi8jP1PSICS1P2ix+Ty3CgZzKqkQPvCQ=;
        b=E7hatD3m4DWwpjltD2KLPyDq993VnU+RteBlAdJRNdDahc1dYlJ1PccAb6qg8/4rSm
         HjFckneOpgprtVzoPBAFgV7ZqrKkb9gsfbzW1of97wtxipgQ+G52vIVXTxhZGQMtSh6h
         Nx6jA3mYpo/OaBgs2iHgl8XKK7sCAAniJpzo3vA/7pQjr6imCDN0mVtGQnFukHPqzMDB
         M/BrLuqyf4kBoCeSvmXSIcMOqWb06ka82GRnfTo7lTIkmijWMWciLwhhM3vIcG7cnM1X
         gBZ53sJsQcTTUO14YK7x+SThz54QbXzYAjaRg8UjP5RidCKx21Ku6XswYjN87Ulk46P0
         6AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770175921; x=1770780721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQbKpNswXJTNi8jP1PSICS1P2ix+Ty3CgZzKqkQPvCQ=;
        b=vjdSOQMlRFYccKmDqLNQhJIhk2YPg4Tng/ppzvLHe1UU20wok2RTvcPS/xZNzt1nPT
         HFktHAkpWvp/78h/FXiS+1lJdH4NXSvIdAbIUNbujVwbpAp1QVUp3y/Kdq/Xh83Iuhu1
         RTiMEgIJ6eumumni5iBpsHlb4Tao4LeTirC2Q4l98jvomVwpLEtPS2Bu8D+y/oOTUg7J
         S/PtucEV2L5zaMlgRcWQE6kgtBSKu9uaWDoKCmxApUdSRUw/K9GTf2g7NE9xYdKbvtYJ
         ynQ8GK2H4EZp0cuyKs3koH8AbAD8LUgQTtwu60/MMktg3+Nq0KxoNSdqwadqAKihAxDg
         osWw==
X-Forwarded-Encrypted: i=1; AJvYcCVh5mN9H+O9Dvu9jx2RM30z5WcSMJNgOV3klhJTKRiOtj6tb4KkUuuODFrIdHMwtW4+dKQrVyclyG9Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1J12wpgwUPJYhH5o0TRQbPpLkpzf5f6QgKv3NXGKkWnOcMv/8
	AUx1tu5IsVl7o+zWYifE4MfG3+QAkLEdCeQcHsBcBU4yDHqcDUXaTKBp8GVZKY6mfEI=
X-Gm-Gg: AZuq6aJC/IZYzoPY3cn62tE6njDsbI6Zm5klfA0EvECqudKHpNahKarkNW6BX2f9ZMm
	b0nMptZ5NxC96VF2tBZiRk35C+dbA08kZWP7XARNGjv7+16eHxs2oXlmJ/a+SwQrQO+FcahL1rj
	BVyo5krtmqP3Tw7akb+Ykwy1bwDS7aPqlXA6a2G5OLNdIkmaaxmH0SyNr2lAVfVTFndEQDTseSi
	gLwjcrLUPdy5XyKZWEdzQ39deONLY3j/9LbGQ99WVSNdz2mzRouFuTqfYkfuZeAEoXRTmQDVn60
	o9fclguUPTlE+N0XdLo0iD8ZlyMyn36Rb2Aba5ZixbltNKZj+6PilCIYfubpE+tgzbRzo19v+12
	lUFbjM2w9pY/EgndMS6jsv26N2r63K+X4cRiUhISpCKeNm5cDQiKJl78ORJA8cQ6y5/3yOmiO5o
	H57QNwZ2WQXxHIPdZd/2Z5XzKtvg8wrVjEvKworIVeBeEoHWM=
X-Received: by 2002:a17:902:e74b:b0:2a1:2b5f:d16b with SMTP id d9443c01a7336-2a933e515fdmr16462875ad.31.1770175921652;
        Tue, 03 Feb 2026 19:32:01 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397ef6fsm7931335ad.95.2026.02.03.19.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 19:32:01 -0800 (PST)
From: Keita Morisaki <keita.morisaki@tier4.jp>
To: martin.petersen@oracle.com
Cc: James.Bottomley@HansenPartnership.com,
	chaotian.jing@mediatek.com,
	chu.stanley@gmail.com,
	keita.morisaki@tier4.jp,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	peter.wang@mediatek.com
Subject: Re: [PATCH] scsi: ufs: mediatek: Fix page faults in ufs_mtk_clk_scale trace event
Date: Wed,  4 Feb 2026 12:31:12 +0900
Message-Id: <20260204033112.2513463-1-keita.morisaki@tier4.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yq1jywtnq7o.fsf@ca-mkp.ca.oracle.com>
References: <yq1jywtnq7o.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tier4.jp,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tier4.jp:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tier4.jp:+];
	FREEMAIL_CC(0.00)[HansenPartnership.com,mediatek.com,gmail.com,tier4.jp,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20689-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keita.morisaki@tier4.jp,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tier4.jp:mid,tier4.jp:dkim]
X-Rspamd-Queue-Id: 4BFD6E1484
X-Rspamd-Action: no action

Hi Martin,

> Applied to 6.20/scsi-staging, thanks!

Thank you for the update! Greatful to contribute!

