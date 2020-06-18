Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784181FED14
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgFRH7l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jun 2020 03:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgFRH7l (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jun 2020 03:59:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B463FAAC3;
        Thu, 18 Jun 2020 07:59:39 +0000 (UTC)
Date:   Thu, 18 Jun 2020 09:59:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/4] gdth: do not use struct scsi_cmnd as argument for
 bus reset
Message-ID: <20200618075939.pth6yo7mlzu5nmsf@beryllium.lan>
References: <20200616121821.99113-1-hare@suse.de>
 <20200616121821.99113-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121821.99113-3-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 16, 2020 at 02:18:19PM +0200, Hannes Reinecke wrote:
> Bus reset just needs the number of the bus to reset as argument,
> so introduce a function gdth_bus_reset() and avoid allocating
> a temporary scsi command when bus reset is triggered via ioctl.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

