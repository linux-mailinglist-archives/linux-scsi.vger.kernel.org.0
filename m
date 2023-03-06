Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79426AB47B
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Mar 2023 02:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFB7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Mar 2023 20:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFB7I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Mar 2023 20:59:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456BD9014
        for <linux-scsi@vger.kernel.org>; Sun,  5 Mar 2023 17:59:07 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVMC16Hppz9tGL;
        Mon,  6 Mar 2023 09:57:01 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 09:59:04 +0800
Subject: Re: [PATCH 41/81] scsi: hisi_sas: Declare SCSI host template const
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20230304003103.2572793-1-bvanassche@acm.org>
 <20230304003103.2572793-42-bvanassche@acm.org>
CC:     <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <229c5727-0948-d62f-ed94-82cc5021c554@hisilicon.com>
Date:   Mon, 6 Mar 2023 09:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230304003103.2572793-42-bvanassche@acm.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


ÔÚ 2023/3/4 8:30, Bart Van Assche Ð´µÀ:
> Make it explicit that the SCSI host template is not modified.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Xiang Chen <chenxiang66@hisilicon.com>

