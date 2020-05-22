Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439211DE697
	for <lists+linux-scsi@lfdr.de>; Fri, 22 May 2020 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgEVMSY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 May 2020 08:18:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42410 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728544AbgEVMSX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 May 2020 08:18:23 -0400
X-UUID: e4e428a023904e49a502d2f6531881e9-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kQDziwgP0hgrh7T+hQAa+vHSi/RDRfa4EIfd/mEUOpk=;
        b=XLRi9by/dY/LSjDXfILlZsNEn2E7XYx1Rq+2gfTMocFjLUnlzj7TaJTjOvWoTywM18XGTzyf+P67saTUdDbEpbcSFWj3MKDHvKd/AfZp91uCXINrkeq3sxw/RS48nQfh+YfnkfhIOiMNb6DCY0ZDaErJeDLS3uPX6iloxFrRfAU=;
X-UUID: e4e428a023904e49a502d2f6531881e9-20200522
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1596963198; Fri, 22 May 2020 20:18:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 20:18:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 20:18:15 +0800
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
        <chaotian.jing@mediatek.com>, <pengshun.zhao@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 0/3] scsi: ufs-mediatek: Fix clk-gating and introduce low-power mode for vccq2
Date:   Fri, 22 May 2020 20:18:11 +0800
Message-ID: <20200522121814.9100-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGksDQpUaGlzIHBhdGNoc2V0IGZpeGVzIGEgY2xrLWdhdGluZyBpc3N1ZSBhbmQgaW50cm9kdWNl
cyBsb3ctcG93ZXIgbW9kZSBmb3IgdmNjcTIgaW4gTWVkaWFUZWsgcGxhdGZvcm1zLg0KDQpTdGFu
bGV5IENodSAoMyk6DQogIHNjc2k6IHVmcy1tZWRpYXRlazogRml4IGltcHJlY2lzZSB3YWl0aW5n
IHRpbWUgZm9yIHJlZi1jbGsgY29udHJvbA0KICBzY3NpOiB1ZnMtbWVkaWF0ZWs6IERvIG5vdCBn
YXRlIGNsb2NrcyBpZiBhdXRvLWhpYmVybjggaXMgbm90IGVudGVyZWQNCiAgICB5ZXQNCiAgc2Nz
aTogdWZzLW1lZGlhdGVrOiBJbnRyb2R1Y2UgbG93LXBvd2VyIG1vZGUgZm9yIGRldmljZSBwb3dl
ciBzdXBwbHkNCg0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMgfCA2NCArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmcy1tZWRpYXRl
ay5oIHwgIDIgKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0
aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

