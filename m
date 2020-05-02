Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F981C242E
	for <lists+linux-scsi@lfdr.de>; Sat,  2 May 2020 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEBIsl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 May 2020 04:48:41 -0400
Received: from verein.lst.de ([213.95.11.211]:50456 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgEBIsk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 2 May 2020 04:48:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C090E68C65; Sat,  2 May 2020 10:48:36 +0200 (CEST)
Date:   Sat, 2 May 2020 10:48:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC v3 02/41] scsi: add scsi_{get,put}_reserved_cmd()
Message-ID: <20200502084836.GA3862@lst.de>
References: <20200430131904.5847-1-hare@suse.de> <20200430131904.5847-3-hare@suse.de> <20200501173946.GA23795@lst.de> <d85e8384-639f-fa89-8c52-367bdb46cc8a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85e8384-639f-fa89-8c52-367bdb46cc8a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, May 02, 2020 at 10:45:24AM +0200, Hannes Reinecke wrote:
> Reserved commands just serve as a placeholder to get a valid tag from the 
> block layer; the SCSI commands themselves are never ever passed through the 
> whole stack, but rather allocated internally within the driver, and passed 
> to the hardware by driver-specific means.
> So really the SCSI specific parts of the commands are never used.
> We can add a check in queuecommand to abort reserved commands if that's 
> what you worried about, though.

How about an interface that just returns a tag then, so that it can't
be misused?
