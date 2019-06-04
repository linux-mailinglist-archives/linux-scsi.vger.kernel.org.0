Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00499341BE
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFDIYP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:24:15 -0400
Received: from verein.lst.de ([213.95.11.211]:34232 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfFDIYO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:24:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A10E768B02; Tue,  4 Jun 2019 10:23:48 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:23:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.com>
Cc:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 10/24] scsi: allocate separate queue for reserved
 commands
Message-ID: <20190604082348.GC16717@lst.de>
References: <20190529132901.27645-1-hare@suse.de> <20190529132901.27645-11-hare@suse.de> <5537cf59-0138-3553-0896-21b1aaf2fe51@huawei.com> <323be693-8280-78ea-8050-8c8d7befdfb9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323be693-8280-78ea-8050-8c8d7befdfb9@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 30, 2019 at 07:14:14PM +0200, Hannes Reinecke wrote:
>> Is this really required? I would think that a non-zero value for 
>> shost->nr_reserved_cmds means the same thing in practice.
>> ;
> My implementation actually allows for per-device reserved tags (eg for 
> virtio). But some drivers require to use internal commands prior to any 
> device setup, so they have to use a separate reserved command queue just to 
> be able to allocate tags.

Why would virtio-scsi need per-device reserved commands?  It currently uses
a global mempool to allocate the reset commands.
