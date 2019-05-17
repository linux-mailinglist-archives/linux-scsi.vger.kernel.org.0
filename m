Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7179F214C8
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfEQHtr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 03:49:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfEQHtr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 03:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7xYUNiPg7hnelZnO5AvvNBshS9i2+xY65lN66AVA0G0=; b=BfkgYsMqfmVwS7LfVfmldJinD
        y8Wc/LIbJxMSGLcWuYJ6VduymLRefFRBQb4a4XeHHySjk1kwofk6actF0R8pZ3jx0rfROp9rR/swa
        J4x32sccgK10FwGHdRa2/y04a+Aff0fGUVJJfvY2KfuBJBAOcsmQCCCSDrn+e870jOBHeYAkIw/xG
        q/T2N+lWcatJQJdoI2goH3ZtUEnvANzHj0SWcl31OErJuvgJm+hgzIDRxQ45kga9rKBCXyL/AOAQh
        HB5GqLAS74OUe/2GxybhK8g8AQnsPLV3ZJaconztPddDR4N0n420dUq+j0Bqb4OBMF9+Wsv/PYCZx
        HpYy4+JFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRXch-0002k2-1k; Fri, 17 May 2019 07:49:47 +0000
Date:   Fri, 17 May 2019 00:49:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     whiteheadm@acm.org
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
Message-ID: <20190517074946.GA10090@infradead.org>
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org>
 <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
 <20190513122846.GA15835@infradead.org>
 <CAP8WD_YTqcduLsYRU-tCsCLC9wvAp4624Ls350Eb98K_fs0+Hw@mail.gmail.com>
 <20190516065823.GA17189@infradead.org>
 <CAP8WD_Z11rikDsn-8u12RYgaXrkReuDyvHLBfsDhCES4EpatTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_Z11rikDsn-8u12RYgaXrkReuDyvHLBfsDhCES4EpatTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 16, 2019 at 05:44:43PM -0400, tedheadster wrote:
> On Thu, May 16, 2019 at 2:58 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Can you still send me the dmesg output with the AHCI debug patch?
> > I'm curious why we can't do 64-bit DMA to your device.
> 
> Christoph,
>   here is the dmesg output with your patch. 64-bit mode is not enabled.

Thanks.  Despite my slightly misleading printk everything looks fine!
