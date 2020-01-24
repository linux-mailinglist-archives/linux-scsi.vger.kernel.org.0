Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79F1478A3
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jan 2020 07:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgAXGtl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jan 2020 01:49:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:31589 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbgAXGtk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Jan 2020 01:49:40 -0500
X-UUID: d7e01f615e6a4a1db03db46215489869-20200124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/iGSD+wjvNgUnG2Paki6e43ca0HmiXdtKRWjFiR1Rb8=;
        b=njXorR7Xp8QqcVM7HbRRvz2YzAyVpzrjX/HpAh1jyeK6HpA0+vUjFSPOFF4gzvZhg93+2b17Muvt0hhj/RjW4Hswvf26Q5hllhXKScRtxL8rmrX9ZO8Fcki57REFW8HappNdRet8a94yYI+U/lm7D8NQf6WeXxeRNWcBgOxpGew=;
X-UUID: d7e01f615e6a4a1db03db46215489869-20200124
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1480089201; Fri, 24 Jan 2020 14:49:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 24 Jan 2020 14:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 24 Jan 2020 14:48:58 +0800
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
Subject: [PATCH v1 3/5] scsi: ufs: add ufshcd_is_auto_hibern8_enabled facility
Date:   Fri, 24 Jan 2020 14:49:24 +0800
Message-ID: <20200124064926.29472-4-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200124064926.29472-1-stanley.chu@mediatek.com>
References: <20200124064926.29472-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2186B81FC91BD56D56DC2ED70414E5CFF365755ADAE41D3EA0322DFF951F41F22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QXV0by1IaWJlcm44IG1heSBiZSBkaXNhYmxlZCBieSBzb21lIHZlbmRvcnMgb3Igc3lzZnMNCmlu
IHJ1bnRpbWUgZXZlbiBpZiBBdXRvLUhpYmVybjggY2FwYWJpbGl0eSBpcyBzdXBwb3J0ZWQNCmJ5
IGhvc3QuIFRodXMgcHJvdmlkZSBhIHdheSB0byBkZXRlY3QgaWYgQXV0by1IaWJlcm44IGlzDQph
Y3R1YWxseSBlbmFibGVkIGZvciBmdXR1cmUgcmVsYXRlZCBoYW5kbGluZ3MuDQoNClNpZ25lZC1v
ZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oIGIvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuaA0KaW5kZXggMmFlNmM3Yzg1MjhjLi44MWM3MWEzZTM0NzQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQorKysgYi9kcml2ZXJzL3Nj
c2kvdWZzL3Vmc2hjZC5oDQpAQCAtNTUsNiArNTUsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9jbGsu
aD4NCiAjaW5jbHVkZSA8bGludXgvY29tcGxldGlvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9yZWd1
bGF0b3IvY29uc3VtZXIuaD4NCisjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCiAjaW5jbHVk
ZSAidW5pcHJvLmgiDQogDQogI2luY2x1ZGUgPGFzbS9pcnEuaD4NCkBAIC03NzMsNiArNzc0LDEx
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1ZnNoY2RfaXNfYXV0b19oaWJlcm44X3N1cHBvcnRlZChz
dHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAlyZXR1cm4gKGhiYS0+Y2FwYWJpbGl0aWVzICYgTUFTS19B
VVRPX0hJQkVSTjhfU1VQUE9SVCk7DQogfQ0KIA0KK3N0YXRpYyBpbmxpbmUgYm9vbCB1ZnNoY2Rf
aXNfYXV0b19oaWJlcm44X2VuYWJsZWQoc3RydWN0IHVmc19oYmEgKmhiYSkNCit7DQorCXJldHVy
biBGSUVMRF9HRVQoVUZTSENJX0FISUJFUk44X1RJTUVSX01BU0ssIGhiYS0+YWhpdCkgPyB0cnVl
IDogZmFsc2U7DQorfQ0KKw0KICNkZWZpbmUgdWZzaGNkX3dyaXRlbChoYmEsIHZhbCwgcmVnKQlc
DQogCXdyaXRlbCgodmFsKSwgKGhiYSktPm1taW9fYmFzZSArIChyZWcpKQ0KICNkZWZpbmUgdWZz
aGNkX3JlYWRsKGhiYSwgcmVnKQlcDQotLSANCjIuMTguMA0K

