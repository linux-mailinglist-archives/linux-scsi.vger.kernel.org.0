Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26797165F22
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBTNs6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 08:48:58 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbgBTNs6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Feb 2020 08:48:58 -0500
X-UUID: 51e40b998c3d4425bad56456e53047c9-20200220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j1shUdhIMGXtvTw4SkKdC2CAhrzkCOkweoDSyilUUBo=;
        b=JuGyWgg0RsaKFLxSk6fjV3FIRJ1bjIHfLJD/lwDYvFI29QK150I1/LVKDfZhQPlZP2R3f4maAU7TjKRmtV5IuQ7BLtPmwL3qjPPKXghufc0F24H7uYSZ1m5f0+0qR8DN1YiDSd7vi8ie7gLwSBMWpndL7+idFV/LgUtqHsiPA9U=;
X-UUID: 51e40b998c3d4425bad56456e53047c9-20200220
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1621483974; Thu, 20 Feb 2020 21:48:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Feb 2020 21:49:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Feb 2020 21:46:45 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 1/1] scsi: ufs: ufs-mediatek: add waiting time for reference clock
Date:   Thu, 20 Feb 2020 21:48:48 +0800
Message-ID: <20200220134848.8807-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200220134848.8807-1-stanley.chu@mediatek.com>
References: <20200220134848.8807-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

