Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555E1EA237
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2020 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFAKrz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Jun 2020 06:47:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29099 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726113AbgFAKq4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Jun 2020 06:46:56 -0400
X-UUID: 17e55ee0386d4a59ae9ee73598f5e7d8-20200601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3tcqnbR/zIlPdKV8ncXNBaptfuExNkU2Wwoy2vi6+Dg=;
        b=LYxPH7Ikoi/Ep5KfZFnE4VbGq89skg7OuL7PkHeAAdH8JvcX47b/hyEtQXI8alTKMCCex5fG8bka+/ou4tgYDPVEdzZog7vcVJOMZLL3iO1+dIVz29ctRK+Jvp+fzZPtVvzWHMIURh4MDphjUMmCpxQR6RbqkC5kTSik3yXKzaA=;
X-UUID: 17e55ee0386d4a59ae9ee73598f5e7d8-20200601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1830363407; Mon, 01 Jun 2020 18:46:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Jun 2020 18:46:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Jun 2020 18:46:45 +0800
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
        <chaotian.jing@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 0/5] scsi: ufs-mediatek: Fix clk-gating and introduce low-power mode for vccq2
Date:   Mon, 1 Jun 2020 18:46:41 +0800
Message-ID: <20200601104646.15436-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGksDQpUaGlzIHNlcmllcyBmaXhlcyBjbGstZ2F0aW5nIGlzc3VlcyBhbmQgaW50cm9kdWNlcyBs
b3ctcG93ZXIgbW9kZSBmb3IgdmNjcTIgaW4gTWVkaWFUZWsgcGxhdGZvcm1zLg0KDQp2MiAtPiB2
MzoNCiAgLSBGaXggKGFkZCBiYWNrKSBsaW5rb2ZmIHN1cHBvcnQgaW4gcGF0Y2ggWzRdIHNpbmNl
IHByZXZpb3VzIHZlcnNpb24gaW5jb3JyZWN0bHkgcmVtb3ZlZCBsaW5rb2ZmIHN1cHBvcnQNCg0K
djEgLT4gdjI6DQogIC0gQWRkIHBhdGNoIFs0XSBhbmQgWzVdDQoNClN0YW5sZXkgQ2h1ICg1KToN
CiAgc2NzaTogdWZzLW1lZGlhdGVrOiBGaXggaW1wcmVjaXNlIHdhaXRpbmcgdGltZSBmb3IgcmVm
LWNsayBjb250cm9sDQogIHNjc2k6IHVmcy1tZWRpYXRlazogRG8gbm90IGdhdGUgY2xvY2tzIGlm
IGF1dG8taGliZXJuOCBpcyBub3QgZW50ZXJlZA0KICAgIHlldA0KICBzY3NpOiB1ZnMtbWVkaWF0
ZWs6IEludHJvZHVjZSBsb3ctcG93ZXIgbW9kZSBmb3IgZGV2aWNlIHBvd2VyIHN1cHBseQ0KICBz
Y3NpOiB1ZnMtbWVkaWF0ZWs6IEZpeCB1bmJhbGFuY2VkIGNsb2NrIG9uL29mZg0KICBzY3NpOiB1
ZnMtbWVkaWF0ZWs6IEFsbG93IHVuYm91bmQgbXBoeQ0KDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMt
bWVkaWF0ZWsuYyB8IDExNiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGRyaXZl
cnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmggfCAgIDMgKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDkw
IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

