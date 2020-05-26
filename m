Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7B1D3434
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2020 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgENPBh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 May 2020 11:01:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43227 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728288AbgENPBe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 May 2020 11:01:34 -0400
X-UUID: e03dea2219f34703833f044f72d32f22-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SfDQhGdBasCQf6xPUtgVXlprnq+Pu6y0OxSgqJwkc34=;
        b=I8zuKm1WOipjNk5rAHraTkv0ffYS6qzg35jEfEelkXc4+esp7cZhsLPJ5uuI9nSJuLRSj2EMaLggOehvZSpcxavcOOPDlGkwXo2saH3gQg4KvrmhoN9fTPPWgtkw3NxIhnBFaMDQRd2JiGS0bpXX0ZTu0BAP1sEbh8q4L1/RjIs=;
X-UUID: e03dea2219f34703833f044f72d32f22-20200514
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1302942915; Thu, 14 May 2020 23:01:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 May 2020 23:01:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 23:01:20 +0800
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
Subject: [PATCH v2 1/4] scsi: ufs: Remove unnecessary memset for dev_info
Date:   Thu, 14 May 2020 23:01:19 +0800
Message-ID: <20200514150122.32110-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200514150122.32110-1-stanley.chu@mediatek.com>
References: <20200514150122.32110-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

VGhlIHdob2xlIFVGUyBob3N0IGluc3RhbmNlIGhhcyBiZWVuIHplcm8taW5pdGlhbGl6ZWQgYnkN
CnNjc2lfaG9zdF9hbGxvYygpLCB0aHVzIFVGUyBkcml2ZXIgZG9lcyBub3QgbmVlZCB0byBjbGVh
cg0KImRldl9pbmZvIiBtZW1iZXIgc3BlY2lmaWNhbGx5IGluIHVmc2hjZF9kZXZpY2VfcGFyYW1z
X2luaXQoKS4NCg0KU2ltcGx5IHJlbW92ZSB0aGUgdW5uZWNlc3NhcnkgY29kZS4NCg0KU2lnbmVk
LW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAzIC0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyBiL2RyaXZl
cnMvc2NzaS91ZnMvdWZzaGNkLmMNCmluZGV4IDQyNjA3M2E1MThlZi4uNDFhZDQ1MDFiMGQwIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KKysrIGIvZHJpdmVycy9zY3Np
L3Vmcy91ZnNoY2QuYw0KQEAgLTcyNzksOSArNzI3OSw2IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2Rl
dmljZV9wYXJhbXNfaW5pdChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAlib29sIGZsYWc7DQogCWlu
dCByZXQ7DQogDQotCS8qIENsZWFyIGFueSBwcmV2aW91cyBVRlMgZGV2aWNlIGluZm9ybWF0aW9u
ICovDQotCW1lbXNldCgmaGJhLT5kZXZfaW5mbywgMCwgc2l6ZW9mKGhiYS0+ZGV2X2luZm8pKTsN
Ci0NCiAJLyogSW5pdCBjaGVjayBmb3IgZGV2aWNlIGRlc2NyaXB0b3Igc2l6ZXMgKi8NCiAJdWZz
aGNkX2luaXRfZGVzY19zaXplcyhoYmEpOw0KIA0KLS0gDQoyLjE4LjANCg==

