Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038EE367A04
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Apr 2021 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhDVGia (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Apr 2021 02:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDVGi3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Apr 2021 02:38:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C30F4AE03;
        Thu, 22 Apr 2021 06:37:54 +0000 (UTC)
Subject: Re: [PATCH 41/42] scsi: drop message byte helper
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210421174749.11221-1-hare@suse.de>
 <20210421174749.11221-42-hare@suse.de>
 <606c5be7-299a-224b-e264-06123587c78a@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4c16d4a0-f3c4-b70e-5eb8-cc352dbd980d@suse.de>
Date:   Thu, 22 Apr 2021 08:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <606c5be7-299a-224b-e264-06123587c78a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/21/21 11:14 PM, Bart Van Assche wrote:
> On 4/21/21 10:47 AM, Hannes Reinecke wrote:
>> The message byte is not unused, so we can drop the helper to set
>> the message byte and the check for message bytes during error recovery.
> 
> not -> now?
> 
Why, of course. Will be fixing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
