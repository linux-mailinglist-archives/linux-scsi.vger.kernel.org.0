Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F067D309CD6
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Jan 2021 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhAaOXu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 31 Jan 2021 09:23:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37358 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhAaOBn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 31 Jan 2021 09:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612101701; x=1643637701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BS8BGfrq1dJT5GZxyDK1Sv89fzYYmrqP6xvx+mP6DAo=;
  b=QZFqNuVkxxzW/zSUQ5vFiOO0hOe/kcEIYeYMqhDY6lkWkyRIXzPJE8Im
   BhB06fod3/vAYuXcxcuznqUCiP9gXLELJ3fA0U9UlTc4weLAas3MGwYaS
   b/Krk7MnyYFwPJN2w+zVcXLap2qSWgrVQH2FUTKVEz/2JWqlbn355DbnR
   OwnMjy+jaJt1AxedvSTUaETk3K+SLD305QlLw6mI8cjToFXU4d6ZraMH7
   1rB9QxOylV0ZSujc+WY/qZeMIL6b/D4iPurWDaFnLWbxvCR8MKhenSXdy
   c0AYOyMeSHipre//z8Toj98rrSXGCgc8HTAKa0dMcgG39GQ8KgHGEoPEs
   w==;
IronPort-SDR: ygyXPUKZKG3oZDYENr7E4vckWjxFhovOT9pHZ5lfVSoURtvjW83TMkVFLuuzALrbh+yfm3Ybzn
 OI84anvsaJCPEsp0jhLy8swZKLowgOp5BYA8yqif9Kw17LHeJjEhE/h3VUBELseH9IheQV1BT+
 MUnBzZjOWVTikJEwwyP+P1EoynKF3S8qTQUUHg2sBcGSsv0AyGUEEY2u7GygBIen7ygAwOPe6/
 qZxR/LHKExzFyMRcNmXH590TwAJXc6VedYb+Wb8lvJqCfcFEPH/Z+atJ3Lmv3Ld2XsciYNu2eE
 SXs=
X-IronPort-AV: E=Sophos;i="5.79,390,1602518400"; 
   d="scan'208";a="158741643"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2021 21:59:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjWeGR8Iqn3qNm4vdNivny/+17rPZhnHEi/G/C+R5QnASP5LlE2Qdpbml9TKdIjw9xXqUeEvr8DR/2GhJ2PM3WaIgZmbgRJR2O8MLbHJJK/r0FRfpXnRD9ZnQaqctwd91iQmsAgKAmaC33iHwFelIvzGSdVtlLchIMg0bC7qElbV+LNnutC7uNrmdK6r5XY+D3zpwg6vy0BiYzyTKrqJMfWHAMMJHhrBtN9H3YFfGmj/1nW16EBIxeK4ynMhd3cZUeOmOc+QFVC4WUa4We7tGU/TEx5Rrxy8vXWXcBHdlUtEh0hdEaEZQ8Fr3Ya6USxARKcNxMw94OpzYf9Dw9nHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De35CkTHFiD65pSRQI7cbhCBHD6dUS7gS834X9GJMMg=;
 b=nPJQdD6LaM6qiYTcbw+I1q82/KXraEjoDpoBKOPeZ8ggdyn0rjMxvlc4rA0zF1UyJR41m8xO/nXUqjO4V3ijqP5JP6+8cUftaSvq9eyUrRO4GsmsByfJXWoTv2RNJaKArhQPjVwV3iw6VkDxTLQCBVCyczakVgxpbFIscY7i2AAskvGqR5gGhK+JHyiGCYOGwMbO3IYzRE+LxIMx7UU3axr1ho/8swblkXKO4/Pw/UgYwuTSRSGCN0kXbNxq1klkPjCW/DGprFLurWNg3YYKnuAN8jxVNYwbeTgktUHneAuiSDvG+pnJwejtHXk0xXmdourAIID1C2Pbi3uMroOgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De35CkTHFiD65pSRQI7cbhCBHD6dUS7gS834X9GJMMg=;
 b=nX+xGfI7wz24vWsuEAV5uYdA4TQSZfju5vaPCHTK2sNjUCbSIVHCMdbMcf1gsrOuQNKLMQqR89fK5akEbgVMT3Sq9+Ych+0pKDnQVB3PUW5ZZaamapnez3HVuQNK32vxuRoTfoFQen8d5w9eoHMQpBDfcv4oU/SLkHknPNv4ug8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7129.namprd04.prod.outlook.com (2603:10b6:5:24b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Sun, 31 Jan 2021 13:59:56 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 13:59:56 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V1 1/3] scsi: ufs: export api for use in vendor file
