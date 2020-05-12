Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3061CF2D4
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2020 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgELKsJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 May 2020 06:48:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21605 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729639AbgELKsG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 May 2020 06:48:06 -0400
X-UUID: 3ef8f152492044dfa820fb36dbd81c6e-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=shvkj9A9bwueIh1LMlmBnCkpSglW983N02ZzRfmxG8k=;
        b=U8zaTPpa1DggylQs2rikllGQZntCC5iMNKr278anni0Hdre6Qam+L8M3+cJOhRgdhWxma0sEmT4/ik9ZWUCHDDox/iyxcvjAnI/VKKxh7YZdcZhgnQPYUp20VRgpn+rO9IEpx9SLQSyzIGOpgXSZzKU/RSmNBeDIG1LvrvoaDts=;
X-UUID: 3ef8f152492044dfa820fb36dbd81c6e-20200512
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 230759903; Tue, 12 May 2020 18:48:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 18:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 18:47:50 +0800
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
Subject: [PATCH v1 2/4] scsi: ufs: Allow WriteBooster on UFS 2.2 devices
Date:   Tue, 12 May 2020 18:47:48 +0800
Message-ID: <20200512104750.8711-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200512104750.8711-1-stanley.chu@mediatek.com>
References: <20200512104750.8711-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D1B50872121CB6B6D9F75C1A4FDBB9E9BC6FD434C636AD02B0AD00D4503F5AB22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QWNjb3JkaW5nIHRvIHRoZSBVRlMgc3BlY2lmaWNhdGlvbiwgV3JpdGVCb29zdGVyIGlzIG9mZmlj
aWFsbHkNCnN1cHBvcnRlZCBieSBVRlMgMi4yLg0KDQpTaW5jZSBVRlMgMi4yIHNwZWNpZmljYXRp
b24gaGFzIGJlZW4gZmluYWxpemVkIGluIEpFREVDIGFuZA0Kc3VjaCBkZXZpY2VzIGhhdmUgYWxz
byBzaG93ZWQgdXAgaW4gdGhlIG1hcmtldCwgbW9kaWZ5IHRoZQ0KY2hlY2tpbmcgcnVsZSBmb3Ig
dWZzaGNkX3diX3Byb2JlKCkgdG8gYWxsb3cgdGhlc2UgZGV2aWNlcyB0byBlbmFibGUNCldyaXRl
Qm9vc3Rlci4NCg0KU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAxICsNCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMv
dWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQppbmRleCA0MWFkNDUwMWIwZDAu
LmIyOThiZGQzZTY5NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCisr
KyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCkBAIC02OTQyLDYgKzY5NDIsNyBAQCBzdGF0
aWMgaW50IHVmc19nZXRfZGV2aWNlX2Rlc2Moc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJICogVUZT
X0RFVklDRV9RVUlSS19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTIGVuYWJsZWQNCiAJICovDQog
CWlmIChkZXZfaW5mby0+d3NwZWN2ZXJzaW9uID49IDB4MzEwIHx8DQorCSAgICBkZXZfaW5mby0+
d3NwZWN2ZXJzaW9uID09IDB4MjIwIHx8DQogCSAgICAoaGJhLT5kZXZfcXVpcmtzICYgVUZTX0RF
VklDRV9RVUlSS19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTKSkNCiAJCXVmc2hjZF93Yl9wcm9i
ZShoYmEsIGRlc2NfYnVmKTsNCiANCi0tIA0KMi4xOC4wDQo=

