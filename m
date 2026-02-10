Return-Path: <linux-scsi+bounces-20772-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Im/IhkEi2kMPQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20772-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 11:10:33 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C334C11976D
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F3DF300B9E3
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FEE342CB3;
	Tue, 10 Feb 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3GoMGKy"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABB34A786
	for <linux-scsi@vger.kernel.org>; Tue, 10 Feb 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718228; cv=none; b=lxiwHSzYU7u3evwEgxBh5C+M1UxwiN28hkNzqPvlvnZQQW5DUCLuvrMAQnVSMdPFAphPxnwIyXoQGAnkH4qMAPaEFD7hKKacO0x1BMs9ft+wa+J5kSyxoBBe3MX0Fe1FlqRNkINNbbsKPkhhI1UD0/DJ55YUITgPHMu3gJYI7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718228; c=relaxed/simple;
	bh=wt7NnjuhYR2KBDv6JU/NFHr/7oZgaw0FyHpTViakKPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QTSkstoXQlzBtSKF0Hb3O3PYbmeMQlkSBoG713u6FEFVkK6sWnRNcuIQu5Y7dt2IbBRWDSbCxD/O5g8Tk56Yhao7XhHG0Kyk6KDi3PCzueGJy3M7CWvgfIo+sFEFVbIYXh//es8lBh8tZW5YCvBQkRa4pcmjuh5MgaKkOjPmTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3GoMGKy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43767807da6so455216f8f.2
        for <linux-scsi@vger.kernel.org>; Tue, 10 Feb 2026 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770718226; x=1771323026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wt7NnjuhYR2KBDv6JU/NFHr/7oZgaw0FyHpTViakKPE=;
        b=X3GoMGKygvOuZ4RvH7vv5Qf+V7apLLmo7o9uuTyA2Ok8PSIQg1+SPvkyZG2mHTH5XG
         KF/eJvKDlMwx9DSXSJIdhq1Zy/pqCjJ1pxe11uda/jxERXhIDiCFz+LYW8JVd0fHsNH6
         gJlD+Wb4XMWMIeL8Vi/lV3A+CytPbwxOyYxWwMYg3/q+LUGygzihbfPe1cOgED2LiQDP
         STTbmqznmGyw0hB07maIxo446JkuEiMk/dkaHWPwj/2m8Kd5cj9cDtQcr7cmEEXvKqpd
         vapSB3ORIC9wnZHhHoiIX4nQDCmgLb6Wezpcdf8M8nIByJRDhuSkDt36YokOtbxC8i8X
         QbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718226; x=1771323026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wt7NnjuhYR2KBDv6JU/NFHr/7oZgaw0FyHpTViakKPE=;
        b=X3pDhGOW0sxseDTYabq1dRyLOHSaPG6uEeKaOhhOIf6f0RsuEbDD6Kjo69JNXGX9p7
         b0YY2MVUJt9+ck8rlswfBHhH3ftsVghP7Un2y2i1DlZv5bVPn23rIz5KQ4tgC1bfkWAr
         YLd75RIzlhoyjmXz/sHKd3M9hTZ11gu1e8yRHatuJKiKRoR6WhA8if8lCGPPv8WDiMK8
         XLoD11CpBGQaxEr7ISc8vP+XdyLBQBBKLTOKX9gk9eVUqtQfOTdjijsBpi+zQyBZEgJD
         llJpDeshFHJynxq6EE5Fnb3gvxitYl7Jn4A9cqpbxtkCGtJuh5IclbUGhQigRBNp7AGV
         McVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLjGfof4/IcJT32EtK+wdVCYTXesDgvSsZIqEouGxbxMV3s2jYtUSmNBg/V6xMeFyb2G20C1qjAyh+@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzPQ6bp6nGqShGLyHk4HawCoUglMGRu26nvDb6r81ASo+zaAn
	t+NhRAVX3jdZI3a/Sqx+Su8psHDXiAKBlmDgCIFEpt7hgjjQlhGS4lgw
X-Gm-Gg: AZuq6aJ0uJXmuLAg1dR3aCkZIWGvJTykT1caASX5k6Lq3uTzpoN4vwUSTPcoQ/4/Qr1
	HpICj7w+5Z8q5eU3TBfV82ezoYuOzgaFw8C15LdoqVosC/LqKINVLNk461n/H7GTaQjkA3fcOvA
	A5uJlbRRt5aZTCiz6qGXhf8OrzGF1yEh2K2L75MVGdjKO4+zWZAfmyf1fwCo2siSkK3G98qt6ib
	sn7TET+wYMqvjxGimqSGtGFRyIqntCEK7aoqJeqaMt1XBPZcSf20llIkqctGGGbk0vVdKs/VdJN
	I0wMZ6WJ1owz2wgSK2p0WwBndUb9+brXRWcKwMMGb4kgWBslVcvITWBc490Cuu/D07oxZiP2rPh
	9UfhRH7gKNRH11BZxl8JAHh4vh4lfeMzkkU5utASgSOgnMKfolYls50t7+METoAPTBtmcSY0DdF
	CBxIFvpO6Pe74FZgYAR4WPONG1iA==
X-Received: by 2002:a05:6000:2889:b0:436:1a24:df81 with SMTP id ffacd0b85a97d-4362904b702mr20341629f8f.2.1770718225617;
        Tue, 10 Feb 2026 02:10:25 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa41sm36773507f8f.23.2026.02.10.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:10:25 -0800 (PST)
Message-ID: <12c200207a5e4419ed3f7ba54aaaf2f74db80de5.camel@gmail.com>
Subject: Re: [PATCH v2] ufs: core: support UFSHCI 4.1 CQ entry tag
From: Bean Huo <huobean@gmail.com>
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org, 
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com,  jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org, 
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com, 
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com,  naomi.chu@mediatek.com, ed.tsai@mediatek.com,
 bvanassche@acm.org
Date: Tue, 10 Feb 2026 11:10:22 +0100
In-Reply-To: <20260210071834.1837878-1-peter.wang@mediatek.com>
References: <20260210071834.1837878-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20772-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huobean@gmail.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: C334C11976D
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 15:17 +0800, peter.wang@mediatek.com wrote:
> From: Peter Wang <peter.wang@mediatek.com>
>=20
> The UFSHCI 4.1 specification introduces a new completion queue(CQ)
> entry format, allowing the tag to be obtained directly.
>=20
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

