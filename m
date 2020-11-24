Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815872C2F33
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404055AbgKXRuY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Nov 2020 12:50:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35966 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbgKXRuY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Nov 2020 12:50:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOHebdD113058;
        Tue, 24 Nov 2020 17:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2axXQg9Zug5f5rxs+mjICQzGcHi3pcd/K+FRV0njW/s=;
 b=dmHdcRSu1vdhERiFPLbclbGw+s/nS1hKSCqlN8AZAlfyhWXfoB/sYuYq5jZ2SPlPgIzu
 wssZO4p1aInHnCoZD5Wh2c9E7loUl/uHhq6J6ebfhDqSmLn6tqSJpynNyxQvFW0YW6O3
 s08rqvkJRDJsZOaHNY5vrt6fvedXZF36OwYZubD7wfmJxynJ349o83588pAI7HT43vNa
 +RFJilpBdZqjALLEBmLtdjGB0TOXxV/OezBRVXA4/zw9O3zn1YYhNORcLTKCGtii3Qy8
 Ic4Xoku46DVDTGdhhZKnZB3Bhd18AyX2XP8vOPmmz+yamtlfVTqShfv5WbibZI9uwH54 xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34xtum43sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 17:48:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOHdfw4024704;
        Tue, 24 Nov 2020 17:46:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34yx8k6asp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 17:46:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AOHkFfu013919;
        Tue, 24 Nov 2020 17:46:16 GMT
Received: from [192.168.1.15] (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 09:46:15 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v7 5/5] scsi:lpfc: Added support for eh_should_retry_cmd
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <1605070685-20945-6-git-send-email-muneendra.kumar@broadcom.com>
Date:   Tue, 24 Nov 2020 11:46:14 -0600
Cc:     linux-scsi@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>, hare@suse.de,
        jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D07EE9A8-07E4-48A3-A966-2016C0C9F10F@oracle.com>
References: <1605070685-20945-1-git-send-email-muneendra.kumar@broadcom.com>
 <1605070685-20945-6-git-send-email-muneendra.kumar@broadcom.com>
To:     Muneendra <muneendra.kumar@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240107
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Nov 10, 2020, at 10:58 PM, Muneendra <muneendra.kumar@broadcom.com> =
wrote:
>=20
> Added support to handle eh_should_retry_cmd in lpfc_template.
>=20
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
>=20
> ---
> v7:
> New patch
> ---
> drivers/scsi/lpfc/lpfc_scsi.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c =
b/drivers/scsi/lpfc/lpfc_scsi.c
> index 4ffdfd2c8604..dbc80e6423ea 100644
> --- a/drivers/scsi/lpfc/lpfc_scsi.c
> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
> @@ -6040,6 +6040,7 @@ struct scsi_host_template lpfc_template =3D {
> 	.info			=3D lpfc_info,
> 	.queuecommand		=3D lpfc_queuecommand,
> 	.eh_timed_out		=3D fc_eh_timed_out,
> +	.eh_should_retry_cmd    =3D fc_eh_should_retry_cmd,
> 	.eh_abort_handler	=3D lpfc_abort_handler,
> 	.eh_device_reset_handler =3D lpfc_device_reset_handler,
> 	.eh_target_reset_handler =3D lpfc_target_reset_handler,
> --=20
> 2.26.2
>=20

This is generic change for LLD, I expect other drivers to add this to =
their respective code as well.=20

So with that in mind .. =20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

