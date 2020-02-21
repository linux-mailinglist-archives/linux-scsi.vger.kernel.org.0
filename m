Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47491681E7
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Feb 2020 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBUPhv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Feb 2020 10:37:51 -0500
Received: from smtp.infotech.no ([82.134.31.41]:50623 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUPhu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Feb 2020 10:37:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id BA12220418D;
        Fri, 21 Feb 2020 16:37:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AE8+Wt9I8DZf; Fri, 21 Feb 2020 16:37:48 +0100 (CET)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 9E97C204150;
        Fri, 21 Feb 2020 16:37:46 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 09/15] scsi_debug: zbc module parameter
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "hare@suse.de" <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200220200838.15809-1-dgilbert@interlog.com>
 <20200220200838.15809-10-dgilbert@interlog.com>
 <DM5PR0401MB359146F8251034D19365A9909B120@DM5PR0401MB3591.namprd04.prod.outlook.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <4c2b94fe-f573-37b6-3b34-59647eabdd13@interlog.com>
Date:   Fri, 21 Feb 2020 10:37:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DM5PR0401MB359146F8251034D19365A9909B120@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-02-21 4:49 a.m., Johannes Thumshirn wrote:
> On 20/02/2020 21:09, Douglas Gilbert wrote:
>> +MODULE_PARM_DESC(opt_xferlen_exp, "optimal transfer length granularity exponent (def=physblk_exp)");
>>    MODULE_PARM_DESC(opts, "1->noise, 2->medium_err, 4->timeout, 8->recovered_err... (def=0)");
>>    MODULE_PARM_DESC(physblk_exp, "physical block exponent (def=0)");
>> -MODULE_PARM_DESC(opt_xferlen_exp, "optimal transfer length granularity exponent (def=physblk_exp)");
> 
> Unrelated change, isn't it?

Yes, it should be in the re-arrange in alphabetical order patch. Do you
know a one-liner (or two or ...) for pulling a line out of one patch
and placing it in another with git :-)

Doug Gilbert

