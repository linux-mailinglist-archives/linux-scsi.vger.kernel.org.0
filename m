Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B41204C03
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2020 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgFWINn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jun 2020 04:13:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgFWINn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 23 Jun 2020 04:13:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D77EAB01C;
        Tue, 23 Jun 2020 08:13:41 +0000 (UTC)
Date:   Tue, 23 Jun 2020 10:13:41 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 2/9] qla2xxx: Remove the __packed annotation from struct
 fcp_hdr and fcp_hdr_le
Message-ID: <20200623081341.7nhy7ym2pepvs66r@beryllium.lan>
References: <20200614223921.5851-1-bvanassche@acm.org>
 <20200614223921.5851-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614223921.5851-3-bvanassche@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jun 14, 2020 at 03:39:14PM -0700, Bart Van Assche wrote:
> Remove the __packed annotation from struct fcp_hdr* because that annotation
> is not necessary for these data structures.
> 
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
