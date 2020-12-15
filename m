Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23FF2DA997
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Dec 2020 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgLOJCC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Dec 2020 04:02:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59403 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726949AbgLOJCC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Dec 2020 04:02:02 -0500
X-UUID: 8a1bf3cab84a4ba680acebf3a27bed0c-20201215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NXkzPQL/VwvmSQBvWolB9uEqb3KVRM+917MGzWN0McM=;
        b=gKVq6rB0x4trl5LOegx2A/4cwREXlip7msOdBKekFH3p2bXJfiA/meJkffnkpOTFeE6b/PQn3bihZ7dVFJvGoydj7E+dgW4igzJW6M73+Y8dj4JNb2OkghhJArJ+262sU8dW0Mqy5tUmDFXi17VVjCvj2+dImbrb2z8pUB4RAsc=;
X-UUID: 8a1bf3cab84a4ba680acebf3a27bed0c-20201215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1264544675; Tue, 15 Dec 2020 17:01:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Dec 2020 17:01:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 17:01:14 +0800
Message-ID: <1608022873.10163.17.camel@mtkswgap22>
Subject: Re: [PATCH v4 3/6] scsi: ufs: Group UFS WB related flags to struct
 ufs_dev_info
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Dec 2020 17:01:13 +0800
In-Reply-To: <20201211140035.20016-4-huobean@gmail.com>
References: <20201211140035.20016-1-huobean@gmail.com>
         <20201211140035.20016-4-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E499427C9C5EFD8744BC2B6E191E364877659CA587EA0C9B9ACA56514E6AC8EF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQmVhbiwNCg0KT24gRnJpLCAyMDIwLTEyLTExIGF0IDE1OjAwICswMTAwLCBCZWFuIEh1byB3
