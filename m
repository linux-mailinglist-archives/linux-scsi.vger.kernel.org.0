Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17675F980
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jul 2019 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfGDOA1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jul 2019 10:00:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61538 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfGDOA1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Jul 2019 10:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562248827; x=1593784827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NHx4kUWfiOXZZGzrrPHAOsmcnsouKM33EHuZPYh002A=;
  b=ClnflF+PILbOaGNN7tq0W0NFnsdsa/fKW+JQJh7SjS9hdyRjZg3tg2D4
   /WOF0g6rpENRJZfXsGQlft+WQCZ1JkE5QaAv/EBC3YJbvib051a64AB7Y
   PNzSvwjQn56giXnlAohUe75FAxzpZDTdmH/jxa8zRRL2xCmqofMCMd7i2
   vpZSAG0pgzgrgZbHq7NI9PdScG65qjXE4uEy7WAA132iUpWN50XtR7f5/
   yK5In0fLbX1RLv/QjAS5YpaToCuo4lH5LebvGJXKUSFfnw4Xd6cujBCjT
   bOb4ztby/H5zfLz/ZJNOBwh5DBBb3FlRNLZbsyIfE/KYbXcnjc6L6hWgm
   A==;
IronPort-SDR: mvY/0VE7jXoRel1ZBe6mlVUTDUGGJAl/Hm2C5qhZ1T/9WlxB7C8ekhRsjvD8UDW151JBhM9xRW
 Kj3HWrh3PAfzl5/s1G35zRUr4d7YTqMbVaYw6Xvxivz+vbA+PelGThpjWrxb9bd53DC4XQ5jIN
 3TvBR58geu45XEA7yRSx93C/2MUVZLImPA/GyUHppXbG2tcF1FdJEQK0xW1nB3xh62EYToiOX+
 CBdS033MPBa/IXHldGGbHsmdVZ6kczetLwbdP9Yj/XqOrUA5xRA5NwBZBfjO2kImXF0z+9uEqR
 01A=
X-IronPort-AV: E=Sophos;i="5.63,451,1557158400"; 
   d="scan'208";a="113427158"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2019 22:00:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHx4kUWfiOXZZGzrrPHAOsmcnsouKM33EHuZPYh002A=;
 b=Yl+T9kWKFSRgj5Q+HtrnKHYOGCNRksxf2G7PNNJFzkuz8uxc4qPM3mO9H0NeSaxv/Bdfn7CxsePiIzG0Ef11dsD7oJxca3E7UtqEepJTK8cPv8XmzFTaG4yIe0GA4s6cWCnZyLm3UKLG4869R20pfsDtUBbeAg405DRLJUqEoYs=
