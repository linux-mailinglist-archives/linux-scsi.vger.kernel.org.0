Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E43F265A
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Aug 2021 07:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhHTFNn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Aug 2021 01:13:43 -0400
Received: from verein.lst.de ([213.95.11.211]:39747 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhHTFNn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Aug 2021 01:13:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92A9C6736F; Fri, 20 Aug 2021 07:13:03 +0200 (CEST)
Date:   Fri, 20 Aug 2021 07:13:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] sym53c8xx_2: move PCI EEH handling to host reset
Message-ID: <20210820051303.GA27915@lst.de>
References: <20210819090716.94049-1-hare@suse.de> <20210819090716.94049-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819090716.94049-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:07:13AM +0200, Hannes Reinecke wrote:
> When PCI EEH is active the entire card will be reset; which means
> that we _have_ to do the equivalent of a eh_host_reset().
> So trying to do it from other EH callbacks is pointless, and we
> should delegate it to eh_host_reset().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
