Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B751C3DB4
	for <lists+linux-scsi@lfdr.de>; Mon,  4 May 2020 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgEDO4u (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 May 2020 10:56:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729258AbgEDO4n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 May 2020 10:56:43 -0400
X-UUID: 900733c30bbd438f91ab2091d26a12f2-20200504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=R6IoPldbjecpNJlUFNI+QJDeygQJEzCNhy+DoSiGFzY=;
        b=e4I5PU1fV0cZexUBbzDIpVKqrpNdqbFL85D5vLEE0560ElyUXUGaYngBBOUhxWEgTAL+axRKur/qkJggsNM1hDC6mpZqcUDZrlCUK01mn9abgvSLCk1zWQKREp5LCqS5qi/hRIAy5ZtoRS7j2xlddE0Q6nQKJkD7tn3ALJHZJZ4=;
X-UUID: 900733c30bbd438f91ab2091d26a12f2-20200504
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1802880350; Mon, 04 May 2020 22:56:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 May 2020 22:56:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 May 2020 22:56:27 +0800
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
Subject: [PATCH v6 8/8] scsi: ufs: cleanup WriteBooster feature
Date:   Mon, 4 May 2020 22:56:22 +0800
Message-ID: <20200504145622.13895-9-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200504145622.13895-1-stanley.chu@mediatek.com>
References: <20200504145622.13895-1-stanley.chu@mediatek.com>
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
cy9zY3NpL3Vmcy91ZnNoY2QuYw0KaW5kZXggYzc3YzVmNGRlN2MwLi4xMGU2NGY1ZWZhMDYgMTAw
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
IHRvIGZsdXNoLg0KQEAgLTgyMjEsMTIgKzgyMTUsMTIgQEAgc3RhdGljIGludCB1ZnNoY2Rfc3Vz
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

