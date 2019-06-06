Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4B378F9
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfFFPy6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 11:54:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34066 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729156AbfFFPy6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 11:54:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56FkSJm013037;
        Thu, 6 Jun 2019 08:54:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=AVAo017mwwVMlKjEJyK8TZQtsWkvs6EilmYNkbAKjhc=;
 b=yST7RHZXu2ui9TJKbMhmYRFvqqR/4Lboqk5F0hSGej2f6RRg3fKMsFkv8jhV3R2hvDZY
 39Qysxu+aOj86IFjOBG7CB8qZDNmomLWAYaOkGD01Gm81tbi0ifmq2S5mxB+TaVIyayT
 yghFeCvcYzUKVbLOgbjpDzZuf1aqVo90+jLEaOAXRCSSaZuwUEdKCDCdyPG+OOA79Oml
 df5J0yZilW/LN5MzFul4lbMrw8CiWP72lSSdhurhxpP9Zy+OltWqPkWoXCeeG3UVBIqL
 ePet6wtWy/WdRUNpsHHneISE+1otxp6udp3+zDuiwax7eCUTtyXHylqIBmxU2KpSjLde XA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sxwgnt4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 08:54:37 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 08:54:37 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Jun 2019 08:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVAo017mwwVMlKjEJyK8TZQtsWkvs6EilmYNkbAKjhc=;
 b=ovkCJ1Yg8MI09q4tJ4ZPBkH9tZby7jzb/5PmBIg5CdQlIPBFcmXCixYHBjpOPV17xf4fktoxbKKFR65JwgXrKCj2NbycycZYiQbyuBjLG6qLuM0gJ6Q35eDLLoJuXtUSEiWrqSxuzj6ue87ZJtqm8jadqwvGCiP8m1Q9DLT+aY8=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3245.namprd18.prod.outlook.com (10.255.237.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 15:54:31 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 15:54:31 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [EXT] [PATCH 00/20] qla2xxx Patches
Thread-Topic: [EXT] [PATCH 00/20] qla2xxx Patches
Thread-Index: AQHVHIAgjfuwF0jxgUWEznzr/Rf1nQ==
Date:   Thu, 6 Jun 2019 15:54:30 +0000
Message-ID: <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com>
References: <20190529202826.204499-1-bvanassche@acm.org>
 <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
 <yq1y32fo4d9.fsf@oracle.com>
In-Reply-To: <yq1y32fo4d9.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa7e8af1-aa8a-44bb-be33-08d6ea97436a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3245;
x-ms-traffictypediagnostic: MN2PR18MB3245:
x-microsoft-antispam-prvs: <MN2PR18MB3245ACCC8E13DA7E62B98592D6170@MN2PR18MB3245.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(51914003)(189003)(199004)(316002)(71190400001)(6486002)(71200400001)(83716004)(86362001)(36756003)(4744005)(14454004)(2616005)(11346002)(446003)(102836004)(68736007)(7736002)(6116002)(3846002)(486006)(2906002)(256004)(53546011)(476003)(305945005)(478600001)(6246003)(54906003)(53936002)(25786009)(26005)(229853002)(8676002)(6512007)(81156014)(81166006)(66556008)(6506007)(4326008)(66946007)(64756008)(66446008)(66476007)(8936002)(76176011)(186003)(66066001)(82746002)(6916009)(99286004)(33656002)(6436002)(76116006)(57306001)(91956017)(5660300002)(50226002)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3245;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tffcZigHBl9EKP/u6+ldrs+g3oUYX+ydnP0YCaEEvLYQK9sSRtY/wBORYnDo7rVy7NxoGPBEqn6nVV93TUzEduwTHrufLGutWdE4WEr0m7huIZBQOosHEg/zumCAaKG3rGQKSeMfzl0Sa4B/SDN7BcWmTMD+p+38O+83EqJxjQBqhKnVPSdbzQ4BGgx4D8Ochra7nFmNyNr2g8bWSAiEEa0JbozNESijn+7tA8iKvHszWdW4+rs+WILBLlWv342UlbkA0nj+RUbr0vCoaz88MI55MmtsJncEP7MPnj4j5anZCx/2weZs17IeXr3GYpMOXc0cYuSPIzX9ORHExZfar85hpvxk9LGOlCVXvQor8ELGLGu9fE7XMVe5/BLAe9urxBriVdhQN8jgFHwlu8Xv3mYvGetNMpSds1M113foIQE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62B54B4C1F634247869A458848E94B24@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e8af1-aa8a-44bb-be33-08d6ea97436a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:54:31.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3245
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_11:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,=20

> On Jun 5, 2019, at 7:05 PM, Martin K. Petersen <martin.petersen@oracle.co=
m> wrote:
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>=20
> Himanshu,
>=20
>> Thanks for the series. We will provide ACK after these patches have
>> gone through our internal testing.
>=20
> Ping on this series. Thanks!
>=20
> --=20
> Martin K. Petersen	Oracle Linux Engineering


Sorry for delay. I need bit more time. I will let my automation work thru w=
eekend=20
and will respond in early next week


Thanks,
Himanshu=
