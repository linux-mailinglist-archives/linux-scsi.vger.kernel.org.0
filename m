Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3322F19A840
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2020 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgDAJGW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Apr 2020 05:06:22 -0400
Received: from verein.lst.de ([213.95.11.211]:42765 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbgDAJGW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 Apr 2020 05:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABACC68BFE; Wed,  1 Apr 2020 11:06:19 +0200 (CEST)
Date:   Wed, 1 Apr 2020 11:06:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikhil Kshirsagar <nkshirsa@redhat.com>
Cc:     martin.petersen@oracle.com, Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] scsi: core: Add DID_ALLOC_FAILURE and DID_MEDIUM_ERROR
 to hostbyte_table
Message-ID: <20200401090618.GC31980@lst.de>
References: <CAMNNMLFtQOHsjWUMs+q_+z9XqQYZmR34ewoB-5LrCpzGp1Ppkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMNNMLFtQOHsjWUMs+q_+z9XqQYZmR34ewoB-5LrCpzGp1Ppkw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Apr 01, 2020 at 09:25:00AM +0530, Nikhil Kshirsagar wrote:
> Since DID_ALLOC_FAILURE and DID_MEDIUM_ERROR are missing from the
> hostbyte_table, scsi debug logging prints their numeric values only.
> Adding them to the hostbyte_table to allow the scsi debug log to print
> those as strings.
> 
> Signed-off-by: Nikhil Kshirsagar <nkshirsa@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
