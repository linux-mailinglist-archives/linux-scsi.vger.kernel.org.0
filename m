Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74BF22B63
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 07:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfETFrs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 01:47:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40133 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfETFrs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 01:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558331268; x=1589867268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OE3L1xsEv1kDNn1e4OTqexBfAyS0AZmf9rnaI8aFf/Y=;
  b=E311Vh8cPvg3C4LZk5nRi2QLubqCCw5IMokeep919jMhMfhw6juut4eb
   49Z4m76kVJJ+ulxKORDrMSVQ95VY0lah7axgio/HN9k54tUZc9if9DqUL
   3u25exMH5CI3yCWHjB4Ns55lRlgw77YtDC6ieBlrhlHYZ/HcxsId/b21o
   80xGvnqc/lFFZHbXF4Q6cG9M29IVYZFfu31fnrUBzC8wTF7i9J4lLk6P9
   G/erPRCqunrSjPSM7f+wTBjcOm+4h6IQ8GF1w67qWFyMvl2q0oMqL6uLS
   1qVWAy71mG6bWeK0tUlq2IBhz6xe1gwF0sesukMQ9S4stvNRPU0xgRT/W
   w==;
X-IronPort-AV: E=Sophos;i="5.60,490,1549900800"; 
   d="scan'208";a="109875807"
