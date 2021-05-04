Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0673725B7
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 08:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhEDGO5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 02:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhEDGO4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 May 2021 02:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDA05ACF6;
        Tue,  4 May 2021 06:14:01 +0000 (UTC)
Subject: Re: [PATCH 06/18] scsi: Use dummy inquiry data for the host device
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
References: <20210503150333.130310-1-hare@suse.de>
 <20210503150333.130310-7-hare@suse.de>
 <07a29507-c33d-8385-d41b-dc7983617862@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5678ca05-a4b7-954a-f439-a81c89401ea2@suse.de>
Date:   Tue, 4 May 2021 08:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <07a29507-c33d-8385-d41b-dc7983617862@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/4/21 4:52 AM, Bart Van Assche wrote:
> On 5/3/21 8:03 AM, Hannes Reinecke wrote:
>> +/**
>> + * scsi_device_is_host_dev - Check if a scsi device is a host device
>> + * @sdev: SCSI device to test
>> + *
>> + * Returns: true if @sdev is a host device, false otherwise
>> + */
>> +bool scsi_device_is_host_dev(struct scsi_device *sdev)
>> +{
>> +	return ((const unsigned char *)sdev->inquiry == scsi_null_inquiry);
>> +}
> 
> No parentheses around the expression in a return statement please.
> 
Okay.

>> +EXPORT_SYMBOL_GPL(scsi_device_is_host_dev);
> 
> Does this mean that this function will be used outside the SCSI core?
> 
Will have to check; might be a left-over from previous iterations.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