U29tZSBkZWxheXMgbWF5IGJlIHJlcXVpcmVkIGVpdGhlciBhZnRlciBnYXRpbmcgb3IgYmVmb3Jl
IHVuZ2F0aW5nDQpyZWZlcmVuY2UgY2xvY2sgZm9yIGRldmljZSBhY2NvcmRpbmcgdG8gdmVuZG9y
IHJlcXVpcmVtZW50cy4NCg0KTm90ZSB0aGF0IGluIFVGUyAzLjAsIHRoZSBkZWxheSB0aW1lIGFm
dGVyIGdhdGluZyByZWZlcmVuY2UNCmNsb2NrIGNhbiBiZSBkZWZpbmVkIGJ5IGF0dHJpYnV0ZSBi
UmVmQ2xrR2F0aW5nV2FpdFRpbWUuIFVzZSB0aGUNCmZvcm1hbCB2YWx1ZSBpbnN0ZWFkIGlmIGl0
IGNhbiBiZSBxdWVyaWVkIGZyb20gZGV2aWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENo
dSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMt
bWVkaWF0ZWsuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGRyaXZl
cnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmggfCAgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS91ZnMvdWZzLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5jDQpp
bmRleCA5ZDA1OTYyZmViMTUuLmRlNjUwODIyYzlkOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2Nz
aS91ZnMvdWZzLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVr
LmMNCkBAIC0xMDAsNiArMTAwLDE3IEBAIHN0YXRpYyBpbnQgdWZzX210a19iaW5kX21waHkoc3Ry
dWN0IHVmc19oYmEgKmhiYSkNCiAJcmV0dXJuIGVycjsNCiB9DQogDQorc3RhdGljIHZvaWQgdWZz
X210a191ZGVsYXkodW5zaWduZWQgbG9uZyB1cykNCit7DQorCWlmICghdXMpDQorCQlyZXR1cm47
DQorDQorCWlmICh1cyA8IDEwKQ0KKwkJdWRlbGF5KHVzKTsNCisJZWxzZQ0KKwkJdXNsZWVwX3Jh
bmdlKHVzLCB1cyArIDEwKTsNCit9DQorDQogc3RhdGljIGludCB1ZnNfbXRrX3NldHVwX3JlZl9j
bGsoc3RydWN0IHVmc19oYmEgKmhiYSwgYm9vbCBvbikNCiB7DQogCXN0cnVjdCB1ZnNfbXRrX2hv
c3QgKmhvc3QgPSB1ZnNoY2RfZ2V0X3ZhcmlhbnQoaGJhKTsNCkBAIC0xMTIsNiArMTIzLDcgQEAg
c3RhdGljIGludCB1ZnNfbXRrX3NldHVwX3JlZl9jbGsoc3RydWN0IHVmc19oYmEgKmhiYSwgYm9v
bCBvbikNCiANCiAJaWYgKG9uKSB7DQogCQl1ZnNfbXRrX3JlZl9jbGtfbm90aWZ5KG9uLCByZXMp
Ow0KKwkJdWZzX210a191ZGVsYXkoaG9zdC0+cmVmX2Nsa191bmdhdGluZ193YWl0X3VzKTsNCiAJ
CXVmc2hjZF93cml0ZWwoaGJhLCBSRUZDTEtfUkVRVUVTVCwgUkVHX1VGU19SRUZDTEtfQ1RSTCk7
DQogCX0gZWxzZSB7DQogCQl1ZnNoY2Rfd3JpdGVsKGhiYSwgUkVGQ0xLX1JFTEVBU0UsIFJFR19V
RlNfUkVGQ0xLX0NUUkwpOw0KQEAgLTEzNywxMiArMTQ5LDI5IEBAIHN0YXRpYyBpbnQgdWZzX210
a19zZXR1cF9yZWZfY2xrKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgb24pDQogDQogb3V0Og0K
IAlob3N0LT5yZWZfY2xrX2VuYWJsZWQgPSBvbjsNCi0JaWYgKCFvbikNCisJaWYgKCFvbikgew0K
KwkJdWZzX210a191ZGVsYXkoaG9zdC0+cmVmX2Nsa19nYXRpbmdfd2FpdF91cyk7DQogCQl1ZnNf
bXRrX3JlZl9jbGtfbm90aWZ5KG9uLCByZXMpOw0KKwl9DQogDQogCXJldHVybiAwOw0KIH0NCiAN
CitzdGF0aWMgdm9pZCB1ZnNfbXRrX3NldHVwX3JlZl9jbGtfd2FpdF91cyhzdHJ1Y3QgdWZzX2hi
YSAqaGJhLA0KKwkJCQkJICB1MTYgZ2F0aW5nX3VzLCB1MTYgdW5nYXRpbmdfdXMpDQorew0KKwlz
dHJ1Y3QgdWZzX210a19ob3N0ICpob3N0ID0gdWZzaGNkX2dldF92YXJpYW50KGhiYSk7DQorDQor
CWlmIChoYmEtPmRldl9pbmZvLmNsa19nYXRpbmdfd2FpdF91cykgew0KKwkJaG9zdC0+cmVmX2Ns
a19nYXRpbmdfd2FpdF91cyA9DQorCQkJaGJhLT5kZXZfaW5mby5jbGtfZ2F0aW5nX3dhaXRfdXM7
DQorCX0gZWxzZSB7DQorCQlob3N0LT5yZWZfY2xrX2dhdGluZ193YWl0X3VzID0gZ2F0aW5nX3Vz
Ow0KKwl9DQorDQorCWhvc3QtPnJlZl9jbGtfdW5nYXRpbmdfd2FpdF91cyA9IHVuZ2F0aW5nX3Vz
Ow0KK30NCisNCiBzdGF0aWMgdTMyIHVmc19tdGtfbGlua19nZXRfc3RhdGUoc3RydWN0IHVmc19o
YmEgKmhiYSkNCiB7DQogCXUzMiB2YWw7DQpAQCAtNTAyLDEwICs1MzEsMjMgQEAgc3RhdGljIHZv
aWQgdWZzX210a19kYmdfcmVnaXN0ZXJfZHVtcChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIHN0YXRp
YyBpbnQgdWZzX210a19hcHBseV9kZXZfcXVpcmtzKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogew0K
IAlzdHJ1Y3QgdWZzX2Rldl9pbmZvICpkZXZfaW5mbyA9ICZoYmEtPmRldl9pbmZvOw0KKwl1MTYg
bWlkID0gZGV2X2luZm8tPndtYW51ZmFjdHVyZXJpZDsNCiANCi0JaWYgKGRldl9pbmZvLT53bWFu
dWZhY3R1cmVyaWQgPT0gVUZTX1ZFTkRPUl9TQU1TVU5HKQ0KKwlpZiAobWlkID09IFVGU19WRU5E
T1JfU0FNU1VORykNCiAJCXVmc2hjZF9kbWVfc2V0KGhiYSwgVUlDX0FSR19NSUIoUEFfVEFDVElW
QVRFKSwgNik7DQogDQorCS8qDQorCSAqIERlY2lkZSB3YWl0aW5nIHRpbWUgYmVmb3JlIGdhdGlu
ZyByZWZlcmVuY2UgY2xvY2sgYW5kDQorCSAqIGFmdGVyIHVuZ2F0aW5nIHJlZmVyZW5jZSBjbG9j
ayBhY2NvcmRpbmcgdG8gdmVuZG9ycycNCisJICogcmVxdWlyZW1lbnRzLg0KKwkgKi8NCisJaWYg
KG1pZCA9PSBVRlNfVkVORE9SX1NBTVNVTkcpDQorCQl1ZnNfbXRrX3NldHVwX3JlZl9jbGtfd2Fp
dF91cyhoYmEsIDEsIDEpOw0KKwllbHNlIGlmIChtaWQgPT0gVUZTX1ZFTkRPUl9TS0hZTklYKQ0K
KwkJdWZzX210a19zZXR1cF9yZWZfY2xrX3dhaXRfdXMoaGJhLCAzMCwgMzApOw0KKwllbHNlIGlm
IChtaWQgPT0gVUZTX1ZFTkRPUl9UT1NISUJBKQ0KKwkJdWZzX210a19zZXR1cF9yZWZfY2xrX3dh
aXRfdXMoaGJhLCAxMDAsIDMyKTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1t
ZWRpYXRlay5oDQppbmRleCA0OTI0MTRlNWY0ODEuLjRjNzg3Yjk5ZmU0MSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmgNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMv
dWZzLW1lZGlhdGVrLmgNCkBAIC05Miw2ICs5Miw4IEBAIHN0cnVjdCB1ZnNfbXRrX2hvc3Qgew0K
IAlzdHJ1Y3QgdWZzX2hiYSAqaGJhOw0KIAlzdHJ1Y3QgcGh5ICptcGh5Ow0KIAlib29sIHJlZl9j
bGtfZW5hYmxlZDsNCisJdTE2IHJlZl9jbGtfdW5nYXRpbmdfd2FpdF91czsNCisJdTE2IHJlZl9j
bGtfZ2F0aW5nX3dhaXRfdXM7DQogfTsNCiANCiAjZW5kaWYgLyogIV9VRlNfTUVESUFURUtfSCAq
Lw0KLS0gDQoyLjE4LjANCg==

