Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD25184310
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2020 10:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCMJBd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Mar 2020 05:01:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37679 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgCMJBd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Mar 2020 05:01:33 -0400
X-UUID: fde5cb2e67b047df899cc8d87d2a9016-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AFM96yV028irlR8soZH4MHzhmotsvDaTG8EF1C+nQj8=;
        b=u3q9GsEHuNW7Izeq4jNF61wxDF33YEKONVjqj4ufEdH7WYEc0kheYu8Y+uMirzO7unYDDwaZCNwW5kUgE8OS7J+9vGOQBY8xWXaOhNalwEffI1FfW5oSoWss3OJuohcH5CH/XQDeIO0hnhkTYTKhOT05o49gdBzUcFi2lC2xhfI=;
X-UUID: fde5cb2e67b047df899cc8d87d2a9016-20200313
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1698503112; Fri, 13 Mar 2020 17:01:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 16:58:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:00:33 +0800
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
Subject: [PATCH v4 5/8] scsi: ufs-mediatek: replace all delay places by common delay function
Date:   Fri, 13 Mar 2020 17:01:00 +0800
Message-ID: <20200313090103.15390-6-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200313090103.15390-1-stanley.chu@mediatek.com>
References: <20200313090103.15390-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CB1561FCEA9142D01092782EE4159A330F91F9F596C9FD14057BA7479C2D65202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QSBjb21tb24gZGVsYXkgZnVuY3Rpb24gaXMgaW50cm9kdWNlZCBpbiBVRlMgY29yZSBkcml2ZXIs
IHRodXMNCnVmcy1tZWRpYXRlayBjYW4gdXNlIGl0IHRvIHJlcGxhY2UgYWxsIGRlbGF5IGNvZGVz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYyB8IDIxICsrKysrLS0tLS0t
LS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2Ry
aXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMNCmluZGV4IDNiMGU1NzVkNzQ2MC4uMGZmNjc4
MTY1NGZkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYw0KKysr
IGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYw0KQEAgLTEwMCwxNyArMTAwLDYgQEAg
c3RhdGljIGludCB1ZnNfbXRrX2JpbmRfbXBoeShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAlyZXR1
cm4gZXJyOw0KIH0NCiANCi1zdGF0aWMgdm9pZCB1ZnNfbXRrX3VkZWxheSh1bnNpZ25lZCBsb25n
IHVzKQ0KLXsNCi0JaWYgKCF1cykNCi0JCXJldHVybjsNCi0NCi0JaWYgKHVzIDwgMTApDQotCQl1
ZGVsYXkodXMpOw0KLQllbHNlDQotCQl1c2xlZXBfcmFuZ2UodXMsIHVzICsgMTApOw0KLX0NCi0N
CiBzdGF0aWMgaW50IHVmc19tdGtfc2V0dXBfcmVmX2NsayhzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBi
b29sIG9uKQ0KIHsNCiAJc3RydWN0IHVmc19tdGtfaG9zdCAqaG9zdCA9IHVmc2hjZF9nZXRfdmFy
aWFudChoYmEpOw0KQEAgLTEyMyw3ICsxMTIsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfc2V0dXBf
cmVmX2NsayhzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBib29sIG9uKQ0KIA0KIAlpZiAob24pIHsNCiAJ
CXVmc19tdGtfcmVmX2Nsa19ub3RpZnkob24sIHJlcyk7DQotCQl1ZnNfbXRrX3VkZWxheShob3N0
LT5yZWZfY2xrX3VuZ2F0aW5nX3dhaXRfdXMpOw0KKwkJdWZzaGNkX3dhaXRfdXMoaG9zdC0+cmVm
X2Nsa191bmdhdGluZ193YWl0X3VzLCAxMCwgdHJ1ZSk7DQogCQl1ZnNoY2Rfd3JpdGVsKGhiYSwg
UkVGQ0xLX1JFUVVFU1QsIFJFR19VRlNfUkVGQ0xLX0NUUkwpOw0KIAl9IGVsc2Ugew0KIAkJdWZz
aGNkX3dyaXRlbChoYmEsIFJFRkNMS19SRUxFQVNFLCBSRUdfVUZTX1JFRkNMS19DVFJMKTsNCkBA
IC0xMzgsNyArMTI3LDcgQEAgc3RhdGljIGludCB1ZnNfbXRrX3NldHVwX3JlZl9jbGsoc3RydWN0
IHVmc19oYmEgKmhiYSwgYm9vbCBvbikNCiAJCWlmICgoKHZhbHVlICYgUkVGQ0xLX0FDSykgPj4g
MSkgPT0gKHZhbHVlICYgUkVGQ0xLX1JFUVVFU1QpKQ0KIAkJCWdvdG8gb3V0Ow0KIA0KLQkJdXNs
ZWVwX3JhbmdlKDEwMCwgMjAwKTsNCisJCXVmc2hjZF93YWl0X3VzKDEwMCwgMTAwLCB0cnVlKTsN
CiAJfSB3aGlsZSAodGltZV9iZWZvcmUoamlmZmllcywgdGltZW91dCkpOw0KIA0KIAlkZXZfZXJy
KGhiYS0+ZGV2LCAibWlzc2luZyBhY2sgb2YgcmVmY2xrIHJlcSwgcmVnOiAweCV4XG4iLCB2YWx1
ZSk7DQpAQCAtMTUwLDcgKzEzOSw3IEBAIHN0YXRpYyBpbnQgdWZzX210a19zZXR1cF9yZWZfY2xr
KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgb24pDQogb3V0Og0KIAlob3N0LT5yZWZfY2xrX2Vu
YWJsZWQgPSBvbjsNCiAJaWYgKCFvbikgew0KLQkJdWZzX210a191ZGVsYXkoaG9zdC0+cmVmX2Ns
a19nYXRpbmdfd2FpdF91cyk7DQorCQl1ZnNoY2Rfd2FpdF91cyhob3N0LT5yZWZfY2xrX2dhdGlu
Z193YWl0X3VzLCAxMCwgdHJ1ZSk7DQogCQl1ZnNfbXRrX3JlZl9jbGtfbm90aWZ5KG9uLCByZXMp
Ow0KIAl9DQogDQpAQCAtNDMwLDEyICs0MTksMTIgQEAgc3RhdGljIHZvaWQgdWZzX210a19kZXZp
Y2VfcmVzZXQoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJICoNCiAJICogVG8gYmUgb24gc2FmZSBz
aWRlLCBrZWVwIHRoZSByZXNldCBsb3cgZm9yIGF0IGxlYXN0IDEwdXMuDQogCSAqLw0KLQl1c2xl
ZXBfcmFuZ2UoMTAsIDE1KTsNCisJdWZzaGNkX3dhaXRfdXMoMTAsIDUsIHRydWUpOw0KIA0KIAl1
ZnNfbXRrX2RldmljZV9yZXNldF9jdHJsKDEsIHJlcyk7DQogDQogCS8qIFNvbWUgZGV2aWNlcyBt
YXkgbmVlZCB0aW1lIHRvIHJlc3BvbmQgdG8gcnN0X24gKi8NCi0JdXNsZWVwX3JhbmdlKDEwMDAw
LCAxNTAwMCk7DQorCXVmc2hjZF93YWl0X3VzKDEwMDAwLCA1MDAwLCB0cnVlKTsNCiANCiAJZGV2
X2luZm8oaGJhLT5kZXYsICJkZXZpY2UgcmVzZXQgZG9uZVxuIik7DQogfQ0KLS0gDQoyLjE4LjAN
Cg==

