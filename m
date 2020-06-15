Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621991F9A38
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2020 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgFOObi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Jun 2020 10:31:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29513 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729243AbgFOObh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 15 Jun 2020 10:31:37 -0400
X-UUID: d464b01d39244626822de9c7124b8e42-20200615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=omTxP510z3SeJM3158srmfQljfQpeJ6GXR7o8i88WeQ=;
        b=LezwDBguD/HW6bv6NTgNCLX7zSZtg/Bz/sEMi/+aFlLQU6EuMfv8EiZlxWuDF/eo3LNceJu+ATeM2oCjCs3Cb4Q8eA8dYebKX1CsVlrKSou1Z7J66+zGukMAUTuHgUHfAe0lZGzLF99BcBhMfNpVq3zFU8k8s7uROuMCgWeSE4Q=;
X-UUID: d464b01d39244626822de9c7124b8e42-20200615
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 523175564; Mon, 15 Jun 2020 22:31:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Jun 2020 22:31:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jun 2020 22:31:22 +0800
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
        <andy.teng@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 2/3] scsi: ufs: Manage and export UFS debugging information dump
Date:   Mon, 15 Jun 2020 22:31:22 +0800
Message-ID: <20200615143123.6627-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200615143123.6627-1-stanley.chu@mediatek.com>
References: <20200615143123.6627-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

