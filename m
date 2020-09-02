Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C812725B08D
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Sep 2020 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIBQAi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Sep 2020 12:00:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBQAf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Sep 2020 12:00:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082Fxbxk069104;
        Wed, 2 Sep 2020 16:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Avwpw/3Gm10hTmsPjLUX2eVPhfEYTETLaEpdVxr1P1k=;
 b=LBeGs1oyhjA+WxOZSbIVlYPYxdquiFBWCp2c94aLn7qXzZEiNx4Qs07+aqhvvrnD/hug
 OHwRkx20AIBJhNlFZLO/LCw2Y2LfpaN2uu5VGdDXI0uHMq3Uv1bCHkc/K8nun71znd++
 fcxJ4ThVihrytLkNq3Xs65hvKOrTjdexCasqE8GBgrIcHX7cE/yG4xI7XBMmDStW1Qgl
 SuUzDOAX5mOY/xC08gK7UlFHoCMMPvG9DrsGnJ1uQjxQWvGX4Xi+NJ6akf8s92QT6FzK
 jhmMStb0I3qPbH/4yV7R569uXLDCei+PJiPmMvJFvFhp8P9W7nyHcwHmJLzJqwUi7JX2 cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmn1ykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 16:00:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FtEQC030644;
        Wed, 2 Sep 2020 15:58:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380kq7gga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 15:58:32 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082FwWnI006881;
        Wed, 2 Sep 2020 15:58:32 GMT
Received: from dhcp-10-154-155-248.vpn.oracle.com (/10.154.155.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 08:58:32 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 10/13] qla2xxx: Add rport fields in debugfs
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200902072548.11491-11-njavali@marvell.com>
Date:   Wed, 2 Sep 2020 10:58:31 -0500
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C830324-7A74-4ED0-8E31-5083F0803568@oracle.com>
References: <20200902072548.11491-1-njavali@marvell.com>
 <20200902072548.11491-11-njavali@marvell.com>
To:     Nilesh Javali <njavali@marvell.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=3
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020152
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Sep 2, 2020, at 2:25 AM, Nilesh Javali <njavali@marvell.com> wrote:
>=20
> From: Arun Easi <aeasi@marvell.com>
>=20
> This patch adds rport fields in debugfs.
>=20
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
> drivers/scsi/qla2xxx/qla_dfs.c | 53 ++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_dfs.c =
b/drivers/scsi/qla2xxx/qla_dfs.c
> index 1e9db568aee3..118f2b223531 100644
> --- a/drivers/scsi/qla2xxx/qla_dfs.c
> +++ b/drivers/scsi/qla2xxx/qla_dfs.c
> @@ -65,13 +65,53 @@ =
DEFINE_DEBUGFS_ATTRIBUTE(qla_dfs_rport_##_attr##_fops,		\
> 		qla_dfs_rport_##_attr##_get,			\
> 		qla_dfs_rport_##_attr##_set, "%llu\n")
>=20
> +/*
> + * Wrapper for getting fc_port fields.
> + *
> + * _attr    : Attribute name.
> + * _get_val : Accessor macro to retrieve the value.
> + */
> +#define DEFINE_QLA_DFS_RPORT_FIELD_GET(_attr, _get_val)			=
\
> +static int qla_dfs_rport_field_##_attr##_get(void *data, u64 *val)	=
\
> +{									=
\
> +	struct fc_port *fp =3D data;					=
\
> +	*val =3D _get_val;						=
\
> +	return 0;							=
\
> +}									=
\
> +DEFINE_DEBUGFS_ATTRIBUTE(qla_dfs_rport_field_##_attr##_fops,		=
\
> +		qla_dfs_rport_field_##_attr##_get,			=
\
> +		NULL, "%llu\n")
> +
> +#define DEFINE_QLA_DFS_RPORT_ACCESS(_attr, _get_val) \
> +	DEFINE_QLA_DFS_RPORT_FIELD_GET(_attr, _get_val)
> +
> +#define DEFINE_QLA_DFS_RPORT_FIELD(_attr) \
> +	DEFINE_QLA_DFS_RPORT_FIELD_GET(_attr, fp->_attr)
> +
> DEFINE_QLA_DFS_RPORT_RW_ATTR(QLA_DFS_RPORT_DEVLOSS_TMO, dev_loss_tmo);
>=20
> +DEFINE_QLA_DFS_RPORT_FIELD(disc_state);
> +DEFINE_QLA_DFS_RPORT_FIELD(scan_state);
> +DEFINE_QLA_DFS_RPORT_FIELD(fw_login_state);
> +DEFINE_QLA_DFS_RPORT_FIELD(login_pause);
> +DEFINE_QLA_DFS_RPORT_FIELD(flags);
> +DEFINE_QLA_DFS_RPORT_FIELD(nvme_flag);
> +DEFINE_QLA_DFS_RPORT_FIELD(last_rscn_gen);
> +DEFINE_QLA_DFS_RPORT_FIELD(rscn_gen);
> +DEFINE_QLA_DFS_RPORT_FIELD(login_gen);
> +DEFINE_QLA_DFS_RPORT_FIELD(loop_id);
> +DEFINE_QLA_DFS_RPORT_FIELD_GET(port_id, fp->d_id.b24);
> +DEFINE_QLA_DFS_RPORT_FIELD_GET(sess_kref, kref_read(&fp->sess_kref));
> +
> void
> qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
> {
> 	char wwn[32];
>=20
> +#define QLA_CREATE_RPORT_FIELD_ATTR(_attr)			\
> +	debugfs_create_file(#_attr, 0400, fp->dfs_rport_dir,	\
> +		fp, &qla_dfs_rport_field_##_attr##_fops)
> +
> 	if (!vha->dfs_rport_root || fp->dfs_rport_dir)
> 		return;
>=20
> @@ -82,6 +122,19 @@ qla2x00_dfs_create_rport(scsi_qla_host_t *vha, =
struct fc_port *fp)
> 	if (NVME_TARGET(vha->hw, fp))
> 		debugfs_create_file("dev_loss_tmo", 0600, =
fp->dfs_rport_dir,
> 				    fp, =
&qla_dfs_rport_dev_loss_tmo_fops);
> +
> +	QLA_CREATE_RPORT_FIELD_ATTR(disc_state);
> +	QLA_CREATE_RPORT_FIELD_ATTR(scan_state);
> +	QLA_CREATE_RPORT_FIELD_ATTR(fw_login_state);
> +	QLA_CREATE_RPORT_FIELD_ATTR(login_pause);
> +	QLA_CREATE_RPORT_FIELD_ATTR(flags);
> +	QLA_CREATE_RPORT_FIELD_ATTR(nvme_flag);
> +	QLA_CREATE_RPORT_FIELD_ATTR(last_rscn_gen);
> +	QLA_CREATE_RPORT_FIELD_ATTR(rscn_gen);
> +	QLA_CREATE_RPORT_FIELD_ATTR(login_gen);
> +	QLA_CREATE_RPORT_FIELD_ATTR(loop_id);
> +	QLA_CREATE_RPORT_FIELD_ATTR(port_id);
> +	QLA_CREATE_RPORT_FIELD_ATTR(sess_kref);
> }
>=20
> void
> --=20
> 2.19.0.rc0
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

