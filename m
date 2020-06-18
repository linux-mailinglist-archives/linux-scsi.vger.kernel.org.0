Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3621FED38
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgFRIJW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jun 2020 04:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgFRIHJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jun 2020 04:07:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 113ADAE96;
        Thu, 18 Jun 2020 08:07:07 +0000 (UTC)
Date:   Thu, 18 Jun 2020 10:07:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/4] gdth: kill __gdth_execute()
Message-ID: <20200618080707.j6batqqy7gdlwqtn@beryllium.lan>
References: <20200616121821.99113-1-hare@suse.de>
 <20200616121821.99113-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121821.99113-4-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 16, 2020 at 02:18:20PM +0200, Hannes Reinecke wrote:
> gdth_execute() is just a wrapper around __gdth_execute(), which
> tries to allocate the host device, too.
> But the host device is required for other code paths, too, so
> we should allocate it during pci init, kill the original
> gdth_execute() and rename __gdth_execute() to gdth_execute().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
