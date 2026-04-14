Return-Path: <linux-scsi+bounces-22935-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHzMCAQc3mmFnAkAu9opvQ
	(envelope-from <linux-scsi+bounces-22935-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 12:50:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E513F8F5A
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09996300FA10
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA83396D28;
	Tue, 14 Apr 2026 10:50:34 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F273D7D93
	for <linux-scsi@vger.kernel.org>; Tue, 14 Apr 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163833; cv=none; b=MULe2HN7WPtG3tsJftdIMnXyaHEVNfsS6bTAHbrEwDEMPss1AK7c4aqW5KDn/TI+eOwgS9opH+fb9Oz5OcCmpPo5HbHPtvtaM/OUZjVtLH4dzDOFPuHaLzu1Yk/ohTXH8u7hIOXE7YrSP13v1F9tblYePxXn3mzq3phggxWboUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163833; c=relaxed/simple;
	bh=oMQZwEthIHyiT2+mLTjlstjxPSriw0qOEg4RBf5bop4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhGmtvmAvhGk5LLoXOSOsEaiz4ZRbFMB2uWuHq09RHpy0BrM4C414+594kACdiVFA9IeNwuKVs3TrwNmNOu5hUw8O5Wlt9LZbimc9G3rqjBFhnbmGYRzf5GSMekLW0w0RIpqaMzl4GuYjcosltdRthffE97O0C3x4lFMEjc8YrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Pj6uKORJRXKP5BeSllf78A==
X-CSE-MsgGUID: SlkVOq45QGS25jR2iqYB2A==
X-IronPort-AV: E=Sophos;i="6.23,179,1770566400"; 
   d="scan'208";a="146592278"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: <peter.wang@mediatek.com>
CC: <James.Bottomley@HansenPartnership.com>, <adrian.hunter@intel.com>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
	<bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<martin.petersen@oracle.com>, <wanghui33@xiaomi.com>,
	<wangshuaiwei1@xiaomi.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix bRefClkFreq write failure in HS-LSS mode
Date: Tue, 14 Apr 2026 18:50:26 +0800
Message-ID: <20260414105026.1543121-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <60e9a9f1a06692b0a4741058c2b9827c6bb98096.camel@mediatek.com>
References: <60e9a9f1a06692b0a4741058c2b9827c6bb98096.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX15.mioffice.cn (10.237.8.135) To bj-mbx11.mioffice.cn
 (10.237.8.131)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22935-lists,linux-scsi=lfdr.de];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[wangshuaiwei1@xiaomi.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xiaomi.com:mid]
X-Rspamd-Queue-Id: 98E513F8F5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 08:46:21 +0000, Peter Wang wrote:
> Hi Shuaiwei,
> 
> Okay, the ref_clk frequency is automatically detected by the
> UFS device. But I am still curious, if you are using HS-LSS,
> why would you set a wrong hba->dev_ref_clk_freq value, which 
> would then require writing bRefClkFreq?
> I mean, you can either set the correct hba->dev_ref_clk_freq
> value, or simply ignore setting the hba->dev_ref_clk_freq value,
> right?
> 
> Thanks.
> Peter

Hi Peter,

It's not about setting a wrong hba->dev_ref_clk_freq value. Rather, it's
that the UFS device's default bRefClkFreq value (which may differ across
different manufacturers) is different from the actual ref_clk frequency
being used.

Additionally, I need to support both HS-LSS and LS-LSS modes,
hba->dev_ref_clk_freq needs to be set to the actual ref_clk frequency and
cannot simply ignore the hba->dev_ref_clk_freq setting.

Thanks,
Wang Shuaiwei

