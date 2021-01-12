Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398152F2DEA
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 12:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbhALL27 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 06:28:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2315 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbhALL26 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Jan 2021 06:28:58 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFSs46TGXz67b7G;
        Tue, 12 Jan 2021 19:24:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 12:28:16 +0100
Received: from [10.210.171.61] (10.210.171.61) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 11:28:14 +0000
Subject: Re: [PATCH] scsi: libsas and users: Remove notifier indirection
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <corbet@lwn.net>, <yanaijie@huawei.com>, <bigeasy@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <intel-linux-scu@intel.com>, <linux-doc@vger.kernel.org>
References: <1610386112-132641-1-git-send-email-john.garry@huawei.com>
 <X/2HDUmb8L8LPELG@lx-t490>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dc966c2a-2967-e6d6-ebe2-d71444cfd4da@huawei.com>
Date:   Tue, 12 Jan 2021 11:27:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <X/2HDUmb8L8LPELG@lx-t490>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.61]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/01/2021 11:25, Ahmed S. Darwish wrote:
> Since this patch necessitates a careful manual rebase of_every_  patch
> in my series, I've included it at the top of my v2 submission and
> rebased everything on top:
> 
>      https://lkml.kernel.org/r/20210112110647.627783-1-a.darwish@linutronix.de
> 
> Some left-over 'sas_ha' local variables were removed, and I've mentioned
> that in the commit log of course.

OK, great. I was just about to look at that.

Cheers,
john
