Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86F24DDB6
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFTXVX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 19:21:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7318 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfFTXVW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Jun 2019 19:21:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KNKXwY031314;
        Thu, 20 Jun 2019 16:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Imzg9r2Txve2Y03Af4FuUuTrQVem2b9V3748B+Kn5XA=;
 b=yyBZ4gM0xq5eawF0AChxwYaZJ5+rKBq8NFf6r6KcCGQ/VH+6Yn/jhDeiGdLjmPjaWxtK
 NzoZE4x/vOUz9qAjmOpjteY0EmyMydwJJrM1d7axYtYWAfbzjDsQBtneLT2EOf3onbSS
 J86T9wcpiuLSW1fopkHgJo/Qpvpk0afDjEPTS8B3VVND7USYjQint/Afs0W0EG8gRfdd
 ysr5PZkUhmRIhidkKjton/axT9mAaGFCFpRkMYkPxAgL6RLl02f/R7PzVcxnnv/y7JWr
 5tkWAF8nBiz0xh/TZ3cxw8PSQtY/ILuFMNTMy0j+eqoX6KaNP6qK1cJG+Xk+1CEeFrk0 PA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t8cfk1nxa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 16:20:57 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 20 Jun
 2019 16:20:55 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 20 Jun 2019 16:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imzg9r2Txve2Y03Af4FuUuTrQVem2b9V3748B+Kn5XA=;
 b=s1B7utx2xaqe5ZzpKmT9KDmjeTvK2jJwR5UnX7M5U55OCNhDJ0nD2vWuhpdM2dz0LPSb8vLFlLDliN3O+5VCD19f8nrNs5L7P7nWLzUmlGFfYSgr1pVyF3Uwta31UeydhUoy7YviBtOTYflEv6nHYhsn+UFeUg0HGzai9frKBbE=
Received: from MWHPR18MB1488.namprd18.prod.outlook.com (10.175.7.135) by
 MWHPR18MB1118.namprd18.prod.outlook.com (10.173.126.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 23:20:52 +0000
Received: from MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::9034:6d9f:c17e:58dd]) by MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::9034:6d9f:c17e:58dd%2]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 23:20:52 +0000
From:   Quinn Tran <qutran@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race
 condition
