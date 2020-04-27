Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485BA1B9A6A
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgD0Ijn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 04:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgD0Ijn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 27 Apr 2020 04:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7AFAABAD;
        Mon, 27 Apr 2020 08:39:41 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:39:41 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v4 07/11] qla2xxx: Change two hardcoded constants into
 offsetof() / sizeof() expressions
Message-ID: <20200427083941.gkouj7dfolx53jtl@beryllium.lan>
References: <20200427030310.19687-1-bvanassche@acm.org>
 <20200427030310.19687-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427030310.19687-8-bvanassche@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Apr 26, 2020 at 08:03:06PM -0700, Bart Van Assche wrote:
> This patch does not change any functionality.
> 
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Good one, I was confusing FCP_PRIO_CFG_HDR_SIZE with FCP_PRIO_CFG_ENTRY_SIZE
while reviewing :)

Reviewed-by: Daniel Wagner <dwagner@suse.de>
