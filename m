Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32B48D63
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFQTDy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 15:03:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29316 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbfFQTDy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 15:03:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HJ00Pb025687;
        Mon, 17 Jun 2019 12:03:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0818; bh=C9sbbByDjjJE1TAgQ+OG8Gx6tADB7ZacnCgx8aAQ1dM=;
 b=nXsdHJ1kOhHB7G2WFxYFU9tp7z+hEDwYuDioLt8yuXdfLBKqSCX0sYmXUdazlObJBskg
 7d3e7kAUJH4ZIyqESj3pk7Opqrd8JElIblqzw8JQ+yKgxmsn4W6Y6oHBzdwxnFtBFi39
 35afiLyg/CIHHIzqRZKOZSWZxe2hmVQhyYiBXzciGIlc24pS4XRuzb5vH6S6w5+j603P
 Q1yity8tPxitTYkQVbE74TfR0jF+pggwKU3eFCUYaKRjN+1Y0790sn7HunYJTh6KTaHE
 koo5sfuTb6H8NhXEBG+ISq1ZQ6A4b3edKymIFIUikISG7mSDFwpySlmHKfmIqWyF3HXn qg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t68rpa3ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jun 2019 12:03:29 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 17 Jun
 2019 12:03:29 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 17 Jun 2019 12:03:29 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id CC7973F703F;
        Mon, 17 Jun 2019 12:03:28 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id x5HJ3OuX024359;
        Mon, 17 Jun 2019 12:03:25 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Mon, 17 Jun 2019 12:03:24 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     "Ewan D. Milne" <emilne@redhat.com>
CC:     Himanshu Madhani <hmadhani@marvell.com>,
        <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/3] qla2xxx: Fix kernel crash after disconnecting NVMe
 devices
In-Reply-To: <8a47bd84daf6154ae4793cb56dfe4b249a2b2c41.camel@redhat.com>
Message-ID: <alpine.LRH.2.21.9999.1906171147570.18638@mvluser05.qlc.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
         <20190614221020.19173-2-hmadhani@marvell.com>
 <8a47bd84daf6154ae4793cb56dfe4b249a2b2c41.camel@redhat.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_07:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Thanks for the review, Ewan. My response inline..

On Mon, 17 Jun 2019, 11:38am, Ewan D. Milne wrote:

