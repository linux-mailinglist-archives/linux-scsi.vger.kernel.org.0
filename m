Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBF52324
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfFYFvw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 01:51:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38876 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727648AbfFYFvv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Jun 2019 01:51:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P5oQop013591;
        Mon, 24 Jun 2019 22:51:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=euQb5x+o6jD2ItniGYbceCHW9cmWEW3Ob2APF0SSkTQ=;
 b=G/iOcP/MQbQBSShOtIHmM1KOToT5+fjh35lEBJ6oPGdAJ3MTvmYd18VzQwSok4Vtt5Ch
 AreoXROUfKKsX6rB9PSKMq96zF1HP4BMrGRvGGMEL89ABfYxmdxykOvTFtITgNvLzHgX
 Hu1VhL2pF0Nvfv6vbqlL0ezortAS6zNXOkpkg/LRuBjcMh8lCkezuHAP4hMVkLSsBxUk
 BoVtTUe/BZkGHZjsYmPZz3auwxsECE89zxq0rpZVbVwW60f0sd7g2trq9Kl/Rs8RIkee
 YzmAG5hg6bXfHHVHOyrM4heyMgsBVujf+jQD1IK2MScLNZgJYY9iaycgquTcrI5lxi4c lw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tbcudr5mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 22:51:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 22:51:43 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 22:51:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euQb5x+o6jD2ItniGYbceCHW9cmWEW3Ob2APF0SSkTQ=;
 b=s5gI4Z3OnyZ8E0tSfjrra4oA6zw6gACdyy3K8SZ2r/iG3n3pCGXJanMgZQWK2i1gFRxOGhnV/tINY0wLrIjQEcluSh4Q+G5EA/+e9/IJEJbQAQVW+LxEsFvbA6b4LHWPWJhQfOVlI62AMmt4WfhnklGHAuZc1frrv40fxAXQC3k=
Received: from MN2PR18MB2527.namprd18.prod.outlook.com (20.179.82.202) by
 MN2PR18MB2781.namprd18.prod.outlook.com (20.179.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 05:51:41 +0000
Received: from MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4]) by MN2PR18MB2527.namprd18.prod.outlook.com
 ([fe80::7084:6d4b:c3cf:28b4%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 05:51:41 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Lin Yi <teroincn@163.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] [PATCH v2 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd
 refcount imbalance in send_rec
Thread-Topic: [EXT] [PATCH v2 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd
 refcount imbalance in send_rec
Thread-Index: AQHVKv6Ch9LnPr2TEkuGxnf8Z5R766asOkKA
Date:   Tue, 25 Jun 2019 05:51:40 +0000
Message-ID: <D937B417.1911D%skashyap@marvell.com>
References: <cover.1561429511.git.teroincn@163.com>
 <c0bd1183bc048eeb29f66e71bfac03fc3f6db222.1561429511.git.teroincn@163.com>
In-Reply-To: <c0bd1183bc048eeb29f66e71bfac03fc3f6db222.1561429511.git.teroincn@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87f76f60-64cf-41aa-4d27-08d6f931324a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2781;
x-ms-traffictypediagnostic: MN2PR18MB2781:
x-microsoft-antispam-prvs: <MN2PR18MB2781F4FF81762DDF19E0C303D2E30@MN2PR18MB2781.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(51914003)(199004)(189003)(305945005)(53546011)(102836004)(6506007)(73956011)(8936002)(81166006)(71190400001)(71200400001)(26005)(7736002)(68736007)(486006)(4326008)(478600001)(76176011)(66556008)(66476007)(66446008)(64756008)(81156014)(86362001)(186003)(2906002)(316002)(5660300002)(66066001)(66946007)(110136005)(99286004)(6436002)(446003)(6512007)(3846002)(36756003)(6486002)(8676002)(256004)(2616005)(476003)(91956017)(2501003)(14444005)(229853002)(76116006)(53936002)(6116002)(14454004)(6246003)(11346002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2781;H:MN2PR18MB2527.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s2kvowdjqFJu3Gkt+PQCRDWfAOzdgZyGcOyWS5tpJRod2gdlhpAwcq97wwq4pC/6dHbKdf87S/s2GmcTrHCpzPNllqIpQ5BC1ld0Fe8Yar5BoRLsOLYnRNgJkkCjyPeLW7BuuoUbgS3G90FZKxsehwIaBHZlU1xRnrXK2L2NJnxzYBh0s6gNaUn8ACMckM01mg273ewYG6I70W6jrBT6LN/w6tnX5uJ3nh/ByMp52BkoIOKjcPEwDplmk9T9m80J5DQeJFIbDUdl1y29QvtjIXxfTAiSli9VQy4qzs2T5FXn9Zv71CQJastAsfdX/1G3BYhOop7VJsqm1KyARTahyAyOjDaehJ+kNA3sG+MFLj3UEE/TKqV0J7xAK8UbZKG2i2quJ9eIDnhiCv4nZWVSlMlUcFwA8e54vvI0bZ4rXXM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <781C950585461C46BEA8D705D3841F62@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f76f60-64cf-41aa-4d27-08d6f931324a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 05:51:41.0258
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

On 25/06/19, 8:04 AM, "Lin Yi" <teroincn@163.com> wrote:

>External Email
>
>----------------------------------------------------------------------
>if cb_arg alloc failed, we can't release the struct orig_io_req refcount
>before we take it's refcount. As Saurav said, move the rec_err label down
>to avoid
>unnecessary refcount release and nullptr free.
>
>Signed-off-by: Lin Yi <teroincn@163.com>
>---
>Changes in v2:
>  - move the rec_err label down instead of moving kref_get.
>---
>---
> drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c
>b/drivers/scsi/bnx2fc/bnx2fc_els.c
>index 76e65a3..e33b94f 100644
>--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
>+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
>@@ -610,7 +610,6 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
> 	rc =3D bnx2fc_initiate_els(tgt, ELS_REC, &rec, sizeof(rec),
> 				 bnx2fc_rec_compl, cb_arg,
> 				 r_a_tov);
>-rec_err:
> 	if (rc) {
> 		BNX2FC_IO_DBG(orig_io_req, "REC failed - release\n");
> 		spin_lock_bh(&tgt->tgt_lock);
>@@ -618,6 +617,7 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
> 		spin_unlock_bh(&tgt->tgt_lock);
> 		kfree(cb_arg);
> 	}
>+rec_err:
> 	return rc;
> }
>=20
>--=20
>1.9.1

Thanks for the patch.

Acked-by: Saurav Kashyap <skashyap@marvell.com>
>
>

