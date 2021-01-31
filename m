Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B04309CDE
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Jan 2021 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhAaOYA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 31 Jan 2021 09:24:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37617 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhAaOD1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 31 Jan 2021 09:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612101805; x=1643637805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gseb56BKRDUAHQwFgeHZtPKi4gNsQNw0mgUD7MU+Ps8=;
  b=qzlYLJf3sq0PJTvQxEJ5G3kngsPEVhoIS+2s3xDhRn2tt2z5CkCsOQwI
   UjfXyauyKFuRP5mkzDEhg1mUq41mHCWUflHWIO+VcHgmGH1hwTtaRTyqg
   EXoEmVBF08k9+9QyFGelSa49HOKUDhSnSWCsR2JEWsWJj9kk/lkuAlash
   jkNHws2m08l9ICYkFpfYqXwa0w0P6Mnn1QHuUGeGLoAuAmLaUWRvy6C+h
   TK9yXzBia6Kz2ORzrFLTZ5zMIllIvpcTgQhUf58sBXybPtjaOYD8y7JZN
   ZXcU614Jbgtb4UuSPbk1KSX3ndYgSBx2Ffcy51B76xBiYV0PSo01yBz0L
   Q==;
IronPort-SDR: MHOYHFiLNm6kx8UTBzMp9T90QjgezWr3FKv8vD2z3Tdlpas8Xixrbz3bNNItJGU/5Zgt1afeIF
 zh/ZpME2GoLv3XMI2HFGkT1QRTqHTSEY6GAa3+pNje7l/9XbucZEEK3C+ExZMiooHKwlo41ato
 um24/6l++/nZlMJH3zXjmD1krDDadiNVaHGTzaDEW9yNlHfJt2cRVn2lxuUTympy4EpEvnSBUR
 /YSor3c4p5vpppMGKEJfM5PEL+UKE5Me4p8uF2pKoaa18niTP7wFQAYkeEyL/sCNZnb8zRXc+6
 Aqo=
X-IronPort-AV: E=Sophos;i="5.79,390,1602518400"; 
   d="scan'208";a="158741773"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2021 22:02:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwedgGipTNVFPoQiKGb4GyKe7Shqs+X8ETQ5bGEHta2qyRWGQBFBXfT0HZ4csTgIt/1sXuRTMth5z4WSM6KsN63bUMCZEP5/IlPy1+VEjPTiXk87HCZeZ2yyFkvhvzFPQQ7/TFWOxudv+LXfwsC+FNiWSDHYkN2TiKE3geFf5kcDwIxuFDblGyKiDdIGdCxKezTBLcDuZcaiZEPE3KgPIWydc1sc2x0bryfzzsx/prUms/qf/iejz/vBR2IsD/ShIof115Nm62wdLfCC5kj2g7Qz4waAKQ70+/zJZf9UOL3IEy4iP0X5cZvJsGXG/Mh2iwSrO9G5+NqoVovt9dTriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wujt4MOWscDpIYXXNA09O0ZEpAYy75Nx5u33g36FF6g=;
 b=AHR18pTcsZpaArxXHieEwS6C/Gp6FU4Gl7J82fBwfymSfJt/GGQ7V9NdJj6S4DQltpA+ZzN8QlrESBO72h/h7aurwni7H9XIIOEVI1AB6P4gdmHUQI/CHyzmCVW3ihMaNeUE4PNX2C4WUH5oIL4lKAveRlSblpnUdCa6ZDcAAEqTIcouESGBYVbGA9Cb2u9nE6mJ73e2Fc5I7jucQ/QYlr3FWN5pQUB2W3zeFqCyeufLMM6Z2rXFMyCpwvbxe8L18iPi+LSe2C23ruBdC7cwORrYcp4Rp5avvh9AeCvxSVmA1FIUCcM/UyS1gbE6YJGTX4XwCjCX8q9Dn+O4EWj9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wujt4MOWscDpIYXXNA09O0ZEpAYy75Nx5u33g36FF6g=;
 b=QhScjKt1FehEQ/Verg5OPG5OJkkod91WlQRyUkDcf4tlaYlYzC7NTH9970uRiyM82UGmXpMkN/TnNW1uKng7BYSOEBTjZcOAL9ASSh6z7MikxfhutP5/843fTblEgrXyyUmi9lCxFb2IoXXdslEcRQNfFg9kHgXpsfvdstFTGDY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7129.namprd04.prod.outlook.com (2603:10b6:5:24b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Sun, 31 Jan 2021 14:02:12 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 14:02:12 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Nitin Rawat <nitirawa@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 0/3] scsi: ufs: Add a vops to configure VCC voltage
 level
