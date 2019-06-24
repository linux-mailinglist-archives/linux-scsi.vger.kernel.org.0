Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8168850510
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfFXJDB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 05:03:01 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7662 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbfFXJDA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 05:03:00 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O91bKi018254;
        Mon, 24 Jun 2019 02:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=JbT9Y2Xlz5O+YqKqe87VQn8LXedd2rbu7t8vBtSiUfY=;
 b=PoSJfsOaimzZ+eNfsrRv5JCxmQMXQnEkvD/sSK1vPRLaP/OoKNHIjtDxLuehfuZ36rCX
 Pv/kKXtQ5rMHQpAllHFm5Q6UX3PYn2ZkG5zRDMjBasWMDR7cpESTY27XBvZ0kDED0jJv
 bSWfqaStbGmr1EUv7wfcswPYfQkNMs/MfE1bgkZz9PHEDDqljQJd/RsgoI00Ap99a284
 DJjqUBydxKfGYVB4UBa76+gBTfPEBA4fJF98zA16t1FcK9L0HhcHt2J2E0gM6vzFG58x
 wsQInv+TygrySulEJaiEItE2neGBq7IvuBeRHiT82Wzcg9WNVzl+/ZRZOEhUQnsgn7JV 1g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kuje08p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 02:02:49 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 02:02:46 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 02:02:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbT9Y2Xlz5O+YqKqe87VQn8LXedd2rbu7t8vBtSiUfY=;
 b=Zxv+wAbnhlcoZk9m0lndmEbXG3kRRK4YISnE9eD3fOrpn2y/xb4/5yYY5aKzD3VAkUUJf/HggAKqcbo9lG+0I7jpA2YwlpNKwjneJ+8VboD4mKbKTUDg3DFKf/zL5XK+OcterVfbi9+1Nu+NHuWW1iPEB1zGrGIXpR3pSQRaZpA=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB3423.namprd18.prod.outlook.com (10.255.239.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:02:45 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:02:45 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Lin Yi <teroincn@163.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "liujian6@iie.ac.cn" <liujian6@iie.ac.cn>,
        "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        "yiqiuping@gmail.com" <yiqiuping@gmail.com>
Subject: Re: [PATCH 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_srr
Thread-Topic: [PATCH 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_srr
Thread-Index: AQHVKWczALuIphnQzUCd5TB/YMoCu6aq4IcA
Date:   Mon, 24 Jun 2019 09:02:45 +0000
Message-ID: <D9368F19.190B1%skashyap@marvell.com>
References: <cover.1561254730.git.teroincn@163.com>
 <a5e2a774fe72c62d9a28f101adb41a3600dc3951.1561254730.git.teroincn@163.com>
In-Reply-To: <a5e2a774fe72c62d9a28f101adb41a3600dc3951.1561254730.git.teroincn@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a073909-9b6c-4f36-8dc6-08d6f882b92e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3423;
x-ms-traffictypediagnostic: MN2PR18MB3423:
x-microsoft-antispam-prvs: <MN2PR18MB34230C437DA4D233D7BFA514D2E00@MN2PR18MB3423.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39850400004)(346002)(396003)(189003)(199004)(51914003)(7736002)(5660300002)(71190400001)(66066001)(71200400001)(86362001)(2906002)(316002)(68736007)(110136005)(478600001)(2501003)(54906003)(6512007)(81156014)(6486002)(81166006)(8676002)(186003)(8936002)(6506007)(53936002)(26005)(305945005)(6436002)(76116006)(66556008)(11346002)(66476007)(64756008)(446003)(66446008)(2616005)(486006)(476003)(91956017)(73956011)(14444005)(256004)(99286004)(25786009)(36756003)(6246003)(4326008)(14454004)(76176011)(6116002)(3846002)(229853002)(53546011)(102836004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3423;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EceD+m8D07d4m8gWrv98gToCDnBFs5w6LvXcJsk+kRHsZ8zfIAjcGf/Z3CMf3lGwisb/tNh0TfUwo0yaWo79iM08du+KsJIn8rPmULiUmEz7polmaDZEdl8/4iRD4VqEEl92KhKDdZHRN/PICpmXOerDAE2piNHC4fOTZCXwm0gZzlNeVI1x3toiqRn+evEidB3E86UYKf6WklHcjla75FDRO343ZMWNwT9kjF0KXOWKaNCdx7QR+v8f7krRu5nlH84AuybxN5MsdwlRCHX3tdDaybeMlhVb6g3mCKKSI7Au0XhcmRHz/P90IEsjUMw+Q/10RGvvN5XgphnFm+qVz2lWrPbiPh5kHPWL/eJOVfMxnxyLG+231geqjShW5fBLLQlH5PsYf114vjiaks4e3hkuQv2mlJMq6J/9jbaSpzw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9613CB582B4F704396FD1987E7766953@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a073909-9b6c-4f36-8dc6-08d6f882b92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:02:45.4487
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


On 23/06/19, 7:28 AM, "linux-scsi-owner@vger.kernel.org on behalf of Lin
Yi" <linux-scsi-owner@vger.kernel.org on behalf of teroincn@163.com> wrote:

>if cb_arg alloc failed, we can't release orig_io_req refcount before
>we take it's refcount. call kref_get before malloc, so as to pair with
>the kref_put on the srr_err path.
>
>Signed-off-by: Lin Yi <teroincn@163.com>
>---
> drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c
>b/drivers/scsi/bnx2fc/bnx2fc_els.c
>index 709bb92..c201ddf 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
>@@ -633,13 +633,13 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req,
>u32 offset, u8 r_ctl)
> 	BNX2FC_IO_DBG(orig_io_req, "Sending SRR\n");
> 	memset(&srr, 0, sizeof(srr));
>=20
>+	kref_get(&orig_io_req->refcount);
> 	cb_arg =3D kzalloc(sizeof(struct bnx2fc_els_cb_arg), GFP_ATOMIC);
> 	if (!cb_arg) {
> 		printk(KERN_ERR PFX "Unable to allocate cb_arg for SRR\n");
> 		rc =3D -ENOMEM;
> 		goto srr_err;
> 	}
>-	kref_get(&orig_io_req->refcount);
>=20
> 	cb_arg->aborted_io_req =3D orig_io_req;
>=20
>--=20
>1.9.1

Thanks for the patch, but this is not the correct fix. If kzalloc fails,
control will reach label srr_err and try to free cb_arg.
Correct fix is to move the srr_err label down.

@@ -680,7 +680,6 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req,
u32 offset, u8 r_ctl)
        rc =3D bnx2fc_initiate_els(tgt, ELS_SRR, &srr, sizeof(srr),
                                 bnx2fc_srr_compl, cb_arg,
                                 r_a_tov);
-srr_err:
        if (rc) {
                BNX2FC_IO_DBG(orig_io_req, "SRR failed - release\n");
                spin_lock_bh(&tgt->tgt_lock);
@@ -690,6 +689,7 @@ srr_err:
        } else
                set_bit(BNX2FC_FLAG_SRR_SENT, &orig_io_req->req_flags);
=20
+srr_err:
        return rc;
 }

Submit an update patch.

Thanks,
~Saurav


>

