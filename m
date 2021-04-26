Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9D36B544
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhDZOyt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 10:54:49 -0400
Received: from verein.lst.de ([213.95.11.211]:41631 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZOys (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 10:54:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B73C68C4E; Mon, 26 Apr 2021 16:54:02 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:54:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 03/39] scsi_dh_alua: do not interpret DRIVER_ERROR
Message-ID: <20210426145401.GD22120@lst.de>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113944.42672-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Apr 23, 2021 at 01:39:08PM +0200, Hannes Reinecke wrote:
> Remove the special handling for DRIVER_ERROR; if there is an error
> we should just fail the command and don't try anything clever.

So this code comes from your commit 40bb61a77347
"scsi_dh_alua: switch to scsi_execute_req_flags()"

but that only switches from DRIVER_BUSY to DRIVER_ERROR, which in
retrospective looks rather fishy.  Some kind of is busy handling here
actually does make sense to me, so maybe we should check for that
more sensibly?
