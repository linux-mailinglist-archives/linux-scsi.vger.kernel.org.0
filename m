Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16751D632B
	for <lists+linux-scsi@lfdr.de>; Sat, 16 May 2020 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEPRqY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 16 May 2020 13:46:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17158 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726238AbgEPRqX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 16 May 2020 13:46:23 -0400
X-UUID: 07c5b6eafeea407d940ae2503b08d813-20200517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cP1jrUWPWOVPgxIIirlAHdjpL7pTLZO8fJ19i9+K9jA=;
        b=Vdc+PvcbwKFWvjb73MYZ4H1CqpImfNP82mK5+yFo9+0Qtvu9tOJBq4lyE1G5GV37vMO22cdek1bTDWI8+0G36nL++tGUK6FBaPRHJFCbV4UapYpMhnd+jpkEp8ZEnU/iEGAO1uMxA2jvfTYR1CFPLW5ZZgUvRUTGMEZjCjeYwH0=;
X-UUID: 07c5b6eafeea407d940ae2503b08d813-20200517
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1037601078; Sun, 17 May 2020 01:46:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 17 May 2020 01:46:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 17 May 2020 01:46:13 +0800
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
Subject: [PATCH v3 2/5] scsi: ufs: Allow WriteBooster on UFS 2.2 devices
Date:   Sun, 17 May 2020 01:46:12 +0800
Message-ID: <20200516174615.15445-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200516174615.15445-1-stanley.chu@mediatek.com>
References: <20200516174615.15445-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 42F24BE482B07131F06058083BE0FC93688E29EC4983011DEF0F26FB5F3517062000:8
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
dWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQppbmRleCA0YTNmMzY0OGM2NGYu
LmY3ZmE1NzEwMjBkYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCisr
KyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCkBAIC02OTI1LDYgKzY5MjUsNyBAQCBzdGF0
aWMgaW50IHVmc19nZXRfZGV2aWNlX2Rlc2Moc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJICogVUZT
X0RFVklDRV9RVUlSS19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTIGVuYWJsZWQNCiAJICovDQog
CWlmIChkZXZfaW5mby0+d3NwZWN2ZXJzaW9uID49IDB4MzEwIHx8DQorCSAgICBkZXZfaW5mby0+
d3NwZWN2ZXJzaW9uID09IDB4MjIwIHx8DQogCSAgICAoaGJhLT5kZXZfcXVpcmtzICYgVUZTX0RF
VklDRV9RVUlSS19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTKSkNCiAJCXVmc2hjZF93Yl9wcm9i
ZShoYmEsIGRlc2NfYnVmKTsNCiANCi0tIA0KMi4xOC4wDQo=

