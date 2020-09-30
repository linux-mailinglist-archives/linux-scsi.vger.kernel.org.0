Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6227E2C7
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgI3Hku (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Sep 2020 03:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3Hku (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 30 Sep 2020 03:40:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A336A2071E;
        Wed, 30 Sep 2020 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601451648;
        bh=iGXhhCfdebOj/hOUooVJdIw0eCNJ5hR+6KCQ1L6QQTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2Af8jF76Repz5+1dubP6/ICd4BnfIXwtVj0wlSXDA6aOz8aQ1kVQo+QMsZMH6ipB
         zxK5A3d3DeL52Ms38l9/QwawYoxoq5Z2KIPYMVL+IbIKLlvfjgyEzBESVpYcHnSXJd
         25+hQjT8JujEKZvdzi3t85/AWBEHTWBfULHQbD4o=
Date:   Wed, 30 Sep 2020 09:40:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [v5 01/12] struct device: Add function callback durable_name
Message-ID: <20200930074051.GB1509708@kroah.com>
References: <20200925161929.1136806-1-tasleson@redhat.com>
 <20200925161929.1136806-2-tasleson@redhat.com>
 <20200929175102.GA1613@infradead.org>
 <20200929180415.GA1400445@kroah.com>
 <20e220a6-4bde-2331-6e5e-24de39f9aa3b@redhat.com>
 <20200930073859.GA1509708@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930073859.GA1509708@kroah.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 30, 2020 at 09:38:59AM +0200, Greg Kroah-Hartman wrote:
> > > {sigh}
> > > 
> > > And for log messages, what about the dynamic debug developers, why not
> > > include them as well?  Since when is this a storage-only thing?
> > 
> > Hannes Reinecke has been involved in the discussion some and he's
> > involved in dynamic debug AFAIK.
> 
> From the maintainers file:
> 	DYNAMIC DEBUG
> 	M:      Jason Baron <jbaron@akamai.com>
> 	S:      Maintained
> 	F:      include/linux/dynamic_debug.h
> 	F:      lib/dynamic_debug.c
> 
> Come on, you know this, don't try to avoid the people who have to
> maintain the code you are wanting to change, that's not ok.

Also, why are you not using scripts/get_maintainer.pl on your patches?
It would have told you about this...

greg k-h
