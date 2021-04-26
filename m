Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EB36B541
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZOwV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 10:52:21 -0400
Received: from verein.lst.de ([213.95.11.211]:41616 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOwU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 10:52:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 194AA68C4E; Mon, 26 Apr 2021 16:51:38 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:51:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 01/39] st: return error code in st_scsi_execute()
Message-ID: <20210426145137.GB22120@lst.de>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113944.42672-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Apr 23, 2021 at 01:39:06PM +0200, Hannes Reinecke wrote:
> The callers to st_scsi_execute already check for negative
> return values, so we can drop the use of DRIVER_ERROR and
> return the actual error code.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
