Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866E312A69A
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Dec 2019 08:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLYHeq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Dec 2019 02:34:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbfLYHeq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 Dec 2019 02:34:46 -0500
X-UUID: 8d3877e443564ef2ae5e9b89816a4440-20191225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3JsaGytja2s0ajkjRHpfBvJl0ga0ZN42HUPzYb0ma90=;
        b=Dahpx+iXR6uSnpu2HYXj97DWwwx9v7/79Ffy3GIyu6+DU1CjnOgFdFTekvJ91oKSel3E1Dsw8/L9OOP/4A9FbRXeNa4sWeAYtED7hOnNsOat2G05IbtFyR+aJwrRczG6V549PSS3CGjS4OBGD7tSlglUSyTh+3Jc0d+9NVVP0o4=;
X-UUID: 8d3877e443564ef2ae5e9b89816a4440-20191225
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1769822510; Wed, 25 Dec 2019 15:34:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Dec 2019 15:33:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Dec 2019 15:34:13 +0800
Message-ID: <1577259276.13056.54.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2 RESEND] soc: mediatek: add header for SiP service
 interface
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Alim Akhtar <alim.akhtar@gmail.com>
CC:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Leon Chen =?UTF-8?Q?=28=E9=99=B3=E6=96=87=E9=8F=98=29?= 
        <Leon.Chen@mediatek.com>,
        "Andy Teng ( =?ISO-8859-1?Q?=1B$B{}G!9(=1B(B?=)" 
        <Andy.Teng@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Chun-Hung Wu =?UTF-8?Q?=28=E5=B7=AB=E9=A7=BF=E5=AE=8F=29?= 
        <Chun-hung.Wu@mediatek.com>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Avri Altman" <avri.altman@wdc.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Peter Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=8F=8B=29?= 
        <peter.wang@mediatek.com>, Alim Akhtar <alim.akhtar@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Date:   Wed, 25 Dec 2019 15:34:36 +0800
In-Reply-To: <1576804540.13056.22.camel@mtkswgap22>
References: <1576468137-17220-1-git-send-email-stanley.chu@mediatek.com>
         <1576468137-17220-2-git-send-email-stanley.chu@mediatek.com>
         <CAGOxZ50RKYAEw=HwYMH=Jm7cagUV12C-fwhauJhJqx6HscAmFA@mail.gmail.com>
         <1576804540.13056.22.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2EF099EE7E0791DEE4F5F3D3D0CACF2D26DB662205C351BEF72A3A062DA5475D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQWxpbSwNCg0KV291bGQgeW91IHRoaW5rIGJlbG93IGV4cGxhbmF0aW9uIGlzIE9LIHRvIHlv
dT8NCg0KQlRXLCBGWUksIHRoaXMgc2VyaWVzIHdhcyBjb21iaW5lZCB0byB0aGUgbmV3IHNlcmll
cyAic2NzaTogdWZzOiBhZGQNCk1lZGlhVGVrIHZlbmRvciBpbXBsZW1lbnRhdGlvbnMiIHdpdGgg
dGhpcyBzYW1lIHBhdGNoIGluIGl0Lg0KDQpUaGFua3MsDQpTdGFubGV5DQoNCg0KT24gRnJpLCAy
MDE5LTEyLTIwIGF0IDA5OjE1ICswODAwLCBTdGFubGV5IENodSB3cm90ZToNCj4gSGkgQWxpbSwN
Cj4gDQo+IE9uIEZyaSwgMjAxOS0xMi0yMCBhdCAwMjowMCArMDgwMCwgQWxpbSBBa2h0YXIgd3Jv
dGU6DQo+ID4gPiArLyogVUZTIHJlbGF0ZWQgU01DIGNhbGwgKi8NCj4gPiA+ICsjZGVmaW5lIE1U
S19TSVBfVUZTX0NPTlRST0wgXA0KPiA+ID4gKyAgICAgICBNVEtfU0lQX1NNQ19DTUQoMHgyNzYp
DQo+ID4gPiArDQo+ID4gSG93IGFib3V0IG1vdmluZyBVRlMgc3BlY2lmaWMgc3R1ZmYgdG8gTVRL
IFVGUyBkcml2ZXIgYW5kIGluY2x1ZGUgdGhpcw0KPiA+IGhlYWRlciBpbiBkcml2ZXIgZmlsZT8N
Cj4gPiBSZXN0IGxvb2tzIGZpbmUuDQo+IA0KPiBUaGFua3Mgc28gbXVjaCBmb3IgeW91ciByZXZp
ZXcuDQo+IA0KPiBPdXIgaW50ZW50aW9uIGlzIHRvIGNvbGxlY3QgYWxsIFNNQyBjYWxsIGNvbW1h
bmQgdHlwZXMgaW4gTWVkaWFUZWsNCj4gQ2hpcHNldHMgaGVyZSBmb3IgZWFzaWVyIG1hbmFnZW1l
bnQuDQo+IA0KPiBUaGlzIGlzIHRoZSBmaXJzdCB0aW1lIHdlIHNob3cgdGhpcyBoZWFkZXIgdGh1
cyBvbmx5IFVGUyByZWxhdGVkIHN0dWZmDQo+IGlzIHByZXNlbnQgaGVyZS4NCj4gDQo+ID4gPiAr
I2VuZGlmDQo+ID4gPiAtLQ0KPiA+ID4gMi4xOC4wDQo+ID4gDQo+ID4gDQo+IA0KPiBUaGFua3Ms
DQo+IFN0YW5sZXkNCj4gDQoNCg0K

