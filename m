Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E173D1863D5
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 04:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgCPDm2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Mar 2020 23:42:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32774 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729423AbgCPDm2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 15 Mar 2020 23:42:28 -0400
X-UUID: e234ed76ab774b75b5c27f8f9640545d-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7YpwD2GG32xhcNkZears5WlJqU2pNhGBUQ+n78Lc3nw=;
        b=nlpuXPN7dly/LYxojhCWJlS1DimwRsV5FAG/PhtwdOavf87hSYy7cN3W4VMszo3vwhRTwfc7RkYEK3+ICnrCJ2odF07m5Kx1KZPtBR8TqDszDd+r3Um7fR0HB40T6EslvmuenenMbng2g38jDdzKNh8jt2UWAYHY6HGfTP4CQ1s=;
X-UUID: e234ed76ab774b75b5c27f8f9640545d-20200316
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 347351772; Mon, 16 Mar 2020 11:42:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 11:40:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 11:39:23 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.peter~sen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v5 7/8] scsi: ufs: make HCE polling more compact to improve initialization latency
Date:   Mon, 16 Mar 2020 11:42:17 +0800
Message-ID: <20200316034218.11914-8-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200316034218.11914-1-stanley.chu@mediatek.com>
References: <20200316034218.11914-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

UmVkdWNlIHRoZSB3YWl0aW5nIHBlcmlvZCBiZXR3ZWVuIGVhY2ggSENFIChIb3N0IENvbnRyb2xs
ZXIgRW5hYmxlKQ0KcG9sbGluZyBmcm9tIDUgbXMgdG8gMSBtcy4gSW4gdGhlIHNhbWUgdGltZSwg
aW5jcmVhc2UgdGhlIG1heGltdW0gcG9sbGluZw0KdGltZXMgdG8gbWFrZSAidG90YWwgcG9sbGlu
ZyB0aW1lIiB1bmNoYW5nZWQgYXBwcm94aW1hdGVseS4NCg0KVGhpcyBjaGFuZ2UgY291bGQgbWFr
ZSBIQ0UgaW5pdGlhbGl6YXRvaW4gZmFzdGVyIHRvIGltcHJvdmUgbGF0ZW5jeSBvZg0KdWZzaGNk
IGluaXRpYWxpemF0aW9uLCBlcnJvciByZWNvdmVyeSwgYW5kIHJlc3VtZSBiZWhhdmlvcnMuDQoN
ClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQpS
ZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQotLS0NCiBkcml2
ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMv
dWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQppbmRleCBkY2JmNDVkNTQ3ZDgu
LmNkMzNkMDdjNTZjZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCisr
KyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCkBAIC00MzAxLDcgKzQzMDEsNyBAQCBpbnQg
dWZzaGNkX2hiYV9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhiYSkNCiAJdWZzaGNkX3dhaXRfdXMo
aGJhLT5oYmFfZW5hYmxlX2RlbGF5X3VzLCAxMDAsIHRydWUpOw0KIA0KIAkvKiB3YWl0IGZvciB0
aGUgaG9zdCBjb250cm9sbGVyIHRvIGNvbXBsZXRlIGluaXRpYWxpemF0aW9uICovDQotCXJldHJ5
ID0gMTA7DQorCXJldHJ5ID0gNTA7DQogCXdoaWxlICh1ZnNoY2RfaXNfaGJhX2FjdGl2ZShoYmEp
KSB7DQogCQlpZiAocmV0cnkpIHsNCiAJCQlyZXRyeS0tOw0KQEAgLTQzMTAsNyArNDMxMCw3IEBA
IGludCB1ZnNoY2RfaGJhX2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KIAkJCQkiQ29udHJv
bGxlciBlbmFibGUgZmFpbGVkXG4iKTsNCiAJCQlyZXR1cm4gLUVJTzsNCiAJCX0NCi0JCXVmc2hj
ZF93YWl0X3VzKDUwMDAsIDEwMCwgdHJ1ZSk7DQorCQl1ZnNoY2Rfd2FpdF91cygxMDAwLCAxMDAs
IHRydWUpOw0KIAl9DQogDQogCS8qIGVuYWJsZSBVSUMgcmVsYXRlZCBpbnRlcnJ1cHRzICovDQot
LSANCjIuMTguMA0K

