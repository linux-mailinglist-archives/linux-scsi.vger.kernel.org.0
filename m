Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC886F349
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfGUMwx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jul 2019 08:52:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56296 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGUMwx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Jul 2019 08:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563713572; x=1595249572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jr/9iVwfIsb8WMeguz+EcBRhicX7u1nuWFZ7yQfaR3g=;
  b=kYYau7dJWr3kNUpx3Yx5gvQV8oY5c1xXZl7LNY/8S7JxuovI7FHco3lq
   XMMFGh2Bc6iS60P55+LZpnU0vawvVxPOPAuNeWDytYRGJeuY6HS0Y26M0
   4YCMGmIW9o461UZQYAXrHR7pVNbvmSsvwvl9tqVJVbPOMnKnKoa5KTARE
   sbJP1SToJv3WAcWZcQRiD4BTl4XyINaFTX+4RP2SOzTxjxDjoaWMOE0dr
   hUC/U5lVd5uagzZGariJ2wtnx3cDE+QKFePeXxLc/Il+3re8PZPSUoNB7
   pJ44FcHgSu2o0BSRpdR+ZpCGIzbaBI+ye9/gcReV51AloHDGYoae17+Ws
   g==;
IronPort-SDR: bRaC+u2BWF7b57H2NfjCi0RC0KYH3n36VG4Rg2Pq0MNzT/+RKPj4mqP2FstqbrN5VLiEspX5Bx
 cdxbwtbgpJUrYYPsljVz2Y0h7xpKRa3Tps9qzcHwg9m1dSMT6M76415F8QznU3kc3AVXOqa1iQ
 yJDwfJRr04mXpOyQUWfOCi9hxJsyTP6S3/i16BtspObzJyTtPh/SUdE2X2SwWt7RAvhrBw+AQR
 a+3dG+xU/+PvxDuL975Hj/1NsIll5GXSEviA8meGIF4Pmfu8dNY9SMWgTPShUkVz6TbnxH4mrH
 Gw8=
X-IronPort-AV: E=Sophos;i="5.64,290,1559491200"; 
   d="scan'208";a="114700015"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2019 20:52:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDja1mMlaTkvsIPn7PJIZZj3X0bnp5nanPd897A3uHtbComFyFmRYBb+K/dlT5/fTr1F63BI5PVdaMso2Xx6NNXPQWUjKGvy5wFr726hYOb/dGg8/D8p2kWS89hmDTWzuf0MLEco6v+ofOJ7Nsq+UaeC04jhrLNAVoJpzXaNp0CZ5RtAUZaP3qEPvOtHq1Tb1lBMkuPeQrZd7SoAh8M+lpFUQG/nMMyP+TDFwYGo49gEA590DLjhBkfvwexZEOesID5J0KaNlsBdjGdrTpIDhWlJAKWcIUv/44Rn4XPsCGevNziYh4dj0L+RSdzjWABPu2H87XhntN74dnXxzfLIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr/9iVwfIsb8WMeguz+EcBRhicX7u1nuWFZ7yQfaR3g=;
 b=e41gmSt7FZ1ve1pM16h923WIKQ9ilEkmiY/YYdTzJfYjSRuq6A7Fs6iLFlh3uptiKoS+RWiwqBt+QYGUcthB3FfgIWY7JbZx23KxBplEoTjm4zDApKLazWeC1r12Hu0jNiU7/c1fp1bUKam0Ujsidmbvn30tEeMNJ3M7oSGq7q4KKhghY+OaZ1fMLSH+1pUs27hNb1BQ/6sbceVOq/LNqUmtei8CVBbkrERIVMy1nKGed/VtJrLwR5OdOBy2oaHtDgxNJp6PoVbpCgnFQhqDd7vbBeRQDXC53r+vn8tYxYQz91susDvEyKFSNI5KoQbQeeJkg7vSz0iv1fNT9eubsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr/9iVwfIsb8WMeguz+EcBRhicX7u1nuWFZ7yQfaR3g=;
 b=Ds64fUyr+sVWndcP45+iDYV3di3uBdW5vFWERUlZkV8ayzYdA4mN818e28h8R+UGuNlMbGwHkBU3/UZR/6sOnoO4kExTn05m/Uq2jC223a87hmJRlSpTeMuNoHDAkbUtdm3AGxLjxjb7HXqEIekdqRFqDp80mQ9B9RmHwfCUzBs=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4110.namprd04.prod.outlook.com (52.135.82.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Sun, 21 Jul 2019 12:52:47 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3%5]) with mapi id 15.20.2094.011; Sun, 21 Jul 2019
 12:52:47 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
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
Subject: RE: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
Thread-Topic: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
Thread-Index: AQHVOGx9NdHB1Jz3wEWNwY1jARxa+abVESuAgAADy1A=
Date:   Sun, 21 Jul 2019 12:52:47 +0000
Message-ID: <SN6PR04MB4925BD03422B827F76A5F7E5FCC50@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
 <SN6PR04MB4925208835D4760249E82DB7FCC50@SN6PR04MB4925.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4925208835D4760249E82DB7FCC50@SN6PR04MB4925.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9841e0cd-f76d-4092-a333-08d70dda54ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4110;
