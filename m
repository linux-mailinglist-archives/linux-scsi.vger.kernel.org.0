Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52A11FD52
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Dec 2019 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLPDtI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Dec 2019 22:49:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726784AbfLPDtH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 15 Dec 2019 22:49:07 -0500
X-UUID: df0c230293fb41a081926df5560ca889-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=12E3/w0zLzo1lHYmnmqiu5tF62G08uQTQTzZ3/Kf2H4=;
        b=Hcg4n26TzyXS2za9aCm9jXFWqGKH+nprJ8AKZgv48EIE7QYfOVTj+i06ntAOWFkNnxAYzOQmTOmKwtQQRdhgwfEeFuhR5zWUVC/mRMWDE0GEHYg4Mm914Bksb3rTUHEfREnfCVT/WuUIeoNhNdHqI/UeBCNW0innOCA0JB1EDbA=;
X-UUID: df0c230293fb41a081926df5560ca889-20191216
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1215728100; Mon, 16 Dec 2019 11:48:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Dec 2019 11:48:36 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Dec 2019 11:48:59 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <matthias.bgg@gmail.com>, <f.fainelli@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <beanhuo@micron.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        <leon.chen@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 1/2 RESEND] soc: mediatek: add header for SiP service interface
Date:   Mon, 16 Dec 2019 11:48:56 +0800
Message-ID: <1576468137-17220-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1576468137-17220-1-git-send-email-stanley.chu@mediatek.com>
References: <1576468137-17220-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

QWRkIGEgaGVhZGVyIGZvciB0aGUgU2lQIHNlcnZpY2UgaW50ZXJmYWNlIGluIG9yZGVyIHRvIGFj
Y2Vzcw0KdGhlIFVGU0hDSSBjb250cm9sbGVyIGZvciBzZWN1cmUgY29tbWFuZCBoYW5kbGluZyBp
biBNZWRpYVRlayBDaGlwc2V0cy4NCg0KU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaHUgPHN0YW5s
ZXkuY2h1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
a19zaXBfc3ZjLmggfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMjkgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
X3NpcF9zdmMuaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uOTcz
MTE5NTlkN2Q3DQotLS0gL2Rldi9udWxsDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGtfc2lwX3N2Yy5oDQpAQCAtMCwwICsxLDI5IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAgKi8NCisvKg0KKyAqIENvcHlyaWdodCAoQykgMjAxOSBNZWRpYVRlayBJ
bmMuDQorICovDQorI2lmbmRlZiBfX01US19TSVBfU1ZDX0gNCisjZGVmaW5lIF9fTVRLX1NJUF9T
VkNfSA0KKw0KKy8qIEVycm9yIENvZGUgKi8NCisjZGVmaW5lIFNJUF9TVkNfRV9TVUNDRVNTICAg
ICAgICAgICAgICAgMA0KKyNkZWZpbmUgU0lQX1NWQ19FX05PVF9TVVBQT1JURUQgICAgICAgICAt
MQ0KKyNkZWZpbmUgU0lQX1NWQ19FX0lOVkFMSURfUEFSQU1TICAgICAgICAtMg0KKyNkZWZpbmUg
U0lQX1NWQ19FX0lOVkFMSURfUkFOR0UgICAgICAgICAtMw0KKyNkZWZpbmUgU0lQX1NWQ19FX1BF
Uk1JU1NJT05fREVOSUVEICAgICAtNA0KKw0KKyNpZmRlZiBDT05GSUdfQVJNNjQNCisjZGVmaW5l
IE1US19TSVBfU01DX0NPTlZFTlRJT04gICAgICAgICAgQVJNX1NNQ0NDX1NNQ182NA0KKyNlbHNl
DQorI2RlZmluZSBNVEtfU0lQX1NNQ19DT05WRU5USU9OICAgICAgICAgIEFSTV9TTUNDQ19TTUNf
MzINCisjZW5kaWYNCisNCisjZGVmaW5lIE1US19TSVBfU01DX0NNRChmbl9pZCkgXA0KKwlBUk1f
U01DQ0NfQ0FMTF9WQUwoQVJNX1NNQ0NDX0ZBU1RfQ0FMTCwgTVRLX1NJUF9TTUNfQ09OVkVOVElP
TiwgXA0KKwkJCSAgIEFSTV9TTUNDQ19PV05FUl9TSVAsIGZuX2lkKQ0KKw0KKy8qIFVGUyByZWxh
dGVkIFNNQyBjYWxsICovDQorI2RlZmluZSBNVEtfU0lQX1VGU19DT05UUk9MIFwNCisJTVRLX1NJ
UF9TTUNfQ01EKDB4Mjc2KQ0KKw0KKyNlbmRpZg0KLS0gDQoyLjE4LjANCg==

