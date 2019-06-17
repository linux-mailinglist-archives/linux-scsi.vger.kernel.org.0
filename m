Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1948C26
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfFQSiT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 14:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFQSiQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 14:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E409330265;
        Mon, 17 Jun 2019 18:38:10 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC75669616;
        Mon, 17 Jun 2019 18:38:09 +0000 (UTC)
Message-ID: <8a47bd84daf6154ae4793cb56dfe4b249a2b2c41.camel@redhat.com>
Subject: Re: [PATCH 1/3] qla2xxx: Fix kernel crash after disconnecting NVMe
 devices
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Mon, 17 Jun 2019 14:38:09 -0400
In-Reply-To: <20190614221020.19173-2-hmadhani@marvell.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
         <20190614221020.19173-2-hmadhani@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 17 Jun 2019 18:38:15 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

See below.

On Fri, 2019-06-14 at 15:10 -0700, Himanshu Madhani wrote:
> From: Arun Easi <aeasi@marvell.com>
> 
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> PGD 800000084cf41067 PUD 84d288067 PMD 0
> Oops: 0000 [#1] SMP
> Call Trace:
>  [<ffffffff98abcfdf>] process_one_work+0x17f/0x440
>  [<ffffffff98abdca6>] worker_thread+0x126/0x3c0
>  [<ffffffff98abdb80>] ? manage_workers.isra.26+0x2a0/0x2a0
>  [<ffffffff98ac4f81>] kthread+0xd1/0xe0
>  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
>  [<ffffffff9918ad37>] ret_from_fork_nospec_begin+0x21/0x21
>  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> RIP  [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> 
> The crash is due to a bad entry in the nvme_rport_list. This list is not
> protected, and when a remoteport_delete callback is called, driver
> traverses the list and crashes.
> 
> Actually, the list could be removed and driver could traverse the main
> fcport list instead. Fix does exactly that.
> 
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h  |  1 -
>  drivers/scsi/qla2xxx/qla_nvme.c | 52 ++++++++++++++++++++---------------------
>  drivers/scsi/qla2xxx/qla_nvme.h |  1 -
>  drivers/scsi/qla2xxx/qla_os.c   |  1 -
>  4 files changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> index 1a4095c56eee..602ed24bb806 100644
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
> @@ -4376,7 +4376,6 @@ typedef struct scsi_qla_host {
>  
>  	struct		nvme_fc_local_port *nvme_local_port;
>  	struct completion nvme_del_done;
> -	struct list_head nvme_rport_list;
>  
>  	uint16_t	fcoe_vlan_id;
>  	uint16_t	fcoe_fcf_idx;
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index 22e3fba28e51..99220a3cf734 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -14,6 +14,18 @@ static struct nvme_fc_port_template qla_nvme_fc_transport;
>  
>  static void qla_nvme_unregister_remote_port(struct work_struct *);
>  
> +static inline
> +int qla_is_active_nvme_fcport(struct fc_port *fcport)
> +{
> +	return fcport->nvme_flag & NVME_FLAG_REGISTERED;
> +}
> +

Nitpick:  "qla_is_active_nvme_fcport", the qualifier "active"
does not match any of the flag definitions and this is only
checking the REGISTERED flag.  Maybe "qla_is_registered_nvme_fcport"
instead?  Would help to understand vs. DELETING and RESETTING case.

> +#define qla_list_for_each_nvme_fcport(_fcport, _vha)		\
> +{								\
> +	list_for_each_entry(_fcport, &_vha->vp_fcports, list)	\
> +		if (qla_is_active_nvme_fcport(_fcport))		\
> +}
> +

Like here, "if (qla_is_registered_nvme_fcport(" would be clearer.

>  int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
>  {
>  	struct qla_nvme_rport *rport;
> @@ -74,7 +86,6 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
>  
>  	rport = fcport->nvme_remote_port->private;
>  	rport->fcport = fcport;
> -	list_add_tail(&rport->list, &vha->nvme_rport_list);
>  
>  	fcport->nvme_flag |= NVME_FLAG_REGISTERED;
>  	return 0;
> @@ -542,19 +553,12 @@ static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
>  static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
>  {
>  	fc_port_t *fcport;
> -	struct qla_nvme_rport *qla_rport = rport->private, *trport;
> +	struct qla_nvme_rport *qla_rport = rport->private;
>  
>  	fcport = qla_rport->fcport;
>  	fcport->nvme_remote_port = NULL;
>  	fcport->nvme_flag &= ~NVME_FLAG_REGISTERED;
>  
> -	list_for_each_entry_safe(qla_rport, trport,
> -	    &fcport->vha->nvme_rport_list, list) {
> -		if (qla_rport->fcport == fcport) {
> -			list_del(&qla_rport->list);
> -			break;
> -		}
> -	}
>  	complete(&fcport->nvme_del_done);
>  
>  	if (!test_bit(UNLOADING, &fcport->vha->dpc_flags)) {
> @@ -590,31 +594,25 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
>  {
>  	struct fc_port *fcport = container_of(work, struct fc_port,
>  	    nvme_del_work);
> -	struct qla_nvme_rport *qla_rport, *trport;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_NVME_FC))
>  		return;
>  
> +	if (!qla_is_active_nvme_fcport(fcport))
> +		return;
> +

This looks like it is prone to a race because the REGISTERED flag
is cleared in the callback from the NVMe transport?  The flag was
already checked in qlt_unreg_sess(), then the work item runs here,
then later qla_nvme_remoteport_delete() runs.  What is happening
here that the check is preventing?

-Ewan

>  	ql_log(ql_log_warn, NULL, 0x2112,
>  	    "%s: unregister remoteport on %p\n",__func__, fcport);
>  
> -	list_for_each_entry_safe(qla_rport, trport,
> -	    &fcport->vha->nvme_rport_list, list) {
> -		if (qla_rport->fcport == fcport) {
> -			ql_log(ql_log_info, fcport->vha, 0x2113,
> -			    "%s: fcport=%p\n", __func__, fcport);
> -			nvme_fc_set_remoteport_devloss
> -				(fcport->nvme_remote_port, 0);
> -			init_completion(&fcport->nvme_del_done);
> -			if (nvme_fc_unregister_remoteport
> -			    (fcport->nvme_remote_port))
> -				ql_log(ql_log_info, fcport->vha, 0x2114,
> -				    "%s: Failed to unregister nvme_remote_port\n",
> -				    __func__);
> -			wait_for_completion(&fcport->nvme_del_done);
> -			break;
> -		}
> -	}
> +	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
> +	init_completion(&fcport->nvme_del_done);
> +	ret = nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
> +	if (ret)
> +		ql_log(ql_log_info, fcport->vha, 0x2114,
> +			"%s: Failed to unregister nvme_remote_port (%d)\n",
> +			    __func__, ret);
> +	wait_for_completion(&fcport->nvme_del_done);
>  }
>  
>  void qla_nvme_delete(struct scsi_qla_host *vha)
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
> index d3b8a6440113..2d088add7011 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.h
> +++ b/drivers/scsi/qla2xxx/qla_nvme.h
> @@ -37,7 +37,6 @@ struct nvme_private {
>  };
>  
>  struct qla_nvme_rport {
> -	struct list_head list;
>  	struct fc_port *fcport;
>  };
>  
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 00fee5bf4de1..ae93ae2b6090 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -4789,7 +4789,6 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
>  	INIT_LIST_HEAD(&vha->plogi_ack_list);
>  	INIT_LIST_HEAD(&vha->qp_list);
>  	INIT_LIST_HEAD(&vha->gnl.fcports);
> -	INIT_LIST_HEAD(&vha->nvme_rport_list);
>  	INIT_LIST_HEAD(&vha->gpnid_list);
>  	INIT_WORK(&vha->iocb_work, qla2x00_iocb_work_fn);
>  
