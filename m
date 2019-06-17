Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B775F48C3C
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFQSkU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 14:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfFQSkT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 14:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8DE300CAC2;
        Mon, 17 Jun 2019 18:40:19 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC2A10027B9;
        Mon, 17 Jun 2019 18:40:18 +0000 (UTC)
Message-ID: <e5ce0d42396d5b445be111873bc5a7bf53e253ab.camel@redhat.com>
Subject: Re: [PATCH 2/3] qla2xxx: on session delete return nvme cmd
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Mon, 17 Jun 2019 14:40:18 -0400
In-Reply-To: <20190614221020.19173-3-hmadhani@marvell.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
         <20190614221020.19173-3-hmadhani@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 18:40:19 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2019-06-14 at 15:10 -0700, Himanshu Madhani wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> - on session delete or chip reset, reject all NVME commands.
> - on NVME command submission error, free srb resource.
> 
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_nvme.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index 99220a3cf734..ead10e1a81fc 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -253,6 +253,10 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
>  
>  	vha = fcport->vha;
>  	ha = vha->hw;
> +
> +	if (!ha->flags.fw_started || (fcport && fcport->deleted))
> +		return rval;
> +
>  	/* Alloc SRB structure */
>  	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
>  	if (!sp)
> @@ -284,6 +288,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
>  		    "qla2x00_start_sp failed = %d\n", rval);
>  		atomic_dec(&sp->ref_count);
>  		wake_up(&sp->nvme_ls_waitq);
> +		sp->free(sp);
>  		return rval;
>  	}
>  
> @@ -500,7 +505,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
>  
>  	vha = fcport->vha;
>  
> -	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags))
> +	if ((qpair && !qpair->fw_started) || (fcport && fcport->deleted))
>  		return rval;
>  
>  	/*
> @@ -535,6 +540,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
>  		    "qla2x00_start_nvme_mq failed = %d\n", rval);
>  		atomic_dec(&sp->ref_count);
>  		wake_up(&sp->nvme_ls_waitq);
> +		sp->free(sp);
>  	}
>  
>  	return rval;
> @@ -561,14 +567,13 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
>  
>  	complete(&fcport->nvme_del_done);
>  
> -	if (!test_bit(UNLOADING, &fcport->vha->dpc_flags)) {
> -		INIT_WORK(&fcport->free_work, qlt_free_session_done);
> -		schedule_work(&fcport->free_work);
> -	}
> +	INIT_WORK(&fcport->free_work, qlt_free_session_done);
> +	schedule_work(&fcport->free_work);
>  
>  	fcport->nvme_flag &= ~NVME_FLAG_DELETING;
>  	ql_log(ql_log_info, fcport->vha, 0x2110,
> -	    "remoteport_delete of %p completed.\n", fcport);
> +	    "remoteport_delete of %p %8phN completed.\n",
> +	    fcport, fcport->port_name);
>  }
>  
>  static struct nvme_fc_port_template qla_nvme_fc_transport = {
> @@ -603,7 +608,8 @@ static void qla_nvme_unregister_remote_port(struct work_struct *work)
>  		return;
>  
>  	ql_log(ql_log_warn, NULL, 0x2112,
> -	    "%s: unregister remoteport on %p\n",__func__, fcport);
> +	    "%s: unregister remoteport on %p %8phN\n",
> +	    __func__, fcport, fcport->port_name);
>  
>  	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
>  	init_completion(&fcport->nvme_del_done);

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