Thread-Topic: [PATCH V1 1/3] scsi: ufs: export api for use in vendor file
Thread-Index: AQHW9ZZmo/O9RzKnuUyM4+Bc9yWaJ6pBxLcw
Date:   Sun, 31 Jan 2021 13:59:56 +0000
Message-ID: <DM6PR04MB657574D3D8B99F3A4997D810FCB79@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1611852899-2171-1-git-send-email-nitirawa@codeaurora.org>
 <1611852899-2171-2-git-send-email-nitirawa@codeaurora.org>
In-Reply-To: <1611852899-2171-2-git-send-email-nitirawa@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92fec424-57f3-4f03-06b3-08d8c5f07dbe
x-ms-traffictypediagnostic: DM6PR04MB7129:
x-microsoft-antispam-prvs: <DM6PR04MB71291882DAD3CAE52CF05ED1FCB79@DM6PR04MB7129.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zTsCHxkBS93p7Z6xUkvknHPg/+czPLMEzcsxP01X/m61yEJIVMZNv8eVLHmqWBaGWdTrTOCqpnovvic6qRtoa4V/PzcuyOvEDCXYBKDap7yAJc5VEWEvl216oYnKc6fpY+FDYtD4/N/qzkXepRxbk4j5dJBPeF1OX1PRzSrus1Yg6nFtLigQa+5ouvasyzXy0KAmLv4oTqvp1KjBLnKa/uEGRDuWLgEcPh0/2uwxePFw2yv9+TFKmc2YZrUsWjgPu7R7FwWHhQL+0ZAMpkWCNge78T037Qc5cqCx3pliYIBjjmJBrOYs+FYkTmR1UzgQ+uxkXqDa/pU7myR6sxqWQRnPTxnzXOsrcSiTfaOMpuMV+Gr0IhlergQOZP4tmzPshItwDuBDoLwr75ZTgS5LfuEySJb9G0Gbepf6Lw6fUpnWLUA+NfUWHbatyFyP+JQLvciMbRVjk93ufuhya1ArgvxNV/fKSnaE51Vgm8zQrDA33js6bHlE5z1yTm6jmE7zI5qdDvg9Giaam6whyXTVqWYYHE/zNC6JspCymWbej1BQiEywos6HsgzWBUlfiGM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66946007)(110136005)(9686003)(55016002)(6506007)(71200400001)(186003)(2906002)(4326008)(316002)(76116006)(52536014)(8936002)(66446008)(66556008)(64756008)(54906003)(921005)(7696005)(83380400001)(5660300002)(86362001)(478600001)(7416002)(8676002)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IBRnNmwkXv9yfyo9V35+oRQktXgof6wWftT5Bkho237PGmJ0fYCzx2w6v/Cj?=
 =?us-ascii?Q?gCDSJjZEW1jPvbsy4raXGBytFw98n7HZek7hPyQU3AlYQbdZ0WVXeMcpvMQd?=
 =?us-ascii?Q?PAYK1CP4ZaVC1hG/7hucbSq7+OTf6HbXTJvzX/+oF3dXB/m/W/5yZESNCj4Z?=
 =?us-ascii?Q?mJskF7E6ADsNyf3gI97GArzb31sA3Z9zz2BCMdvySyBsDvMpOzS2S7ZDcxLc?=
 =?us-ascii?Q?XgW/JcXI4VmrP/EMoGmkMeE25P9Wu1cC7BML7ZBfWCxX6N/s3z5LTltMXvx+?=
 =?us-ascii?Q?PujNqgzzrms5KQq3aCuWw3V5bcVfdM2Pd06Eo7B4VfKq5xEqu4gfhKLSouQl?=
 =?us-ascii?Q?pgNbjULJYshCkh3vSsjRCP32FcFJ2hm5kAoHdnCmufZ8CVaqFmN4AvfCi3js?=
 =?us-ascii?Q?vytq5/zq7QMiDsJCgZ20PIGwghkQUuPUQLnDEM0xzIQubwq8k+mZvqB7/o6x?=
 =?us-ascii?Q?jVaRx7kmy+JXJwDw3kP0uLyk/corM8Uvi8ioYCqle0kDmJTx/Klz/Ls4aUsR?=
 =?us-ascii?Q?F+cIjHi1++7RuhPnKN4JdCsjBLb12dBMw54Lo38Kx/X4JPkK4hKVjqDDa0xN?=
 =?us-ascii?Q?iZ88AUcbmwtGBGdk/NcP00gn44Q4k9KVIN7lg5tbCC63R/lSATVJRfQFJiMK?=
 =?us-ascii?Q?cbjw/32nzlkC/9Ck5qkB1gqGqiaILhS8mp1t2Kn1+/UNTw8JBdR1HRSbPHUz?=
 =?us-ascii?Q?tO7MItmL+p30fzd/q/3CT71nk5qecJf/fEBX6ZXYUKvmkDQ80Js/12zYrPiV?=
 =?us-ascii?Q?f11pzIP9o7grzJ/4nE5MDl9o0t+qKtI0yxabUWBXL4/+v1aBb7DlUeiZgqIK?=
 =?us-ascii?Q?31GXelVterXzlmq7L3QWP5rlf7wkgde+gXFdQPZooqS7ck2JqDSbevMbic7j?=
 =?us-ascii?Q?GIryLOOKyCaWtY4WweX99JFdcNcZIeUF4xQzCJr32/fIDUslJauGgcvs4q8+?=
 =?us-ascii?Q?Nrljp6DuynSTRUFJ0FCUFl7RWqnlMeaCA5agdrVwmnziOeB7FRVE+anwuMsU?=
 =?us-ascii?Q?AJHCqcgT8IagxjDzVV9Wp3hbSVOHfKmwPxIhe4BYM+Ypi2Hy9GDrYfxfsE3b?=
 =?us-ascii?Q?vPHaFUAl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fec424-57f3-4f03-06b3-08d8c5f07dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 13:59:56.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGo2kpJIxNBMDA0FnmNFeWJfXHy6PqiZj4e+ne41aXZWQZyVANG3KpIBKukDfrlP25IcgTSi2su7W7gPoLhEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7129
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>=20
> Exporting functions ufshcd_set_dev_pwr_mode, ufshcd_disable_vreg
> and ufshcd_enable_vreg so that vendor drivers can make use of
> them in setting vendor specific regulator setting
> in vendor specific file.
As for ufshcd_{enable,disable}_vreg - maybe inline ufshcd_toggle_vreg and u=
se it instead?