x-ms-traffictypediagnostic: SN6PR04MB4110:
x-microsoft-antispam-prvs: <SN6PR04MB4110B6E5E8F863C6CD48245BFCC50@SN6PR04MB4110.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0105DAA385
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(478600001)(76116006)(66946007)(256004)(25786009)(110136005)(2201001)(54906003)(76176011)(66476007)(66556008)(64756008)(66446008)(476003)(446003)(11346002)(316002)(486006)(6506007)(2501003)(8676002)(186003)(7696005)(7736002)(102836004)(99286004)(305945005)(74316002)(52536014)(26005)(6116002)(6436002)(55016002)(2906002)(81156014)(33656002)(81166006)(6246003)(9686003)(2940100002)(86362001)(66066001)(229853002)(4744005)(5660300002)(71190400001)(71200400001)(8936002)(68736007)(53936002)(4326008)(7416002)(3846002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4110;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /8E5USBtaTOhNNdSxYUVpLthBdAeOQHTDAAU58S2IJyP40X2vSQbPvUK6TAatNE/wmdwzt1YCpOKrGgMXeSaj9RfEhOuwtndfKqiotlKOzP9sfVD9FfxyU/pbHi/QI0tJCiY8PNhetVQeYoS7+tdTy2eu3S0pmxzXJiv1+3G21wGqGnMj5bHlP0pRalCRe9xji/VdU/ZOXm5PsREoIUmjPCVKggQfOrqQcfGqHvOsWHNnX9n1vlFcRGFX6rj6DiIpfmVySNGhiF4KUbaxoOqpvVvw4D3xakAe2W2T3CBpyfpXsKplTuEwuBJrzPyzq7iQmzk4Kmzc3dvQFjl41MnBHxrxRGVFd7U0O2fJLz6lrrqDcHwecKUmYzPUkcsBmtcCxd7cjD7chgrIDA5Cu3BY4mzEi5GOl1VF1vSg81i9ZY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9841e0cd-f76d-4092-a333-08d70dda54ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2019 12:52:47.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4110
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiANCj4gSGksDQo+IA0KPiA+DQo+ID4gQ3VycmVudGx5IGJpdHMgaW4gaGJhLT5vdXRzdGFuZGlu
Z190YXNrcyBhcmUgY2xlYXJlZCBvbmx5IGFmdGVyIHRoZWlyDQo+ID4gY29ycmVzcG9uZGluZyB0
YXNrIG1hbmFnZW1lbnQgY29tbWFuZHMgYXJlIHN1Y2Nlc3NmdWxseSBkb25lIGJ5DQo+ID4gX191
ZnNoY2RfaXNzdWVfdG1fY21kKCkuDQo+ID4NCj4gPiBJZiB0aW1lb3V0IGhhcHBlbnMgaW4gYSB0
YXNrIG1hbmFnZW1lbnQgY29tbWFuZCwgaXRzIGNvcnJlc3BvbmRpbmcNCj4gPiBiaXQgaW4gaGJh
LT5vdXRzdGFuZGluZ190YXNrcyB3aWxsIG5vdCBiZSBjbGVhcmVkIHVudGlsIG5leHQgdGFzaw0K
PiA+IG1hbmFnZW1lbnQgY29tbWFuZCB3aXRoIHRoZSBzYW1lIHRhZyB1c2VkIHN1Y2Nlc3NmdWxs
eSBmaW5pc2hlcy7igKcNCj4gdWZzaGNkX2NsZWFyX3RtX2NtZCBpcyBhbHNvIGNhbGxlZCBhcyBw
YXJ0IG9mIHVmc2hjZF9lcnJfaGFuZGxlci4NCj4gRG9lcyB0aGlzIGNoYW5nZSBzb21ldGhpbmcg
aW4geW91ciBhc3N1bXB0aW9ucz8NCkFuZCBCVFcgdGhlcmUgaXMgYSBzcGVjaWZpYyBfX2NsZWFy
X2JpdCBpbiBfX3Vmc2hjZF9pc3N1ZV90bV9jbWQoKSBpbiBjYXNlIG9mIGEgVE8uDQoNCj4gDQo+
IFRoYW5rcywNCj4gQXZyaQ0KPiANCg==
