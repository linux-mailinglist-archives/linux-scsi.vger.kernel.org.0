Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6646C94
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Jun 2019 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFNW6U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 18:58:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36680 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfFNW6U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 18:58:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMtFMY000604;
        Fri, 14 Jun 2019 15:58:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=sQ3MSB3kRfqz8Uq049q49NXs8GsAXrzi7Ye2ide7LBI=;
 b=I6KpEP1fGXcbdzxNbYEHyh0JuMWjWT/5DInD7VjuQhR59MrMYpMod+bdfVvl1BoBgWVa
 ZOK75aPpPRMFbn9mzeQlxXMPQoVcbVAITXPuslXdMQ4pIqjUdhBiSew8Xio1Iz7+Ml86
 GmJKJ9vaupOGCr573c1vhsr52pOCz0z/GdunX+lgPht+Oz+yV11lRArWc+LUsbLslzlu
 5M52Yo/OnJr98z0HVVvQtwSVXuqCPmR3J0mqdhWevn+8/cgnyYkA56pV7Er+QPWSmShd
 FNVhZRpA0p2Q/YfmYyZrHefY2Kbu1QqzD7B9b87iz9ciuZXUJaX8epdj7LOaAGtMFdDr qw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t4gx3ru9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:58:06 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 15:58:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 15:58:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ3MSB3kRfqz8Uq049q49NXs8GsAXrzi7Ye2ide7LBI=;
 b=NNI0N75nQJMVb0eeaQlbsSM33MSL4IcQNOnTmmqh/bPwlhTB19l6bTsdDzl/k/JsMAaawguha6ha/L3OrrtvzF8tpv++5wjKyGruaL0+B5n/hS+Bg7NOEWHy4QT0AC8vEDWhIwC/gB7vbdcf2/VJQfLWGMXKuFDSElSkvRLw5rU=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2959.namprd18.prod.outlook.com (20.179.23.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 22:58:05 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1987.013; Fri, 14 Jun 2019
 22:58:05 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
Thread-Topic: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
Thread-Index: AQHVIv39akuS1tOVHESDxVOswRgcdaabuesA//+T/oA=
Date:   Fri, 14 Jun 2019 22:58:04 +0000
Message-ID: <CDBC6094-EA99-45BE-A420-404ED6A3BE0F@marvell.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-4-hmadhani@marvell.com>
 <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
In-Reply-To: <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:646:8181:6df0:7090:38f5:27d5:21fb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3ab2ad2-cf5d-4d03-c46b-08d6f11bc28e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2959;
x-ms-traffictypediagnostic: MN2PR18MB2959:
x-microsoft-antispam-prvs: <MN2PR18MB2959B06713F4E56C27E18D9DD6EE0@MN2PR18MB2959.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(51444003)(199004)(189003)(51234002)(2906002)(5660300002)(46003)(446003)(476003)(2616005)(102836004)(11346002)(99286004)(186003)(86362001)(81166006)(8936002)(486006)(4326008)(256004)(53936002)(25786009)(14444005)(6512007)(81156014)(8676002)(66446008)(64756008)(66556008)(66476007)(53546011)(76176011)(2501003)(76116006)(6246003)(66946007)(73956011)(2201001)(91956017)(6116002)(36756003)(68736007)(14454004)(71200400001)(71190400001)(229853002)(110136005)(305945005)(316002)(6436002)(33656002)(6486002)(478600001)(6506007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2959;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: foQByLaFr+uP7C8qOC+kzcwEjMX99GHuCQj62ySELBdcgbk/JCASP0BiaHJwdC8Mg1tVpD7qmqvqSByrpqQJZf+EDGvVzkR9oKPBduYp/z9IAJ6S7A/3eKGA4gUoQ/Zb/tDk1ZIjj4AdV8O4q+KhcRlSbEV0dS5xd3rFz74hx/9k8Aez/kTQyAQN6WS2TFMYm1Gs7yO+srJlMg1MhquxtbAshyZrIYssZ0vZLs6HoZHNLFAPsA9hM5wbeL6FwFKDgPeNAA80E3gw3ZZlBkx8p/uVMLnMVB1nq1bXPHsK3YOEgNq4qAHEyViMJi8NxuW2VF/oIJm/OSTbNRNkrLInr70AV6y8OxuhF6dUCbinyQbws6Nc1yNVv0PD3iVKP8L1YJITvpuh3ZOZpemuxtwGwUyzEAA6IgmitXS3X1ky24o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34B657A7CE9AEB41BDC1C8BE2352C8FA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ab2ad2-cf5d-4d03-c46b-08d6f11bc28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 22:58:04.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2959
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQmFydCwgDQoNCu+7v09uIDYvMTQvMTksIDM6MjQgUE0sICJCYXJ0IFZhbiBBc3NjaGUiIDxi
dmFuYXNzY2hlQGFjbS5vcmc+IHdyb3RlOg0KDQogICAgRXh0ZXJuYWwgRW1haWwNCiAgICANCiAg
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQogICAgT24gNi8xNC8xOSAzOjEwIFBNLCBIaW1hbnNodSBNYWRoYW5p
IHdyb3RlOg0KICAgID4gRnJvbTogUXVpbm4gVHJhbiA8cXV0cmFuQG1hcnZlbGwuY29tPg0KICAg
ID4gDQogICAgPiBUaGlzIHBhdGNoIHVzZXMga3JlZiB0byBwcm90ZWN0IGFjY2VzcyBiZXR3ZWVu
IGZjcF9hYm9ydA0KICAgID4gcGF0aCBhbmQgbnZtZSBjb21tYW5kIGFuZCBMUyBjb21tYW5kIGNv
bXBsZXRpb24gcGF0aC4NCiAgICA+IFN0YWNrIHRyYWNlIGJlbG93IHNob3dzIHRoZSBhYm9ydCBw
YXRoIGlzIGFjY2Vzc2luZyBzdGFsZQ0KICAgID4gbWVtb3J5IChudm1lX3ByaXZhdGUtPnNwKS4N
CiAgICA+IA0KICAgID4gV2hlbiBjb21tYW5kIGtyZWYgcmVhY2hlcyAwLCBudm1lX3ByaXZhdGUg
JiBzcmIgcmVzb3VyY2Ugd2lsbA0KICAgID4gYmUgZGlzY29ubmVjdGVkIGZyb20gZWFjaCBvdGhl
ci4gIEFueSBzdWJzZXF1ZW5jZSBudm1lIGFib3J0DQogICAgPiByZXF1ZXN0IHdpbGwgbm90IGJl
IGFibGUgdG8gcmVmZXJlbmNlIHRoZSBvcmlnaW5hbCBzcmIuDQogICAgPiANCiAgICA+IFsgNTYz
MS4wMDM5OThdIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQg
MDAwMDAwMTAwMDAwMDVkOA0KICAgID4gWyA1NjMxLjAwNDAxNl0gSVA6IFs8ZmZmZmZmZmZjMDg3
ZGY5Mj5dIHFsYV9udm1lX2Fib3J0X3dvcmsrMHgyMi8weDEwMCBbcWxhMnh4eF0NCiAgICA+IFsg
NTYzMS4wMDQwODZdIFdvcmtxdWV1ZTogZXZlbnRzIHFsYV9udm1lX2Fib3J0X3dvcmsgW3FsYTJ4
eHhdDQogICAgPiBbIDU2MzEuMDA0MDk3XSBSSVA6IDAwMTA6WzxmZmZmZmZmZmMwODdkZjkyPl0g
IFs8ZmZmZmZmZmZjMDg3ZGY5Mj5dIHFsYV9udm1lX2Fib3J0X3dvcmsrMHgyMi8weDEwMCBbcWxh
Mnh4eF0NCiAgICA+IFsgNTYzMS4wMDQxMDldIENhbGwgVHJhY2U6DQogICAgPiBbIDU2MzEuMDA0
MTE1XSAgWzxmZmZmZmZmZmFhNGI4MTc0Pl0gPyBwd3FfZGVjX25yX2luX2ZsaWdodCsweDY0LzB4
YjANCiAgICA+IFsgNTYzMS4wMDQxMTddICBbPGZmZmZmZmZmYWE0YjlkNGY+XSBwcm9jZXNzX29u
ZV93b3JrKzB4MTdmLzB4NDQwDQogICAgPiBbIDU2MzEuMDA0MTIwXSAgWzxmZmZmZmZmZmFhNGJh
ZGU2Pl0gd29ya2VyX3RocmVhZCsweDEyNi8weDNjMA0KICAgID4gDQogICAgPiBTaWduZWQtb2Zm
LWJ5OiBRdWlubiBUcmFuIDxxdXRyYW5AbWFydmVsbC5jb20+DQogICAgPiBTaWduZWQtb2ZmLWJ5
OiBIaW1hbnNodSBNYWRoYW5pIDxobWFkaGFuaUBtYXJ2ZWxsLmNvbT4NCiAgICA+IC0tLQ0KICAg
ID4gICBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfZGVmLmggIHwgICAyICsNCiAgICA+ICAgZHJp
dmVycy9zY3NpL3FsYTJ4eHgvcWxhX252bWUuYyB8IDE2NCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tDQogICAgPiAgIGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9udm1l
LmggfCAgIDEgKw0KICAgID4gICAzIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRpb25zKCspLCA1
MCBkZWxldGlvbnMoLSkNCiAgICA+IA0KICAgID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9x
bGEyeHh4L3FsYV9kZWYuaCBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kZWYuaA0KICAgID4g
aW5kZXggNjAyZWQyNGJiODA2Li44NWEyN2VlNWQ2NDcgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2
ZXJzL3Njc2kvcWxhMnh4eC9xbGFfZGVmLmgNCiAgICA+ICsrKyBiL2RyaXZlcnMvc2NzaS9xbGEy
eHh4L3FsYV9kZWYuaA0KICAgID4gQEAgLTUzMiw2ICs1MzIsOCBAQCB0eXBlZGVmIHN0cnVjdCBz
cmIgew0KICAgID4gICAJdWludDhfdCBjbWRfdHlwZTsNCiAgICA+ICAgCXVpbnQ4X3QgcGFkWzNd
Ow0KICAgID4gICAJYXRvbWljX3QgcmVmX2NvdW50Ow0KICAgID4gKwlzdHJ1Y3Qga3JlZiBjbWRf
a3JlZjsJLyogbmVlZCB0byBtaWdyYXRlIHJlZl9jb3VudCBvdmVyIHRvIHRoaXMgKi8NCiAgICA+
ICsJdm9pZCAqcHJpdjsNCiAgICA+ICAgCXdhaXRfcXVldWVfaGVhZF90IG52bWVfbHNfd2FpdHE7
DQogICAgPiAgIAlzdHJ1Y3QgZmNfcG9ydCAqZmNwb3J0Ow0KICAgID4gICAJc3RydWN0IHNjc2lf
cWxhX2hvc3QgKnZoYTsNCiAgICANCiAgICBNeSBmZWVkYmFjayBhYm91dCB0aGlzIHBhdGNoIGlz
IGFzIGZvbGxvd3M6DQogICAgLSBJIHRoaW5rIHRoYXQgaGF2aW5nIHR3byBhdG9taWMgY291bnRl
cnMgaW4gc3RydWN0IHNyYiB3aXRoIGEgdmVyeQ0KICAgICAgIHNpbWlsYXIgcHVycG9zZSBpcyBv
dmVya2lsbCBhbmQgYWxzbyB0aGF0IGEgc2luZ2xlIGF0b21pYyBjb3VudGVyDQogICAgICAgc2hv
dWxkIGJlIHN1ZmZpY2llbnQgaW4gdGhpcyBzdHJ1Y3R1cmUuDQogICAgLSBUaGUgcHJvYmxlbSBm
aXhlZCBieSB0aGlzIHBhdGNoIG5vdCBvbmx5IGNhbiBoYXBwZW4gd2l0aCBOVk1lLUZDIGJ1dA0K
ICAgICAgIGFsc28gd2l0aCBGQy4gSSB3b3VsZCBwcmVmZXIgdG8gc2VlIGFsbCBjb2RlIHBhdGhz
IGZpeGVkIGZvciB3aGljaCBhDQogICAgICAgcmFjZSBiZXR3ZWVuIGNvbXBsZXRpb24gYW5kIGFi
b3J0IGNhbiBvY2N1ci4NCiAgICANClllcy4gV2UgYXJlIGluIHByb2Nlc3Mgb2YgZG9pbmcgdGhl
IGxhcmdlciBjbGVhbnVwLiBIb3dldmVyLCB0aGlzIHBhdGNoIHdhcyBwYXJ0IG9mIGZpeGVzIHdl
IHZlcmlmaWVkIGZvciBhIGNyYXNoIGFuZCB3YW50IHRvIGdldCB0aGlzIGluIGEgZGlzdHJvDQpi
ZWZvcmUgdGhlIHdpZGVyIGNsZWFudXAgaXMgc3VibWl0dGVkIGZvciBpbmNsdXNpb24uIA0KDQpX
b3VsZCB5b3UgY29uc2lkZXIgYWxsb3dpbmcgdXMgdG8gYWRkIHRoaXMgcGF0Y2ggYW5kIHdlJ2xs
IHByb3ZpZGUgbGFyZ2VyIHBhdGNoIGZpeGluZyBhbGwgY29kZSBwYXRoIGluIG5leHQgc2VyaWVz
LiANCg0KICAgIFRoYW5rcywNCiAgICANCiAgICBCYXJ0Lg0KICAgIA0KDQo=
