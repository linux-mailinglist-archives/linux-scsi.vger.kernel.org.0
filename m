Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CD2C4C66
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKZBIK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Nov 2020 20:08:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37880 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729760AbgKZBIK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 Nov 2020 20:08:10 -0500
X-UUID: da15571322c9404397139d1107ba2857-20201126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nuSlFfD2Jjo2YzrPyfDkI8wl2PPyiDyhZDKh8O5xqqc=;
        b=M2FGcjetToVTX8xMf3eN0Yq7d7Pz3OdtIk7YF3uIXRwm4TQjZE7tEsixh5xL8VBlI/sm5tb2si3rc4BqJCp66COWLUKymrxISLnUZaM0kzleM+T7l2SiRc87xUbte3StYnspvunuySfT5/zdhskEFSfeRnRZ76CQDEPBeAweQaU=;
X-UUID: da15571322c9404397139d1107ba2857-20201126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 63321513; Thu, 26 Nov 2020 09:08:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Nov 2020 09:08:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Nov
 2020 09:08:05 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Nov 2020 09:08:05 +0800
Message-ID: <1606352885.23925.3.camel@mtkswgap22>
Subject: Re: [PATCH] scsi: ufs: Remove unnecessary if condition in
 ufshcd_suspend()
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <tomas.winkler@intel.com>,
        <cang@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Nov 2020 09:08:05 +0800
In-Reply-To: <20201125185300.3394-1-huobean@gmail.com>
References: <20201125185300.3394-1-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTI1IGF0IDE5OjUzICswMTAwLCBCZWFuIEh1byB3cm90ZToNCj4gRnJv
bTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IEluIHRoZSBjYXNlIHRoYXQg
YXV0b19ia29wc19lbmFibGUgaXMgZmFsc2UsIHdoaWNoIG1lYW5zIGF1dG8gYmtvcHMNCj4gaGFz
IGJlZW4gZGlzYWJsZWQsIHNvIG5vIG5lZWQgdG8gY2FsbCB1ZnNoY2RfZGlzYWJsZV9hdXRvX2Jr
b3BzKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29t
Pg0KDQpSZXZpZXdlZC1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4N
Cg==

