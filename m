Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D220318458B
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2020 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCMLFd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Mar 2020 07:05:33 -0400
Received: from verein.lst.de ([213.95.11.211]:41940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgCMLFc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 13 Mar 2020 07:05:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B91068C4E; Fri, 13 Mar 2020 12:05:28 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:05:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harvey Harrison <harvey.harrison@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/5] linux/unaligned/byteshift.h: Remove superfluous
 casts
Message-ID: <20200313110527.GA8132@lst.de>
References: <20200313023718.21830-1-bvanassche@acm.org> <20200313023718.21830-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313023718.21830-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Mar 12, 2020 at 07:37:14PM -0700, Bart Van Assche wrote:
> The C language supports implicitly casting a void pointer into a non-void
> pointer. Remove explicit void pointer to non-void pointer casts because
> these are superfluous.
> 
> Cc: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
