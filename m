Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1555223
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfFYOjT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 10:39:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62887 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfFYOjS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 10:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561473558; x=1593009558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v79ozKUyeBpCWFe3wnWGCGh1/kWW9fjsxDbXH2BpWBg=;
  b=Dc9Rt1DdP6KRjsyhJJKgzN7n94p7zPVmmq6au+HF4cfevXCx0ww7bwA+
   9oKcG+Dz9uAeZ2QL6nkPPtiWELPjIZE08kR7Y8nGbMfULkDZoGJBhxUW3
   cuT2m/931aWHCJ9n9IFXTioQQieTZZY3x2Xcr5R7PJDH94gdjPtNaA3be
   hXRm3WeifCu+w3HkfBForjzm5yD5QFfOd190GTl0S8j8crQtkDVNwMoVP
   0IRkTCVzDoM58R2ByMTo5nF5cR1bTp8Iao5cTfi9hTOTHyFNfzdXa5RLK
   b/jKsvKf+AITSWQ2wKbOE0MvcVyyPjFMbPE29kCPJ/f+p/EryjVk8APQc
   w==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557158400"; 
   d="scan'208";a="111488144"
Received: from mail-bn3nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 22:39:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v79ozKUyeBpCWFe3wnWGCGh1/kWW9fjsxDbXH2BpWBg=;
 b=hApKcsn8ttYnUqK9yJ1Z91IgTM1Yb47IwofVY8SV9EEnBN/PP9EMD1y83XNbTdg9mwnHb8gZJ+FcownXYRvbxu7zpbkhwO/bwne6XcMNLQMMnRsKYJDy5cZrBIFMZyzAb0KPeN5Vh3QbhsP0rIc5GgMHD2kjyca/Xs+D8veoUTs=
Received: from DM5PR04MB1132.namprd04.prod.outlook.com (10.173.172.135) by
 DM5PR04MB3755.namprd04.prod.outlook.com (10.172.189.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:39:13 +0000
Received: from DM5PR04MB1132.namprd04.prod.outlook.com
 ([fe80::dc69:42e6:c063:a885]) by DM5PR04MB1132.namprd04.prod.outlook.com
 ([fe80::dc69:42e6:c063:a885%3]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 14:39:13 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Avri Altman <Avri.Altman@wdc.com>
CC:     Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Topic: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Index: AQHVK1KaNlGAmc8lW06K1OPlrADX4aasUPiAgAAfgTA=
Date:   Tue, 25 Jun 2019 14:39:13 +0000
Message-ID: <DM5PR04MB113202B71F488EDC658847ACEDE30@DM5PR04MB1132.namprd04.prod.outlook.com>
References: <CGME20190625123640epcas1p2b043961d1b03d2fea1f3c9ddc8d2760d@epcas1p2.samsung.com>
        <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
 <d4e4cd78-18d1-1087-87f0-cb87f6ae99e5@samsung.com>
In-Reply-To: <d4e4cd78-18d1-1087-87f0-cb87f6ae99e5@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arthur.Simchaev@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3ddf4c-9b0f-4129-65a6-08d6f97ae4bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR04MB3755;
x-ms-traffictypediagnostic: DM5PR04MB3755:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB37559FDB5969EAD09A8D15C0EDE30@DM5PR04MB3755.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(7696005)(99286004)(5660300002)(316002)(76116006)(73956011)(81156014)(11346002)(66946007)(81166006)(64756008)(8676002)(7736002)(66556008)(256004)(102836004)(52536014)(2201001)(6636002)(66446008)(74316002)(76176011)(14454004)(8936002)(6246003)(186003)(72206003)(26005)(86362001)(54906003)(4326008)(6116002)(305945005)(2501003)(25786009)(66066001)(2906002)(7416002)(66476007)(33656002)(55016002)(9686003)(53936002)(3846002)(6436002)(71190400001)(478600001)(229853002)(71200400001)(476003)(486006)(68736007)(446003)(558084003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB3755;H:DM5PR04MB1132.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SbuiY1i2uQbqMni2xH66GNDbNPx7lqtalBUhbA5EbXcl+/T8N7KwuWo9Dy3UYFU+lgWQagGvp0VFGuE2rcXgbDjjCLBQiBvHNtvgp/kzbNK+Th6t5zJoydgi6WngexBeSbIlIzNyLy3ptdc9arkJkaX7dkCULzddx6edsPyCI2qmLE/8odfMlhqYb16Rs3EKeevkRwYLJk23nhUgmZ65BRsSSNUhnkZ1BY0psbquge3aURdVbazbKNUThhukOv7lGgKbBNgsV00BLB4sEANM1Ky+ioNS8CEYism4Txzdb9S6qC0YVLk1TfW64aPqoUXJpkbR+cuU2mP1xg22Nk0OH0x6hW1tOOtGSU9aH3IEQR3ujarUmKQBqJrUEyiuC7AMdpem+UFKfSeEF9fyYUcW1Ca+8cHw+gWfTVIM4gVAfGs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3ddf4c-9b0f-4129-65a6-08d6f97ae4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:39:13.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Arthur.Simchaev@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3755
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

IEhpIEFsaW0gDQoNCiBZZXMgeW91IGNhbiwgYnkgd3JpdGluZyB0aGUgY29uZmlndXJhdGlvbiBk
ZXNjcmlwdG9yLg0KDQpSZWdhcmRzDQpBcnRodXINCg0KPiANCj4gSGkgQXJ0aHVyLA0KPiBEb2Vz
IHRoaXMgdG9vbHMgcHJvdmlkZXMgYSB3YXkgZm9yIHVmcyBkZXZpY2UgcGFydGl0aW9uIHByb3Zp
c2luZyBmcm9tDQo+IHVzZXIgc3BhY2UgYXMgd2VsbD8NCj4gKGhhdmUgbm90IHVzZWQgdGhpcyB0
b29sIHRpbGwgbm93LCBwbGFubmluZyB0byB1c2Ugc29vbikNCj4gDQoNCg==
