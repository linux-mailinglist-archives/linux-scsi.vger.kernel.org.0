Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640751BDD1A
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD2NFM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 09:05:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43386 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgD2NFM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Apr 2020 09:05:12 -0400
X-UUID: c3ed02801496480b8d9f3bd909e1b478-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PNI0WDJmz/9JD0UtP8DMHGZ8r8zpffAaucvWKOp0H/M=;
        b=VlACrPdzGlk4pWpXWSA3twIItfS+zLbZwllyohmvhu3rW8OE30iE05HMdM3lWsxkQdQP0exRENm27vJNNV+XP+EIzmPheshVam/XdhXlKgw5hWGAyBGvf7WPzzLhr2agwghH6iOxMXpkQ3j6t6BUBicxZx/bAYQyf66SG86x9HA=;
X-UUID: c3ed02801496480b8d9f3bd909e1b478-20200429
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 69938006; Wed, 29 Apr 2020 21:05:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 21:05:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 21:05:03 +0800
Message-ID: <1588165506.3197.0.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/4] scsi: ufs: add LU Dedicated buffer type support
 for WriteBooster
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
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
Date:   Wed, 29 Apr 2020 21:05:06 +0800
In-Reply-To: <BN7PR08MB5684630793F03282E4C6F3D7DBAD0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <20200428111355.1776-1-stanley.chu@mediatek.com>
         <20200428111355.1776-4-stanley.chu@mediatek.com>
         <BN7PR08MB5684630793F03282E4C6F3D7DBAD0@BN7PR08MB5684.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 93D7F8DB1FC187A36CBACEF22410B86BFB7E58962EFD80A220FFCC8E333837BA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQmVhbiwNCg0KT24gV2VkLCAyMDIwLTA0LTI5IGF0IDEwOjM5ICswMDAwLCBCZWFuIEh1byAo
YmVhbmh1bykgd3JvdGU6DQo+ID4gDQo+ID4gKy8qIFdyaXRlQm9vc3RlciBidWZmZXIgdHlwZSAq
Lw0KPiA+ICtlbnVtIHsNCj4gPiArCVdCX1RZUEVfTFVfREVESUNBVEVECT0gMHgwLA0KPiA+ICsJ
V0JfVFlQRV9TSU5HTEVfU0hBUkVECT0gMHgxDQo+ID4gK307DQo+IA0KPiANCj4gSGksICBTdGFu
bHkNCj4gV0JfVFlQRV9TSU5HTEVfU0hBUkVEIG1pZ2h0IGJlIFdCX1RZUEVfU0hBUkVEX0JVRkZF
Ui4gIEkgdGhpbmssDQo+IHdlIHNob3VsZCB0cnkgdG8gbWFrZSB0aGUgbmFtZSBkZWZpbml0aW9u
IGNvcnJlc3BvbmQgdG8gU3BlYw0KDQpNYWtlIHNlbnNlLiBJIHdpbGwgZml4IHRoaXMgaW4gbmV4
dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpTdGFubGV5IENodQ0KDQo=

