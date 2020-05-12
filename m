Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC681CF2DA
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2020 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgELKsS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 May 2020 06:48:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46695 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729562AbgELKr7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 May 2020 06:47:59 -0400
X-UUID: 8cf5f21aa8b74f04ab057e26a294a8f6-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WOoU1J20WnftJm5Uc9Ijpskv9v6giRhPTTZph1ObLMg=;
        b=VO84Uakq8sXEycU/82wnvka9mCVrsyNXVd+UeFFoLMeiXFkqbO8nmEtkVLVmJkV2G3lEKebE+oCqk9P5qAZJtW4CcobF6M5tS1vRDbJN7WiFqo0niwnil60rTkwVfmyvG1Rf1rGEtmbFcniepvGBlQUIlI0O9IaF7NlMy3m6NqQ=;
X-UUID: 8cf5f21aa8b74f04ab057e26a294a8f6-20200512
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 459613446; Tue, 12 May 2020 18:47:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 18:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 18:47:51 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>, <asutoshd@codeaurora.org>
CC:     <beanhuo@micron.com>, <cang@codeaurora.org>,
        <matthias.bgg@gmail.com>, <bvanassche@acm.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 3/4] scsi: ufs: Fix index of attributes query for WriteBooster feature
Date:   Tue, 12 May 2020 18:47:49 +0800
Message-ID: <20200512104750.8711-4-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200512104750.8711-1-stanley.chu@mediatek.com>
References: <20200512104750.8711-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Rm9yIFdyaXRlQm9vc3RlciBmZWF0dXJlIHJlbGF0ZWQgYXR0cmlidXRlcywgdGhlIGluZGV4IHVz
ZWQgYnkNCnF1ZXJ5IHNoYWxsIGJlIExVTiBJRCBpZiBMVSBEZWRpY2F0ZWQgYnVmZmVyIG1vZGUg
aXMgZW5hYmxlZC4NCg0KU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgfCAxMyArKysr
KysrKysrKy0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyAgICB8IDE2ICsrKysrKysrKyst
LS0tLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oICAgIHwgIDIgKy0NCiAzIGZpbGVzIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMu
Yw0KaW5kZXggYTBiMzc2M2UxZGMyLi4yZDcxZDIzMmE2OWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3Njc2kvdWZzL3Vmcy1zeXNmcy5jDQorKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5j
DQpAQCAtNjM3LDcgKzYzNyw3IEBAIHN0YXRpYyBzc2l6ZV90IF9uYW1lIyNfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCQkJCVwNCiAJaW50IHJldDsJCQkJCQkJXA0KIAlzdHJ1Y3QgdWZzX2hiYSAq
aGJhID0gZGV2X2dldF9kcnZkYXRhKGRldik7CQkJXA0KIAlpZiAodWZzaGNkX2lzX3diX2ZsYWdz
KFFVRVJZX0ZMQUdfSUROIyNfdW5hbWUpKQkJCVwNCi0JCWluZGV4ID0gdWZzaGNkX3diX2dldF9m
bGFnX2luZGV4KGhiYSk7CQkJXA0KKwkJaW5kZXggPSB1ZnNoY2Rfd2JfZ2V0X3F1ZXJ5X2luZGV4
KGhiYSk7CQkJXA0KIAlwbV9ydW50aW1lX2dldF9zeW5jKGhiYS0+ZGV2KTsJCQkJCVwNCiAJcmV0
ID0gdWZzaGNkX3F1ZXJ5X2ZsYWcoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9SRUFEX0ZMQUcsCVwN
CiAJCVFVRVJZX0ZMQUdfSUROIyNfdW5hbWUsIGluZGV4LCAmZmxhZyk7CQkJXA0KQEAgLTY4MCw2
ICs2ODAsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgdWZzX3N5c2Zz
X2ZsYWdzX2dyb3VwID0gew0KIAkuYXR0cnMgPSB1ZnNfc3lzZnNfZGV2aWNlX2ZsYWdzLA0KIH07
DQogDQorc3RhdGljIGlubGluZSBib29sIHVmc2hjZF9pc193Yl9hdHRycyhlbnVtIGF0dHJfaWRu
IGlkbikNCit7DQorCXJldHVybiAoKGlkbiA+PSBRVUVSWV9BVFRSX0lETl9XQl9GTFVTSF9TVEFU
VVMpICYmDQorCQkoaWRuIDw9IFFVRVJZX0FUVFJfSUROX0NVUlJfV0JfQlVGRl9TSVpFKSk7DQor
fQ0KKw0KICNkZWZpbmUgVUZTX0FUVFJJQlVURShfbmFtZSwgX3VuYW1lKQkJCQkJXA0KIHN0YXRp
YyBzc2l6ZV90IF9uYW1lIyNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCQkJCVwNCiAJc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikJCQlcDQpAQCAtNjg3LDkgKzY5Mywx
MiBAQCBzdGF0aWMgc3NpemVfdCBfbmFtZSMjX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAkJCQlc
DQogCXN0cnVjdCB1ZnNfaGJhICpoYmEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsJCQlcDQogCXUz
MiB2YWx1ZTsJCQkJCQkJXA0KIAlpbnQgcmV0OwkJCQkJCQlcDQorCXU4IGluZGV4ID0gMDsJCQkJ
CQkJXA0KKwlpZiAodWZzaGNkX2lzX3diX2F0dHJzKFFVRVJZX0FUVFJfSUROIyNfdW5hbWUpKQkJ
CVwNCisJCWluZGV4ID0gdWZzaGNkX3diX2dldF9xdWVyeV9pbmRleChoYmEpOwkJCVwNCiAJcG1f
cnVudGltZV9nZXRfc3luYyhoYmEtPmRldik7CQkJCQlcDQogCXJldCA9IHVmc2hjZF9xdWVyeV9h
dHRyKGhiYSwgVVBJVV9RVUVSWV9PUENPREVfUkVBRF9BVFRSLAlcDQotCQlRVUVSWV9BVFRSX0lE
TiMjX3VuYW1lLCAwLCAwLCAmdmFsdWUpOwkJCVwNCisJCVFVRVJZX0FUVFJfSUROIyNfdW5hbWUs
IGluZGV4LCAwLCAmdmFsdWUpOwkJXA0KIAlwbV9ydW50aW1lX3B1dF9zeW5jKGhiYS0+ZGV2KTsJ
CQkJCVwNCiAJaWYgKHJldCkJCQkJCQkJXA0KIAkJcmV0dXJuIC1FSU5WQUw7CQkJCQkJXA0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5jDQppbmRleCBiMjk4YmRkM2U2OTcuLjE2OWEzMzc5ZTQ2OCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMN
CkBAIC01MjEyLDcgKzUyMTIsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF93Yl9jdHJsKHN0cnVjdCB1
ZnNfaGJhICpoYmEsIGJvb2wgZW5hYmxlKQ0KIAllbHNlDQogCQlvcGNvZGUgPSBVUElVX1FVRVJZ
X09QQ09ERV9DTEVBUl9GTEFHOw0KIA0KLQlpbmRleCA9IHVmc2hjZF93Yl9nZXRfZmxhZ19pbmRl
eChoYmEpOw0KKwlpbmRleCA9IHVmc2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJhKTsNCiAJcmV0
ID0gdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBvcGNvZGUsDQogCQkJCSAgICAgIFFVRVJZ
X0ZMQUdfSUROX1dCX0VOLCBpbmRleCwgTlVMTCk7DQogCWlmIChyZXQpIHsNCkBAIC01MjM4LDcg
KzUyMzgsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF93Yl90b2dnbGVfZmx1c2hfZHVyaW5nX2g4KHN0
cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgc2V0KQ0KIAllbHNlDQogCQl2YWwgPSBVUElVX1FVRVJZ
X09QQ09ERV9DTEVBUl9GTEFHOw0KIA0KLQlpbmRleCA9IHVmc2hjZF93Yl9nZXRfZmxhZ19pbmRl
eChoYmEpOw0KKwlpbmRleCA9IHVmc2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJhKTsNCiAJcmV0
dXJuIHVmc2hjZF9xdWVyeV9mbGFnX3JldHJ5KGhiYSwgdmFsLA0KIAkJCQlRVUVSWV9GTEFHX0lE
Tl9XQl9CVUZGX0ZMVVNIX0RVUklOR19ISUJFUk44LA0KIAkJCQlpbmRleCwgTlVMTCk7DQpAQCAt
NTI2MSw3ICs1MjYxLDcgQEAgc3RhdGljIGludCB1ZnNoY2Rfd2JfYnVmX2ZsdXNoX2VuYWJsZShz
dHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAlpZiAoIXVmc2hjZF9pc193Yl9hbGxvd2VkKGhiYSkgfHwg
aGJhLT53Yl9idWZfZmx1c2hfZW5hYmxlZCkNCiAJCXJldHVybiAwOw0KIA0KLQlpbmRleCA9IHVm
c2hjZF93Yl9nZXRfZmxhZ19pbmRleChoYmEpOw0KKwlpbmRleCA9IHVmc2hjZF93Yl9nZXRfcXVl
cnlfaW5kZXgoaGJhKTsNCiAJcmV0ID0gdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBVUElV
X1FVRVJZX09QQ09ERV9TRVRfRkxBRywNCiAJCQkJICAgICAgUVVFUllfRkxBR19JRE5fV0JfQlVG
Rl9GTFVTSF9FTiwNCiAJCQkJICAgICAgaW5kZXgsIE5VTEwpOw0KQEAgLTUyODMsNyArNTI4Myw3
IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3diX2J1Zl9mbHVzaF9kaXNhYmxlKHN0cnVjdCB1ZnNfaGJh
ICpoYmEpDQogCWlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSB8fCAhaGJhLT53Yl9idWZf
Zmx1c2hfZW5hYmxlZCkNCiAJCXJldHVybiAwOw0KIA0KLQlpbmRleCA9IHVmc2hjZF93Yl9nZXRf
ZmxhZ19pbmRleChoYmEpOw0KKwlpbmRleCA9IHVmc2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJh
KTsNCiAJcmV0ID0gdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09QQ09E
RV9DTEVBUl9GTEFHLA0KIAkJCQkgICAgICBRVUVSWV9GTEFHX0lETl9XQl9CVUZGX0ZMVVNIX0VO
LA0KIAkJCQkgICAgICBpbmRleCwgTlVMTCk7DQpAQCAtNTMwMywxMCArNTMwMywxMiBAQCBzdGF0
aWMgYm9vbCB1ZnNoY2Rfd2JfcHJlc3J2X3VzcnNwY19rZWVwX3ZjY19vbihzdHJ1Y3QgdWZzX2hi
YSAqaGJhLA0KIHsNCiAJdTMyIGN1cl9idWY7DQogCWludCByZXQ7DQorCXU4IGluZGV4Ow0KIA0K
KwlpbmRleCA9IHVmc2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJhKTsNCiAJcmV0ID0gdWZzaGNk
X3F1ZXJ5X2F0dHJfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9SRUFEX0FUVFIsDQogCQkJ
CQkgICAgICBRVUVSWV9BVFRSX0lETl9DVVJSX1dCX0JVRkZfU0laRSwNCi0JCQkJCSAgICAgIDAs
IDAsICZjdXJfYnVmKTsNCisJCQkJCSAgICAgIGluZGV4LCAwLCAmY3VyX2J1Zik7DQogCWlmIChy
ZXQpIHsNCiAJCWRldl9lcnIoaGJhLT5kZXYsICIlcyBkQ3VyV3JpdGVCb29zdGVyQnVmZmVyU2l6
ZSByZWFkIGZhaWxlZCAlZFxuIiwNCiAJCQlfX2Z1bmNfXywgcmV0KTsNCkBAIC01MzI5LDYgKzUz
MzEsNyBAQCBzdGF0aWMgYm9vbCB1ZnNoY2Rfd2Jfa2VlcF92Y2Nfb24oc3RydWN0IHVmc19oYmEg
KmhiYSkNCiB7DQogCWludCByZXQ7DQogCXUzMiBhdmFpbF9idWY7DQorCXU4IGluZGV4Ow0KIA0K
IAlpZiAoIXVmc2hjZF9pc193Yl9hbGxvd2VkKGhiYSkpDQogCQlyZXR1cm4gZmFsc2U7DQpAQCAt
NTM0Myw5ICs1MzQ2LDEwIEBAIHN0YXRpYyBib29sIHVmc2hjZF93Yl9rZWVwX3ZjY19vbihzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KIAkgKiBidWZmZXIgKGRDdXJyZW50V3JpdGVCb29zdGVyQnVmZmVy
U2l6ZSkuIFRoZXJlJ3Mgbm8gcG9pbnQgaW4NCiAJICoga2VlcGluZyB2Y2Mgb24gd2hlbiBjdXJy
ZW50IGJ1ZmZlciBpcyBlbXB0eS4NCiAJICovDQorCWluZGV4ID0gdWZzaGNkX3diX2dldF9xdWVy
eV9pbmRleChoYmEpOw0KIAlyZXQgPSB1ZnNoY2RfcXVlcnlfYXR0cl9yZXRyeShoYmEsIFVQSVVf
UVVFUllfT1BDT0RFX1JFQURfQVRUUiwNCiAJCQkJICAgICAgUVVFUllfQVRUUl9JRE5fQVZBSUxf
V0JfQlVGRl9TSVpFLA0KLQkJCQkgICAgICAwLCAwLCAmYXZhaWxfYnVmKTsNCisJCQkJICAgICAg
aW5kZXgsIDAsICZhdmFpbF9idWYpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfd2FybihoYmEtPmRl
diwgIiVzIGRBdmFpbGFibGVXcml0ZUJvb3N0ZXJCdWZmZXJTaXplIHJlYWQgZmFpbGVkICVkXG4i
LA0KIAkJCSBfX2Z1bmNfXywgcmV0KTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5oIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaA0KaW5kZXggMjNhNDM0YzAzYzJhLi5h
YjBkMTgwZGFkNmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQorKysg
Yi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQpAQCAtODYxLDcgKzg2MSw3IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCB1ZnNoY2Rfa2VlcF9hdXRvYmtvcHNfZW5hYmxlZF9leGNlcHRfc3VzcGVuZCgN
CiAJcmV0dXJuIGhiYS0+Y2FwcyAmIFVGU0hDRF9DQVBfS0VFUF9BVVRPX0JLT1BTX0VOQUJMRURf
RVhDRVBUX1NVU1BFTkQ7DQogfQ0KIA0KLXN0YXRpYyBpbmxpbmUgdTggdWZzaGNkX3diX2dldF9m
bGFnX2luZGV4KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQorc3RhdGljIGlubGluZSB1OCB1ZnNoY2Rf
d2JfZ2V0X3F1ZXJ5X2luZGV4KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogew0KIAlpZiAoaGJhLT5k
ZXZfaW5mby5iX3diX2J1ZmZlcl90eXBlID09IFdCX0JVRl9NT0RFX0xVX0RFRElDQVRFRCkNCiAJ
CXJldHVybiBoYmEtPmRldl9pbmZvLndiX2RlZGljYXRlZF9sdTsNCi0tIA0KMi4xOC4wDQo=

