Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B40FD67B
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2019 07:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOGg0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Nov 2019 01:36:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56494 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbfKOGfn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Nov 2019 01:35:43 -0500
X-UUID: 4fd331558b9d414794818d6513d7117a-20191115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rk57yqGMmLCWAiKj3bUDvcywvFJ3T7OqD7JZ6VwhDU4=;
        b=UB0SWHg95dooa4dydC6ecVveeXLMd9W9mOHNDhRUkv8P01rDr/YjQmJbZHIjAyts+4GsTaRZmHhL23GLl/M6J6/xIelgranoUFGDbxLiAQFxfRh+08Dc/d/59XRq+ZXEEO4xHXL5sCGx24TlBPGdzCVoVIXk6+2kLkGIzSJCiuU=;
X-UUID: 4fd331558b9d414794818d6513d7117a-20191115
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 254854927; Fri, 15 Nov 2019 14:35:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Nov 2019 14:35:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Nov 2019 14:35:27 +0800
Message-ID: <1573799728.4956.5.camel@mtkswgap22>
Subject: Re: [PATCH v5 3/7] scsi: ufs: Fix up auto hibern8 enablement
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <asutoshd@codeaurora.org>, <nguyenb@codeaurora.org>,
        <rnayak@codeaurora.org>, <linux-scsi@vger.kernel.org>,
        <kernel-team@android.com>, <saravanak@google.com>,
        <salyzyn@google.com>, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Nov 2019 14:35:28 +0800
In-Reply-To: <1573798172-20534-4-git-send-email-cang@codeaurora.org>
References: <1573798172-20534-1-git-send-email-cang@codeaurora.org>
         <1573798172-20534-4-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQ2FuLA0KDQpPbiBUaHUsIDIwMTktMTEtMTQgYXQgMjI6MDkgLTA4MDAsIENhbiBHdW8gd3Jv
dGU6DQo+ICsJaWYgKGhiYS0+YWhpdCAhPSBhaGl0KQ0KPiArCQloYmEtPmFoaXQgPSBhaGl0Ow0K
PiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoaGJhLT5ob3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsN
Cj4gKwlpZiAoIXBtX3J1bnRpbWVfc3VzcGVuZGVkKGhiYS0+ZGV2KSkgew0KDQpBbHdheXMgZG8g
cG1fcnVudGltZV9nZXRfc3luYygpIGhlcmUgY291bGQgYXZvaWQgcG9zc2libGUgcmFjaW5nPw0K
DQpBbmQgdGh1cyBBSDggY291bGQgYmUgZW5hYmxlZCByZWdhcmRsZXNzIG9mIHJ1bnRpbWUgc3Rh
dHVzLg0KDQo+ICsJCXBtX3J1bnRpbWVfZ2V0X3N5bmMoaGJhLT5kZXYpOw0KPiArCQl1ZnNoY2Rf
aG9sZChoYmEsIGZhbHNlKTsNCj4gKwkJdWZzaGNkX2F1dG9faGliZXJuOF9lbmFibGUoaGJhKTsN
Cj4gKwkJdWZzaGNkX3JlbGVhc2UoaGJhKTsNCj4gKwkJcG1fcnVudGltZV9wdXQoaGJhLT5kZXYp
Ow0KPiArCX0NCj4gIH0NCg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo=

