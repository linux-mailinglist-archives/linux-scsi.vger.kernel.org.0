Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C22FF8F4
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbhAUXdA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Jan 2021 18:33:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbhAUXc5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 21 Jan 2021 18:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611271930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buZ7hCah14JlxAK4UCUAW3Ia/sZi8xMRjhPZ6hLKL24=;
        b=OYly1ACxqP7ygxN0fCzYWuJw3pXK+p344Oa5y6yHEQLSFE1rKYcN0+0wqldWMP1uM8SnTg
        FMsyiHhidUTZJc5SK2e9UL3y3BVzDU0Un0UCPhzkMstWbGTwNwNBVKnB3bQQIe4hlAzUa6
        Su2Hg73R2wsqc8Dv5YO9FO7mLKBWVFk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FD8CAB7A;
        Thu, 21 Jan 2021 23:32:10 +0000 (UTC)
Message-ID: <5724da4acbad312e8824ee097ca4d8eb831360e5.camel@suse.com>
Subject: Re: [PATCH] scsi: scsi_host_queue_ready: increase busy count early
From:   Martin Wilck <mwilck@suse.com>
To:     John Garry <john.garry@huawei.com>,
        Donald Buczek <buczek@molgen.mpg.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Don Brace <Don.Brace@microchip.com>,
        Kevin Barnett <Kevin.Barnett@microchip.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Hannes Reinecke <hare@suse.com>
Date:   Fri, 22 Jan 2021 00:32:08 +0100
In-Reply-To: <361d5a2f-fb8e-c400-2818-29aea435aff2@huawei.com>
References: <20210120184548.20219-1-mwilck@suse.com>
         <37579c64-1cdb-8864-6a30-4d912836f28a@huawei.com>
         <231d9fcd-14f4-6abf-c41a-56315877a3dc@molgen.mpg.de>
         <87b7f873-46c4-140b-ee45-f724b50b6aca@huawei.com>
         <d48f98a9-77e3-dfe3-af5c-91b0ef45586b@molgen.mpg.de>
         <361d5a2f-fb8e-c400-2818-29aea435aff2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2021-01-21 at 13:05 +0000, John Garry wrote:
> > > 
> 
> Confirmed my suspicions - it looks like the host is sent more
> commands 
> than it can handle. We would need many disks to see this issue
> though, 
> which you have.
> 
> So for stable kernels, 6eb045e092ef is not in 5.4 . Next is 5.10, and
> I 
> suppose it could be simply fixed by setting .host_tagset in scsi host
> template there.

If it's really just that, it should be easy enough to verify.

@Donald, you'd need to test with a 5.10 kernel, and after reproducing
the issue, add 

        .host_tagset            = 1,

to the definition of pqi_driver_template in
drivers/scsi/smartpqi/smartpqi_init.c. 

You don't need a patch to test that, I believe. Would you able to do
this test?

Regards,
Martin