> See below.
> 
> On Fri, 2019-06-14 at 15:10 -0700, Himanshu Madhani wrote:
> > From: Arun Easi <aeasi@marvell.com>
> > 
> > BUG: unable to handle kernel NULL pointer dereference at           (null)
> > IP: [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > PGD 800000084cf41067 PUD 84d288067 PMD 0
> > Oops: 0000 [#1] SMP
> > Call Trace:
> >  [<ffffffff98abcfdf>] process_one_work+0x17f/0x440
> >  [<ffffffff98abdca6>] worker_thread+0x126/0x3c0
> >  [<ffffffff98abdb80>] ? manage_workers.isra.26+0x2a0/0x2a0
> >  [<ffffffff98ac4f81>] kthread+0xd1/0xe0
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> >  [<ffffffff9918ad37>] ret_from_fork_nospec_begin+0x21/0x21
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> > RIP  [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > 
> > The crash is due to a bad entry in the nvme_rport_list. This list is not
> > protected, and when a remoteport_delete callback is called, driver
> > traverses the list and crashes.
> > 
> > Actually, the list could be removed and driver could traverse the main
> > fcport list instead. Fix does exactly that.
> > 
> > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> > ---
> >  drivers/scsi/qla2xxx/qla_def.h  |  1 -
> >  drivers/scsi/qla2xxx/qla_nvme.c | 52 ++++++++++++++++++++---------------------
> >  drivers/scsi/qla2xxx/qla_nvme.h |  1 -
> >  drivers/scsi/qla2xxx/qla_os.c   |  1 -
> >  4 files changed, 25 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> > index 1a4095c56eee..602ed24bb806 100644
> > --- a/drivers/scsi/qla2xxx/qla_def.h
> > +++ b/drivers/scsi/qla2xxx/qla_def.h
> > @@ -4376,7 +4376,6 @@ typedef struct scsi_qla_host {
> >  
> >  	struct		nvme_fc_local_port *nvme_local_port;
> >  	struct completion nvme_del_done;
> > -	struct list_head nvme_rport_list;
> >  
> >  	uint16_t	fcoe_vlan_id;
> >  	uint16_t	fcoe_fcf_idx;
> > diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> > index 22e3fba28e51..99220a3cf734 100644
> > --- a/drivers/scsi/qla2xxx/qla_nvme.c
> > +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> > @@ -14,6 +14,18 @@ static struct nvme_fc_port_template qla_nvme_fc_transport;
> >  
> >  static void qla_nvme_unregister_remote_port(struct work_struct *);
> >  
> > +static inline
> > +int qla_is_active_nvme_fcport(struct fc_port *fcport)
> > +{
> > +	return fcport->nvme_flag & NVME_FLAG_REGISTERED;
> > +}
> > +
> 
> Nitpick:  "qla_is_active_nvme_fcport", the qualifier "active"
> does not match any of the flag definitions and this is only
> checking the REGISTERED flag.  Maybe "qla_is_registered_nvme_fcport"
> instead?  Would help to understand vs. DELETING and RESETTING case.

Sure, this sounds better, will do in v2.

> 
> > +#define qla_list_for_each_nvme_fcport(_fcport, _vha)		\
> > +{								\
> > +	list_for_each_entry(_fcport, &_vha->vp_fcports, list)	\
> > +		if (qla_is_active_nvme_fcport(_fcport))		\
> > +}
> > +
> 
> Like here, "if (qla_is_registered_nvme_fcport(" would be clearer.
> 
> >  int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
> >  {
> >  	struct qla_nvme_rport *rport;
> > @@ -74,7 +86,6 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
> >  
> >  	rport = fcport->nvme_remote_port->private;
> >  	rport->fcport = fcport;
> > -	list_add_tail(&rport->list, &vha->nvme_rport_list);
> >  
> >  	fcport->nvme_flag |= NVME_FLAG_REGISTERED;
> >  	return 0;
> > @@ -542,19 +553,12 @@ static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
> >  static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
> >  {
> >  	fc_port_t *fcport;
> > -	struct qla_nvme_rport *qla_rport = rport->private, *trport;
> > +	struct qla_nvme_rport *qla_rport = rport->private;
> >  
> >  	fcport = qla_rport->fcport;
> >  	fcport->nvme_remote_port = NULL;
> >  	fcport->nvme_flag &= ~NVME_FLAG_REGISTERED;
> >  
> > -	list_for_each_entry_safe(qla_rport, trport,
> > -	    &fcport->vha->nvme_rport_list, list) {
> > -		if (qla_rport->fcport == fcport) {
> > -			list_del(&qla_rport->list);
> > -			break;
> > -		}
> > -	}
> >  	complete(&fcport->nvme_del_done);
> >  
> >  	if (!test_bit(UNLOADING, &fcport->vha->dpc_flags)) {
> > @@ -590,31 +594,25 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
> >  {
> >  	struct fc_port *fcport = container_of(work, struct fc_port,
> >  	    nvme_del_work);
> > -	struct qla_nvme_rport *qla_rport, *trport;
> > +	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_NVME_FC))
> >  		return;
> >  
> > +	if (!qla_is_active_nvme_fcport(fcport))
> > +		return;
> > +
> 
> This looks like it is prone to a race because the REGISTERED flag
> is cleared in the callback from the NVMe transport?

The remoteport_delete callback gets invoked only after a 
nvme_fc_unregister_remoteport() which has not yet happened, so I am
not sure where the race is.

> The flag was already checked in qlt_unreg_sess(), then the work item 
> runs here, then later qla_nvme_remoteport_delete() runs.  What is 
> happening here that the check is preventing?

This was merely a defensive check added, that I guess got stuck in mind 
somehow. Anycase, you are right, that is not needed and can be removed.

-- arun

> 
> -Ewan
> 
> >  	ql_log(ql_log_warn, NULL, 0x2112,
> >  	    "%s: unregister remoteport on %p\n",__func__, fcport);
> >  
> > -	list_for_each_entry_safe(qla_rport, trport,
> > -	    &fcport->vha->nvme_rport_list, list) {
> > -		if (qla_rport->fcport == fcport) {
> > -			ql_log(ql_log_info, fcport->vha, 0x2113,
> > -			    "%s: fcport=%p\n", __func__, fcport);
> > -			nvme_fc_set_remoteport_devloss
> > -				(fcport->nvme_remote_port, 0);
> > -			init_completion(&fcport->nvme_del_done);
> > -			if (nvme_fc_unregister_remoteport
> > -			    (fcport->nvme_remote_port))
> > -				ql_log(ql_log_info, fcport->vha, 0x2114,
> > -				    "%s: Failed to unregister nvme_remote_port\n",
> > -				    __func__);
> > -			wait_for_completion(&fcport->nvme_del_done);
> > -			break;
> > -		}
> > -	}
> > +	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
> > +	init_completion(&fcport->nvme_del_done);
> > +	ret = nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
> > +	if (ret)
> > +		ql_log(ql_log_info, fcport->vha, 0x2114,
> > +			"%s: Failed to unregister nvme_remote_port (%d)\n",
> > +			    __func__, ret);
> > +	wait_for_completion(&fcport->nvme_del_done);
> >  }
> >  
> >  void qla_nvme_delete(struct scsi_qla_host *vha)
> > diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
> > index d3b8a6440113..2d088add7011 100644
> > --- a/drivers/scsi/qla2xxx/qla_nvme.h
> > +++ b/drivers/scsi/qla2xxx/qla_nvme.h
> > @@ -37,7 +37,6 @@ struct nvme_private {
> >  };
> >  
> >  struct qla_nvme_rport {
> > -	struct list_head list;
> >  	struct fc_port *fcport;
> >  };
> >  
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> > index 00fee5bf4de1..ae93ae2b6090 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -4789,7 +4789,6 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
> >  	INIT_LIST_HEAD(&vha->plogi_ack_list);
> >  	INIT_LIST_HEAD(&vha->qp_list);
> >  	INIT_LIST_HEAD(&vha->gnl.fcports);
> > -	INIT_LIST_HEAD(&vha->nvme_rport_list);
> >  	INIT_LIST_HEAD(&vha->gpnid_list);
> >  	INIT_WORK(&vha->iocb_work, qla2x00_iocb_work_fn);
> >  
> 
