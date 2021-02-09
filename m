Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0FF314A1C
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Feb 2021 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBIIRf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Feb 2021 03:17:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2525 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBIIRf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Feb 2021 03:17:35 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZbHZ44Xxz67mJS;
        Tue,  9 Feb 2021 16:13:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 09:16:53 +0100
Received: from [10.210.172.215] (10.210.172.215) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 08:16:52 +0000
Subject: Re: [PATCH] mpt3sas: Added support for shared host tagset for
 cpuhotplug
To:     kernel test robot <lkp@intel.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        <martin.petersen@oracle.com>
CC:     <kbuild-all@lists.01.org>, <linux-scsi@vger.kernel.org>,
        <sathya.prakash@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>,
        <kashyap.desai@broadcom.com>
References: <20210201093343.29712-1-sreekanth.reddy@broadcom.com>
 <202102020051.x4A03YiQ-lkp@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d8c5dafc-1ce8-6d31-914d-e495ee3a16fc@huawei.com>
Date:   Tue, 9 Feb 2021 08:15:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202102020051.x4A03YiQ-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.215]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 01/02/2021 16:34, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>>> aarch64-linux-ld: drivers/scsi/mpt3sas/mpt3sas_scsih.o:(.data+0xb80): multiple definition of `host_tagset_enable'; drivers/scsi/megaraid/megaraid_sas_base.o:(.data+0x2280): first defined here
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation


It would be good to fix this for megaraid sas also, i.e. make 
host_tagset_enable static?

Cheers,
John
