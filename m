Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAE18683A
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgCPJwt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 05:52:49 -0400
Received: from verein.lst.de ([213.95.11.211]:53434 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbgCPJwt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Mar 2020 05:52:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 37BE368CEC; Mon, 16 Mar 2020 10:52:46 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:52:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Subject: Re: [PATCH v3 2/5] c6x: Include <linux/unaligned/generic.h>
 instead of duplicating it
Message-ID: <20200316095246.GA13730@lst.de>
References: <20200313203102.16613-1-bvanassche@acm.org> <20200313203102.16613-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313203102.16613-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Mar 13, 2020 at 01:30:59PM -0700, Bart Van Assche wrote:
> Use the generic __{get,put}_unaligned_[bl]e() definitions instead of
> duplicating these. Since a later patch will add more definitions into
> <linux/unaligned/generic.h>, this patch ensures that these definitions
> have to be added only once. See also commit a7f626c1948a ("C6X: headers").
> See also commit 6510d41954dc ("kernel: Move arches to use common unaligned
> access").

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
