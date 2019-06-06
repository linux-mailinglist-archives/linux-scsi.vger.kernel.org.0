Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A251E368B7
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFFAUr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 20:20:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35411 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFFAUr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 20:20:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so740239qto.2
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOyPjyeosyjmMyuCExBUNW4udd++0RgyUCksIaflUUk=;
        b=Rh74oYuFKq/v9o89M22ksbXfcciAegEQPaBuc+bhzlG1uJn4lTkqFOe1PGjcPBzoIU
         jDZ8gua0t+oIxOIfn4+qD8EDUKlPnFLJne/q2EIRg59q0Cyk7q9LPc+6L7smGBqDQ7Ql
         m0Yk3Xo/80eni7fwbsmwWhy41e/5y00q5zHo25lZtnIEr033QXTYg4RKv2/iopPODnGP
         wJBqxy7zLKEse+DqgXJ3ibaLMeeQ0GsTR4iCPPE4qrSLU7xT+xImOngPnilTRTWKdrnR
         LOxCpQ0SpJ40muyRyZ1EFLOuHCmx5qYu6itV4UdZ6Ft1MMG70yJF15RsE1xWJpyl6TqP
         XPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOyPjyeosyjmMyuCExBUNW4udd++0RgyUCksIaflUUk=;
        b=PqlF6YxuKxQ4ddIc5dbINbkp3Cv0nyAoLT4ngHQuCQmqWi2o0rfwqGVA3+cMmqcrMq
         4gYUgQdTzJAau/BDdbD8nzAddlXhYjOen5/QvrXbwCQSFCtGpEA03O/B0vp59ttkEWY3
         a57ohcZ9mX7450beYT3dAWk1K7DFrMGS49njh/5sj3KOcgRcxfZP+I3cCPzL/bBMswEM
         T0qO0u5+M0bth3IxApAk6LYfcWWu21RxuayYnbYZGX+hGaIU6ioS87fMAcGoeOz4YCfw
         D0qdzBLf5QpMrsZwLNCXBetNpKCXBQhbN6Si1N1K2mUdSl1xc9wZO/fhknJ+m+hQYz3G
         Ve3A==
X-Gm-Message-State: APjAAAXQtS8jGLG9asIVniQ2WJikHdUgdE6s8FBkOvlq/w442sdmUMVE
        M9ngh5TjuhUHa1rq8+h0Zu3E8A==
X-Google-Smtp-Source: APXvYqzW0WAv6Ow20ON14GDyfqY2gH4LWCP5N9Hl8AaudsUdfB7WE9FN3fjyeLQtlFKaqNShBmqcfw==
X-Received: by 2002:ac8:17f7:: with SMTP id r52mr37979671qtk.235.1559780446045;
        Wed, 05 Jun 2019 17:20:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t26sm77408qkt.89.2019.06.05.17.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 17:20:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYg96-0003xL-TO; Wed, 05 Jun 2019 21:20:44 -0300
Date:   Wed, 5 Jun 2019 21:20:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
Message-ID: <20190606002044.GD3273@ziepe.ca>
References: <20190606000209.26086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606000209.26086-1-sagi@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 05, 2019 at 05:02:09PM -0700, Sagi Grimberg wrote:
> if the lld does not explicitly sets this, scsi takes BLK_MAX_SEGMENT_SIZE
> and sets it using dma_set_max_seg_size(). In our case, this will affect
> all the rdma device consumers.
> 
> Fix it by setting shost max_segment_size according to the device
> capability.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> This goes on top of hch patchset:
> "properly communicate queue limits to the DMA layer"
> 
> Normally this should go through the rdma tree, so we can
> either get it through jens with hch patchset. Alternatively
> this is a fix that should go to rc anyways?

If CH's series goes to -rc we can take this through rdma after it gets
to -rc4 or so..

Otherwise Jens should probably take it, I'm not expecting conflicts in
this area so far.

Thanks,
Jason
