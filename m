Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8126578A
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 05:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKDh4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Sep 2020 23:37:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbgIKDhu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Sep 2020 23:37:50 -0400
X-UUID: 992b970273424110b4d92863f700a1b1-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3PUv1RZDuxtoswhg70U37JDJQ6DCyg4Gxx7SBN2DtaY=;
        b=ZkDxprwfW+lgRrq9NEappucCflji8p/bIHaOUHmc4fz28nb2hNKgI3OXIPU39EeJjjkzAWkGrs3/LiXzIDQ+/UtipXTchYZU/aig8V42/Gc3toAFvYCK/VKqIM1DfHo7MkaxxDcpD977kvcxiUU6OVFu2AnOJpH66SWlV8sV6fE=;
X-UUID: 992b970273424110b4d92863f700a1b1-20200911
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 416230220; Fri, 11 Sep 2020 11:37:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Sep 2020 11:37:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 11:37:36 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <robh@kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <matthias.bgg@gmail.com>, <bvanassche@acm.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, <arvin.wang@mediatek.com>,
        <HenryC.Chen@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 1/2] scsi: ufs-mediatek: Support performance mode for inline encryption engine
Date:   Fri, 11 Sep 2020 11:37:34 +0800
Message-ID: <20200911033735.21751-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200911033735.21751-1-stanley.chu@mediatek.com>
References: <20200911033735.21751-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 207A352C1CC0F5EC89C9BC5EAF09E3B509B89A047E786BBEAA0697EBDF7AE4DA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

