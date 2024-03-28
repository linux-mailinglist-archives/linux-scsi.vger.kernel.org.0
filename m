Return-Path: <linux-scsi+bounces-2899-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F298713C3
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Mar 2024 03:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3AD1F23BEE
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Mar 2024 02:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792028DB5;
	Tue,  5 Mar 2024 02:44:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D728684;
	Tue,  5 Mar 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606694; cv=none; b=lOoB3K/qReHPFd7IRjxEmurN+ScRr1eUmGuT/u5/yarQKErJUUaL2jogIywTekufB2xrmc1BgeRzicxsq7+HElW0tTX3/c8Y7gZfOOUy4fQ2IzKs5OXeQ8WD8/Zj9GGTxMxna6EwjDbkpJPJP1DLMBLEB3pqViWvxEwvgL6tEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606694; c=relaxed/simple;
	bh=8OXkcDl9sqlqFaahg6tEKayVkJ0Vkw3i4A6ERvPz3Ys=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YVP8uTGhahFRuKKqjktFENZWc5I8FAwWHHhQFLh1U7QtutzaKIC1pPT6egF5oXLO4seXhNp5iwGHPFAUwUSfoNsae71wP3NmWLn27GlaifjLszoZMD2F1r1PrQ1Mzl3C6JabV9zRYVvem7opMueBKIq+sK6mhFrnhAfi+2HHwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tpfwv4zfQz1Q9rW;
	Tue,  5 Mar 2024 10:42:23 +0800 (CST)
Received: from canpemm100010.china.huawei.com (unknown [7.192.104.38])
	by mail.maildlp.com (Postfix) with ESMTPS id 02EA71A016C;
	Tue,  5 Mar 2024 10:44:44 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100010.china.huawei.com (7.192.104.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:44:43 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:44:43 +0800
Subject: Re: [PATCH v5 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jack Wang <jinpu.wang@cloud.ionos.com>, "Hannes
 Reinecke" <hare@suse.de>, Xiang Chen <chenxiang66@hisilicon.com>, "Artur
 Paszkiewicz" <artur.paszkiewicz@intel.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: TJ Adams <tadamsjr@google.com>, <linux-ide@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-3-ipylypiv@google.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <a80f1045-fb19-6871-46c2-11ae78dad8f0@huawei.com>
Date: Tue, 5 Mar 2024 10:44:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305005103.1849325-3-ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/5 8:50, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/sda/device/ncq_prio_enable
> - /sys/block/sda/device/ncq_prio_supported
> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Reviewed-by: John Garry<john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
>   include/scsi/sas_ata.h        |  6 +++
>   2 files changed, 100 insertions(+)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

