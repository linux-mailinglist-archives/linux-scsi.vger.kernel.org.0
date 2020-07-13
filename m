Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8327F219E71
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGIK4m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Jul 2020 06:56:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIK4m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Jul 2020 06:56:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069AudtV059098;
        Thu, 9 Jul 2020 10:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cLIHYpjfK7KUt0VXK6dLAKo3bWyef9fWWh7Qd9conbU=;
 b=GCNmIQ0OovuVd+ynHP2i9AKjUTwnBW4gaKpnGoEL6jV/aVA71TXsDLmtFPOXsIELqCQi
 tjlmKIVeAoabPgcI2RKSB8A6vS3e4yngAmUDpOUATV75QJs3IKt42EQb3SwVmnN6vsbw
 m4qgdJS7JARyF2K1HpCL8DrnPW+l2uafAxUe/vVAKEYUiJbGkxBD9rXgA2odo2XHwJHU
 JfghgYm76gu2JPGxU2pw+JEdMhoTxxnZ2OAl9rO3XapRmqDYArOIVbLBqNXkmGEwfrU8
 pt9Ja4gs/RkZT46UXwO2Q2Vckg79AaJwUzG9Nuti0EiL7eD31cIFfNcBPdvD16sWGbaQ qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 325y0agxt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 10:56:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069AnFhF037444;
        Thu, 9 Jul 2020 10:56:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 325k3ggssq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 10:56:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069AuZgk027355;
        Thu, 9 Jul 2020 10:56:35 GMT
Received: from kadam (/105.59.63.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 03:56:35 -0700
Date:   Thu, 9 Jul 2020 13:56:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Fix a condition in lpfc_dmp_dbg()
Message-ID: <20200709105628.GG2571@kadam>
References: <20200709104919.GD20875@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709104919.GD20875@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090087
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jul 09, 2020 at 01:49:19PM +0300, Dan Carpenter wrote:
> These variables are unsigned so the result of the subtraction is also
> unsigned and thus can't be negative.  Change it to a comparison and
> remove the subtraction.
> 
> Fixes: 372c187b8a70 ("scsi: lpfc: Add an internal trace log buffer")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 7285b0114837..2bb2c96e7784 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -14152,7 +14152,7 @@ void lpfc_dmp_dbg(struct lpfc_hba *phba)
>  		if ((start_idx + dbg_cnt) > (DBG_LOG_SZ - 1)) {
>  			temp_idx = (start_idx + dbg_cnt) % DBG_LOG_SZ;
>  		} else {
> -			if ((start_idx - dbg_cnt) < 0) {
> +			if (start_idx > dbg_cnt) {

Nope.  That's reversed.  I'm dumb.  Let me resend.

regards,
dan carpenter