Thread-Topic: [PATCH v2 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race
 condition
Thread-Index: AQHVJgFa3ZygApT7rkKbLvZn/sSCpKajcTSAgAFLCoA=
Date:   Thu, 20 Jun 2019 23:20:52 +0000
Message-ID: <788843F4-AF00-44DC-A649-1FF5E5876FBD@marvell.com>
References: <20190618181021.16547-1-hmadhani@marvell.com>
 <20190618181021.16547-4-hmadhani@marvell.com>
 <018503da-f39c-1583-87b3-af2b632432b5@acm.org>
In-Reply-To: <018503da-f39c-1583-87b3-af2b632432b5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.186.1.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 395f4b37-e388-495f-8f55-08d6f5d5f048
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR18MB1118;
x-ms-traffictypediagnostic: MWHPR18MB1118:
x-microsoft-antispam-prvs: <MWHPR18MB1118A366F29E264396572F3CD5E40@MWHPR18MB1118.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(64756008)(14454004)(110136005)(316002)(33656002)(4326008)(25786009)(478600001)(68736007)(2501003)(6246003)(66066001)(99286004)(6116002)(76176011)(3846002)(53936002)(102836004)(11346002)(81156014)(476003)(2906002)(305945005)(446003)(256004)(8936002)(53546011)(14444005)(81166006)(8676002)(91956017)(73956011)(6512007)(186003)(26005)(71190400001)(71200400001)(66946007)(6486002)(2201001)(5660300002)(6436002)(66556008)(2616005)(486006)(76116006)(66476007)(36756003)(229853002)(66446008)(86362001)(6506007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR18MB1118;H:MWHPR18MB1488.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /qnl+Qjf8r0Qitzdt1cSTaY+0zzp9ne8WT9ohLt9Pd/ahW6Wpxg/1tOrsXf4aDE6lpTzqLOrUtLYO1gAH7ReO+Q+w2fQl6z/m0NRJuFLmWMfKRQ6XK9C3r3Jqg1e+mbDzGFUH3saoLEQWPWX8EL39xrTfCRKSPH6Zr19lcRAMZRP2attCpMaz4buUHr/mdDcVWsvwGTKEhvq/2OzC16zxZh5Z/YiVxh7DWkp1rUNi9P//BJ6gYFWgKeMTZmLcL94yAEcQPHHScSAZf1g/PFYHRokeCNAt9uEs6WfsUrZSs/BR7HrQY239XDjUoPRo25+x8jjavLj6zd6hPCeaEUktlOrKNLjc9RlTbXhvYZSOTOijlRHR/ALR2sko1RGaKEK7QnEdFmDtqB+d57bJ1BJmt5N+9Xn6Yf0oapYP2nzYsI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC220C79053CA245BC87360C31413CA3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 395f4b37-e388-495f-8f55-08d6f5d5f048
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 23:20:52.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qutran@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1118
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QmFydCwNCg0KWWVzLiBJdCBkb2VzIG1ha2Ugc2Vuc2UgdG8gY29tYmluZSBTUkIgaW50byBudm1l
X3ByaXZhdGUvc2NzaV9jbW5kIHByaXZhdGUuICBUaGF0J3MgaXMgYSBsYXJnZXIgZGlzY3Vzc2lv
biB0aGF0IHJlcXVpcmUgb3VyIHRlYW0gdG8gYnV5IGluICsgdGVzdCBlZmZvcnQuICBXZSBhcmUg
YWN0aXZlbHkgZGlzY3Vzc2luZyB0aGlzIHN1YmplY3QuIA0KDQpJbiB0aGUgbWVhbiB0aW1lLCB3
ZSBsaWtlIG90aGVyIE5WTUUgdXNlcnMgdG8gbm90IHJ1biBpbnRvIHRoaXMgY3Jhc2ggdW50aWwg
dGhlIG5leHQgc3VibWlzc2lvbiB3aW5kb3cuDQoNClJlZ2FyZHMsDQpRdWlubiBUcmFuIA0KDQrv
u79PbiA2LzE5LzE5LCAxOjM2IFBNLCAibGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIEJhcnQgVmFuIEFzc2NoZSIgPGxpbnV4LXNjc2ktb3duZXJAdmdlci5rZXJu
ZWwub3JnIG9uIGJlaGFsZiBvZiBidmFuYXNzY2hlQGFjbS5vcmc+IHdyb3RlOg0KDQogICAgT24g
Ni8xOC8xOSAxMToxMCBBTSwgSGltYW5zaHUgTWFkaGFuaSB3cm90ZToNCiAgICA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5oIGIvZHJpdmVycy9zY3NpL3FsYTJ4
eHgvcWxhX252bWUuaA0KICAgID4gaW5kZXggMmQwODhhZGQ3MDExLi42N2JiNGEyYTM3NDIgMTAw
NjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5oDQogICAgPiAr
KysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5oDQogICAgPiBAQCAtMzQsNiArMzQs
NyBAQCBzdHJ1Y3QgbnZtZV9wcml2YXRlIHsNCiAgICA+ICAgCXN0cnVjdCB3b3JrX3N0cnVjdCBs
c193b3JrOw0KICAgID4gICAJc3RydWN0IHdvcmtfc3RydWN0IGFib3J0X3dvcms7DQogICAgPiAg
IAlpbnQgY29tcF9zdGF0dXM7DQogICAgPiArCXNwaW5sb2NrX3QgY21kX2xvY2s7DQogICAgPiAg
IH07DQogICAgDQogICAgSGkgSGltYW5zaHUgYW5kIFF1aW5uLA0KICAgIA0KICAgICBGcm9tIHRo
ZSBxbGEyeHh4IGRyaXZlcjoNCiAgICANCiAgICBzdGF0aWMgc3RydWN0IG52bWVfZmNfcG9ydF90
ZW1wbGF0ZSBxbGFfbnZtZV9mY190cmFuc3BvcnQgPSB7DQogICAgCVsgLi4uIF0NCiAgICAJLmxz
cnFzdF9wcml2X3N6ID0gc2l6ZW9mKHN0cnVjdCBudm1lX3ByaXZhdGUpLA0KICAgIAkuZmNwcnFz
dF9wcml2X3N6ID0gc2l6ZW9mKHN0cnVjdCBudm1lX3ByaXZhdGUpLA0KICAgIH07DQogICAgWyAu
Li4gXQ0KICAgIHN0cnVjdCBudm1lX3ByaXZhdGUgew0KICAgIAlzdHJ1Y3Qgc3JiCSpzcDsNCiAg
ICAJc3RydWN0IG52bWVmY19sc19yZXEgKmZkOw0KICAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QgbHNf
d29yazsNCiAgICAJc3RydWN0IHdvcmtfc3RydWN0IGFib3J0X3dvcms7DQogICAgCWludCBjb21w
X3N0YXR1czsNCiAgICB9Ow0KICAgIA0KICAgIEhhcyBpdCBiZWVuIGNvbnNpZGVyZWQgdG8gY2hh
bmdlICJzdHJ1Y3Qgc3JiICpzcCIgaW50byAic3RydWN0IHNyYiBzcmIiPyANCiAgICBUaGF0IHdv
dWxkIGd1YXJhbnRlZSB0aGF0IHRoZSBzcmIgYW5kIG52bWVfcHJpdmF0ZSBkYXRhIHN0cnVjdHVy
ZXMgaGF2ZSANCiAgICB0aGUgc2FtZSBsaWZldGltZS4gQXMgYSByZXN1bHQgdXNpbmcgdGhlIHNy
YiByZWZlcmVuY2UgY291bnQgd291bGQgbm8gDQogICAgbG9uZ2VyIGJlIG5lY2Vzc2FyeSBmb3Ig
TlZNZSBhbmQgbm8gbmV3IGxvY2tpbmcgd291bGQgaGF2ZSB0byBiZSANCiAgICBpbnRyb2R1Y2Vk
IGluIHRoZSBOVk1lLUZDIGNvbXBsZXRpb24gcGF0aHMuDQogICAgDQogICAgSSB0aGluayBhIHNp
bWlsYXIgYXBwcm9hY2ggaXMgcG9zc2libGUgZm9yIHRoZSBTQ1NJLUZDIGNvZGUuDQogICAgDQog
ICAgRG9lcyB0aGlzIG1ha2Ugc2Vuc2UgdG8geW91Pw0KICAgIA0KICAgIFRoYW5rcywNCiAgICAN
CiAgICBCYXJ0Lg0KICAgIA0KDQo=
