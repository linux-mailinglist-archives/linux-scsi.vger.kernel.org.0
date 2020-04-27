Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE11B9994
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgD0ISJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 04:18:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgD0ISI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 27 Apr 2020 04:18:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD877ABAD;
        Mon, 27 Apr 2020 08:18:06 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:18:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v4 04/11] qla2xxx: Add more BUILD_BUG_ON() statements
Message-ID: <20200427081807.2ppd4edosmauckjo@beryllium.lan>
References: <20200427030310.19687-1-bvanassche@acm.org>
 <20200427030310.19687-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427030310.19687-5-bvanassche@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Apr 26, 2020 at 08:03:03PM -0700, Bart Van Assche wrote:
> Before fixing the endianness annotations in data structures, make the
> compiler verify the size of FC protocol and firmware data structures.
> 
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I don't have a manual to check it but this looks reasonable.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
