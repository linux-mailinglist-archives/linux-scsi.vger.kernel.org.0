Return-Path: <linux-scsi+bounces-23807-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOvxB/b+BWrFdwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23807-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:57:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B831544FF7
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90F99302166A
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99A34A3BC;
	Thu, 14 May 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz8G8Ll1"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061D31E83C;
	Thu, 14 May 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777799; cv=none; b=JqlId/4//IT3Kr396BVNiS2//bEaLD8R8eXkIybsjFmy0f2ddqIKAJHdpXnnm6R0Aw/crhHpkC0VYW5SWBpw7NtnoEU9BhH6opJ0WVM+0HbSs7pffOVxCadkkmPPCbiZS+nwJ/qxarFjeUyBwlCzbw3s6sRey4DEgPqRoTaZvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777799; c=relaxed/simple;
	bh=3toBXMpP4awO/mcKO1JYvkg+Qt/cHhm2X0K5cAsGqDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IbZ4KXAyMMEUnVwlIfw8QqGMJibXB2zzGqbju1/2+4/NcqM5V2EuK7tBP3BL4hcrt3e7hQx+PH3xqA4AM/eLf95sSzNgpiDuQ9lWg22otmkM9RG0bIhA2MMg2WcknTH0Q0TfemA4KY2o39Yhw//eO1LvRzKdulwU9wKZTNIVVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz8G8Ll1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D77FC2BCB3;
	Thu, 14 May 2026 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778777798;
	bh=3toBXMpP4awO/mcKO1JYvkg+Qt/cHhm2X0K5cAsGqDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mz8G8Ll1E7RkkDyz25X6LHsreB+eQUx2upkprv9Z7RGKO8GSjIAqPv1oWWZCbMA0m
	 FBvppxk6YEuOr2bW5XHDwnBETL/Uf7VQ0CG9mtgwa5kYbmnItv+x8eXf6+b4PMrX1g
	 dTUKheLGs8+Dotju2tV026tZSbSiGMt7ZrGElBbyEgH+ejCjxMIImxWniXhyQ1i/NB
	 /G5yiFdaztNlTC32oNfr3iFl+DJIvI7r3TjODt+pWr/2dOMQnIO2wU/5YTpRFbRwsu
	 otCktyLEdmsKlQ4BXhzyzSmSEd5Sw1x9h2SOilgyxiHJISJQU5NQXmoFW0U1lgmJbN
	 UHGToBiTxwXlg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org, 
 martin.petersen@oracle.com, krzk+dt@kernel.org, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: sowon.na@samsung.com, peter.griffin@linaro.org, 
 linux-scsi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260417121452.827054-1-alim.akhtar@samsung.com>
References: <20260417121452.827054-1-alim.akhtar@samsung.com>
Subject: Re: (subset) [PATCH v2 0/4] add ufs support for Exynosautov920 SoC
Message-Id: <177877779617.167822.12072849768585215518.b4-ty@b4>
Date: Thu, 14 May 2026 18:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 8B831544FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23807-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Fri, 17 Apr 2026 17:44:48 +0530, Alim Akhtar wrote:
> This series adds ufs driver support for ExynosAutov920,
> ExynosAutov920 has the UFSHCI 3.1 compliant UFS controller.
> 
> ExynosAutov920 has a different mask of UFS sharability from ExynosAutov9,
> so this series provide flexible parameter for the mask.
> 
> With this series applied, UFS is functional and basic I/O operations are
> known to be working.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: exynosautov920: Add syscon hsi2 node
      https://git.kernel.org/krzk/linux/c/14b0c168c7038f1d9e50f27e47d8e285f52cd2a3
[4/4] arm64: dts: exynosautov920: enable support for ufs controller
      https://git.kernel.org/krzk/linux/c/ae326b14b2a5a5e426bea0210b984ee8dc5ed0bb

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


