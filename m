Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E764A9D5
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfFRS2V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 14:28:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52170 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729642AbfFRS2V (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:28:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIJvDr028152;
        Tue, 18 Jun 2019 11:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=14WHG/6koUiAraFQFQj9EJrk1mUG3yGssbStczxcOLk=;
 b=a2k6qapEp4PBYL2JKqo43J7G8uZyB8ybydHysMJf6gTTlpZoetL9ROeAKj+B139/bufu
 ue4OoWke8ThS0W02si2cMCilRSic90r6VKz7latogZLT9zv+MobnlYuoWiUbnijVt6/t
 tiU+1DcV3j+zdsPCKzdXq5Pal7HkPRCjv4KSpYgc5ZTrBDSm5p9oJJshg3Djp0YVaxAV
 qHzQFTOGg9Cdt4lXUq/IpEzgd++hbfnE+GCUvOLPFjKiwokfUW4dFyJSRxner4M8pv+H
 TAo+1BzDVcryH5R1GCKZUX+eQ0Vq1Pywe8+z4/6295LB3fGpVxqXMZE6IjpSurm4p57E Ww== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t73vqgf1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 11:28:07 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 11:28:06 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 18 Jun 2019 11:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14WHG/6koUiAraFQFQj9EJrk1mUG3yGssbStczxcOLk=;
 b=QGmTkxHR0aqrL8xOot3/OP6xt7uh8Ub/gurgGnCs6a6KCYDSG3hg9E9PmFhizbtYk5MphWg3Oq9E0n8R5jDWGwK41B2WwOkSX2ubtOx8EQP9A/m9ZMlXSMlwFHBvwCuH5SOm3+4Tpdcf34QZmvjUzVCnDOjHbODCIc96b8p2OvE=
Received: from MWHPR18MB1488.namprd18.prod.outlook.com (10.175.7.135) by
 MWHPR18MB0926.namprd18.prod.outlook.com (10.173.120.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 18:28:01 +0000
Received: from MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::9034:6d9f:c17e:58dd]) by MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::9034:6d9f:c17e:58dd%2]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 18:28:01 +0000
From:   Quinn Tran <qutran@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
Thread-Topic: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
Thread-Index: AQHVIv4BL39boxvrlkmr8rNsBpQqaKabuesAgAAJVwCABJD0AP//wncAgAGAUgD//7TGgA==
Date:   Tue, 18 Jun 2019 18:28:00 +0000
Message-ID: <D17E4394-131D-46BB-AA97-99708BE1AD6C@marvell.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-4-hmadhani@marvell.com>
 <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
 <CDBC6094-EA99-45BE-A420-404ED6A3BE0F@marvell.com>
 <e5b17e5a-49d1-7496-a395-9a09bb791a7f@acm.org>
 <52D4CB41-2BD6-4CD6-B779-DC4C5F0CE94E@marvell.com>
 <2d582a54-024a-186a-fa52-6bc8123247e9@acm.org>
