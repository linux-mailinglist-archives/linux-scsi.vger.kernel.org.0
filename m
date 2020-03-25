Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0C192E36
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2020 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCYQ2p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Mar 2020 12:28:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbgCYQ2o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 25 Mar 2020 12:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E56D2ADB5;
        Wed, 25 Mar 2020 16:28:42 +0000 (UTC)
Message-ID: <dfbd88461ef4b5f56a83db7095c6e3f36b5a485e.camel@suse.com>
Subject: Re: [PATCH v2 1/3] scsi: qla2xxx: avoid sending mailbox commands if
 firmware is stopped
From:   Martin Wilck <mwilck@suse.com>
To:     Arun Easi <aeasi@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Date:   Wed, 25 Mar 2020 17:28:45 +0100
In-Reply-To: <alpine.LRH.2.21.9999.2003241648560.12727@irv1user01.caveonetworks.com>
References: <20200205214422.3657-1-mwilck@suse.com>
         <20200205214422.3657-2-mwilck@suse.com>
         <alpine.LRH.2.21.9999.2003241648560.12727@irv1user01.caveonetworks.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2020-03-24 at 16:51 -0700, Arun Easi wrote:
> On Wed, 5 Feb 2020, 1:44pm, mwilck@suse.com wrote:
> 
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > Since commit 45235022da99 ("scsi: qla2xxx: Fix driver unload by
> > shutting down chip"),
> > it is possible that FC commands are scheduled after the adapter
> > firmware
> > has been shut down. IO sent to the firmware in this situation hangs
> > indefinitely. Avoid this for the LOGO code path that is typically
> > taken
> > when adapters are shut down.
> > 
> > Fixes: 45235022da99 ("scsi: qla2xxx: Fix driver unload by shutting
> > down chip")
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  drivers/scsi/qla2xxx/qla_mbx.c | 3 +++
> >  drivers/scsi/qla2xxx/qla_os.c  | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > 
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -4878,6 +4878,9 @@ qla2x00_post_work(struct scsi_qla_host *vha,
> > struct qla_work_evt *e)
> >  	unsigned long flags;
> >  	bool q = false;
> >  
> > +	if (!vha->hw->flags.fw_started)
> > +		return QLA_FUNCTION_FAILED;
> > +
> 
> I'd probably not do it here; rather in qla2x00_get_sp() 
> /qla2x00_start_sp()/ qla2xxx_get_qpair_sp() time. Not all works are
> for 
> posting to firmware (QLA_EVT_IDC_ACK, QLA_EVT_UNMAP etc.).

qla81xx_idc_ack() calls qla2x00_mailbox_command(), which should be
avoided IMO. But I'll review the various cases and re-post the patch.

Thanks,
Martin



> 
> Regards,
> -Arun
> 
> >  	spin_lock_irqsave(&vha->work_lock, flags);
> >  	list_add_tail(&e->list, &vha->work_list);
> >  
> > 


