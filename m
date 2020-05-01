Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3FB1C17EA
	for <lists+linux-scsi@lfdr.de>; Fri,  1 May 2020 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgEAOiq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 May 2020 10:38:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32383 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728894AbgEAOip (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 May 2020 10:38:45 -0400
X-UUID: 2354f5e60c2d4654b590ffac5063f52c-20200501
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9zpy3Z360xbpsbBXHLy0D+vzh40UNAdJ6ZZreHY+ip4=;
        b=hI7rt9Agjv8QsxGTCFtwyZwuqGxSkHn8retccFn/b52syYLiWBRCJeSjX662CQpY5I8mfXhTr+OwEP4c8dAf4D4DW2izTgcUqY3gDAEQyFlW1/3Z1RLUSHeBm09YBwF4OsAYNVyFLQiLWnsDELH44D2EH2F2qcRU2FGot77qfYc=;
X-UUID: 2354f5e60c2d4654b590ffac5063f52c-20200501
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 238855842; Fri, 01 May 2020 22:38:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 May 2020 22:38:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 May 2020 22:38:34 +0800
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
Subject: [PATCH v3 2/5] scsi: ufs: add "index" in parameter list of ufshcd_query_flag()
Date:   Fri, 1 May 2020 22:38:32 +0800
Message-ID: <20200501143835.26032-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200501143835.26032-1-stanley.chu@mediatek.com>
References: <20200501143835.26032-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Rm9yIHByZXBhcmF0aW9uIG9mIExVIERlZGljYXRlZCBidWZmZXIgbW9kZSBzdXBwb3J0IG9uIFdy
aXRlQm9vc3Rlcg0KZmVhdHVyZSwgImluZGV4IiBwYXJhbWV0ZXIgc2hhbGwgYmUgYWRkZWQgYW5k
IGFsbG93ZWQgdG8gYmUgc3BlY2lmaWVkDQpieSBjYWxsZXJzLg0KDQpTaWduZWQtb2ZmLWJ5OiBT
dGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEJlYW4g
SHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQotLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNm
cy5jIHwgIDIgKy0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jICAgIHwgMjggKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmggICAgfCAgMiAr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jIGIvZHJpdmVycy9zY3Np
L3Vmcy91ZnMtc3lzZnMuYw0KaW5kZXggOTM0ODQ0MDhiYzQwLi5iODZiNmE0MGQ3ZTYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jDQorKysgYi9kcml2ZXJzL3Njc2kv
dWZzL3Vmcy1zeXNmcy5jDQpAQCAtNjMxLDcgKzYzMSw3IEBAIHN0YXRpYyBzc2l6ZV90IF9uYW1l
IyNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCQkJCVwNCiAJc3RydWN0IHVmc19oYmEgKmhiYSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwkJCVwNCiAJcG1fcnVudGltZV9nZXRfc3luYyhoYmEtPmRl
dik7CQkJCQlcDQogCXJldCA9IHVmc2hjZF9xdWVyeV9mbGFnKGhiYSwgVVBJVV9RVUVSWV9PUENP
REVfUkVBRF9GTEFHLAlcDQotCQlRVUVSWV9GTEFHX0lETiMjX3VuYW1lLCAmZmxhZyk7CQkJCVwN
CisJCVFVRVJZX0ZMQUdfSUROIyNfdW5hbWUsIDAsICZmbGFnKTsJCQlcDQogCXBtX3J1bnRpbWVf
cHV0X3N5bmMoaGJhLT5kZXYpOwkJCQkJXA0KIAlpZiAocmV0KQkJCQkJCQlcDQogCQlyZXR1cm4g
LUVJTlZBTDsJCQkJCQlcDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyBi
L2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCmluZGV4IGM2NjY4Nzk5ZDk1Ni4uZjIzNzA1Mzc5
YjdkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KKysrIGIvZHJpdmVy
cy9zY3NpL3Vmcy91ZnNoY2QuYw0KQEAgLTI3ODQsMTMgKzI3ODQsMTMgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIHVmc2hjZF9pbml0X3F1ZXJ5KHN0cnVjdCB1ZnNfaGJhICpoYmEsDQogfQ0KIA0KIHN0
YXRpYyBpbnQgdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoc3RydWN0IHVmc19oYmEgKmhiYSwNCi0J
ZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLCBlbnVtIGZsYWdfaWRuIGlkbiwgYm9vbCAqZmxhZ19y
ZXMpDQorCWVudW0gcXVlcnlfb3Bjb2RlIG9wY29kZSwgZW51bSBmbGFnX2lkbiBpZG4sIHU4IGlu
ZGV4LCBib29sICpmbGFnX3JlcykNCiB7DQogCWludCByZXQ7DQogCWludCByZXRyaWVzOw0KIA0K
IAlmb3IgKHJldHJpZXMgPSAwOyByZXRyaWVzIDwgUVVFUllfUkVRX1JFVFJJRVM7IHJldHJpZXMr
Kykgew0KLQkJcmV0ID0gdWZzaGNkX3F1ZXJ5X2ZsYWcoaGJhLCBvcGNvZGUsIGlkbiwgZmxhZ19y
ZXMpOw0KKwkJcmV0ID0gdWZzaGNkX3F1ZXJ5X2ZsYWcoaGJhLCBvcGNvZGUsIGlkbiwgaW5kZXgs
IGZsYWdfcmVzKTsNCiAJCWlmIChyZXQpDQogCQkJZGV2X2RiZyhoYmEtPmRldiwNCiAJCQkJIiVz
OiBmYWlsZWQgd2l0aCBlcnJvciAlZCwgcmV0cmllcyAlZFxuIiwNCkBAIC0yODExLDE2ICsyODEx
LDE3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoc3RydWN0IHVmc19oYmEg
KmhiYSwNCiAgKiBAaGJhOiBwZXItYWRhcHRlciBpbnN0YW5jZQ0KICAqIEBvcGNvZGU6IGZsYWcg
cXVlcnkgdG8gcGVyZm9ybQ0KICAqIEBpZG46IGZsYWcgaWRuIHRvIGFjY2Vzcw0KKyAqIEBpbmRl
eDogZmxhZyBpbmRleCB0byBhY2Nlc3MNCiAgKiBAZmxhZ19yZXM6IHRoZSBmbGFnIHZhbHVlIGFm
dGVyIHRoZSBxdWVyeSByZXF1ZXN0IGNvbXBsZXRlcw0KICAqDQogICogUmV0dXJucyAwIGZvciBz
dWNjZXNzLCBub24temVybyBpbiBjYXNlIG9mIGZhaWx1cmUNCiAgKi8NCiBpbnQgdWZzaGNkX3F1
ZXJ5X2ZsYWcoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLA0K
LQkJCWVudW0gZmxhZ19pZG4gaWRuLCBib29sICpmbGFnX3JlcykNCisJCQllbnVtIGZsYWdfaWRu
IGlkbiwgdTggaW5kZXgsIGJvb2wgKmZsYWdfcmVzKQ0KIHsNCiAJc3RydWN0IHVmc19xdWVyeV9y
ZXEgKnJlcXVlc3QgPSBOVUxMOw0KIAlzdHJ1Y3QgdWZzX3F1ZXJ5X3JlcyAqcmVzcG9uc2UgPSBO
VUxMOw0KLQlpbnQgZXJyLCBpbmRleCA9IDAsIHNlbGVjdG9yID0gMDsNCisJaW50IGVyciwgc2Vs
ZWN0b3IgPSAwOw0KIAlpbnQgdGltZW91dCA9IFFVRVJZX1JFUV9USU1FT1VUOw0KIA0KIAlCVUdf
T04oIWhiYSk7DQpAQCAtNDE3Nyw3ICs0MTc4LDcgQEAgc3RhdGljIGludCB1ZnNoY2RfY29tcGxl
dGVfZGV2X2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJYm9vbCBmbGFnX3JlcyA9IHRydWU7
DQogDQogCWVyciA9IHVmc2hjZF9xdWVyeV9mbGFnX3JldHJ5KGhiYSwgVVBJVV9RVUVSWV9PUENP
REVfU0VUX0ZMQUcsDQotCQlRVUVSWV9GTEFHX0lETl9GREVWSUNFSU5JVCwgTlVMTCk7DQorCQlR
VUVSWV9GTEFHX0lETl9GREVWSUNFSU5JVCwgMCwgTlVMTCk7DQogCWlmIChlcnIpIHsNCiAJCWRl
dl9lcnIoaGJhLT5kZXYsDQogCQkJIiVzIHNldHRpbmcgZkRldmljZUluaXQgZmxhZyBmYWlsZWQg
d2l0aCBlcnJvciAlZFxuIiwNCkBAIC00MTg4LDcgKzQxODksNyBAQCBzdGF0aWMgaW50IHVmc2hj
ZF9jb21wbGV0ZV9kZXZfaW5pdChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAkvKiBwb2xsIGZvciBt
YXguIDEwMDAgaXRlcmF0aW9ucyBmb3IgZkRldmljZUluaXQgZmxhZyB0byBjbGVhciAqLw0KIAlm
b3IgKGkgPSAwOyBpIDwgMTAwMCAmJiAhZXJyICYmIGZsYWdfcmVzOyBpKyspDQogCQllcnIgPSB1
ZnNoY2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1JFQURfRkxBRywN
Ci0JCQlRVUVSWV9GTEFHX0lETl9GREVWSUNFSU5JVCwgJmZsYWdfcmVzKTsNCisJCQlRVUVSWV9G
TEFHX0lETl9GREVWSUNFSU5JVCwgMCwgJmZsYWdfcmVzKTsNCiANCiAJaWYgKGVycikNCiAJCWRl
dl9lcnIoaGJhLT5kZXYsDQpAQCAtNTAwMyw3ICs1MDA0LDcgQEAgc3RhdGljIGludCB1ZnNoY2Rf
ZW5hYmxlX2F1dG9fYmtvcHMoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJCWdvdG8gb3V0Ow0KIA0K
IAllcnIgPSB1ZnNoY2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1NF
VF9GTEFHLA0KLQkJCVFVRVJZX0ZMQUdfSUROX0JLT1BTX0VOLCBOVUxMKTsNCisJCQlRVUVSWV9G
TEFHX0lETl9CS09QU19FTiwgMCwgTlVMTCk7DQogCWlmIChlcnIpIHsNCiAJCWRldl9lcnIoaGJh
LT5kZXYsICIlczogZmFpbGVkIHRvIGVuYWJsZSBia29wcyAlZFxuIiwNCiAJCQkJX19mdW5jX18s
IGVycik7DQpAQCAtNTA1Myw3ICs1MDU0LDcgQEAgc3RhdGljIGludCB1ZnNoY2RfZGlzYWJsZV9h
dXRvX2Jrb3BzKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCX0NCiANCiAJZXJyID0gdWZzaGNkX3F1
ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9DTEVBUl9GTEFHLA0KLQkJCVFV
RVJZX0ZMQUdfSUROX0JLT1BTX0VOLCBOVUxMKTsNCisJCQlRVUVSWV9GTEFHX0lETl9CS09QU19F
TiwgMCwgTlVMTCk7DQogCWlmIChlcnIpIHsNCiAJCWRldl9lcnIoaGJhLT5kZXYsICIlczogZmFp
bGVkIHRvIGRpc2FibGUgYmtvcHMgJWRcbiIsDQogCQkJCV9fZnVuY19fLCBlcnIpOw0KQEAgLTUy
MTksNyArNTIyMCw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3diX2N0cmwoc3RydWN0IHVmc19oYmEg
KmhiYSwgYm9vbCBlbmFibGUpDQogCQlvcGNvZGUgPSBVUElVX1FVRVJZX09QQ09ERV9DTEVBUl9G
TEFHOw0KIA0KIAlyZXQgPSB1ZnNoY2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIG9wY29kZSwNCi0J
CQkJICAgICAgUVVFUllfRkxBR19JRE5fV0JfRU4sIE5VTEwpOw0KKwkJCQkgICAgICBRVUVSWV9G
TEFHX0lETl9XQl9FTiwgMCwgTlVMTCk7DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoaGJhLT5k
ZXYsICIlcyB3cml0ZSBib29zdGVyICVzIGZhaWxlZCAlZFxuIiwNCiAJCQlfX2Z1bmNfXywgZW5h
YmxlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIsIHJldCk7DQpAQCAtNTI0Myw3ICs1MjQ0LDcgQEAg
c3RhdGljIGludCB1ZnNoY2Rfd2JfdG9nZ2xlX2ZsdXNoX2R1cmluZ19oOChzdHJ1Y3QgdWZzX2hi
YSAqaGJhLCBib29sIHNldCkNCiAJCXZhbCA9IFVQSVVfUVVFUllfT1BDT0RFX0NMRUFSX0ZMQUc7
DQogDQogCXJldHVybiB1ZnNoY2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIHZhbCwNCi0JCQkgICAg
ICAgUVVFUllfRkxBR19JRE5fV0JfQlVGRl9GTFVTSF9EVVJJTkdfSElCRVJOOCwNCisJCQkgICAg
ICAgUVVFUllfRkxBR19JRE5fV0JfQlVGRl9GTFVTSF9EVVJJTkdfSElCRVJOOCwgMCwNCiAJCQkJ
ICAgICAgIE5VTEwpOw0KIH0NCiANCkBAIC01MjY0LDcgKzUyNjUsOCBAQCBzdGF0aWMgaW50IHVm
c2hjZF93Yl9idWZfZmx1c2hfZW5hYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCQlyZXR1cm4g
MDsNCiANCiAJcmV0ID0gdWZzaGNkX3F1ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09Q
Q09ERV9TRVRfRkxBRywNCi0JCQkJICAgICAgUVVFUllfRkxBR19JRE5fV0JfQlVGRl9GTFVTSF9F
TiwgTlVMTCk7DQorCQkJCSAgICAgIFFVRVJZX0ZMQUdfSUROX1dCX0JVRkZfRkxVU0hfRU4sDQor
CQkJCSAgICAgIDAsIE5VTEwpOw0KIAlpZiAocmV0KQ0KIAkJZGV2X2VycihoYmEtPmRldiwgIiVz
IFdCIC0gYnVmIGZsdXNoIGVuYWJsZSBmYWlsZWQgJWRcbiIsDQogCQkJX19mdW5jX18sIHJldCk7
DQpAQCAtNTI4Myw3ICs1Mjg1LDcgQEAgc3RhdGljIGludCB1ZnNoY2Rfd2JfYnVmX2ZsdXNoX2Rp
c2FibGUoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJCXJldHVybiAwOw0KIA0KIAlyZXQgPSB1ZnNo
Y2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX0NMRUFSX0ZMQUcsDQot
CQkJCSAgICAgIFFVRVJZX0ZMQUdfSUROX1dCX0JVRkZfRkxVU0hfRU4sIE5VTEwpOw0KKwkJCQkg
ICAgICBRVUVSWV9GTEFHX0lETl9XQl9CVUZGX0ZMVVNIX0VOLCAwLCBOVUxMKTsNCiAJaWYgKHJl
dCkgew0KIAkJZGV2X3dhcm4oaGJhLT5kZXYsICIlczogV0IgLSBidWYgZmx1c2ggZGlzYWJsZSBm
YWlsZWQgJWRcbiIsDQogCQkJIF9fZnVuY19fLCByZXQpOw0KQEAgLTcyNjMsNyArNzI2NSw3IEBA
IHN0YXRpYyBpbnQgdWZzaGNkX2RldmljZV9wYXJhbXNfaW5pdChzdHJ1Y3QgdWZzX2hiYSAqaGJh
KQ0KIAl1ZnNoY2RfZ2V0X3JlZl9jbGtfZ2F0aW5nX3dhaXQoaGJhKTsNCiANCiAJaWYgKCF1ZnNo
Y2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1JFQURfRkxBRywNCi0J
CQlRVUVSWV9GTEFHX0lETl9QV1JfT05fV1BFLCAmZmxhZykpDQorCQkJUVVFUllfRkxBR19JRE5f
UFdSX09OX1dQRSwgMCwgJmZsYWcpKQ0KIAkJaGJhLT5kZXZfaW5mby5mX3Bvd2VyX29uX3dwX2Vu
ID0gZmxhZzsNCiANCiAJLyogUHJvYmUgbWF4aW11bSBwb3dlciBtb2RlIGNvLXN1cHBvcnRlZCBi
eSBib3RoIFVGUyBob3N0IGFuZCBkZXZpY2UgKi8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kv
dWZzL3Vmc2hjZC5oIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaA0KaW5kZXggMDU2NTM3ZTUy
YzE5Li5lNTU1ZDc5NGQ0NDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5o
DQorKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQpAQCAtOTQ2LDcgKzk0Niw3IEBAIGlu
dCB1ZnNoY2RfcmVhZF9kZXNjX3BhcmFtKHN0cnVjdCB1ZnNfaGJhICpoYmEsDQogaW50IHVmc2hj
ZF9xdWVyeV9hdHRyKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gcXVlcnlfb3Bjb2RlIG9wY29k
ZSwNCiAJCSAgICAgIGVudW0gYXR0cl9pZG4gaWRuLCB1OCBpbmRleCwgdTggc2VsZWN0b3IsIHUz
MiAqYXR0cl92YWwpOw0KIGludCB1ZnNoY2RfcXVlcnlfZmxhZyhzdHJ1Y3QgdWZzX2hiYSAqaGJh
LCBlbnVtIHF1ZXJ5X29wY29kZSBvcGNvZGUsDQotCWVudW0gZmxhZ19pZG4gaWRuLCBib29sICpm
bGFnX3Jlcyk7DQorCWVudW0gZmxhZ19pZG4gaWRuLCB1OCBpbmRleCwgYm9vbCAqZmxhZ19yZXMp
Ow0KIA0KIHZvaWQgdWZzaGNkX2F1dG9faGliZXJuOF9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhi
YSk7DQogdm9pZCB1ZnNoY2RfYXV0b19oaWJlcm44X3VwZGF0ZShzdHJ1Y3QgdWZzX2hiYSAqaGJh
LCB1MzIgYWhpdCk7DQotLSANCjIuMTguMA0K

