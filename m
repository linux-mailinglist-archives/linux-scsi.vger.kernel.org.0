Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BE3FD736
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Sep 2021 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhIAJvO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Sep 2021 05:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232817AbhIAJvO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 Sep 2021 05:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630489817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9pkxPeIT3jfPlp49Tf0bbQtBACmuxy4I9myE5ofaSw=;
        b=aSLaWTmzVam1sk3G0/eXLxOsEB1BwhCWU5K8rlGN1lMODIZ5Xr9hm82vCpWWF0qasa/NkE
        LMq4cwA56ylk9dgzxtv89bSRm3JzrjIMmO23cKufcIopifGpI+oezrprgbeHs/bRsqNYnz
        J4NPlItp5ghRM+zhlul/3KJvPavU+vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-yff_s_iENneDkG3hQbVroA-1; Wed, 01 Sep 2021 05:50:16 -0400
X-MC-Unique: yff_s_iENneDkG3hQbVroA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C502F6D252;
        Wed,  1 Sep 2021 09:50:14 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6147C100164C;
        Wed,  1 Sep 2021 09:50:06 +0000 (UTC)
Date:   Wed, 1 Sep 2021 17:50:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     luojiaxing <luojiaxing@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        john.garry@huawei.com
Subject: Re: rq pointer in tags->rqs[] is not cleared in time and make SCSI
 error handle can not be triggered
Message-ID: <YS9Myajg+h4io1F5@T590>
References: <fe5cf6c4-ce5e-4a0f-f4ab-5c10539492cb@huawei.com>
 <YSdCfSeEv9s9OUMX@T590>
 <ebda23e8-0fa2-e96c-ee09-e0b2e783c40e@huawei.com>
 <YS9Jt8wTScNBIPlj@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS9Jt8wTScNBIPlj@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 01, 2021 at 05:36:55PM +0800, Ming Lei wrote:
