Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A279127740
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTIgm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 03:36:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727089AbfLTIgl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 03:36:41 -0500
X-UUID: a8a17a01f0db4e789f8e708170174f4a-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IZiP5YrTxE+iO+RWwQXc0/Jmdtb3apOUhGjsyueGvtg=;
        b=B1Fc0bo2vEVBG94K+hVjXDo6tDYKlTVDxTkob9ykCRBqhZ3B6GYRPt8UReylF29hh9vcMA4sW46Vsq4MXI7NastM1hLolNWJOuGPEUJVAkpvGy0QWnusmaej9g32qVJN+swlaSycTAU6HDQpsi6LTnG0gr3vbm8cPaQWzlQGOEc=;
X-UUID: a8a17a01f0db4e789f8e708170174f4a-20191220
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1398704638; Fri, 20 Dec 2019 16:36:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 16:35:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 16:35:39 +0800
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
Subject: [PATCH v1 5/6] scsi: ufs-mediatek: configure customized auto-hibern8 timer
Date:   Fri, 20 Dec 2019 16:36:27 +0800
Message-ID: <1576830988-22435-6-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1576830988-22435-1-git-send-email-stanley.chu@mediatek.com>
References: <1576830988-22435-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Q29uZmlndXJlIGN1c3RvbWl6ZWQgYXV0by1oaWJlcm44IHRpbWVyIGluIE1lZGlhVGVrIENoaXBz
ZXRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsu
Y29tPg0KUmV2aWV3ZWQtYnk6IEFsaW0gQWtodGFyIDxhbGltLmFraHRhckBzYW1zdW5nLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMgfCA4ICsrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLW1lZGlhdGVrLmMNCmlu
ZGV4IDY5MDQ4M2M3ODIxMi4uNzFlMmUwZTRlYTExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zY3Np
L3Vmcy91ZnMtbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsu
Yw0KQEAgLTcsNiArNyw3IEBADQogICovDQogDQogI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5o
Pg0KKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KICNpbmNsdWRlIDxsaW51eC9vZi5oPg0K
ICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BoeS9waHku
aD4NCkBAIC0zMDAsNiArMzAxLDEzIEBAIHN0YXRpYyBpbnQgdWZzX210a19wb3N0X2xpbmsoc3Ry
dWN0IHVmc19oYmEgKmhiYSkNCiAJLyogZW5hYmxlIHVuaXBybyBjbG9jayBnYXRpbmcgZmVhdHVy
ZSAqLw0KIAl1ZnNfbXRrX2NmZ191bmlwcm9fY2coaGJhLCB0cnVlKTsNCiANCisJLyogY29uZmln
dXJlIGF1dG8taGliZXJuOCB0aW1lciB0byAxMG1zICovDQorCWlmICh1ZnNoY2RfaXNfYXV0b19o
aWJlcm44X3N1cHBvcnRlZChoYmEpKSB7DQorCQl1ZnNoY2RfYXV0b19oaWJlcm44X3VwZGF0ZSho
YmEsDQorCQkJRklFTERfUFJFUChVRlNIQ0lfQUhJQkVSTjhfVElNRVJfTUFTSywgMTApIHwNCisJ
CQlGSUVMRF9QUkVQKFVGU0hDSV9BSElCRVJOOF9TQ0FMRV9NQVNLLCAzKSk7DQorCX0NCisNCiAJ
cmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjE4LjANCg==

