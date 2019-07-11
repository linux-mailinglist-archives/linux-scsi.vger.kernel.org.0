Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3867651C0
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jul 2019 08:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfGKGPc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 02:15:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25399 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfGKGPc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 02:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562825741; x=1594361741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1YrGGyNlRB9hb3RBUHcYaJSdfrvxqWNsTUeEdON888A=;
  b=Jus3NN/McWoqKiTcVkIC41uAoWyQFnDtcxnHBP1K64+izr0gvptNTnKw
   UC0wEBQahvQbNlOLJaKPpVGUvLTO5GhnxT9hvEZI0wUoiW9vBnls1hSv0
   6poiMnzIXKsZO5W4uwteQ/Hw9pLWxhFc1vwlhbnZnKZeqOLG8nMJLVa+X
   o76SPSgLrhw8v3cn7e2LHu2AIeEnb+fFlSfT5jBFayBzdhywTaZ5P3TWs
   jmKvWt8O9nQjvg2cYV/ZbSoWzm7gZEiec+QAYd9/X9T9wONXWmA2HAt2n
   tsKdouD530k7jgItnLx2+dSbLzvWq1BZIntnGlowocASDST7W+I6iFCd6
   g==;
IronPort-SDR: o234wHZ08xdc7I7+V3mMEvsfOuTf9YxvzkzMQqfCEA/PaAlPyps2drwditFAiReTC/LF2FfOB0
 eimMOFB1aTtJdsy1mKa9I/OErI1/e/s7Vjl/oHt118ygNUh/b+0dEz5eqRPLXDU+vWaBG8VBvW
 ipSvQUG1ST36VlC1ZdntSYJoQcBFE78bWbaHe6gSxz/js3ORaz3Y/oLWLRNE2SKnT/C1ZMFFhS
 ndFdTdzv33L5aWupYjyZAvqA+19MQMile7mda0IDDa5cdeNkJXd8htwiCicqoled5gbmIxwZ2/
 srE=
X-IronPort-AV: E=Sophos;i="5.63,476,1557158400"; 
   d="scan'208";a="212667730"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2019 14:15:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX/A5UCiyCH9HbKlu2jcYbNg/3d2J5L+6SSUSukvsJUypjSIoPLweu7Wn859jnsAanJkos38I3SToRFsJRpyLPI/YHwZ5pY6vL0lljsCisfIMfrjSn2adVZpc1Kt/HXCGq7uWRGEW8Pl5BPeyY7GfXAQpvLbduDwxIemLm6YT4J3GO62OYEqztvHqGFni9s9jzUTaBZClMyzW6ZPMyOvy0tcMmvCLpVxXUJBiQ3966A2nH0JxfJq1vQfh2VpPeOw1iHcJR1OBMnDzhwcMbN7RnxF8AMb6cMrqcTU2m+8M7XBgRZa855QS97GuniFvMO9zUWRrFFKM3Ht5DmMNxFsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/spphAd0K8MM7F1/9AFl9NDmoF4CClkrJ4E2ZcsKmLQ=;
 b=dTyU83eFhrlDrZfdETGU8eodvso/AXw/yBMls161hEwCv+GdfzHO3Qi+PZ5XnWIuH3MNsJqQDkdk5On+iSO7pXLuhCRDOShWM56uppQZKjj5UwSEfQvBVPZtaLQmPgoKtPzr9NJZsvEq2ltzRQDJvDlb/g5FyR9/mrBRt/S4jUeVFHZUtQe8MpEHQFTRetgxi8n78/FqJdcR64IHuHdWGO62YAR5AREI0IMc9TwHQs+CqTjSo4dDL2V9Oj6f72L3zg5WV4PyKUccw0cTdUQV6tMythnP8ret13A0pFeuQ2Lz6YTPk0R6fWsPVHUAo9RmCvBYny9r6L+bH0iqFwXiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/spphAd0K8MM7F1/9AFl9NDmoF4CClkrJ4E2ZcsKmLQ=;
 b=D+VOK+kCqS1ZWDzvzHby2abGJe3tYXE9bwpiv32ufdhaVeMb7Lc7GDhw7gWmQVqCHN0HuMyW0O1v30YdlmAUHnJno3Txh11hvxPNM9UVw82vDvUcXaDDIIGxxlAgezkE5/yd71pBQ4Euqyp5il2kS9mufaQ6DvXqeiuOiWQfqyw=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5262.namprd04.prod.outlook.com (20.178.7.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Thu, 11 Jul 2019 06:15:20 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::541e:d74b:98bf:c319]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::541e:d74b:98bf:c319%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 06:15:20 +0000
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
        "ygardi@codeaurora.org" <ygardi@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "sthumma@codeaurora.org" <sthumma@codeaurora.org>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [PATCH v3 4/4] scsi: ufs: Add history of fatal events
