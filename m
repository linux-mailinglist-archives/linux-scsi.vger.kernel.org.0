Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18741BF53
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 08:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbhI2Gxq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 02:53:46 -0400
Received: from verein.lst.de ([213.95.11.211]:54710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhI2Gxq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 02:53:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4F6567357; Wed, 29 Sep 2021 08:52:02 +0200 (CEST)
Date:   Wed, 29 Sep 2021 08:52:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>, jack@suse.cz,
        axboe@kernel.dk, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dm-devel@redhat.com, sachinp <sachinp@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>, dougmill@us.ibm.com
Subject: Re: [next-20210827][ppc][multipathd] INFO: task hung in
 dm_table_add_target
Message-ID: <20210929065202.GA31534@lst.de>
References: <68dde454-965a-0c44-374a-a0ca277150ee@linux.vnet.ibm.com> <20210901133618.GA16687@lst.de> <86f8e47b-84ca-4cc3-5d5b-f5f11c1d4d1a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f8e47b-84ca-4cc3-5d5b-f5f11c1d4d1a@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Sep 28, 2021 at 03:53:47PM +0530, Abdul Haleem wrote:
>
> On 9/1/21 7:06 PM, Christoph Hellwig wrote:
>> On Wed, Sep 01, 2021 at 04:47:26PM +0530, Abdul Haleem wrote:
>>> Greeting's
>>>
>>> multiple task hung while adding the vfc disk back to the multipath on my
>>> powerpc box running linux-next kernel
>> Can you retry to reproduce this with lockdep enabled to see if there
>> is anything interesting holding this lock?
>
> LOCKDEP was earlier enabled by default
>
> # cat .config | grep LOCKDEP
> CONFIG_LOCKDEP_SUPPORT=y
>
> BTW, Recreated again on 5.15.0-rc2 mainline kernel and attaching the logs

It seems the reinstate is blocking on the close which is blocking on
flushing dirty data.  In other words it looks like the link blocking
looks like the symptom and not the cause.
