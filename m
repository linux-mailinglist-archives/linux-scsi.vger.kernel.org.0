Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1952F567
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 06:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbfE3ErD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 00:47:03 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38724 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729057AbfE3ErC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 00:47:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4U4itYT029757;
        Wed, 29 May 2019 21:46:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=j/wfGcA9I2hFZAh/3Zm7kJaFbpgaCJwGJO/IjOQCRLo=;
 b=lr6WYOlDN+FJKDj1BTGO+Cmbu9K+LDE3BjIkoF+dkWq2gVsDHFcSBqvKcbq1v+g8Ecz7
 hQ2LY6KYFHOpucqxOL7oxdKmnkkhAfCpiikBggUAUa9XkIo9QA7mF1RIWR/n2WpT7QgW
 em4kvO4pNqHK6GNATBHVfvPhh8p55vaP5Gp0A7OgXOyqarA54OK083XpmznW4Emm83tL
 Pinjwse9xR8B1bqo1djleplDU52zMlVcqFicT0XnqwZ5PI8cpKhWRVOqEbF4SPZ5HXKR
 SQCIwHJHI4xnQGY/9369zkXlOWLKbfkVN8zEbyi1Ns2XHfP2wvYodbqzb8pWRHdhqOrg LA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2st4488yg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 21:46:57 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 21:46:55 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 21:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/wfGcA9I2hFZAh/3Zm7kJaFbpgaCJwGJO/IjOQCRLo=;
 b=KAbHzrGxqzk1xdt/gvSg/qpUpFTAhpuz91zC/7nWI9CD9OeCV/lgS1Y6zeKDaX5prsh6h/KVWkV4J66Sw7A2AglG/3exq/P0BMCIXfgKtr1RTkt8HizQGuh8Ja8MWisXX68y6RynOr5LMLMj6iw4dxP/8fPfWD2yBl5DuwPHgD8=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3325.namprd18.prod.outlook.com (10.255.238.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 30 May 2019 04:46:53 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1922.024; Thu, 30 May 2019
 04:46:53 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Enzo Matsumiya <ematsumiya@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] qla2xxx: remove double assignment in
 qla2x00_update_fcport
Thread-Topic: [EXT] Re: [PATCH] qla2xxx: remove double assignment in
 qla2x00_update_fcport
Thread-Index: AQHVBOsJTjXawkuw70Ove8nSpNu5G6aDFMWo//+xboA=
Date:   Thu, 30 May 2019 04:46:52 +0000
Message-ID: <90C8089C-F5F2-4E33-8DEB-A0B05500A072@marvell.com>
References: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de>
 <yq11s0gy8v3.fsf@oracle.com>
