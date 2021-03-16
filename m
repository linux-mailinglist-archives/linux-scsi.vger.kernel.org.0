Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68ED33CFCD
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Mar 2021 09:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhCPIZx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Mar 2021 04:25:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhCPIZo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Mar 2021 04:25:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC3D2AEAE;
        Tue, 16 Mar 2021 08:25:43 +0000 (UTC)
Date:   Tue, 16 Mar 2021 09:25:43 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 2/7] qla2xxx: Constify struct qla_tgt_func_tmpl
Message-ID: <20210316082543.bzytipqnohfdgp5l@beryllium.lan>
References: <20210316035655.2835-1-bvanassche@acm.org>
 <20210316035655.2835-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316035655.2835-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 15, 2021 at 08:56:50PM -0700, Bart Van Assche wrote:
> Since the target function pointers are not modified at runtime, declare
> the data structure with the target function pointers const.
> 
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