cm90ZToNCj4gRnJvbTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IFVGUyBk
ZXZpY2UtcmVsYXRlZCBmbGFncyBzaG91bGQgYmUgZ3JvdXBlZCBpbiB1ZnNfZGV2X2luZm8uIFRh
a2UNCj4gd2JfZW5hYmxlZCBhbmQgd2JfYnVmX2ZsdXNoX2VuYWJsZWQgb3V0IGZyb20gdGhlIHN0
cnVjdCB1ZnNfaGJhLA0KPiBncm91cCB0aGVtIHRvIHN0cnVjdCB1ZnNfZGV2X2luZm8sIGFuZCBh
bGlnbiB0aGUgbmFtZXMgb2YgdGhlIHN0cnVjdHVyZQ0KPiBtZW1iZXJzIHZlcnRpY2FsbHkNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMuYyB8ICAyICstDQo+ICBkcml2ZXJzL3Njc2kv
dWZzL3Vmcy5oICAgICAgIHwgMzMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+
ICBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAg
ZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaCAgICB8ICAyIC0tDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5j
DQo+IGluZGV4IDJiNGU5ZmU5MzVjYy4uNGJkN2UxOGJiNDg2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLXN5
c2ZzLmMNCj4gQEAgLTE5NCw3ICsxOTQsNyBAQCBzdGF0aWMgc3NpemVfdCB3Yl9vbl9zaG93KHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICB7DQo+
ICAJc3RydWN0IHVmc19oYmEgKmhiYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgDQo+IC0J
cmV0dXJuIHNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVkXG4iLCBoYmEtPndiX2VuYWJsZWQp
Ow0KPiArCXJldHVybiBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlZFxuIiwgaGJhLT5kZXZf
aW5mby53Yl9lbmFibGVkKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHNzaXplX3Qgd2Jfb25fc3Rv
cmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vm
cy5oDQo+IGluZGV4IDE0ZGZkYTczNWFkZi4uNDViZWJjYTI5ZmRkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3Njc2kvdWZzL3Vmcy5oDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmgNCj4g
QEAgLTUyNywyMiArNTI3LDI3IEBAIHN0cnVjdCB1ZnNfdnJlZ19pbmZvIHsNCj4gIH07DQo+ICAN
Cj4gIHN0cnVjdCB1ZnNfZGV2X2luZm8gew0KPiAtCWJvb2wgZl9wb3dlcl9vbl93cF9lbjsNCj4g
Kwlib29sCWZfcG93ZXJfb25fd3BfZW47DQo+ICAJLyogS2VlcHMgaW5mb3JtYXRpb24gaWYgYW55
IG9mIHRoZSBMVSBpcyBwb3dlciBvbiB3cml0ZSBwcm90ZWN0ZWQgKi8NCj4gLQlib29sIGlzX2x1
X3Bvd2VyX29uX3dwOw0KPiArCWJvb2wJaXNfbHVfcG93ZXJfb25fd3A7DQo+ICAJLyogTWF4aW11
bSBudW1iZXIgb2YgZ2VuZXJhbCBMVSBzdXBwb3J0ZWQgYnkgdGhlIFVGUyBkZXZpY2UgKi8NCj4g
LQl1OCBtYXhfbHVfc3VwcG9ydGVkOw0KPiAtCXU4IHdiX2RlZGljYXRlZF9sdTsNCj4gLQl1MTYg
d21hbnVmYWN0dXJlcmlkOw0KPiAtCS8qVUZTIGRldmljZSBQcm9kdWN0IE5hbWUgKi8NCj4gLQl1
OCAqbW9kZWw7DQo+IC0JdTE2IHdzcGVjdmVyc2lvbjsNCj4gLQl1MzIgY2xrX2dhdGluZ193YWl0
X3VzOw0KPiAtCXUzMiBkX2V4dF91ZnNfZmVhdHVyZV9zdXA7DQo+IC0JdTggYl93Yl9idWZmZXJf
dHlwZTsNCj4gLQl1MzIgZF93Yl9hbGxvY191bml0czsNCj4gLQlib29sIGJfcnBtX2Rldl9mbHVz
aF9jYXBhYmxlOw0KPiAtCXU4IGJfcHJlc3J2X3VzcGNfZW47DQo+ICsJdTgJbWF4X2x1X3N1cHBv
cnRlZDsNCj4gKwl1MTYJd21hbnVmYWN0dXJlcmlkOw0KPiArCS8qIFVGUyBkZXZpY2UgUHJvZHVj
dCBOYW1lICovDQo+ICsJdTgJKm1vZGVsOw0KPiArCXUxNgl3c3BlY3ZlcnNpb247DQo+ICsJdTMy
CWNsa19nYXRpbmdfd2FpdF91czsNCj4gKwl1MzIJZF9leHRfdWZzX2ZlYXR1cmVfc3VwOw0KPiAr
DQo+ICsJLyogVUZTIFdCIHJlbGF0ZWQgZmxhZ3MgKi8NCj4gKwlib29sCXdiX2VuYWJsZWQ7DQo+
ICsJYm9vbAl3Yl9idWZfZmx1c2hfZW5hYmxlZDsNCj4gKwl1OAl3Yl9kZWRpY2F0ZWRfbHU7DQo+
ICsJdTgJYl93Yl9idWZmZXJfdHlwZTsNCj4gKwl1MzIJZF93Yl9hbGxvY191bml0czsNCj4gKw0K
PiArCWJvb2wJYl9ycG1fZGV2X2ZsdXNoX2NhcGFibGU7DQo+ICsJdTgJYl9wcmVzcnZfdXNwY19l
bjsNCg0KUGVyaGFwcyB3ZSBjb3VsZCB1bmlmeSB0aGUgc3R5bGUgb2YgdGhlc2UgV0IgcmVsYXRl
ZCBzdHVmZiB0byB3Yl8qID8NCg0KQmVzaWRlcywgSSBhbSBub3Qgc3VyZSBpZiB1c2luZyB0YWIg
aW5zdGVhZCBzcGFjZSBiZXR3ZWVuIHRoZSB0eXBlIGFuZA0KbmFtZSBpbiB0aGlzIHN0cnVjdCBp
cyBhIGdvb2QgaWRlYS4NCg0KVGhhbmtzLA0KU3RhbmxleSBDaHUNCg0KPiAgfTsNCj4gIA0KPiAg
LyoqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9z
Y3NpL3Vmcy91ZnNoY2QuYw0KPiBpbmRleCA2YTU1MzJiNzUyYWEuLjUyOGMyNTdkZjQ4YyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiArKysgYi9kcml2ZXJzL3Nj
c2kvdWZzL3Vmc2hjZC5jDQo+IEBAIC01ODksOCArNTg5LDggQEAgc3RhdGljIHZvaWQgdWZzaGNk
X2RldmljZV9yZXNldChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgCWlmICghZXJyKSB7DQo+ICAJ
CXVmc2hjZF9zZXRfdWZzX2Rldl9hY3RpdmUoaGJhKTsNCj4gIAkJaWYgKHVmc2hjZF9pc193Yl9h
bGxvd2VkKGhiYSkpIHsNCj4gLQkJCWhiYS0+d2JfZW5hYmxlZCA9IGZhbHNlOw0KPiAtCQkJaGJh
LT53Yl9idWZfZmx1c2hfZW5hYmxlZCA9IGZhbHNlOw0KPiArCQkJaGJhLT5kZXZfaW5mby53Yl9l
bmFibGVkID0gZmFsc2U7DQo+ICsJCQloYmEtPmRldl9pbmZvLndiX2J1Zl9mbHVzaF9lbmFibGVk
ID0gZmFsc2U7DQo+ICAJCX0NCj4gIAl9DQo+ICAJaWYgKGVyciAhPSAtRU9QTk9UU1VQUCkNCj4g
QEAgLTUzNTksNyArNTM1OSw3IEBAIGludCB1ZnNoY2Rfd2JfY3RybChzdHJ1Y3QgdWZzX2hiYSAq
aGJhLCBib29sIGVuYWJsZSkNCj4gIAlpZiAoIXVmc2hjZF9pc193Yl9hbGxvd2VkKGhiYSkpDQo+
ICAJCXJldHVybiAwOw0KPiAgDQo+IC0JaWYgKCEoZW5hYmxlIF4gaGJhLT53Yl9lbmFibGVkKSkN
Cj4gKwlpZiAoIShlbmFibGUgXiBoYmEtPmRldl9pbmZvLndiX2VuYWJsZWQpKQ0KPiAgCQlyZXR1
cm4gMDsNCj4gIAlpZiAoZW5hYmxlKQ0KPiAgCQlvcGNvZGUgPSBVUElVX1FVRVJZX09QQ09ERV9T
RVRfRkxBRzsNCj4gQEAgLTUzNzUsNyArNTM3NSw3IEBAIGludCB1ZnNoY2Rfd2JfY3RybChzdHJ1
Y3QgdWZzX2hiYSAqaGJhLCBib29sIGVuYWJsZSkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+
ICANCj4gLQloYmEtPndiX2VuYWJsZWQgPSBlbmFibGU7DQo+ICsJaGJhLT5kZXZfaW5mby53Yl9l
bmFibGVkID0gZW5hYmxlOw0KPiAgCWRldl9kYmcoaGJhLT5kZXYsICIlcyB3cml0ZSBib29zdGVy
ICVzICVkXG4iLA0KPiAgCQkJX19mdW5jX18sIGVuYWJsZSA/ICJlbmFibGUiIDogImRpc2FibGUi
LCByZXQpOw0KPiAgDQo+IEBAIC01NDE1LDcgKzU0MTUsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF93
Yl9idWZfZmx1c2hfZW5hYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICAJaW50IHJldDsNCj4g
IAl1OCBpbmRleDsNCj4gIA0KPiAtCWlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSB8fCBo
YmEtPndiX2J1Zl9mbHVzaF9lbmFibGVkKQ0KPiArCWlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQo
aGJhKSB8fCBoYmEtPmRldl9pbmZvLndiX2J1Zl9mbHVzaF9lbmFibGVkKQ0KPiAgCQlyZXR1cm4g
MDsNCj4gIA0KPiAgCWluZGV4ID0gdWZzaGNkX3diX2dldF9xdWVyeV9pbmRleChoYmEpOw0KPiBA
QCAtNTQyNiw3ICs1NDI2LDcgQEAgc3RhdGljIGludCB1ZnNoY2Rfd2JfYnVmX2ZsdXNoX2VuYWJs
ZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgCQlkZXZfZXJyKGhiYS0+ZGV2LCAiJXMgV0IgLSBi
dWYgZmx1c2ggZW5hYmxlIGZhaWxlZCAlZFxuIiwNCj4gIAkJCV9fZnVuY19fLCByZXQpOw0KPiAg
CWVsc2UNCj4gLQkJaGJhLT53Yl9idWZfZmx1c2hfZW5hYmxlZCA9IHRydWU7DQo+ICsJCWhiYS0+
ZGV2X2luZm8ud2JfYnVmX2ZsdXNoX2VuYWJsZWQgPSB0cnVlOw0KPiAgDQo+ICAJZGV2X2RiZyho
YmEtPmRldiwgIldCIC0gRmx1c2ggZW5hYmxlZDogJWRcbiIsIHJldCk7DQo+ICAJcmV0dXJuIHJl
dDsNCj4gQEAgLTU0MzcsNyArNTQzNyw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3diX2J1Zl9mbHVz
aF9kaXNhYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICAJaW50IHJldDsNCj4gIAl1OCBpbmRl
eDsNCj4gIA0KPiAtCWlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSB8fCAhaGJhLT53Yl9i
dWZfZmx1c2hfZW5hYmxlZCkNCj4gKwlpZiAoIXVmc2hjZF9pc193Yl9hbGxvd2VkKGhiYSkgfHwg
IWhiYS0+ZGV2X2luZm8ud2JfYnVmX2ZsdXNoX2VuYWJsZWQpDQo+ICAJCXJldHVybiAwOw0KPiAg
DQo+ICAJaW5kZXggPSB1ZnNoY2Rfd2JfZ2V0X3F1ZXJ5X2luZGV4KGhiYSk7DQo+IEBAIC01NDQ4
LDcgKzU0NDgsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF93Yl9idWZfZmx1c2hfZGlzYWJsZShzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgCQlkZXZfd2FybihoYmEtPmRldiwgIiVzOiBXQiAtIGJ1ZiBm
bHVzaCBkaXNhYmxlIGZhaWxlZCAlZFxuIiwNCj4gIAkJCSBfX2Z1bmNfXywgcmV0KTsNCj4gIAl9
IGVsc2Ugew0KPiAtCQloYmEtPndiX2J1Zl9mbHVzaF9lbmFibGVkID0gZmFsc2U7DQo+ICsJCWhi
YS0+ZGV2X2luZm8ud2JfYnVmX2ZsdXNoX2VuYWJsZWQgPSBmYWxzZTsNCj4gIAkJZGV2X2RiZyho
YmEtPmRldiwgIldCIC0gRmx1c2ggZGlzYWJsZWQ6ICVkXG4iLCByZXQpOw0KPiAgCX0NCj4gIA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaCBiL2RyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLmgNCj4gaW5kZXggMmE5NzAwNmEyYzkzLi40NWMzZWNhODhmMGUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCj4gKysrIGIvZHJpdmVycy9zY3NpL3Vm
cy91ZnNoY2QuaA0KPiBAQCAtODA1LDggKzgwNSw2IEBAIHN0cnVjdCB1ZnNfaGJhIHsNCj4gIA0K
PiAgCXN0cnVjdCBkZXZpY2UJCWJzZ19kZXY7DQo+ICAJc3RydWN0IHJlcXVlc3RfcXVldWUJKmJz
Z19xdWV1ZTsNCj4gLQlib29sIHdiX2J1Zl9mbHVzaF9lbmFibGVkOw0KPiAtCWJvb2wgd2JfZW5h
YmxlZDsNCj4gIAlzdHJ1Y3QgZGVsYXllZF93b3JrIHJwbV9kZXZfZmx1c2hfcmVjaGVja193b3Jr
Ow0KPiAgDQo+ICAjaWZkZWYgQ09ORklHX1NDU0lfVUZTX0NSWVBUTw0KDQo=