>=20
> Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 9 ++++++---
>  drivers/scsi/ufs/ufshcd.h | 4 ++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 9c691e4..000a03a 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8091,7 +8091,7 @@ static int ufshcd_config_vreg(struct device *dev,
>         return ret;
>  }
>=20
> -static int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
> +int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
>  {
>         int ret =3D 0;
>=20
> @@ -8110,8 +8110,9 @@ static int ufshcd_enable_vreg(struct device *dev,
> struct ufs_vreg *vreg)
>  out:
>         return ret;
>  }
> +EXPORT_SYMBOL(ufshcd_enable_vreg);
Why do you need to export it across the kernel?
Isn't making it non-static suffices?
Do you need it for a loadable module?

>=20
> -static int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg=
)
> +int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg)
>  {
>         int ret =3D 0;
>=20
> @@ -8131,6 +8132,7 @@ static int ufshcd_disable_vreg(struct device *dev,
> struct ufs_vreg *vreg)
>  out:
>         return ret;
>  }
> +EXPORT_SYMBOL(ufshcd_disable_vreg);
>=20
>  static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on)
>  {
> @@ -8455,7 +8457,7 @@ ufshcd_send_request_sense(struct ufs_hba *hba,
> struct scsi_device *sdp)
>   * Returns 0 if requested power mode is set successfully
>   * Returns non-zero if failed to set the requested power mode
>   */
> -static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
> +int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
>                                      enum ufs_dev_pwr_mode pwr_mode)
>  {
>         unsigned char cmd[6] =3D { START_STOP };
> @@ -8513,6 +8515,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba
> *hba,
>         hba->host->eh_noresume =3D 0;
>         return ret;
>  }
> +EXPORT_SYMBOL(ufshcd_set_dev_pwr_mode);
>=20
>  static int ufshcd_link_state_transition(struct ufs_hba *hba,
>                                         enum uic_link_state req_link_stat=
e,
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index ee61f82..1410c95 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -997,6 +997,10 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba,
> u32 attr_sel,
>                                u32 *mib_val, u8 peer);
>  extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
>                         struct ufs_pa_layer_attr *desired_pwr_mode);
> +extern int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
> +                                               enum ufs_dev_pwr_mode pwr=
_mode);
> +extern int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)=
;
> +extern int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg=
);
>=20
>  /* UIC command interfaces for DME primitives */
>  #define DME_LOCAL      0
> --
> 2.7.4

