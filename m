Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03C123E25
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Dec 2019 04:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRDw7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Dec 2019 22:52:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbfLRDw7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Dec 2019 22:52:59 -0500
X-UUID: 505a971fa5ad43c092ee4ae90a93eb10-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JgEIyQg1MGN6RIP2uMOeIekA1H6Nku9DNihrJErp254=;
        b=DDowWujpl4LXOfs+8FR768+1sjfc2gOhPQSOyaGFp2Uexv1aALgK/rcNe/G576vU+A6DxqkEbw4qQKdeST7OASumbNuWG3DyXAQNnJ1rr4gW6NjXvomZbLaD9hDcyPZuiWIT45hJPspX5wYa7VvMJF4ASx4HiF4gHeV0n1s9Lxk=;
X-UUID: 505a971fa5ad43c092ee4ae90a93eb10-20191218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 197169922; Wed, 18 Dec 2019 11:52:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 11:52:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 11:52:23 +0800
Message-ID: <1576641171.13056.16.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/2] scsi: ufs: disable interrupt during clock-gating
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>
CC:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <beanhuo@micron.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>
Date:   Wed, 18 Dec 2019 11:52:51 +0800
In-Reply-To: <a36d111e-ef7f-9f9b-6f6a-692a9980103a@codeaurora.org>
References: <1575721321-8071-1-git-send-email-stanley.chu@mediatek.com>
         <1575721321-8071-3-git-send-email-stanley.chu@mediatek.com>
         <a36d111e-ef7f-9f9b-6f6a-692a9980103a@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQXN1dG9zaCwNCg0KT24gVHVlLCAyMDE5LTEyLTE3IGF0IDE1OjI1IC0wODAwLCBBc3V0b3No
IERhcyAoYXNkKSB3cm90ZToNCj4gPiANCj4gDQo+IEhpLA0KPiBEb2VzIHRoaXMgc2F2ZSBzaWdu
aWZpY2FudCBwb3dlcj8gSSBzZWUgdGhhdCBnYXRlL3VuZ2F0ZSBvZiBjbG9ja3MgDQo+IGhhcHBl
biBmYXIgdG9vIGZyZXF1ZW50bHkgdGhhbiBzdXNwZW5kL3Jlc3VtZS4NCj4gDQo+IEhhdmUgeW91
IGNvbnNpZGVyZWQgaG93IG11Y2ggbGF0ZW5jeSB0aGlzIHdvdWxkIGFkZCB0byB0aGUgDQo+IGdh
dGluZy91bmdhdGluZyBwYXRoPw0KPiANCj4gLWFzZA0KPiANCg0KWWVzLCB3ZSBoYXZlIG1lYXN1
cmVkIDIwMCB0aW1lcyBjbGstZ2F0aW5nL2Nsay11bmdhdGluZyBhbmQgbGF0ZW5jeSBkYXRhDQpp
cyBzaG93ZWQgYXMgYmVsb3csDQoNCkZvciBjbGstZ2F0aW5nIHdpdGggaW50ZXJydXB0IGRpc2Fi
bGluZyB0b2dnbGVkLA0KDQoJQXZlcmFnZSBsYXRlbmN5IG9mIGVhY2ggY2xrLWdhdGluZzogNTUu
MTE3IHVzDQoJQXZlcmFnZSBsYXRlbmN5IG9mIGlycS1kaXNhYmxpbmcgZHVyaW5nIGNsay1nYXRp
bmc6IDQuMiB1cw0KDQpGb3IgY2xrLXVuZ2F0aW5nIHdpdGggaW50ZXJydXB0IGVuYWJsaW5nIHRv
Z2dsZWQsDQoJQXZlcmFnZSBsYXRlbmN5IG9mIGVhY2ggY2xrLXVuZ2F0aW5nOiAxMTguMzI0IHVz
DQoJQXZlcmFnZSBsYXRlbmN5IG9mIGlycS1lbmFibGluZyBkdXJpbmcgY2xrLXVuZ2F0aW5nOiAy
LjkgdXMNCg0KVGhlIGV2YWx1YXRpb24gaGVyZSBpcyBiYXNlZCBvbiBiZWxvdyBDYW4ncyBwYXRj
aCB0aGVyZWZvcmUgdGhlDQppbnRlcnJ1cHQgY29udHJvbCAoZW5hYmxlX2lycS9kaXNhYmxlX2ly
cSkgbGF0ZW5jeSBpcyBtdWNoIHNob3J0ZXIgdGhhbg0KYmVmb3JlIChyZXF1ZXN0X2lycS9mcmVl
X2lycSkuDQoNCnNjc2k6IHVmczogRG8gbm90IGZyZWUgaXJxIGluIHN1c3BlbmQNCmh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5n
aXQvY29tbWl0L2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmM/aWQ9ODcwOWMxZjY4NTM2ZTI1NjY2
ODgxMjc4OGFmNWIyYmIwMjdmNDljMw0KDQpCVFcsIHRoZSBtYWluIHB1cnBvc2Ugb2YgdGhpcyBw
YXRjaCBpcyBhaW1lZCB0byBwcm90ZWN0IHVmc2hjZCByZWdpc3Rlcg0KZnJvbSBhY2Nlc3Npbmcg
d2hpbGUgaG9zdCBjbG9ja3MgYXJlIGRpc2FibGVkIHRvIGZpeCBwb3RlbnRpYWwgc3lzdGVtDQpo
YW5nIGlzc3VlLiBUaGUgcG9zc2libGUgc2NlbmFyaW8gaXMgbWVudGlvbmVkIGluIGNvbW1pdCBt
ZXNzYWdlIG9mDQpwYXRjaCAic2NzaTogdWZzOiBkaXNhYmxlIGlycSBiZWZvcmUgZGlzYWJsaW5n
IGNsb2NrcyIgaW4gdGhlIHNhbWUNCnNlcmllcy4NCg0KVGhhbmtzDQpTdGFubGV5DQo=