Thread-Topic: [PATCH V1 0/3] scsi: ufs: Add a vops to configure VCC voltage
 level
Thread-Index: AQHW9ZZmeK7PA8AawUSfMfIJOx/dhapBx6jw
Date:   Sun, 31 Jan 2021 14:02:12 +0000
Message-ID: <DM6PR04MB6575D0348161330D21A9B6C5FCB79@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1611852899-2171-1-git-send-email-nitirawa@codeaurora.org>
In-Reply-To: <1611852899-2171-1-git-send-email-nitirawa@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78840d30-e7b7-4157-56d0-08d8c5f0cf0b
x-ms-traffictypediagnostic: DM6PR04MB7129:
x-microsoft-antispam-prvs: <DM6PR04MB7129320CF57CCA0A53B5CB33FCB79@DM6PR04MB7129.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTQyAyBY34kk6pMu9UF7eLNh4A4h525e4M4vbSHxnx2CoN42HLH8LA3bGBbS47LIOqYChyqLeKDlfLzTT9GnC01LtILxW4Hfn2xUMB981ftzpnYJxSdwBlz2LcQcvGNTqujnGc6wy/xJU/MIwPe/j1Xv+k3aB+RTTeJrtFx49bh2NILYa7HV+vHFgI5JxpBH2dm82zE89nVHxyq6lb5Z6WOE/rT6mHPWwFU57col1wtqmdLL6wdEhaaNtuSPd2aBeAVaBnL+LxlgdSxDB+T0CYZcNoN8nX9xKDkgpc5krtmvsTYbZFWcOkKHENgy2rSUTcPFwQziyykA/3/7j8ASwxgSPHKyrvU7k8a6GVqOzMXfOoG1UKlGUEJLBV/oGCsibB8DRXW1WaSFqboo6TBT5QRTSN9VPuJaEgLkvZi9qA+82rw4YuSAVbjnrtvNtjQC9Xbttl8Gb8RoeU5ENQDFqJ0IFIKh3PEObOkVrYDwwYDle1rNnv30aC78+RhiDSnmwgm2wFcpxyQntbMNKyf08+JSQyTVMDa9mPAhZUtACrBV6A+oahjwxvOU3y/CIL3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(478600001)(7416002)(26005)(33656002)(8676002)(5660300002)(86362001)(186003)(2906002)(4326008)(110136005)(66476007)(66946007)(6506007)(55016002)(9686003)(71200400001)(66446008)(66556008)(8936002)(921005)(7696005)(64756008)(54906003)(316002)(52536014)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YSTcidjOLHNdvXST3QSEb3J6d15WMpcXI5PeOyYaqhm9yFdY/6TwW5R7chGa?=
 =?us-ascii?Q?1DPvIqIsEpUM6wJ9GQw12H41iHHNbiZekYVjzFUYMuFa+C100fI5KJMlOSio?=
 =?us-ascii?Q?t4awGzzVND1z6Dk2PENGfW2y35Ed6BCrhXW8A15H88CyRU69kLKkPC+aOkzo?=
 =?us-ascii?Q?ZMY/OEiNOHplUHCLApnd08WhbK+39Fx4aHTUPjr7lynt73LdMqaO8aooamOp?=
 =?us-ascii?Q?bQhHST9YG59f8DMfaDvAEcJuq6gOZn10TU6/87wqS6mU84EgHI764uq2pA7N?=
 =?us-ascii?Q?ofHK72wmA2REvyWKqnZPybP9Kq0FK8Z9yJ+k8cFdF4w/Sik9c5YpvbXl6HLC?=
 =?us-ascii?Q?SUSvQD4KDpGooJ9xEFGwDRPF9J/b+O9ss/TbezBnvKvAID7noIJB8ySXl6y3?=
 =?us-ascii?Q?BNvrry7W4E/m1zs2gVV1sSWOW/L8xgPkAqrjN5+NvQcoM3HvhVsnMcnOM3BN?=
 =?us-ascii?Q?rv/rYvLfKcPVHkdutjQ0fkbDAVelQZOSCbqsv23AGNttGxQCRrzrmxO8g/AQ?=
 =?us-ascii?Q?HjWKPio/95xmj/G6RQZTar1EfDoT2YVDs266zuqe3ycQ/bIHSqrP/M6uCL8x?=
 =?us-ascii?Q?uW5UpKxy/cpwj0g6rs6N/W0rXw/TIUEnvhJ8MCt7EmI1hu4HVkJxOk62Cz49?=
 =?us-ascii?Q?OE/XcJq5dXU8wEXtm7e/kHC5a3Vv70TrA12tMrfHPBm6OUu7GzW8ZiGhhXny?=
 =?us-ascii?Q?yQRY5uO92CN0XgeDs0gKc7ciqRLx7/bJXhsouShjm3tTaxYEE86z+Nru6uC6?=
 =?us-ascii?Q?OkifIgvi0/sJoLaFydWuFe4t1r8keFodMBDNggGjz+Mtmn04eMQNQEy1jQdr?=
 =?us-ascii?Q?r7WbA/9FCvzrdXjTXUBZnzzlNOdDecwc2PJsrmBF47N6dT58qhjMVmGYbklX?=
 =?us-ascii?Q?P3Hkjp/naIPsYeGeCMD5cLCKtEA0qJsvlZsWx5AmHdBsnADhAzdcLXvoHlfP?=
 =?us-ascii?Q?eo2jDvBb/mOY1PyOsYurLxK1ae2zLlSCn8Wnky5pIqi4wmTO52oidfK3RCys?=
 =?us-ascii?Q?Ydx+biGcCpSBa5e38s0QA/ZN2iBwvv2a3K6JXn0CZQmEVkKTBF3XsQdLWGny?=
 =?us-ascii?Q?1fxqYgih?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78840d30-e7b7-4157-56d0-08d8c5f0cf0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 14:02:12.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjIuSDwKa7hU7wUUQhGeXvQ99ezMLZ74m1Gsn4irPE6k692ffasCUmcXOiCEUXgL35n3wL9PJc42UakuideftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7129
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>=20
> UFS specification allows different VCC configurations for UFS devices,
> for example,
>         (1)2.70V - 3.60V (For UFS 2.x devices)
>         (2)2.40V - 2.70V (For UFS 3.x devices)
> For platforms supporting both ufs 2.x (2.7v-3.6v) and
> ufs 3.x (2.4v-2.7v), the voltage requirements (VCC) is 2.4v-3.6v.
> So to support this, we need to start the ufs device initialization with
> the common VCC voltage(2.7v) and after reading the device descriptor we
> need to switch to the correct range(vcc min and vcc max) of VCC voltage
> as per UFS device type since 2.7v is the marginal voltage as per specs
> for both type of devices.
>=20
> Once VCC regulator supply has been intialised to 2.7v and UFS device
> type is read from device descriptor, we follows below steps to
> change the VCC voltage values.
>=20
> 1. Set the device to SLEEP state.
> 2. Disable the Vcc Regulator.
> 3. Set the vcc voltage according to the device type and reenable
>    the regulator.
> 4. Set the device mode back to ACTIVE.
>=20
> The above changes are done in vendor specific file by
> adding a vops which will be needed for platform
> supporting both ufs 2.x and ufs 3.x devices.
The flow should be generic - isn't it?
Why do you need the entire flow to be vendor-specific?
Why not just the parameters vendor-specific?

Thanks,
Avri
