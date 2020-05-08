Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF51CB598
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2020 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEHRPU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 May 2020 13:15:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726767AbgEHRPT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 May 2020 13:15:19 -0400
X-UUID: 6da898a83a1e415ea90f873b44e098ff-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+7J/Ls/qZVPDQuRiUUjEeGW9nmJ58u2HwRnHyuO/vGQ=;
        b=I/j5hLj9mNdY0ka1ODGwW/30hk89NdVQTy7ivuyit6YXb0IHlAUa2jexrkZs1S6UhKgyuTnqX1FSlUWXxXCBey/gkU7EChPYMR9Vz2M0bKbY17gAPN25OeIgHsPLBGt6ltcXTj9Ush21LwW+vTi7d9zBg43RcLgOLcgNhZd/YVQ=;
X-UUID: 6da898a83a1e415ea90f873b44e098ff-20200509
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 815445995; Sat, 09 May 2020 01:15:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 01:15:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 01:15:12 +0800
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
Subject: [PATCH v1 5/5] scsi: ufs-mediatek: customize WriteBooster flush policy
Date:   Sat, 9 May 2020 01:15:13 +0800
Message-ID: <20200508171513.14665-6-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200508171513.14665-1-stanley.chu@mediatek.com>
References: <20200508171513.14665-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Q2hhbmdlIHRoZSBXcml0ZUJvb3N0ZXIgcG9saWN5IHRvIGtlZXAgVkNDIG9uIGR1cmluZw0KcnVu
dGltZSBzdXNwZW5kIGlmIGF2YWlsYWJsZSBXcml0ZUJvb3N0ZXIgYnVmZmVyIGlzIGxlc3MNCnRo
YW4gODAlLg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYyB8IDEgKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMNCmlu
ZGV4IDU2NjIwZjdkODhjZS4uOTRlOTc3MDFmNDU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3Np
L3Vmcy91ZnMtbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsu
Yw0KQEAgLTI3MSw2ICsyNzEsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfaW5pdChzdHJ1Y3QgdWZz
X2hiYSAqaGJhKQ0KIA0KIAkvKiBFbmFibGUgV3JpdGVCb29zdGVyICovDQogCWhiYS0+Y2FwcyB8
PSBVRlNIQ0RfQ0FQX1dCX0VOOw0KKwloYmEtPnZwcy0+d2JfZmx1c2hfdGhyZXNob2xkID0gVUZT
X1dCX0JVRl9SRU1BSU5fUEVSQ0VOVCg4MCk7DQogDQogCS8qDQogCSAqIHVmc2hjZF92b3BzX2lu
aXQoKSBpcyBpbnZva2VkIGFmdGVyDQotLSANCjIuMTguMA0K

