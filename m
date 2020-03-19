Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1818B463
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2020 14:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgCSNJY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Mar 2020 09:09:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgCSNJX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Mar 2020 09:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqjXm+8cIASTCtWXrNBERiIJ/yMnw/FMEWzdd1tFgnY=; b=q68hYra68mmG4bCZpjhfB/vJb8
        qb2vzF+rKq8qzNbyTAM1/V73b+e+HLwTsHN3zGecNXizjPGvbN3amJ4cWDMlhpjr6foSvxLYOB7yM
        uZqYFtfnP+JCtTejGvKNFTjL4fh/WV1OIXOhukJ0dpgLyL47cyTZWVDaozK9vSr2DEjWSqzlOaO+T
        9LRWuod1lR7NFg9Oc2OX8pKBIADhxMOSFkXnYT8X9Tjg4CJQPwqlG7k7NmcZpMnJcvg4VUG42Mf5z
        KR8vj4xYqjf7w/+UEp0RgHJkK0ocW4jhjNVnbwoI1QikjJB0lYGyhS3OlAzgbp7igZv1vE3+BPtke
        VfyWRfZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEuvL-00070D-6X; Thu, 19 Mar 2020 13:09:23 +0000
Date:   Thu, 19 Mar 2020 06:09:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/5] mpt3sas: Handle RDPQ DMA allocation in same 4g region
Message-ID: <20200319130923.GA26476@infradead.org>
References: <1581416293-41610-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1581416293-41610-5-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20200225184202.GC6261@infradead.org>
 <CAK=zhgoR0k+eoEMNznMGCF21eQMKT2UJ5vufCho4dXfHNFFV3g@mail.gmail.com>
 <CAK=zhgpXF=qcwhwpzsx44GDEJxFXLcZFSgO9cAXL8p2GjU0KoQ@mail.gmail.com>
 <CA+RiK67RquZitjQrh=yGcdunAOZaOhS90xGk3Mco2rm-ZHrEYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RiK67RquZitjQrh=yGcdunAOZaOhS90xGk3Mco2rm-ZHrEYA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Mar 18, 2020 at 12:21:11PM +0530, Suganath Prabu Subramani wrote:
> Hi Christoph,
> 
> We will simplify the logic as below, let us know your comments.
> 
> #use one dma pool for RDPQ's, thus removes the logic of using second dma
> pool with align.
> The requirement is, RDPQ memory blocks starting & end address should have
> the same
> higher 32 bit address.
> 
> 1) At driver load, set DMA Mask to 64 and allocate memory for RDPQ's.
> 
> 2) Check if allocated resources are in the same 4GB range.
> 
> 3) If #2 is true, continue with 64 bit DMA and go to #6
> 
> 4) If #2 is false, then free all the resources from #1.
> 
> 5) Set DMA mask to 32 and allocate RDPQ's.
> 
> 6) Proceed with driver loading and other allocations.

Yes, please do.
