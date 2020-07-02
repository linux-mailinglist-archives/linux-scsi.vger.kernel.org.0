Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB921277C
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2020 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgGBPO5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jul 2020 11:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgGBPO5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 Jul 2020 11:14:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F155AB18A;
        Thu,  2 Jul 2020 15:14:53 +0000 (UTC)
Subject: Re: [PATCH] scsi: allow state transitions BLOCK -> BLOCK
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
References: <20200702142436.98336-1-hare@suse.de>
 <1593700443.9652.2.camel@HansenPartnership.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0c1ce7fc-98ba-0a14-d1a7-889bf1ce794f@suse.de>
Date:   Thu, 2 Jul 2020 17:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593700443.9652.2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/2/20 4:34 PM, James Bottomley wrote:
> On Thu, 2020-07-02 at 16:24 +0200, Hannes Reinecke wrote:
>> scsi_transport_srp.c will call scsi_target_block() repeatedly
>> without calling scsi_target_unblock() first.
>> So allow the idempotent state transition BLOCK -> BLOCK to avoid
>> a warning here.
> 
> That really doesn't sound like a good idea.  Block and unblock should
> be matched pairs and since you don't have a running->running transition
> allowed this implies that srp calls block many times but unblock only
> once.  It really sounds like srp needs fixing.
> 
That was what I was planning first, but then SRP has a weird mix of 
states, calling scsi_target_block()/scsi_target_unblock() on all sorts 
of places.
Bart?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
