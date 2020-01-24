Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183E2148AF5
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jan 2020 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbgAXPIP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jan 2020 10:08:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:63559 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390221AbgAXPH7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Jan 2020 10:07:59 -0500
X-UUID: 3a7e23b2d02d4e87b1c1382881600437-20200124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YOeqNnQON0pZMvJ2TpcgdJrhCqwz0qDgTvW6jd4cUGg=;
        b=EG0HJKwdwX7D17y7vRkPb/H/Gzp2dGzk/Hre5ZSuaywMf3/UxRaUUglkoqUkPlQbRmMok6WmJe7NumsMj5xztt2QowBK1V7CCctlMbAF/fFplGPxeblJpMllMIti8PjKdW/o+8t7zxrgxwUumTx9ikLmK8cAdvKixZvqSgPE+8Y=;
X-UUID: 3a7e23b2d02d4e87b1c1382881600437-20200124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1597464827; Fri, 24 Jan 2020 23:07:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 24 Jan 2020 23:08:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 24 Jan 2020 23:07:16 +0800
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
Subject: [PATCH v2 2/5] scsi: ufs-mediatek: support linkoff state during suspend
Date:   Fri, 24 Jan 2020 23:07:40 +0800
Message-ID: <20200124150743.15110-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200124150743.15110-1-stanley.chu@mediatek.com>
References: <20200124150743.15110-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SWYgc3lzdGVtIHN1c3BlbmQgb3IgcnVudGltZSBzdXNwZW5kIG1vZGUgaXMgY29uZmlndXJlZCBh
cw0KbGlua29mZiBzdGF0ZSwgcGh5IGNhbiBiZSBwb3dlcmVkIG9mZiBhbmQgcmVmZXJlbmNlIGNs
b2NrDQpjYW4gYmUgZ2F0ZWQgaW4gTWVkaWFUZWsgQ2hpcHNldHMuDQoNCkluIHRoZSBzYW1lIHRp
bWUsIHJlbW92ZSByZWR1bmRhbnQgcmVmZXJlbmNlIGNsb2NrIGNvbnRyb2wNCmluIHN1c3BlbmQg
YW5kIHJlc3VtZSBjYWxsYmFja3MgYmVjYXVzZSBzdWNoIGNvbnRyb2wgY2FuIGJlDQp3ZWxsLWhh
bmRsZWQgaW4gc2V0dXBfY2xvY2tzIGNhbGxiYWNrLi4NCg0KU2lnbmVkLW9mZi1ieTogU3Rhbmxl
eSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMv
dWZzLW1lZGlhdGVrLmMgfCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vm
cy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMNCmluZGV4
IDdhYzgzOGNjMTVkMS4uZDc4ODk3YTE0OTA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vm
cy91ZnMtbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYw0K
QEAgLTE2Nyw3ICsxNjcsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfc2V0dXBfY2xvY2tzKHN0cnVj
dCB1ZnNfaGJhICpoYmEsIGJvb2wgb24sDQogDQogCXN3aXRjaCAoc3RhdHVzKSB7DQogCWNhc2Ug
UFJFX0NIQU5HRToNCi0JCWlmICghb24pIHsNCisJCWlmICghb24gJiYgIXVmc2hjZF9pc19saW5r
X2FjdGl2ZShoYmEpKSB7DQogCQkJdWZzX210a19zZXR1cF9yZWZfY2xrKGhiYSwgb24pOw0KIAkJ
CXJldCA9IHBoeV9wb3dlcl9vZmYoaG9zdC0+bXBoeSk7DQogCQl9DQpAQCAtNDM3LDEwICs0Mzcs
MTEgQEAgc3RhdGljIGludCB1ZnNfbXRrX3N1c3BlbmQoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51
bSB1ZnNfcG1fb3AgcG1fb3ApDQogCQllcnIgPSB1ZnNfbXRrX2xpbmtfc2V0X2xwbShoYmEpOw0K
IAkJaWYgKGVycikNCiAJCQlyZXR1cm4gLUVBR0FJTjsNCi0JCXBoeV9wb3dlcl9vZmYoaG9zdC0+
bXBoeSk7DQotCQl1ZnNfbXRrX3NldHVwX3JlZl9jbGsoaGJhLCBmYWxzZSk7DQogCX0NCiANCisJ
aWYgKCF1ZnNoY2RfaXNfbGlua19hY3RpdmUoaGJhKSkNCisJCXBoeV9wb3dlcl9vZmYoaG9zdC0+
bXBoeSk7DQorDQogCXJldHVybiAwOw0KIH0NCiANCkBAIC00NDksOSArNDUwLDEwIEBAIHN0YXRp
YyBpbnQgdWZzX210a19yZXN1bWUoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSB1ZnNfcG1fb3Ag
cG1fb3ApDQogCXN0cnVjdCB1ZnNfbXRrX2hvc3QgKmhvc3QgPSB1ZnNoY2RfZ2V0X3ZhcmlhbnQo
aGJhKTsNCiAJaW50IGVycjsNCiANCi0JaWYgKHVmc2hjZF9pc19saW5rX2hpYmVybjgoaGJhKSkg
ew0KLQkJdWZzX210a19zZXR1cF9yZWZfY2xrKGhiYSwgdHJ1ZSk7DQorCWlmICghdWZzaGNkX2lz
X2xpbmtfYWN0aXZlKGhiYSkpDQogCQlwaHlfcG93ZXJfb24oaG9zdC0+bXBoeSk7DQorDQorCWlm
ICh1ZnNoY2RfaXNfbGlua19oaWJlcm44KGhiYSkpIHsNCiAJCWVyciA9IHVmc19tdGtfbGlua19z
ZXRfaHBtKGhiYSk7DQogCQlpZiAoZXJyKQ0KIAkJCXJldHVybiBlcnI7DQotLSANCjIuMTguMA0K

