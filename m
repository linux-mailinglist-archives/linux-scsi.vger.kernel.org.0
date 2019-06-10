Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55EF3BFA9
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2019 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfFJXCa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 19:02:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33342 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390340AbfFJXC3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 19:02:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3FCFA8EE182;
        Mon, 10 Jun 2019 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560207749;
        bh=XbFAvY+RkM8o5Sd21kgZZJjGvrgAoeHtELASG9QdLDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UF/A/wT/VxDkq35r0+nVYMqMVx6rtHvJisSq7x+D0nAG8Z0AnGtfdBkkTdnexuOrn
         xtPd9KeMVuTFCm48X4h0cQ21z1PgZfRjCvONgJNaII54YdTOpRScH2w8V/BBT9QdvR
         DY/aJhKu8GqGY9gu9BwElqxX1ryrgP1UvZWr1Zmk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b7FVjTJhPtcR; Mon, 10 Jun 2019 16:02:29 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 76E678EE105;
        Mon, 10 Jun 2019 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560207748;
        bh=XbFAvY+RkM8o5Sd21kgZZJjGvrgAoeHtELASG9QdLDM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VO2aNZc4HO28KM6Kb67i+dGzc5g/tvitpDvXyJymuGryiYIqhyn7gsO+xPyfC6ayP
         WU+j+1gaJfqS/mmEjqVGNdwflkVg+R7Aa3kk7Jl383pPB2ZRJBLCWOXXJV0YNlLMQ2
         H3CjP4CVQLT6lYJn5BrtGz2Qy/mK1THEroonsiKU=
Message-ID: <1560207747.3698.30.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 16:02:27 -0700
In-Reply-To: <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-3-ming.lei@redhat.com>
         <1560191829.3698.8.camel@HansenPartnership.com>
         <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 15:36 -0400, Ewan D. Milne wrote:
> On Mon, 2019-06-10 at 11:37 -0700, James Bottomley wrote:
> > On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> > > The current way isn't safe for chained sgl, so use sgl helper to
> > > operate sgl.
> > 
> > The advansys driver doesn't currently use a chained
> > scatterlist.  In
> > theory it could; the 
> > 
> > 	if (shost->sg_tablesize > SG_ALL) {
> > 		shost->sg_tablesize = SG_ALL;
> > 	}
> > 
> > At around line 11226 is what prevents it and that could be
> > eliminated provided someone actually has the hardware to test.
> > 
> > However, provided drivers make the correct SG_ALL or less
> > declaration, they're entitled to treat scatterlists as fully
> > contiguous, so there's no real justification (beyond uniformity)
> > for making it use the chain helpers.
> > 
> > James
> > 
> 
> I thought the whole issue came about because Ming's earlier changes
> to scsi_lib.c made the previously SG_CHUNK_SIZE scatterlist allocated
> with the struct request much smaller, (SCSI_INLINE_SG_CNT is 2) so
> everything needs to support it?

Um, well, I'm just going by the commit log.  If the problem is someone
broke the SG_ALL no chaining assumption in an earlier commit, finger
that as the buggy commit you're fixing rather than implying the drivers
had a longstanding bug.  In fact, preferably do this work as a
precursor to the original instead of leaving the drivers broken for a
bisect.

James