In-Reply-To: <2d582a54-024a-186a-fa52-6bc8123247e9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.186.1.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc5fb19e-0f23-476a-16d9-08d6f41ab1e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR18MB0926;
x-ms-traffictypediagnostic: MWHPR18MB0926:
x-microsoft-antispam-prvs: <MWHPR18MB092693AA383D90472B5D9D4CD5EA0@MWHPR18MB0926.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39850400004)(51914003)(51444003)(189003)(199004)(53936002)(7736002)(2501003)(186003)(446003)(476003)(2616005)(110136005)(81166006)(486006)(6506007)(53546011)(81156014)(8676002)(6436002)(66946007)(73956011)(91956017)(5660300002)(76116006)(8936002)(76176011)(66476007)(66446008)(64756008)(2906002)(66556008)(25786009)(26005)(86362001)(71200400001)(478600001)(102836004)(6512007)(6116002)(71190400001)(2201001)(66066001)(11346002)(14444005)(6246003)(229853002)(3846002)(6486002)(99286004)(4326008)(14454004)(36756003)(316002)(33656002)(305945005)(256004)(68736007)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR18MB0926;H:MWHPR18MB1488.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jp2+Tr5BIpTNi4Lvg/uQMbGoAubEeIRiADLd7Pgd8VhcyE9yPFZUd4MQ3vYA3Th/Piis+FenhR5s9f/cAE6O2J4YtRhyzmaTfivgsyJ1YxTaGph5gJbO6WZwt5SQtahTU/nPw41luUb15TjE1yXmw1/YwTNIqWpA5IGsq6M5ZwgJW94lmTPdBshmLXVNumkpLMNfgzwS48+Slo3xil9ixTtyX0+yV2s/7aAwFI+IcoQEkQ8H3a9UJ+Zg2OA1nYd+tiIeQ8dsDA/vr4e6UBXk6TeMDKLDGid0/xwZXGgwWBnbiLft/SJWxLP8UK5Olzr3FdVF7tZqqtS5K0QXjEKFaTAUvPVbciDX84RtSaLSI5sWTJCGNuZhFfuaKEjWSpzIixdo48DY5XJ57lz7cFGIFj/TC8t1BUiZPGwbl5zRJZ8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81E4D2E497CCFE4B8B9018F5F1211461@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fb19e-0f23-476a-16d9-08d6f41ab1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 18:28:00.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qutran@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB0926
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQrvu79PbiA2LzE4LzE5LCA4OjU3IEFNLCAiQmFydCBWYW4gQXNzY2hlIiA8YnZhbmFzc2NoZUBh
Y20ub3JnPiB3cm90ZToNCg0KICAgIE9uIDYvMTcvMTkgNTowMSBQTSwgUXVpbm4gVHJhbiB3cm90
ZToNCiAgICA+IEF0dGFjaGVkIGlzIHRoZSBjbGVhbi11cCBwYXRjaCB0aGF0IHdlIGhlbGQgYmFj
ayBmcm9tIHRoZSBzZXJpZXMuID4gV2UgZmVsdCBpdCB3YXNuJ3QgcmVhZHkgZm9yIHdpZGVyIGF1
ZGllbmNlIGJlY2F1c2UgaXQgbmVlZGVkIGFkZGl0aW9uYWwNCiAgICA+IHNvYWsgdGltZSB3aXRo
IG91ciB0ZXN0IGdyb3VwLg0KICAgID4gDQogICAgPiBXZSB3YW50IHRvIGFoZWFkIGFuZCBzaGFy
ZSBpdCB3aXRoIHlvdSB0byBsZXQgeW91IGtub3cgdGhhdCB3ZSBpbnRlbnQNCiAgICA+IHRvIGNs
ZWFudXAgdGhlIGR1cGxpY2F0ZSBhdG9taWMgW3JlZl9jb3VudHxrcmVmXS4gIE9uY2UgaXQgaGFz
IHNvbWUNCiAgICA+IHNvYWsgdGltZSBpbiBvdXIgdGVzdCBncm91cCwgd2UnbGwgc3VibWl0IGl0
IGluIHRoZSBuZXh0IFJDIHdpbmRvdy4NCiAgICANCiAgICBIaSBRdWlubiwNCiAgICANCiAgICBU
aGFuayB5b3UgZm9yIGhhdmluZyBzaGFyZWQgdGhhdCBwYXRjaCBlYXJseS4gTXkgY29tbWVudHMg
YWJvdXQgdGhhdCANCiAgICBwYXRjaCBhcmUgYXMgZm9sbG93czoNCiAgICAtIFRoZSBwYXRjaCBk
ZXNjcmlwdGlvbiBpcyBub3QgY29ycmVjdC4gVG9kYXkgZnJlZWluZyBvZiBhbiBTUkIgZG9lcyBu
b3QgDQogICAgaGFwcGVuIHdoZW4gcmVmX2NvdW50IHJlYWNoZXMgemVybyBidXQgaXQgaGFwcGVu
cyB3aGVuIHRoZSBmaXJtd2FyZSANCiAgICByZXBvcnRzIGEgY29tcGxldGlvbi4gVGhhdCBpcyB3
aHkgdG9kYXkgdGhlIGFib3J0IGNvZGUgY2FuIHRyaWdnZXIgYSANCiAgICB1c2UtYWZ0ZXItZnJl
ZS4gcmVmX2NvdW50IGlzIG9ubHkgdXNlZnVsIHRvZGF5IGZvciB0aGUgYWJvcnQgY29kZSB0byAN
CiAgICBkZXRlY3QgYXRvbWljYWxseSB3aGV0aGVyIG9yIG5vdCB0aGUgZmlybXdhcmUgYWxyZWFk
eSByZXBvcnRlZCB0aGF0IGEgDQogICAgcmVxdWVzdCBjb21wbGV0ZWQuDQoNClFUOiBCYXJ0LCB0
aGFua3MgZm9yIHRoZSBhZGRpdGlvbmFsIGV5ZXMuICBUaGlzIHBhdGNoIG1hZGUgYWRkaXRpb25h
bCBzYWZlIGd1YXJkIHRvIHByZXZlbnQgdXNlIGFmdGVyIGZyZWUuICBXaGVuIHRoZSBvcmlnaW5h
bCBJTyBhcnJpdmUgaW50byBRTEEgZHJpdmVyLCBRTEEgd2lsbCBiaW5kIHNjc2lfY21uZCAmIHNy
YiB0b2dldGhlci4gIFdoZW4gdGhlIGtyZWYgcmVhY2hlcyAwLCB3ZSB3aWxsIHVuYmluZCB0aGUg
MiBzdHJ1Y3R1cmVzIHdpdGggTlVMTCBwb2ludGVyLiAgQW55IGF0dGVtcHQgb24gJ3VzZSBhZnRl
ciBmcmVlJyB3aWxsIGJlIGJsb2NrIGJ5IG51bGwgcG9pbnRlci4gIFdlIHJlc2VydmUgYWRkaXRp
b25hbCBzY3JhdGNoIHNwYWNlIGF0IHRoZSBlbmQgb2Ygc2NzaV9jbW5kIChzcmJfcHJpdmF0ZSkg
dG8gZmFjaWxpdGF0ZSB0aGUgYmluZCBhbmQgdW5iaW5kLg0KDQo4NzkgcWxhX3JlbGVhc2VfZmNw
X2NtZF9rcmVmKHN0cnVjdCBrcmVmICprcmVmKQ0KODgwIHsNCiA4ODEgICAgICAgICBzdHJ1Y3Qg
c3JiICpzcCA9IGNvbnRhaW5lcl9vZihrcmVmLCBzdHJ1Y3Qgc3JiLCBjbWRfa3JlZik7DQogODgy
ICAgICAgICAgc3RydWN0IHNjc2lfY21uZCAqY21kID0gR0VUX0NNRF9TUChzcCk7DQogODg0ICAg
ICAgICAgc3RydWN0IHNyYl9wcml2YXRlICpwcml2ID0gKHN0cnVjdCBzcmJfcHJpdmF0ZSopKGNt
ZCArIDEpOw0KLi4NCiA4ODggICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmcHJpdi0+Y21kX2xv
Y2ssIGZsYWdzKTsNCiA4ODkgICAgICAgICBDTURfU1AoY21kKSA9IE5VTEw7ICAgIDw8PDwgdW5i
aW5kIHNjc2lfY21uZCBmcm9tIHNyYi4NCiA4OTAgICAgICAgICBzcC0+dS5zY21kLmNtZCA9IE5V
TEw7DQogODkxICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHJpdi0+Y21kX2xvY2ss
IGZsYWdzKTsNCn0NCg0KMTM1OSBzdGF0aWMgaW50DQoxMzYwIHFsYTJ4eHhfZWhfYWJvcnQoc3Ry
dWN0IHNjc2lfY21uZCAqY21kKQ0KMTM2MSB7DQouLg0KMTM3MCAgICAgICAgIHN0cnVjdCBzcmJf
cHJpdmF0ZSAqcHJpdiA9IChzdHJ1Y3Qgc3JiX3ByaXZhdGUqKShjbWQgKyAxKTsNCi4uDQoxMzgy
IA0KMTM4MyAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZwcml2LT5jbWRfbG9jaywgZmxhZ3Mp
Ow0KMTM4NCAgICAgICAgIHNwID0gKHNyYl90ICopIENNRF9TUChjbWQpOw0KMTM4NSAgICAgICAg
IGlmICghc3AgfHwgIXNwLT5xcGFpciB8fA0KMTM4NiAgICAgICAgICAgICAocHJpdi0+Y21kX2lk
ICE9IHNwLT5jbWRfaWQpIHx8DQoxMzg3ICAgICAgICAgICAgIChzcC0+ZmNwb3J0ICYmIHNwLT5m
Y3BvcnQtPmRlbGV0ZWQpKSB7DQoxMzg4ICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZwcml2LT5jbWRfbG9jaywgZmxhZ3MpOw0KMTM4OSAgICAgICAgICAgICAgICAgcmV0
dXJuIFNVQ0NFU1M7DQoxMzkwICAgICAgICAgfQ0KICANCg0KDQogICAgLSBPbmx5IGNhbGxpbmcg
Y21kLT5zY3NpLWRvbmUoY21kKSB3aGVuIHRoZSByZWZlcmVuY2UgY291bnQgcmVhY2hlcyB6ZXJv
IA0KICAgIGludm9sdmVzIGEgYmVoYXZpb3IgY2hhbmdlLiBJZiBhIGNvbW1hbmQgY29tcGxldGlv
biBhbmQgYSByZXF1ZXN0IHRvIA0KICAgIGFib3J0IGEgY29tbWFuZCByYWNlLCB0aGlzIHBhdGNo
IHdpbGwgcmVwb3J0IHRoZSBjb21tYW5kIGFzIGFib3J0ZWQgdG8gDQogICAgdGhlIFNDU0kgbWlk
LWxheWVyIGluc3RlYWQgb2YgYXMgY29tcGxldGVkLiBUaGlzIGNoYW5nZSBoYXMgbm90IGJlZW4g
DQogICAgbWVudGlvbmVkIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4gSXMgdGhpcyBjaGFuZ2Ug
cGVyaGFwcyB1bmludGVudGlvbmFsPw0KUVQ6ICBJIGJlbGlldmUgdGhlIG9yaWdpbmFsIGNvZGUg
aGFzIHRoZSBzYW1lIGJlaGF2aW9yLiAgV2UncmUgdHJ5aW5nIHRvIHByZXNlcnZlIHByZWNlZGVu
dC4gIFdpbGwgcmV2aXNpdCB0byBkaWZmZXJlbnRpYXRlIHRoZSAyIHN0YXR1cyBjb2RlIHRoZSBk
ZXNjcmliZWQgcmFjZS4NCg0KICAgIC0gSSB0aGluayB0aGF0IHRoaXMgcGF0Y2ggZG9lcyBub3Qg
YWRkcmVzcyB0aGUgbWVtb3J5IGxlYWsgdGhhdCBjYW4gYmUgDQogICAgdHJpZ2dlcmVkIGJ5IGFi
b3J0aW5nIGEgY29tbWFuZC4gSWYgYSBjb21tYW5kIGlzIGFib3J0ZWQgaXQgd2lsbCBiZSANCiAg
ICBmcmVlZCBieSBxbGFfcmVsZWFzZV9mY3BfY21kX2tyZWYoKSBjYWxsaW5nIHFsYTJ4eHhfcmVs
X3FwYWlyX3NwKCkgYW5kIA0KICAgIGJ5IHFsYTJ4eHhfcmVsX3FwYWlyX3NwKCkgY2FsbGluZyBz
cC0+ZnJlZShzcCkuIEhvd2V2ZXIsIHRoZSANCiAgICBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnJl
ZSBmdW5jdGlvbiBmb3IgbXVsdGlwbGUgU1JCIHR5cGVzIGlzIGluY29tcGxldGUuDQoNClFUOiAg
QXMgZm9yIHRoZSBvdGhlciB0eXBlIFNSQiwgSSBmb2xsb3cgd2hhdCB5b3UncmUgcG9pbnRpbmcg
YXQuICBXZSBkbyBoYXZlIGFub3RoZXIgcGF0Y2goaXMpIHRvIGFkZHJlc3MgdGhpcyBvdGhlciBj
b3JuZXIuICBXaWxsIHF1ZXVlIGl0IHVwIHRvIGdvIG91dCBhbHNvIHdpdGggdGhlIG5leHQgd2lu
ZG93LiBJdCdzIGN1cnJlbnRseSBiZWluZyBzb2FrIGluIG91ciB0ZXN0IGdyb3VwLg0KDQogICAg
LSBUaGUgYXBwcm9hY2ggZm9yIGF2b2lkaW5nIHRoYXQgcWxhMnh4eF9laF9hYm9ydCgpIHRyaWdn
ZXJzIGEgDQogICAgdXNlLWFmdGVyLWZyZWUgKHRoZSBuZXcgc3JiX3ByaXZhdGUgc3RydWN0dXJl
KSBpcyBpbnRlcmVzdGluZy4gSG93ZXZlciwgDQogICAgdGhhdCBhcHByb2FjaCBkb2VzIG5vdCBs
b29rIGNvcnJlY3QgdG8gbWUuIFRoZSBwYXRjaCBhdHRhY2hlZCB0byB0aGUgDQogICAgcHJldmlv
dXMgZS1tYWlsIGluc2VydHMgdGhlIGZvbGxvd2luZyBjb2RlIGluIHFsYTJ4eHhfZWhfYWJvcnQo
KToNCiAgICAgICAnc3AgPSBDTURfU1AoY21kKTsgaWYgKCFzcCB8fCAhc3AtPnFwYWlyIHx8IC4u
LikgcmV0dXJuIFNVQ0NFU1MnDQogICAgQXMgb25lIGNhbiBzZWUgdGhlIHNwIHBvaW50ZXIgaXMg
ZGVyZWZlcmVuY2VkIGFsdGhvdWdoIHRoZSBtZW1vcnkgaXQgDQogICAgcG9pbnRzIGF0IGNvdWxk
IGFscmVhZHkgaGF2ZSBiZWVuIGZyZWVkIGFuZCBjb3VsZCBoYXZlIGJlZW4gcmVhbGxvY2F0ZWQg
DQogICAgYnkgYW5vdGhlciBkcml2ZXIgb3IgYW5vdGhlciBwcm9jZXNzLiBTbyBJIGRvbid0IHRo
aW5rIHRoZSBuZXcgY29kZSBmb3IgDQogICAgYXZvaWRpbmcgYSB1c2UtYWZ0ZXItZnJlZSBpcyBj
b3JyZWN0Lg0KDQpRVDogIE9LLiBXaWxsIHJlbW92ZSBvbGQgZGVmZW5zaXZlIGNoZWNrIHRoYXQg
bWF5IHN0aWxsIGNhdXNlIHVzZSBhZnRlciBmcmVlLg0KDQotLS0tDQogICAgDQogICAgVGhhbmtz
LA0KICAgIA0KICAgIEJhcnQuDQogICAgDQoNCg==
