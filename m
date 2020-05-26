Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9191C2A48
	for <lists+linux-scsi@lfdr.de>; Sun,  3 May 2020 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgECGEW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 May 2020 02:04:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44123 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726948AbgECGEG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 May 2020 02:04:06 -0400
X-UUID: 7e3c8d0f689f4180af31083e8278ac9f-20200503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZBVUUZf+DNEs831r3e5mrVeWEH2R43z4hy3xuPB6tFA=;
        b=fVAJNCCPTe6EVtRWELQVllQ1WTxXsShiV1OxcwIo6nsPpa7wK1ytPY2X99kh1TIqZIIJs7TjKSWL/gz1uY+LoFn7XjAixVO39A14XdGdRIksH5Op7pJTtSJblv7leI1AAFVmNNgPmYgEydaWrQCUrwfRiUpzOqxSeUW3HMZGky8=;
X-UUID: 7e3c8d0f689f4180af31083e8278ac9f-20200503
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1048901333; Sun, 03 May 2020 14:03:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 3 May 2020 14:03:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 3 May 2020 14:03:55 +0800
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
Subject: [PATCH v4 8/8] scsi: ufs: cleanup WriteBooster feature
Date:   Sun, 3 May 2020 14:03:51 +0800
Message-ID: <20200503060351.10572-9-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200503060351.10572-1-stanley.chu@mediatek.com>
References: <20200503060351.10572-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

