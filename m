Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CC247EE
	for <lists+linux-scsi@lfdr.de>; Tue, 21 May 2019 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEUGSQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 02:18:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54885 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfEUGSQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 02:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558419528; x=1589955528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tjsXONKa+Pf6UPe0Zzel/r/jyoegrw1lpopf3HtQQyY=;
  b=WQTZSDXzh18tAYv0aTA+v23C6lYr7F/hNFGLUfMgrSSSOS/sfnx2IXPv
   YehqYk1JZeq6POtL8FI7y9qB61kuBCTQ0B8ZBNNC2zR8CmSPSuSyx81I8
   KqqOhYPPq9DH0uSrWD9GTYnr0PQJC1DR5ygvlNkqtln3gXntLFTy9fOmL
   3XiFUItkVTIJ7AOEjDZFKWneoaVEt9nGDz4FTfnCp2lQHM61OI9kMzuuG
   82nReUcVtCcUXGspM5iihd08xYt/o4IqW9R8w7pA5Qkco84V0AEH8edwD
   lQQ3F2zbUOX4BRZq4cFdAMqL4POpiDNgDWY880/PpiFK/EQB7KRfDrMEN
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,494,1549900800"; 
   d="scan'208";a="208184221"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2019 14:18:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjsXONKa+Pf6UPe0Zzel/r/jyoegrw1lpopf3HtQQyY=;
 b=BRnRkGiVSFcU7oDMZGaJ5jbv9m7JvBDJs/AuRWp2VSaIsTtsWvftbgvRXNkzTxqw3Qun5aLxPpjeCV4EZOSKW1qcP6X2wHfEtM2zoc1GY+mNrQC77zCaDaWKwSgnvkV9kQIxeqKFwSlAxNUU4OX6tqtO92pivxMS5CdvWJwEjWk=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3824.namprd04.prod.outlook.com (52.135.81.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 06:18:11 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530%6]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 06:18:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [PATCH v4 2/3] scsi: ufs: Introduce
 ufshcd_is_auto_hibern8_supported()
Thread-Topic: [PATCH v4 2/3] scsi: ufs: Introduce
 ufshcd_is_auto_hibern8_supported()
Thread-Index: AQHVDxXZu6oGxF11MU6BMI1MBhbFCaZ1GtHg
Date:   Tue, 21 May 2019 06:18:11 +0000
Message-ID: <SN6PR04MB4925EAB455D857AEB055258FFC070@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1558361445-30994-1-git-send-email-stanley.chu@mediatek.com>
 <1558361445-30994-3-git-send-email-stanley.chu@mediatek.com>
In-Reply-To: <1558361445-30994-3-git-send-email-stanley.chu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20d7dde-6802-49c7-a78d-08d6ddb419ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3824;
x-ms-traffictypediagnostic: SN6PR04MB3824:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3824DF90CC9E6DE59927266CFC070@SN6PR04MB3824.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(76176011)(33656002)(99286004)(6116002)(6506007)(3846002)(5660300002)(54906003)(110136005)(7696005)(55016002)(558084003)(256004)(4326008)(26005)(11346002)(52536014)(446003)(68736007)(478600001)(2501003)(14454004)(7736002)(6246003)(8936002)(81166006)(53936002)(81156014)(8676002)(186003)(102836004)(66066001)(476003)(86362001)(9686003)(486006)(72206003)(316002)(64756008)(66446008)(66556008)(2906002)(73956011)(76116006)(66946007)(66476007)(2201001)(229853002)(71190400001)(305945005)(7416002)(6436002)(74316002)(25786009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3824;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L0vnxzWxKVRMQWeeCxzzjIw2vMOTm1/9ZedCGdkKv4DvlIRCe8yLw2L5DxvZzzUaRyPqmTCjFlVKL+6axMJjcAkhEu8k03YiX1dbpckZempERgJKOMujmM3aVphTgsKR+MsfI1kWz8Mm+TJFYVxHnBWKBwym/tbwn/iJbVB0poqLLIm+Jm94xgT8TtArrxO5PlnBZ/A2zGuDFQH0/rUOgJg3QeSrBAXxtKWPo+HDN/a4IMWd8hKeD9VYG4ch+lz9mKygnpZayTYvLKDbsd/uaL9SwtzbBPTRlq7DobTi/861sQ4pHWy2zJ5sTN7H+PMLGKtId0bh6s+VYdY0S6XdYgYCNYnU26U+WDmjbQFbq/M9f0mACg3m3XTpdAMgbEZiGd1b75Pdmi6dBSa67jMdSpAjm4acsTo13R9FhZEFiT8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20d7dde-6802-49c7-a78d-08d6ddb419ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 06:18:11.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3824
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>=20
> ufshcd_is_auto_hibern8_supported() will be used elsewhere
> in the driver, thus refactor it for preparation.
You missed a couple of spots, e.g. in ufshcd_auto_hibern8_enable and in ufs=
-sysfs.

Thanks,
Avri
