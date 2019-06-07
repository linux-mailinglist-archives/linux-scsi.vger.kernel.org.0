Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4476B383E1
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 07:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFGFwU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 01:52:20 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33677 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFwU (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Fri, 7 Jun 2019 01:52:20 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 07 Jun 2019 07:52:18 +0200
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-2-bvanassche@acm.org>
 <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
 <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com>
Date:   Fri, 7 Jun 2019 07:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/6/19 7:26 PM, Bart Van Assche wrote:
> On 6/5/19 10:46 PM, Hannes Reinecke wrote:
>> Why not simply '-EPERM' ?
>> Translating a state into something else seems counterproductive.
> 
> Personally I'm OK with returning -EPERM for attempts from user space to
> change the device state into SDEV_BLOCK. The state translation is
> something that was proposed about two months ago (see also
> https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg82610.html).
> 
>> And, while we're at it:
>> The only meaningful states to be set from userspace are 'RUNNING',
>> 'OFFLINE', and 'BLOCK'.
>> Everything else relates to the internal state machine and really
>> shouldn't be touched from userspace at all.
>> So I'd rather filter out everything _but_ the three states, avoid
>> similar issue in the future.
> 
> Can you please clarify why you think it is useful to change the SCSI
> device state from user space into SDEV_BLOCK? As one can see in
> scsi_device_set_state() transitions from SDEV_BLOCK into the following
> states are allowed: SDEV_RUNNING, SDEV_OFFLINE, SDEV_TRANSPORT_OFFLINE
> and SDEV_DEL. The mpt3sas driver and also the FC, iSCSI and SRP
> transport drivers all can call scsi_internal_device_unblock_nowait() or
> scsi_target_unblock(). So at least for this LLD and these transport
> drivers if the device state is set to SDEV_BLOCK from user space that
> change can be overridden any time by kernel code. So I'm not sure it is
> useful to change the device state into SDEV_BLOCK from user space.
> 
Yes, I agree.

So let's restrict userspace to only ever setting 'RUNNING' or 'OFFLINE'.
None of the other states make sense to set from userspace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