Received: from mail-dm3nam03lp2054.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.54])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2019 13:47:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE3L1xsEv1kDNn1e4OTqexBfAyS0AZmf9rnaI8aFf/Y=;
 b=G2rJS7hHB/l5t6W62J0RpxZjGk/IwReA/K9XfhvvGj6T09VrbIn7wkfoigIVq3owoFKfyNyoNRHZhG/CFz50tR2K9x9f1f9i5/0LMJ2nvoAHsMPrllXM+o/Q9HU+h60DNJtqP6AT4AXEiw9a2F8jiRM2WV2XCyGMGsQFFRypun0=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4702.namprd04.prod.outlook.com (52.135.122.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 05:47:43 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 05:47:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [PATCH v2 1/3] scsi: ufs: Do not overwrite Auto-Hibernate timer
Thread-Topic: [PATCH v2 1/3] scsi: ufs: Do not overwrite Auto-Hibernate timer
Thread-Index: AQHVDsyCIZqpZobCA02Vxl/j/e/uWKZzgTZA
Date:   Mon, 20 May 2019 05:47:43 +0000
Message-ID: <SN6PR04MB4925D68D8D8EF2E16FD6525AFC060@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
        <CGME20190515093640epcas2p17e4c3e4545ce5e4e4b59ed7b9a954741@epcas2p1.samsung.com>
        <1557912988-26758-2-git-send-email-stanley.chu@mediatek.com>
 <15a271c6-88c8-b9d5-68a8-dc142afdf224@samsung.com>
In-Reply-To: <15a271c6-88c8-b9d5-68a8-dc142afdf224@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0434ed10-c7f7-4905-1898-08d6dce6ad97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4702;
x-ms-traffictypediagnostic: SN6PR04MB4702:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4702D20DA1E13B293355F6FBFC060@SN6PR04MB4702.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(446003)(11346002)(86362001)(476003)(7736002)(2201001)(305945005)(3846002)(53936002)(486006)(33656002)(186003)(2501003)(6116002)(52536014)(26005)(14444005)(256004)(102836004)(73956011)(66446008)(64756008)(66946007)(76116006)(8676002)(81166006)(8936002)(81156014)(4326008)(25786009)(2906002)(110136005)(76176011)(7696005)(66066001)(6246003)(54906003)(99286004)(6506007)(53546011)(5660300002)(316002)(7416002)(66476007)(68736007)(478600001)(229853002)(14454004)(55016002)(74316002)(66556008)(6436002)(9686003)(72206003)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4702;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZigZrSoNbpJ4wDTG0i+9jdnfHcpO4rC+NK3c4tPjHLu4IgCXP1IFGuVOCeRA0bX33Wke9qUswu44xUuX/xrTUuoqYmdZ87BKxMBO6IPChvEnpfWLlzVmkaymDUJ9oefxRV7Fni3U+EZBiHkwH1WQQxzZoGgdeK+4/sOKc+Kwofa65f/qZpVT4Fc23YqNZQt66nLWD0Pq0SdywSgU+g/ze9LWr/Th5bp7qZWLEg5ja4qT01aAGVfEP+mPeVHFXTtRe3qP9/n1oFp72ICaR3LWrTim1ZRR0trVaFK7oGhMt9EKgdvPFrYjUz4cXS7N0ZS7bjlwGI24nLpNnw2tzbzT+wfL6VnCWGDk5Nw+nlKsn6+a0rZSQm7Lb6+FNfgVrlXaFdHDTZ9w8827wSa0i18wPe8y4D6YIjiFVtQXXptn6WM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0434ed10-c7f7-4905-1898-08d6dce6ad97
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 05:47:43.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4702
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQo+IA0KPiBIZWxsbyBTdGFubGV5LA0KPiANCj4gT24gNS8xNS8xOSAzOjA2IFBNLCBTdGFubGV5
IENodSB3cm90ZToNCj4gPiBTb21lIHZlbmRvci1zcGVjaWZpYyBpbml0aWFsaXphdGlvbiBmbG93
IG1heSBzZXQgaXRzIG93bg0KPiA+IGF1dG8taGliZXJuYXRlIHRpbWVyLiBJbiB0aGlzIGNhc2Us
IGRvIG5vdCBvdmVyd3JpdGUgdGltZXIgdmFsdWUNCj4gPiBhcyAiZGVmYXVsdCB2YWx1ZSIgaW4g
dWZzaGNkX2luaXQoKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFu
bGV5LmNodUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2Qu
YyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gPiBpbmRleCBlMDQwZjlkZDlmZjMuLjE2
NjU4MjBjMjJmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+
ID4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiA+IEBAIC04MzA5LDcgKzgzMDks
NyBAQCBpbnQgdWZzaGNkX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSwgdm9pZCBfX2lvbWVtDQo+
ICptbWlvX2Jhc2UsIHVuc2lnbmVkIGludCBpcnEpDQo+ID4gICAJCQkJCQlVSUNfTElOS19ISUJF
Uk44X1NUQVRFKTsNCj4gPg0KPiA+ICAgCS8qIFNldCB0aGUgZGVmYXVsdCBhdXRvLWhpYmVyYXRl
IGlkbGUgdGltZXIgdmFsdWUgdG8gMTUwIG1zICovDQo+ID4gLQlpZiAoaGJhLT5jYXBhYmlsaXRp
ZXMgJiBNQVNLX0FVVE9fSElCRVJOOF9TVVBQT1JUKSB7DQo+ID4gKwlpZiAoaGJhLT5jYXBhYmls
aXRpZXMgJiBNQVNLX0FVVE9fSElCRVJOOF9TVVBQT1JUICYgIWhiYS0+YWhpdCkgew0KQSB0eXBv
Pw0KDQoNCj4gPiAgIAkJaGJhLT5haGl0ID0gRklFTERfUFJFUChVRlNIQ0lfQUhJQkVSTjhfVElN
RVJfTUFTSywNCj4gMTUwKSB8DQo+ID4gICAJCQkgICAgRklFTERfUFJFUChVRlNIQ0lfQUhJQkVS
TjhfU0NBTEVfTUFTSywgMyk7DQo+ID4gICAJfQ0KPiA+DQo+IExvb2tzIGdvb2QgdG8gbWUsDQo+
IFJldmlld2VkLWJ5OiBBbGltIEFraHRhciA8YWxpbS5ha2h0YXJAc2Ftc3VuZy5jb20+DQo=
