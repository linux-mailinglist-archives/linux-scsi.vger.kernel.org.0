Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D899318431C
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2020 10:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCMJBy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Mar 2020 05:01:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbgCMJB3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Mar 2020 05:01:29 -0400
X-UUID: 2f32cc3fbe9b46b99979ff8082ebd0c3-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4SVFDx1dUwhWROvYtY0dTPYSsP2l15nHohTxw716oJc=;
        b=UXrVJB/8voa2dTynPZTjtOgPGoi9M6NqweXtcOFEzQlNzeH27V+0+UZy2cSFh0+w9Tk6HXhZ4jkpL+p0bSMVExq0g0UUnY6EF1po9aWNWZFl4JWBqNk1pqnU1tY4RN/Tdl07fxRZJjnGowxLf3iPUtgU5o1EWYc6WDtlUx7uTtg=;
X-UUID: 2f32cc3fbe9b46b99979ff8082ebd0c3-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 832525857; Fri, 13 Mar 2020 17:01:23 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 16:59:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:00:33 +0800
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
Subject: [PATCH v4 6/8] scsi: ufs: allow customized delay for host enabling
Date:   Fri, 13 Mar 2020 17:01:01 +0800
Message-ID: <20200313090103.15390-7-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200313090103.15390-1-stanley.chu@mediatek.com>
References: <20200313090103.15390-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Q3VycmVudGx5IGEgMSBtcyBkZWxheSBpcyBhcHBsaWVkIGJlZm9yZSBwb2xsaW5nIENPTlRST0xM
RVJfRU5BQkxFDQpiaXQuIFRoaXMgZGVsYXkgbWF5IG5vdCBiZSByZXF1aXJlZCBvciBjYW4gYmUg
Y2hhbmdlZCBpbiBkaWZmZXJlbnQNCmNvbnRyb2xsZXJzLiBNYWtlIHRoZSBkZWxheSBhcyBhIGNo
YW5nZWFibGUgdmFsdWUgaW4gc3RydWN0IHVmc19oYmEgdG8NCmFsbG93IGl0IGN1c3RvbWl6ZWQg
YnkgdmVuZG9ycy4NCg0KU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1l
ZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDYW4gR3VvIDxjYW5nQGNvZGVhdXJvcmEub3JnPg0K
LS0tDQogZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyB8IDMgKystDQogZHJpdmVycy9zY3NpL3Vm
cy91ZnNoY2QuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KaW5kZXggY2U2NWQzMjFhNzNmLi5kY2JmNDVkNTQ3ZDgg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQorKysgYi9kcml2ZXJzL3Nj
c2kvdWZzL3Vmc2hjZC5jDQpAQCAtNDI5OCw3ICs0Mjk4LDcgQEAgaW50IHVmc2hjZF9oYmFfZW5h
YmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQogCSAqIGluc3RydWN0aW9uIG1pZ2h0IGJlIHJlYWQg
YmFjay4NCiAJICogVGhpcyBkZWxheSBjYW4gYmUgY2hhbmdlZCBiYXNlZCBvbiB0aGUgY29udHJv
bGxlci4NCiAJICovDQotCXVmc2hjZF93YWl0X3VzKDEwMDAsIDEwMCwgdHJ1ZSk7DQorCXVmc2hj
ZF93YWl0X3VzKGhiYS0+aGJhX2VuYWJsZV9kZWxheV91cywgMTAwLCB0cnVlKTsNCiANCiAJLyog
d2FpdCBmb3IgdGhlIGhvc3QgY29udHJvbGxlciB0byBjb21wbGV0ZSBpbml0aWFsaXphdGlvbiAq
Lw0KIAlyZXRyeSA9IDEwOw0KQEAgLTg0MTgsNiArODQxOCw3IEBAIGludCB1ZnNoY2RfaW5pdChz
dHJ1Y3QgdWZzX2hiYSAqaGJhLCB2b2lkIF9faW9tZW0gKm1taW9fYmFzZSwgdW5zaWduZWQgaW50
IGlycSkNCiANCiAJaGJhLT5tbWlvX2Jhc2UgPSBtbWlvX2Jhc2U7DQogCWhiYS0+aXJxID0gaXJx
Ow0KKwloYmEtPmhiYV9lbmFibGVfZGVsYXlfdXMgPSAxMDAwOw0KIA0KIAllcnIgPSB1ZnNoY2Rf
aGJhX2luaXQoaGJhKTsNCiAJaWYgKGVycikNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZz
L3Vmc2hjZC5oIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaA0KaW5kZXggNDY4M2U3YmY2NjQw
Li4yNjlkZGI5MmJiNTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQor
KysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQpAQCAtNjUzLDYgKzY1Myw3IEBAIHN0cnVj
dCB1ZnNfaGJhIHsNCiAJdTMyIGVoX2ZsYWdzOw0KIAl1MzIgaW50cl9tYXNrOw0KIAl1MTYgZWVf
Y3RybF9tYXNrOw0KKwl1MTYgaGJhX2VuYWJsZV9kZWxheV91czsNCiAJYm9vbCBpc19wb3dlcmVk
Ow0KIA0KIAkvKiBXb3JrIFF1ZXVlcyAqLw0KLS0gDQoyLjE4LjANCg==

