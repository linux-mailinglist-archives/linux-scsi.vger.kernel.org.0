Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51021115B5C
	for <lists+linux-scsi@lfdr.de>; Sat,  7 Dec 2019 07:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfLGGjU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 7 Dec 2019 01:39:20 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbfLGGjU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 7 Dec 2019 01:39:20 -0500
X-UUID: 30520caad3a04d458a6e199ce99c9f6a-20191207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FsOPpGNcvyN3hqCpKWKad5Cxcn0GwUWSQI3FseIG2Rg=;
        b=Ch2EJJRY4iHukue/yzS8oQ9cnCLyxaAYDIp8wKWnk6b2vAHc5j440FyHfuc5usvXgozSluJe0PiAnf0NO/IOaFu68v3rDG8/39vFGnzV6jGZPPo/v+gUEuh2fKLUwUpiubf/r9KC6REHx8Q/NWhF6iF8b4IW2RFhgYTKgHFH2c0=;
X-UUID: 30520caad3a04d458a6e199ce99c9f6a-20191207
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1158404149; Sat, 07 Dec 2019 14:39:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 7 Dec 2019 14:38:51 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 7 Dec 2019 14:38:44 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <beanhuo@micron.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        <leon.chen@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 2/2] scsi: ufs-mediatek: add device reset implementation
Date:   Sat, 7 Dec 2019 14:39:08 +0800
Message-ID: <1575700748-28191-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1575700748-28191-1-git-send-email-stanley.chu@mediatek.com>
References: <1575700748-28191-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QWRkIGRldmljZSByZXNldCB2b3BzIGltcGxlbWVudGF0aW9uIGluIE1lZGlhVGVrIFVGUyBkcml2
ZXIuDQoNClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5jIHwgMjcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuaCB8ICA3
ICsrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vm
cy1tZWRpYXRlay5jDQppbmRleCA4M2UyOGVkYzNhYzUuLjZhM2VjMTFiMTZkYiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91
ZnMvdWZzLW1lZGlhdGVrLmMNCkBAIC02LDEwICs2LDEyIEBADQogICoJUGV0ZXIgV2FuZyA8cGV0
ZXIud2FuZ0BtZWRpYXRlay5jb20+DQogICovDQogDQorI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNj
Yy5oPg0KICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNz
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5o
Pg0KIA0KICNpbmNsdWRlICJ1ZnNoY2QuaCINCiAjaW5jbHVkZSAidWZzaGNkLXBsdGZybS5oIg0K
QEAgLTI2OSw2ICsyNzEsMzAgQEAgc3RhdGljIGludCB1ZnNfbXRrX2xpbmtfc3RhcnR1cF9ub3Rp
Znkoc3RydWN0IHVmc19oYmEgKmhiYSwNCiAJcmV0dXJuIHJldDsNCiB9DQogDQorc3RhdGljIHZv
aWQgdWZzX210a19kZXZpY2VfcmVzZXQoc3RydWN0IHVmc19oYmEgKmhiYSkNCit7DQorCXN0cnVj
dCBhcm1fc21jY2NfcmVzIHJlczsNCisNCisJYXJtX3NtY2NjX3NtYyhNVEtfU0lQX1VGU19DT05U
Uk9MLCBVRlNfTVRLX1NJUF9ERVZJQ0VfUkVTRVQsDQorCQkgICAgICAwLCAwLCAwLCAwLCAwLCAw
LCAmcmVzKTsNCisJLyoNCisJICogVGhlIHJlc2V0IHNpZ25hbCBpcyBhY3RpdmUgbG93LiBVRlMg
ZGV2aWNlcyBzaGFsbCBkZXRlY3QNCisJICogbW9yZSB0aGFuIG9yIGVxdWFsIHRvIDF1cyBvZiBw
b3NpdGl2ZSBvciBuZWdhdGl2ZSBSU1Rfbg0KKwkgKiBwdWxzZSB3aWR0aC4NCisJICoNCisJICog
VG8gYmUgb24gc2FmZSBzaWRlLCBrZWVwIHRoZSByZXNldCBsb3cgZm9yIGF0IGxlYXN0IDEwdXMu
DQorCSAqLw0KKwl1c2xlZXBfcmFuZ2UoMTAsIDE1KTsNCisNCisJYXJtX3NtY2NjX3NtYyhNVEtf
U0lQX1VGU19DT05UUk9MLCBVRlNfTVRLX1NJUF9ERVZJQ0VfUkVTRVQsDQorCQkgICAgICAxLCAw
LCAwLCAwLCAwLCAwLCAmcmVzKTsNCisNCisJLyogU29tZSBkZXZpY2VzIG1heSBuZWVkIHRpbWUg
dG8gcmVzcG9uZCB0byByc3RfbiAqLw0KKwl1c2xlZXBfcmFuZ2UoMTAwMDAsIDE1MDAwKTsNCisN
CisJZGV2X2luZm8oaGJhLT5kZXYsICJkZXZpY2UgcmVzZXQgZG9uZVxuIik7DQorfQ0KKw0KIHN0
YXRpYyBpbnQgdWZzX210a19zdXNwZW5kKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gdWZzX3Bt
X29wIHBtX29wKQ0KIHsNCiAJc3RydWN0IHVmc19tdGtfaG9zdCAqaG9zdCA9IHVmc2hjZF9nZXRf
dmFyaWFudChoYmEpOw0KQEAgLTMwMyw2ICszMjksNyBAQCBzdGF0aWMgc3RydWN0IHVmc19oYmFf
dmFyaWFudF9vcHMgdWZzX2hiYV9tdGtfdm9wcyA9IHsNCiAJLnB3cl9jaGFuZ2Vfbm90aWZ5ICAg
PSB1ZnNfbXRrX3B3cl9jaGFuZ2Vfbm90aWZ5LA0KIAkuc3VzcGVuZCAgICAgICAgICAgICA9IHVm
c19tdGtfc3VzcGVuZCwNCiAJLnJlc3VtZSAgICAgICAgICAgICAgPSB1ZnNfbXRrX3Jlc3VtZSwN
CisJLmRldmljZV9yZXNldCAgICAgICAgPSB1ZnNfbXRrX2RldmljZV9yZXNldCwNCiB9Ow0KIA0K
IC8qKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmggYi9kcml2
ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5oDQppbmRleCAxOWY4YzQyZmUwNmYuLmIwM2Y2MDFk
M2E5ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmgNCisrKyBi
L2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmgNCkBAIC02LDYgKzYsOCBAQA0KICNpZm5k
ZWYgX1VGU19NRURJQVRFS19IDQogI2RlZmluZSBfVUZTX01FRElBVEVLX0gNCiANCisjaW5jbHVk
ZSA8bGludXgvYml0b3BzLmg+DQorDQogLyoNCiAgKiBWZW5kb3Igc3BlY2lmaWMgcHJlLWRlZmlu
ZWQgcGFyYW1ldGVycw0KICAqLw0KQEAgLTI5LDYgKzMxLDExIEBADQogI2RlZmluZSBWU19TQVZF
UE9XRVJDT05UUk9MICAgICAgICAgMHhEMEE2DQogI2RlZmluZSBWU19VTklQUk9QT1dFUkRPV05D
T05UUk9MICAgMHhEMEE4DQogDQorLyoNCisgKiBTaVAgY29tbWFuZHMNCisgKi8NCisjZGVmaW5l
IFVGU19NVEtfU0lQX0RFVklDRV9SRVNFVCAgICBCSVQoMSkNCisNCiAvKg0KICAqIFZTX0RFQlVH
Q0xPQ0tFTkFCTEUNCiAgKi8NCi0tIA0KMi4xOC4wDQo=

