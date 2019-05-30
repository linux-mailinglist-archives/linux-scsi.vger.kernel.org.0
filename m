Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54892F77D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE3GlO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 02:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3GlO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 02:41:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B79A307D84B;
        Thu, 30 May 2019 06:41:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB8AA5D721;
        Thu, 30 May 2019 06:41:07 +0000 (UTC)
Date:   Thu, 30 May 2019 14:41:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
Message-ID: <20190530064101.GA22773@ming.t460p>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529132901.27645-3-hare@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 30 May 2019 06:41:13 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 03:28:39PM +0200, Hannes Reinecke wrote:
> Add helper functions to retrieve SCSI commands from the reserved
> tag pool.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  include/scsi/scsi_tcq.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
> index 6053d46e794e..227f3bd4e974 100644
> --- a/include/scsi/scsi_tcq.h
> +++ b/include/scsi/scsi_tcq.h
> @@ -39,5 +39,27 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
>  	return blk_mq_rq_to_pdu(req);
>  }
>  
> +static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
> +{
> +	struct request *rq;
> +	struct scsi_cmnd *scmd;
> +
> +	rq = blk_mq_alloc_request(sdev->request_queue,
> +				  REQ_OP_SCSI_OUT | REQ_NOWAIT,
> +				  BLK_MQ_REQ_RESERVED);
> +	if (IS_ERR(rq))
> +		return NULL;
> +	scmd = blk_mq_rq_to_pdu(rq);
> +	scmd->request = rq;
> +	return scmd;
> +}

Now all these internal commands won't share tags with IO requests,
however, your patch switches to reserve slots for internal
commands.

This way may have performance effect on IO workloads given the
reserved tags can't be used by IO at all.

Just wondering why not use an new tagset for internal commands?

Thanks,
Ming
