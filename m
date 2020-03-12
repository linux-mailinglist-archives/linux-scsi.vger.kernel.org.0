Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715B418313A
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2020 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCLNX5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Mar 2020 09:23:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4695 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgCLNX5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Mar 2020 09:23:57 -0400
X-UUID: af957d97b5094ac8a73c892bb2858151-20200312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jM6zMEkp2gCDGD/bAUrEXxpJslmHATovcsB4DY5GntA=;
        b=HSvOicChF8Uzf64Y4kG3f3VxmW80tlMNBtDDi0dr0JNsBWNTAtmwaL3xOZ7pqa0NITca/2pB8R058zPVes5audjtbzROhwIz6uLW778nHJWf3CkvAhejf7QH+f7Nw7VIDyeFWgH7XmHsFzyNMlMDVGVJUklsMbnWQt/yMussTFM=;
X-UUID: af957d97b5094ac8a73c892bb2858151-20200312
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1577247499; Thu, 12 Mar 2020 21:23:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Mar 2020 21:21:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Mar 2020 21:21:02 +0800
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
Subject: [PATCH v3 1/8] scsi: ufs: fix uninitialized tx_lanes in ufshcd_disable_tx_lcc()
Date:   Thu, 12 Mar 2020 21:23:43 +0800
Message-ID: <20200312132350.18061-2-stanley.chu@mediatek.com>
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

SW4gdWZzaGNkX2Rpc2FibGVfdHhfbGNjKCksIGlmIHVmc2hjZF9kbWVfZ2V0KCkgb3IgdWZzaGNk
X2RtZV9wZWVyX2dldCgpDQpnZXQgZmFpbCwgdW5pbml0aWFsaXplZCB2YXJpYWJsZSAidHhfbGFu
ZXMiIG1heSBiZSB1c2VkIGFzIHVuZXhwZWN0ZWQgbGFuZQ0KSUQgZm9yIERNRSBjb25maWd1cmF0
aW9uLg0KDQpGaXggdGhpcyBpc3N1ZSBieSBpbml0aWFsaXppbmcgInR4X2xhbmVzIi4NCg0KU2ln
bmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZz
L3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KaW5kZXggNTY5OGYxMTY0YTVl
Li4zMTRlODA4YjBkNGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQor
KysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQpAQCAtNDMxNSw3ICs0MzE1LDcgQEAgRVhQ
T1JUX1NZTUJPTF9HUEwodWZzaGNkX2hiYV9lbmFibGUpOw0KIA0KIHN0YXRpYyBpbnQgdWZzaGNk
X2Rpc2FibGVfdHhfbGNjKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGJvb2wgcGVlcikNCiB7DQotCWlu
dCB0eF9sYW5lcywgaSwgZXJyID0gMDsNCisJaW50IHR4X2xhbmVzID0gMCwgaSwgZXJyID0gMDsN
CiANCiAJaWYgKCFwZWVyKQ0KIAkJdWZzaGNkX2RtZV9nZXQoaGJhLCBVSUNfQVJHX01JQihQQV9D
T05ORUNURURUWERBVEFMQU5FUyksDQotLSANCjIuMTguMA0K

