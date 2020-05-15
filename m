Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1C1D4810
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2020 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEOIZ5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 May 2020 04:25:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgEOIZ5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 May 2020 04:25:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6447EAB5C;
        Fri, 15 May 2020 08:25:58 +0000 (UTC)
Date:   Fri, 15 May 2020 10:25:55 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Arun Easi <aeasi@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v6 09/15] qla2xxx: Use register names instead of register
 offsets
Message-ID: <20200515082555.shq2z4b4wxn2wfbz@beryllium.lan>
References: <20200514213516.25461-1-bvanassche@acm.org>
 <20200514213516.25461-10-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514213516.25461-10-bvanassche@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On Thu, May 14, 2020 at 02:35:10PM -0700, Bart Van Assche wrote:
> Make qla27xx_write_remote_reg() easier to read by using register names
> instead of register offsets. The 'pahole' tool has been used to convert
> register offsets into register names. See also commit cbb01c2f2f63
> ("scsi: qla2xxx: Fix MPI failure AEN (8200) handling").
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Arun Easi <aeasi@marvell.com>
> Cc: Nilesh Javali <njavali@marvell.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

This looks like a reasonable cleanup. I looked through the rest of the file
and the code is consistently using the same code pattern. It would be good
to keep it consistent. I am not against this change, I am just thinking
it would be good to fixup the complete file.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks,
Daniel
