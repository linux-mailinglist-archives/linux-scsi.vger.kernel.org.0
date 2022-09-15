Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B705B9A48
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Sep 2022 14:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIOMDS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Sep 2022 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIOMDP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Sep 2022 08:03:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA2C4F6AF
        for <linux-scsi@vger.kernel.org>; Thu, 15 Sep 2022 05:03:15 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MSwmn3fFXz67W0D;
        Thu, 15 Sep 2022 20:02:17 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 14:03:12 +0200
Received: from [10.126.175.63] (10.126.175.63) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 13:03:12 +0100
Message-ID: <022389a4-eb7f-7b81-a6b2-0ef11faa0cfd@huawei.com>
Date:   Thu, 15 Sep 2022 13:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/15] mpi3mr: Added Support for SAS Transport
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC:     <martin.petersen@oracle.com>
References: <20220804131226.16653-1-sreekanth.reddy@broadcom.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804131226.16653-1-sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.63]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 04/08/2022 14:12, Sreekanth Reddy wrote:
> - Enhanced the driver to support SAS transport layer and
>   expose SAS controller PHYs, ports, attached expander, expander PHYs,
>   expander ports and SAS/SATA end devices to the kernel through
>   SAS transport class.
> - The driver also provides call back handlers for get_linkerrors,
>   get_enclosure_identifier, get_bay_identifier, phy_reset, phy_enable,
>   set_phy_speed and smp_handler to the kernel as defined by the
>   SAS transport layer.
> - The SAS transport layer support is enabled only when the
>   controller multipath capability is not enabled.
> - The NVMe devices, VDs, vSES and PCIe Managed SES devices
>   are not exposed through SAS transport.

Out of curiosity, are there any plans to add SCSI transport SAS support 
for megaraid sas?

Thanks,
John
