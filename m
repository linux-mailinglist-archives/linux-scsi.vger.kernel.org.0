Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6EE195
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfD2LvM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 07:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfD2LvM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j38JudO0qhU870Yr7jDI/6QZJ039LfXF1doZeEZ7TeQ=; b=Z/nRoZb3biXgz/w5MCCNWRTeS
        xWTSP8tEduOOJuU0KVkn4MTHPPRdNw8urSwBcY4Dxi32FUWESD3Tdwa9XQ6nIjGyEGovvwbshcG2b
        OZhV22rF9JHCVLHZUebOFaRbQ1qH6R+1Y8H3UWNFzG75Ze/CspFfyrkA35OkazX7vpDk7tb0p4Jn3
        qj8RfWXcfNXQJuo8vpTexSwKMCWyIvsgkUBph1S4w+l7Y3g3sHHkA6YWJ8MCYcbHOttJZXOfE1WlW
        OA1d4EVitpvcZGayfc2Hj510r1MhEJvmiWoMbB/9T7OY9NqeqKk4U4nXmZFQ9q7v6COdedpHrIIqf
        RW6XmXpfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL4oI-00087V-Vz; Mon, 29 Apr 2019 11:51:02 +0000
Date:   Mon, 29 Apr 2019 04:51:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fdomain: Resurrect driver (core)
Message-ID: <20190429115102.GB25365@infradead.org>
References: <20190422173323.15365-1-linux@zary.sk>
 <20190422173323.15365-2-linux@zary.sk>
 <20190424060212.GA5506@infradead.org>
 <201904282152.32077.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904282152.32077.linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Apr 28, 2019 at 09:52:31PM +0200, Ondrej Zary wrote:
> On Wednesday 24 April 2019 08:02:12 Christoph Hellwig wrote:
> > > +static void fdomain_work(struct work_struct *work)
> > > +{
> > > +	struct fdomain *fd = container_of(work, struct fdomain, work);
> > > +	struct Scsi_Host *sh = container_of((void *)fd, struct Scsi_Host,
> > > +					    hostdata);
> > 
> > This looks odd.  We should never need a void cast for container_of.
> 
> This cast is present in all drivers involving container_of, struct Scsi_Host and hostdata. hostdata in struct Scsi_Host is defined as "unsigned long hostdata[0]"...

Oh, right - it is the hostdata mess.  Sorry for the noise!
