Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B92FF98
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfE3Ps5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 11:48:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50988 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Ps5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 11:48:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so276122wme.0
        for <linux-scsi@vger.kernel.org>; Thu, 30 May 2019 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cu+hi41BGDayUiqPxylDiDNAOXQyhy257aVt4Nm9Cr4=;
        b=fI2Mv/ypqjQhbx65BW1jCWT10DhHx4vNHkeMaM6z3bserQT2n+jUtM1A73h1uGMvqD
         +yVWoxzVCWIAGNWpR25TqgMo2MztSxyVUzmESkzwyoUj7cZ5lXOJ1myNGgK8HdQrSSwz
         jkO42WmdzEVKq5Y42C0BSN5JBpjziCPRf25Ak45TRg/JsjJxQWAEDv3T90tL8VmUZL9h
         M9PXW/9PG1st7ajnwPomqEkgr8dRXqmH9x6QITRDQAcSIc6w4PfEIgv2NpccrRAeStDX
         UaHiKGDSn3MBt4IvWMoL4IbskaShYYs0w1GHhluPcTSCjckxUPpj/k9r1jrc9KHQN0tT
         THTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cu+hi41BGDayUiqPxylDiDNAOXQyhy257aVt4Nm9Cr4=;
        b=Cvn+1dhLZyAr9LM4M9A2HGPI/EyJXrJlXlR7RAAVtH+FgBVzu8DfWrIXdBFSImmLCl
         BHM8pE2lqHcQ9seMpF24zT6dXIRbFPjN0VN1GwImOUdhNbG6DG/i2qqLDIa3FB3Qw5tI
         DouO0dny2ogVaM9JQtPEJf+WG111f6lAjb4VjTO9Jn1A2x+AG3PTExZHqCzg5DtjDgOI
         DoKDTJvahco4IpPBGd5AlDZbpn1HTE98zshU4aq5XOx+ARmPklf/1Vo+bzJTCV6iT3/X
         qrahFGAijLkbDfN0YItZLorc8YfcEW/8dazBOOb6PqtLjQOy+2grt/WpXrjfRpvbD1De
         sVIw==
X-Gm-Message-State: APjAAAU9KlFTO+8R/qpEUUXHDYLHLgsAoBsD4e3z/QoTyELsX+ws4qW4
        GA1BYywoh5U7YTmFTY4X3eQlFInDn2Ua18pSsCnwPBx/PbIQMQ==
X-Google-Smtp-Source: APXvYqzc4kqEaBiJbo9aggWheYES8JQa3EA5ZbMd8D5FFYbW9/hUDbtKhPjRp4FEBuMhnnUb0UUTtgyjDxJv087hpJo=
X-Received: by 2002:a1c:8049:: with SMTP id b70mr2658047wmd.33.1559231335308;
 Thu, 30 May 2019 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190529132901.27645-1-hare@suse.de> <20190529132901.27645-3-hare@suse.de>
 <20190530064101.GA22773@ming.t460p> <0e8c345e-1fa4-5420-2dc1-26f449b027ca@suse.de>
In-Reply-To: <0e8c345e-1fa4-5420-2dc1-26f449b027ca@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 30 May 2019 23:48:43 +0800
Message-ID: <CACVXFVM9igoO+NMY=JHLDWxE3aX=yiCcAjMs=YwtciANLdh-ow@mail.gmail.com>
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 30, 2019 at 10:57 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/30/19 8:41 AM, Ming Lei wrote:
> > On Wed, May 29, 2019 at 03:28:39PM +0200, Hannes Reinecke wrote:
> >> Add helper functions to retrieve SCSI commands from the reserved
> >> tag pool.
> >>
> >> Signed-off-by: Hannes Reinecke <hare@suse.com>
> >> ---
> >>   include/scsi/scsi_tcq.h | 22 ++++++++++++++++++++++
> >>   1 file changed, 22 insertions(+)
> >>
> >> diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
> >> index 6053d46e794e..227f3bd4e974 100644
> >> --- a/include/scsi/scsi_tcq.h
> >> +++ b/include/scsi/scsi_tcq.h
> >> @@ -39,5 +39,27 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
> >>      return blk_mq_rq_to_pdu(req);
> >>   }
> >>
> >> +static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
> >> +{
> >> +    struct request *rq;
> >> +    struct scsi_cmnd *scmd;
> >> +
> >> +    rq = blk_mq_alloc_request(sdev->request_queue,
> >> +                              REQ_OP_SCSI_OUT | REQ_NOWAIT,
> >> +                              BLK_MQ_REQ_RESERVED);
> >> +    if (IS_ERR(rq))
> >> +            return NULL;
> >> +    scmd = blk_mq_rq_to_pdu(rq);
> >> +    scmd->request = rq;
> >> +    return scmd;
> >> +}
> >
> > Now all these internal commands won't share tags with IO requests,
> > however, your patch switches to reserve slots for internal
> > commands.
> >
> Yes.
>
> > This way may have performance effect on IO workloads given the
> > reserved tags can't be used by IO at all.
> >
> Not really. Basically all drivers which have to use tags to send
> internal commands already set some tags aside to handle internal
> commands. So all this patchset does is to formalize this behaviour by
> using private tags.
> Some drivers (like fnic or snic) does _not_ do this currently; for those
> I've set one command aside to handle command abort etc.

From hardware view, you might be right, however, the implementation
isn't correct:

set->queue_depth means number of the total tags, set->reserved_tags is just
part of the total tags, see blk_mq_init_bitmap_tags().

So any driver sets .reserved_tags > 0, tags available for IO is reduced by
same amount, isn't it?  Cause .can_queue isn't increased.


Thanks,
Ming Lei
