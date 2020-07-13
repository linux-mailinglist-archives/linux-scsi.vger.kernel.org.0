Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E497E21DB5A
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2020 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgGMQNr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Jul 2020 12:13:47 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:40425 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQNq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Jul 2020 12:13:46 -0400
Received: from localhost (varun.asicdesigners.com [10.193.191.116])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06DGDc06003726;
        Mon, 13 Jul 2020 09:13:38 -0700
Date:   Mon, 13 Jul 2020 21:43:37 +0530
From:   Varun Prakash <varun@chelsio.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        varun@chelsio.com
Subject: Re: [PATCH] scsi: cxgb4i: clean up a debug printk
Message-ID: <20200713161336.GA1780@chelsio.com>
References: <20200713105100.GA251988@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713105100.GA251988@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 13, 2020 at 10:51:00AM +0000, Dan Carpenter wrote:
> The pr_fmt() at the top of the file already includes the __func__ so we
> can remove the duplicative "cxgbi_conn_init_pdu:" from the string here.
> Now it all fits on one  line as well.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/scsi/cxgbi/libcxgbi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
> index 1fb101c616b7..ba1593be626c 100644
> --- a/drivers/scsi/cxgbi/libcxgbi.c
> +++ b/drivers/scsi/cxgbi/libcxgbi.c
> @@ -2182,8 +2182,7 @@ int cxgbi_conn_init_pdu(struct iscsi_task *task, unsigned int offset,
>  	}
>  
>  	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
> -		  "cxgbi_conn_init_pdu: tdata->total_count %u, "
> -		  "tdata->total_offset %u\n",
> +		  "data->total_count %u, tdata->total_offset %u\n",
>  		  tdata->total_count, tdata->total_offset);
>  
>  	expected_count = tdata->total_count;

Acked-by: Varun Prakash <varun@chelsio.com>
