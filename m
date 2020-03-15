Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA8185877
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Mar 2020 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCOCKL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Mar 2020 22:10:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37354 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgCOCKK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 14 Mar 2020 22:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584238210; x=1615774210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ffzs/j17EKw3jqq5Jg4iahkqMhMTWcgIy4/HKUbCt0=;
  b=d4whsut4xlQdGSZ6wJQhDxTTl0oJJN6MTgbPNilz1/KnnnJy+3s5TX9g
   GG3YkAN2GLJZAb15r4zbFUTCkPIkn0bvQtHEC+CXywTsg/ChjZUh4WqGY
   30xt0oK7of3WYG3ZSl11gN6w8ekfkQFC+u0s60ohP+Q/XbKg151D1smJg
   +lAEK+OMEN4BRsQWNEJjS7t4Wxw+wOf0Tq8ceTNukuhTI0rHGFGX6cHCS
   1/sQFd6cVH6HZxk3laxOZT3X58ZmCZb1zpbmUPtcpOSnLWk83MaTYxf1I
   roJac1vS6MTXGbR66xFaVgYiby76jJAVprWsh+xK6P52br+9wD1imeWDp
   g==;
IronPort-SDR: hGpCbq1j3xPCOVsqmeXkHSrrxQ3t2WpqhMK/aEU2d53gjlnoiKdKG+prZXbPWdobYG0Bu0XAa8
 hdwwVEPSHVwv+u9EiULSpOefAGkpo/TnTbdnIGor7Po8tylAUVKeOvr6qWFBhOoPqF4hqWg8Wg
 eKiICgSNVSoQgcY0eF9O0lmGA/2yOJ5MPhmQCmFIFE7GsCiM3xUynlMoHYyoJE90hWRGLbRCai
 CJMF5lzgG17acBoz42VhaFkED9IVHmkJLnS/s81vHxAZZiinyAgXsCxzb2lpyIN2NXEzOMEqCK
 L8U=
X-IronPort-AV: E=Sophos;i="5.70,552,1574092800"; 
   d="scan'208";a="132919508"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2020 17:47:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWDCP9lFZ+IhcQnJU9WN9dt19kUZz2dA0R9eODx5C1V587zOV09ZkmIyGkYtHGVc0+A4i9Ka75EU1joq7pDqtWO9KgGL3jsNtQyKKkf3pBYo+ZRf2SrI4caXw3L081u+HWPWmdUWu3qjo7EZs5P9+sa63j4lXnsu+tGSDgYTESm6xU+6wgDnwT2/L4cHbAMvgiSuJA1wjuyf8J4QZXqDXpIESWIsJeWExLf3/Z37UiarU85RLCiViiEB8jDbwxpnYNjfy7S4xsiUDKyQuEuDU1bptei4FlRhDXUZBXzp5mhtOladHrwfhdyG0LgO2QU53XzJroqUab7uG/5VSN3qKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNjOe4QFYL4DkY9KX/Fj1W3iiZnHL7bjGaLr0pDt4Dk=;
 b=T6oR7rZrU5j9OIOR3tcNqqgdW/cTBxK6/1kMU4uU2E4dbG9wK28QcU7eN4j1TNtr6kzOK7bw41wO4mpEHtvH0s+Mezxp7xXW1GAyv2L4H8zaNwMKLpMImAMdQ7AtCw4lI/TreKcBL/9GSAsjiIlYya+xLlACzI1p8pojF+f4q8RrLAkI6MGVM/m2ldAbtxTfKJ18noAAGuwjVKYx0cnEM9uiHlmSs0nTINgVtENjPSfnxiVQE/aEp2tI/Qn3fxjy9KYf5QX5vAj9b1DpFCj/MZ+OTHmNSGjZQ5uQY7EYTWwKeBCFIbji7XO4/EQCzHnMk7a62kKk6xxW1pF78cfLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNjOe4QFYL4DkY9KX/Fj1W3iiZnHL7bjGaLr0pDt4Dk=;
 b=HMJvo6W0ixVzsojGWVh4Kf5nhQev/AFuRR7OlrWwtzK8YI7UY7E/kSOmp0HjLxOBMykneq1H56NuYEjiP5iJ7ukgDuQukMdXQlNVhYDI9hO99hcpELatJLzck9e8ehFDiaAmpgReFOidaS8p55ETmGxzfAxeD6q4EByN8WXRboI=
