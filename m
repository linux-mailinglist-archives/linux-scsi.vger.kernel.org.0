Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A98027DD84
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 02:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI3AuH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 20:50:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbgI3AuG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 20:50:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 901CC35C07DAD9C4034E;
        Wed, 30 Sep 2020 08:50:04 +0800 (CST)
Received: from [10.174.179.1] (10.174.179.1) by smtp.huawei.com (10.3.19.201)
 with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 30 Sep 2020 08:49:59
 +0800
Subject: Re: [PATCH] scsi: esas2r: prevent a potential NULL dereference in
 esas2r_probe()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200909084653.79341-1-jingxiangfeng@huawei.com>
 <yq11rj267ij.fsf@ca-mkp.ca.oracle.com>
CC:     <linuxdrivers@attotech.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F620166.7070305@huawei.com>
Date:   Wed, 16 Sep 2020 20:13:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <yq11rj267ij.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.1]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2020/9/16 5:44, Martin K. Petersen wrote:
>
> Jing,
>
>> esas2r_probe() calls scsi_host_put() in an error path. However,
>> esas2r_log_dev() may hit a potential NULL dereference. So use NUll instead.
>
> Wouldn't it be better to move the scsi_host_put() call after the error
> message?

There is already a message before the scsi_host_put() call. It is used 
to record calling function.

>
