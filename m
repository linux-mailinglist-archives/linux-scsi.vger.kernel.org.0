Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD61FFE5
	for <lists+linux-scsi@lfdr.de>; Thu, 16 May 2019 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEPG6Y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 May 2019 02:58:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEPG6Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 May 2019 02:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cJhtT9u8y+hG+p/Xv3cZ+1L1SMwh5WOTyLBnnr/HCUo=; b=d9C+ZpTUlssoMEN8hGsk8SGjR
        QMOmWClT65ltzF9EuVXuJvsfT43TD/Gu0xqqcelIT50zQI0xAx96F5DDVMNSMfcbr9h51/xln6a+Q
        Kn14rkCki4W/BsDZ4thzA4qAdlVl6KatX1rLN5kZNN3+0iKYPyG50rH3aBKAfZJuu+7vUJklwWVC2
        imycBhk9c9QPzN8IAIw3PJ5LdMI3qftFs8Qf2BUPQCvxqhQO+uiAbroONAztnlIBn+wFJCQVG4fhB
        ZsAoPIvmHcef3XTYKR4mMgPqQhoG6qUNibwpaaxf8XUOF6L5mmL2aw8+Z3IkuKCyoQzco4C3LCfk3
        /LzR38p9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRALQ-0004V6-0w; Thu, 16 May 2019 06:58:24 +0000
Date:   Wed, 15 May 2019 23:58:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     whiteheadm@acm.org
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
Message-ID: <20190516065823.GA17189@infradead.org>
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org>
 <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
 <20190513122846.GA15835@infradead.org>
 <CAP8WD_YTqcduLsYRU-tCsCLC9wvAp4624Ls350Eb98K_fs0+Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_YTqcduLsYRU-tCsCLC9wvAp4624Ls350Eb98K_fs0+Hw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 15, 2019 at 06:23:20PM -0400, tedheadster wrote:
> Christoph,
>   I believe I found the problem, and it does not relate to anything I
> considered before. I forgot that I had chosen the SLOB memory
> allocator for a previous test and it was still enabled. There was a
> huge amount of locking slowing the system down while SLOB was
> allocating new memory with its simple algorithm.
> 
> Switching to SLUB has improved it immensely. I am sorry I missed this
> rather important item.

Can you still send me the dmesg output with the AHCI debug patch?
I'm curious why we can't do 64-bit DMA to your device.
