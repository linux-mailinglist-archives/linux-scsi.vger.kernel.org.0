Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124D126575C
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKDZA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Sep 2020 23:25:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20619 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgIKDY5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Sep 2020 23:24:57 -0400
X-UUID: 94fcfb6834f64d0daa1bd93403a53b0c-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/mYD66patFgq7ha/cJhn7mSkoKmWOdFvvY0fkbfVMfM=;
        b=ryKp8yaFvl3g0EnQNymGWOzRP7zdDlQ1XVkWKje4KUwRobdMf+nzz/3yejOjVQH6H16hel00rcgh+oPAFTwDf64eWf4AnetY5EiXwueZs70fotkuzVkyeZ0eFsKFv9wUP8gO5NKUrAGUrGO2Ro+ot/NK0z+MkfsrOlHVRawgDwA=;
X-UUID: 94fcfb6834f64d0daa1bd93403a53b0c-20200911
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 429657948; Fri, 11 Sep 2020 11:24:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Sep 2020 11:24:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 11:24:50 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <robh@kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <matthias.bgg@gmail.com>, <bvanassche@acm.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, <arvin.wang@mediatek.com>,
        <HenryC.Chen@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: ufs-mediatek: Add mt8192-ufshci compatible string
Date:   Fri, 11 Sep 2020 11:24:49 +0800
Message-ID: <20200911032449.21577-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200911032449.21577-1-stanley.chu@mediatek.com>
References: <20200911032449.21577-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QWRkICJtZWRpYXRlayxtdDgxOTItdWZzaGNpIiBjb21wYXRpYmxlIHN0cmluZyB0byBmb3IgTWVk
aWFUZWsNClVGUyBob3N0IGNvbnRyb2xsZXIgcHJlc2VudCBvbiBNVDgxOTIgY2hpcHNldHMuDQoN
ClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQot
LS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZzL3Vmcy1tZWRpYXRlay50
eHQgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZz
L3Vmcy1tZWRpYXRlay50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZz
L3Vmcy1tZWRpYXRlay50eHQNCmluZGV4IDcyYWFiODU0NzMwOC4uNjNhOTUzYjY3MmQyIDEwMDY0
NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vmcy91ZnMtbWVkaWF0
ZWsudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZzL3Vmcy1t
ZWRpYXRlay50eHQNCkBAIC05LDcgKzksOSBAQCBjb250YWluIGEgcGhhbmRsZSByZWZlcmVuY2Ug
dG8gVUZTIE0tUEhZIG5vZGUuDQogUmVxdWlyZWQgcHJvcGVydGllcyBmb3IgVUZTIG5vZGVzOg0K
IC0gY29tcGF0aWJsZSAgICAgICAgIDogQ29tcGF0aWJsZSBsaXN0LCBjb250YWlucyB0aGUgZm9s
bG93aW5nIGNvbnRyb2xsZXI6DQogICAgICAgICAgICAgICAgICAgICAgICAibWVkaWF0ZWssbXQ4
MTgzLXVmc2hjaSIgZm9yIE1lZGlhVGVrIFVGUyBob3N0IGNvbnRyb2xsZXINCi0gICAgICAgICAg
ICAgICAgICAgICAgIHByZXNlbnQgb24gTVQ4MXh4IGNoaXBzZXRzLg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgcHJlc2VudCBvbiBNVDgxODMgY2hpcHNldHMuDQorICAgICAgICAgICAgICAgICAg
ICAgICAibWVkaWF0ZWssbXQ4MTkyLXVmc2hjaSIgZm9yIE1lZGlhVGVrIFVGUyBob3N0IGNvbnRy
b2xsZXINCisgICAgICAgICAgICAgICAgICAgICAgIHByZXNlbnQgb24gTVQ4MTkyIGNoaXBzZXRz
Lg0KIC0gcmVnICAgICAgICAgICAgICAgIDogQWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBVRlMg
cmVnaXN0ZXIgc2V0Lg0KIC0gcGh5cyAgICAgICAgICAgICAgIDogcGhhbmRsZSB0byBtLXBoeS4N
CiAtIGNsb2NrcyAgICAgICAgICAgICA6IExpc3Qgb2YgcGhhbmRsZSBhbmQgY2xvY2sgc3BlY2lm
aWVyIHBhaXJzLg0KLS0gDQoyLjE4LjANCg==

