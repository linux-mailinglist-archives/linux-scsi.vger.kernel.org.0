Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48422C7AE
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jul 2020 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXOQd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jul 2020 10:16:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63299 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbgGXOQd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Jul 2020 10:16:33 -0400
X-UUID: 8a42d10ae5014834a8de1a588a501137-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=m/J/gzq1uW0/CaTq7kELXH0oOhP3/tQJ+deO3cPbxHM=;
        b=K7IjJVFmWr38T985rei045Yd8P6KgKnzNFFd4qhT2xaC4QcnOf2GRsHh75tys0Uj63eTo+jXb7EyYcVa+nG3r1En5NKXLxzXXP+/m8hUHsyyTr9HVVg49cAZTEwk8uwlKap7P2XXIXp28s1jiuRwpekceATXIZNaIudtm94VBFo=;
X-UUID: 8a42d10ae5014834a8de1a588a501137-20200724
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 368038415; Fri, 24 Jul 2020 22:16:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jul 2020 22:16:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 22:16:26 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>, <bvanassche@acm.org>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1] scsi: ufs-mediatek: Prevent LPM operation on undeclared VCC
Date:   Fri, 24 Jul 2020 22:16:27 +0800
Message-ID: <20200724141627.20094-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SW4gc29tZSBwbGF0Zm9ybXMsIFZDQyByZWd1bGF0b3IgbWF5IG5vdCBiZSBkZWNsYXJlZCBpbiBk
ZXZpY2UgdHJlZQ0KdG8ga2VlcCBpdHNlbGYgImFsd2F5cy1vbiIuIEluIHRoaXMgY2FzZSwgaGJh
LT52cmVnX2luZm8udmNjIGlzIE5VTEwNCmFuZCBzaGFsbCBub3QgYmUgb3BlcmF0ZWQgZHVyaW5n
IGFueSBmbG93Lg0KDQpQcmV2ZW50IHBvc3NpYmxlIE5VTEwgaGJhLT52cmVnX2luZm8udmNjIGFj
Y2VzcyBpbiBMUE0gbW9kZSBieSBjaGVja2luZw0KaWYgaXQgaXMgdmFsaWQgZmlyc3QuDQoNClNp
Z25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRlay5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
Y3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMN
CmluZGV4IDMxYWY4YjNkMmI1My4uNjYyMjNmZTIwMGZjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9z
Y3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0
ZWsuYw0KQEAgLTU3NCw3ICs1NzQsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfbGlua19zZXRfbHBt
KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogDQogc3RhdGljIHZvaWQgdWZzX210a192cmVnX3NldF9s
cG0oc3RydWN0IHVmc19oYmEgKmhiYSwgYm9vbCBscG0pDQogew0KLQlpZiAoIWhiYS0+dnJlZ19p
bmZvLnZjY3EyKQ0KKwlpZiAoIWhiYS0+dnJlZ19pbmZvLnZjY3EyIHx8ICFoYmEtPnZyZWdfaW5m
by52Y2MpDQogCQlyZXR1cm47DQogDQogCWlmIChscG0gJiAhaGJhLT52cmVnX2luZm8udmNjLT5l
bmFibGVkKQ0KLS0gDQoyLjE4LjANCg==

