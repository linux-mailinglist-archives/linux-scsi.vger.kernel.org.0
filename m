Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC722062D
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2020 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgGOHaP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Jul 2020 03:30:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2480 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728888AbgGOHaP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Jul 2020 03:30:15 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E78918ACBCDD2BA09E4F;
        Wed, 15 Jul 2020 08:30:10 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 15 Jul
 2020 08:30:09 +0100
Subject: Re: [PATCH RFC v7 11/12] smartpqi: enable host tagset
To:     <Don.Brace@microchip.com>, <don.brace@microsemi.com>,
        <hare@suse.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <kashyap.desai@broadcom.com>,
        <sumit.saxena@broadcom.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <hch@lst.de>,
        <shivasharan.srikanteshwara@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        <megaraidlinux.pdl@broadcom.com>, <hare@suse.de>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <1591810159-240929-12-git-send-email-john.garry@huawei.com>
 <a8afea5c-97f2-ac84-f4b5-155963bebb2c@huawei.com>
 <786e0b9d-ab42-aaf6-f552-072010892778@huawei.com>
 <SN6PR11MB28486DB217EFB23F26321236E1610@SN6PR11MB2848.namprd11.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dad8d9de-ef36-e412-db04-644bca623c01@huawei.com>
Date:   Wed, 15 Jul 2020 08:28:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB28486DB217EFB23F26321236E1610@SN6PR11MB2848.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.38]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/07/2020 19:16, Don.Brace@microchip.com wrote:
> Subject: Re: [PATCH RFC v7 11/12] smartpqi: enable host tagset
> 
> 
> Both the driver author and myself do not want to change how commands are processed in the smartpqi driver.
> 
> Nak.
> 

ok, your call. But it still seems that the driver should set the 
host_tagset flag.

Anyway, can you also let us know your stance on the hpsa change in this 
series?

https://lore.kernel.org/linux-scsi/1591810159-240929-1-git-send-email-john.garry@huawei.com/T/#m1057b8a8c23a9bf558a048817a1cda4a576291b2

thanks


