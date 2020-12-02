Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9692CB7FB
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgLBJBn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 04:01:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55907 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388022AbgLBJBm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Dec 2020 04:01:42 -0500
X-UUID: c421f04d21644768a715251f77686355-20201202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LZJM1T74ENqOGbl8a7Q37TekEOWVNgcTRY1aFVfY5X8=;
        b=ZPiingF6fDYqTPNZqHpX0HntU5DXUuAw081XrryzDI9QVlYS/TUtYCY2nbKRjDN9g9xfcxLIyVfixLXdgYOawHAdSmLLS4bKmig0bDv+j4ItjYn0cko6/t3A/U23241e4A4EjiLGypZ2ujXCMqL7ne/czN4bBTrQkiG1k93GBIg=;
X-UUID: c421f04d21644768a715251f77686355-20201202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1437356229; Wed, 02 Dec 2020 17:00:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Dec 2020 17:00:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Dec 2020 17:00:54 +0800
Message-ID: <1606899655.23925.42.camel@mtkswgap22>
Subject: Re: [PATCH V5 3/3] scsi: ufs: Print host regs in IRQ handler when
 AH8 error happens
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <asutoshd@codeaurora.org>, <nguyenb@codeaurora.org>,
        <hongwus@codeaurora.org>, <rnayak@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>,
        <saravanak@google.com>, <salyzyn@google.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 2 Dec 2020 17:00:55 +0800
In-Reply-To: <1606897475-16907-4-git-send-email-cang@codeaurora.org>
References: <1606897475-16907-1-git-send-email-cang@codeaurora.org>
         <1606897475-16907-4-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTAyIGF0IDAwOjI0IC0wODAwLCBDYW4gR3VvIHdyb3RlOg0KPiBXaGVu
IEFIOCBlcnJvciBoYXBwZW5zLCBhbGwgdGhlIHJlZ3MgYW5kIHN0YXRlcyBhcmUgZHVtcGVkIGlu
IGVyciBoYW5kbGVyLg0KPiBTb21ldGltZSB3ZSBuZWVkIHRvIGxvb2sgaW50byBob3N0IHJlZ3Mg
cmlnaHQgYWZ0ZXIgQUg4IGVycm9yIGhhcHBlbnMsDQo+IHdoaWNoIGlzIGJlZm9yZSBsZWF2aW5n
IHRoZSBJUlEgaGFuZGxlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBCYW8gRC4gTmd1eWVuIDxuZ3V5
ZW5iQGNvZGVhdXJvcmEub3JnPg0KPiBSZXZpZXdlZC1ieTogQXN1dG9zaCBEYXMgPGFzdXRvc2hk
QGNvZGVhdXJvcmEub3JnPg0KPiBSZXZpZXdlZC1ieTogSG9uZ3d1IFN1PGhvbmd3dXNAY29kZWF1
cm9yYS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IENhbiBHdW8gPGNhbmdAY29kZWF1cm9yYS5vcmc+
DQoNClJldmlld2VkLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0K
DQoNCg0K

