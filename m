Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA544E9DE
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Nov 2021 16:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhKLPW2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Nov 2021 10:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhKLPW1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Nov 2021 10:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636730376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
        b=IEmTYYOVu8mnNf8dncwvv63iPXnTzw+SDFVpHEr5SCq5O1ZxbPCmPqq7Wdw97KhFccVCcs
        PpvF0X6sLfvePo+htyPszZOVP9OPJFw+TC9+/jUt+DHqLVkcJdZ2V8c3AfrjHJX4R0Iaf/
        vTUFGcudgKajU4OGV7+iJCc739D3CyQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-HCwmsxR3ObuVLBpo4Ks9xw-1; Fri, 12 Nov 2021 10:19:35 -0500
X-MC-Unique: HCwmsxR3ObuVLBpo4Ks9xw-1
Received: by mail-qk1-f200.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so6649459qkl.7
        for <linux-scsi@vger.kernel.org>; Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
        b=rFdSVhGHbRHvd7yiozLhsaTt7yZzb2I2dKsiY/OVv14DKLr1af2RWzCAUymD1uezsu
         YszTxhHEXUjlKmRJUlMJbl198z98mHCH8fcqk8AmZYcZDOrAsvRdFEXx3QVGl4obcEap
         7s07Sh8RRnQVvriXRhnsjUzAhRA3mLrK4FiSyZZ247UTWOzQjuujop2g0RrliqiqAWp9
         XNoujQ9wPLbibSPrMGD7Cl1qv1mEoyHpUtmPWl3NflizhPYmKq3GKMF7vKCgE/Dru8+3
         YUcu8N9lVV47xTZ1EAc65EuB8PJNZ5rfBq2mIxs86Z/G6hbJRTBRQ0+Ihm8yBfxNozX4
         FUqA==
X-Gm-Message-State: AOAM5307fwBeVEpV3WzTIO6AMP0FnmkYBCEM6OF7lOm781R2RfFU1a7K
        eOHjlFUa+8V5bRTfyJHobp+3wCklLNolefet/1nPcknm27g7ym+RPZFv9f7XQ6lFZ2Pqla6Br2Q
        B2veBKpOXd2zPgDAphDE6
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127490qkh.232.1636730375044;
        Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk6sSDPzw7jrkKAxFn/K0PAx9HKUToVCIsJBG7fV34DkkAlHg0N9AMoil4JWoJAqjFdQQ15g==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127438qkh.232.1636730374828;
        Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id az14sm2791255qkb.125.2021.11.12.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:19:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 8/8] md: add support for REQ_OP_VERIFY
Message-ID: <YY6GBaSypKNPZnBj@redhat.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-9-chaitanyak@nvidia.com>
 <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 11 2021 at  3:13P -0500,
Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:

> On 11/3/2021 11:46 PM, Chaitanya Kulkarni wrote:
> > From: Chaitanya Kulkarni <kch@nvidia.com>
> > 
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> I want to make sure the new REQ_OP_VERIFY is compatible with the
> dm side as it is a generic interface.
> 
> Any comments on the dm side ? It will help me to respin the series for
> V1 of this proposal.

I can review, but have you tested your XFS scrub usecase ontop of
the various DM devices you modified?

Also, you seem to have missed Keith's suggestion of using io_uring to
expose this capability.  If you happen to go that route: making sure
DM has required io_uring capabilities would be needed (IIRC there
were/are some lingering patches from Ming Lei to facilitate more
efficient io_uring on DM.. I'll try to find, could be I'm wrong).

Mike

