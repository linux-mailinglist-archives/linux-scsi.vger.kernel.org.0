Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D41184591
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2020 12:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMLGQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Mar 2020 07:06:16 -0400
Received: from verein.lst.de ([213.95.11.211]:41953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCMLGP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 13 Mar 2020 07:06:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2AB768C4E; Fri, 13 Mar 2020 12:06:12 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:06:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Felipe Balbi <balbi@kernel.org>,
        Harvey Harrison <harvey.harrison@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/5] treewide: Consolidate
 {get,put}_unaligned_[bl]e24() definitions
Message-ID: <20200313110612.GB8132@lst.de>
References: <20200313023718.21830-1-bvanassche@acm.org> <20200313023718.21830-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313023718.21830-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Mar 12, 2020 at 07:37:16PM -0700, Bart Van Assche wrote:
> Move the get_unaligned_be24(), get_unaligned_le24() and
> put_unaligned_le24() definitions from various drivers into
> include/linux/unaligned/generic.h. Add a put_unaligned_be24()
> implementation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although the added consts suggested by Andy look useful to me)
