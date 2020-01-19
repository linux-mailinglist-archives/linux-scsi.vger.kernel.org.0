Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF6141D2D
	for <lists+linux-scsi@lfdr.de>; Sun, 19 Jan 2020 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgASJ4J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Jan 2020 04:56:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49223 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgASJ4I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 Jan 2020 04:56:08 -0500
X-UUID: d65eb91d3b354ac09368b928fbe266b7-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BdVcsiB+e41P2FSuzgzn4eQrqW2tVlQ1igW0BX1Y+e4=;
        b=d6fMpTiZ4phCJrxRzF0Oejw0laoQC1KwuM1xd3/nmnkn+cXVgYWD/WrPgoYLPTB10f7U6T4L2R+FkMJNrL9trGLrzE87DTtY6wuMxwELDKIlp/ghf1H5uMc2SyfGEhhGpBoB9NAYHqZl6E4DodbPFkTSenEEjH37YgUZ+wX9iaM=;
X-UUID: d65eb91d3b354ac09368b928fbe266b7-20200119
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 292205510; Sun, 19 Jan 2020 17:55:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 19 Jan 2020 17:54:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 19 Jan
 2020 17:55:46 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 19 Jan 2020 17:54:52 +0800
Message-ID: <1579427757.19362.11.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/8] scsi: ufs: Fix ufshcd_probe_hba() reture value
 in case ufshcd_scsi_add_wlus() fails
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <tomas.winkler@intel.com>,
        <cang@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 19 Jan 2020 17:55:57 +0800
In-Reply-To: <20200119001327.29155-2-huobean@gmail.com>
References: <20200119001327.29155-1-huobean@gmail.com>
         <20200119001327.29155-2-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gU3VuLCAyMDIwLTAxLTE5IGF0IDAxOjEzICswMTAwLCBCZWFuIEh1byB3cm90ZToNCj4gRnJv
bTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IEEgbm9uLXplcm8gZXJyb3Ig
dmFsdWUgbGlrZWx5IGJlaW5nIHJldHVybmVkIGJ5IHVmc2hjZF9zY3NpX2FkZF93bHVzKCkNCj4g
aW4gY2FzZSBvZiBmYWlsdXJlIG9mIGFkZGluZyB0aGUgV0xzLCBidXQgdWZzaGNkX3Byb2JlX2hi
YSgpIGRvZXNuJ3QNCj4gdXNlIHRoaXMgdmFsdWUsIGFuZCBkb2Vzbid0IHJlcG9ydCB0aGlzIGZh
aWx1cmUgdG8gdXBwZXIgY2FsbGVyLg0KPiBUaGlzIHBhdGNoIGlzIHRvIGZpeCB0aGlzIGlzc3Vl
Lg0KPiANCj4gRml4ZXM6IDJhOGZhNjAwNDQ1YyAoInVmczogbWFudWFsbHkgYWRkIHdlbGwga25v
d24gbG9naWNhbCB1bml0cyIpDQo+IFJldmlld2VkLWJ5OiBBc3V0b3NoIERhcyA8YXN1dG9zaGRA
Y29kZWF1cm9yYS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jv
bi5jb20+DQoNClJldmlld2VkLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsu
Y29tPg0KDQoNCg==