U29tZSBNZWRpYVRlayBVRlMgcGxhdGZvcm1zIHN1cHBvcnQgaGlnaC1wZXJmb3JtYW5jZSBtb2Rl
IHRoYXQgaW5saW5lDQplbmNyeXB0aW9uIGVuZ2luZSBjYW4gYmUgYm9vc3RlZCB3aGlsZSBVRlMg
aXMgbm90IGNsb2NrLWdhdGVkLg0KDQpUaGUgaGlnaC1wZXJmb3JtYW5jZSBtb2RlIHdpbGwgYmUg
ZW5hYmxlZCBpZiBhbGwgYmVsb3cgY29uZGl0aW9ucyBhcmUNCndlbGwtZGVjbGFpcmVkIGluIGRl
dmljZSB0cmVlLA0KDQoxLiBQcm9wZXIgcGxhdGZvcm0tc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJp
bmcgd2hpY2ggZW5hYmxlcyB0aGUgaG9zdA0KICAgY2FwYWJpbGl0eSAiVUZTX01US19DQVBfQk9P
U1RfQ1JZUFRfRU5HSU5FIi4NCg0KMi4gImR2ZnNyYy12Y29yZSIgbm9kZSBpcyBhdmFpbGFibGUg
aW4gdGhpcyBwbGF0Zm9ybS4NCg0KMy4gQ2xvY2sgbXV4IGFuZCBjbG9jayBwYXJlbnRzIG9mIGlu
bGluZSBlbmNyeXB0aW9uIGVuZ2luZSBmb3IgYm90aA0KICAgImxvdy1wb3dlciBtb2RlIiBhbmQg
ImhpZ2gtcGVyZm9ybWFuY2UgbW9kZSIuDQoNClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxz
dGFubGV5LmNodUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRp
YXRlay5jIHwgMTc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogZHJpdmVycy9z
Y3NpL3Vmcy91ZnMtbWVkaWF0ZWsuaCB8ICAyMiArKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxOTIg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS91ZnMvdWZzLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5jDQpp
bmRleCAzZWM0NGRmYTI1NjcuLjgzYjgzZjIxMDY3ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2Nz
aS91ZnMvdWZzLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVr
LmMNCkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L29mLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCisjaW5j
bHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCiAj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ3Vs
YXRvci9jb25zdW1lci5oPg0KQEAgLTQ0LDYgKzQ1LDI4IEBAIHN0YXRpYyBzdHJ1Y3QgdWZzX2Rl
dl9maXggdWZzX210a19kZXZfZml4dXBzW10gPSB7DQogCUVORF9GSVgNCiB9Ow0KIA0KK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgdWZzX210a19ob3N0X2NmZyB1ZnNfbXRrX210ODE5Ml9jZmcgPSB7DQor
CS5jYXBzID0gVUZTX01US19DQVBfQk9PU1RfQ1JZUFRfRU5HSU5FLA0KK307DQorDQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdWZzX210a19vZl9tYXRjaFtdID0gew0KKwl7DQor
CQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtdWZzaGNpIiwNCisJfSwNCisJew0KKwkJ
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXVmc2hjaSIsDQorCQkuZGF0YSA9ICZ1ZnNf
bXRrX210ODE5Ml9jZmcNCisJfSwNCisJe30sDQorfTsNCisNCitzdGF0aWMgYm9vbCB1ZnNfbXRr
X2lzX2Jvb3N0X2NyeXB0X2VuYWJsZWQoc3RydWN0IHVmc19oYmEgKmhiYSkNCit7DQorCXN0cnVj
dCB1ZnNfbXRrX2hvc3QgKmhvc3QgPSB1ZnNoY2RfZ2V0X3ZhcmlhbnQoaGJhKTsNCisNCisJcmV0
dXJuIChob3N0LT5jYXBzICYgVUZTX01US19DQVBfQk9PU1RfQ1JZUFRfRU5HSU5FKTsNCit9DQor
DQogc3RhdGljIHZvaWQgdWZzX210a19jZmdfdW5pcHJvX2NnKHN0cnVjdCB1ZnNfaGJhICpoYmEs
IGJvb2wgZW5hYmxlKQ0KIHsNCiAJdTMyIHRtcDsNCkBAIC0yOTQsNiArMzE3LDEzNyBAQCBzdGF0
aWMgdm9pZCB1ZnNfbXRrX21waHlfcG93ZXJfb24oc3RydWN0IHVmc19oYmEgKmhiYSwgYm9vbCBv
bikNCiAJaG9zdC0+bXBoeV9wb3dlcmVkX29uID0gb247DQogfQ0KIA0KK3N0YXRpYyBpbnQgdWZz
X210a19nZXRfaG9zdF9jbGsoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0K
KwkJCQlzdHJ1Y3QgY2xrICoqY2xrX291dCkNCit7DQorCXN0cnVjdCBjbGsgKmNsazsNCisJaW50
IGVyciA9IDA7DQorDQorCWNsayA9IGRldm1fY2xrX2dldChkZXYsIG5hbWUpOw0KKwlpZiAoSVNf
RVJSKGNsaykpDQorCQllcnIgPSBQVFJfRVJSKGNsayk7DQorCWVsc2UNCisJCSpjbGtfb3V0ID0g
Y2xrOw0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCisNCitzdGF0aWMgdm9pZCB1ZnNfbXRrX2Jvb3N0
X2NyeXB0KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgYm9vc3QpDQorew0KKwlzdHJ1Y3QgdWZz
X210a19ob3N0ICpob3N0ID0gdWZzaGNkX2dldF92YXJpYW50KGhiYSk7DQorCXN0cnVjdCB1ZnNf
bXRrX2NyeXB0X2NmZyAqY2ZnOw0KKwlzdHJ1Y3QgcmVndWxhdG9yICpyZWc7DQorCWludCB2b2x0
LCByZXQ7DQorDQorCWlmICghdWZzX210a19pc19ib29zdF9jcnlwdF9lbmFibGVkKGhiYSkpDQor
CQlyZXR1cm47DQorDQorCWNmZyA9IGhvc3QtPmNyeXB0Ow0KKwl2b2x0ID0gY2ZnLT52Y29yZV92
b2x0Ow0KKwlyZWcgPSBjZmctPnJlZ192Y29yZTsNCisNCisJcmV0ID0gY2xrX3ByZXBhcmVfZW5h
YmxlKGNmZy0+Y2xrX2NyeXB0X211eCk7DQorCWlmIChyZXQpIHsNCisJCWRldl9pbmZvKGhiYS0+
ZGV2LCAiY2xrX3ByZXBhcmVfZW5hYmxlKCk6ICVkXG4iLA0KKwkJCSByZXQpOw0KKwkJcmV0dXJu
Ow0KKwl9DQorDQorCWlmIChib29zdCkgew0KKwkJcmV0ID0gcmVndWxhdG9yX3NldF92b2x0YWdl
KHJlZywgdm9sdCwgSU5UX01BWCk7DQorCQlpZiAocmV0KSB7DQorCQkJZGV2X2luZm8oaGJhLT5k
ZXYsDQorCQkJCSAiZmFpbGVkIHRvIHNldCB2Y29yZSB0byAlZFxuIiwgdm9sdCk7DQorCQkJZ290
byBvdXQ7DQorCQl9DQorDQorCQlyZXQgPSBjbGtfc2V0X3BhcmVudChjZmctPmNsa19jcnlwdF9t
dXgsDQorCQkJCSAgICAgY2ZnLT5jbGtfY3J5cHRfcGVyZik7DQorCQlpZiAocmV0KSB7DQorCQkJ
ZGV2X2luZm8oaGJhLT5kZXYsDQorCQkJCSAiZmFpbGVkIHRvIHNldCBjbGtfY3J5cHRfcGVyZlxu
Iik7DQorCQkJcmVndWxhdG9yX3NldF92b2x0YWdlKHJlZywgMCwgSU5UX01BWCk7DQorCQkJZ290
byBvdXQ7DQorCQl9DQorCX0gZWxzZSB7DQorCQlyZXQgPSBjbGtfc2V0X3BhcmVudChjZmctPmNs
a19jcnlwdF9tdXgsDQorCQkJCSAgICAgY2ZnLT5jbGtfY3J5cHRfbHApOw0KKwkJaWYgKHJldCkg
ew0KKwkJCWRldl9pbmZvKGhiYS0+ZGV2LA0KKwkJCQkgImZhaWxlZCB0byBzZXQgY2xrX2NyeXB0
X2xwXG4iKTsNCisJCQlnb3RvIG91dDsNCisJCX0NCisNCisJCXJldCA9IHJlZ3VsYXRvcl9zZXRf
dm9sdGFnZShyZWcsIDAsIElOVF9NQVgpOw0KKwkJaWYgKHJldCkgew0KKwkJCWRldl9pbmZvKGhi
YS0+ZGV2LA0KKwkJCQkgImZhaWxlZCB0byBzZXQgdmNvcmUgdG8gTUlOXG4iKTsNCisJCX0NCisJ
fQ0KK291dDoNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGNmZy0+Y2xrX2NyeXB0X211eCk7DQor
fQ0KKw0KK3N0YXRpYyBpbnQgdWZzX210a19pbml0X2hvc3RfY2xrKHN0cnVjdCB1ZnNfaGJhICpo
YmEsIGNvbnN0IGNoYXIgKm5hbWUsDQorCQkJCSBzdHJ1Y3QgY2xrICoqY2xrKQ0KK3sNCisJaW50
IHJldDsNCisNCisJcmV0ID0gdWZzX210a19nZXRfaG9zdF9jbGsoaGJhLT5kZXYsIG5hbWUsIGNs
ayk7DQorCWlmIChyZXQpIHsNCisJCWRldl9pbmZvKGhiYS0+ZGV2LCAiJXM6IGZhaWxlZCB0byBn
ZXQgJXM6ICVkIiwgX19mdW5jX18sDQorCQkJIG5hbWUsIHJldCk7DQorCX0NCisNCisJcmV0dXJu
IHJldDsNCit9DQorDQorc3RhdGljIHZvaWQgdWZzX210a19pbml0X2hvc3RfY2FwcyhzdHJ1Y3Qg
dWZzX2hiYSAqaGJhKQ0KK3sNCisJc3RydWN0IHVmc19tdGtfaG9zdCAqaG9zdCA9IHVmc2hjZF9n
ZXRfdmFyaWFudChoYmEpOw0KKwlzdHJ1Y3QgdWZzX210a19jcnlwdF9jZmcgKmNmZzsNCisJc3Ry
dWN0IGRldmljZSAqZGV2ID0gaGJhLT5kZXY7DQorCXN0cnVjdCByZWd1bGF0b3IgKnJlZzsNCisN
CisJaG9zdC0+Y2FwcyA9IGhvc3QtPmNmZy0+Y2FwczsNCisNCisJaWYgKCF1ZnNfbXRrX2lzX2Jv
b3N0X2NyeXB0X2VuYWJsZWQoaGJhKSkNCisJCXJldHVybjsNCisNCisJaG9zdC0+Y3J5cHQgPSBk
ZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKihob3N0LT5jcnlwdCkpLA0KKwkJCQkgICBHRlBfS0VS
TkVMKTsNCisJaWYgKCFob3N0LT5jcnlwdCkNCisJCWdvdG8gZGlzYWJsZV9jYXBzOw0KKw0KKwly
ZWcgPSBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwoZGV2LCAiZHZmc3JjLXZjb3JlIik7DQor
CWlmIChJU19FUlIocmVnKSkgew0KKwkJZGV2X2luZm8oZGV2LCAiZmFpbGVkIHRvIGdldCBkdmZz
cmMtdmNvcmU6ICVsZCIsDQorCQkJIFBUUl9FUlIocmVnKSk7DQorCQlnb3RvIGRpc2FibGVfY2Fw
czsNCisJfQ0KKw0KKwljZmcgPSBob3N0LT5jcnlwdDsNCisJaWYgKHVmc19tdGtfaW5pdF9ob3N0
X2NsayhoYmEsICJjcnlwdF9tdXgiLA0KKwkJCQkgICZjZmctPmNsa19jcnlwdF9tdXgpKQ0KKwkJ
Z290byBkaXNhYmxlX2NhcHM7DQorDQorCWlmICh1ZnNfbXRrX2luaXRfaG9zdF9jbGsoaGJhLCAi
Y3J5cHRfbHAiLA0KKwkJCQkgICZjZmctPmNsa19jcnlwdF9scCkpDQorCQlnb3RvIGRpc2FibGVf
Y2FwczsNCisNCisJaWYgKHVmc19tdGtfaW5pdF9ob3N0X2NsayhoYmEsICJjcnlwdF9wZXJmIiwN
CisJCQkJICAmY2ZnLT5jbGtfY3J5cHRfcGVyZikpDQorCQlnb3RvIGRpc2FibGVfY2FwczsNCisN
CisJY2ZnLT5yZWdfdmNvcmUgPSByZWc7DQorCWNmZy0+dmNvcmVfdm9sdCA9IDYwMDAwMDsNCisJ
ZGV2X2luZm8oZGV2LCAiY2FwczogYm9vc3QtY3J5cHQiKTsNCisJcmV0dXJuOw0KKw0KK2Rpc2Fi
bGVfY2FwczoNCisJaG9zdC0+Y2FwcyAmPSB+VUZTX01US19DQVBfQk9PU1RfQ1JZUFRfRU5HSU5F
Ow0KK30NCisNCiAvKioNCiAgKiB1ZnNfbXRrX3NldHVwX2Nsb2NrcyAtIGVuYWJsZXMvZGlzYWJs
ZSBjbG9ja3MNCiAgKiBAaGJhOiBob3N0IGNvbnRyb2xsZXIgaW5zdGFuY2UNCkBAIC0zMzYsMTIg
KzQ5MCwxNCBAQCBzdGF0aWMgaW50IHVmc19tdGtfc2V0dXBfY2xvY2tzKHN0cnVjdCB1ZnNfaGJh
ICpoYmEsIGJvb2wgb24sDQogCQl9DQogDQogCQlpZiAoY2xrX3B3cl9vZmYpIHsNCisJCQl1ZnNf
bXRrX2Jvb3N0X2NyeXB0KGhiYSwgb24pOw0KIAkJCXVmc19tdGtfc2V0dXBfcmVmX2NsayhoYmEs
IG9uKTsNCiAJCQl1ZnNfbXRrX21waHlfcG93ZXJfb24oaGJhLCBvbik7DQogCQl9DQogCX0gZWxz
ZSBpZiAob24gJiYgc3RhdHVzID09IFBPU1RfQ0hBTkdFKSB7DQogCQl1ZnNfbXRrX21waHlfcG93
ZXJfb24oaGJhLCBvbik7DQogCQl1ZnNfbXRrX3NldHVwX3JlZl9jbGsoaGJhLCBvbik7DQorCQl1
ZnNfbXRrX2Jvb3N0X2NyeXB0KGhiYSwgb24pOw0KIAl9DQogDQogCXJldHVybiByZXQ7DQpAQCAt
MzU5LDggKzUxNSw5IEBAIHN0YXRpYyBpbnQgdWZzX210a19zZXR1cF9jbG9ja3Moc3RydWN0IHVm
c19oYmEgKmhiYSwgYm9vbCBvbiwNCiAgKi8NCiBzdGF0aWMgaW50IHVmc19tdGtfaW5pdChzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQ0KIHsNCi0Jc3RydWN0IHVmc19tdGtfaG9zdCAqaG9zdDsNCisJY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCAqaWQ7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9IGhiYS0+
ZGV2Ow0KKwlzdHJ1Y3QgdWZzX210a19ob3N0ICpob3N0Ow0KIAlpbnQgZXJyID0gMDsNCiANCiAJ
aG9zdCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaG9zdCksIEdGUF9LRVJORUwpOw0KQEAg
LTM3Myw2ICs1MzAsMTggQEAgc3RhdGljIGludCB1ZnNfbXRrX2luaXQoc3RydWN0IHVmc19oYmEg
KmhiYSkNCiAJaG9zdC0+aGJhID0gaGJhOw0KIAl1ZnNoY2Rfc2V0X3ZhcmlhbnQoaGJhLCBob3N0
KTsNCiANCisJLyogR2V0IGhvc3QgY2FwYWJpbGl0eSBhbmQgcGxhdGZvcm0gZGF0YSAqLw0KKwlp
ZCA9IG9mX21hdGNoX2RldmljZSh1ZnNfbXRrX29mX21hdGNoLCBkZXYpOw0KKwlpZiAoIWlkKSB7
DQorCQllcnIgPSAtRUlOVkFMOw0KKwkJZ290byBvdXQ7DQorCX0NCisNCisJaWYgKGlkLT5kYXRh
KSB7DQorCQlob3N0LT5jZmcgPSAoc3RydWN0IHVmc19tdGtfaG9zdF9jZmcgKilpZC0+ZGF0YTsN
CisJCXVmc19tdGtfaW5pdF9ob3N0X2NhcHMoaGJhKTsNCisJfQ0KKw0KIAllcnIgPSB1ZnNfbXRr
X2JpbmRfbXBoeShoYmEpOw0KIAlpZiAoZXJyKQ0KIAkJZ290byBvdXRfdmFyaWFudF9jbGVhcjsN
CkBAIC03ODIsMTEgKzk1MSw2IEBAIHN0YXRpYyBpbnQgdWZzX210a19yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIHVmc19tdGtfb2ZfbWF0Y2hbXSA9IHsNCi0JeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODMtdWZzaGNpIn0sDQotCXt9LA0KLX07DQotDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIHVmc19tdGtfcG1fb3BzID0gew0KIAkuc3VzcGVuZCAgICAg
ICAgID0gdWZzaGNkX3BsdGZybV9zdXNwZW5kLA0KIAkucmVzdW1lICAgICAgICAgID0gdWZzaGNk
X3BsdGZybV9yZXN1bWUsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0
ZWsuaCBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmgNCmluZGV4IDVjMzJkNWY1Mjc1
OS4uMmI2YTEzMTJjOWJjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0
ZWsuaA0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuaA0KQEAgLTg5LDkgKzg5
LDMxIEBAIGVudW0gew0KIAlUWF9DTEtfR0FURV9FTiAgICAgICAgICA9IDMsDQogfTsNCiANCisv
Kg0KKyAqIEhvc3QgY2FwYWJpbGl0eQ0KKyAqLw0KK2VudW0gdWZzX210a19ob3N0X2NhcHMgew0K
KwlVRlNfTVRLX0NBUF9CT09TVF9DUllQVF9FTkdJTkUgICAgICAgICA9IDEgPDwgMCwNCit9Ow0K
Kw0KK3N0cnVjdCB1ZnNfbXRrX2NyeXB0X2NmZyB7DQorCXN0cnVjdCByZWd1bGF0b3IgKnJlZ192
Y29yZTsNCisJc3RydWN0IGNsayAqY2xrX2NyeXB0X3BlcmY7DQorCXN0cnVjdCBjbGsgKmNsa19j
cnlwdF9tdXg7DQorCXN0cnVjdCBjbGsgKmNsa19jcnlwdF9scDsNCisJaW50IHZjb3JlX3ZvbHQ7
DQorfTsNCisNCitzdHJ1Y3QgdWZzX210a19ob3N0X2NmZyB7DQorCWVudW0gdWZzX210a19ob3N0
X2NhcHMgY2FwczsNCit9Ow0KKw0KIHN0cnVjdCB1ZnNfbXRrX2hvc3Qgew0KIAlzdHJ1Y3QgdWZz
X2hiYSAqaGJhOw0KIAlzdHJ1Y3QgcGh5ICptcGh5Ow0KKwlzdHJ1Y3QgdWZzX210a19ob3N0X2Nm
ZyAqY2ZnOw0KKwlzdHJ1Y3QgdWZzX210a19jcnlwdF9jZmcgKmNyeXB0Ow0KKwllbnVtIHVmc19t
dGtfaG9zdF9jYXBzIGNhcHM7DQogCXN0cnVjdCByZXNldF9jb250cm9sICpoY2lfcmVzZXQ7DQog
CXN0cnVjdCByZXNldF9jb250cm9sICp1bmlwcm9fcmVzZXQ7DQogCXN0cnVjdCByZXNldF9jb250
cm9sICpjcnlwdG9fcmVzZXQ7DQotLSANCjIuMTguMA0K

