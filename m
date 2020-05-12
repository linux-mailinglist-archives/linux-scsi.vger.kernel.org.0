Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560F21CF2CD
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2020 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgELKrx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 May 2020 06:47:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48135 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgELKrx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 May 2020 06:47:53 -0400
X-UUID: 83a232f5747248bc9fedafc9abff1c4c-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PUUW7PULaCne9XtBwUXC3VWmohwibLK+zV12aIK8IVo=;
        b=V2y017hVlNQObzlmvGrdemUb7f0GnILy/dqFWzhNjN0h7tFDeS+NSUw0L6/LbyxbU1XIWehx1F+PdYJNsSqbK8bVI515eCu8CikWn0g2YaL5Iu5NfYkET+940QaeozpaoWbVtSC0G6sRGSJgMpwBtrTAyzzriYTyehG+dXstiR8=;
X-UUID: 83a232f5747248bc9fedafc9abff1c4c-20200512
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 247812614; Tue, 12 May 2020 18:47:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 18:47:50 +0800
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
Subject: [PATCH v1 0/4] scsi: ufs: Fix WriteBooster and cleanup UFS driver
Date:   Tue, 12 May 2020 18:47:46 +0800
Message-ID: <20200512104750.8711-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGksDQoNClRoaXMgcGF0Y2ggc2V0IGZpeGVzIHNvbWUgV3JpdGVCb29zdGVyIGlzc3VlcyBhbmQg
ZG8gc21hbGwgY2xlYW51cCBpbiBVRlMgZHJpdmVyDQoNClN0YW5sZXkgQ2h1ICg0KToNCiAgc2Nz
aTogdWZzOiBSZW1vdmUgdW5uZWNlc3NhcnkgbWVtc2V0IGZvciBkZXZfaW5mbw0KICBzY3NpOiB1
ZnM6IEFsbG93IFdyaXRlQm9vc3RlciBvbiBVRlMgMi4yIGRldmljZXMNCiAgc2NzaTogdWZzOiBG
aXggaW5kZXggb2YgYXR0cmlidXRlcyBxdWVyeSBmb3IgV3JpdGVCb29zdGVyIGZlYXR1cmUNCiAg
c2NzaTogdWZzOiBGaXggV3JpdGVCb29zdGVyIGZsdXNoIGR1cmluZyBydW50aW1lIHN1c3BlbmQN
Cg0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgfCAxMyArKysrKystLQ0KIGRyaXZlcnMv
c2NzaS91ZnMvdWZzLmggICAgICAgfCAgMSAtDQogZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyAg
ICB8IDU5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvc2Nz
aS91ZnMvdWZzaGNkLmggICAgfCAgMiArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKSwgMzMgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xOC4wDQo=