U21hbGwgY2xlYW51cCBhcyBiZWxvdyBpdGVtcywNCg0KMS4gVXNlIHVmc2hjZF9pc193Yl9hbGxv
d2VkKCkgZGlyZWN0bHkgaW5zdGVhZCBvZiB1ZnNoY2Rfd2Jfc3VwKCkNCiAgIHNpbmNlIHVmc2hj
ZF93Yl9zdXAoKSBqdXN0IHJldHVybnMgdGhlIHJlc3VsdCBvZg0KICAgdWZzaGNkX2lzX3diX2Fs
bG93ZWQoKS4NCg0KMi4gSW4gdWZzaGNkX3N1c3BlbmQoKSwgImVsc2UgaWYgKCF1ZnNoY2RfaXNf
cnVudGltZV9wbShwbV9vcCkpDQogICBjYW4gYmUgc2ltcGxpZmllZCB0byAiZWxzZSIgc2luY2Ug
Ym90aCBoYXZlIHRoZSBzYW1lIG1lYW5pbmcuDQoNClRoaXMgcGF0Y2ggZG9lcyBub3QgY2hhbmdl
IGFueSBmdW5jdGlvbmFsaXR5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENodSA8c3Rhbmxl
eS5jaHVAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1h
bkB3ZGMuY29tPg0KLS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyB8IDIwICsrKysrKyst
LS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVy
cy9zY3NpL3Vmcy91ZnNoY2QuYw0KaW5kZXggZmUwOTMyMDdjYzQ1Li43NDhjZDVjYTJhZjggMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQorKysgYi9kcml2ZXJzL3Njc2kv
dWZzL3Vmc2hjZC5jDQpAQCAtMjUzLDcgKzI1Myw2IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3NjYWxl
X2Nsa3Moc3RydWN0IHVmc19oYmEgKmhiYSwgYm9vbCBzY2FsZV91cCk7DQogc3RhdGljIGlycXJl
dHVybl90IHVmc2hjZF9pbnRyKGludCBpcnEsIHZvaWQgKl9faGJhKTsNCiBzdGF0aWMgaW50IHVm
c2hjZF9jaGFuZ2VfcG93ZXJfbW9kZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KIAkJCSAgICAgc3Ry
dWN0IHVmc19wYV9sYXllcl9hdHRyICpwd3JfbW9kZSk7DQotc3RhdGljIGJvb2wgdWZzaGNkX3di
X3N1cChzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCiBzdGF0aWMgaW50IHVmc2hjZF93Yl9idWZfZmx1
c2hfZW5hYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpOw0KIHN0YXRpYyBpbnQgdWZzaGNkX3diX2J1
Zl9mbHVzaF9kaXNhYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpOw0KIHN0YXRpYyBpbnQgdWZzaGNk
X3diX2N0cmwoc3RydWN0IHVmc19oYmEgKmhiYSwgYm9vbCBlbmFibGUpOw0KQEAgLTI4NSw3ICsy
ODQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdWZzaGNkX3diX2NvbmZpZyhzdHJ1Y3QgdWZzX2hi
YSAqaGJhKQ0KIHsNCiAJaW50IHJldDsNCiANCi0JaWYgKCF1ZnNoY2Rfd2Jfc3VwKGhiYSkpDQor
CWlmICghdWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSkNCiAJCXJldHVybjsNCiANCiAJcmV0ID0g
dWZzaGNkX3diX2N0cmwoaGJhLCB0cnVlKTsNCkBAIC01MTk3LDE4ICs1MTk2LDEzIEBAIHN0YXRp
YyB2b2lkIHVmc2hjZF9ia29wc19leGNlcHRpb25fZXZlbnRfaGFuZGxlcihzdHJ1Y3QgdWZzX2hi
YSAqaGJhKQ0KIAkJCQlfX2Z1bmNfXywgZXJyKTsNCiB9DQogDQotc3RhdGljIGJvb2wgdWZzaGNk
X3diX3N1cChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KLXsNCi0JcmV0dXJuIHVmc2hjZF9pc193Yl9h
bGxvd2VkKGhiYSk7DQotfQ0KLQ0KIHN0YXRpYyBpbnQgdWZzaGNkX3diX2N0cmwoc3RydWN0IHVm
c19oYmEgKmhiYSwgYm9vbCBlbmFibGUpDQogew0KIAlpbnQgcmV0Ow0KIAl1OCBpbmRleDsNCiAJ
ZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlOw0KIA0KLQlpZiAoIXVmc2hjZF93Yl9zdXAoaGJhKSkN
CisJaWYgKCF1ZnNoY2RfaXNfd2JfYWxsb3dlZChoYmEpKQ0KIAkJcmV0dXJuIDA7DQogDQogCWlm
ICghKGVuYWJsZSBeIGhiYS0+d2JfZW5hYmxlZCkpDQpAQCAtNTI2NCw3ICs1MjU4LDcgQEAgc3Rh
dGljIGludCB1ZnNoY2Rfd2JfYnVmX2ZsdXNoX2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0K
IAlpbnQgcmV0Ow0KIAl1OCBpbmRleDsNCiANCi0JaWYgKCF1ZnNoY2Rfd2Jfc3VwKGhiYSkgfHwg
aGJhLT53Yl9idWZfZmx1c2hfZW5hYmxlZCkNCisJaWYgKCF1ZnNoY2RfaXNfd2JfYWxsb3dlZCho
YmEpIHx8IGhiYS0+d2JfYnVmX2ZsdXNoX2VuYWJsZWQpDQogCQlyZXR1cm4gMDsNCiANCiAJaW5k
ZXggPSB1ZnNoY2Rfd2JfZ2V0X2ZsYWdfaW5kZXgoaGJhKTsNCkBAIC01Mjg2LDcgKzUyODAsNyBA
QCBzdGF0aWMgaW50IHVmc2hjZF93Yl9idWZfZmx1c2hfZGlzYWJsZShzdHJ1Y3QgdWZzX2hiYSAq
aGJhKQ0KIAlpbnQgcmV0Ow0KIAl1OCBpbmRleDsNCiANCi0JaWYgKCF1ZnNoY2Rfd2Jfc3VwKGhi
YSkgfHwgIWhiYS0+d2JfYnVmX2ZsdXNoX2VuYWJsZWQpDQorCWlmICghdWZzaGNkX2lzX3diX2Fs
bG93ZWQoaGJhKSB8fCAhaGJhLT53Yl9idWZfZmx1c2hfZW5hYmxlZCkNCiAJCXJldHVybiAwOw0K
IA0KIAlpbmRleCA9IHVmc2hjZF93Yl9nZXRfZmxhZ19pbmRleChoYmEpOw0KQEAgLTUzMzYsNyAr
NTMzMCw3IEBAIHN0YXRpYyBib29sIHVmc2hjZF93Yl9rZWVwX3ZjY19vbihzdHJ1Y3QgdWZzX2hi
YSAqaGJhKQ0KIAlpbnQgcmV0Ow0KIAl1MzIgYXZhaWxfYnVmOw0KIA0KLQlpZiAoIXVmc2hjZF93
Yl9zdXAoaGJhKSkNCisJaWYgKCF1ZnNoY2RfaXNfd2JfYWxsb3dlZChoYmEpKQ0KIAkJcmV0dXJu
IGZhbHNlOw0KIAkvKg0KIAkgKiBUaGUgdWZzIGRldmljZSBuZWVkcyB0aGUgdmNjIHRvIGJlIE9O
IHRvIGZsdXNoLg0KQEAgLTgyMjYsMTIgKzgyMjAsMTIgQEAgc3RhdGljIGludCB1ZnNoY2Rfc3Vz
cGVuZChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBlbnVtIHVmc19wbV9vcCBwbV9vcCkNCiAJCSAqIGNv
bmZpZ3VyZWQgV0IgdHlwZSBpcyA3MCUgZnVsbCwga2VlcCB2Y2MgT04NCiAJCSAqIGZvciB0aGUg
ZGV2aWNlIHRvIGZsdXNoIHRoZSB3YiBidWZmZXINCiAJCSAqLw0KLQkJaWYgKChoYmEtPmF1dG9f
YmtvcHNfZW5hYmxlZCAmJiB1ZnNoY2Rfd2Jfc3VwKGhiYSkpIHx8DQorCQlpZiAoKGhiYS0+YXV0
b19ia29wc19lbmFibGVkICYmIHVmc2hjZF9pc193Yl9hbGxvd2VkKGhiYSkpIHx8DQogCQkgICAg
dWZzaGNkX3diX2tlZXBfdmNjX29uKGhiYSkpDQogCQkJaGJhLT5kZXZfaW5mby5rZWVwX3ZjY19v
biA9IHRydWU7DQogCQllbHNlDQogCQkJaGJhLT5kZXZfaW5mby5rZWVwX3ZjY19vbiA9IGZhbHNl
Ow0KLQl9IGVsc2UgaWYgKCF1ZnNoY2RfaXNfcnVudGltZV9wbShwbV9vcCkpIHsNCisJfSBlbHNl
IHsNCiAJCWhiYS0+ZGV2X2luZm8ua2VlcF92Y2Nfb24gPSBmYWxzZTsNCiAJfQ0KIA0KLS0gDQoy
LjE4LjANCg==

