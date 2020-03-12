Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47A183135
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2020 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCLNYR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Mar 2020 09:24:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727372AbgCLNYB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Mar 2020 09:24:01 -0400
X-UUID: bf1ae25c1db94894bd7333fad6c49793-20200312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ssIHMZ3gzFIIN/d3N49O20oiYNm4fTdpyf9DffWHFP8=;
        b=pcyN5pRH9SMaygnOI0ScQL2RvaG7HQtev4QnamSBZTxAboeamzEP8Z1zob2uWdn2jU+Y7i59LFYARh29FNBh4mfW6BJ1p+chgsioYrEGvI9PmvXSmTmEnbnoXxftKRoqeC4amKRTojMsYHJsZqhHPRWs8g3D0z7qCea7Df57PSg=;
X-UUID: bf1ae25c1db94894bd7333fad6c49793-20200312
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2055070852; Thu, 12 Mar 2020 21:23:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Mar 2020 21:21:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Mar 2020 21:21:03 +0800
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
Subject: [PATCH v3 7/8] scsi: ufs: make HCE polling more compact to improve initializatoin latency
Date:   Thu, 12 Mar 2020 21:23:49 +0800
Message-ID: <20200312132350.18061-8-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200312132350.18061-1-stanley.chu@mediatek.com>
References: <20200312132350.18061-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

UmVkdWNlIHRoZSB3YWl0aW5nIHBlcmlvZCBiZXR3ZWVuIGVhY2ggSENFIChIb3N0IENvbnRyb2xs
ZXIgRW5hYmxlKQ0KcG9sbGluZyBmcm9tIDUgbXMgdG8gMSBtcy4gSW4gdGhlIHNhbWUgdGltZSwg
aW5jcmVhc2UgdGhlIG1heGltdW0gcG9sbGluZw0KdGltZXMgdG8gbWFrZSAidG90YWwgcG9sbGlu
ZyB0aW1lIiB1bmNoYW5nZWQgYXBwcm94aW1hdGVseS4NCg0KVGhpcyBjaGFuZ2UgY291bGQgbWFr
ZSBIQ0UgaW5pdGlhbGl6YXRvaW4gZmFzdGVyIHRvIGltcHJvdmUgbGF0ZW5jeSBvZg0KdWZzaGNk
IGluaXRpYWxpemF0aW9uLCBlcnJvciByZWNvdmVyeSwgYW5kIHJlc3VtZSBiZWhhdmlvcnMuDQoN
ClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQppbmRleCBkY2Jm
NDVkNTQ3ZDguLmNkMzNkMDdjNTZjZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZz
aGNkLmMNCisrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCkBAIC00MzAxLDcgKzQzMDEs
NyBAQCBpbnQgdWZzaGNkX2hiYV9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJdWZzaGNk
X3dhaXRfdXMoaGJhLT5oYmFfZW5hYmxlX2RlbGF5X3VzLCAxMDAsIHRydWUpOw0KIA0KIAkvKiB3
YWl0IGZvciB0aGUgaG9zdCBjb250cm9sbGVyIHRvIGNvbXBsZXRlIGluaXRpYWxpemF0aW9uICov
DQotCXJldHJ5ID0gMTA7DQorCXJldHJ5ID0gNTA7DQogCXdoaWxlICh1ZnNoY2RfaXNfaGJhX2Fj
dGl2ZShoYmEpKSB7DQogCQlpZiAocmV0cnkpIHsNCiAJCQlyZXRyeS0tOw0KQEAgLTQzMTAsNyAr
NDMxMCw3IEBAIGludCB1ZnNoY2RfaGJhX2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAkJ
CQkiQ29udHJvbGxlciBlbmFibGUgZmFpbGVkXG4iKTsNCiAJCQlyZXR1cm4gLUVJTzsNCiAJCX0N
Ci0JCXVmc2hjZF93YWl0X3VzKDUwMDAsIDEwMCwgdHJ1ZSk7DQorCQl1ZnNoY2Rfd2FpdF91cygx
MDAwLCAxMDAsIHRydWUpOw0KIAl9DQogDQogCS8qIGVuYWJsZSBVSUMgcmVsYXRlZCBpbnRlcnJ1
cHRzICovDQotLSANCjIuMTguMA0K

