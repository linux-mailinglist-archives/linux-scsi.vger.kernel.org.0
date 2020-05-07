Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E21C8284
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 08:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGG2C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 02:28:02 -0400
Received: from verein.lst.de ([213.95.11.211]:44828 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEGG2C (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 02:28:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C129268AFE; Thu,  7 May 2020 08:28:00 +0200 (CEST)
Date:   Thu, 7 May 2020 08:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: remove 'list' entry from struct scsi_cmnd
Message-ID: <20200507062800.GB5814@lst.de>
References: <20200507062642.100612-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507062642.100612-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 07, 2020 at 08:26:42AM +0200, Hannes Reinecke wrote:
> Leftover from commandlist removal.
> 
> Fixes: c5a9707672fe ("scsi: core: Remove cmd_list functionality")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
