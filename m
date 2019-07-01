Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1B11965
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfEBMxc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 08:53:32 -0400
Received: from verein.lst.de ([213.95.11.211]:59099 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBMxc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 May 2019 08:53:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2FAA68AA6; Thu,  2 May 2019 14:53:12 +0200 (CEST)
Date:   Thu, 2 May 2019 14:53:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chriosstoph Hellwig <hch@losst.de>
Subject: Re: [PATCH 24/24] osst: add a SPDX tag to osst.c
Message-ID: <20190502125312.GA2560@lst.de>
References: <20190501161417.32592-1-hch@lst.de> <20190501161417.32592-25-hch@lst.de> <70277444-5b5b-6e3c-5af3-c658a841b144@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70277444-5b5b-6e3c-5af3-c658a841b144@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 02, 2019 at 08:06:38AM +0200, Hannes Reinecke wrote:
> On 5/1/19 6:14 PM, Christoph Hellwig wrote:
>> osst.c is the only osst file missing licensing information.  Add a
>> GPLv2 tag for the default kernel license.
>>
>> Signed-off-by: Chriosstoph Hellwig <hch@losst.de>

FYI, my s/st/osst/ on the commit message message up my signoff, this
should be:

Signed-off-by: Christoph Hellwig <hch@lst.de>
