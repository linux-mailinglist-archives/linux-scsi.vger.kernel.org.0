Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34E1DE1E6
	for <lists+linux-scsi@lfdr.de>; Fri, 22 May 2020 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgEVIcU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 May 2020 04:32:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728883AbgEVIcU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 May 2020 04:32:20 -0400
X-UUID: 896b2fc4da5a49cba9ffc87e400a522f-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ySjpqS2b2+5IV1wMLJ9XawozivexLkd7UOWw5IgdK4A=;
        b=XOterxazLQFB2zwnlZuZQfv0G52lbAo5yMLA0BG6FIlRfSinKs01TJWqJ/PoEuXoa7wYoWmP5wIyeUrbPYRPd/y1brlRmAI6VAZZJF9lfip6hZXb5PICgVwEjoYBBYUEbzugyOPZ3f4ZhPfFogBcX2ajd16vFYjDYL0scRIDLIw=;
X-UUID: 896b2fc4da5a49cba9ffc87e400a522f-20200522
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 888027467; Fri, 22 May 2020 16:32:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 16:32:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 16:32:14 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>, <asutoshd@codeaurora.org>
CC:     <beanhuo@micron.com>, <cang@codeaurora.org>,
        <matthias.bgg@gmail.com>, <bvanassche@acm.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Virtual_Global_UFS_Upstream@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v4 2/4] scsi: ufs: Allow WriteBooster on UFS 2.2 devices
Date:   Fri, 22 May 2020 16:32:10 +0800
Message-ID: <20200522083212.4008-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200522083212.4008-1-stanley.chu@mediatek.com>
References: <20200522083212.4008-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
dGVrLmNvbT4NClJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMg
Yi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQppbmRleCA5ZTU1YzUyNGYzMzAuLjBkYmQ4YTdh
NjY0MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCisrKyBiL2RyaXZl
cnMvc2NzaS91ZnMvdWZzaGNkLmMNCkBAIC02OTMwLDYgKzY5MzAsNyBAQCBzdGF0aWMgaW50IHVm
c19nZXRfZGV2aWNlX2Rlc2Moc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJICogVUZTX0RFVklDRV9R
VUlSS19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTIGVuYWJsZWQNCiAJICovDQogCWlmIChkZXZf
aW5mby0+d3NwZWN2ZXJzaW9uID49IDB4MzEwIHx8DQorCSAgICBkZXZfaW5mby0+d3NwZWN2ZXJz
aW9uID09IDB4MjIwIHx8DQogCSAgICAoaGJhLT5kZXZfcXVpcmtzICYgVUZTX0RFVklDRV9RVUlS
S19TVVBQT1JUX0VYVEVOREVEX0ZFQVRVUkVTKSkNCiAJCXVmc2hjZF93Yl9wcm9iZShoYmEsIGRl
c2NfYnVmKTsNCiANCi0tIA0KMi4xOC4wDQo=

