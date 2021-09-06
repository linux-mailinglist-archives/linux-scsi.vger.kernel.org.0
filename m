Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E4013D4
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Sep 2021 03:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhIFB3C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Sep 2021 21:29:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15291 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbhIFB1F (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Sep 2021 21:27:05 -0400
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H2rLh2dmBz8sqg;
        Mon,  6 Sep 2021 09:25:32 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 dggeml756-chm.china.huawei.com (10.1.199.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 09:25:59 +0800
Subject: Re: [PATCH] scsi: libsas: co-locate exports with symbols
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1630664852-225115-1-git-send-email-john.garry@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <f767b99a-e4cb-642f-a319-5cea2b4a2a88@huawei.com>
Date:   Mon, 6 Sep 2021 09:25:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1630664852-225115-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml756-chm.china.huawei.com (10.1.199.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


�� 2021/9/3 18:27, John Garry д��:
> It is standard practice to co-locate export declarations with the symbol
> which is being exported. Or at least in the same file - see
> sas_phy_reset().
> 
> Modify libsas to follow this practice consistently.
> 
> Signed-off-by: John Garry<john.garry@huawei.com>

Reviewed-by: Jason Yan <yanaijie@huawei.com>
