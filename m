Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2A43C9B
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFMPgt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFMKQ7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 06:16:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FECD2147A;
        Thu, 13 Jun 2019 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560421018;
        bh=VisLdZRLYBHUGC086DvgShH/5UWS0mQi8XB0fSRtouU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqnaYdYBeuHFc6qcgbkniXutVlSfJbi11qWa+Am+WKvgqpW2WcvivDUNY5Nu3Bf3y
         l5ZdR2RxMAUmXCPc+ULfR5TQHaPfS8Ec8yNVkaMMDBHqUuJprUNGcDfRtFiFffr8tj
         pavpRxKpH+8BAiIujv+eUifHMjQg8NficuACdCCE=
Date:   Thu, 13 Jun 2019 12:16:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, devel@driverdev.osuosl.org,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>, Jim Gill <jgill@vmware.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Brian King <brking@us.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 08/15] staging: unisys: visorhba: use sg helper to
 operate sgl
Message-ID: <20190613101656.GA28256@kroah.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-9-ming.lei@redhat.com>
 <20190613095214.GA18796@kroah.com>
 <20190613100410.GA10829@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613100410.GA10829@ming.t460p>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 06:04:11PM +0800, Ming Lei wrote:
> On Thu, Jun 13, 2019 at 11:52:14AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2019 at 03:13:28PM +0800, Ming Lei wrote:
> > > The current way isn't safe for chained sgl, so use sg helper to
> > > operate sgl.
> > 
> > I can not make any sense out of this changelog.
> > 
> > What "isn't safe"?  What is a "sgl"?
> 
> sgl is 'scatterlist' in kernel, and several linear sgl can be chained
> together, so accessing the sgl in linear way may see a chained sg, which
> is like a link pointer, then may cause trouble for driver.

What kind of "trouble"?  Is this a bug fix that needs to be backported
to stable kernels?  How can this be triggered?

> > Can this be applied "out of order"?
> 
> Yes, there isn't any dependency among the 15 patches.

Then perhaps you shouldn't send a numbered patch series with different
patches sent to different maintainers, it just causes confusion :)

thanks,

greg k-h
