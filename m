Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B362C34196
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFDIR0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:17:26 -0400
Received: from verein.lst.de ([213.95.11.211]:34168 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfFDIR0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:17:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3638068B05; Tue,  4 Jun 2019 10:17:00 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:16:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
Message-ID: <20190604081659.GB16717@lst.de>
References: <20190529132901.27645-1-hare@suse.de> <20190529132901.27645-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529132901.27645-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
> +{
> +	struct request *rq;
> +	struct scsi_cmnd *scmd;
> +
> +	rq = blk_mq_alloc_request(sdev->request_queue,
> +				  REQ_OP_SCSI_OUT | REQ_NOWAIT,
> +				  BLK_MQ_REQ_RESERVED);

REQ_OP_SCSI_OUT is used for data transfers to the device, is that really
what you want?  REQ_NOWAIT not only seems misplaced, but also generally
wrong.  Maybe for some callers you don't want to wait, but that
really should be passed in.

Also why does this take a scsi device?  Host reserved command usually
would be on a per-host, not a per-LU basis.

> +	if (IS_ERR(rq))
> +		return NULL;
> +	scmd = blk_mq_rq_to_pdu(rq);
> +	scmd->request = rq;
> +	return scmd;
> +}
> +
> +static inline void scsi_put_reserved_cmd(struct scsi_cmnd *scmd)
> +{
> +	struct request *rq = blk_mq_rq_from_pdu(scmd);
> +
> +	blk_mq_free_request(rq);
> +}

Also both helpers really should be out of line somewhere.
