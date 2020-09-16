Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8BB26CBD7
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIPUfz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 16:35:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728389AbgIPUfy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 16:35:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8138FC97797992C28F05;
        Wed, 16 Sep 2020 20:29:04 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 16 Sep
 2020 20:28:59 +0800
Subject: Re: [PATCH] scsi: esas2r: prevent a potential NULL dereference in
 esas2r_probe()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200909084653.79341-1-jingxiangfeng@huawei.com>
 <yq11rj267ij.fsf@ca-mkp.ca.oracle.com>
CC:     <linuxdrivers@attotech.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F62050A.6060109@huawei.com>
Date:   Wed, 16 Sep 2020 20:28:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <yq11rj267ij.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
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
