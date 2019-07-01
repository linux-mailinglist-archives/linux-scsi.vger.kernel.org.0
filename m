Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB12D238C9
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfETNwS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 09:52:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731648AbfETNwS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 May 2019 09:52:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F7CA5F45FA0FA683575;
        Mon, 20 May 2019 21:52:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 21:52:04 +0800
Subject: Re: [PATCH v2] scsi: libsas: no need to join wide port again in
 sas_ex_discover_dev()
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190520140600.22861-1-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <zhaohongjiang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7b7c51db-15f3-d06b-ba58-8b6ef618f7d2@huawei.com>
Date:   Mon, 20 May 2019 14:51:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190520140600.22861-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 20/05/2019 15:06, Jason Yan wrote:
> Since we are processing events synchronously now, the second call of
> sas_ex_join_wide_port() in sas_ex_discover_dev() is not needed. There
> will be no races with other works in disco workqueue. So remove the
> second sas_ex_join_wide_port().
>
> I did not change the return value of 'res' to error when discover failed
> because we need to continue to discover other phys if one phy discover
> failed. So let's keep that logic as before and just add a debug log to
> detect the failure. And directly return if second fanout expander
> attatched to the parent expander because it has nothing to do after the
> phy is disabled.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

Reviewed-by: John Garry <john.garry@huawei.com>

