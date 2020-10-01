Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2428043B
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Oct 2020 18:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgJAQsj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Oct 2020 12:48:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37404 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbgJAQsj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Oct 2020 12:48:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091GjxNe156951;
        Thu, 1 Oct 2020 16:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=vZuhxDZKDyeXm3lZGGVdl+G9RR36NC/Au4CFcffL7Xg=;
 b=jucfAiZpIF7lboyUzM8mcWWV4lSvD6YFlenJ4Oz0xzsk6ir509siuIRqdAgIjTmJhvsl
 6qyZ2fZ5V7xThp1FWJCTSRG3jk++qVIl1Dnhr19ximpr+5EPc+2xolb6FWN/o82ZJgFx
 0BMdDl//6FQhMWYHTLw+6a2DuSwkDvUCQv1uRdoSrnmjxOBdNa+7SzNLqLsjv9X73dui
 gm+vGoqb8Fz4XFdTrFUKOwsDZV9sEbAhKpDUOn+aLhap1yIXh7HyMw6ppbpoVRYWNAbO
 Tzg43JP3sixCtLZFWBXtO6qxeW0ZDWBhZdGTiio5NjNNpJVbP/QaCmW8/Ul3PHrAbmFG Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5b78ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 01 Oct 2020 16:48:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Gixji022156;
        Thu, 1 Oct 2020 16:46:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33uv2h5r7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 16:46:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 091GkMK1027401;
        Thu, 1 Oct 2020 16:46:22 GMT
Received: from dhcp-10-154-119-140.vpn.oracle.com (/10.154.119.140)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Oct 2020 09:46:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/3] scsi: qla2xxx: Fix inconsistent of format with
 argument type in qla_os.c
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200930022515.2862532-3-yebin10@huawei.com>
Date:   Thu, 1 Oct 2020 11:46:21 -0500
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        linux-scsi@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <580E0778-0A64-475B-BFD4-9B1C4D2815B0@oracle.com>
References: <20200930022515.2862532-1-yebin10@huawei.com>
 <20200930022515.2862532-3-yebin10@huawei.com>
To:     Ye Bin <yebin10@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010141
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Sep 29, 2020, at 9:25 PM, Ye Bin <yebin10@huawei.com> wrote:
>=20
> Fix follow warning:
> [drivers/scsi/qla2xxx/qla_os.c:4882]: (warning) %ld in format string =
(no. 2)
> 	requires 'long' but the argument type is 'unsigned long'.
> [drivers/scsi/qla2xxx/qla_os.c:5011]: (warning) %ld in format string =
(no. 1)
> 	requires 'long' but the argument type is 'unsigned long'.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> drivers/scsi/qla2xxx/qla_os.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_os.c =
b/drivers/scsi/qla2xxx/qla_os.c
> index 910a6ed0ccc7..473a02603697 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -4879,7 +4879,7 @@ struct scsi_qla_host *qla2x00_create_host(struct =
scsi_host_template *sht,
> 	}
> 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
>=20
> -	sprintf(vha->host_str, "%s_%ld", QLA2XXX_DRIVER_NAME, =
vha->host_no);
> +	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, =
vha->host_no);
> 	ql_dbg(ql_dbg_init, vha, 0x0041,
> 	    "Allocated the host=3D%p hw=3D%p vha=3D%p dev_name=3D%s",
> 	    vha->host, vha->hw, vha,
> @@ -5008,7 +5008,7 @@ qla2x00_uevent_emit(struct scsi_qla_host *vha, =
u32 code)
>=20
> 	switch (code) {
> 	case QLA_UEVENT_CODE_FW_DUMP:
> -		snprintf(event_string, sizeof(event_string), =
"FW_DUMP=3D%ld",
> +		snprintf(event_string, sizeof(event_string), =
"FW_DUMP=3D%lu",
> 		    vha->host_no);
> 		break;
> 	default:
> --=20
> 2.25.4
>=20

Looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

