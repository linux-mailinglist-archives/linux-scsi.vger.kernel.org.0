Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C714C68C
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jan 2020 07:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgA2GeI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jan 2020 01:34:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:27271 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725966AbgA2GeH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Jan 2020 01:34:07 -0500
X-UUID: 34e162673faa47b69fdf43c08316f37c-20200129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ujk6W1itj+kyGPWCpmoTXw9A47Q4LtnJX0OapEkv6Rs=;
        b=HkrrDZHup2REa8MtxmosCkPS2cLm6biREC/G85Xxz2ifw/hufxhyJQyE7nO/eyv2UbcbOJrp6r7QWC/kYf3/gCYxNXbcvGX9QAwrgXNf2ZDE+B+nfo73VozsGay5X4rLIqZw3nigefKFzduoYRwFJtYM/gN7PAk9bJffEryUGbs=;
X-UUID: 34e162673faa47b69fdf43c08316f37c-20200129
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1775390333; Wed, 29 Jan 2020 14:33:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 Jan 2020 14:32:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 Jan 2020 14:34:03 +0800
Message-ID: <1580279636.15794.0.camel@mtksdccf07>
Subject: RE: [EXT] [PATCH v2 4/5] scsi: ufs: fix auto-hibern8 error detection
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>
Date:   Wed, 29 Jan 2020 14:33:56 +0800
In-Reply-To: <BN7PR08MB56840A622E2170C4F913A5D7DB0A0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <20200124150743.15110-1-stanley.chu@mediatek.com>
         <20200124150743.15110-5-stanley.chu@mediatek.com>
         <BN7PR08MB56840A622E2170C4F913A5D7DB0A0@BN7PR08MB5684.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQmVhbiwNCg0KT24gVHVlLCAyMDIwLTAxLTI4IGF0IDE1OjUyICswMDAwLCBCZWFuIEh1byAo
YmVhbmh1bykgd3JvdGU6DQo+IEhpLCBTdGFubGV5IA0KPiBEbyB5b3UgdGhpbmsgaXQgaXMgbmVj
ZXNzYXJ5IHRvIGFkZCBmaXhlcyB0YWcsIGFuZCBjb21iaW5lIHRoaXMgcGF0Y2ggd2l0aCBwcmV2
aW91cyBwYXRjaCB0bw0KPiBzaW5nbGUgcGF0Y2g/ICBUaGF0IHdpbGwgYmUgZWFzaWVyIHRvIGRv
d24gcG9ydCB0byB0aGUgb2xkZXIga2VybmVsLg0KDQpPSyEgSSB3aWxsIHVwZGF0ZSB0aGlzIHBh
dGNoIGFjY29yZGluZyB0byB5b3VyIHN1Z2dlc3Rpb25zIGluIG5leHQNCnZlcnNpb24uDQoNClRo
YW5rcywNClN0YW5sZXkNCg0K

