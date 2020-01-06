Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E71130AD9
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jan 2020 01:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAFA0q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Jan 2020 19:26:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgAFA0p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Jan 2020 19:26:45 -0500
X-UUID: 67be401cfb42401aabb7c7a98905db96-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RtocooZxOutpJvHIz7Z7EHFeutv+3ZeQQ4M/OYfYdXE=;
        b=auZRD/w/39O2uVOF7o2uui3Cse7Pz9s++GKusvTX7OdB+3tkVLYaYKghD8bzeR0dCf3mmRRADiMJzlUXfsrf/mnCah7a8pNwpEMMC6L8WxwNnTE8qPlgkyIiKT+TMVbhfaqjgljoRmIdBFjyta9opQGL1D3i5XaoN3WVXY/IPh8=;
X-UUID: 67be401cfb42401aabb7c7a98905db96-20200106
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 437596842; Mon, 06 Jan 2020 08:26:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 6 Jan 2020 08:25:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 08:25:07 +0800
Message-ID: <1578270395.17435.4.camel@mtkswgap22>
Subject: RE: [PATCH v1 0/3] scsi: ufs: pass device information to
 apply_dev_quirks
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Date:   Mon, 6 Jan 2020 08:26:35 +0800
In-Reply-To: <MN2PR04MB699151E6AEC7D15CBE1224A2FC3D0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <1578200118-29547-1-git-send-email-stanley.chu@mediatek.com>
         <MN2PR04MB69913F0B671032A388747CF7FC3D0@MN2PR04MB6991.namprd04.prod.outlook.com>
         <1578229802.17435.3.camel@mtkswgap22>
         <MN2PR04MB699151E6AEC7D15CBE1224A2FC3D0@MN2PR04MB6991.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQXZyaSwNCg0KT24gU3VuLCAyMDIwLTAxLTA1IGF0IDE2OjQwICswMDAwLCBBdnJpIEFsdG1h
biB3cm90ZToNCj4gPiBIaSBBdnJpLA0KPiA+IA0KPiA+IE9uIFN1biwgMjAyMC0wMS0wNSBhdCAw
NTo1MSArMDAwMCwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gPiBZb3UgaGF2ZSB0byBzcXVhc2gg
cGF0Y2ggMSAmIDIsIG90aGVyd2lzZSB5b3VyIHBhdGNoIDEgd29uJ3QgY29tcGlsZS4NCj4gPiA+
IE90aGVyIHRoYW4gdGhhdDogbG9va3MgZ29vZCB0byBtZS4NCj4gPiA+IFRoYW5rcywNCj4gPiA+
IEF2cmkNCj4gPiANCj4gPiBTb3JyeSBiZWNhdXNlIEkgc2VudCAyIHNlcmllcyBpbiB0aGVzZSB0
d28gZGF5cy4NCj4gPiANCj4gPiBXb3VsZCB5b3UgbWVhbiBwYXRjaCAxIGlzIHNlcmllczogInNj
c2k6IHVmczogZml4IGVycm9yIGhpc3RvcnkgYW5kIGNvbXBsZXRlDQo+ID4gZGV2aWNlIHJlc2V0
IGhpc3RvcnkiIGFuZCBwYXRjaCAyIGlzIHNlcmllcyAic2NzaTogdWZzOiBwYXNzIGRldmljZSBp
bmZvcm1hdGlvbiB0bw0KPiA+IGFwcGx5X2Rldl9xdWlya3MiPw0KPiA+IA0KPiA+IE9yIHBhdGNo
IDEgJiAyIG1lYW4gdGhlIGZpcnN0IDIgY29tbWl0cyBpbiB0aGlzIHNlcmllczogInNjc2k6IHVm
czogcGFzcyBkZXZpY2UNCj4gPiBpbmZvcm1hdGlvbiB0byBhcHBseV9kZXZfcXVpcmtzIj8NCj4g
VGhpcyBvbmUuDQoNCk9LISBJIHdpbGwgc2VuZCB0aGUgdXBkYXRlZCB2Mi4NCg0KPiANCj4gPiAN
Cj4gPiBUaGFua3MgYSBsb3QuDQo+ID4gU3RhbmxleQ0KDQpUaGFua3MsDQpTdGFubGV5DQo=