> On Tue, Aug 31, 2021 at 10:27:28AM +0800, luojiaxing wrote:
> > Hi, Ming
> > 
> > 
> > Sorry to reply so late, This issue occur in low probability,
> > 
> > so it take some time to confirm.
> > 
> > 
> > On 2021/8/26 15:29, Ming Lei wrote:
> > > On Thu, Aug 26, 2021 at 11:00:34AM +0800, luojiaxing wrote:
> > > > Dear all:
> > > > 
> > > > 
> > > > I meet some problem when test hisi_sas driver(under SCSI) based on 5.14-rc4
> > > > kernel, it's found that error handle can not be triggered after
> > > > 
> > > > abnormal IO occur in some test with a low probability. For example,
> > > > circularly run disk hardreset or disable all local phy of expander when
> > > > running fio.
> > > > 
> > > > 
> > > > We add some tracepoint and print to see what happen, and we got the
> > > > following information:
> > > > 
> > > > (1).print rq and rq_state at bt_tags_iter() to confirm how many IOs is
> > > > running now.
> > > > 
> > > > <4>[  897.431182] bt_tags_iter: rqs[2808]: 0xffff202007bd3000; rq_state: 1
> > > > <4>[  897.437514] bt_tags_iter: rqs[3185]: 0xffff0020c5261e00; rq_state: 1
> > > > <4>[  897.443841] bt_tags_iter: rqs[3612]: 0xffff00212f242a00; rq_state: 1
> > > > <4>[  897.450167] bt_tags_iter: rqs[2808]: 0xffff00211d208100; rq_state: 1
> > > > <4>[  897.456492] bt_tags_iter: rqs[2921]: 0xffff00211d208100; rq_state: 1
> > > > <4>[  897.462818] bt_tags_iter: rqs[1214]: 0xffff002151d21b00; rq_state: 1
> > > > <4>[  897.469143] bt_tags_iter: rqs[2648]: 0xffff0020c4bfa200; rq_state: 1
> > > > 
> > > > The preceding information show that rq with tag[2808] is found in different
> > > > hctx by bt_tags_iter() and with different pointer saved in tags->rqs[].
> > > > 
> > > > And tag[2808] own the same pointer value saved in rqs[] with tag[2921]. It's
> > > > wrong because our driver share tag between all hctx, so it's not possible
> > > What is your io scheduler? I guess it is deadline,
> > 
> > 
> > yes
> > 
> > 
> > >   and can you observe
> > > such issue by switching to none?
> > 
> > 
> > Yes, it happen when switched to none
> > 
> > 
> > > 
> > > The tricky thing is that one request dumped may be re-allocated to other tag
> > > after returning from bt_tags_iter().
> > > 
> > > > to allocate one tag to different rq.
> > > > 
> > > > 
> > > > (2).check tracepoints(temporarily add) in blk_mq_get_driver_tag() and
> > > > blk_mq_put_tag() to see where this tag is come from.
> > > > 
> > > >      Line 1322969:            <...>-20189   [013] .... 893.427707:
> > > > blk_mq_get_driver_tag: rqs[2808]: 0xffff00211d208100
> > > >      Line 1322997:  irq/1161-hisi_s-7602    [012] d..1 893.427814:
> > > > blk_mq_put_tag_in_free_request: rqs[2808]: 0xffff00211d208100
> > > >      Line 1331257:            <...>-20189   [013] .... 893.462663:
> > > > blk_mq_get_driver_tag: rqs[2860]: 0xffff00211d208100
> > > >      Line 1331289:  irq/1161-hisi_s-7602    [012] d..1 893.462785:
> > > > blk_mq_put_tag_in_free_request: rqs[2860]: 0xffff00211d208100
> > > >      Line 1338493:            <...>-20189   [013] .... 893.493519:
> > > > blk_mq_get_driver_tag: rqs[2921]: 0xffff00211d208100
> > > > 
> > > > As we can see this rq is allocated to tag[2808] once, and finially come to
> > > > tag[2921], but rqs[2808] still save the pointer.
> > > Yeah, we know this kind of handling, but not see it as issue.
> > > 
> > > > There will be no problem until we encounter a rare situation.
> > > > 
> > > > For example, tag[2808] is reassigned to another hctx for execution, then
> > > > some IO meet some error.
> > > I guess the race is triggered when 2808 is just assigned, meantime
> > > ->rqs[] isn't updated.
> > 
> > 
> > As we shared tag between hctx, so if 2808 was assinged to other hctx.
> > 
> > So previous hctx's rqs will not updated。
> > 
> > 
> > > > Before waking up the error handle thread, SCSI compares the values of
> > > > scsi_host_busy() and shost->host_failed.
> > > > 
> > > > If the values are different, SCSI waits for the completion of some I/Os.
> > > > According to the print provided by (1), the return value of scsi_host_busy()
> > > > should be 7 for tag [2808] is calculated twice,
> > > > 
> > > > and the value of shost->host_failed is 6. As a result, this two values are
> > > > never equal, and error handle cannot be triggered.
> > > > 
> > > > 
> > > > A temporary workaround is provided and can solve the problem as:
> > > > 
> > > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > > index 2a37731..e3dc773 100644
> > > > --- a/block/blk-mq-tag.c
> > > > +++ b/block/blk-mq-tag.c
> > > > @@ -190,6 +190,7 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct
> > > > blk_mq_ctx *ctx,
> > > >                  BUG_ON(tag >= tags->nr_reserved_tags);
> > > >                  sbitmap_queue_clear(tags->breserved_tags, tag, ctx->cpu);
> > > >          }
> > > > +       tags->rqs[tag] = NULL;
> > > >   }
> > > > 
> > > > 
> > > > Since we did not encounter this problem in some previous kernel versions, we
> > > > wondered if the community already knew about the problem or could provide
> > > > some solutions.
> > > Can you try the following patch?
> > 
> > 
> > I tested it. it can fix the bug.
> > 
> > 
> > However, if there is still a problem in the following scenario? For example,
> > driver tag 0 is assigned
> > 
> > to rq0 in hctx0, and reclaimed after rq completed. Next time driver tag 0 is
> > still assigned to rq0 but
> > 
> > in hctx1. So at this time,  bt_tags_iter will still got two rqs.
> 
> Each hctx has its own rq pool so far, so no such issue you worried.
> 
> John's patch works towards sharing rq pool among hctxs in case of
> shared sbitmap, not merged yet, but ->rqs[] should be shared too, still
> no such issue.
> 
> Follows the revised patch for handling the stale request in ->rqs[] issue:
> 
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 86f87346232a..ff5caeb82542 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -208,7 +208,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>  
>  	spin_lock_irqsave(&tags->lock, flags);
>  	rq = tags->rqs[bitnr];
> -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> +	if (!rq || rq->tag != bitnr || !refcount_inc_not_zero(&rq->ref))
>  		rq = NULL;
>  	spin_unlock_irqrestore(&tags->lock, flags);
>  	return rq;

Explain the issue a bit in detail:

scsi_host_check_in_flight() is used to counting scsi in-flight requests
after scsi host is blocked, so no new scsi command can be marked as
SCMD_STATE_INFLIGHT. However, driver tag allocation still can be run at
that time by blk-mq core.

The issue is in blk_mq_tagset_busy_iter(). One request is in-flight, but
this request may be kept in another slot of ->rqs[], meantime the slot
can be allocated out but ->rqs[] isn't updated yet. Then the in-flight
request is counted twice as SCMD_STATE_INFLIGHT.


Thanks,
Ming

