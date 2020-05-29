Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8981E851E
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2020 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgE2Rhs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 May 2020 13:37:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23803 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rhq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 May 2020 13:37:46 -0400
X-UUID: f0ef82ab5f5a444ea0967d7eb5efc747-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jZp9Yl9q7Xr6E209YE1XG7GDClSwTxz3XRE0bXzb1QU=;
        b=kiuYxj1rkpgyHABQGXDjaNyDGQTzZDomtk8O57YvP6T4abRTxLhAWVMXNQaTUTPR3Ud6XINoEHOVJ6VokGi/xclKVtkOox/Ehn8p7og4opaNCVxoPQnwJAhV8YxKxiq8RBB1bJ32lRf6hm7IiL/x+eaxox1YonIOpuZbg2iqMfI=;
X-UUID: f0ef82ab5f5a444ea0967d7eb5efc747-20200530
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2055573831; Sat, 30 May 2020 01:37:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 01:37:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 01:37:36 +0800
Message-ID: <1590773860.25636.5.camel@mtkswgap22>
Subject: Re: [PATCH v4 1/4] scsi: ufs: remove max_t in ufs_get_device_desc
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Bean Huo <huobean@gmail.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <asutoshd@codeaurora.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <bvanassche@acm.org>, <tomas.winkler@intel.com>,
        <cang@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 30 May 2020 01:37:40 +0800
In-Reply-To: <20200529164054.27552-2-huobean@gmail.com>
References: <20200529164054.27552-1-huobean@gmail.com>
         <20200529164054.27552-2-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDE4OjQwICswMjAwLCBCZWFuIEh1byB3cm90ZToNCj4gRnJv
bTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IEZvciB0aGUgVUZTIGRldmlj
ZSwgdGhlIG1heGltdW0gZGVzY3JpcHRvciBzaXplIGlzIDI1NSwgbWF4X3QgY2FsbGVkDQo+IGlu
IHVmc19nZXRfZGV2aWNlX2Rlc2MoKSBpcyB1c2VsZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QmFydCB2YW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEJl
YW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+DQo+IEFja2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZy
aS5hbHRtYW5Ad2RjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNo
dUBtZWRpYXRlay5jb20+DQo=

