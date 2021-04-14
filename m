Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EFF35F193
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Apr 2021 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhDNKjo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Apr 2021 06:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233804AbhDNKj3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Apr 2021 06:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618396743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mtxNf9G7ZE9nH07cAbuCxEu8T2eiRwRRG1NfOPrUKo=;
        b=CfZ0NeAAHXOUzMnoiSocHLcFM8U3dW0xJG/6Wi85sCNyGkpxbHrY1l3otbyo5hLw3r/aEn
        /6AU2zIZjOo/bfaqlQyVARItzSkNIcTAlI1dQuh2MezKM/EhuFxUHbQvHWbV4Ga6BUHSAP
        whbyU4ftbaXm5PUL1hEmuxd7iVdH99o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-x6jvojrPPW6xCf0lyYg1Bw-1; Wed, 14 Apr 2021 06:38:59 -0400
X-MC-Unique: x6jvojrPPW6xCf0lyYg1Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD8783DD22;
        Wed, 14 Apr 2021 10:38:57 +0000 (UTC)
Received: from T590 (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 595A25D76F;
        Wed, 14 Apr 2021 10:38:53 +0000 (UTC)
Date:   Wed, 14 Apr 2021 18:38:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [bug report] shared tags causes IO hang and performance drop
Message-ID: <YHbGOWnVbMjFV7TI@T590>
References: <YHaez6iN2HHYxYOh@T590>
 <9a6145a5-e6ac-3d33-b52a-0823bfc3b864@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6145a5-e6ac-3d33-b52a-0823bfc3b864@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Apr 14, 2021 at 11:10:39AM +0100, John Garry wrote:
> Hi Ming,
> 
> > 
> > It is reported inside RH that CPU utilization is increased ~20% when
> > running simple FIO test inside VM which disk is built on image stored
> > on XFS/megaraid_sas.
> > 
> > When I try to investigate by reproducing the issue via scsi_debug, I found
> > IO hang when running randread IO(8k, direct IO, libaio) on scsi_debug disk
> > created by the following command:
> > 
> > 	modprobe scsi_debug host_max_queue=128 submit_queues=$NR_CPUS virtual_gb=256
> > 
> 
> So I can recreate this hang for using mq-deadline IO sched for scsi debug,
> in that fio does not exit. I'm using v5.12-rc7.
> 
> Do you have any idea of what changed to cause this, as we would have tested
> this before? Or maybe only none IO sched on scsi_debug. And normally 4k
> block size and only rw=read (for me, anyway).

Just run a quick test with none on scsi_debug, looks the issue can't be
reproduced, but very worse performance is observed with none(20% IOPS drops,
and 50% CPU utilization increased).

> 
> Note that host_max_queue=128 will cap submit queue depth at 128, while would
> be 192 by default.

I take 128 because the reported megaraid_sas's host queue depth is 128.


Thanks, 
Ming

