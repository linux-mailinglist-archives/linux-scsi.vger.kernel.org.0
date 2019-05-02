Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834151243D
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBVna (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 17:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbfEBVn3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 May 2019 17:43:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42LgSIt060432
        for <linux-scsi@vger.kernel.org>; Thu, 2 May 2019 17:43:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s88j6890m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 02 May 2019 17:43:28 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
        Thu, 2 May 2019 22:43:27 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 22:43:25 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42LhO2u35127444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 21:43:24 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0255C124058;
        Thu,  2 May 2019 21:43:24 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E3C8124055;
        Thu,  2 May 2019 21:43:23 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.10.86.114])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 21:43:23 +0000 (GMT)
Subject: Re: [PATCH 2/3] ibmvscsi: redo driver work thread to use enum action
 states
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20190502004729.19962-1-tyreld@linux.ibm.com>
 <20190502004729.19962-2-tyreld@linux.ibm.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Date:   Thu, 2 May 2019 16:43:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502004729.19962-2-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050221-0040-0000-0000-000004EA4889
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011037; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197678; UDB=6.00628194; IPR=6.00978534;
 MB=3.00026705; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-02 21:43:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050221-0041-0000-0000-000008F64D9F
Message-Id: <5515ab01-f2d4-d925-76ff-7fa8416b86f8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020135
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/19 7:47 PM, Tyrel Datwyler wrote:
> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> 
> The current implemenation relies on two flags in the drivers private host
> structure to signal the need for a host reset or to reenable the CRQ after a
> LPAR migration. This patch does away with those flags and introduces a single
> action flag and defined enums for the supported kthread work actions. Lastly,
> the if/else logic is replaced with a switch statement.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvscsi.c | 57 +++++++++++++++++++++-----------
>  drivers/scsi/ibmvscsi/ibmvscsi.h |  9 +++--
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 1c37244f16a0..683139e6c63f 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -828,7 +828,7 @@ static void ibmvscsi_reset_host(struct ibmvscsi_host_data *hostdata)
>  	atomic_set(&hostdata->request_limit, 0);
>  
>  	purge_requests(hostdata, DID_ERROR);
> -	hostdata->reset_crq = 1;
> +	hostdata->action = IBMVSCSI_HOST_ACTION_RESET;
>  	wake_up(&hostdata->work_wait_q);
>  }
>  
> @@ -1797,7 +1797,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
>  			/* We need to re-setup the interpartition connection */
>  			dev_info(hostdata->dev, "Re-enabling adapter!\n");
>  			hostdata->client_migrated = 1;
> -			hostdata->reenable_crq = 1;
> +			hostdata->action = IBMVSCSI_HOST_ACTION_REENABLE;
>  			purge_requests(hostdata, DID_REQUEUE);
>  			wake_up(&hostdata->work_wait_q);
>  		} else {
> @@ -2118,26 +2118,32 @@ static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
>  
>  static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
>  {
> +	unsigned long flags;
>  	int rc;
>  	char *action = "reset";
>  
> -	if (hostdata->reset_crq) {
> -		smp_rmb();
> -		hostdata->reset_crq = 0;
> -
> +	spin_lock_irqsave(hostdata->host->host_lock, flags);
> +	switch (hostdata->action) {
> +	case IBMVSCSI_HOST_ACTION_NONE:
> +		break;
> +	case IBMVSCSI_HOST_ACTION_RESET:
>  		rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);

Looks like you are now calling ibmvscsi_reset_crq_queue with the host_lock held.
However, ibmvscsi_reset_crq_queue can call msleep.

This had been implemented as separate reset_crq and reenable_crq fields
so that it could run lockless. I'm not opposed to changing this to a single
field in general, we just need to be careful where we are adding locking.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