Received: from CY4PR04MB0969.namprd04.prod.outlook.com (10.171.246.153) by
 CY4PR04MB0681.namprd04.prod.outlook.com (10.172.141.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 14:00:22 +0000
Received: from CY4PR04MB0969.namprd04.prod.outlook.com
 ([fe80::2ca8:9c34:85aa:f73a]) by CY4PR04MB0969.namprd04.prod.outlook.com
 ([fe80::2ca8:9c34:85aa:f73a%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 14:00:22 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Pedro Sousa <PedroM.Sousa@synopsys.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-@mx0a-00230701.pphosted.com" 
        <linux-@mx0a-00230701.pphosted.com>,
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>
CC:     Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Topic: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Index: AQHVK1KaNlGAmc8lW06K1OPlrADX4aa6UwMAgAA2EZA=
Date:   Thu, 4 Jul 2019 14:00:22 +0000
Message-ID: <CY4PR04MB09692377698277D03E3D2183EDFA0@CY4PR04MB0969.namprd04.prod.outlook.com>
References: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
 <MN2PR12MB316796A709A4A0358D530A3CCCFA0@MN2PR12MB3167.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB316796A709A4A0358D530A3CCCFA0@MN2PR12MB3167.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arthur.Simchaev@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588c5156-127e-4b90-72f1-08d70087f50d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR04MB0681;
x-ms-traffictypediagnostic: CY4PR04MB0681:
x-microsoft-antispam-prvs: <CY4PR04MB0681707211FB400532105EB7EDFA0@CY4PR04MB0681.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(13464003)(476003)(52536014)(8676002)(478600001)(486006)(33656002)(6116002)(68736007)(73956011)(76116006)(256004)(66446008)(66556008)(66476007)(14444005)(66066001)(66946007)(64756008)(2906002)(3846002)(2501003)(72206003)(71200400001)(71190400001)(2201001)(102836004)(86362001)(53936002)(229853002)(76176011)(74316002)(53546011)(446003)(7696005)(186003)(316002)(305945005)(6436002)(6506007)(5660300002)(6636002)(9686003)(99286004)(110136005)(7416002)(14454004)(54906003)(25786009)(55016002)(7736002)(4326008)(81156014)(8936002)(6246003)(81166006)(11346002)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0681;H:CY4PR04MB0969.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 91RrdMNZQiXlGwy+XGApYil8LcpZcT7RgKEs0dU6Lw6J8x6ysJDQL/z+FCvnRcB1yrWa2lxoba19Ly3stqousfJDq7NtDCG+as3dd0IQTZZfwKJUjZgtOnV9VmhXKAwHLjj1jXmmILxrKoKuBtxUE1qwSSaYzZiTNsn3Yj3OINwOe1WnGsMCMpw5fmhDbDlBpVFUw4nZ6e89MlYEK5fYAEuxv2OSlaApLuFtQlINDUo85tIPyJg9jq7k77B8aWs/N5xDL1HaSCPNNYZLuOz/TyQ03E8Ai0MYXK2ezgUkZMbUcU549Gvzh93jl+4Hslt1dpqaWWhNGEkymJzfUf1lKLn2VYst6ldowCaR0gAF4UOh7dV67hBsdntN2TcftP19OiPnwK83GzIaxX0QppiV5XZTU5knL5aVyoj3Bc/DbJ8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588c5156-127e-4b90-72f1-08d70087f50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 14:00:22.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Arthur.Simchaev@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0681
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Pedro.=20

Regarding to you questions:
1) Yes , the tool's maintenance done by github
2) Currently in case you want test "UIC" functionality, please pull the PR.=
=20

Regards
Arthur

> -----Original Message-----
> From: Pedro Sousa <PedroM.Sousa@synopsys.com>
> Sent: Thursday, July 4, 2019 1:40 PM
> To: Arthur Simchaev <Arthur.Simchaev@wdc.com>; Bean Huo
> <beanhuo@micron.com>; James E . J . Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-@mx0a-
> 00230701.pphosted.com; kernel@vger.kernel.org; Arnd Bergmann
> <arnd@arndb.de>; Alim Akhtar <alim.akhtar@samsung.com>; Avri Altman
> <Avri.Altman@wdc.com>
> Cc: Stanley Chu <stanley.chu@mediatek.com>; Doug Anderson
> <dianders@chromium.org>; Evan Green <evgreen@chromium.org>; Adrian
> Hunter <adrian.hunter@intel.com>; Avi Shchislowski
> <Avi.Shchislowski@wdc.com>; Alex Lemberg <Alex.Lemberg@wdc.com>;
> Arthur Simchaev <Arthur.Simchaev@wdc.com>; Joao Pinto
> <Joao.Pinto@synopsys.com>
> Subject: RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
>=20
> Hello Arthur,
>=20
> Very glad to see the ufs-tool coming to light! I will try to give it a
> run as soon as I get free time slot.
>=20
> The "maintenance" of the tool will be through github, correct?
> I took a fast look at the Bean Huo pull request (especially the UniPro
> command part) and it would be very useful, if I get the time to test it
> should I mention that in the github pull-request?
>=20
> Thank you,
> Pedro Sousa
>=20
