Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF683341CC
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfFDI24 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:28:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34275 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfFDI24 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:28:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1C6C768B02; Tue,  4 Jun 2019 10:28:30 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:28:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] scsi: esp: make it working on SG_CHAIN
Message-ID: <20190604082829.GB17205@lst.de>
References: <20190604082308.5575-1-ming.lei@redhat.com> <20190604082308.5575-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604082308.5575-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 04, 2019 at 04:23:08PM +0800, Ming Lei wrote:
> The driver supporses that there isn't sg chain, and itereate the

s/supporses/expects/ ?

> +	struct scatterlist *sgt;

Maybe just call this s, which is a common name for scatterlist iterators?
sgt is used for a sg table in many places in scsi.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
