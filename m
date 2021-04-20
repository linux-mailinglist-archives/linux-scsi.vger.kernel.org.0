Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DF6365909
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 14:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDTMh5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Apr 2021 08:37:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhDTMh4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Apr 2021 08:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DE02B229;
        Tue, 20 Apr 2021 12:37:24 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:37:23 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Subject: Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210420123723.bregf4debvyincpo@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb00b188-31bf-d943-8f82-31c8c966c728@infradead.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Randy,

On Mon, Apr 19, 2021 at 09:19:13AM -0700, Randy Dunlap wrote:
> > +int ql2xdev_loss_tmo = 60;
> > +module_param(ql2xdev_loss_tmo, int, 0444);
> > +MODULE_PARM_DESC(ql2xdev_loss_tmo,
> > +		"Time to wait for device to recover before reporting\n"
> > +		"an error. Default is 60 seconds\n");
> 
> No need for the \n in the quoted string. Just change it to a space.

I just followed the current style in this file. I guess this style
question is up to the maintainers to decide what they want.

Thanks,
Daniel

