Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4F38CF4E
	for <lists+linux-scsi@lfdr.de>; Fri, 21 May 2021 22:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEUUsk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 May 2021 16:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhEUUsk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 May 2021 16:48:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 961A0613DB;
        Fri, 21 May 2021 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621630037;
        bh=SNkCKHBSwxHC/7QeBTxQBdV1STVYJV1pdJgmQu2LL1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADhYGjkCKu3hKsXOc2KzrSQDTy7z16GQc0NX6V4cwsS0EWVmHUhZFuv3TWbT1kZm3
         rRgYsY5K4jY/Z5dpDAm29bTrwuTYaoLP9UAdehkyO8SFnRqnew0RRfb6n4ZMA3w2DQ
         6hDpi+OpJ+LKO1l43aJutvDIdAnPr6d6nE3p735s=
Date:   Fri, 21 May 2021 22:47:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: snic: debugfs: remove local storage of debugfs
 files
Message-ID: <YKgcU4LPY3+y+gSK@kroah.com>
References: <20210518161625.3696996-1-gregkh@linuxfoundation.org>
 <YKPrW1rdDE7GgjOm@kroah.com>
 <yq18s474yia.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq18s474yia.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 21, 2021 at 04:36:19PM -0400, Martin K. Petersen wrote:
> 
> Greg,
> 
> >>  drivers/scsi/snic/snic_debugfs.c | 23 +++++++++--------------
> >>  drivers/scsi/snic/snic_trc.h     |  3 ---
> >>  2 files changed, 9 insertions(+), 17 deletions(-)
> >
> > I can take this through my debugfs tree so I can clean up the
> > debugfs_create_bool() api if no one objects.
> 
> Sure, not a problem.

Thanks!
