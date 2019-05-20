Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD722B94
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 07:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfETF7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 01:59:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8724 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbfETF7J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 01:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558331965; x=1589867965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a9/bHOgFnUreMHZBG1vGYSgMpDREqB1bSYrKhGziPCk=;
  b=b88xE30vrsg8NmeINA1OtkfY1R3nDTnRsVPTEcELFyXxYAKLG9cIrStC
   boat9oKBVvSCyt30KRUdZL/wqvSLkgcUgLgM1SxNCYRo2/ph55i+Mftb9
   tqseBztaHB53++wel+blCtTK+f6jDxvzoazY3hBuh9GyyABp7YVk90nZE
   ltHUwE2g7dPCactAC8Ai5oY+u+Mekb+4gwENWU2lRtsMXB91zeBgFwYgN
   dPJOQAuAwflM3PMCJzLPP3oOBMoyqMbtdrCgOMfqHETkdDmNBySDqSQfq
   EvYI5jHpY7VX0cmZLYEnVn4OhldkdBICc5BXSuj9XDsX+HGtVsvJ4Vg7Q
   g==;
X-IronPort-AV: E=Sophos;i="5.60,490,1549900800"; 
   d="scan'208";a="208089286"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2019 13:59:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9/bHOgFnUreMHZBG1vGYSgMpDREqB1bSYrKhGziPCk=;
 b=HXS5oGK97z6e8lQsrhckoN9iYZfFquG2R7tnfMgo1G93BFsRt+SvZOdT0F6f6hbqhuNHjvbLvJnJOUD9EJBJr/dcwT+8JH3HfpBB7rvbNwSdTfEt2O8TDJhcRJZCwNH920q5vzpYQTjWWsOotX7aa3Tz82vRL/HmmrciGpzY2WQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5261.namprd04.prod.outlook.com (20.178.7.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 05:58:59 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 05:58:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v1 0/3] scsi: ufs: add error handlings of auto-hibern8
Thread-Topic: [PATCH v1 0/3] scsi: ufs: add error handlings of auto-hibern8
Thread-Index: AQHVCZlLHLuK5SjZGEupOZN+OiGKg6ZpI2EAgApptQA=
Date:   Mon, 20 May 2019 05:58:58 +0000
Message-ID: <SN6PR04MB49250CC0866546DB50F446F8FC060@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
 <55818bc4-d464-bb35-25bb-9ef87af8224e@free.fr>
