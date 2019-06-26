Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9056C5C
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFZOkS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 10:40:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfFZOkS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 10:40:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEXfix096090;
        Wed, 26 Jun 2019 14:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=k+RXU8fNAkbJZnvKvN9Zh+NmpwwImWtKUca0Q9GKf8Q=;
 b=3qcctqZPtNM32TXcEgCWx3kTgYckI/lMTHWnkx0bHZ+wGkiGWC0lghZ0ZKwTw45fSsHR
 YcLCmQKXhYAz68tOg5Kr2xRiT0BSYCA583n9tbNayD3dI/kkhqEulDbBkwOqKibqprjK
 Frle1Hit2s6nsc6QIYvKvn78O15iD5OsR8TCW9EBEXipa3Nt+hEeN3cJr9BbEZY17o5K
 Y1LjfEy2aDPGE4hWO/X7PWX0F2eoDHZLs1iXYCTA8kwgiqI2mNGutXWh4eNuo2/w1oPG
 c8svXVrmjbTGaJktVAx3dDxR0SLyugcIi+s/ey4khcYHa5NVfhVFH2q2Dcin8lPfmzyL DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtat0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:38:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEbimf015777;
        Wed, 26 Jun 2019 14:38:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t9accqww1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:38:08 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QEc7Lp027752;
        Wed, 26 Jun 2019 14:38:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 07:38:06 -0700
Date:   Wed, 26 Jun 2019 17:37:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: clean up a sizeof()
Message-ID: <20190626143755.GF28859@kadam>
References: <20190626101243.GF3242@mwanda>
 <1561558950.3435.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561558950.3435.2.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260172
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 26, 2019 at 07:22:30AM -0700, James Bottomley wrote:
> On Wed, 2019-06-26 at 13:12 +0300, Dan Carpenter wrote:
> > This patch is just a cleanup and doesn't change run time because both
> > sizeof EVENT and SCSI are 84 bytes.  But this is clearly a cut and
> > paste
> > error and the SCSI struct was intended.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > index d4ecfbbe738c..06a901ed743c 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > @@ -3280,7 +3280,7 @@ diag_trigger_scsi_store(struct device *cdev,
> >  	spin_lock_irqsave(&ioc->diag_trigger_lock, flags);
> >  	sz = min(sizeof(struct SL_WH_SCSI_TRIGGERS_T), count);
> >  	memset(&ioc->diag_trigger_scsi, 0,
> > -	    sizeof(struct SL_WH_EVENT_TRIGGERS_T));
> > +	    sizeof(struct SL_WH_SCSI_TRIGGERS_T));
> 
> Please can we make this the correct pattern of
> 
> sizeof(ioc->diag_trigger_scsi)

Sure.  I'll resend.

regards,
dan carpenter

