Return-Path: <linux-scsi+bounces-22926-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNstA77i3WnrkgkAu9opvQ
	(envelope-from <linux-scsi+bounces-22926-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 08:46:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B003F6357
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF26300B9AD
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801036DA1F;
	Tue, 14 Apr 2026 06:44:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14D36D9E7
	for <linux-scsi@vger.kernel.org>; Tue, 14 Apr 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149044; cv=none; b=Bj6rZ7aIIKYTRdkhDtJzry/pYgEXqKeNA6sqx6f4S2AV5EgcQtg+qPzXEO5s+FgQfAjeIjvDJX3QnxABl851Smt4H8ImKrfQlJ/k8OFcxtgYL1gj7p09tfuiEnhh09/JFxUMri/Y5ta0sGpD/HdRD8W8TTAgSVjyeSdWMgMjR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149044; c=relaxed/simple;
	bh=TC/OgJtWlCiewVpD8nDqMBZSwdxOsiHHEUitGW/Tv40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ6VrTJEYUT1/lFPK8VGPiSuGj4dp7Md8m93MYaWsSJ/ZlVZhqA8Vhl93YtYNbtivIcK4Obnp39mbhhCbqXjGxq34gCtIcsPSYQ5AtYZVCQvGhzWWcfWaASZD5BBNiT6yXHLyCP2wcvvPF+aLAj43cfnjLYB4S64jqf8tkM6I8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: NlwyEgQ/RC2t6SMseztW3w==
X-CSE-MsgGUID: XPVxGixIRZ6bQhns7vNZ/Q==
X-IronPort-AV: E=Sophos;i="6.23,179,1770566400"; 
   d="scan'208";a="146558435"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: <peter.wang@mediatek.com>
CC: <James.Bottomley@HansenPartnership.com>, <adrian.hunter@intel.com>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
	<bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<martin.petersen@oracle.com>, <wanghui33@xiaomi.com>,
	<wangshuaiwei1@xiaomi.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix bRefClkFreq write failure in HS-LSS mode
Date: Tue, 14 Apr 2026 14:43:59 +0800
Message-ID: <20260414064359.1497746-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ed8f32842f42dab0a3ef4774272b41cefbfe8fae.camel@mediatek.com>
References: <ed8f32842f42dab0a3ef4774272b41cefbfe8fae.camel@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22926-lists,linux-scsi=lfdr.de];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[wangshuaiwei1@xiaomi.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4B003F6357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 05:36:06 +0000, Peter Wang wrote:
> On Mon, 2026-04-13 at 17:11 +0800, Wang Shuaiwei wrote:
> > According to the UFS spec, the bRefClkFreq attribute can only be
> > written
> > when both sub-links are in LS-MODE. However, in HS LSS mode with
> > resetmode = HS_MODE, if the UFS device's default bRefClkFreq value
> > differs from the host controller's dev_ref_clk_freq setting, the
> > write operation will fail.
> > 
> > To fix this issue, introduce ufshcd_get_op_mode() function to detect
> > the current link operational mode. Call ufshcd_set_dev_ref_clk() only
> > when both sub-links are in LS-MODE to ensure the attribute can be
> > written successfully.
> > 
> > Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
> 
> Hi Shuaiwei,
> 
> I'm a bit confused about how this situation could happen.
> Once it is set to HS-LSS, the ref-clk should already be correct.
> Why would we still need to set bRefClkFreq separately?
> In fact, if bRefClkFreq is not set correctly, the UFS host 
> wouldn't be able to communicate with the device at all,
> much less set the bRefClkFreq.

Hi Peter,

In HS-LSS mode, the ref_clk frequency is automatically detected
by the UFS device. The bRefClkFreq attribute is ignored in this
mode and should not be write in this mode.

However, the current code does not properly handle this scenario
when calling ufshcd_set_dev_ref_clk(). If the UFS device's default
bRefClkFreq value differs from the host controller's dev_ref_clk_freq,
the function will attempt to write the bRefClkFreq attribute,
which will inevitably fail.

So, fix this by adding a check to skip ufshcd_set_dev_ref_clk()
when operating in HS-LSS mode.

Thanks,
Wang Shuaiwei.

