Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330D6818EC
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 14:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHEMNh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 08:13:37 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36113 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfHEMNh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 08:13:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1481E20423A;
        Mon,  5 Aug 2019 14:13:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qNHDHyTnk9xf; Mon,  5 Aug 2019 14:13:34 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id E2E45204153;
        Mon,  5 Aug 2019 14:13:34 +0200 (CEST)
Reply-To: dgilbert@interlog.com
To:     SCSI development list <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@ORACLE.COM>,
        jejb@linux.vnet.ibm.com, Bart Van Assche <bvanassche@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: RFC: scsi_lib: export scsi_alloc_sense_buffer() and
 scsi_free_sense_buffer()
Message-ID: <2381e5dd-7963-0d97-ff44-b02b57e4c601@interlog.com>
Date:   Mon, 5 Aug 2019 14:13:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In a review comment to this post:
     [PATCH v2 12/18] sg: sense buffer rework

Hannes said:
 > Maybe it's worthwhile using a mempool here for sense buffers; frequest
 > kmalloc()/kfree() really should be avoided.
 >
 > Also the allocation at end_io time is slightly dodgy; I'd rather have
 > the sense allocated before setting up the command. Thing is, the end_io
 > callback might be called at any time and in about every context
 > (including from an interrupt handler), so I really would avoid having to
 > do kmalloc() there.


The problem, seen from the POV of the sg driver, is to get a sense_buffer
either before, or at the time of, sg_rq_end_io(). It needs to be by the end
of that call because the inherited code for the sg driver comments that
the associated request and scsi_request object(s) will be "freed" toward
the end of sg_rq_end_io() to maximize re-use of those objects.

To get a sense_buffer _before_ sg_rq_end_io() seems an unnecessary imposition
as I would guesstimate that the sense buffer is actually needed between
1% and 0.00001% of the time. Then that leaves fetching a sense_buffer within
sg_rq_end_io() _only_ when it is needed, copying the contents from either
scsi_request::sense [or scsi_cmnd::sense_buffer, which is damn confusing]
into an sg owned sense buffer before the request and associated
scsi_request (and associated scsi_cmnd) object is "freed" (actually put back
into the pool for re-use, I suspect).

Now addressing Hannes' comment: scsi_lib.c already has a sense buffer pool,
actually two of them:
    static struct kmem_cache *scsi_sense_cache;
    static struct kmem_cache *scsi_sense_isadma_cache;

So it would be good to re-use that code, as I assume it works and is
efficient. But the two needed functions:
     scsi_alloc_sense_buffer() and scsi_free_sense_buffer()

are declared static and not exported.

So is that cache appropriate for the sg driver (and perhaps st and
ses drivers) and if so can those scsi_lib functions be exported?
They are a little over-constrained for what the sg driver needs.


As for the "dodgy" comment, I believe that is only in cases where
kernel janitors come along and unwisely change a gfp_mask from
GFP_ATOMIC to GFP_KERNEL. Hopefully a comment like
        ... , GFP_ATOMIC /* <-- leave */);
will catch the attention of a janitor, a reviewer, or someone debugging
broken code.

Doug Gilbert


PS: The split personalities of scsi_request and scsi_cmnd:
Here is a quick survey of ULDs in the scsi subsystem:

ULD    Uses
==========================
sd     scsi_cmnd (only)
sr     scsi_cmnd (only)
st     scsi_request (only)
sg     scsi_request (only)
ch     neither
ses    neither

Rationale ?