VUZTIGhhcyBtYW55IGZ1bmN0aW9ucyB0byBwcmludCBkaWZmZXJlbnQgdHlwZXMgb2YgZGVidWdn
aW5nDQppbmZvcm1hdGlvbi4gU29tZSBpbmZvcm1hdGlvbiBpcyBoZWxwZnVsIGZvciB2ZW5kb3Ig
ZHJpdmVycyBhbmQNCmNhbiBiZSBkdW1wZWQgaWYgc29tZXRoaW5nIHdyb25nIGluIHZlbmRvci1z
cGVjaWZpYyBmbG93cy4NCg0KVG8gaGF2ZSBtaW5pbXVtIGFuZCBtb3N0IHNpbXBsZSBleHBvcnRl
ZCBpbnRlcmZhY2UgZm9yIHZlbmRvcg0KZHJpdmVycywgY3JlYXRlIGEgc2luZ2xlIGFuZCB1bmlm
aWVkIGVudHJhbmNlIHRvIG1vc3QNCmRlYnVnZ2luZyBmdW5jdGlvbnMsIGFuZCB0aGVuIGV4cG9y
dCB0aGUgZW50cnkgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFu
bGV5LmNodUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIHwg
NDkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9zY3Np
L3Vmcy91ZnNoY2QuaCB8ICA4ICsrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlv
bnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91
ZnNoY2QuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCmluZGV4IDE1MmFlN2Y1YWU4Ni4u
NTE1OGM0OTZjZjk1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KKysr
IGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KQEAgLTU3Myw2ICs1NzMsMTkgQEAgc3RhdGlj
IHZvaWQgdWZzaGNkX3ByaW50X3B3cl9pbmZvKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCQkgaGJh
LT5wd3JfaW5mby5oc19yYXRlKTsNCiB9DQogDQordm9pZCB1ZnNoY2RfcHJpbnRfaW5mbyhzdHJ1
Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIHVmc19pbmZvX2l0ZW0gZmxhZ3MpDQorew0KKwlpZiAoZmxh
Z3MgJiBVRlNfSU5GT19IT1NUX1NUQVRFKQ0KKwkJdWZzaGNkX3ByaW50X2hvc3Rfc3RhdGUoaGJh
KTsNCisJaWYgKGZsYWdzICYgVUZTX0lORk9fSE9TVF9SRUdTKQ0KKwkJdWZzaGNkX3ByaW50X2hv
c3RfcmVncyhoYmEpOw0KKwlpZiAoZmxhZ3MgJiBVRlNfSU5GT19QV1IpDQorCQl1ZnNoY2RfcHJp
bnRfcHdyX2luZm8oaGJhKTsNCisJaWYgKGZsYWdzICYgVUZTX0lORk9fVE1SUykNCisJCXVmc2hj
ZF9wcmludF90bXJzKGhiYSwgaGJhLT5vdXRzdGFuZGluZ190YXNrcyk7DQorfQ0KK0VYUE9SVF9T
WU1CT0xfR1BMKHVmc2hjZF9wcmludF9pbmZvKTsNCisNCiB2b2lkIHVmc2hjZF9kZWxheV91cyh1
bnNpZ25lZCBsb25nIHVzLCB1bnNpZ25lZCBsb25nIHRvbGVyYW5jZSkNCiB7DQogCWlmICghdXMp
DQpAQCAtMzc4MywxMSArMzc5Niw5IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3VpY19wd3JfY3RybChz
dHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3QgdWljX2NvbW1hbmQgKmNtZCkNCiAJCXJldCA9IChz
dGF0dXMgIT0gUFdSX09LKSA/IHN0YXR1cyA6IC0xOw0KIAl9DQogb3V0Og0KLQlpZiAocmV0KSB7
DQotCQl1ZnNoY2RfcHJpbnRfaG9zdF9zdGF0ZShoYmEpOw0KLQkJdWZzaGNkX3ByaW50X3B3cl9p
bmZvKGhiYSk7DQotCQl1ZnNoY2RfcHJpbnRfaG9zdF9yZWdzKGhiYSk7DQotCX0NCisJaWYgKHJl
dCkNCisJCXVmc2hjZF9wcmludF9pbmZvKGhiYSwgVUZTX0lORk9fSE9TVF9TVEFURSB8DQorCQkJ
CSAgVUZTX0lORk9fSE9TVF9SRUdTIHwgVUZTX0lORk9fUFdSKTsNCiANCiAJc3Bpbl9sb2NrX2ly
cXNhdmUoaGJhLT5ob3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsNCiAJaGJhLT5hY3RpdmVfdWljX2Nt
ZCA9IE5VTEw7DQpAQCAtNDQ1NCw3ICs0NDY1LDcgQEAgc3RhdGljIGludCB1ZnNoY2RfbGlua19z
dGFydHVwKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogDQogCS8qIE1hcmsgdGhhdCBsaW5rIGlzIHVw
IGluIFBXTS1HMSwgMS1sYW5lLCBTTE9XLUFVVE8gbW9kZSAqLw0KIAl1ZnNoY2RfaW5pdF9wd3Jf
aW5mbyhoYmEpOw0KLQl1ZnNoY2RfcHJpbnRfcHdyX2luZm8oaGJhKTsNCisJdWZzaGNkX3ByaW50
X2luZm8oaGJhLCBVRlNfSU5GT19QV1IpOw0KIA0KIAlpZiAoaGJhLT5xdWlya3MgJiBVRlNIQ0Rf
UVVJUktfQlJPS0VOX0xDQykgew0KIAkJcmV0ID0gdWZzaGNkX2Rpc2FibGVfZGV2aWNlX3R4X2xj
YyhoYmEpOw0KQEAgLTQ0NzEsOSArNDQ4Miw4IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2xpbmtfc3Rh
cnR1cChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIG91dDoNCiAJaWYgKHJldCkgew0KIAkJZGV2X2Vy
cihoYmEtPmRldiwgImxpbmsgc3RhcnR1cCBmYWlsZWQgJWRcbiIsIHJldCk7DQotCQl1ZnNoY2Rf
cHJpbnRfaG9zdF9zdGF0ZShoYmEpOw0KLQkJdWZzaGNkX3ByaW50X3B3cl9pbmZvKGhiYSk7DQot
CQl1ZnNoY2RfcHJpbnRfaG9zdF9yZWdzKGhiYSk7DQorCQl1ZnNoY2RfcHJpbnRfaW5mbyhoYmEs
IFVGU19JTkZPX0hPU1RfU1RBVEUgfA0KKwkJCQkgIFVGU19JTkZPX0hPU1RfUkVHUyB8IFVGU19J
TkZPX1BXUik7DQogCX0NCiAJcmV0dXJuIHJldDsNCiB9DQpAQCAtNDgxNyw4ICs0ODI3LDggQEAg
dWZzaGNkX3RyYW5zZmVyX3JzcF9zdGF0dXMoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHVm
c2hjZF9scmIgKmxyYnApDQogCQlkZXZfZXJyKGhiYS0+ZGV2LA0KIAkJCQkiT0NTIGVycm9yIGZy
b20gY29udHJvbGxlciA9ICV4IGZvciB0YWcgJWRcbiIsDQogCQkJCW9jcywgbHJicC0+dGFza190
YWcpOw0KLQkJdWZzaGNkX3ByaW50X2hvc3RfcmVncyhoYmEpOw0KLQkJdWZzaGNkX3ByaW50X2hv
c3Rfc3RhdGUoaGJhKTsNCisJCXVmc2hjZF9wcmludF9pbmZvKGhiYSwgVUZTX0lORk9fSE9TVF9T
VEFURSB8DQorCQkJCSAgVUZTX0lORk9fSE9TVF9SRUdTKTsNCiAJCWJyZWFrOw0KIAl9IC8qIGVu
ZCBvZiBzd2l0Y2ggKi8NCiANCkBAIC01ODAxLDkgKzU4MTEsOSBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgdWZzaGNkX2NoZWNrX2Vycm9ycyhzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAkJCQkJX19mdW5j
X18sIGhiYS0+c2F2ZWRfZXJyLA0KIAkJCQkJaGJhLT5zYXZlZF91aWNfZXJyKTsNCiANCi0JCQkJ
dWZzaGNkX3ByaW50X2hvc3RfcmVncyhoYmEpOw0KLQkJCQl1ZnNoY2RfcHJpbnRfcHdyX2luZm8o
aGJhKTsNCi0JCQkJdWZzaGNkX3ByaW50X3RtcnMoaGJhLCBoYmEtPm91dHN0YW5kaW5nX3Rhc2tz
KTsNCisJCQkJdWZzaGNkX3ByaW50X2luZm8oaGJhLCBVRlNfSU5GT19IT1NUX1JFR1MgfA0KKwkJ
CQkJCSAgVUZTX0lORk9fUFdSIHwNCisJCQkJCQkgIFVGU19JTkZPX1RNUlMpOw0KIAkJCQl1ZnNo
Y2RfcHJpbnRfdHJzKGhiYSwgaGJhLT5vdXRzdGFuZGluZ19yZXFzLA0KIAkJCQkJCQlwcl9wcmR0
KTsNCiAJCQl9DQpAQCAtNjQxNiw5ICs2NDI2LDggQEAgc3RhdGljIGludCB1ZnNoY2RfYWJvcnQo
c3RydWN0IHNjc2lfY21uZCAqY21kKQ0KIAlzY3NpX3ByaW50X2NvbW1hbmQoaGJhLT5scmJbdGFn
XS5jbWQpOw0KIAlpZiAoIWhiYS0+cmVxX2Fib3J0X2NvdW50KSB7DQogCQl1ZnNoY2RfdXBkYXRl
X3JlZ19oaXN0KCZoYmEtPnVmc19zdGF0cy50YXNrX2Fib3J0LCAwKTsNCi0JCXVmc2hjZF9wcmlu
dF9ob3N0X3JlZ3MoaGJhKTsNCi0JCXVmc2hjZF9wcmludF9ob3N0X3N0YXRlKGhiYSk7DQotCQl1
ZnNoY2RfcHJpbnRfcHdyX2luZm8oaGJhKTsNCisJCXVmc2hjZF9wcmludF9pbmZvKGhiYSwgVUZT
X0lORk9fSE9TVF9TVEFURSB8DQorCQkJCSAgVUZTX0lORk9fSE9TVF9SRUdTIHwgVUZTX0lORk9f
UFdSKTsNCiAJCXVmc2hjZF9wcmludF90cnMoaGJhLCAxIDw8IHRhZywgdHJ1ZSk7DQogCX0gZWxz
ZSB7DQogCQl1ZnNoY2RfcHJpbnRfdHJzKGhiYSwgMSA8PCB0YWcsIGZhbHNlKTsNCkBAIC03NDQ0
LDcgKzc0NTMsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9wcm9iZV9oYmEoc3RydWN0IHVmc19oYmEg
KmhiYSwgYm9vbCBhc3luYykNCiAJCQkJCV9fZnVuY19fLCByZXQpOw0KIAkJCWdvdG8gb3V0Ow0K
IAkJfQ0KLQkJdWZzaGNkX3ByaW50X3B3cl9pbmZvKGhiYSk7DQorCQl1ZnNoY2RfcHJpbnRfaW5m
byhoYmEsIFVGU19JTkZPX1BXUik7DQogCX0NCiANCiAJLyoNCkBAIC04ODk3LDggKzg5MDYsOCBA
QCBpbnQgdWZzaGNkX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSwgdm9pZCBfX2lvbWVtICptbWlv
X2Jhc2UsIHVuc2lnbmVkIGludCBpcnEpDQogCWVyciA9IHVmc2hjZF9oYmFfZW5hYmxlKGhiYSk7
DQogCWlmIChlcnIpIHsNCiAJCWRldl9lcnIoaGJhLT5kZXYsICJIb3N0IGNvbnRyb2xsZXIgZW5h
YmxlIGZhaWxlZFxuIik7DQotCQl1ZnNoY2RfcHJpbnRfaG9zdF9yZWdzKGhiYSk7DQotCQl1ZnNo
Y2RfcHJpbnRfaG9zdF9zdGF0ZShoYmEpOw0KKwkJdWZzaGNkX3ByaW50X2luZm8oaGJhLCBVRlNf
SU5GT19IT1NUX1NUQVRFIHwNCisJCQkJICBVRlNfSU5GT19IT1NUX1JFR1MpOw0KIAkJZ290byBm
cmVlX3RtZl9xdWV1ZTsNCiAJfQ0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZz
aGNkLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQppbmRleCA3ZmEzNWM3ODM0MmIuLjM0
NTBkOTU4OTYwMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCisrKyBi
L2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCkBAIC04MTcsNiArODE3LDEzIEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCB1ZnNoY2Rfcm13bChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCB1MzIgbWFzaywgdTMy
IHZhbCwgdTMyIHJlZykNCiAJdWZzaGNkX3dyaXRlbChoYmEsIHRtcCwgcmVnKTsNCiB9DQogDQor
ZW51bSB1ZnNfaW5mb19pdGVtIHsNCisJVUZTX0lORk9fSE9TVF9TVEFURSA9ICgxIDw8IDApLA0K
KwlVRlNfSU5GT19IT1NUX1JFR1MgID0gKDEgPDwgMSksDQorCVVGU19JTkZPX1BXUiAgICAgICAg
PSAoMSA8PCAyKSwNCisJVUZTX0lORk9fVE1SUyAgICAgICA9ICgxIDw8IDMpDQorfTsNCisNCiBp
bnQgdWZzaGNkX2FsbG9jX2hvc3Qoc3RydWN0IGRldmljZSAqLCBzdHJ1Y3QgdWZzX2hiYSAqKik7
DQogdm9pZCB1ZnNoY2RfZGVhbGxvY19ob3N0KHN0cnVjdCB1ZnNfaGJhICopOw0KIGludCB1ZnNo
Y2RfaGJhX2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCkBAIC04MjYsNiArODMzLDcgQEAg
aW50IHVmc2hjZF9tYWtlX2hiYV9vcGVyYXRpb25hbChzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCiB2
b2lkIHVmc2hjZF9yZW1vdmUoc3RydWN0IHVmc19oYmEgKik7DQogaW50IHVmc2hjZF91aWNfaGli
ZXJuOF9leGl0KHN0cnVjdCB1ZnNfaGJhICpoYmEpOw0KIHZvaWQgdWZzaGNkX2RlbGF5X3VzKHVu
c2lnbmVkIGxvbmcgdXMsIHVuc2lnbmVkIGxvbmcgdG9sZXJhbmNlKTsNCit2b2lkIHVmc2hjZF9w
cmludF9pbmZvKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gdWZzX2luZm9faXRlbSBmbGFncyk7
DQogaW50IHVmc2hjZF93YWl0X2Zvcl9yZWdpc3RlcihzdHJ1Y3QgdWZzX2hiYSAqaGJhLCB1MzIg
cmVnLCB1MzIgbWFzaywNCiAJCQkJdTMyIHZhbCwgdW5zaWduZWQgbG9uZyBpbnRlcnZhbF91cywN
CiAJCQkJdW5zaWduZWQgbG9uZyB0aW1lb3V0X21zKTsNCi0tIA0KMi4xOC4wDQo=

