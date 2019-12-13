Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207AD11DC3F
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Dec 2019 03:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfLMCsX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Dec 2019 21:48:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:29891 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727605AbfLMCsX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Dec 2019 21:48:23 -0500
X-UUID: ef95fc06bd1a427d9db9083dc31d40e7-20191213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1mh7OPQCgMOBR1dvjtbiL2hG+rXyscvDOnW/uspS6Jg=;
        b=Pa6pK6ODz4CZP0vPhpwf7QPrL+CysndJoTOGcw5+gVlbVxo5xLwIHVeS9gTek2XrE4N93R6TlMXZhiArWDall1mgvloG2emzEL0zE8TtuK/nHnqegsla0MLUV3Ujh/H2DJYLR8jaap1kk97tMYd9+6PgddmmYIIh3CWJAUgZ6tU=;
X-UUID: ef95fc06bd1a427d9db9083dc31d40e7-20191213
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2126199904; Fri, 13 Dec 2019 10:48:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 10:47:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 10:47:36 +0800
Message-ID: <1576205295.12066.5.camel@mtkswgap22>
Subject: Re: [PATCH v1 0/2] scsi: ufs: fixup active period of ufshcd
 interrupt
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <avri.altman@wdc.com>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <beanhuo@micron.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>
Date:   Fri, 13 Dec 2019 10:48:15 +0800
In-Reply-To: <1575721321-8071-1-git-send-email-stanley.chu@mediatek.com>
References: <1575721321-8071-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

RGVhciByZXZpZXdlcnMsDQoNCglHZW50bGUgcGluZyBmb3IgdGhpcyBwYXRjaCBzZXQuDQoNCk9u
IFNhdCwgMjAxOS0xMi0wNyBhdCAyMDoyMSArMDgwMCwgU3RhbmxleSBDaHUgd3JvdGU6DQo+IFRo
aXMgcGF0Y2hzZXQgZml4ZXMgdXAgYWN0aXZlIGR1cmF0aW9uIG9mIHVmc2hjZCBpbnRlcnJ1cHQg
dG8gYXZvaWQgcG90ZW50aWFsIHN5c3RlbSBoYW5nIGlzc3Vlcy4NCj4gDQo+IFN0YW5sZXkgQ2h1
ICgyKToNCj4gICBzY3NpOiB1ZnM6IGRpc2FibGUgaXJxIGJlZm9yZSBkaXNhYmxpbmcgY2xvY2tz
DQo+ICAgc2NzaTogdWZzOiBkaXNhYmxlIGludGVycnVwdCBkdXJpbmcgY2xvY2stZ2F0aW5nDQo+
IA0KPiAgZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyB8IDE1ICsrKysrKysrKystLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KDQpU
aGFua3MsDQpTdGFubGV5DQoNCg==

