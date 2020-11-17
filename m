Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C42B5BAB
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKQJTY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 04:19:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2110 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQJTY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Nov 2020 04:19:24 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb0hs5YlMz67DgV;
        Tue, 17 Nov 2020 17:17:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 10:19:17 +0100
Received: from [10.200.64.221] (10.200.64.221) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 09:19:08 +0000
Subject: Re: [PATCH V4 05/12] sbitmap: export sbitmap_weight
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>
References: <20201116090737.50989-1-ming.lei@redhat.com>
 <20201116090737.50989-6-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d996b26f-b614-c8e4-805c-2c0fd48cee9e@huawei.com>
Date:   Tue, 17 Nov 2020 09:18:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201116090737.50989-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.200.64.221]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 16/11/2020 09:07, Ming Lei wrote:
> +
> +/**
> + * sbitmap_weight() - Return how many real bits set in a &struct sbitmap.
> + * @sb: Bitmap to check.
> + *
> + * Return: How many real bits set
> + */
> +unsigned int sbitmap_weight(const struct sbitmap *sb);
> +

Hi Ming,

Just a nit on the comment - I think that "real bits set" is vague. How 
about "set and not cleared bits", "busy bits", "net set bits" or 
"aggregate bits set"?

Thanks,
John