Thread-Topic: [PATCH v3 4/4] scsi: ufs: Add history of fatal events
Thread-Index: AQHVNyTGnP9of7OWlUuyDLJWlYUyBKbE7K7g
Date:   Thu, 11 Jul 2019 06:15:20 +0000
Message-ID: <SN6PR04MB4925157680BCEE559ED6F038FCF30@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
 <1562765901-18328-5-git-send-email-stanley.chu@mediatek.com>
In-Reply-To: <1562765901-18328-5-git-send-email-stanley.chu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e9d2b2b-5426-46e8-01a4-08d705c72722
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5262;
x-ms-traffictypediagnostic: SN6PR04MB5262:
x-microsoft-antispam-prvs: <SN6PR04MB52625D007B9581F6CD1C0B8CFCF30@SN6PR04MB5262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(76116006)(66946007)(26005)(66556008)(66446008)(66476007)(64756008)(229853002)(478600001)(25786009)(55016002)(316002)(186003)(66066001)(2906002)(446003)(74316002)(476003)(11346002)(110136005)(486006)(54906003)(2501003)(7696005)(5660300002)(99286004)(4326008)(7416002)(6506007)(68736007)(102836004)(53936002)(33656002)(76176011)(9686003)(52536014)(14454004)(6116002)(81156014)(6436002)(8936002)(86362001)(3846002)(256004)(81166006)(14444005)(71200400001)(71190400001)(7736002)(305945005)(2201001)(8676002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5262;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j0aSW+m1PKWHBPlxb9OjZfK4YSjch5TLrSGzVREN4zLsZLEUrXQsNQ5KS2Y0s/mvOp2T//o2CPnGKgE7U8Bfmv6qW+2xlj4DQZKE7FAEmN56fmG6iSgKAt7dtcey8ymrrsDc6yxL3CPUrsxPYudK54piJAUPfDBTDPwvIevwpikYsn4TgK/gdDtMEJHejMFHZpQlBg2apW1aHP82YWO5KI7HPP6comnKmtD0Y6PpWcMeT4ez3S+pNR04namZtR79lKCOrUlmy/cvWzZObYfBO3xy8tE79CGh+6vfUbjYcygbcK77jgqDQO0xR+ZHgLc34T9KH01MwOANIbfBw4qAe7MmXkHNVi6kIFCUv01yH8xqtBqJw5CAa6CuPss9nQE9cgCNyM9FBJg0q0vc4ES5rK5FdENSNLRdxfNrCpDVYG0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9d2b2b-5426-46e8-01a4-08d705c72722
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 06:15:20.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5262
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

> Currently only "interrupt-based" errors have their own history,
> however there are some "non-interrupt-based" errors or events
> which need history to improve debugging or help know the health
> status of UFS devices.
>=20
> Example of fatal errors,
> - Link startup error
> - Suspend error
> - Resume error
>=20
> Example of abnormal events,
> - Task or request abort
> - Device reset (now equals to Logical Unit Reset)
> - Host reset
>=20
> This patch tries to track above errors and events by existed UFS error
> history mechanism.
>=20
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

>  /**
>   * ufshcd_link_startup - Initialize unipro link startup
>   * @hba: per adapter instance
> @@ -4356,6 +4372,8 @@ static int ufshcd_link_startup(struct ufs_hba
> *hba)
>=20
>  		/* check if device is detected by inter-connect layer */
>  		if (!ret && !ufshcd_is_device_present(hba)) {
> +			ufshcd_update_reg_hist(&hba-
> >ufs_stats.link_startup_err,
> +					       0);
So no device =3D no error, instead of ENXIO.
Well I guess this is a fair choice,
although less informative if the device stop responding.



