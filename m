Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4C1F0821
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Jun 2020 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgFFS0d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 6 Jun 2020 14:26:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53892 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgFFS0c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 6 Jun 2020 14:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591467992; x=1623003992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TO47JxgV09/vCAOrXTCdux6hNDEhH8EegxG+dJoZbv8=;
  b=fYPbHbOYzmG8Z/6g1kAJWSljcB08S5Im84xfCDItLd4aHwwOPIkfKBcC
   aBGBFQKRuVMrwH29RrtR8NppLkbgafcQncwaLKAbLtPXhpzSgxXKhhh7i
   O50PYI0pWiKpWHoNSanTjy+B2qHCSLvNCjbJLUmTjMDBUyA7t0YlfDIq+
   gynf35wSdiNXdfvNz1Ey48k870B+t9Mf3ZmrRqrw2SRH3NGauu/HWdTiM
   np/lmp4stoGHd7QbIbCHUnWNOiO9yGb3GuZqY/LPR+vjBXbYaaj+w9+tZ
   inxCMHhj4avi6MMWiaF3BI3a1tz8lqXdlfIiAExxiBwQ/+t/RECcIfcf/
   w==;
IronPort-SDR: oEkkSrpJiPist5HjuLrgBLEObNuSVbYD/m0RFwXQ9xQcu+LcEUpt13QCBUrDG96lUSb35M8bDH
 NfI8qPs5lj3wAwmvzmsvAiXNFlsh723O7nxrvX5gps+nTsWDY4DG7Fi1tJIbcK+Lq8I40uCzN2
 u6dUfXg3m8uj2uthn7zNYMxOqR+x1w1QtrEAZpU5ZekeBT4IePIsXB6woQuAL47YdI+VLgMujJ
 AZ5dnDTbHJTrP2hStVa92Ioc64LoCTSJkrWHAfirlYTgEDAjLdQrwCR5cEKav38Ep45z+zMAMZ
 ZqQ=
X-IronPort-AV: E=Sophos;i="5.73,481,1583164800"; 
   d="scan'208";a="139668762"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2020 02:26:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+9KWd578hNYeaiKFrd0JLrzQlG9TIVaH4nZjYM0+9HF0sgzPtyYyU5M0MkIldG6qOc0sUaZykm3xn3IUMovPBAKpiNzHVoglHMAmH9vovqU/ZK3esa2TjUdSq4YR6QobfsToLMosaGJwLBVLdHJOqsZdzpZSIRli3IYhXQv4na/kMNbGw27jxaX7bynNRUZxhbpQ7zAo/IFt0D1NJLI/cW4Nd6fW7fo/ekGrOXK0HVIvp/gMECm5X/2YCuIIt4DI+urDYTdeKjcZleOIpXAeZ7IJOTjGPzicUfxMqRIYBFbkQWCGuqUA7uv5iE3k9muC4MxSbe76kF4rXESAnGjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO47JxgV09/vCAOrXTCdux6hNDEhH8EegxG+dJoZbv8=;
 b=B6BEDZXlmCmbD8fGP4ilQ/80oCR/VBRGpAZ+bUdWDS+chhlaEnO40ar95ILliokJQJGCYFRCEHSycXnNOfHQokmEG9Q3Te216gHjkcDXtUP0gYYSgK8UK1QCDiFWvt+7aCbWubd0I/HaRA9/n+YBGZ2BoHpGtHCFkU93laFG67NflGLXkm4QnTE+8iHzxsRpiihQSxbCw6WQQ56OMJth834bzyM6fQkZFG7D2DBGUj5VEDP2dE+ZTqn2IFsFHc+XXw3RWrD0xAGhsjqxgRZC0dBiGpaOIRUKHSvRB7yiW6UP3CRKfyquiKiVLcHAkqvCaRNRC/0mNyoTHguZatm8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO47JxgV09/vCAOrXTCdux6hNDEhH8EegxG+dJoZbv8=;
 b=KFswwF5s3PQqpR1loKheauN8mKL1GA1FUWLwr0TTXhE75PeizLTSrKOXyRB4mwgqo7yr1bCi3oJ5lsG8SpCu8kIW43H61gwGyVRY7htuf0qy+P5Ej4/DKo3EkfPkrGsBUhmLk8z1Ze3e0Yu4xGsRfq//D89fS8HFlw+VuN0Ugzw=
