Return-Path: <linux-scsi+bounces-24969-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jdBPFl4/MGqOQQUAu9opvQ
	(envelope-from <linux-scsi+bounces-24969-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 20:07:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C66890E7
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 20:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=IaJ+YSu+;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24969-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24969-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF61330363A1
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFE26A1AC;
	Mon, 15 Jun 2026 18:06:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EA25B098
	for <linux-scsi@vger.kernel.org>; Mon, 15 Jun 2026 18:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546809; cv=none; b=fZGtSo1bHhHDjLQeMZU01jcI3+uxglk9c6ewTjWiPEo643uy6Iws+def4DxvJ4Ym+vxTBgqlUiibO6erOdi7bOeT00vn7SMMryXBFfoZXo0XLh5khRKl75zGqvlwjCVd1/cgDmjdeSytj3ifU6Godp1RhRlAQqs1hJs6y6aHs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546809; c=relaxed/simple;
	bh=Rnpdq8NO9Jw5OxxZ8Q99rr0E2SeEVouwaasIxxZptzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnQ1BtipXswymFyKSnKONASez6xEhpO+mwhM2Fo2AkvS12xk6HtA6S0nIRiDbUsQu/tHEKcKsmpcBtRDag6h88JenrLtY267iEAUYJSfx9OgEPuFFw4zer4leN42JKie2vISxPxO4TshtPoGpRBP8ziU2Z/6hDStSGc7uXqcStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IaJ+YSu+; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30b9e755555so947152eec.1
        for <linux-scsi@vger.kernel.org>; Mon, 15 Jun 2026 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1781546808; x=1782151608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnpdq8NO9Jw5OxxZ8Q99rr0E2SeEVouwaasIxxZptzs=;
        b=IaJ+YSu+ZgTXL/RAGcS2un5aCBH7Q1eu6wn9kW7Gu04AMTTLTG1r8t9U7s1A2TVlF9
         a/9PEZnuBPxg39gSUnmJNPLWrIag9b/wiA6ZdIvzGewiR7PNUmu17/KsBj2N/XJzVmgg
         qo5NgjKmxYkmHPqF0EkTxNaWbnXvPMw917WuaA1XuqAYqqozgSxmt2rRjnRwMbQobGsV
         t8NziT4NcUPeWxAbLUERzjgmANQkkP9UAgbOAnKnrpqPPU8u0sPqRl6QXLIHHHqJ2I9b
         1+x5cF1DmjiHi4HTs3pGLgCluQk6TdOaCIK0nimo3zUTQZB79RH3H7Avxnrzv2dbA1VC
         DVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546808; x=1782151608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rnpdq8NO9Jw5OxxZ8Q99rr0E2SeEVouwaasIxxZptzs=;
        b=s7dD6trKabNEYkvXPaVQhDFHrME0rEe+aBbEJG07aW7dbv3g1BJisUi+VDDhrFeG8y
         zN6CROAQKhEYepFeVMJSkV+rDP1wEfcyzjRfWqLN5cv2Ho4umhn7g+Z0qBJTpAg+kU+k
         bXJtJxUyBhIXx6iDUIb28a7G2W85f9UN3OhJJ6JUhqewdYtUg/A2tpn0Q9grtkzA4p6W
         /5YtDL1Xddk4/zxcPihcrtldHG/6LNrcAT8t2MU+UTIibRfY6qU6FjokgBP+loyY30v7
         GLD+V3Rmeu31rBhcmZsLEus7o4iLAMgJ+z17qdDM/NG4bacFfgTwlpoSQMPojfAPWC7u
         V7rg==
X-Gm-Message-State: AOJu0Yx6HFg8shDB7DezCR3FdG7NElC6sIpwYuy5908U0ERY8nyvy17Z
	VPW+Hh9lYsCdu6Ygq126wlG1lCiNdwMzXqoYPg9jkxYkp6dtvbQ4CmhwbscWCjKIraI=
X-Gm-Gg: Acq92OG4jnJraKZwP2aWKBuutVPX1WAXVoRR604u5jMAJS+pn0X0m89wT6thbDoM2fz
	7QSLzNvIgaJwo4IETo7OUrNGUBy+VEkPaSKYYQm5Ka3QE9DG+p2qk1hWSNyojoI/sq0t/WjBJF5
	B97CmiYA/IoeWP2bzhjdtDMeh2MnXCaV6uYQqdhFINJb3TQE7NO7IfIB6tDqvgeq+vFqoOl5LV8
	AgrFEr8pp3YY0ynKRriuqvoSHHa2YPks6Y9iau7D8BM8tcH7/I76aZ6Z/RM36zMEbNPoKe4c9VF
	Qjq1hcP8cJihBspD3Jt3oBsUObAztHAVpHwmnB701cOcwYvsS1kk4tazp1KN9SPePJII6KiqQXH
	3njgM/x651M9KqFAs+oF3mc2rpMr2O3JlFaD4fnX7fW1HKXV3E1J/KEL1z4ZPlJA/Lgut5Z3ppN
	ub5NmNvEgVTzAp4kxkl8vRSpNsWfZqmw5wSwtVla4f/VjV+OE4FDtDvYijlViE5qxjtkGIYQ73V
	jx/zHCFyjl+K1KoVQwFFwTuhsQ//AvHIKqrOl3fB2mhwsebvyIGMJx+F6Rx+l2mJLlD9DaXvuX5
	OuDJcizhLFSsyz0DnyH63+/w
X-Received: by 2002:a05:7300:1481:b0:304:df0e:9db0 with SMTP id 5a478bee46e88-3093a8ebbe2mr7216295eec.15.1781546807669;
        Mon, 15 Jun 2026 11:06:47 -0700 (PDT)
Received: from brian--MacBookPro18.purestorage.com ([136.226.65.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm9925215eec.31.2026.06.15.11.06.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 11:06:47 -0700 (PDT)
From: Brian Bunker <brian@purestorage.com>
To: hare@suse.de
Cc: linux-scsi@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	bvanassche@acm.org,
	krishna.kant@purestorage.com
Subject: Re: [PATCH v4 2/5] scsi: core: Add scsi_update_inquiry_data() for updating INQUIRY data
Date: Mon, 15 Jun 2026 11:06:36 -0700
Message-ID: <20260615180636.28266-1-brian@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011819.74466-1-brian@purestorage.com>
References: <20260603011819.74466-1-brian@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-24969-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:linux-scsi@vger.kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:bvanassche@acm.org,m:krishna.kant@purestorage.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brian@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[brian@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[purestorage.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:mid,purestorage.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA2C66890E7

Hannes,

Gentle ping on this -- v5 is ready to post and this is the last open
question before we send it.

Thanks,
Brian

