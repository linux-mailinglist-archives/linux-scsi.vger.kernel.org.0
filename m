Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B82DB9FA
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Dec 2020 05:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgLPERz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Dec 2020 23:17:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725803AbgLPERy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Dec 2020 23:17:54 -0500
X-UUID: f5fd692a73dc45bcae18e8c078b7ad5e-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Fs6NuFbA0ABmMlsscv7TTwPc4OosIz1A89iNe9TGw+k=;
        b=UUv/NLN88MowRA6g9wgAfBnA93BQ3S1tBFeCqcIdA783OyZbgv0YBGx8o5wsOz2m8eienta5mgfN5D1idSQT78Wdeuf2yqBssQeLgElGYAR/KJ8MnofdfIO2bcAwND2Eg0qXEHg4GACdJEKYyKgmY22qePhXu4tahRoAtC3BsHo=;
X-UUID: f5fd692a73dc45bcae18e8c078b7ad5e-20201216
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 453768579; Wed, 16 Dec 2020 12:17:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 12:17:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 12:17:09 +0800
Message-ID: <1608092230.10163.31.camel@mtkswgap22>
Subject: Re: [PATCH v5 6/7] scsi: ufs: Cleanup WB buffer flush toggle
 implementation
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <tomas.winkler@intel.com>,
        <cang@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Dec 2020 12:17:10 +0800
In-Reply-To: <20201215230519.15158-7-huobean@gmail.com>
References: <20201215230519.15158-1-huobean@gmail.com>
         <20201215230519.15158-7-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTE2IGF0IDAwOjA1ICswMTAwLCBCZWFuIEh1byB3cm90ZToNCj4gRnJv
bTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IERlbGV0ZSB1ZnNoY2Rfd2Jf
YnVmX2ZsdXNoX2VuYWJsZSgpIGFuZCB1ZnNoY2Rfd2JfYnVmX2ZsdXNoX2Rpc2FibGUoKSwNCj4g
bW92ZSB0aGUgaW1wbGVtZW50YXRpb24gaW50byB1ZnNoY2Rfd2JfdG9nZ2xlX2ZsdXNoKCkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiAtLS0N
Cg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+DQoN
Cg==

