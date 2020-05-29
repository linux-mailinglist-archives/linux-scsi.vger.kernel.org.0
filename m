Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498951E764E
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2020 09:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2HCt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 May 2020 03:02:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgE2HCt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 29 May 2020 03:02:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF3FAABF4;
        Fri, 29 May 2020 07:02:47 +0000 (UTC)
Date:   Fri, 29 May 2020 09:02:46 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/4] target_core_pscsi: use __scsi_device_lookup()
Message-ID: <20200529070246.ywgycwiqadcvhib4@beryllium.lan>
References: <20200528163625.110184-1-hare@suse.de>
 <20200528163625.110184-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528163625.110184-3-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 28, 2020 at 06:36:23PM +0200, Hannes Reinecke wrote:
> Instead of walking the list of devices manually use the helper
> function to return the device directly.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
