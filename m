Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF711DE699
	for <lists+linux-scsi@lfdr.de>; Fri, 22 May 2020 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgEVMS2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 May 2020 08:18:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42410 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728889AbgEVMSY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 May 2020 08:18:24 -0400
X-UUID: 95ef12c71ef1453685c344ff69309885-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ckHEM7GVI4e4nimxXTABhbmcvCORVQbBj1jfInkgoAg=;
        b=n81B/JDEMXzSi0diDNXDhCFgfIYXJp3X+8YMHa2xMVSdwxEmbSUOkp0CBaez8Ex/nmQBnNcjWMNjqyb9+b5pNfOCmGZ3GMVCxjXbL9NqcBeQisT1cOATNBKlF2exr9PJfrZ9/BjoNceCbHvtX4g56CdpXG9Lq9CBTZUNuwf4TOo=;
X-UUID: 95ef12c71ef1453685c344ff69309885-20200522
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 669861996; Fri, 22 May 2020 20:18:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 20:18:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 20:18:15 +0800
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
        <andy.teng@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <pengshun.zhao@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 3/3] scsi: ufs-mediatek: Introduce low-power mode for device power supply
Date:   Fri, 22 May 2020 20:18:14 +0800
Message-ID: <20200522121814.9100-4-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200522121814.9100-1-stanley.chu@mediatek.com>
References: <20200522121814.9100-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QWxsb3cgZGV2aWNlIHBvd2VyIHN1cHBseSB0byBlbnRlciBsb3ctcG93ZXIgbW9kZSBpZiBkZXZp
Y2Ugd2lsbA0KZG8gbm90aGluZyB0byBzYXZlIG1vcmUgcG93ZXIuDQoNClNpZ25lZC1vZmYtYnk6
IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogUGVu
Z3NodW4gWmhhbyA8cGVuZ3NodW4uemhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Nj
c2kvdWZzL3Vmcy1tZWRpYXRlay5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91
ZnMvdWZzLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5jDQppbmRl
eCAzYzg1ZjVlOTdkZWEuLjVmNDFiN2I3ZGI4ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91
ZnMvdWZzLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMN
CkBAIC0xMiw2ICsxMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5j
bHVkZSA8bGludXgvcGh5L3BoeS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCisjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxp
bnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oPg0KIA0KICNpbmNsdWRlICJ1ZnNoY2QuaCIN
CkBAIC01MjEsNiArNTIyLDE5IEBAIHN0YXRpYyBpbnQgdWZzX210a19saW5rX3NldF9scG0oc3Ry
dWN0IHVmc19oYmEgKmhiYSkNCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHVmc19t
dGtfdnJlZ19zZXRfbHBtKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgbHBtKQ0KK3sNCisJaWYg
KCFoYmEtPnZyZWdfaW5mby52Y2NxMikNCisJCXJldHVybjsNCisNCisJaWYgKGxwbSAmICFoYmEt
PnZyZWdfaW5mby52Y2MtPmVuYWJsZWQpDQorCQlyZWd1bGF0b3Jfc2V0X21vZGUoaGJhLT52cmVn
X2luZm8udmNjcTItPnJlZywNCisJCQkJICAgUkVHVUxBVE9SX01PREVfSURMRSk7DQorCWVsc2Ug
aWYgKCFscG0pDQorCQlyZWd1bGF0b3Jfc2V0X21vZGUoaGJhLT52cmVnX2luZm8udmNjcTItPnJl
ZywNCisJCQkJICAgUkVHVUxBVE9SX01PREVfTk9STUFMKTsNCit9DQorDQogc3RhdGljIGludCB1
ZnNfbXRrX3N1c3BlbmQoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSB1ZnNfcG1fb3AgcG1fb3Ap
DQogew0KIAlpbnQgZXJyOw0KQEAgLTUzNyw2ICs1NTEsMTIgQEAgc3RhdGljIGludCB1ZnNfbXRr
X3N1c3BlbmQoc3RydWN0IHVmc19oYmEgKmhiYSwgZW51bSB1ZnNfcG1fb3AgcG1fb3ApDQogCQkJ
dWZzaGNkX3NldF9saW5rX29mZihoYmEpOw0KIAkJCXJldHVybiAtRUFHQUlOOw0KIAkJfQ0KKwkJ
LyoNCisJCSAqIE1ha2Ugc3VyZSBubyBlcnJvciB3aWxsIGJlIHJldHVybmVkIHRvIHByZXZlbnQN
CisJCSAqIHVmc2hjZF9zdXNwZW5kKCkgcmUtZW5hYmxpbmcgcmVndWxhdG9ycyB3aGlsZSB2cmVn
IGlzIHN0aWxsDQorCQkgKiBpbiBsb3ctcG93ZXIgbW9kZS4NCisJCSAqLw0KKwkJdWZzX210a192
cmVnX3NldF9scG0oaGJhLCB0cnVlKTsNCiAJfQ0KIA0KIAlpZiAoIXVmc2hjZF9pc19saW5rX2Fj
dGl2ZShoYmEpKQ0KQEAgLTU1NCw2ICs1NzQsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfcmVzdW1l
KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gdWZzX3BtX29wIHBtX29wKQ0KIAkJcGh5X3Bvd2Vy
X29uKGhvc3QtPm1waHkpOw0KIA0KIAlpZiAodWZzaGNkX2lzX2xpbmtfaGliZXJuOChoYmEpKSB7
DQorCQl1ZnNfbXRrX3ZyZWdfc2V0X2xwbShoYmEsIGZhbHNlKTsNCiAJCWVyciA9IHVmc19tdGtf
bGlua19zZXRfaHBtKGhiYSk7DQogCQlpZiAoZXJyKSB7DQogCQkJZXJyID0gdWZzaGNkX2xpbmtf
cmVjb3ZlcnkoaGJhKTsNCi0tIA0KMi4xOC4wDQo=

