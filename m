Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED05DDB1
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 07:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfGCFLZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Jul 2019 01:11:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfGCFLZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Jul 2019 01:11:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so1141707wru.0
        for <linux-scsi@vger.kernel.org>; Tue, 02 Jul 2019 22:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCBo68cNpu9K2+/oD1vEHNbliIsfq9Q6CFA9cda7BCg=;
        b=FgoMN7QZ/bicRCJawMdgeHwPb8Zzg2uCzZIfnfJsd+dOlXrOvXOT/hxM1XaGoEpMQQ
         VyfZu7jaHdZgGHkxfffWsEMDiAADqvJh7J9Xp9TrrrjaghEUVsVeAj1NFoccXhBOlXMO
         1MNze9hl+xyHxyVZd9xgbSprLM680eE0ptrKCJ7XaixcpWIlA3Mn8kSN1ni6S7elKva+
         MJT17ORah4To3ezs3jZLJIcoRA4vr4vrgWAN8q5WSgr6COh+nEkq9Yuopj9SLE89stRj
         oFKeUg+XkpizZwL2pGdxbSxoQWZ7BO1AAcawIx6OEa5U4RvdZf886OWavhMoSAlWy+G7
         4PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCBo68cNpu9K2+/oD1vEHNbliIsfq9Q6CFA9cda7BCg=;
        b=tgtIIaoi99Xu7CJ28FtGbSLUa5KwM2KnY5zydw5U48NK07hVYKXx1dS9stjBKszQjT
         MosfsoT7LBZFYGFkUt7S3gTkfNulfnjyoZVRMRuyQQzjogXtEWKFJW415IZRodAg9hln
         pcnKgjM1t7O00ggJNWNeC0+p4dTX6l8xMuf0leEz6bMYfwzTVMkuo3zbcX/kGFzUmdjd
         iAUXdSM3zz/x1DFyvidp+754DQKYs1b8GxDRGvIWCzX6QwQMAXGeKyArlGS2XVA/o6s7
         rhx+21cT3IuFZVG3A4uFhE/1aJCRAtz/7z2rLgCQ0zaT40Phuxf8V1FFu++XCJMH0aca
         xKXQ==
X-Gm-Message-State: APjAAAWSiDpLg6RtykmZ59S6ni3Lz2snl44AzhoIMF6SWTOmFOyVM+QZ
        LiV42JCMCZL3qA/aDDTOqLmoQA==
X-Google-Smtp-Source: APXvYqwItJ1xofEc3Pxg0+Z9V98mKz2e3BPbyQS7r3T5ZG7OniQHTnn6RQnCoNsTnG05RFqgShLrYg==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr25804612wrm.257.1562130682903;
        Tue, 02 Jul 2019 22:11:22 -0700 (PDT)
Received: from brian.unipv.it ([37.162.54.227])
        by smtp.gmail.com with ESMTPSA id l8sm1953716wrg.40.2019.07.02.22.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 22:11:22 -0700 (PDT)
Date:   Wed, 3 Jul 2019 07:11:17 +0200
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20190703051117.GA6458@brian.unipv.it>
References: <cc54d51ec7a203eceb76d62fc230b378b1da12e1.camel@unipv.it>
 <20190702120112.GA19890@ming.t460p>
 <20190702223931.GB3735@brian.unipv.it>
 <20190703020119.GA23872@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703020119.GA23872@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 03/07/19 10:01:23, Ming Lei wrote:
> On Wed, Jul 03, 2019 at 12:39:31AM +0200, Andrea Vai wrote:
> > On 02/07/19 20:01:13, Ming Lei wrote:
> > > On Tue, Jul 02, 2019 at 12:46:45PM +0200, Andrea Vai wrote:
> > > > Hi,
> > > >   I have a problem writing data to a USB pendrive, and it seems
> > > > kernel-related. With the help of Greg an Alan (thanks) and some
> > > > bisect, I found out the offending commit being
> > > > 
> > > > commit f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
> > > > 
> > > >  [...]    
> > > >     
> > > 
> > > One possible reason may be related with too small 'nr_requests', could
> > > you apply the following command and see if any difference can be made?
> > > 
> > > echo 32 > /sys/block/sdN/queue/nr_requests
> > 
> > I applied it (echo 32 > /sys/block/sdf/queue/nr_requests), ran the test again, and still failed. I assumed I didn't have to build the kernel again, did I? (sorry but I am not skilled)
> > 
> 
> You don't need to build kernel.
> 
> I just run same write test on one slow usb drive in my laptop, which
> runs '5.1.11-200.fc29.x86_64', and can't reproduce your issue, maybe it
> depends on your drive.
> 
> Could you collect the queue limits sysfs log via the following command?
> 
> 	find /sys/block/sdN/queue -type f -exec grep -aH . {} \;
>

# find /sys/block/sdf/queue -type f -exec grep -aH . {} ;
/sys/block/sdf/queue/io_poll_delay:-1
/sys/block/sdf/queue/max_integrity_segments:0
/sys/block/sdf/queue/zoned:none
/sys/block/sdf/queue/scheduler:[mq-deadline] none
/sys/block/sdf/queue/io_poll:0
/sys/block/sdf/queue/discard_zeroes_data:0
/sys/block/sdf/queue/minimum_io_size:512
/sys/block/sdf/queue/nr_zones:0
/sys/block/sdf/queue/write_same_max_bytes:0
/sys/block/sdf/queue/max_segments:2048
/sys/block/sdf/queue/dax:0
/sys/block/sdf/queue/physical_block_size:512
/sys/block/sdf/queue/logical_block_size:512
/sys/block/sdf/queue/io_timeout:30000
/sys/block/sdf/queue/nr_requests:2
/sys/block/sdf/queue/write_cache:write through/sys/block/sdf/queue/max_segment_size:4294967295
/sys/block/sdf/queue/rotational:1
/sys/block/sdf/queue/discard_max_bytes:0
/sys/block/sdf/queue/add_random:1
/sys/block/sdf/queue/discard_max_hw_bytes:0
/sys/block/sdf/queue/optimal_io_size:0
/sys/block/sdf/queue/chunk_sectors:0
/sys/block/sdf/queue/iosched/front_merges:1
/sys/block/sdf/queue/iosched/read_expire:500
/sys/block/sdf/queue/iosched/fifo_batch:16
/sys/block/sdf/queue/iosched/write_expire:5000/sys/block/sdf/queue/iosched/writes_starved:2
/sys/block/sdf/queue/read_ahead_kb:128
/sys/block/sdf/queue/max_discard_segments:1
/sys/block/sdf/queue/write_zeroes_max_bytes:0
/sys/block/sdf/queue/nomerges:0
/sys/block/sdf/queue/wbt_lat_usec:75000
/sys/block/sdf/queue/fua:0
/sys/block/sdf/queue/discard_granularity:0
/sys/block/sdf/queue/rq_affinity:1
/sys/block/sdf/queue/max_sectors_kb:120
/sys/block/sdf/queue/hw_sector_size:512
/sys/block/sdf/queue/max_hw_sectors_kb:120
/sys/block/sdf/queue/iostats:1 

Thanks, and bye,
Andrea