Received: from SN6PR04MB4640.namprd04.prod.outlook.com (2603:10b6:805:a4::19)
 by SN6PR04MB3888.namprd04.prod.outlook.com (2603:10b6:805:50::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 14 Mar
 2020 09:47:02 +0000
Received: from SN6PR04MB4640.namprd04.prod.outlook.com
 ([fe80::3877:5e49:6cdd:c8b]) by SN6PR04MB4640.namprd04.prod.outlook.com
 ([fe80::3877:5e49:6cdd:c8b%5]) with mapi id 15.20.2814.021; Sat, 14 Mar 2020
 09:47:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [PATCH v4 0/8] scsi: ufs: some cleanups and make the delay for
 host enabling customizable
Thread-Topic: [PATCH v4 0/8] scsi: ufs: some cleanups and make the delay for
 host enabling customizable
Thread-Index: AQHV+RX9jRrM0tPTvUyCj9SJPGT/n6hH2KzA
Date:   Sat, 14 Mar 2020 09:47:01 +0000
Message-ID: <SN6PR04MB4640CB68C9FBD3702A30CE60FCFB0@SN6PR04MB4640.namprd04.prod.outlook.com>
References: <20200313090103.15390-1-stanley.chu@mediatek.com>
In-Reply-To: <20200313090103.15390-1-stanley.chu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [2a00:a040:188:9241:146e:dac0:a78:a147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf60fd2d-018c-4d7c-0053-08d7c7fca588
x-ms-traffictypediagnostic: SN6PR04MB3888:
x-microsoft-antispam-prvs: <SN6PR04MB388884A49096928D9C0AB07FFCFB0@SN6PR04MB3888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(2906002)(5660300002)(478600001)(52536014)(8676002)(54906003)(110136005)(316002)(186003)(8936002)(81166006)(86362001)(81156014)(7416002)(7696005)(33656002)(4326008)(66946007)(76116006)(6506007)(55016002)(66476007)(66446008)(9686003)(66556008)(71200400001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3888;H:SN6PR04MB4640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTlegNq6FYpA5UUlB2BHKQI7OyoC2Um5sRs2tMZisW1c0uKo9hGxYhg5iuahGqbon63e4ruXnm18KMkHSXXN0EG2SqrpOrf5VasM0DGUL1kRl6QVVqZ4jfPq70pysxUPEkKxU4FyiF0W6JNQwtrsSIVvemx8BR04M8993Synuy7WUpXWz8MzfgaSpTfANMOBRRQG55+qRSUwagxhKeJJhX7l1twQdBFHJNrQFD16y9lBcoNAnHf7TL5qqMjYnklljNc8R5Gifa45sg5bHswKuoV8e+PtjIFWE8HDJgVspR0kaUz83htZT1Kx9UvAPEaT41EZMsWgPF5KgFDv9fwJt7glZeLdybnKcbs1rNjAIOSvOLKOlrGjTyBdljGtsNHcshOPbGpQXGac7fE3ql931SI1qrEl9SeOwmgLexp6P4TSqIuCSkXHhGtGJ7SPl9RN
x-ms-exchange-antispam-messagedata: +pLH3gVuV7sE9tz4NXeE7bsnt59xOVTJhTo+tPMxEJgxU/6pEih8aXamGQ2zrgagVyjRL22hg7t097SgiEka0irBC1hqr9lUn5zjULfbxhB2xF31IqdV36fr0+HxxmnUkbMHf3CdeCMTIwbA6RY+Kz41WtmeAJB+r3B2JBmau5xtLdm0XwARZV2pDaGX9naMWrp+owmSViz5rZHNhPQrkw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf60fd2d-018c-4d7c-0053-08d7c7fca588
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 09:47:01.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndJJzruuu5o/qYz3VTOcgtcNnsPgE9pENeLhaLCShyxuULgasTCz0o1ckGdgPcDpYmq7G+RtW4MiFbp7AIPdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3888
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good to me.
Thanks,
Avri

=20
>=20
> Hi,
>=20
> This patchset applies some driver cleanups and performance improvement
> in ufs host drivers by making the delay for host enabling customizable
> according to vendors' requirements.
>=20
> v3 -> v4
>         - Collect review tags in v2
>         - In patch #8, fix incorrect condition of customized delay for ho=
st
> enabling
>=20
> v2 -> v3
>         - Remove /arch/arm64/configs/defconfig chnage because it is for l=
ocal
> test only
>=20
> v1 -> v2
>         - Add patch #1 "scsi: ufs: fix uninitialized tx_lanes in
> ufshcd_disable_tx_lcc"
>         - Remove struct ufs_init_prefetch in patch #2 "scsi: ufs: remove
> init_prefetch_data in struct ufs_hba"
>         - Introduce common delay function in patch #4
>         - Replace all delay places by common delay function in ufs-mediat=
ek in
> patch #5
>         - Use common delay function instead for host enabling delay in pa=
tch #6
>         - Add patch #7 "scsi: ufs: make HCE polling more compact to impro=
ve
> initializatoin latency"
>         - In patch #8, customize the delay in ufs_mtk_hce_enable_notify
> callback instead of ufs_mtk_init (Avri)
>=20
>  drivers/scsi/ufs/ufs-mediatek.c | 64 ++++++++++++++++-----------
>  drivers/scsi/ufs/ufs-mediatek.h |  1 +
>  drivers/scsi/ufs/ufshcd.c       | 47 +++++++++++---------
>  drivers/scsi/ufs/ufshcd.h       | 78 ++++++++++++++++-----------------
>  4 files changed, 106 insertions(+), 84 deletions(-)
>=20
> --
> 2.18.0
