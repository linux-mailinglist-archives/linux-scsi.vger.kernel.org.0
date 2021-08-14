Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFE3EC12F
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Aug 2021 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhHNHkT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Aug 2021 03:40:19 -0400
Received: from verein.lst.de ([213.95.11.211]:49489 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHkT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 14 Aug 2021 03:40:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9361467373; Sat, 14 Aug 2021 09:39:48 +0200 (CEST)
Date:   Sat, 14 Aug 2021 09:39:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.garry@huawei.com>, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de, hch@lst.de
Subject: Re: [PATCH 2/3] scsi: fnic: Stop setting scsi_cmnd.tag
Message-ID: <20210814073948.GA21536@lst.de>
References: <1628862553-179450-1-git-send-email-john.garry@huawei.com> <1628862553-179450-3-git-send-email-john.garry@huawei.com> <3e5d1bd4-cee9-7fd0-93a4-58d808e198f6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5d1bd4-cee9-7fd0-93a4-58d808e198f6@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Aug 13, 2021 at 08:17:45PM -0700, Bart Van Assche wrote:
> On 8/13/21 6:49 AM, John Garry wrote:
> > It is never read. Setting it and the request tag seems dodgy
> > anyway.
> 
> This is done because there is code in the SCSI error handler that may
> allocate a SCSI command without allocating a tag. See also
> scsi_ioctl_reset().

Yes.  Hannes had a great series to stop passing the pointless scsi_cmnd
to the reset methods.  Hannes, any chance you coul look into
resurrecting that?
