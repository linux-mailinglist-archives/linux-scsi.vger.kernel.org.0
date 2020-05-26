Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA61C2A46
	for <lists+linux-scsi@lfdr.de>; Sun,  3 May 2020 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgECGEG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 May 2020 02:04:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44123 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgECGEF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 May 2020 02:04:05 -0400
X-UUID: b423f935b4be4dedbe5852074aeb56d2-20200503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KYibbf++Qp3+JdHc699e2So1GRR0TyNSil90rT4UJq0=;
        b=DOW3M92oJ3+tsLZxL9Jt3hrzSYt4oHMA3178x2dHQr85ozlmzlVW3KHKb/uzSd2HnGixJx4bM78Msu3wGt1Gh+CbFZ7I62VxDqjtzAZadzca+xucGGusfVLMRfjZ4hGDoTJqIBtK0hoXbDjQkQV6tjx4hb6G4psBznpkryRxl6U=;
X-UUID: b423f935b4be4dedbe5852074aeb56d2-20200503
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 930530585; Sun, 03 May 2020 14:03:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 3 May 2020 14:03:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 3 May 2020 14:03:54 +0800
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
Subject: [PATCH v4 3/8] scsi: ufs: export ufs_fixup_device_setup() function
Date:   Sun, 3 May 2020 14:03:46 +0800
Message-ID: <20200503060351.10572-4-stanley.chu@mediatek.com>
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

RXhwb3J0IHVmc19maXh1cF9kZXZpY2Vfc2V0dXAoKSB0byBhbGxvdyB2ZW5kb3JzIHRvIHJlLXVz
ZSBpdCBmb3INCmZpeGluZyBkZXZpY2UgcXVyaWtzIG9uIHNwZWNpZmllZCBVRlMgaG9zdHMuDQoN
ClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIHwgNyArKysrLS0tDQogZHJpdmVycy9zY3Np
L3Vmcy91ZnNoY2QuaCB8IDQgKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2Qu
YyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCmluZGV4IGRhN2IzNzU3MDliNi4uNmQ1YjQ5
YzA3YTY5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KKysrIGIvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KQEAgLTY4MzgsMTIgKzY4MzgsMTIgQEAgc3RhdGljIHZv
aWQgdWZzaGNkX3diX3Byb2JlKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHU4ICpkZXNjX2J1ZikNCiAJ
aGJhLT5jYXBzICY9IH5VRlNIQ0RfQ0FQX1dCX0VOOw0KIH0NCiANCi1zdGF0aWMgdm9pZCB1ZnNf
Zml4dXBfZGV2aWNlX3NldHVwKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQordm9pZCB1ZnNoY2RfZml4
dXBfZGV2aWNlX3NldHVwKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHN0cnVjdCB1ZnNfZGV2X2ZpeCAq
Zml4dXBzKQ0KIHsNCiAJc3RydWN0IHVmc19kZXZfZml4ICpmOw0KIAlzdHJ1Y3QgdWZzX2Rldl9p
bmZvICpkZXZfaW5mbyA9ICZoYmEtPmRldl9pbmZvOw0KIA0KLQlmb3IgKGYgPSB1ZnNfZml4dXBz
OyBmLT5xdWlyazsgZisrKSB7DQorCWZvciAoZiA9IGZpeHVwczsgZi0+cXVpcms7IGYrKykgew0K
IAkJaWYgKChmLT53bWFudWZhY3R1cmVyaWQgPT0gZGV2X2luZm8tPndtYW51ZmFjdHVyZXJpZCB8
fA0KIAkJICAgICBmLT53bWFudWZhY3R1cmVyaWQgPT0gVUZTX0FOWV9WRU5ET1IpICYmDQogCQkg
ICAgICgoZGV2X2luZm8tPm1vZGVsICYmDQpAQCAtNjg1Miw2ICs2ODUyLDcgQEAgc3RhdGljIHZv
aWQgdWZzX2ZpeHVwX2RldmljZV9zZXR1cChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAkJCWhiYS0+
ZGV2X3F1aXJrcyB8PSBmLT5xdWlyazsNCiAJfQ0KIH0NCitFWFBPUlRfU1lNQk9MX0dQTCh1ZnNo
Y2RfZml4dXBfZGV2aWNlX3NldHVwKTsNCiANCiBzdGF0aWMgaW50IHVmc19nZXRfZGV2aWNlX2Rl
c2Moc3RydWN0IHVmc19oYmEgKmhiYSkNCiB7DQpAQCAtNjg5OCw3ICs2ODk5LDcgQEAgc3RhdGlj
IGludCB1ZnNfZ2V0X2RldmljZV9kZXNjKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCQlnb3RvIG91
dDsNCiAJfQ0KIA0KLQl1ZnNfZml4dXBfZGV2aWNlX3NldHVwKGhiYSk7DQorCXVmc2hjZF9maXh1
cF9kZXZpY2Vfc2V0dXAoaGJhLCB1ZnNfZml4dXBzKTsNCiAJdWZzaGNkX3ZvcHNfZml4dXBfZGV2
X3F1aXJrcyhoYmEpOw0KIA0KIAkvKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZz
aGNkLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQppbmRleCA1ZmEwM2UwZjNiZDEuLmYz
NDYwMTEyMTg4MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCisrKyBi
L2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmgNCkBAIC02OSw2ICs2OSw3IEBADQogI2luY2x1ZGUg
PHNjc2kvc2NzaV9laC5oPg0KIA0KICNpbmNsdWRlICJ1ZnMuaCINCisjaW5jbHVkZSAidWZzX3F1
aXJrcy5oIg0KICNpbmNsdWRlICJ1ZnNoY2kuaCINCiANCiAjZGVmaW5lIFVGU0hDRCAidWZzaGNk
Ig0KQEAgLTk1MSw3ICs5NTIsOCBAQCBpbnQgdWZzaGNkX3F1ZXJ5X2ZsYWcoc3RydWN0IHVmc19o
YmEgKmhiYSwgZW51bSBxdWVyeV9vcGNvZGUgb3Bjb2RlLA0KIA0KIHZvaWQgdWZzaGNkX2F1dG9f
aGliZXJuOF9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhiYSk7DQogdm9pZCB1ZnNoY2RfYXV0b19o
aWJlcm44X3VwZGF0ZShzdHJ1Y3QgdWZzX2hiYSAqaGJhLCB1MzIgYWhpdCk7DQotDQordm9pZCB1
ZnNoY2RfZml4dXBfZGV2aWNlX3NldHVwKHN0cnVjdCB1ZnNfaGJhICpoYmEsDQorCQkJICAgICAg
IHN0cnVjdCB1ZnNfZGV2X2ZpeCAqZml4dXBzKTsNCiAjZGVmaW5lIFNEX0FTQ0lJX1NURCB0cnVl
DQogI2RlZmluZSBTRF9SQVcgZmFsc2UNCiBpbnQgdWZzaGNkX3JlYWRfc3RyaW5nX2Rlc2Moc3Ry
dWN0IHVmc19oYmEgKmhiYSwgdTggZGVzY19pbmRleCwNCi0tIA0KMi4xOC4wDQo=

