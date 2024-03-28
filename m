Return-Path: <linux-scsi+bounces-3161-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABB8779B9
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Mar 2024 03:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220361F2190E
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Mar 2024 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E65EBE;
	Mon, 11 Mar 2024 02:04:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB03801;
	Mon, 11 Mar 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122657; cv=none; b=LZsfvo4f0T5pHoQUnBuKvvP16QUWC/2i1qdxDTozc8mVESSenXGofkD9DAHNfjuvhDt+2VR5MoI7vjzJhRh11asKffP/1+sLrWA17Dm2Lv+2mLMShJXWQq6yQmGwL+MWrw5Pk7NCQqFbt44/TU6wrpx6j5LSPisRHWkgBiV8VBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122657; c=relaxed/simple;
	bh=78azJxq2/rUlx99Od1McKEzM15SZry1+OnT5ACQcEOQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ElOorTJpLZvZHfJc0XZBY2kc/1alVxXdUjkRYYz3HbWD1km15uHoNIf+4BgHmbtSCLI68pCV7FVhBoW/+rzLwHmQ5r3ss26ympPvxy2rIosOA0cbvKmaGfpXk4WzA9g39cXxYKF/+Ghxf3t0jieeH9lIc1WR1S9CjHVcfhpaD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TtKlZ3P4Bz1Q9XF;
	Mon, 11 Mar 2024 10:02:02 +0800 (CST)
Received: from canpemm100002.china.huawei.com (unknown [7.192.105.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 414BB1400D1;
	Mon, 11 Mar 2024 10:04:06 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100002.china.huawei.com (7.192.105.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 10:04:06 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 10:04:05 +0800
Subject: Re: [PATCH v2 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
To: John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>,
	<jinpu.wang@cloud.ionos.com>, <artur.paszkiewicz@intel.com>,
	<dlemoal@kernel.org>, <ipylypiv@google.com>, <cassel@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-6-john.g.garry@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <d10b1081-6fa2-57ad-effb-bc699b98944f@huawei.com>
Date: Mon, 11 Mar 2024 10:04:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240308114339.1340549-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/8 19:43, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/scsi/mvsas/mv_init.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

