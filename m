Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C8148AEE
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jan 2020 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbgAXPIC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jan 2020 10:08:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:63559 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390239AbgAXPIA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Jan 2020 10:08:00 -0500
X-UUID: 9147351f5a9d49f4b75294790a52668f-20200124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U+SJilTSjU4Ah23qrbk+p7ZPljJWavFzvAUeFBoGVOE=;
        b=nbwsxi43J4t6JUoJWQOVWd/YtD+HeecE+7TgxSwllbooQKQdilpQ6aP8jKipJPS7pHX8n4S6BLuunoKMmCaEk2TN1MU/+goKst+VMSW4M482fLTt10htj0Znzjc/Ope49uMesC3r+obXuTB0MjJ8KwjZom5eIJMpf9Mu09Zu8bg=;
X-UUID: 9147351f5a9d49f4b75294790a52668f-20200124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1609969415; Fri, 24 Jan 2020 23:07:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 24 Jan 2020 23:07:07 +0800
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
Subject: [PATCH v2 4/5] scsi: ufs: fix auto-hibern8 error detection
Date:   Fri, 24 Jan 2020 23:07:42 +0800
Message-ID: <20200124150743.15110-5-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200124150743.15110-1-stanley.chu@mediatek.com>
References: <20200124150743.15110-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E882959BE61CE493C138527C0779D0F7A3AD316EC64655FCFBF3790C074A38F12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SWYgQXV0by1IaWJlcm44IGNhcGFiaWxpdHkgaXMgc3VwcG9ydGVkIGJ5IGhvc3QgYnV0IG5vdCBh
Y3R1YWxseQ0KZW5hYmxlZCwgQXV0by1IaWJlcm44IGVycm9yIHNoYWxsIG5vdCBoYXBwZW4uIFRo
dXMgYnlwYXNzDQpBdXRvLUhpYmVybjggZGlzYWJsaW5nIGNhc2UgaW4gdWZzaGNkX2lzX2F1dG9f
aGliZXJuOF9lcnJvcigpLg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5j
aHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyB8IDMgKyst
DQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZz
aGNkLmMNCmluZGV4IGFiZDBlNmIwNWY3OS4uMjE0YTNmMzczZGQ4IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0K
QEAgLTU0NzksNyArNTQ3OSw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCB1ZnNoY2RfdXBkYXRlX3Vp
Y19lcnJvcihzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIHN0YXRpYyBib29sIHVmc2hjZF9pc19hdXRv
X2hpYmVybjhfZXJyb3Ioc3RydWN0IHVmc19oYmEgKmhiYSwNCiAJCQkJCSB1MzIgaW50cl9tYXNr
KQ0KIHsNCi0JaWYgKCF1ZnNoY2RfaXNfYXV0b19oaWJlcm44X3N1cHBvcnRlZChoYmEpKQ0KKwlp
ZiAoIXVmc2hjZF9pc19hdXRvX2hpYmVybjhfc3VwcG9ydGVkKGhiYSkgfHwNCisJICAgICF1ZnNo
Y2RfaXNfYXV0b19oaWJlcm44X2VuYWJsZWQoaGJhKSkNCiAJCXJldHVybiBmYWxzZTsNCiANCiAJ
aWYgKCEoaW50cl9tYXNrICYgVUZTSENEX1VJQ19ISUJFUk44X01BU0spKQ0KLS0gDQoyLjE4LjAN
Cg==

