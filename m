Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10B306B4F
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhA1DAI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 22:00:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38141 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229682AbhA1DAF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Jan 2021 22:00:05 -0500
X-UUID: 6bbe9a276bb54c81b12c8dda8186fa27-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aqShpSnRtd7/hTVNe8MJJvFv2eUPYon5fnP3Eu5cFxE=;
        b=FMTmEsu7SsLEfEHAs68c+/JUBVt7A4jPfdfMipcMeMLghAcdHFnkthpCubR6idWOl9AJTcHKdqI38jHFn9+9Lh2j88jT5jB5bZy6trmsdAzw+4LQUhtCuEmofiWGzpL4miLkMJxJb/orsQA1OZMkIJ++M+w+PCbv89W3/KaUXvs=;
X-UUID: 6bbe9a276bb54c81b12c8dda8186fa27-20210128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 849238491; Thu, 28 Jan 2021 10:59:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 10:59:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 Jan
 2021 10:59:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 10:59:10 +0800
Message-ID: <1611802750.1261.7.camel@mtkswgap22>
Subject: Re: [PATCH v2] scsi: ufs: Give clk scaling min gear a value
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <jaegeuk@kernel.org>, <asutoshd@codeaurora.org>,
        <nguyenb@codeaurora.org>, <hongwus@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <linux-scsi@vger.kernel.org>,
        <kernel-team@android.com>, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Jan 2021 10:59:10 +0800
In-Reply-To: <1611802172-37802-1-git-send-email-cang@codeaurora.org>
References: <1611802172-37802-1-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
X-TM-SNTS-SMTP: E45801C943FF85AA7ACC75482F954222CD7128B145BC04EFAA5C357ED89527022000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTI3IGF0IDE4OjQ5IC0wODAwLCBDYW4gR3VvIHdyb3RlOg0KPiBUaGUg
aW5pdGlhbGl6YXRpb24gb2YgY2xrX3NjYWxpbmcubWluX2dlYXIgd2FzIHJlbW92ZWQgYnkgbWlz
dGFrZS4gVGhpcw0KPiBjaGFuZ2UgYWRkcyBpdCBiYWNrLCBvdGhlcndpc2UgY2xvY2sgc2NhbGlu
ZyBkb3duIHdvdWxkIGZhaWwuDQo+IA0KPiBGaXhlczogNDU0M2Q5ZDc4MjI3ICgic2NzaTogdWZz
OiBSZWZhY3RvciB1ZnNoY2RfaW5pdC9leGl0X2Nsa19zY2FsaW5nL2dhdGluZygpIikNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENhbiBHdW8gPGNhbmdAY29kZWF1cm9yYS5vcmc+DQoNClJldmlld2Vk
LWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KDQoNCg==

