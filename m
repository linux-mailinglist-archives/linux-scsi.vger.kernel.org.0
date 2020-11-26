Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C799F2C4C5A
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 02:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgKZA6m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Nov 2020 19:58:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60448 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729371AbgKZA6m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 Nov 2020 19:58:42 -0500
X-UUID: 11307a1992a24223ba4bd2307ca99185-20201126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=B+YqNU++fb4lSeIdFp4cnM3988znwgJ6sEBCbGdHlKA=;
        b=ADjYILEcQYSpgJwps4ADCxvmvSqGuVfp+lwnNFKvFKui1wpinQ6i3yrA/aQENH8fHZIAhXdfEAH5za0VZS6o69/bbozO69r5Ge93z7a9wqiS3aydEwwq2aUXme6StgodbUVlbvGQR5lO0sZYYZ54+/LOP580F9GePylG0dceY6g=;
X-UUID: 11307a1992a24223ba4bd2307ca99185-20201126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 157600909; Thu, 26 Nov 2020 08:58:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Nov 2020 08:58:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Nov 2020 08:58:36 +0800
Message-ID: <1606352316.23925.1.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] scsi: ufs: Refector ufshcd_setup_clocks() to
 remove skip_ref_clk
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <asutoshd@codeaurora.org>, <nguyenb@codeaurora.org>,
        <hongwus@codeaurora.org>, <ziqichen@codeaurora.org>,
        <rnayak@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <kernel-team@android.com>, <saravanak@google.com>,
        <salyzyn@google.com>, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Nov 2020 08:58:36 +0800
In-Reply-To: <1606202906-14485-2-git-send-email-cang@codeaurora.org>
References: <1606202906-14485-1-git-send-email-cang@codeaurora.org>
         <1606202906-14485-2-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQ2FuLA0KDQoiUmVmZWN0b3IiIGluIHRpdGxlIHNoYWxsIGJlICJSZWZhY3RvciI/DQoNCk9u
IE1vbiwgMjAyMC0xMS0yMyBhdCAyMzoyOCAtMDgwMCwgQ2FuIEd1byB3cm90ZToNCj4gUmVtb3Zl
IHRoZSBwYXJhbSBza2lwX3JlZl9jbGsgZnJvbSBfX3Vmc2hjZF9zZXR1cF9jbG9ja3MoKSwgYnV0
IGtlZXAgYSBmbGFnDQo+IGluIHN0cnVjdCB1ZnNfY2xrX2luZm8gdG8gdGVsbCB3aGV0aGVyIGEg
Y2xvY2sgY2FuIGJlIGRpc2FibGVkIG9yIG5vdCB3aGlsZQ0KPiB0aGUgbGluayBpcyBhY3RpdmUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDYW4gR3VvIDxjYW5nQGNvZGVhdXJvcmEub3JnPg0KDQpP
dGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxz
dGFubGV5LmNodUBtZWRpYXRlay5jb20+DQoNCg==