In-Reply-To: <55818bc4-d464-bb35-25bb-9ef87af8224e@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38df3390-6524-4983-d9b4-08d6dce84076
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5261;
x-ms-traffictypediagnostic: SN6PR04MB5261:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5261DC16B065001FCF1276AFFC060@SN6PR04MB5261.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(316002)(66476007)(7416002)(2906002)(66066001)(7696005)(76176011)(25786009)(99286004)(53546011)(6506007)(5660300002)(110136005)(54906003)(6246003)(9686003)(6436002)(66556008)(68736007)(74316002)(71190400001)(72206003)(71200400001)(229853002)(478600001)(55016002)(14454004)(33656002)(186003)(2501003)(86362001)(476003)(6116002)(11346002)(446003)(3846002)(53936002)(486006)(305945005)(2201001)(7736002)(76116006)(66946007)(64756008)(66446008)(8676002)(73956011)(4326008)(81156014)(81166006)(8936002)(52536014)(26005)(102836004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5261;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fMD/lsWZMS9pWAR4s5Btv2J81EmE/P8J+9ZNe8Z9pinMiu2MaE8fOr9SH3L8HlJ9zT3DYncqAQjv8pA0OWOOhqHxy+FVLBKtTCgEVQowlWXABSppNZyDqPo1VrxfMk3tTjXe0GR91O6iWBF5WFpWVIHNC8beWavgp3d+ojbVZXqTKadeUb2OQkzG6BOuRgEgGYD5kMQpQXlqqTNwe+y5Y+dv2z+bGhuaXwJ9+NyOVuZlCTquwWRYtRuFaxxeMrlQkSrh2sRxuAV/jiY40PY2qYn5jKxuri/Or/7gUmc2AWOW6Jmf9iDZLd1qWpUBkMxKqjBcqKYj9YTbgWBrKK9ba9+lA98Z4oSkioNVwflg6p/VGJor56it79KQHPOedB9TXU+/amCWQcR2E9FPdJ0ZvTTOXWTfxEnScCPGYd57/ts=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38df3390-6524-4983-d9b4-08d6dce84076
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 05:58:58.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5261
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiANCj4gT24gMTMvMDUvMjAxOSAxNjozNiwgU3RhbmxleSBDaHUgd3JvdGU6DQo+IA0KPiA+IEN1
cnJlbnRseSBhdXRvLWhpYmVybjggaXMgYWN0aXZhdGVkIGlmIGhvc3Qgc3VwcG9ydHMNCj4gPiBh
dXRvLWhpYmVybjggY2FwYWJpbGl0eS4gSG93ZXZlciBubyBlcnJvciBoYW5kbGluZ3MgYXJlIGV4
aXN0ZWQgdGh1cw0KPiA+IHRoaXMgZmVhdHVyZSBpcyBraW5kIG9mIHJpc2t5Lg0KPiANCj4gVGhp
cyBsYXN0IHNlbnRlbmNlIGlzIG5vdCB2ZXJ5IGlkaW9tYXRpYy4NCj4gDQo+IEkgd291bGQgc3Vn
Z2VzdDoNCj4gIkhvd2V2ZXIsIGVycm9yLWhhbmRsaW5nIGlzIG5vdCBpbXBsZW1lbnRlZCwgd2hp
Y2ggbWFrZXMgdGhlIGZlYXR1cmUNCj4gc29tZXdoYXQgcmlza3kuIg0KPiANCj4gPiBJZiAiSGli
ZXJuYXRlIEVudGVyIiBvciAiSGliZXJuYXRlIEV4aXQiIGZhaWwgaGFwcGVucw0KPiANCj4gSSB3
b3VsZCBzdWdnZXN0Og0KPiBJZiBlaXRoZXIgIkhpYmVybmF0ZSBFbnRlciIgb3IgIkhpYmVybmF0
ZSBFeGl0IiBmYWlsIGR1cmluZyAuLi4NCj4gDQo+ID4gZHVyaW5nIGF1dG8taGliZXJuOCBmbG93
LCB0aGUgY29ycmVzcG9uZGluZyBpbnRlcnJ1cHQNCj4gPiAiVUlDX0hJQkVSTkFURV9FTlRFUiIg
b3IgIlVJQ19ISUJFUk5BVEVfRVhJVCIgc2hhbGwgYmUgcmFpc2VkDQo+ID4gYWNjb3JkaW5nIHRv
IFVGUyBzcGVjaWZpY2F0aW9uLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGF1dG8taGliZXJu
OCBlcnJvciBoYW5kbGluZ3M6DQo+IA0KPiBlcnJvci1oYW5kbGluZw0KPiANCj4gPiAtIE1vbml0
b3IgIkhpYmVybmF0ZSBFbnRlciIgYW5kICJIaWJlcm5hdGUgRXhpdCIgaW50ZXJydXB0cyBhZnRl
cg0KPiA+ICAgYXV0by1oaWJlcm44IGZlYXR1cmUgaXMgYWN0aXZhdGVkLg0KPiANCj4gSSBqdXN0
IHdhbnQgdG8gdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRvIGFzayBhIHJoZXRvcmljYWwgcXVlc3Rp
b24uDQo+IA0KPiBXaG8gaW4gdGhlIEdyZWF0IEhlYXZlbnMgdGhvdWdodCBpdCB3b3VsZCBiZSBh
IGdvb2QgaWRlYSB0byBjYWxsIHRoZQ0KPiBmZWF0dXJlICJhdXRvLWhpYmVybjgiID8NCj4gDQo+
IFdhcyBpdCByZWFsbHkgd29ydGggaXQgdG8gc2F2ZSAyIGNoYXJhY3RlcnMgYnkgd3JpdGluZyAi
OCIgaW5zdGVhZA0KPiBvZiAiYXRlIiA/DQo+IA0KPiBUaGlzIGJ1Z3MgbWUgc28gbXVjaCB0aGF0
IEkganVzdCBtaWdodCBzZW5kIGEgcGF0Y2ggdG8gZml4IGl0IHVwLg0KQXMgc3RyYW5nZSBhcyBp
dCBtYXkgYmUsIHRoaXMgaXMgbm90IHRoZSBwcm9kdWN0IG9mIHRoZSBjcmVhdGl2ZSBtaW5kDQpP
ZiB0aGUgb3JpZ2luYWwgZHJpdmVyJ3MgYXV0aG9ycywgbm9yIGV2ZW4gSkVERUMgZ3V5cyB3aGlj
aCB1c2VzIGl0IGluDQp0aGVpciBzcGVjcyAoYm90aCBVRlMgJiBIQ0kpLg0KVGhpcyBzdHJhbmdl
IGFtYWxnYW0gZGF0ZXMgYmFjayB0byB0aGUgbWlwaS11bmlwcm8gdGVybWlub2xvZ3kuDQoNClRo
YW5rcywNCkF2cmkNCg==
