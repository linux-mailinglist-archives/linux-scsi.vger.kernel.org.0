Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2B211A49
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2020 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGBCt4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Jul 2020 22:49:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgGBCt4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 Jul 2020 22:49:56 -0400
X-UUID: 609bd3dbb79c4576974bd0f2ef834416-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BxzcxjLFPFAfROechcGcp77hZAYcAOCqr6JkUkvRESc=;
        b=j6DNdmf4NTvcP6ThoQwrfKIODKsrBECqPB9HSVO4w7eJnp0G1y6aitWN6ZlSIsfrzxpu/XCsRvxpmC4fvTHRHcalz6LQX7UnV5MjyIPiADAfGJjjqeVtBiQcR0x/WvQ2ZmWuvEjfnJiMvQdCi2BOHqTf6hAwpCYwv3vhOG+soaM=;
X-UUID: 609bd3dbb79c4576974bd0f2ef834416-20200702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1964697657; Thu, 02 Jul 2020 10:49:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 10:49:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 10:49:50 +0800
Message-ID: <1593658191.3278.7.camel@mtkswgap22>
Subject: Re: [RFC PATCH v2 0/2] ufs: introduce callbacks to get command
 information
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
CC:     <linux-scsi@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>
Date:   Thu, 2 Jul 2020 10:49:51 +0800
In-Reply-To: <cover.1593657314.git.kwmad.kim@samsung.com>
References: <CGME20200702024556epcas2p41b15bb9fb91884435a2cb8711273d29f@epcas2p4.samsung.com>
         <cover.1593657314.git.kwmad.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgS2l3b29uZywNCg0KT24gVGh1LCAyMDIwLTA3LTAyIGF0IDExOjM4ICswOTAwLCBLaXdvb25n
IEtpbSB3cm90ZToNCj4gU29tZSBTb0Mgc3BlY2lmaWMgbWlnaHQgbmVlZCBjb21tYW5kIGhpc3Rv
cnkgZm9yDQo+IHZhcmlvdXMgcmVhc29ucywgc3VjaCBhcyBzdGFja2luZyBjb21tYW5kIGNvbnRl
eHRzDQo+IGluIHN5c3RlbSBtZW1vcnkgdG8gY2hlY2sgZm9yIGRlYnVnZ2luZyBpbiB0aGUgZnV0
dXJlDQo+IG9yIHNjYWxpbmcgc29tZSBEVkZTIGtub2JzIHRvIGJvb3N0IElPIHRocm91Z2hwdXQu
DQo+IA0KPiBXaGF0IHlvdSB3b3VsZCBkbyB3aXRoIHRoZSBpbmZvcm1hdGlvbiBjb3VsZCBiZQ0K
PiB2YXJpYW50IHBlciBTb0MgdmVuZG9yLg0KPiANCj4gS2l3b29uZyBLaW0gKDIpOg0KPiAgIHVm
czogaW50cm9kdWNlIGEgY2FsbGJhY2sgdG8gZ2V0IGluZm8gb2YgY29tbWFuZCBjb21wbGV0aW9u
DQo+ICAgZXh5bm9zLXVmczogaW1wbGVtZW50IGRiZ19yZWdpc3Rlcl9kdW1wIGFuZCBjb21wbF94
ZmVyX3JlcQ0KDQpUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQoNCldvdWxkIHlvdSBwbGVhc2UgZWxh
Ym9yYXRlIHRoZSBjaGFuZ2UgbG9nIGluIGNvdmVyIGxldHRlciBmb3IgZWFzaWVyDQpyZXZpZXcg
aW4gdGhlIGZ1dHVyZT8NCg0KVGhhbmtzLA0KU3RhbmxleSBDaHUNCg0KDQo=

