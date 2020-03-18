Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7ED1899AD
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2020 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCRKkx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Mar 2020 06:40:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42689 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbgCRKk0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Mar 2020 06:40:26 -0400
X-UUID: 5978fd2b742e4869b5120814ff692d56-20200318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pe2ICmxiDGZfXw8Ju8bu2oy7yN84cTxQ4OAqo9x25H8=;
        b=XImsuGveFSmHCc5zpKOad/Us27YgUcRuHhs0fTUUsxWfRLR+HWjnhcIZ7lghlMcIrKhXo4DSGo52LGtGnmAgggCvZGXn9L2v/vGdwjYSX1YKfs0KFg0+IP0tCIUGegRpXTbbmGk3wyLOBjYyFgAOFCRO1LnsGZHlPBZSew8K94I=;
X-UUID: 5978fd2b742e4869b5120814ff692d56-20200318
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1502368353; Wed, 18 Mar 2020 18:40:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Mar 2020 18:38:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Mar 2020 18:40:30 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.peter~sen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>, <bvanassche@acm.org>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v7 1/7] scsi: ufs: fix uninitialized tx_lanes in ufshcd_disable_tx_lcc()
Date:   Wed, 18 Mar 2020 18:40:10 +0800
Message-ID: <20200318104016.28049-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200318104016.28049-1-stanley.chu@mediatek.com>
References: <20200318104016.28049-1-stanley.chu@mediatek.com>
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
bmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBBc3V0b3NoIERhcyA8YXN1dG9zaGRAY29kZWF1cm9yYS5vcmc+DQpSZXZpZXdlZC1i
eTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQpSZXZpZXdlZC1ieTogQ2FuIEd1
byA8Y2FuZ0Bjb2RlYXVyb3JhLm9yZz4NCi0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vm
cy91ZnNoY2QuYw0KaW5kZXggNTY5OGYxMTY0YTVlLi4zMTRlODA4YjBkNGUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQorKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hj
ZC5jDQpAQCAtNDMxNSw3ICs0MzE1LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwodWZzaGNkX2hiYV9l
bmFibGUpOw0KIA0KIHN0YXRpYyBpbnQgdWZzaGNkX2Rpc2FibGVfdHhfbGNjKHN0cnVjdCB1ZnNf
aGJhICpoYmEsIGJvb2wgcGVlcikNCiB7DQotCWludCB0eF9sYW5lcywgaSwgZXJyID0gMDsNCisJ
aW50IHR4X2xhbmVzID0gMCwgaSwgZXJyID0gMDsNCiANCiAJaWYgKCFwZWVyKQ0KIAkJdWZzaGNk
X2RtZV9nZXQoaGJhLCBVSUNfQVJHX01JQihQQV9DT05ORUNURURUWERBVEFMQU5FUyksDQotLSAN
CjIuMTguMA0K

