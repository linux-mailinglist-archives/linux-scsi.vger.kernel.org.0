Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375071C1C04
	for <lists+linux-scsi@lfdr.de>; Fri,  1 May 2020 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgEARjt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 May 2020 13:39:49 -0400
Received: from verein.lst.de ([213.95.11.211]:48058 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgEARjt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 May 2020 13:39:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54DF868C65; Fri,  1 May 2020 19:39:46 +0200 (CEST)
Date:   Fri, 1 May 2020 19:39:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC v3 02/41] scsi: add scsi_{get,put}_reserved_cmd()
Message-ID: <20200501173946.GA23795@lst.de>
References: <20200430131904.5847-1-hare@suse.de> <20200430131904.5847-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430131904.5847-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 30, 2020 at 03:18:25PM +0200, Hannes Reinecke wrote:
> Add helper functions to retrieve SCSI commands from the reserved
> tag pool.

I'm still quite worried about the fact that we have a pretty much
half-initialized command that now goes down the whole stack.
