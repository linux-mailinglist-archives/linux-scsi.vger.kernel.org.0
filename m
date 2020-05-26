Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3111B19F0B8
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2020 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDFHZr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Apr 2020 03:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFHZr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Apr 2020 03:25:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B1E83ACBA;
        Mon,  6 Apr 2020 07:25:45 +0000 (UTC)
Date:   Mon, 6 Apr 2020 09:25:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH] qla2xxx: Split qla2x00_configure_local_loop()
Message-ID: <20200406072545.hdumz25n2c4gaaid@beryllium.lan>
References: <20200405225905.17171-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405225905.17171-1-bvanassche@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On Sun, Apr 05, 2020 at 03:59:05PM -0700, Bart Van Assche wrote:
> The size of the function qla2x00_configure_local_loop() hurts its
> readability. Hence split that function. This patch does not change
> any functionality.
> 
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Himanshu Madhani <hmadhani@marvell.com>
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks,
Daniel
