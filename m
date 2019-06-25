Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAD5232B
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 07:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfFYFwa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 01:52:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62868 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727648AbfFYFwa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Jun 2019 01:52:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P5nouT013024;
        Mon, 24 Jun 2019 22:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mimxo+7t+9KqsL5YdbWNjSBvg8JahZyeuQYsDqNYfgc=;
 b=UZ+JU5f69k75WzXzAClPZbVTQodC2KcvVseac/PSYjaY+fI881zO4Pqwnune5UyfoTUh
 D2TrDQhtImpkHJAeObcxEcojB79LZ3zBZm1agLny84cUGFBPbpygoMd5pdS8I/knNOZw
 7TVc0MiMnvTUQPIGAMGwv95pW8supX8EXaRqY4Uw3aMrf2TN851QtnsAZKWof3Mlswxy
 nk6XVSdo3wJiF3JdPFTYg8mrvEA/QYvMNhimgKO0+dZBAQu0TT7/pfkmH9NumT1/di1T
 lf+VFKxYPDpXHXUc3iqyLFxxThhNf/SaNcc4k0TKtv3sxhm9I3kLqfActuS1kDFX20K0 5A== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tbcudr5p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 22:52:25 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 22:52:23 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 22:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mimxo+7t+9KqsL5YdbWNjSBvg8JahZyeuQYsDqNYfgc=;
 b=T3+ckGLtxTQK+jS+VuzDxH0uKnSpd9S1ceOJhGORp8FHZXkllTYR8nAvw12nFewqpc79YB3S5MjYyt4HhrGKRqA1xoCB2BhvhK8G50eqxojSNj+7sGaJ/96MJCw3ej+cn56Q1YzQnkxmNOI/FLdkkxB42cMC4NSsDFa4mbXj2tU=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB2781.namprd18.prod.outlook.com (20.179.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 05:52:22 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 05:52:22 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Lin Yi <teroincn@163.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] [PATCH v2 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd
 refcount imbalance in send_srr
Thread-Topic: [EXT] [PATCH v2 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd
 refcount imbalance in send_srr
Thread-Index: AQHVKv6sT/ugAxCWDUmWwUk1p8OFAaasOmqA
Date:   Tue, 25 Jun 2019 05:52:22 +0000
Message-ID: <D937B438.1911E%skashyap@marvell.com>
References: <cover.1561429511.git.teroincn@163.com>
 <ffe1e2d44c08a0132bbd6686b11020ca20e77689.1561429511.git.teroincn@163.com>
In-Reply-To: <ffe1e2d44c08a0132bbd6686b11020ca20e77689.1561429511.git.teroincn@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0800373-f631-4162-c2a5-08d6f9314ab8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2781;
x-ms-traffictypediagnostic: MN2PR18MB2781:
x-microsoft-antispam-prvs: <MN2PR18MB2781FF0FF862910A97C7C985D2E30@MN2PR18MB2781.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(51914003)(199004)(189003)(305945005)(53546011)(102836004)(6506007)(73956011)(8936002)(81166006)(71190400001)(71200400001)(26005)(7736002)(68736007)(486006)(4326008)(478600001)(76176011)(66556008)(66476007)(66446008)(64756008)(81156014)(86362001)(186003)(2906002)(316002)(5660300002)(66066001)(66946007)(110136005)(99286004)(6436002)(446003)(6512007)(3846002)(36756003)(6486002)(8676002)(256004)(2616005)(476003)(91956017)(2501003)(14444005)(229853002)(76116006)(53936002)(6116002)(14454004)(6246003)(11346002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2781;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dXwmIpyY5wi+ywjdxH+lA1RPuASpjZToxEG8uu3lziVklCQQ2DyaTL6aoswBaMbRTUd58NASpIno/IxT5TBHVKyPqajrHfy9cW4I2B7cnQewyBPyC9qJL7fvFSwT7IyZCHJj++3grKwyfyuOZZJoRyTezW1zJob+NOYfSS+PCFc9syzajFhRGI/ytDqCKnIN1rJn+lpwMnxknOps6XFt8NagweXgFhhIYvh/2DVHX2UTioDaCwwnWMqamw52w9I2qXGOIQqdfN/McZr6BrEkDlgkmsRtXacNQjG+qEu1CoRTAFwlMfoxNMo09bwrzUBPMhzWLRt5C4hp8p9bYJOqtJ1E3uYAHWvlNfUh51Nr2gvVSCPYNCBnH9M9zz44AnAQhOZwujgc3LU0HVqrWFc+OWd1vtNYgLkvkRb4V0QrzZY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9A60ED32D5F6E478204BA03B15CC55B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e0800373-f631-4162-c2a5-08d6f9314ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 05:52:22.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skashyap@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2781
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_04:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Lin,

On 25/06/19, 8:05 AM, "Lin Yi" <teroincn@163.com> wrote:

>External Email
>
>----------------------------------------------------------------------
>if cb_arg alloc failed, we can't release the struct orig_io_req refcount
>before we take it's refcount. As Saurav said, move the srr_err label
>down to avoid unnecessary refcount release and nullptr free.
>
>Signed-off-by: Lin Yi <teroincn@163.com>
>---
>Changes in v2:
> -move the srr_err label down instead of moving kref_get.
>---
> drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c
>b/drivers/scsi/bnx2fc/bnx2fc_els.c
>index e33b94f..b807736 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
>@@ -654,7 +654,6 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req,
>u32 offset, u8 r_ctl)
> 	rc =3D bnx2fc_initiate_els(tgt, ELS_SRR, &srr, sizeof(srr),
> 				 bnx2fc_srr_compl, cb_arg,
> 				 r_a_tov);
>-srr_err:
> 	if (rc) {
> 		BNX2FC_IO_DBG(orig_io_req, "SRR failed - release\n");
> 		spin_lock_bh(&tgt->tgt_lock);
>@@ -664,6 +663,7 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req,
>u32 offset, u8 r_ctl)
> 	} else
> 		set_bit(BNX2FC_FLAG_SRR_SENT, &orig_io_req->req_flags);
>=20
>+srr_err:
> 	return rc;
> }
>=20
>--=20
>1.9.1

Thanks for the patch.

Asked-by: Saurav Kashyap <skashyap@marvell.com>
>
>

