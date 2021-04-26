Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAD36AA27
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 02:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhDZA4m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 25 Apr 2021 20:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231247AbhDZA4l (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 25 Apr 2021 20:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619398560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKYRSeiLkiR/jaBtGKeDPIosa1m/L6grwM4dRV82BUA=;
        b=WLa+5K8TvqxguU9G7bJqZUFWnX/ogX61NTT28HsCab9Z7ATW7E3Rm4M7ETQamqBQzjr/eb
        RcMRod959PN33IYKtpjQZhhMc1OFokMjRAa0BgW9MFvdWf/65StryU7yLncj1ysYmM485A
        zY435wHi2ViFYuLmi0jG18KFd3LvAu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-D0Omu1eBOUaJRLP-aapJBg-1; Sun, 25 Apr 2021 20:55:59 -0400
X-MC-Unique: D0Omu1eBOUaJRLP-aapJBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875651898296;
        Mon, 26 Apr 2021 00:55:57 +0000 (UTC)
Received: from T590 (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA725C1CF;
        Mon, 26 Apr 2021 00:55:48 +0000 (UTC)
Date:   Mon, 26 Apr 2021 08:55:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
Message-ID: <YIYPmvkRSVaiBhC8@T590>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org>
 <YIDqa6YkNoD5OiKN@T590>
 <b717ffc0-a434-738f-9c63-32901bd164b2@acm.org>
 <YIEiElb9wxReV/oL@T590>
 <32a121b7-2444-ac19-420d-4961f2a18129@acm.org>
 <YIJEg9DLWoOJ06Kc@T590>
 <28607d75-042f-7a6a-f5d0-2ee03754917e@acm.org>
 <YISzLal7Ur7jyuiy@T590>
 <037f5a58-545c-5265-c2a2-d2e8b92168c6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037f5a58-545c-5265-c2a2-d2e8b92168c6@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Apr 25, 2021 at 02:01:11PM -0700, Bart Van Assche wrote:
> On 4/24/21 5:09 PM, Ming Lei wrote:
> > However, blk_mq_wait_for_tag_iter() still may return before
> > blk_mq_wait_for_tag_iter() is done because blk_mq_wait_for_tag_iter()
> > supposes all request reference is just done inside bt_tags_iter(),
> > especially .iter_rwsem and read rcu lock is added in bt_tags_iter().
> 
> The comment above blk_mq_wait_for_tag_iter() needs to be updated but I
> believe that the code is fine. Waiting for bt_tags_iter() to finish
> should be sufficient to fix the UAF. What matters is that the pointer
> read by rcu_dereference(tags->rqs[bitnr]) remains valid until the
> callback function has finished. I think that is guaranteed by the
> current implementation.

It depends if 'rq' will be passed to another new context from ->fn(),
since 'rq' still can be USEed in the new context after ->fn() returns.


thanks,
Ming

