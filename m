Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066DF1B63CF
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2020 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgDWS3o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Apr 2020 14:29:44 -0400
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:16618
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730102AbgDWS3n (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 23 Apr 2020 14:29:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut37LoKL0oEqPksJiILiWxVfZ5rfYMY1SVrSI7yOIIimenO84SRJmJotUf1rhduZiuHMiJ7WchF7YBiLUnxnF9W3qXg6zSLsqV0B650GQTbwsNHodi49OiXP6ps6qblhCoekEAVNUSTscjO1LqaY/2sZQEO+SN7pqMqR2dICBZQdDSPrFd4ExS/h/WKuCmz1ZJnfqprlZiQ4tf8S73AW2pcps8Vu1P26PssRL4+7ey6Jr3Mx8p3XvWOlNPqn7X5NPZCK/1Pm7NcJVViY6gh5efaI7FA2bst7u2Vp7bJ5kbL5m+CFuNIgUQnX8bHhFNoCwRuiR/gv73e+UrUSvvdQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdP82RiIqIzKb8P3LImUFmpPvCT93h9LV2STJiB5ock=;
 b=VXVbdWfcuX/koUoNg0nDAmKdU9n4p1zXJpW4epPZVcwMvGCUI9pEGTmE27icfbJMcnwjncEH5wegQ07HEUf5SEx1j5k10O4bnuMaEfjGQo7Q4FNDz/dys9SeKk3/Jf70nNsaGTgxxsf3M6kxeJnI6wOUlJ/652/HyPV2Kv+jSECA/tqWgrBq8Cmv9nKRybieCc1J+PtxSyY0Dcoog7LvBytc74jgQfu7NsAmBZDB/KbjwKi/jnLhrxlkv+VxysrrNgg5o3aCY0JZNH/Nrdv6OYoDgZrahG8YmiYMa9iC5LAG4uAdB+72kCdozx2y8mN+/9WjD+LdhGowdcYzPGlPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdP82RiIqIzKb8P3LImUFmpPvCT93h9LV2STJiB5ock=;
 b=I0iQrCZP/px3JxbwcroZ+AUv6u/AtOqHPR/t0l4vDtYi52oYKKmO1JDo2JMYnPbbCLxaryrlX0+q+lkdxcei3QZmoeUMiL9nRkzq97keWbig9mQFEZ31g5KXf2VNdZHyzAbatR/pTiLqouU2eiVTyNo+ADkNxgExScL3KZtde7w=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0308.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Thu, 23 Apr
 2020 18:29:31 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.010; Thu, 23 Apr 2020
 18:29:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGGMw6DFeJK2tFE2eFTHRpRyDH6iElrSggAD4nwCAAKqbQIAAsEKAgAAFkoA=
Date:   Thu, 23 Apr 2020 18:29:30 +0000
Message-ID: <HK0P153MB02731F9C5FC61C466715362CBFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
 <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
In-Reply-To: <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-23T18:29:28.4535589Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4fa33f2-4808-469a-842c-8dd94fef93a8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:3421:d362:4eed:46b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86b5a769-8e08-4d50-0e5b-08d7e7b44389
x-ms-traffictypediagnostic: HK0P153MB0308:|HK0P153MB0308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0308608A0C19F0BD0CE43A27BFD30@HK0P153MB0308.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(107886003)(8990500004)(8936002)(54906003)(81156014)(8676002)(110136005)(33656002)(186003)(2906002)(316002)(4326008)(76116006)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(7696005)(9686003)(6506007)(53546011)(52536014)(5660300002)(10290500003)(71200400001)(82960400001)(82950400001)(7416002)(478600001)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdDz/hcIrbPmacgiQpQkQ7iMeIjfLm4JfYj7VwT+aTpwjz2cgSKwHW93HwzByhHt6TN+6B5GdP9FZwxztBWLyGbo1XbJA++mDUwXis7rmoF2oc2M06qCDQ7fYIQxnsXoSqQ3p1kyvhm5LXcb6dDEjNzRyaT2cFpA+jlQmRpEAZeSYKbZqkSOQTpfLBSuIYkQr2GXmqt5CdJoKHZe3+IeYpmQfmcyNerPsCpWm07R13namfcDTZwi+8CP9qmlPgH6Vno4NKqWTaymXddgYr+k2jlGgLbveyIuDkbgm0J0YinzbpeKVTp2mji7yE72kCzg3oPTKV6LIO9sV2Dc6YBkK+IRvYSvS3MoQ+NYv9C2qpZoVSZZIZmFCroZ/okG3InCRZV5hIJM8tB+2vuVt3tswz9vqMtEFHlm6OxZ8o5WynS/ctCRZ9luSpX1YGYrE+XSmzccOsX+S6LQE+YozXTmXMOBVfskIsaV7k072AP+yT8=
x-ms-exchange-antispam-messagedata: QlJl6yqLI5fzhgYh+e4dfWFWBEyBna/YagMtJQld+IJ8SYbDCQH65POmbYKFfS7lAYChwUP1p4h1doWOzJ+azkRYcGNM3A7zblOuvb8Wk1QbVeNTwk5RCq26NjgNpOcz7pgChiRHcMwTIFy/XgiGiboRYNYZIAm+bjqJCr4kaxAogIdp/ObTkk8OopiNwIjDGVHUWWPFfqAuRMGIwtcuXDhl9pq8PxHlPe5KUmlX1r8u0lkZIbgiOYvvQ2f8SFvXOxvOcusgUUjX5yItUxUV1bT8FbG05CaZUM9J3oNVowA6+tHgmjPow34BNb440sN4Fx1n2SZf78jfz3GkrxLXbrfRljBFdvLEVkdmm+MRRY5Z9s361u4wFi6sWuJ08VytVXFJ5zQMG2S7PSSKzkapvgjwj4t+bqUgTodUXodksNtxE274pZUVUCH9ms2HCPmgIn6w4rb6v7SbPBHX4K2W8Ug/Ap5+EoJ5JphcfiWrBG7GME2hATshpJjTnO352v8+z/Qlvgpo/nPyoNAqEgxgRajSwDIxMwTQx9FOyP7Bqlke4P9TUFNpCHjiWZlDKKak51fCuyqrEpxj3yUNE1r2tUYK07bC1oKWE7OZMO0WXtz0xK/rIVizCN49Pcikb/YHu010dNtTUAa6YaMscg/j65zPlg464SltEq58KjFbUA823CSRSKGz76i0kAkNxbLd5X9l8L6XFhLu9/nk1nk7dOVyMSDUfLdPUgHp7Jer9FOL4WQHXC8tyRA35qCxWVIlAQKeSgu8DVLE4OzOAcGm2SxHNgsmJtO+Pz2M1wUwL4ERQI1eB/7twSHKZbaZTOc1xyRwgMejlu377eh9HL6z6Axm48JO4W9BEeDaCjBETDw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b5a769-8e08-4d50-0e5b-08d7e7b44389
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 18:29:30.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knQX6wOoHVHpz5lzpdNleEKoLJpC72Za5cw3E8xg1THJyTMdXoELUI3HnOjjojh8P+y1WJ16bTjdic+DDLimAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0308
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDIzLCAyMDIwIDk6MzggQU0NCj4gDQo+IE9uIDQvMjMvMjAgMTI6MDQgQU0s
IERleHVhbiBDdWkgd3JvdGU6DQo+ID4gSXQgbG9va3MgdGhlIHNkIHN1c3BlbmQgY2FsbGJhY2tz
IGFyZSBvbmx5IGZvciB0aGUgSS9PIGZyb20gdGhlIGRpc2ssIGUuZy4NCj4gPiBmcm9tIHRoZSBm
aWxlIHN5c3RlbSB0aGF0IGxpdmVzIGluIHNvbWUgcGFydGl0aW9uIG9mIHNvbWUgZGlzay4NCj4g
Pg0KPiA+IFRoZSBwYW5pYyBJJ20gc2VlaW5nIGlzIG5vdCBmcm9tIHNkLiBJIHRoaW5rIGl0J3Mg
ZnJvbSBhIGtlcm5lbCB0aHJlYWQNCj4gPiB0aGF0IHRyaWVzIHRvIGRldGVjdCB0aGUgc3RhdHVz
IG9mIHRoZSBTQ1NJIENEUk9NLiBUaGlzIGlzIHRoZSBzbmlwcGVkDQo+ID4gbWVzc2FnZXMgKHRo
ZSBmdWxsIHZlcnNpb24gaXMgYXQgLi4uKTogaGVyZQ0KPiA+IHRoZSBzdXNwZW5kIGNhbGxiYWNr
cyBvZiB0aGUgc2QsIHNyIGFuZCBzY3NpX2J1c190eXBlLnBtIGhhdmUgYmVlbiBjYWxsZWQsDQo+
ID4gYW5kIGxhdGVyIHRoZSBzdG9ydnNjIExMRCdzIHN1c3BlbmQgY2FsbGJhY2sgaXMgYWxzbyBj
YWxsZWQsIGJ1dA0KPiA+IHNyX2Jsb2NrX2NoZWNrX2V2ZW50cygpIGNhbiBzdGlsbCB0cnkgdG8g
c3VibWl0IFNDU0kgY29tbWFuZHMgdG8gc3RvcnZzYzoNCj4gPg0KPiA+IFsgICAxMS42Njg3NDFd
IHNyIDA6MDowOjE6IGJ1cyBxdWllc2NlDQo+ID4gWyAgIDExLjY2ODgwNF0gc2QgMDowOjA6MDog
YnVzIHF1aWVzY2UNCj4gPiBbICAgMTEuNjk4MDgyXSBzY3NpIHRhcmdldDA6MDowOiBidXMgcXVp
ZXNjZQ0KPiA+IFsgICAxMS43MDMyOTZdIHNjc2kgaG9zdDA6IGJ1cyBxdWllc2NlDQo+ID4gWyAg
IDExLjc4MTczMF0gaHZfc3RvcnZzYyBiZjc4OTM2Zi03ZDhmLTQ1Y2UtYWIwMy02YzM0MTQ1MmU1
NWQ6IG5vaXJxDQo+IGJ1cyBxdWllc2NlDQo+ID4gWyAgIDExLjc5NjQ3OV0gaHZfbmV0dnNjIGRk
YTVhMmJlLWI4YjgtNDIzNy1iMzMwLWJlOGE1MTZhNzJjMDogbm9pcnENCj4gYnVzIHF1aWVzY2UN
Cj4gPiBbICAgMTEuODA0MDQyXSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Us
IGFkZHJlc3M6DQo+IDAwMDAwMDAwMDAwMDAwOTANCj4gPiBbICAgMTEuODA0OTk2XSBXb3JrcXVl
dWU6IGV2ZW50c19mcmVlemFibGVfcG93ZXJfIGRpc2tfZXZlbnRzX3dvcmtmbg0KPiA+IFsgICAx
MS44MDQ5OTZdIFJJUDogMDAxMDpzdG9ydnNjX3F1ZXVlY29tbWFuZCsweDI2MS8weDcxNA0KPiBb
aHZfc3RvcnZzY10NCj4gPiBbICAgMTEuODA0OTk2XSBDYWxsIFRyYWNlOg0KPiA+IFsgICAxMS44
MDQ5OTZdICBzY3NpX3F1ZXVlX3JxKzB4NTkzLzB4YTEwDQo+ID4gWyAgIDExLjgwNDk5Nl0gIGJs
a19tcV9kaXNwYXRjaF9ycV9saXN0KzB4OGQvMHg1MTANCj4gPiBbICAgMTEuODA0OTk2XSAgYmxr
X21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKzB4ZWQvMHgxNzANCj4gPiBbICAgMTEuODA0OTk2
XSAgX19ibGtfbXFfcnVuX2h3X3F1ZXVlKzB4NTUvMHgxMTANCj4gPiBbICAgMTEuODA0OTk2XSAg
X19ibGtfbXFfZGVsYXlfcnVuX2h3X3F1ZXVlKzB4MTQxLzB4MTYwDQo+ID4gWyAgIDExLjgwNDk5
Nl0gIGJsa19tcV9zY2hlZF9pbnNlcnRfcmVxdWVzdCsweGMzLzB4MTcwDQo+ID4gWyAgIDExLjgw
NDk5Nl0gIGJsa19leGVjdXRlX3JxKzB4NGIvMHhhMA0KPiA+IFsgICAxMS44MDQ5OTZdICBfX3Nj
c2lfZXhlY3V0ZSsweGViLzB4MjUwDQo+ID4gWyAgIDExLjgwNDk5Nl0gIHNyX2NoZWNrX2V2ZW50
cysweDlmLzB4MjcwIFtzcl9tb2RdDQo+ID4gWyAgIDExLjgwNDk5Nl0gIGNkcm9tX2NoZWNrX2V2
ZW50cysweDFhLzB4MzAgW2Nkcm9tXQ0KPiA+IFsgICAxMS44MDQ5OTZdICBzcl9ibG9ja19jaGVj
a19ldmVudHMrMHhjYy8weDExMCBbc3JfbW9kXQ0KPiA+IFsgICAxMS44MDQ5OTZdICBkaXNrX2No
ZWNrX2V2ZW50cysweDY4LzB4MTYwDQo+ID4gWyAgIDExLjgwNDk5Nl0gIHByb2Nlc3Nfb25lX3dv
cmsrMHgyMGMvMHgzZDANCj4gPiBbICAgMTEuODA0OTk2XSAgd29ya2VyX3RocmVhZCsweDJkLzB4
M2UwDQo+ID4gWyAgIDExLjgwNDk5Nl0gIGt0aHJlYWQrMHgxMGMvMHgxMzANCj4gPiBbICAgMTEu
ODA0OTk2XSAgcmV0X2Zyb21fZm9yaysweDM1LzB4NDANCj4gPg0KPiA+IEl0IGxvb2tzIHRoZSBp
c3N1ZSBpczogc2NzaV9idXNfZnJlZXplKCkgLT4gLi4uIC0+IHNjc2lfZGV2X3R5cGVfc3VzcGVu
ZCAtPg0KPiA+IHNjc2lfZGV2aWNlX3F1aWVzY2UoKSBkb2VzIG5vdCBndWFyYW50ZWUgdGhlIGRl
dmljZSBpcyB0b3RhbGx5IHF1aWVzY2VudDoNCj4gDQo+IER1cmluZyBoaWJlcm5hdGlvbiBwcm9j
ZXNzZXMgYXJlIGZyb3plbiBiZWZvcmUgZGV2aWNlcyBhcmUgcXVpZXNjZWQuDQo+IGZyZWV6ZV9w
cm9jZXNzZXMoKSBjYWxscyB0cnlfdG9fZnJlZXplX3Rhc2tzKCkgYW5kIHRoYXQgZnVuY3Rpb24g
aW4gdHVybg0KPiBjYWxscyBmcmVlemVfd29ya3F1ZXVlc19iZWdpbigpIGFuZCBmcmVlemVfd29y
a3F1ZXVlc19idXN5KCkuDQo+IGZyZWV6ZV93b3JrcXVldWVzX2J1c3koKSBmcmVlemVzIGFsbCBm
cmVlemFibGUgd29ya3F1ZXVlcyBpbmNsdWRpbmcNCj4gc3lzdGVtX2ZyZWV6YWJsZV9wb3dlcl9l
ZmZpY2llbnRfd3EsIHRoZSB3b3JrcXVldWUgZnJvbSB3aGljaA0KPiBjaGVja19ldmVudHMgZnVu
Y3Rpb25zIGFyZSBjYWxsZWQuIFNvbWUgdGltZSBhZnRlciBmcmVlemFibGUgd29ya3F1ZXVlcw0K
PiBhcmUgZnJvemVuIGRwbV9zdXNwZW5kKFBNU0dfRlJFRVpFKSBpcyBjYWxsZWQuIFRoYXQgbGFz
dCBjYWxsIHRyaWdnZXJzDQo+IHRoZSBwbV9vcHMuZnJlZXplIGNhbGxiYWNrcywgaW5jbHVkaW5n
IHRoZSBwbV9vcHMuZnJlZXplIGNhbGxiYWNrcw0KPiBkZWZpbmVkIGluIHRoZSBTQ1NJIGNvcmUu
DQo+IA0KPiBUaGUgYWJvdmUgdHJhY2Ugc2VlbXMgdG8gaW5kaWNhdGUgdGhhdCBmcmVlemluZyB3
b3JrcXVldWVzIGhhcyBub3QNCj4gaGFwcGVuZWQgYmVmb3JlIGRldmljZXMgd2VyZSBmcm96ZW4u
IEhvdyBhYm91dCBkb2luZyB0aGUgZm9sbG93aW5nIHRvDQo+IHJldHJpZXZlIG1vcmUgaW5mb3Jt
YXRpb24gYWJvdXQgd2hhdCBpcyBnb2luZyBvbj8NCj4gKiBFbmFibGUgQ09ORklHX1BNX0RFQlVH
IGluIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbi4NCj4gKiBSdW4gZWNobyAxID4gL3N5cy9wb3dl
ci9wbV9wcmludF90aW1lcyBhbmQgZWNobyAxID4NCj4gL3N5cy9wb3dlci9wbV9kZWJ1Z19tZXNz
YWdlcyBiZWZvcmUgaGliZXJuYXRpb24gc3RhcnRzLg0KPiANCj4gQmFydC4NCg0KR29vZCBwb2lu
dCEgTXkgcGFuaWMgaGFwcGVucyBpbiB0aGUgInJlc3RvcmUiIHBhdGgsIG5vdCB0aGUgInNhdmUi
IHBhdGguDQoNCkluIHRoZSAic2F2ZSIgcGF0aCwgYXMgeW91IGRlc2NyaWJlZCwgaXQgbG9va3Mg
ZXZlcnl0aGluZyBpcyBkb25lIGNvcnJlY3RseS4NCkJUVywgZnJlZXplX3Byb2Nlc3NlcygpIG9u
bHkgZnJlZXplcyB0aGUgdXNlcnNwYWNlIHByb2Nlc3Nlcy4gQWZ0ZXINCmhpYmVybmF0ZSgpIC0+
IGZyZWV6ZV9wcm9jZXNzZXMoKSwgaGliZXJuYXRlKCkgLT4gaGliZXJuYXRpb25fc25hcHNob3Qo
KQ0KLT4gZnJlZXplX2tlcm5lbF90aHJlYWRzKCkgYWxzbyBmcmVlemVzIHRoZSAiZnJlZXphYmxl
IiBrZXJuZWwgcHJvY2Vzc2VzLA0KYW5kIHRoZW4gd2UgY2FsbCBkcG1fc3VzcGVuZChQTVNHX0ZS
RUVaRSksIGFuZCBuZXh0IHdlIGRvIGEgbG90IG9mDQpvdGhlciB0aGluZ3MsIGFuZCBmaW5hbGx5
IHRoZSBzeXN0ZW0gaXMgcG93ZXJlZCBvZmYuDQoNCkluIHRoZSAicmVzdG9yZSIgcGF0aCBvZiB0
aGUgaGliZXJuYXRpb246DQoxLiBXZSBzdGFydCB0aGUgc3lzdGVtIGFuZCBhIGZyZXNoIG5ldyBr
ZXJuZWwgc3RhcnRzIHRvIHJ1bi4NCg0KMi4gVGhlICduZXcnIGtlcm5lbCBpdHNlbGYgZmluaXNo
ZXMgdGhlIGluaXRpYWxpemF0aW9uIGFuZCB0aGUgJ2luaXQnIHNjcmlwdA0KaW4gdGhlIGluaXRy
YW1mcyBzdGFydHMgdG8gcnVuLiBUaGUgJ2luaXQnIHNjcmlwdCBub3RpY2VzIHRoZXJlIGlzIGEg
c2F2ZWQNCnN0YXRlIG9mIHRoZSBwcmV2aW91cyAnb2xkJyBrZXJuZWwgaW4gc29tZSBzd2FwIGZp
bGUvcGFydGl0aW9uLCBzbyBpdCB3b24ndA0KZG8gYSB1c3VhbCBzdGFydC11cDsgaW5zdGVhZCwg
dGhlICdpbml0JyBzY3JpcHQgcnVucyBhIHByb2dyYW0gY2FsbGVkICdyZXN1bWUnLg0KDQozLiBU
aGUgJ3Jlc3VtZScgcHJvZ3JhbSB0YWxrcyB0byB0aGUga2VybmVsIHZpYSAvc3lzL3Bvd2VyL3Jl
c3VtZSBhbmQNCmFza3MgdGhlIGtlcm5lbCB0byBkbyBhIHJlc3VtZS1mcm9tLWRpc2suDQoNCjQu
IFRoZSBrZXJuZWwgc3RhcnRzIHRvIHJ1biByZXN1bWVfc3RvcmUoKSAtPiBzb2Z0d2FyZV9yZXN1
bWUgLT4NCmZyZWV6ZV9wcm9jZXNzZXMoKSwgd2hpY2ggZnJlZXplcyB0aGUgdXNlcnNwYWNlLCBi
dXQgdGhlICJmcmVlemFibGUiDQprZXJuZWwgdGhyZWFkcyBhcmUgbm90IGZyb3plbiEhIQ0KDQpT
byBpdCBsb29rcyB0aGUgYmVsb3cgcGF0Y2ggYWxzbyB3b3JrcyBmb3IgbWU6DQoNCi0tLSBhL2tl
cm5lbC9wb3dlci9oaWJlcm5hdGUuYw0KKysrIGIva2VybmVsL3Bvd2VyL2hpYmVybmF0ZS5jDQpA
QCAtODk4LDYgKzg5OCwxMSBAQCBzdGF0aWMgaW50IHNvZnR3YXJlX3Jlc3VtZSh2b2lkKQ0KICAg
ICAgICBlcnJvciA9IGZyZWV6ZV9wcm9jZXNzZXMoKTsNCiAgICAgICAgaWYgKGVycm9yKQ0KICAg
ICAgICAgICAgICAgIGdvdG8gQ2xvc2VfRmluaXNoOw0KKw0KKyAgICAgICBlcnJvciA9IGZyZWV6
ZV9rZXJuZWxfdGhyZWFkcygpOw0KKyAgICAgICBpZiAoZXJyb3IpDQorICAgICAgICAgICAgICAg
Z290byBDbG9zZV9GaW5pc2g7DQorDQogICAgICAgIGVycm9yID0gbG9hZF9pbWFnZV9hbmRfcmVz
dG9yZSgpOw0KICAgICAgICB0aGF3X3Byb2Nlc3NlcygpOw0KICBGaW5pc2g6DQoNCkp1c3QgdG8g
YmUgc3VyZSwgSSdsbCBkbyBtb3JlIHRlc3RzLCBidXQgSSBiZWxpZXZlIHRoZSBwYW5pYyBjYW4g
YmUgZml4ZWQNCmJ5IHRoaXMgYWNjb3JkaW5nIHRvIG15IHRlc3RzIEkgaGF2ZSBkb25lIHNvIGZh
ci4NCg0KSSdtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdGhlIGNvbW1lbnQgYmVmb3JlIHNjc2lfZGV2
aWNlX3F1aWVzY2UoKSBtZWFuczoNCiAqICAuLi4gU2luY2Ugc3BlY2lhbCByZXF1ZXN0cyBtYXkg
YWxzbyBiZSByZXF1ZXVlZCByZXF1ZXN0cywNCiAqICAgICAgYSBzdWNjZXNzZnVsIHJldHVybiBk
b2Vzbid0IGd1YXJhbnRlZSB0aGUgZGV2aWNlIHdpbGwgYmUNCiAqICAgICAgdG90YWxseSBxdWll
c2NlbnQuDQoNCkkgZG9uJ3Qga25vdyBpZiB0aGVyZSBjYW4gYmUgc29tZSBvdGhlciBJL08gc3Vi
bWl0dGVkIGFmdGVyDQpzY3NpX2RldmljZV9xdWllc2NlKCkgcmV0dXJucyBpbiB0aGUgY2FzZSBv
ZiBoaWJlcm5hdGlvbiwgYW5kIEkgZG9uJ3QNCmtub3cgaWYgYWFjX3N1c3BlbmQoKSAtPiBzY3Np
X2hvc3RfYmxvY2soKSBzaG91bGQgYmUgZml4ZWQvcmVtb3ZlZCwNCmJ1dCBhcyBmYXIgYXMgdGhl
IHBhbmljIGlzIGNvbmNlcm5lZCwgSSdtIHZlcnkgZ2xhZCBJIGhhdmUgZm91bmQgYSBiZXR0ZXIN
CmZpeCB3aXRoIHlvdXIgaGVscC4gDQoNClRoYW5rIHlvdSBzbyBtdWNoLCBCYXJ0ISANCg0KVGhh
bmtzLA0KLS0gRGV4dWFuDQo=
