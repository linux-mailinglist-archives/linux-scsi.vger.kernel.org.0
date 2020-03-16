Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6524818656B
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 08:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgCPHIT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 03:08:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45759 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgCPHIT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Mar 2020 03:08:19 -0400
X-UUID: 8a90e77ca46c45f0900eeb67382c4134-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dau95JaNBGsRunTGBlpYGDM3JLIWHp3+4y4tNiux/2U=;
        b=BpGDmAXQShE3p/Mx8LKdOiQqUicz4QnmplojYZIxOeNrkR811wDSTmULr7hR3BaU6XsbhvpfEfDFXbgQgRBSivkElfFnZPEq1JfZMcyuSZCfrq8YplhJslOemcJOGinVkbCxZmWGi9OHWMXY7oaeda19he2Lv1JE/i9ViCW+mLU=;
X-UUID: 8a90e77ca46c45f0900eeb67382c4134-20200316
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1014602838; Mon, 16 Mar 2020 15:08:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 15:05:15 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 15:07:28 +0800
Message-ID: <1584342487.14250.11.camel@mtksdccf07>
Subject: Re: [PATCH v5 2/8] scsi: ufs: remove init_prefetch_data in struct
 ufs_hba
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <andy.teng@mediatek.com>, <jejb@linux.ibm.com>,
        <chun-hung.wu@mediatek.com>, <kuohong.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <avri.altman@wdc.com>,
        <martin.peter~sen@oracle.com>,
        <linux-mediatek@lists.infradead.org>, <peter.wang@mediatek.com>,
        <alim.akhtar@samsung.com>, <matthias.bgg@gmail.com>,
        <asutoshd@codeaurora.org>, <linux-arm-kernel@lists.infradead.org>,
        <beanhuo@micron.com>
Date:   Mon, 16 Mar 2020 15:08:07 +0800
In-Reply-To: <51fde835f4f03fcca6e83ba6d3579f2e@codeaurora.org>
References: <20200316034218.11914-1-stanley.chu@mediatek.com>
         <20200316034218.11914-3-stanley.chu@mediatek.com>
         <51fde835f4f03fcca6e83ba6d3579f2e@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 91130EEECD614F04B26B8D968427210292287D7953CE94BE6ED417119E909D972000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQ2FuLA0KDQpPbiBNb24sIDIwMjAtMDMtMTYgYXQgMTQ6MjUgKzA4MDAsIENhbiBHdW8gd3Jv
dGU6DQo+IE9uIDIwMjAtMDMtMTYgMTE6NDIsIFN0YW5sZXkgQ2h1IHdyb3RlOg0KPiA+IFN0cnVj
dCBpbml0X3ByZWZldGNoX2RhdGEgY3VycmVudGx5IGlzIHVzZWQgcHJpdmF0ZWx5IGluDQo+ID4g
dWZzaGNkX2luaXRfaWNjX2xldmVscygpLCB0aHVzIGl0IGNhbiBiZSByZW1vdmVkIGZyb20gc3Ry
dWN0IHVmc19oYmEuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5s
ZXkuY2h1QG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQXN1dG9zaCBEYXMgPGFzdXRv
c2hkQGNvZGVhdXJvcmEub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5h
bHRtYW5Ad2RjLmNvbT4NCj4gDQo+IEhpIFN0YW5sZXksDQo+IA0KPiBFYXJsaWVyLCBJIGhhdmUg
b25lIHNpbWlsYXIgcGF0Y2ggZm9yIHRoaXMsIGJ1dCBpdCBkb2VzIG1vcmUgdGhhbiB0aGlzLg0K
PiBQbGVhc2UgY2hlY2sgdGhlIG1haWwgSSBqdXN0IHNlbnQuDQo+IA0KPiBUaGFua3MsDQo+IENh
biBHdW8uDQoNCk9LISBUaGFua3MgdG8gcmVtaW5kIG1lIHRoaXMuIFRoZW4gSSBjYW4gZHJvcCB0
aGlzIGNsZWFudXAgcGF0Y2ggIzIgaW4NCml0cyBzZXJpZXMgdG8gbm90IGNvbmZsaWN0IHdpdGgg
eW91ciBwcm9wb3NlZCBvbmUuDQoNClRoYW5rcywNClN0YW5sZXkgQ2h1DQoNCg0K

