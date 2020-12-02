Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265C02CC26F
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgLBQeM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:34:12 -0500
Received: from verein.lst.de ([213.95.11.211]:54958 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgLBQeM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:34:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B9C6167373; Wed,  2 Dec 2020 17:33:30 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:33:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 20/34] dc395x: drop internal SCSI message definitions
Message-ID: <20201202163330.GO32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-21-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-21-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:35PM +0100, Hannes Reinecke wrote:
> Drop the internel SCSI message definitions and use the functions
> provided by the SPI transport class.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