Received: from SN6PR04MB4640.namprd04.prod.outlook.com (2603:10b6:805:a4::19)
 by SN6PR04MB3968.namprd04.prod.outlook.com (2603:10b6:805:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 18:26:28 +0000
Received: from SN6PR04MB4640.namprd04.prod.outlook.com
 ([fe80::9cbe:995f:c25f:d288]) by SN6PR04MB4640.namprd04.prod.outlook.com
 ([fe80::9cbe:995f:c25f:d288%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 18:26:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
Subject: RE: [RFC PATCH 4/5] scsi: ufs: L2P map management for HPB read
Thread-Topic: [RFC PATCH 4/5] scsi: ufs: L2P map management for HPB read
Thread-Index: AQHWOt5z/DbVMmIRNkq+06TbmiHC8KjLsIjg
Date:   Sat, 6 Jun 2020 18:26:27 +0000
Message-ID: <SN6PR04MB46409E16CCF95A0AA9FFE944FC870@SN6PR04MB4640.namprd04.prod.outlook.com>
References: <231786897.01591322101492.JavaMail.epsvc@epcpadp1>
        <336371513.41591320902369.JavaMail.epsvc@epcpadp1>
        <963815509.21591320301642.JavaMail.epsvc@epcpadp1>
        <231786897.01591320001492.JavaMail.epsvc@epcpadp1>
        <CGME20200605011604epcms2p8bec8ef6682583d7248dc7d9dc1bfc882@epcms2p2>
 <963815509.21591323002276.JavaMail.epsvc@epcpadp1>
In-Reply-To: <963815509.21591323002276.JavaMail.epsvc@epcpadp1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3c1cdac-d708-4cf6-0e60-08d80a472099
x-ms-traffictypediagnostic: SN6PR04MB3968:
x-microsoft-antispam-prvs: <SN6PR04MB39685420A563ECACD42F3716FC870@SN6PR04MB3968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 04267075BD
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ioGZyKSVCsL6ZWO4oJd+GCL0u6096g0EF9tq1gNSjk6e+Gkosw76H4HErMoGeMSHxUdIQYHRNv4SbfjkakPhBWo9H9U6WyLqcD69iJ8EDq1YaVllrAUNoyY9z55Fg1SNeLSGpHx9iF6kdVOZQtHf07LleMgLDt5+o+1aZnykGML3wK6EpjskAhoQ4YDdTGYTnnOcs/rOVePOtoZexDO3LLW+1Q9qkjnerkIsHpENYkQITrNkFmVBfeqNWkzuf0C4LuzPRuRwhY8YeWe147ZWx4iKJ8IMidedZ4jUySra0R+2nf8R8bQqPnP/mVX7e0cYhpYQwrUrwlg9SRZ850BdbPQ7laRGjr+9CPqkiB7oEiv+CrxH8e9Nd65MYGCdRntX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4640.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(4326008)(83380400001)(6506007)(316002)(54906003)(86362001)(26005)(110136005)(5660300002)(7696005)(33656002)(55016002)(478600001)(186003)(71200400001)(76116006)(2906002)(64756008)(66556008)(66446008)(66476007)(52536014)(9686003)(7416002)(8936002)(8676002)(66946007)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t6GvQd68ydjxRTYaR62rAHFFgmMvM/XHEhU9ac0M78uX4xYaAvaki4etXg+T2wbD7D8zOZvYFpnP20foJI/ra4vJAPuvzeGhTc4SS8PIoTHjeLMw7tgL0YSpulqG09jjgEu2w01GW6jusdH+EuBsfwXd1DjheWLTqwnhwE6BjluBsS3hLa9JO6Zz2dGt8RmzJiAXGpeEIQ9dVx7DJ92PilQsnjP7udsQFsSTDsFRS14zb4r2vejrIFE1XL5KXYDdcihispyJZBiVtumXzIDGUsfzXZe8sFVdlgYEwbjyh06lzThjWS/aejvn+aP/+jrjO8BYAq1unaBRgH4oBNPPU/RQ/EwjXTmbYFoV53fuTVRcga2uE+raSgEwd6pTcq92EffL7A4703CiSj9vQljbBdfqV7HoG7GHIjiUT+3O7rvuSgz6LT4XoIh4OkfmBej5tB/ViardMHNRo4IAoBryynsQBpo7OxvSFijY7u4fo1Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c1cdac-d708-4cf6-0e60-08d80a472099
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2020 18:26:27.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xqip4HbfTP889byDRBA/JNTPa1pwRI1ICQhst8juBoH1R//wuj+MwMRvyLi3RFySndyJcoReUXnXdG75hwJU+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3968
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiANCj4gQSBwaW5uZWQgcmVnaW9uIGlzIGEgcHJlLXNldCByZWdpb25zIG9uIHRoZSBVRlMgZGV2
aWNlIHRoYXQgaXMgYWx3YXlzDQo+IGFjdGl2YXRlLXN0YXRlIGFuZA0KVGhpcyBzZW50ZW5jZSBn
b3QgY3V0IG9mZg0KDQo+IA0KPiBUaGUgZGF0YSBzdHJ1Y3R1cmUgZm9yIG1hcCBkYXRhIHJlcXVl
c3QgYW5kIEwyUCBtYXAgdXNlcyBtZW1wb29sIEFQSSwNCj4gbWluaW1pemluZyBhbGxvY2F0aW9u
IG92ZXJoZWFkIHdoaWxlIGF2b2lkaW5nIHN0YXRpYyBhbGxvY2F0aW9uLg0KDQpNYXliZSBvbmUg
b3IgdHdvIG1vcmUgc2VudGVuY2VzIHRvIGV4cGxhaW4gdGhlIEwyUCBmcmFtZXdvcms6DQpFYWNo
IGhwYiBsdW4gbWFpbnRhaW5zIDIgInRvLWRvIiBsaXN0czogDQogLSBocGItPmxoX2luYWN0X3Jn
biAtIHJlZ2lvbnMgdG8gYmUgaW5hY3RpdmF0ZWQsIGFuZCANCiAtIGhwYi0+bGhfYWN0X3NyZ24g
LSBzdWJyZWdpb25zIHRvIGJlIGFjdGl2YXRlZA0KVGhvc2UgbGlzdHMgYXJlIGJlaW5nIGNoZWNr
ZWQgb24gZXZlcnkgcmVzdW1lIGFuZCBjb21wbGV0aW9uIGludGVycnVwdC4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRGFlanVuIFBhcmsgPGRhZWp1bjcucGFya0BzYW1zdW5nLmNvbT4NCj4gLS0t
DQo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGhwYi0+cGFnZXNfcGVyX3NyZ247IGkrKykgew0K
PiArICAgICAgICAgICAgICAgbWN0eC0+bV9wYWdlW2ldID0gbWVtcG9vbF9hbGxvYyh1ZnNocGJf
ZHJ2LnVmc2hwYl9wYWdlX3Bvb2wsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPiArICAgICAgICAgICAgICAgbWVtc2V0KHBh
Z2VfYWRkcmVzcyhtY3R4LT5tX3BhZ2VbaV0pLCAwLCBQQUdFX1NJWkUpOw0KQmV0dGVyIG1vdmUg
dGhpcyBtZW1zZXQgYWZ0ZXIgaWYgKCFtY3R4LT5tX3BhZ2VbaV0pLg0KQW5kIG1heWJlIHVzZSBj
bGVhcl9wYWdlIGluc3RlYWQ/DQoNCj4gKyAgICAgICAgICAgICAgIGlmICghbWN0eC0+bV9wYWdl
W2ldKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBpOyBqKysp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtcG9vbF9mcmVlKG1jdHgtPm1f
cGFnZVtqXSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWZzaHBiX2Rydi51ZnNocGJfcGFnZV9wb29sKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byByZWxlYXNlX3Bwbl9kaXJ0eTsNCj4gKyAgICAgICAgICAgICAgIH0NCg0KDQo+ICtzdGF0
aWMgaW5saW5lIGludCB1ZnNocGJfYWRkX3JlZ2lvbihzdHJ1Y3QgdWZzaHBiX2x1ICpocGIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB1ZnNocGJfcmVnaW9u
ICpyZ24pDQo+ICt7DQpNYXliZSBiZXR0ZXIgZGVzY3JpYmUgd2hhdCB0aGlzIGZ1bmN0aW9uIGRv
ZXMgLSB1ZnNocGJfZ2V0X3Jnbl9tYXBfY3R4ID8NCg0KPiArDQo+ICtzdGF0aWMgaW50IHVmc2hw
Yl9ldmljdF9yZWdpb24oc3RydWN0IHVmc2hwYl9sdSAqaHBiLCBzdHJ1Y3QgdWZzaHBiX3JlZ2lv
bg0KPiAqcmduKQ0KPiArew0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsgICAg
ICAgaW50IHJldCA9IDA7DQo+ICsNCj4gKyAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmaHBiLT5o
cGJfc3RhdGVfbG9jaywgZmxhZ3MpOw0KPiArICAgICAgIGlmIChyZ24tPnJnbl9zdGF0ZSA9PSBI
UEJfUkdOX1BJTk5FRCkgew0KPiArICAgICAgICAgICAgICAgZGV2X3dhcm4oJmhwYi0+aHBiX2x1
X2RldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICJwaW5uZWQgcmVnaW9uIGNhbm5vdCBk
cm9wLW91dC4gcmVnaW9uICVkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgcmduLT5y
Z25faWR4KTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgIH0NCj4gKw0K
PiArICAgICAgIGlmICghbGlzdF9lbXB0eSgmcmduLT5saXN0X2xydV9yZ24pKSB7DQo+ICsgICAg
ICAgICAgICAgICBpZiAodWZzaHBiX2NoZWNrX2lzc3VlX3N0YXRlX3NyZ25zKGhwYiwgcmduKSkg
ew0KU28gaWYgb25lIG9mIGl0cyBzdWJyZWdpb25zIGhhcyBpbmZsaWdodCBtYXAgcmVxdWVzdCAt
IHlvdSBhZGQgaXQgdG8gdGhlICJzdGFydmVkIiBsaXN0Pw0KV2h5IGNhbGwgaXQgc3RhcnZlZD8N
Cg0KDQo+ICtzdGF0aWMgaW50IHVmc2hwYl9pc3N1ZV9tYXBfcmVxKHN0cnVjdCB1ZnNocGJfbHUg
KmhwYiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdWZzaHBiX3Jl
Z2lvbiAqcmduLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB1ZnNo
cGJfc3VicmVnaW9uICpzcmduKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCB1ZnNocGJfcmVxICpt
YXBfcmVxOw0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsgICAgICAgaW50IHJl
dCA9IDA7DQo+ICsNCj4gKyAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmaHBiLT5ocGJfc3RhdGVf
bG9jaywgZmxhZ3MpOw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogU2luY2UgdGhlIHJlZ2lv
biBzdGF0ZSBjaGFuZ2Ugb2NjdXJzIG9ubHkgaW4gdGhlIGhwYiB0YXNrLXdvcmssDQo+ICsgICAg
ICAgICogdGhlIHN0YXRlIG9mIHRoZSByZWdpb24gY2Fubm90IEhQQl9SR05fSU5BQ1RJVkUgYXQg
dGhpcyBwb2ludC4NCj4gKyAgICAgICAgKiBUaGUgcmVnaW9uIHN0YXRlIG11c3QgYmUgY2hhbmdl
ZCBpbiB0aGUgaHBiIHRhc2std29yaw0KSSB0aGluayB0aGF0IHlvdSBjYWxsZWQgdGhpcyB3b3Jr
ZXIgbWFwX3dvcms/DQoNCg0KPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmaHBiLT5ocGJfc3RhdGVfbG9jaywgZmxhZ3MpOw0KPiArICAgICAgICAgICAgICAgcmV0ID0g
dWZzaHBiX2FkZF9yZWdpb24oaHBiLCByZ24pOw0KSWYgdGhpcyBpcyBub3QgYW4gYWN0aXZlIHJl
Z2lvbiwNCkFsdGhvdWdoIHRoZSBkZXZpY2UgaW5kaWNhdGVkIHRvIGFjdGl2YXRlIGEgc3BlY2lm
aWMgc3VicmVnaW9uLCANCllvdSBhcmUgYWN0aXZhdGluZyBhbGwgdGhlIHN1YnJlZ2lvbnMgb2Yg
dGhhdCByZWdpb24uDQpZb3Ugc2hvdWxkIGVsYWJvcmF0ZSBvbiB0aGF0IGluIHlvdXIgY29tbWl0
IGxvZywNCmFuZCBleHBsYWluIHdoeSB0aGlzIGlzIHRoZSBjb3JyZWN0IGFjdGl2YXRpb24gY291
cnNlLg0KDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBJZiB0aGUgYWN0aXZlIHJlZ2lvbiBh
bmQgdGhlIGluYWN0aXZlIHJlZ2lvbiBhcmUgdGhlIHNhbWUsDQo+ICsgICAgICAgICogd2Ugd2ls
bCBpbmFjdGl2YXRlIHRoaXMgcmVnaW9uLg0KPiArICAgICAgICAqIFRoZSBkZXZpY2UgY291bGQg
Y2hlY2sgdGhpcyAocmVnaW9uIGluYWN0aXZhdGVkKSBhbmQNCj4gKyAgICAgICAgKiB3aWxsIHJl
c3BvbnNlIHRoZSBwcm9wZXIgYWN0aXZlIHJlZ2lvbiBpbmZvcm1hdGlvbg0KPiArICAgICAgICAq
Lw0KPiArICAgICAgIHNwaW5fbG9jaygmaHBiLT5yc3BfbGlzdF9sb2NrKTsNCj4gKyAgICAgICBm
b3IgKGkgPSAwOyBpIDwgcnNwX2ZpZWxkLT5hY3RpdmVfcmduX2NudDsgaSsrKSB7DQo+ICsgICAg
ICAgICAgICAgICByZ25faWR4ID0NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYmUxNl90b19j
cHUocnNwX2ZpZWxkLT5ocGJfYWN0aXZlX2ZpZWxkW2ldLmFjdGl2ZV9yZ24pOw0KPiArICAgICAg
ICAgICAgICAgc3Jnbl9pZHggPQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBiZTE2X3RvX2Nw
dShyc3BfZmllbGQtPmhwYl9hY3RpdmVfZmllbGRbaV0uYWN0aXZlX3NyZ24pOw0KZ2V0X3VuYWxp
Z25lZCBpbnN0ZWFkIG9mIGJlMTZfdG9fY3B1ID8NCg0KPiArDQo+ICsgICAgICAgICAgICAgICBk
ZXZfZGJnKCZocGItPmhwYl9sdV9kZXYsICJhY3RpdmF0ZSglZCkgcmVnaW9uICVkIC0gJWRcbiIs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGksIHJnbl9pZHgsIHNyZ25faWR4KTsNCj4gKyAg
ICAgICAgICAgICAgIHVmc2hwYl91cGRhdGVfYWN0aXZlX2luZm8oaHBiLCByZ25faWR4LCBzcmdu
X2lkeCk7DQo+ICsgICAgICAgICAgICAgICBhdG9taWNfaW5jKCZocGItPnN0YXRzLnJiX2FjdGl2
ZV9jbnQpOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCByc3Bf
ZmllbGQtPmluYWN0aXZlX3Jnbl9jbnQ7IGkrKykgew0KPiArICAgICAgICAgICAgICAgcmduX2lk
eCA9IGJlMTZfdG9fY3B1KHJzcF9maWVsZC0+aHBiX2luYWN0aXZlX2ZpZWxkW2ldKTsNCj4gKyAg
ICAgICAgICAgICAgIGRldl9kYmcoJmhwYi0+aHBiX2x1X2RldiwgImluYWN0aXZhdGUoJWQpIHJl
Z2lvbiAlZFxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaSwgcmduX2lkeCk7DQo+ICsg
ICAgICAgICAgICAgICB1ZnNocGJfdXBkYXRlX2luYWN0aXZlX2luZm8oaHBiLCByZ25faWR4KTsN
Cj4gKyAgICAgICAgICAgICAgIGF0b21pY19pbmMoJmhwYi0+c3RhdHMucmJfaW5hY3RpdmVfY250
KTsNCj4gKyAgICAgICB9DQo+ICsgICAgICAgc3Bpbl91bmxvY2soJmhwYi0+cnNwX2xpc3RfbG9j
ayk7DQo+ICsNCj4gKyAgICAgICBkZXZfZGJnKCZocGItPmhwYl9sdV9kZXYsICJOb3RpOiAjQUNU
ICV1ICNJTkFDVCAldVxuIiwNCj4gKyAgICAgICAgICAgICAgIHJzcF9maWVsZC0+YWN0aXZlX3Jn
bl9jbnQsIHJzcF9maWVsZC0+aW5hY3RpdmVfcmduX2NudCk7DQo+ICsNCj4gKyAgICAgICBxdWV1
ZV93b3JrKHVmc2hwYl9kcnYudWZzaHBiX3dxLCAmaHBiLT5tYXBfd29yayk7DQo+ICt9DQo+ICsN
Cj4gKy8qIHJvdXRpbmUgOiBpc3IgKHVmcykgKi8NCj4gK3N0YXRpYyB2b2lkIHVmc2hwYl9yc3Bf
dXBpdShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3QgdWZzaGNkX2xyYiAqbHJicCkNCj4gK3sN
Cj4gKyAgICAgICBzdHJ1Y3QgdWZzaHBiX2x1ICpocGI7DQo+ICsgICAgICAgc3RydWN0IHVmc2hw
Yl9yc3BfZmllbGQgKnJzcF9maWVsZDsNCj4gKyAgICAgICBpbnQgZGF0YV9zZWdfbGVuLCByZXQ7
DQo+ICsNCj4gKyAgICAgICBkYXRhX3NlZ19sZW4gPSBiZTMyX3RvX2NwdShscmJwLT51Y2RfcnNw
X3B0ci0+aGVhZGVyLmR3b3JkXzIpDQo+ICsgICAgICAgICAgICAgICAmIE1BU0tfUlNQX1VQSVVf
REFUQV9TRUdfTEVOOw0KZ2V0X3VuYWxpZ25lZCBpbnN0ZWFkIG9mIGJlMzJfdG9fY3B1ID8NCg0K
PiArDQo+ICsgICAgICAgaWYgKCFkYXRhX3NlZ19sZW4pIHsNCmRhdGFfc2VnX2xlbiBzaG91bGQg
YmUgREVWX0RBVEFfU0VHX0xFTiwgYW5kIHlvdSBzaG91bGQgYWxzbyBjaGVjayBIUEJfVVBEQVRF
X0FMRVJULA0Kd2hpY2ggeW91IG1pZ2h0IHdhbnQgdG8gZG8gaGVyZSBhbmQgbm90IGluIHVmc2hw
Yl9tYXlfZmllbGRfdmFsaWQNCg0KPiArICAgICAgICAgICAgICAgaWYgKCF1ZnNocGJfaXNfZ2Vu
ZXJhbF9sdW4obHJicC0+bHVuKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiArDQo+ICsgICAgICAgICAgICAgICBocGIgPSB1ZnNocGJfZ2V0X2hwYl9kYXRhKGxyYnAtPmNt
ZCk7DQo+ICsgICAgICAgICAgICAgICByZXQgPSB1ZnNocGJfbHVfZ2V0KGhwYik7DQo+ICsgICAg
ICAgICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+
ICsNCj4gKyAgICAgICAgICAgICAgIGlmICghdWZzaHBiX2lzX2VtcHR5X3JzcF9saXN0cyhocGIp
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZV93b3JrKHVmc2hwYl9kcnYudWZzaHBi
X3dxLCAmaHBiLT5tYXBfd29yayk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gcHV0X2hw
YjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByc3BfZmllbGQgPSB1ZnNocGJfZ2V0X2hw
Yl9yc3AobHJicCk7DQo+ICsgICAgICAgaWYgKHVmc2hwYl9tYXlfZmllbGRfdmFsaWQoaGJhLCBs
cmJwLCByc3BfZmllbGQpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArDQo+ICsgICAg
ICAgaHBiID0gdWZzaHBiX2dldF9ocGJfZGF0YShscmJwLT5jbWQpOw0KPiArICAgICAgIHJldCA9
IHVmc2hwYl9sdV9nZXQoaHBiKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiArDQo+ICsgICAgICAgYXRvbWljX2luYygmaHBiLT5zdGF0cy5yYl9ub3Rp
X2NudCk7DQo+ICsNCj4gKyAgICAgICBzd2l0Y2ggKHJzcF9maWVsZC0+aHBiX3R5cGUpIHsNCj4g
KyAgICAgICBjYXNlIEhQQl9SU1BfUkVRX1JFR0lPTl9VUERBVEU6DQo+ICsgICAgICAgICAgICAg
ICBXQVJOX09OKGRhdGFfc2VnX2xlbiAhPSBERVZfREFUQV9TRUdfTEVOKTsNCj4gKyAgICAgICAg
ICAgICAgIHVmc2hwYl9yc3BfcmVxX3JlZ2lvbl91cGRhdGUoaHBiLCByc3BfZmllbGQpOw0KPiAr
ICAgICAgICAgICAgICAgYnJlYWs7DQpXaGF0IGFib3V0IGhwYiBkZXYgcmVzZXQgLSBvcGVyIDB4
Mj8NCg0KDQo+ICsgICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICAgIGRldl9ub3RpY2Uo
JmhwYi0+aHBiX2x1X2RldiwgImhwYl90eXBlIGlzIG5vdCBhdmFpbGFibGU6ICVkXG4iLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICByc3BfZmllbGQtPmhwYl90eXBlKTsNCj4gKyAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIH0NCj4gK3B1dF9ocGI6DQo+ICsgICAgICAgdWZz
aHBiX2x1X3B1dChocGIpOw0KPiArfQ0KPiArDQoNCg0KPiArc3RhdGljIHZvaWQgdWZzaHBiX2Fk
ZF9hY3RpdmVfbGlzdChzdHJ1Y3QgdWZzaHBiX2x1ICpocGIsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHVmc2hwYl9yZWdpb24gKnJnbiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdWZzaHBiX3N1YnJlZ2lvbiAqc3JnbikN
Cj4gK3sNCj4gKyAgICAgICBpZiAoIWxpc3RfZW1wdHkoJnJnbi0+bGlzdF9pbmFjdF9yZ24pKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArDQo+ICsgICAgICAgaWYgKCFsaXN0X2VtcHR5
KCZzcmduLT5saXN0X2FjdF9zcmduKSkgew0KPiArICAgICAgICAgICAgICAgbGlzdF9tb3ZlKCZz
cmduLT5saXN0X2FjdF9zcmduLCAmaHBiLT5saF9hY3Rfc3Jnbik7DQpXaHkgaXMgdGhpcyBuZWVk
ZWQ/DQpXaHkgdXBkYXRpbmcgdGhpcyBzdWJyZWdpb24gcG9zaXRpb24/DQoNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBsaXN0X2FkZCgmc3Jn
bi0+bGlzdF9hY3Rfc3JnbiwgJmhwYi0+bGhfYWN0X3NyZ24pOw0KPiArfQ0KDQoNCj4gQEAgLTE5
NSw4ICsxMDQ3LDE1IEBAIHN0YXRpYyBpbnQgdWZzaHBiX2FsbG9jX3JlZ2lvbl90Ymwoc3RydWN0
IHVmc19oYmENCj4gKmhiYSwgc3RydWN0IHVmc2hwYl9sdSAqaHBiKQ0KPiAgcmVsZWFzZV9zcmdu
X3RhYmxlOg0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCByZ25faWR4OyBpKyspIHsNCj4gICAg
ICAgICAgICAgICAgIHJnbiA9IHJnbl90YWJsZSArIGk7DQo+IC0gICAgICAgICAgICAgICBpZiAo
cmduLT5zcmduX3RibCkNCj4gKyAgICAgICAgICAgICAgIGlmIChyZ24tPnNyZ25fdGJsKSB7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoc3Jnbl9pZHggPSAwOyBzcmduX2lkeCA8IHJn
bi0+c3Jnbl9jbnQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Jnbl9pZHgrKykg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNyZ24gPSByZ24tPnNyZ25fdGJs
ICsgc3Jnbl9pZHg7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNyZ24t
Pm1jdHgpDQpIb3cgaXMgaXQgZXZlbiBwb3NzaWJsZSB0aGF0IG9uIGluaXQgdGhlcmUgaXMgYW4g
YWN0aXZlIHN1YnJlZ2lvbj8NCnVmc2hwYl9pbml0X3Bpbm5lZF9hY3RpdmVfcmVnaW9uIGRvZXMg
aXRzIG93biBjbGVhbnVwLg0KDQo+ICsgICAgICAgaHBiLT5tX3BhZ2VfY2FjaGUgPSBrbWVtX2Nh
Y2hlX2NyZWF0ZSgidWZzaHBiX21fcGFnZV9jYWNoZSIsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKHN0cnVjdCBwYWdlICopICogaHBiLT5wYWdlc19wZXJfc3JnbiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCBOVUxMKTsNCldoYXQgaXMgdGhlIGFkdmFudGFn
ZSBpbiB1c2luZyBhbiBhcnJheSBvZiBwYWdlIHBvaW50ZXJzLA0KSW5zdGVhZCBvZiBhIHNpbmds
ZSBwb2ludGVyIHRvIHBhZ2VzX3Blcl9zcmduPw0KDQogDQoNCj4gQEAgLTM5OCw2ICsxMzI2LDkg
QEAgc3RhdGljIHZvaWQgdWZzaHBiX3Jlc3VtZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiANCj4g
ICAgICAgICAgICAgICAgIGRldl9pbmZvKCZocGItPmhwYl9sdV9kZXYsICJ1ZnNocGIgcmVzdW1l
Iik7DQo+ICAgICAgICAgICAgICAgICB1ZnNocGJfc2V0X3N0YXRlKGhwYiwgSFBCX1BSRVNFTlQp
Ow0KPiArICAgICAgICAgICAgICAgaWYgKCF1ZnNocGJfaXNfZW1wdHlfcnNwX2xpc3RzKGhwYikp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHF1ZXVlX3dvcmsodWZzaHBiX2Rydi51ZnNocGJf
d3EsICZocGItPm1hcF93b3JrKTsNCkFoaGEgLSBzbyB5b3UgYXJlIHVzaW5nIHRoZSB1ZnMgZHJp
dmVyIHBtIGZsb3dzIHRvIHBvbGwgeW91ciB3b3JrIHF1ZXVlLg0KV2h5IGRldmljZSByZWNvbW1l
bmRhdGlvbnMgaXNuJ3QgZW5vdWdoPw0KDQo+ICsNCj4gICAgICAgICAgICAgICAgIHVmc2hwYl9s
dV9wdXQoaHBiKTsNCj4gICAgICAgICB9DQo+ICB9DQoNClRoYW5rcywNCkF2cmkNCg==
