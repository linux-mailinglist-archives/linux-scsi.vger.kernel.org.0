Return-Path: <linux-scsi+bounces-22921-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ISQJNW13WlRiAkAu9opvQ
	(envelope-from <linux-scsi+bounces-22921-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 05:34:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AFE3F5488
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287C0306CBEF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59730B529;
	Tue, 14 Apr 2026 03:32:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B75275AE4
	for <linux-scsi@vger.kernel.org>; Tue, 14 Apr 2026 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137551; cv=none; b=h+7oS8ZKsYTQHFJHqJCnKY6zl4X4E8g/YVO5xmsWG6J16eFEpAXwXZKBpGVEgD7L7BdGX/wEoJG8QAOzFGZ+/lay5nmT/xkMI4+0p7db06OnVnrzJ6B+FfVBl5LlEmt5sCHpNo07r6gBkjW4wR+XBf4Gsb00QvFx6yZs9AU93xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137551; c=relaxed/simple;
	bh=bwgMACwiXb9QBX/GUscwZSjtI4EHWUgYIvGymEG61YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOHQN3B95iYASfrUkHw7chLB9mU0IR53c3ab8dsuxCmhzql6X2KeyojGPLpIyVE/4iC3cOpUtmta6UH+JhDie1aXLEEw6RqGOdTLXe1yOXCHvSDufuiKw+QqajXAVrFmVSGFjsLMk8cl/e+ta3xxw2h13PKkLyWZOx0zZsxZSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: O/L4Ksf5SxmEL2P3HmsyUQ==
X-CSE-MsgGUID: +HHw3vkLS8GXHy6fc9EEMQ==
X-IronPort-AV: E=Sophos;i="6.23,178,1770566400"; 
   d="scan'208";a="172727058"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: <bvanassche@acm.org>
CC: <James.Bottomley@HansenPartnership.com>, <adrian.hunter@intel.com>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
	<linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
	<peter.wang@mediatek.com>, <wanghui33@xiaomi.com>, <wangshuaiwei1@xiaomi.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix bRefClkFreq write failure in HS-LSS mode
Date: Tue, 14 Apr 2026 11:32:25 +0800
Message-ID: <20260414033225.1454960-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b8f882ae-ddce-4ab5-8c8a-28efdc31bee5@acm.org>
References: <b8f882ae-ddce-4ab5-8c8a-28efdc31bee5@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To bj-mbx11.mioffice.cn
 (10.237.8.131)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22921-lists,linux-scsi=lfdr.de];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[wangshuaiwei1@xiaomi.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:mid]
X-Rspamd-Queue-Id: 49AFE3F5488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 08:46:48 -0700, Bart Van Assche wrote:
> On 4/13/26 2:11 AM, Wang Shuaiwei wrote:
> > +	if ((SLOW_MODE == rx_mode || SLOWAUTO_MODE == rx_mode) &&
> > +	    (SLOW_MODE == tx_mode || SLOWAUTO_MODE == tx_mode))
> > +		return LS_MODE;
> 
> A stylistic comment: please follow the coding style that is used
> elsewhere in the Linux kernel. In this case, that means no Yoda
> conditions. As an example, "SLOW_MODE == rx_mode" should be changed into
> "rx_mode == SLOW_MODE".

Hi Bart,

I will modify the coding style in the next version.

Thanks,
Wang Shuaiwei.

