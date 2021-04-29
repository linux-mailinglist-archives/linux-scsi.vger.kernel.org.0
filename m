Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1290236E50F
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Apr 2021 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhD2Gt0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Apr 2021 02:49:26 -0400
Received: from verein.lst.de ([213.95.11.211]:51942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhD2GtZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 29 Apr 2021 02:49:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6510167357; Thu, 29 Apr 2021 08:48:37 +0200 (CEST)
Date:   Thu, 29 Apr 2021 08:48:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 40/40] scsi: drop obsolete linux-specific SCSI status
 codes
Message-ID: <20210429064837.GA2882@lst.de>
References: <20210427083046.31620-1-hare@suse.de> <20210427083046.31620-41-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427083046.31620-41-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 27, 2021 at 10:30:46AM +0200, Hannes Reinecke wrote:
> +/*
> + *  Original linux SCSI Status codes. They are shifted 1 bit right
> + *  from those found in the SCSI standards.
> + */
> +
> +#define GOOD                 0x00
> +#define CHECK_CONDITION      0x01
> +#define CONDITION_GOOD       0x02
> +#define BUSY                 0x04
> +#define INTERMEDIATE_GOOD    0x08
> +#define INTERMEDIATE_C_GOOD  0x0a
> +#define RESERVATION_CONFLICT 0x0c
> +#define COMMAND_TERMINATED   0x11
> +#define QUEUE_FULL           0x14
> +#define ACA_ACTIVE           0x18
> +#define TASK_ABORTED         0x20

I don't think there is any need to keep defining them, is there?