In-Reply-To: <yq11s0gy8v3.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ae4443c-d4cb-4cb6-9aca-08d6e4b9d636
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3325;
x-ms-traffictypediagnostic: MN2PR18MB3325:
x-microsoft-antispam-prvs: <MN2PR18MB332595A65C7A3D1D34242A2CD6180@MN2PR18MB3325.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(478600001)(256004)(14444005)(316002)(76176011)(66446008)(6512007)(3846002)(6116002)(6506007)(6246003)(86362001)(99286004)(4326008)(53936002)(82746002)(66066001)(476003)(54906003)(6486002)(36756003)(486006)(8936002)(2906002)(33656002)(25786009)(68736007)(5660300002)(2616005)(81156014)(186003)(76116006)(66946007)(102836004)(8676002)(66476007)(66556008)(64756008)(81166006)(14454004)(83716004)(71200400001)(446003)(4744005)(11346002)(7736002)(229853002)(6916009)(73956011)(26005)(71190400001)(6436002)(91956017)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3325;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sWCBOPTD+5xVrbzgBTaZFDA9yKVIjDGAhCdLBHEHMlQW8a41tuDSOrjY6Z/TdYeFbRoi2GP2nED7Tow6kZ9gLXI7ubjjclr1tNMN12Lt7m8+pMFPyv2rB3aDfRInMrYcrP7SiREAFJK2lagpC9Psp6ywP5oMkokxWTOjxgGASpXAUz3bahFgGaHg8Ci0rOzZmcnoyHoBKt77tBl5nKtOe0Aym/q8BX3Luu8ATDcHYMYFiIUgQX2YGPoObgH9BPD/EQ3EAy0FWsXnbCLLgbEfIOMR1Bfef1pzHAojWzF26ZpiHXfKUCmD4jDlR963IAw41W0f9fJWKUq9T9NB6MMk9unOz9iMFwNoexpUB4hRK5UXlw37JLZb7ljiDESntc+WfYIpIAXeCuTudN+DRw5vkyj7vbFMTNnzDx3ZpYlRiC4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03D61DC056AB4E4BA6CEE58C00BF9974@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae4443c-d4cb-4cb6-9aca-08d6e4b9d636
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 04:46:52.6603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3325
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_03:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQoNCu+7v09uIDUvMjkvMTksIDc6MjggUE0sICJNYXJ0aW4gSy4gUGV0ZXJzZW4iIDxtYXJ0aW4u
cGV0ZXJzZW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQoNCiAgICBFeHRlcm5hbCBFbWFpbA0KICAgIA0K
ICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCiAgICANCiAgICBIaW1hbnNodT8NCiAgICANCiAgICA+IFJlbW92
ZSBkb3VibGUgYXNzaWdubWVudCBpbiBxbGEyeDAwX3VwZGF0ZV9mY3BvcnQoKS4NCiAgICA+DQog
ICAgPiBTaWduZWQtb2ZmLWJ5OiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPg0K
ICAgID4gLS0tDQogICAgPiAgZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2luaXQuYyB8IDEgLQ0K
ICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQogICAgPg0KICAgID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pbml0LmMNCiAgICA+IGIvZHJpdmVycy9z
Y3NpL3FsYTJ4eHgvcWxhX2luaXQuYw0KICAgID4gaW5kZXggMGM3MDBiMTQwY2U3Li4xODA3OGUy
MTU0NjYgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW5pdC5j
DQogICAgPiArKysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW5pdC5jDQogICAgPiBAQCAt
NTIzNyw3ICs1MjM3LDYgQEAgcWxhMngwMF91cGRhdGVfZmNwb3J0KHNjc2lfcWxhX2hvc3RfdCAq
dmhhLA0KICAgID4gZmNfcG9ydF90ICpmY3BvcnQpDQogICAgPiAgICAgICAgIGZjcG9ydC0+Zmxh
Z3MgJj0gfihGQ0ZfTE9HSU5fTkVFREVEIHwgRkNGX0FTWU5DX1NFTlQpOw0KICAgID4gICAgICAg
ICBmY3BvcnQtPmRlbGV0ZWQgPSAwOw0KICAgID4gICAgICAgICBmY3BvcnQtPmxvZ291dF9vbl9k
ZWxldGUgPSAxOw0KICAgID4gLSAgICAgICBmY3BvcnQtPmxvZ2luX3JldHJ5ID0gdmhhLT5ody0+
bG9naW5fcmV0cnlfY291bnQ7DQogICAgPiAgICAgICAgIGZjcG9ydC0+bjJuX2NoaXBfcmVzZXQg
PSBmY3BvcnQtPm4ybl9saW5rX3Jlc2V0X2NudCA9IDA7DQogICAgPg0KICAgID4gICAgICAgICBz
d2l0Y2ggKHZoYS0+aHctPmN1cnJlbnRfdG9wb2xvZ3kpIHsNCiAgICA+IC0tDQogICAgPiAyLjEy
LjMNCiAgICA+DQogICAgPg0KICAgIA0KICAgIC0tIA0KICAgIE1hcnRpbiBLLiBQZXRlcnNlbglP
cmFjbGUgTGludXggRW5naW5lZXJpbmcNCiAgICANCg0KU29ycnkgZm9yIGRlbGF5LiAgIExvb2tz
IGdvb2QuIA0KDQpBY2tlZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aG1hZGhhbmlAbWFydmVsbC5j
b20+DQoNCg0K
