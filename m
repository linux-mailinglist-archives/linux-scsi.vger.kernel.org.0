Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5212CA758
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgLAPnb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 10:43:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35622 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbgLAPnb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 10:43:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1FYvvM195272;
        Tue, 1 Dec 2020 15:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=H4eodoH1mwSQpZp5VBdnpTOQGj/CEIv9rpO5Bhp1Ufk=;
 b=JIHL4cp9h6SSY1ql560vDA6UQZVG4kem9r3IQndLdWID8fibv4c7n84qDk3WstVcr7aP
 wF+JL7UzjUfb8tgXu3zrX6p9GInsakxY6RHudGCE5Vrccoe9ZuE/yibiQx8wa1gWNOOQ
 hx/xUMk6Pg+VrbF5V3Xzuxuo26EVCt1dt1o5q37ef8htApVoIk4Ot+vfu4wv1vM3vDAQ
 MEFsbKgljh9MvsWI96YIxGPazu41DmnptBTTSj9LOWUmCxnahqmBR6YCwb9+6EHCdgSy
 eYxCMFahiRoYxSM2plBfkS9gZb3s7MyUiWiP1agB9nVcBqcKNrSkmrTjKZhUjEx90ztY eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2aubn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 15:42:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1FVKeg012757;
        Tue, 1 Dec 2020 15:40:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540fx4vjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 15:40:48 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1Feln7019957;
        Tue, 1 Dec 2020 15:40:47 GMT
Received: from [192.168.1.15] (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 07:40:46 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 01/15] scsi: qla2xxx: Return EBUSY on fcport deletion
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201201082730.24158-2-njavali@marvell.com>
Date:   Tue, 1 Dec 2020 09:40:44 -0600
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C604FE2-93E5-41F8-BC3A-691E94CA6646@oracle.com>
References: <20201201082730.24158-1-njavali@marvell.com>
 <20201201082730.24158-2-njavali@marvell.com>
To:     Nilesh Javali <njavali@marvell.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010099
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Dec 1, 2020, at 2:27 AM, Nilesh Javali <njavali@marvell.com> wrote:
>=20
> From: Daniel Wagner <dwagner@suse.de>
>=20
> When the fcport is about to be deleted we should return EBUSY instead =
of
> ENODEV. Only for EBUSY will the request be requeued in a multipath =
setup.
>=20
> Also return EBUSY when the firmware has not yet started to avoid =
dropping
> the request.
>=20
> Link: https://lore.kernel.org/r/20201014073048.36219-1-dwagner@suse.de
> Reviewed-by: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
> drivers/scsi/qla2xxx/qla_nvme.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c =
b/drivers/scsi/qla2xxx/qla_nvme.c
> index 1f9005125313..b7a1dc24db38 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -554,10 +554,12 @@ static int qla_nvme_post_cmd(struct =
nvme_fc_local_port *lport,
>=20
> 	fcport =3D qla_rport->fcport;
>=20
> -	if (!qpair || !fcport || (qpair && !qpair->fw_started) ||
> -	    (fcport && fcport->deleted))
> +	if (!qpair || !fcport)
> 		return -ENODEV;
>=20
> +	if (!qpair->fw_started || fcport->deleted)
> +		return -EBUSY;
> +
> 	vha =3D fcport->vha;
>=20
> 	if (!(fcport->nvme_flag & NVME_FLAG_REGISTERED))
> --=20
> 2.19.0.rc0
>=20

Looks Good.=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

