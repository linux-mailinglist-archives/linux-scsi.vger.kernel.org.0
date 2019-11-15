Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C960AFD81C
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2019 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfKOItB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Nov 2019 03:49:01 -0500
Received: from verein.lst.de ([213.95.11.211]:43518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOItB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 Nov 2019 03:49:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E9CD68AFE; Fri, 15 Nov 2019 09:48:58 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:48:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] dpt_i2o: use midlayer tcq implementation
Message-ID: <20191115084857.GA24954@lst.de>
References: <20191115080555.146710-1-hare@suse.de> <20191115080555.146710-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115080555.146710-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Nov 15, 2019 at 09:05:52AM +0100, Hannes Reinecke wrote:
static bool fail_posted_scbs_iter(struct request *rq, void *data, bool reserved)
>  {
> +	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
>  
> +	cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;

Not new in this patch, but SAM_STAT_TASK_SET_FULL seems like an odd
error code for bouncing all commands to the mid layer after an reset.

> +	cmd->scsi_done(cmd);
> +
> +	return true;
> +}
> +
> +static void adpt_fail_posted_scbs(adpt_hba* pHba)
> +{
> +	blk_mq_tagset_busy_iter(&pHba->host->tag_set,
> +				fail_posted_scbs_iter, NULL);

Should this be a scsi layer helper?  In the future it also sounds
like we migh want to move something like this to be called from
common code, as letting the other command posted to the hardware
just time out after a host reset is rather silly.
