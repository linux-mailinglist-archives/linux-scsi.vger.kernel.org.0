Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4D1A68DE
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Apr 2020 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgDMPaz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Apr 2020 11:30:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43426 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730336AbgDMPay (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Apr 2020 11:30:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B2909415AB;
        Mon, 13 Apr 2020 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1586791849;
         x=1588606250; bh=+KYRc4ytMhQS1W8lY34IzFKEwpr3bf1wBTyRiaYi08c=; b=
        UQJpXoZ+uPwGnKxKQpDrOyMkplS5iXz6TgkGlsofG2eGZBlKVecXpL3g+vgvrcV7
        JnqemkOKxvaWDxOgeaUalnxOyJ78svjfpjhH0xIyt1qArgdqdt9V5yWfFNp3XkLO
        KcM8J+bPo6WjaTHF7mUtsKGjHCuWytkg7S7FmuZahQk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kRHeWJkkSfqQ; Mon, 13 Apr 2020 18:30:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4920F414F4;
        Mon, 13 Apr 2020 18:30:48 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 13
 Apr 2020 18:30:48 +0300
Date:   Mon, 13 Apr 2020 18:30:49 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] qla2xxx: Increase the size of struct qla_fcp_prio_cfg to
 FCP_PRIO_CFG_SIZE
Message-ID: <20200413153049.GA8042@SPB-NB-133.local>
References: <20200405231339.29612-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200405231339.29612-1-bvanassche@acm.org>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Apr 05, 2020 at 04:13:39PM -0700, Bart Van Assche wrote:
> This patch fixes the following Coverity complaint without changing any
> functionality:
> 
> CID 337793 (#1 of 1): Wrong size argument (SIZEOF_MISMATCH)
> suspicious_sizeof: Passing argument ha->fcp_prio_cfg of type
> struct qla_fcp_prio_cfg * and argument 32768UL to function memset is
> suspicious because a multiple of sizeof (struct qla_fcp_prio_cfg) /*48*/
> is expected.
> 
> memset(ha->fcp_prio_cfg, 0, FCP_PRIO_CFG_SIZE);
> 
> ---
>  drivers/scsi/qla2xxx/qla_fw.h | 3 ++-
>  drivers/scsi/qla2xxx/qla_os.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
> index f9bad5bd7198..647e67c6ba5e 100644
> --- a/drivers/scsi/qla2xxx/qla_fw.h
> +++ b/drivers/scsi/qla2xxx/qla_fw.h
> @@ -2217,8 +2217,9 @@ struct qla_fcp_prio_cfg {
>  #define FCP_PRIO_ATTR_PERSIST   0x2
>  	uint8_t  reserved;      /* Reserved for future use          */
>  #define FCP_PRIO_CFG_HDR_SIZE   0x10
> -	struct qla_fcp_prio_entry entry[1];     /* fcp priority entries  */
> +	struct qla_fcp_prio_entry entry[1023]; /* fcp priority entries  */
>  #define FCP_PRIO_CFG_ENTRY_SIZE 0x20
> +	uint8_t  reserved2[16];
>  };
>  
>  #define FCP_PRIO_CFG_SIZE       (32*1024) /* fcp prio data per port*/

Hi Bart,

A new constant may be introduced to define size of qla_fcp_prio_entry.
That would let to drop the magic 32 number here and allow to add one
more BUILD_BUG_ON for sizeof(struct qla_fcp_prio_entry).

Besides that,
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index d9072ea7c42b..784f3e553f15 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -7840,6 +7840,7 @@ qla2x00_module_init(void)
>  	BUILD_BUG_ON(sizeof(struct vf_evfp_entry_24xx) != 56);
>  	BUILD_BUG_ON(sizeof(struct qla_flt_region) != 16);
>  	BUILD_BUG_ON(sizeof(struct qla_flt_header) != 8);
> +	BUILD_BUG_ON(sizeof(struct qla_fcp_prio_cfg) != FCP_PRIO_CFG_SIZE);
>  
>  	/* Allocate cache for SRBs. */
>  	srb_cachep = kmem_cache_create("qla2xxx_srbs", sizeof(srb_t), 0,

Thanks,
Roman
