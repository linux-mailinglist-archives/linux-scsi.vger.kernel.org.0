Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4361938259
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfFGBCl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 21:02:41 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59668 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBCl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 21:02:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 28B4229D1D;
        Thu,  6 Jun 2019 21:02:37 -0400 (EDT)
Date:   Fri, 7 Jun 2019 11:02:36 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ondrej Zary <linux@zary.sk>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH V3 0/3] scsi: three SG_CHAIN related fixes
In-Reply-To: <yq1ftommk66.fsf@oracle.com>
Message-ID: <alpine.LNX.2.21.1906070956580.26@nippy.intranet>
References: <20190606083410.32243-1-ming.lei@redhat.com> <yq1ftommk66.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 6 Jun 2019, Martin K. Petersen wrote:

> 
> Ming,
> 
> > Guenter reported scsi boot issue caused by commit c3288dd8c232 ("scsi:
> > core: avoid pre-allocating big SGL for data").
> 
> Applied to 5.3/scsi-queue, thank you!
> 

Thanks, that seems to fix the esp_scsi regression.

Am I right in thinking that commit c3288dd8c232 ("scsi: core: avoid 
pre-allocating big SGL for data") has the effect that any scsi host with 
sg_tablesize > 2 must now support chained sg lists?

In commit 4af14d113bcf ("[PATCH] scsi: remove the use_clustering flag"), I 
read that "setting the dma_boundary to PAGE_SIZE - 1 and the 
max_segment_size to PAGE_SIZE" is sufficient to inhibit clustering. Is 
that sufficient to inhibit chained sg lists for LLDs?

Does it follow that #define SCSI_INLINE_SG_CNT 2 is now the upper bound 
for sg list entries (clamping sg_tablesize) for those LLDs (regardless 
support for chained sg lists)?

Does commit c3288dd8c232 have similar implications for any LLD running on 
an architecture with CONFIG_ARCH_NO_SG_CHAIN=y?

I can't find answers to these questions in Documentation/block/biodoc.txt 
etc. Any clarification or insight you can offer would be appreciated.

Thanks.

-- 
