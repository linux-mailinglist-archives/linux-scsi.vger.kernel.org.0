Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BF43DE6
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfFMPqP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:46:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39970 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfFMPqO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 11:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2438C8EE0C7;
        Thu, 13 Jun 2019 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560440773;
        bh=gMwntk/IzwI086ahC3l12emrfcHO6JQMxmh3VkSjshE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mIPNn1GoVw9YK9vvc5PGLtMEryM+8RTsdlT68HIfW9ha65vB5qtZLGouYz9JntDVS
         3h2KG8HuVYnYBcOO5xxs6fYayxJKsNb3Yhg/kwdjmS22LkUTZR9kXgcZkHukM+fs2J
         NcA4++VNcrugYnf+J3NNdGuMHbhwNDAtkubEdxsk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 98QEIRZ8iKoF; Thu, 13 Jun 2019 08:46:12 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4DF778EE147;
        Thu, 13 Jun 2019 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560440772;
        bh=gMwntk/IzwI086ahC3l12emrfcHO6JQMxmh3VkSjshE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WrEHxmx+NcCR4U45jwluUA05nbpOLZUWOfZeYramAtpt8Z5fK6D3T/hi00P5XyQQC
         sV6f/Z4KLX4DGguHABjCcep72L4ch8xyq8Z6+Fbtm1Gi95FdHaq8RXy99PkZzyOL/K
         jxx0qKEmdu+MEsE3lTXyXzWo/Fc4DBoPl3fbTBrM=
Message-ID: <1560440768.3329.30.camel@HansenPartnership.com>
Subject: Re: [PATCH V2 08/15] staging: unisys: visorhba: use sg helper to
 operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, devel@driverdev.osuosl.org,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>, Jim Gill <jgill@vmware.com>,
        Brian King <brking@us.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Thu, 13 Jun 2019 08:46:08 -0700
In-Reply-To: <20190613101656.GA28256@kroah.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
         <20190613071335.5679-9-ming.lei@redhat.com>
         <20190613095214.GA18796@kroah.com> <20190613100410.GA10829@ming.t460p>
         <20190613101656.GA28256@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-06-13 at 12:16 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2019 at 06:04:11PM +0800, Ming Lei wrote:
> > On Thu, Jun 13, 2019 at 11:52:14AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 13, 2019 at 03:13:28PM +0800, Ming Lei wrote:
> > > > The current way isn't safe for chained sgl, so use sg helper to
> > > > operate sgl.
> > > 
> > > I can not make any sense out of this changelog.
> > > 
> > > What "isn't safe"?  What is a "sgl"?
> > 
> > sgl is 'scatterlist' in kernel, and several linear sgl can be
> > chained together, so accessing the sgl in linear way may see a
> > chained sg, which is like a link pointer, then may cause trouble
> > for driver.
> 
> What kind of "trouble"?  Is this a bug fix that needs to be
> backported to stable kernels?  How can this be triggered?

OK, stop.  I haven't seen the commit log since the original hasn't
appeared on the list yet, but the changelog needs to say something like
this to prevent questions like the above, as I asked in the last
review.  Please make it something like this:

---
Scsi MQ makes a large static allocation for the first scatter gather
list chunk for the driver to use.  This is a performance headache we'd
like to fix by reducing the size of the allocation to a 2 element
array.  Doing this will break the current guarantee that any driver
using SG_ALL doesn't need to use the scatterlist iterators and can get
away with directly dereferencing the array.  Thus we need to update all
drivers to use the scatterlist iterators and remove direct indexing of
the scatterlist array before reducing the initial scatterlist
allocation size in SCSI.
---

James

