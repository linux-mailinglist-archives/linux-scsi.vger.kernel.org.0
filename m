Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399121C2BC0
	for <lists+linux-scsi@lfdr.de>; Sun,  3 May 2020 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgECLe0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 May 2020 07:34:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727773AbgECLeZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 May 2020 07:34:25 -0400
X-UUID: 10c150db42f342be9e71d42a817b2008-20200503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FXgchehaCaQllpaErKyBEQaIrlgeFD/FE8iUAnQT1NM=;
        b=D+3dXMSaXxPnijGr1UzngixR+LySDTgLeh7qBDqZ9W1jB9ek/dJBu+5tbmz5dtFL6Pdp47l4fcKuKchBchHcDObAkS/JOxGcHt2chuJsV8ysSgLe0+tLIaERGpMgE+lR6EjFThFhoOaC93dDl74OxWpWm47jovClEGNtKEb9OZg=;
X-UUID: 10c150db42f342be9e71d42a817b2008-20200503
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1002612688; Sun, 03 May 2020 19:34:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 3 May 2020 19:34:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 3 May 2020 19:34:16 +0800
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
Subject: [PATCH v5 5/8] scsi: ufs: add "index" in parameter list of ufshcd_query_flag()
Date:   Sun, 3 May 2020 19:34:12 +0800
Message-ID: <20200503113415.21034-6-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200503113415.21034-1-stanley.chu@mediatek.com>
References: <20200503113415.21034-1-stanley.chu@mediatek.com>
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
SHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQpSZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmku
YWx0bWFuQHdkYy5jb20+DQpSZXZpZXdlZC1ieTogQ2FuIEd1byA8Y2FuZ0Bjb2RlYXVyb3JhLm9y
Zz4NCi0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgfCAgMiArLQ0KIGRyaXZlcnMv
c2NzaS91ZnMvdWZzaGNkLmMgICAgfCAyOCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQog
ZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaCAgICB8ICAyICstDQogMyBmaWxlcyBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c2NzaS91ZnMvdWZzLXN5c2ZzLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1zeXNmcy5jDQppbmRl
eCA5MzQ4NDQwOGJjNDAuLmI4NmI2YTQwZDdlNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91
ZnMvdWZzLXN5c2ZzLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMNCkBAIC02
MzEsNyArNjMxLDcgQEAgc3RhdGljIHNzaXplX3QgX25hbWUjI19zaG93KHN0cnVjdCBkZXZpY2Ug
KmRldiwJCQkJXA0KIAlzdHJ1Y3QgdWZzX2hiYSAqaGJhID0gZGV2X2dldF9kcnZkYXRhKGRldik7
CQkJXA0KIAlwbV9ydW50aW1lX2dldF9zeW5jKGhiYS0+ZGV2KTsJCQkJCVwNCiAJcmV0ID0gdWZz
aGNkX3F1ZXJ5X2ZsYWcoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9SRUFEX0ZMQUcsCVwNCi0JCVFV
RVJZX0ZMQUdfSUROIyNfdW5hbWUsICZmbGFnKTsJCQkJXA0KKwkJUVVFUllfRkxBR19JRE4jI191
bmFtZSwgMCwgJmZsYWcpOwkJCVwNCiAJcG1fcnVudGltZV9wdXRfc3luYyhoYmEtPmRldik7CQkJ
CQlcDQogCWlmIChyZXQpCQkJCQkJCVwNCiAJCXJldHVybiAtRUlOVkFMOwkJCQkJCVwNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNo
Y2QuYw0KaW5kZXggNmQ1YjQ5YzA3YTY5Li5kNGE5YzQ3OTI5NGMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQorKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQpA
QCAtMjc4MiwxMyArMjc4MiwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdWZzaGNkX2luaXRfcXVl
cnkoc3RydWN0IHVmc19oYmEgKmhiYSwNCiB9DQogDQogc3RhdGljIGludCB1ZnNoY2RfcXVlcnlf
ZmxhZ19yZXRyeShzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KLQllbnVtIHF1ZXJ5X29wY29kZSBvcGNv
ZGUsIGVudW0gZmxhZ19pZG4gaWRuLCBib29sICpmbGFnX3JlcykNCisJZW51bSBxdWVyeV9vcGNv
ZGUgb3Bjb2RlLCBlbnVtIGZsYWdfaWRuIGlkbiwgdTggaW5kZXgsIGJvb2wgKmZsYWdfcmVzKQ0K
IHsNCiAJaW50IHJldDsNCiAJaW50IHJldHJpZXM7DQogDQogCWZvciAocmV0cmllcyA9IDA7IHJl
dHJpZXMgPCBRVUVSWV9SRVFfUkVUUklFUzsgcmV0cmllcysrKSB7DQotCQlyZXQgPSB1ZnNoY2Rf
cXVlcnlfZmxhZyhoYmEsIG9wY29kZSwgaWRuLCBmbGFnX3Jlcyk7DQorCQlyZXQgPSB1ZnNoY2Rf
cXVlcnlfZmxhZyhoYmEsIG9wY29kZSwgaWRuLCBpbmRleCwgZmxhZ19yZXMpOw0KIAkJaWYgKHJl
dCkNCiAJCQlkZXZfZGJnKGhiYS0+ZGV2LA0KIAkJCQkiJXM6IGZhaWxlZCB3aXRoIGVycm9yICVk
LCByZXRyaWVzICVkXG4iLA0KQEAgLTI4MDksMTYgKzI4MDksMTcgQEAgc3RhdGljIGludCB1ZnNo
Y2RfcXVlcnlfZmxhZ19yZXRyeShzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KICAqIEBoYmE6IHBlci1h
ZGFwdGVyIGluc3RhbmNlDQogICogQG9wY29kZTogZmxhZyBxdWVyeSB0byBwZXJmb3JtDQogICog
QGlkbjogZmxhZyBpZG4gdG8gYWNjZXNzDQorICogQGluZGV4OiBmbGFnIGluZGV4IHRvIGFjY2Vz
cw0KICAqIEBmbGFnX3JlczogdGhlIGZsYWcgdmFsdWUgYWZ0ZXIgdGhlIHF1ZXJ5IHJlcXVlc3Qg
Y29tcGxldGVzDQogICoNCiAgKiBSZXR1cm5zIDAgZm9yIHN1Y2Nlc3MsIG5vbi16ZXJvIGluIGNh
c2Ugb2YgZmFpbHVyZQ0KICAqLw0KIGludCB1ZnNoY2RfcXVlcnlfZmxhZyhzdHJ1Y3QgdWZzX2hi
YSAqaGJhLCBlbnVtIHF1ZXJ5X29wY29kZSBvcGNvZGUsDQotCQkJZW51bSBmbGFnX2lkbiBpZG4s
IGJvb2wgKmZsYWdfcmVzKQ0KKwkJCWVudW0gZmxhZ19pZG4gaWRuLCB1OCBpbmRleCwgYm9vbCAq
ZmxhZ19yZXMpDQogew0KIAlzdHJ1Y3QgdWZzX3F1ZXJ5X3JlcSAqcmVxdWVzdCA9IE5VTEw7DQog
CXN0cnVjdCB1ZnNfcXVlcnlfcmVzICpyZXNwb25zZSA9IE5VTEw7DQotCWludCBlcnIsIGluZGV4
ID0gMCwgc2VsZWN0b3IgPSAwOw0KKwlpbnQgZXJyLCBzZWxlY3RvciA9IDA7DQogCWludCB0aW1l
b3V0ID0gUVVFUllfUkVRX1RJTUVPVVQ7DQogDQogCUJVR19PTighaGJhKTsNCkBAIC00MTc1LDcg
KzQxNzYsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9jb21wbGV0ZV9kZXZfaW5pdChzdHJ1Y3QgdWZz
X2hiYSAqaGJhKQ0KIAlib29sIGZsYWdfcmVzID0gdHJ1ZTsNCiANCiAJZXJyID0gdWZzaGNkX3F1
ZXJ5X2ZsYWdfcmV0cnkoaGJhLCBVUElVX1FVRVJZX09QQ09ERV9TRVRfRkxBRywNCi0JCVFVRVJZ
X0ZMQUdfSUROX0ZERVZJQ0VJTklULCBOVUxMKTsNCisJCVFVRVJZX0ZMQUdfSUROX0ZERVZJQ0VJ
TklULCAwLCBOVUxMKTsNCiAJaWYgKGVycikgew0KIAkJZGV2X2VycihoYmEtPmRldiwNCiAJCQki
JXMgc2V0dGluZyBmRGV2aWNlSW5pdCBmbGFnIGZhaWxlZCB3aXRoIGVycm9yICVkXG4iLA0KQEAg
LTQxODYsNyArNDE4Nyw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2NvbXBsZXRlX2Rldl9pbml0KHN0
cnVjdCB1ZnNfaGJhICpoYmEpDQogCS8qIHBvbGwgZm9yIG1heC4gMTAwMCBpdGVyYXRpb25zIGZv
ciBmRGV2aWNlSW5pdCBmbGFnIHRvIGNsZWFyICovDQogCWZvciAoaSA9IDA7IGkgPCAxMDAwICYm
ICFlcnIgJiYgZmxhZ19yZXM7IGkrKykNCiAJCWVyciA9IHVmc2hjZF9xdWVyeV9mbGFnX3JldHJ5
KGhiYSwgVVBJVV9RVUVSWV9PUENPREVfUkVBRF9GTEFHLA0KLQkJCVFVRVJZX0ZMQUdfSUROX0ZE
RVZJQ0VJTklULCAmZmxhZ19yZXMpOw0KKwkJCVFVRVJZX0ZMQUdfSUROX0ZERVZJQ0VJTklULCAw
LCAmZmxhZ19yZXMpOw0KIA0KIAlpZiAoZXJyKQ0KIAkJZGV2X2VycihoYmEtPmRldiwNCkBAIC01
MDAxLDcgKzUwMDIsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9lbmFibGVfYXV0b19ia29wcyhzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KIAkJZ290byBvdXQ7DQogDQogCWVyciA9IHVmc2hjZF9xdWVyeV9m
bGFnX3JldHJ5KGhiYSwgVVBJVV9RVUVSWV9PUENPREVfU0VUX0ZMQUcsDQotCQkJUVVFUllfRkxB
R19JRE5fQktPUFNfRU4sIE5VTEwpOw0KKwkJCVFVRVJZX0ZMQUdfSUROX0JLT1BTX0VOLCAwLCBO
VUxMKTsNCiAJaWYgKGVycikgew0KIAkJZGV2X2VycihoYmEtPmRldiwgIiVzOiBmYWlsZWQgdG8g
ZW5hYmxlIGJrb3BzICVkXG4iLA0KIAkJCQlfX2Z1bmNfXywgZXJyKTsNCkBAIC01MDUxLDcgKzUw
NTIsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9kaXNhYmxlX2F1dG9fYmtvcHMoc3RydWN0IHVmc19o
YmEgKmhiYSkNCiAJfQ0KIA0KIAllcnIgPSB1ZnNoY2RfcXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQ
SVVfUVVFUllfT1BDT0RFX0NMRUFSX0ZMQUcsDQotCQkJUVVFUllfRkxBR19JRE5fQktPUFNfRU4s
IE5VTEwpOw0KKwkJCVFVRVJZX0ZMQUdfSUROX0JLT1BTX0VOLCAwLCBOVUxMKTsNCiAJaWYgKGVy
cikgew0KIAkJZGV2X2VycihoYmEtPmRldiwgIiVzOiBmYWlsZWQgdG8gZGlzYWJsZSBia29wcyAl
ZFxuIiwNCiAJCQkJX19mdW5jX18sIGVycik7DQpAQCAtNTIxNyw3ICs1MjE4LDcgQEAgc3RhdGlj
IGludCB1ZnNoY2Rfd2JfY3RybChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBib29sIGVuYWJsZSkNCiAJ
CW9wY29kZSA9IFVQSVVfUVVFUllfT1BDT0RFX0NMRUFSX0ZMQUc7DQogDQogCXJldCA9IHVmc2hj
ZF9xdWVyeV9mbGFnX3JldHJ5KGhiYSwgb3Bjb2RlLA0KLQkJCQkgICAgICBRVUVSWV9GTEFHX0lE
Tl9XQl9FTiwgTlVMTCk7DQorCQkJCSAgICAgIFFVRVJZX0ZMQUdfSUROX1dCX0VOLCAwLCBOVUxM
KTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycihoYmEtPmRldiwgIiVzIHdyaXRlIGJvb3N0ZXIg
JXMgZmFpbGVkICVkXG4iLA0KIAkJCV9fZnVuY19fLCBlbmFibGUgPyAiZW5hYmxlIiA6ICJkaXNh
YmxlIiwgcmV0KTsNCkBAIC01MjQxLDcgKzUyNDIsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF93Yl90
b2dnbGVfZmx1c2hfZHVyaW5nX2g4KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgc2V0KQ0KIAkJ
dmFsID0gVVBJVV9RVUVSWV9PUENPREVfQ0xFQVJfRkxBRzsNCiANCiAJcmV0dXJuIHVmc2hjZF9x
dWVyeV9mbGFnX3JldHJ5KGhiYSwgdmFsLA0KLQkJCSAgICAgICBRVUVSWV9GTEFHX0lETl9XQl9C
VUZGX0ZMVVNIX0RVUklOR19ISUJFUk44LA0KKwkJCSAgICAgICBRVUVSWV9GTEFHX0lETl9XQl9C
VUZGX0ZMVVNIX0RVUklOR19ISUJFUk44LCAwLA0KIAkJCQkgICAgICAgTlVMTCk7DQogfQ0KIA0K
QEAgLTUyNjIsNyArNTI2Myw4IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3diX2J1Zl9mbHVzaF9lbmFi
bGUoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJCXJldHVybiAwOw0KIA0KIAlyZXQgPSB1ZnNoY2Rf
cXVlcnlfZmxhZ19yZXRyeShoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1NFVF9GTEFHLA0KLQkJCQkg
ICAgICBRVUVSWV9GTEFHX0lETl9XQl9CVUZGX0ZMVVNIX0VOLCBOVUxMKTsNCisJCQkJICAgICAg
UVVFUllfRkxBR19JRE5fV0JfQlVGRl9GTFVTSF9FTiwNCisJCQkJICAgICAgMCwgTlVMTCk7DQog
CWlmIChyZXQpDQogCQlkZXZfZXJyKGhiYS0+ZGV2LCAiJXMgV0IgLSBidWYgZmx1c2ggZW5hYmxl
IGZhaWxlZCAlZFxuIiwNCiAJCQlfX2Z1bmNfXywgcmV0KTsNCkBAIC01MjgxLDcgKzUyODMsNyBA
QCBzdGF0aWMgaW50IHVmc2hjZF93Yl9idWZfZmx1c2hfZGlzYWJsZShzdHJ1Y3QgdWZzX2hiYSAq
aGJhKQ0KIAkJcmV0dXJuIDA7DQogDQogCXJldCA9IHVmc2hjZF9xdWVyeV9mbGFnX3JldHJ5KGhi
YSwgVVBJVV9RVUVSWV9PUENPREVfQ0xFQVJfRkxBRywNCi0JCQkJICAgICAgUVVFUllfRkxBR19J
RE5fV0JfQlVGRl9GTFVTSF9FTiwgTlVMTCk7DQorCQkJCSAgICAgIFFVRVJZX0ZMQUdfSUROX1dC
X0JVRkZfRkxVU0hfRU4sIDAsIE5VTEwpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfd2FybihoYmEt
PmRldiwgIiVzOiBXQiAtIGJ1ZiBmbHVzaCBkaXNhYmxlIGZhaWxlZCAlZFxuIiwNCiAJCQkgX19m
dW5jX18sIHJldCk7DQpAQCAtNzI2Niw3ICs3MjY4LDcgQEAgc3RhdGljIGludCB1ZnNoY2RfZGV2
aWNlX3BhcmFtc19pbml0KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCXVmc2hjZF9nZXRfcmVmX2Ns
a19nYXRpbmdfd2FpdChoYmEpOw0KIA0KIAlpZiAoIXVmc2hjZF9xdWVyeV9mbGFnX3JldHJ5KGhi
YSwgVVBJVV9RVUVSWV9PUENPREVfUkVBRF9GTEFHLA0KLQkJCVFVRVJZX0ZMQUdfSUROX1BXUl9P
Tl9XUEUsICZmbGFnKSkNCisJCQlRVUVSWV9GTEFHX0lETl9QV1JfT05fV1BFLCAwLCAmZmxhZykp
DQogCQloYmEtPmRldl9pbmZvLmZfcG93ZXJfb25fd3BfZW4gPSBmbGFnOw0KIA0KIAkvKiBQcm9i
ZSBtYXhpbXVtIHBvd2VyIG1vZGUgY28tc3VwcG9ydGVkIGJ5IGJvdGggVUZTIGhvc3QgYW5kIGRl
dmljZSAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmggYi9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5oDQppbmRleCBmMzQ2MDExMjE4ODAuLjg5ODg4MzA1OGUzYSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCisrKyBiL2RyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLmgNCkBAIC05NDgsNyArOTQ4LDcgQEAgaW50IHVmc2hjZF9yZWFkX2Rlc2NfcGFy
YW0oc3RydWN0IHVmc19oYmEgKmhiYSwNCiBpbnQgdWZzaGNkX3F1ZXJ5X2F0dHIoc3RydWN0IHVm
c19oYmEgKmhiYSwgZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLA0KIAkJICAgICAgZW51bSBhdHRy
X2lkbiBpZG4sIHU4IGluZGV4LCB1OCBzZWxlY3RvciwgdTMyICphdHRyX3ZhbCk7DQogaW50IHVm
c2hjZF9xdWVyeV9mbGFnKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gcXVlcnlfb3Bjb2RlIG9w
Y29kZSwNCi0JZW51bSBmbGFnX2lkbiBpZG4sIGJvb2wgKmZsYWdfcmVzKTsNCisJZW51bSBmbGFn
X2lkbiBpZG4sIHU4IGluZGV4LCBib29sICpmbGFnX3Jlcyk7DQogDQogdm9pZCB1ZnNoY2RfYXV0
b19oaWJlcm44X2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCiB2b2lkIHVmc2hjZF9hdXRv
X2hpYmVybjhfdXBkYXRlKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHUzMiBhaGl0KTsNCi0tIA0KMi4x
OC4wDQo=

