Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62F2325885
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Feb 2021 22:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhBYVSo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Feb 2021 16:18:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhBYVSl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Feb 2021 16:18:41 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PL3L9d191222;
        Thu, 25 Feb 2021 16:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gw0IEjknbMH0QCu1NRzsc/4MbGba4x97bqNNSLB62/I=;
 b=KWIlIT6Wywfzvb2HiELCGWp8jLvr2NZcn/SmSUHdXrzl61GA/NGpwVhlduSYyfkDoPFo
 Lp+gNx0m0P4B6qcavHNGO53y9TGdX/xNDfz8feitbnU789hNWMkeOKFspWUJ1q7NIYD2
 QM373E0mEIdQSJSRKxq5dqhcdtSy89PTjeEsp1f+Ku2zChsepcBFSbOVlKC82AJG9apu
 7CHFEqTFQLvS2aWktEOjLMkl3Asjsbxy5a9OyydCyG5P4H7Bqq6xSVEkS6PNOVyc+32t
 +CnHkA4T1Ia9ZKPaDoqHapS/Z+wDJ2ZCKqQ+iSKhc9u/PdbcRaid5UPCJkYcik3nRFXK 6g== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xf2v049j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:17:53 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PL7smN027901;
        Thu, 25 Feb 2021 21:17:53 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 36v5y9mk8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 21:17:53 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PLHqfn42860868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 21:17:52 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26ED6AE05F;
        Thu, 25 Feb 2021 21:17:52 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E204AE060;
        Thu, 25 Feb 2021 21:17:51 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.211.123.159])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 21:17:51 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] ibmvfc: reinitialize sub-CRQs and perform channel
 enquiry after LPM
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com
References: <20210225204824.14570-1-tyreld@linux.ibm.com>
 <20210225204824.14570-6-tyreld@linux.ibm.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Message-ID: <451323f3-e778-81d0-38e9-5f098ed3426c@linux.vnet.ibm.com>
Date:   Thu, 25 Feb 2021 15:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225204824.14570-6-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_14:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250161
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/25/21 2:48 PM, Tyrel Datwyler wrote:
> A live partition migration (LPM) results in a CRQ disconnect similar to
> a hard reset. In this LPM case the hypervisor moslty perserves the CRQ
> transport such that it simply needs to be reenabled. However, the
> capabilities may have changed such as fewer channels, or no channels at
> all. Further, its possible that there may be sub-CRQ support, but no
> channel support. The CRQ reenable path currently doesn't take any of
> this into consideration.
> 
> For simpilicty release and reinitialize sub-CRQs during reenable, and
> set do_enquiry and using_channels with the appropriate values to trigger
> channel renegotiation.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index 4ac2c442e1e2..9ae6be56e375 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -903,6 +903,9 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
>  {
>  	int rc = 0;
>  	struct vio_dev *vdev = to_vio_dev(vhost->dev);
> +	unsigned long flags;
> +
> +	ibmvfc_release_sub_crqs(vhost);
>  
>  	/* Re-enable the CRQ */
>  	do {
> @@ -914,6 +917,16 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
>  	if (rc)
>  		dev_err(vhost->dev, "Error enabling adapter (rc=%d)\n", rc);
>  
> +	spin_lock_irqsave(vhost->host->host_lock, flags);
> +	spin_lock(vhost->crq.q_lock);
> +	vhost->do_enquiry = 1;
> +	vhost->using_channels = 0;
> +
> +	ibmvfc_init_sub_crqs(vhost);
> +
> +	spin_unlock(vhost->crq.q_lock);
> +	spin_unlock_irqrestore(vhost->host->host_lock, flags);

ibmvfc_init_sub_crqs can sleep, for multiple reasons, so you can't hold
a lock when you call it. There is a GFP_KERNEL allocation in it, and the
patch before this one adds an msleep in an error path.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

