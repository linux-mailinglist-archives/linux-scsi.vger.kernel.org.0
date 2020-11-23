Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4E2C14B1
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Nov 2020 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgKWTrU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729937AbgKWTrU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 23 Nov 2020 14:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606160838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5uzYCjplKD+DxD+G0R7UJqygYhBOrFivkxReOyiVA0=;
        b=MGDw7QSzihj8Q6UqjGyDKoVRNvIRiCkmr12Zjn8l1/+2RGhSWXzgu2PHxDaYj7KwieR76b
        Foe053Ahc3nNKfUv+H+lCJcqlYrJ4ZtR2I/TdkoCb9bwJUCiEzlVhtJx1+pdEuFTmYRIQ3
        jZHyXtCH0RbEXCOaV2BvGaj+lgbVoIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-t5lweaIUP4iqmBwfbZvzQw-1; Mon, 23 Nov 2020 14:47:14 -0500
X-MC-Unique: t5lweaIUP4iqmBwfbZvzQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6742D1005E54;
        Mon, 23 Nov 2020 19:47:13 +0000 (UTC)
Received: from ovpn-112-111.phx2.redhat.com (ovpn-112-111.phx2.redhat.com [10.3.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E220060C13;
        Mon, 23 Nov 2020 19:47:12 +0000 (UTC)
Message-ID: <11ca876b0520724f84dc762b15e999421b694cf0.camel@redhat.com>
Subject: Re: [PATCH v7 3/5] scsi_transport_fc: Added a new rport state
 FC_PORTSTATE_MARGINAL
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jsmart2021@gmail.com, mkumar@redhat.com
Date:   Mon, 23 Nov 2020 14:47:12 -0500
In-Reply-To: <1605070685-20945-4-git-send-email-muneendra.kumar@broadcom.com>
References: <1605070685-20945-1-git-send-email-muneendra.kumar@broadcom.com>
         <1605070685-20945-4-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2020-11-11 at 10:28 +0530, Muneendra wrote:
> Added a new rport state FC_PORTSTATE_MARGINAL.
> 
> Added a new interface fc_eh_should_retry_cmd which Checks if the cmd
> should be retried or not by checking the rport state.
> If the rport state is marginal it returns
> false to make sure there won't be any retries on the cmd.
> 
> Also made changes in fc_remote_port_delete,fc_user_scan_tgt,
> fc_timeout_deleted_rport functions  to handle the new rport state
> FC_PORTSTATE_MARGINAL.
> 
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> 
> ---
> v7:
> Removed the changes related to SCMD_NORETRIES_ABORT bit.
> 
> Added a new function fc_eh_should_retry_cmd to check whether the cmd
> should be retried based on the rport state.
> 
> v6:
> No change
> 
> v5:
> Made changes to clear the SCMD_NORETRIES_ABORT bit if the port_state
> has changed from marginal to online due to port_delete and port_add
> as we need the normal cmd retry behaviour
> 
> Made changes in fc_scsi_scan_rport as we are checking
> FC_PORTSTATE_ONLINE
> instead of FC_PORTSTATE_ONLINE and FC_PORTSTATE_MARGINAL
> 
> v4:
> Made changes in fc_eh_timed_out to call
> fc_rport_chkmarginal_set_noretries
> so that SCMD_NORETRIES_ABORT bit in cmd->state is set if rport state
> is marginal.
> 
> Removed the newly added scsi_cmd argument to fc_remote_port_chkready
> as the current patch handles only SCSI EH timeout/abort case.
> 
> v3:
> Rearranged the patch so that all the changes with respect to new
> rport state is part of this patch.
> Added a new argument to scsi_cmd  to fc_remote_port_chkready
> 
> v2:
> New patch
> ---
>  drivers/scsi/scsi_transport_fc.c | 62 +++++++++++++++++++++++-------
> --
>  include/scsi/scsi_transport_fc.h |  4 ++-
>  2 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c
> b/drivers/scsi/scsi_transport_fc.c
> index a926e8f9e56e..ffd25195ae62 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -148,20 +148,23 @@ fc_enum_name_search(host_event_code,
> fc_host_event_code,
>  static struct {
>  	enum fc_port_state	value;
>  	char			*name;
> +	int			matchlen;
>  } fc_port_state_names[] = {
> -	{ FC_PORTSTATE_UNKNOWN,		"Unknown" },
> -	{ FC_PORTSTATE_NOTPRESENT,	"Not Present" },
> -	{ FC_PORTSTATE_ONLINE,		"Online" },
> -	{ FC_PORTSTATE_OFFLINE,		"Offline" },
> -	{ FC_PORTSTATE_BLOCKED,		"Blocked" },
> -	{ FC_PORTSTATE_BYPASSED,	"Bypassed" },
> -	{ FC_PORTSTATE_DIAGNOSTICS,	"Diagnostics" },
> -	{ FC_PORTSTATE_LINKDOWN,	"Linkdown" },
> -	{ FC_PORTSTATE_ERROR,		"Error" },
> -	{ FC_PORTSTATE_LOOPBACK,	"Loopback" },
> -	{ FC_PORTSTATE_DELETED,		"Deleted" },
> +	{ FC_PORTSTATE_UNKNOWN,		"Unknown", 7},
> +	{ FC_PORTSTATE_NOTPRESENT,	"Not Present", 11 },
> +	{ FC_PORTSTATE_ONLINE,		"Online", 6 },
> +	{ FC_PORTSTATE_OFFLINE,		"Offline", 7 },
> +	{ FC_PORTSTATE_BLOCKED,		"Blocked", 7 },
> +	{ FC_PORTSTATE_BYPASSED,	"Bypassed", 8 },
> +	{ FC_PORTSTATE_DIAGNOSTICS,	"Diagnostics", 11 },
> +	{ FC_PORTSTATE_LINKDOWN,	"Linkdown", 8 },
> +	{ FC_PORTSTATE_ERROR,		"Error", 5 },
> +	{ FC_PORTSTATE_LOOPBACK,	"Loopback", 8 },
> +	{ FC_PORTSTATE_DELETED,		"Deleted", 7 },
> +	{ FC_PORTSTATE_MARGINAL,	"Marginal", 8 },
>  };
>  fc_enum_name_search(port_state, fc_port_state, fc_port_state_names)
> +fc_enum_name_match(port_state, fc_port_state, fc_port_state_names)
>  #define FC_PORTSTATE_MAX_NAMELEN	20
>  
>  
> @@ -2509,7 +2512,8 @@ fc_user_scan_tgt(struct Scsi_Host *shost, uint
> channel, uint id, u64 lun)
>  		if (rport->scsi_target_id == -1)
>  			continue;
>  
> -		if (rport->port_state != FC_PORTSTATE_ONLINE)
> +		if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +			(rport->port_state != FC_PORTSTATE_MARGINAL))
>  			continue;
>  
>  		if ((channel == rport->channel) &&
> @@ -3373,7 +3377,8 @@ fc_remote_port_delete(struct fc_rport  *rport)
>  
>  	spin_lock_irqsave(shost->host_lock, flags);
>  
> -	if (rport->port_state != FC_PORTSTATE_ONLINE) {
> +	if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +		(rport->port_state != FC_PORTSTATE_MARGINAL)) {
>  		spin_unlock_irqrestore(shost->host_lock, flags);
>  		return;
>  	}
> @@ -3515,7 +3520,8 @@ fc_timeout_deleted_rport(struct work_struct
> *work)
>  	 * target, validate it still is. If not, tear down the
>  	 * scsi_target on it.
>  	 */
> -	if ((rport->port_state == FC_PORTSTATE_ONLINE) &&
> +	if (((rport->port_state == FC_PORTSTATE_ONLINE) ||
> +		(rport->port_state == FC_PORTSTATE_MARGINAL)) &&
>  	    (rport->scsi_target_id != -1) &&
>  	    !(rport->roles & FC_PORT_ROLE_FCP_TARGET)) {
>  		dev_printk(KERN_ERR, &rport->dev,
> @@ -3658,7 +3664,8 @@ fc_scsi_scan_rport(struct work_struct *work)
>  	struct fc_internal *i = to_fc_internal(shost->transportt);
>  	unsigned long flags;
>  
> -	if ((rport->port_state == FC_PORTSTATE_ONLINE) &&
> +	if (((rport->port_state == FC_PORTSTATE_ONLINE) ||
> +		(rport->port_state == FC_PORTSTATE_MARGINAL)) &&
>  	    (rport->roles & FC_PORT_ROLE_FCP_TARGET) &&
>  	    !(i->f->disable_target_scan)) {
>  		scsi_scan_target(&rport->dev, rport->channel,
> @@ -3731,6 +3738,28 @@ int fc_block_scsi_eh(struct scsi_cmnd *cmnd)
>  }
>  EXPORT_SYMBOL(fc_block_scsi_eh);
>  
> +/*
> + * fc_eh_should_retry_cmd - Checks if the cmd should be retried or
> not
> + * @scmd:        The SCSI command to be checked
> + *
> + * This checks the rport state to decide if a cmd is
> + * retryable.
> + *
> + * Returns: true if the rport state is not in marginal state.
> + */
> +bool fc_eh_should_retry_cmd(struct scsi_cmnd *scmd)
> +{
> +	struct fc_rport *rport = starget_to_rport(scsi_target(scmd-
> >device));
> +
> +	if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +		(scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT)) {
> +		set_host_byte(scmd, DID_TRANSPORT_MARGINAL);
> +		return false;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(fc_eh_should_retry_cmd);
> +
>  /**
>   * fc_vport_setup - allocates and creates a FC virtual port.
>   * @shost:	scsi host the virtual port is connected to.
> @@ -4162,7 +4191,8 @@ static blk_status_t fc_bsg_rport_prep(struct
> fc_rport *rport)
>  	    !(rport->flags & FC_RPORT_FAST_FAIL_TIMEDOUT))
>  		return BLK_STS_RESOURCE;
>  
> -	if (rport->port_state != FC_PORTSTATE_ONLINE)
> +	if ((rport->port_state != FC_PORTSTATE_ONLINE) &&
> +		(rport->port_state != FC_PORTSTATE_MARGINAL))
>  		return BLK_STS_IOERR;
>  
>  	return BLK_STS_OK;
> diff --git a/include/scsi/scsi_transport_fc.h
> b/include/scsi/scsi_transport_fc.h
> index c759b29e46c7..14214ee121ad 100644
> --- a/include/scsi/scsi_transport_fc.h
> +++ b/include/scsi/scsi_transport_fc.h
> @@ -67,6 +67,7 @@ enum fc_port_state {
>  	FC_PORTSTATE_ERROR,
>  	FC_PORTSTATE_LOOPBACK,
>  	FC_PORTSTATE_DELETED,
> +	FC_PORTSTATE_MARGINAL,
>  };
>  
>  
> @@ -742,7 +743,6 @@ struct fc_function_template {
>  	unsigned long	disable_target_scan:1;
>  };
>  
> -
>  /**
>   * fc_remote_port_chkready - called to validate the remote port
> state
>   *   prior to initiating io to the port.
> @@ -758,6 +758,7 @@ fc_remote_port_chkready(struct fc_rport *rport)
>  
>  	switch (rport->port_state) {
>  	case FC_PORTSTATE_ONLINE:
> +	case FC_PORTSTATE_MARGINAL:
>  		if (rport->roles & FC_PORT_ROLE_FCP_TARGET)
>  			result = 0;
>  		else if (rport->flags & FC_RPORT_DEVLOSS_PENDING)
> @@ -839,6 +840,7 @@ int fc_vport_terminate(struct fc_vport *vport);
>  int fc_block_rport(struct fc_rport *rport);
>  int fc_block_scsi_eh(struct scsi_cmnd *cmnd);
>  enum blk_eh_timer_return fc_eh_timed_out(struct scsi_cmnd *scmd);
> +bool fc_eh_should_retry_cmd(struct scsi_cmnd *scmd);
>  
>  static inline struct Scsi_Host *fc_bsg_to_shost(struct bsg_job *job)
>  {

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


