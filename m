Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E503E53D8
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhHJGsX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 02:48:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53766 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhHJGsV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 02:48:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F7DF1FE26;
        Tue, 10 Aug 2021 06:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628578079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfslFNPkBhXLBsvLqtfYoG1YSnJja/Qd9XavD2B2vuI=;
        b=lEwgG5K1tiPqmyLw/E4n769/2no2qTggp8q6qHJkba866EILlrkuYwG/l+cnIqr2tky1cl
        Mka06X8z0jDj7YqXLnMe4ijgT0BPI0Jg/NFKhAbixWE/6Q9xShyfoUDoyjqZoO5S5GvWMH
        bv3sgNFdyDBvE8ipnLlX6KTK6iWbFlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628578079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfslFNPkBhXLBsvLqtfYoG1YSnJja/Qd9XavD2B2vuI=;
        b=ZI0j27lQhveMTQ5cfk/jAZ+eTt3h9WZbi5p37Y+91qMvGs8B/NgaZXWpToS3t+sDVbAJXJ
        3wwd4PQy9z2huTCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 471CA133F9;
        Tue, 10 Aug 2021 06:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id jb1FDx8hEmGUQAAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 10 Aug 2021 06:47:59 +0000
Subject: Re: [PATCH v4 10/11] qla2xxx: Increment EDIF command and completion
 counts
To:     Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
References: <20210624052606.21613-1-njavali@marvell.com>
 <20210624052606.21613-11-njavali@marvell.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <86a16d29-8528-cf04-9f9f-130dcc85a35f@suse.de>
Date:   Tue, 10 Aug 2021 08:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624052606.21613-11-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/24/21 7:26 AM, Nilesh Javali wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> Increment the command and the completion counts.
> 
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_edif.c | 1 +
>   drivers/scsi/qla2xxx/qla_isr.c  | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
> index 8e730cc882e6..ccbe0e1bfcbc 100644
> --- a/drivers/scsi/qla2xxx/qla_edif.c
> +++ b/drivers/scsi/qla2xxx/qla_edif.c
> @@ -2926,6 +2926,7 @@ qla28xx_start_scsi_edif(srb_t *sp)
>   		req->ring_ptr++;
>   	}
>   
> +	sp->qpair->cmd_cnt++;
>   	/* Set chip new ring index. */
>   	wrt_reg_dword(req->req_q_in, req->ring_index);
>   
> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
> index ce4f93fb4d25..e8928fd83049 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -3192,10 +3192,9 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
>   		return;
>   	}
>   
> -	sp->qpair->cmd_completion_cnt++;
> -
>   	/* Fast path completion. */
>   	qla_chk_edif_rx_sa_delete_pending(vha, sp, sts24);
> +	sp->qpair->cmd_completion_cnt++;
>   
>   	if (comp_status == CS_COMPLETE && scsi_status == 0) {
>   		qla2x00_process_completed_request(vha, req, handle);
> 
Please fix up the patch description (the patch doesn't add counter 
increments, it just moves them to the correct place).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
