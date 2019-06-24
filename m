Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE850506
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfFXJBR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 05:01:17 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35142 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfFXJBR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 05:01:17 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8pAR0009828;
        Mon, 24 Jun 2019 02:00:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rWALocp2aHcM30umtShLHzYz+XwwB5AKJ0CRvIKVwT4=;
 b=Q3c/KIPyv8G+vD5frjQBh+ypBoOydFosahPgAEcRdSXQjUzCX5kOcLAdK/MRdmeNDHPb
 1/phjATgfnc9w4Z+YZPTKZhsSszcQBX0oaBcGoNU21UOpllMNGZmC0kOLY0sUF4i3zeg
 y83J2EPqxYmsEhAS2UzJktqtMyXWlw8J/Bu83+DEhhcRd8Z1qlR89T9GAhts79f+NSd/
 fPalRYy8Bl3Kgy5QiHIuICW8qxPJ3rINeMktNK3eQ+kRbD4s04nQOqlvjONQeXwGuiAj
 qmIxjj6WXHw7GlByCQ0GfVxQLKNF8wN+XdUqcoLeElV+VULbWg/L+W3ubsjNCeQMf4Ak SA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kuje00a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 02:00:54 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 02:00:53 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 02:00:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWALocp2aHcM30umtShLHzYz+XwwB5AKJ0CRvIKVwT4=;
 b=qtqAF0kM0ZcNAEoHFG8ZDJt6fGLK/HWw5AnHwUO/vERqF78B/Vn4DKTTAZIuhXWLKQ9mGg521hWss6NA+Tdu76gHPI/hMBb6wjnY7ivaA5TjiKpxGjSD79unVkJ4V+os5u8zKyal9hEgc20rpsqBgB1/i0FZC6ev3OZeYaNiOnM=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB3423.namprd18.prod.outlook.com (10.255.239.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:00:51 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:00:51 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Lin Yi <teroincn@163.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "liujian6@iie.ac.cn" <liujian6@iie.ac.cn>,
        "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        "yiqiuping@gmail.com" <yiqiuping@gmail.com>
Subject: Re: [PATCH 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_rec
Thread-Topic: [PATCH 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_rec
Thread-Index: AQHVKWcKFnmQPdEdz0+Vr/m90vDfH6aq3/6A
Date:   Mon, 24 Jun 2019 09:00:51 +0000
Message-ID: <D9368E70.190AA%skashyap@marvell.com>
References: <cover.1561254730.git.teroincn@163.com>
 <54a23cc9ea9ad2b7919ef5cec8a70ef18886d644.1561254730.git.teroincn@163.com>
In-Reply-To: <54a23cc9ea9ad2b7919ef5cec8a70ef18886d644.1561254730.git.teroincn@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f811b53-d84d-49cc-90eb-08d6f8827530
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3423;
x-ms-traffictypediagnostic: MN2PR18MB3423:
x-microsoft-antispam-prvs: <MN2PR18MB34233DFFDAA4247F8C73A688D2E00@MN2PR18MB3423.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39850400004)(346002)(396003)(189003)(199004)(51914003)(7736002)(5660300002)(71190400001)(66066001)(71200400001)(86362001)(2906002)(316002)(68736007)(110136005)(478600001)(2501003)(54906003)(6512007)(81156014)(6486002)(81166006)(8676002)(186003)(8936002)(6506007)(53936002)(26005)(305945005)(6436002)(76116006)(66556008)(11346002)(66476007)(64756008)(446003)(66446008)(2616005)(486006)(476003)(91956017)(73956011)(14444005)(256004)(99286004)(25786009)(36756003)(6246003)(4326008)(14454004)(76176011)(6116002)(3846002)(229853002)(53546011)(102836004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3423;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ELhyrW3RvAxBRBsvFyendWURplpyHjFgl6cnmTZpz7d0uVaHApEzVb5XUzI5qqiGzq6pITWIRclnuqVCBRn+HAhPMc+uR1dirGPHF5jPnBI+Gu0orvHtNnu3M6UiDo/G+PDUU/rfX+pY18lO3UzVwqgUIw3mHsueMywlpwj00vEDseCuu4sd0saM9dB4qChW+5Se0DOwd1i0zzW+StwHMg+CUc+z2VS5XV2X6FcBQeQAAu6DsjnexE/AyaxKKKnyIDoBph/s/rnaPYSAfFTE4vUud5s4BBm+10Anm4xoCXaNfoZ4zGpg8hU6Y0Xl1k9aDLcOLlLHYl0FVtO+achl48OhvrLVGx8Mg3hsB0sMbLfcVumG1qzsUGGg/kLkUx6VA/HuOR+9EHam3SSK+c6opI6MhzSiZD7f+ZnHv+LuWKA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0726261E763FB44382E27BF322AD7A62@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f811b53-d84d-49cc-90eb-08d6f8827530
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:00:51.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skashyap@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3423
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_07:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Lin,

On 23/06/19, 7:27 AM, "linux-scsi-owner@vger.kernel.org on behalf of Lin
Yi" <linux-scsi-owner@vger.kernel.org on behalf of teroincn@163.com> wrote:

>if cb_arg alloc failed, we can't release the struct orig_io_req refcount
>before we take it's refcount. call kref_get before malloc, so as to pair
>with kref_put on rec_err path.
>
>Signed-off-by: Lin Yi <teroincn@163.com>
>---
> drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c
>b/drivers/scsi/bnx2fc/bnx2fc_els.c
>index 76e65a3..709bb92 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
>@@ -592,13 +592,13 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
> 	BNX2FC_IO_DBG(orig_io_req, "Sending REC\n");
> 	memset(&rec, 0, sizeof(rec));
>=20
>+	kref_get(&orig_io_req->refcount);
> 	cb_arg =3D kzalloc(sizeof(struct bnx2fc_els_cb_arg), GFP_ATOMIC);
> 	if (!cb_arg) {
> 		printk(KERN_ERR PFX "Unable to allocate cb_arg for REC\n");
> 		rc =3D -ENOMEM;
> 		goto rec_err;
> 	}
>-	kref_get(&orig_io_req->refcount);
>=20
> 	cb_arg->aborted_io_req =3D orig_io_req;
>=20
>--=20
>1.9.1

Thanks for the patch, but this is not the correct fix. If kzalloc fails
code will go to rec_err and try to free cb_arg as well.
Correct way is to move the rec_err label down.

diff --git a/bnx2fc/driver/bnx2fc_els.c b/bnx2fc/driver/bnx2fc_els.c
index 2287008..1b816af 100644
--- a/bnx2fc/driver/bnx2fc_els.c
+++ b/bnx2fc/driver/bnx2fc_els.c
@@ -635,7 +635,6 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
        rc =3D bnx2fc_initiate_els(tgt, ELS_REC, &rec, sizeof(rec),
                                 bnx2fc_rec_compl, cb_arg,
                                 r_a_tov);
-rec_err:
        if (rc) {
                BNX2FC_IO_DBG(orig_io_req, "REC failed - release\n");
                spin_lock_bh(&tgt->tgt_lock);
@@ -643,6 +642,7 @@ rec_err:
                spin_unlock_bh(&tgt->tgt_lock);
                kfree(cb_arg);
        }
+rec_err:
        return rc;
 }

Kindly submit the updated patch.

Thanks,
~Saurav

>

