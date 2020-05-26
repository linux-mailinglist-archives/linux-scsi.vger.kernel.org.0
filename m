Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6741C9F4B
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2020 01:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGXvD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 19:51:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62743 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgEGXvC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 19:51:02 -0400
X-UUID: d4a0d81a670149c6b1bccba1ad43e72a-20200508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7rh/xNev2bozJWN2jpMZ42zVTLpDJdHHe0AkEEw+riA=;
        b=pqFEksD4ggHIegkXQTKEXf1adsl5Vqtd0yZnmajUF+a+blHp8FILsOHUVYw9VzM/gpWlB6ro5kDxk/mgk7MHROeC9ni2GDgFUfEsi2aqjAnH3F7nk4EepCgVyfXnPbpGzoU3MuXgX/SJMbIVgkQlBKzBJQ4pHj9y7Rab2BgVBX8=;
X-UUID: d4a0d81a670149c6b1bccba1ad43e72a-20200508
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1143080490; Fri, 08 May 2020 07:50:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 May 2020 07:50:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 May 2020 07:50:54 +0800
Message-ID: <1588895457.3197.40.camel@mtkswgap22>
Subject: Re: [PATCH v5 1/8] scsi: ufs: enable WriteBooster on some pre-3.1
 UFS devices
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Date:   Fri, 8 May 2020 07:50:57 +0800
In-Reply-To: <1588602837.3197.32.camel@mtkswgap22>
References: <20200503113415.21034-1-stanley.chu@mediatek.com>
         <20200503113415.21034-2-stanley.chu@mediatek.com>
         <BYAPR04MB4629F2C00ABAB512DB833232FCA60@BYAPR04MB4629.namprd04.prod.outlook.com>
         <1588602837.3197.32.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E528BD5724FFA756FDB6C319DCE7ED3EFAD25D9B4B53F50DE16DB1ECC31FC39B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQXZyaSwNCk9uIE1vbiwgMjAyMC0wNS0wNCBhdCAyMjozMyArMDgwMCwgU3RhbmxleSBDaHUg
d3JvdGU6DQo+IEhpIEF2cmksDQo+IA0KPiBPbiBNb24sIDIwMjAtMDUtMDQgYXQgMTA6MzcgKzAw
MDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiAgc3RhdGljIHZvaWQgdWZzaGNk
X3diX3Byb2JlKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHU4ICpkZXNjX2J1ZikNCj4gPiA+ICB7DQo+
ID4gPiArICAgICAgIGlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSkNCj4gPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm47DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlmIChoYmEtPmRlc2Nf
c2l6ZS5kZXZfZGVzYyA8PQ0KPiA+ID4gREVWSUNFX0RFU0NfUEFSQU1fRVhUX1VGU19GRUFUVVJF
X1NVUCkNCj4gPiBTaG91bGQgYmUgDQo+ID4gREVWSUNFX0RFU0NfUEFSQU1fRVhUX1VGU19GRUFU
VVJFX1NVUCArIDQgDQo+IA0KPiBJIHRoaW5rIHRoaXMgZGVzY3JpcHRpb24gbGVuZ3RoIGNoZWNr
IGlzIHJlZHVuZGFudCBiZWNhdXNlIHRoZSBkZXZpY2UNCj4gcXVpcmsgc2hhbGwgYmUgYWRkZWQg
b25seSBhZnRlciBXcml0ZUJvb3N0ZXIgc3VwcG9ydGF0IGlzIGNvbmZpcm1lZCBpbg0KPiBhdHRh
Y2hlZCBVRlMgZGV2aWNlLiBTbyBJIHdpbGwgcmVtb3ZlIHRoaXMgaW4gbmV4dCB2ZXJzaW9uLg0K
DQpTb3JyeSB0aGlzIHN0YXRlbWVudCBpcyBpbmNvcnJlY3QgYmVjYXVzZSB0aGlzIGtpbmQgb24g
ZGV2aWNlcyBtYXkgaGF2ZQ0Kc2hvcnQgKHdpdGhvdXQgREVWSUNFX0RFU0NfUEFSQU1fRVhUX1VG
U19GRUFUVVJFX1NVUCBmaWVsZCkgYmVmb3JlDQpmaXJtd2FyZSB1cGdyYWRpbmcuIFNvIHRoZSBj
aGVja2luZyBmb3IgZGVzY3JpcHRvciBsZW5ndGggaXMgc3RpbGwNCnJlcXVpcmVkIHRvIGF2b2lk
IG91dC1vZi1ib3VuZGFyeSBhY2Nlc3MgaW4gYmVsb3cgY29kZXMuDQoNCkkgd2lsbCBhZGQgaXQg
YmFjayBpbiBuZXh0IHZlcnNpb24gYW5kIGFsc28gZml4IHRoZSBsZW5ndGguDQoNClRoYW5rcywN
ClN0YW5sZXkgQ2h1DQoNCj4gPiANCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiA+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiA+IExp
bnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQo+IA0KDQo=

