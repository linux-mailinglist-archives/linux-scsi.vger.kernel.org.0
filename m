Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F602141D2E
	for <lists+linux-scsi@lfdr.de>; Sun, 19 Jan 2020 10:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgASJ4f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Jan 2020 04:56:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63573 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgASJ4f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 Jan 2020 04:56:35 -0500
X-UUID: 8c3d58d06a6e4280bf0a3d1af8593c09-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LyM+HQkZrMO8a7jbl51/gAXhqxHOjKvnEIzTtNgGfHo=;
        b=TkyCkj/uM7AbC3J2JwshRPe7XItALXF3PYY/XOdWQ4p8Q7ESTmnKJ7ruBBUzKYArneAo/o0GyjczyEFT8jvBV/uwOqJppVP9isD0AHDWOiIFz3uBTWeDhyj1Lvu/i3CJTHsD7XluCPqMQu1+Q9HCsF+caEi1dkQxpF3hwQydeAY=;
X-UUID: 8c3d58d06a6e4280bf0a3d1af8593c09-20200119
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1654224308; Sun, 19 Jan 2020 17:56:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 19 Jan 2020 17:55:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 19 Jan 2020 17:55:26 +0800
Message-ID: <1579427790.19362.12.camel@mtksdccf07>
Subject: Re: [PATCH v3 2/8] scsi: ufs: Delete struct ufs_dev_desc
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <tomas.winkler@intel.com>,
        <cang@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 19 Jan 2020 17:56:30 +0800
In-Reply-To: <20200119001327.29155-3-huobean@gmail.com>
References: <20200119001327.29155-1-huobean@gmail.com>
         <20200119001327.29155-3-huobean@gmail.com>
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
bTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IEluIGNvbnNpZGVyYXRpb24g
b2YgVUZTIGhvc3QgZHJpdmVyIHVzZXMgcGFyYW1ldGVycyBvZiBzdHJ1Y3QNCj4gdWZzX2Rldl9k
ZXNjLCBtb3ZlIGl0cyBwYXJhbWV0ZXJzIHRvIHN0cnVjdCB1ZnNfZGV2X2luZm8sDQo+IGRlbGV0
ZSBzdHJ1Y3QgdWZzX2Rldl9kZXNjLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2No
ZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiBSZXZpZXdlZC1ieTogQXN1dG9zaCBEYXMgPGFzdXRv
c2hkQGNvZGVhdXJvcmEub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0Bt
aWNyb24uY29tPg0KDQpSZXZpZXdlZC1ieTogU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlh
dGVrLmNvbT4NCg0KDQo=

