Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5156BC3
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZOWk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 10:22:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbfFZOWj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Jun 2019 10:22:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QE8fEN062121;
        Wed, 26 Jun 2019 10:22:35 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc8m3dnsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 10:22:35 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5QEKtn5016708;
        Wed, 26 Jun 2019 14:22:34 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by77qjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 14:22:34 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QEMXeO59441604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:22:33 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA796E04C;
        Wed, 26 Jun 2019 14:22:33 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62A316E05D;
        Wed, 26 Jun 2019 14:22:31 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.213.131])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 14:22:31 +0000 (GMT)
Message-ID: <1561558950.3435.2.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: mpt3sas: clean up a sizeof()
From:   James Bottomley <jejb@linux.ibm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 26 Jun 2019 07:22:30 -0700
In-Reply-To: <20190626101243.GF3242@mwanda>
References: <20190626101243.GF3242@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260169
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2019-06-26 at 13:12 +0300, Dan Carpenter wrote:
> This patch is just a cleanup and doesn't change run time because both
> sizeof EVENT and SCSI are 84 bytes.  But this is clearly a cut and
> paste
> error and the SCSI struct was intended.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index d4ecfbbe738c..06a901ed743c 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -3280,7 +3280,7 @@ diag_trigger_scsi_store(struct device *cdev,
>  	spin_lock_irqsave(&ioc->diag_trigger_lock, flags);
>  	sz = min(sizeof(struct SL_WH_SCSI_TRIGGERS_T), count);
>  	memset(&ioc->diag_trigger_scsi, 0,
> -	    sizeof(struct SL_WH_EVENT_TRIGGERS_T));
> +	    sizeof(struct SL_WH_SCSI_TRIGGERS_T));

Please can we make this the correct pattern of

sizeof(ioc->diag_trigger_scsi)

James

