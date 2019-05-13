Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193F61BD19
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEMSVg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 14:21:36 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:6484
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfEMSVg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 May 2019 14:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z+Mn+lb73jmCGFVT1Pk/z//+SLoGgNMe99zjJuR7Q8=;
 b=sK3HLb3cuMqVBE9El25ZGrDXGs/TS4n/FZylNfxPHNz3so9rU8hBeQh33WEzuBnrqp1esAIqYryOK/NnSvupWiMuuZFfXYdzU+ovwScyjPO/sPEhcCjocMx5bNKcrCW38IMpzcrxcYhDN/huxxtQmwrNdn2xKNPN4ul7h88pPjg=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB5537.namprd08.prod.outlook.com (20.176.29.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 18:21:23 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532%4]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 18:21:23 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>
Subject: RE: [EXT] [PATCH v1 2/3] scsi: ufs: add error handling of
 auto-hibern8
Thread-Topic: [EXT] [PATCH v1 2/3] scsi: ufs: add error handling of
 auto-hibern8
Thread-Index: AQHVCZlJG8f+B7maOUSAPf/KvWjoI6ZpV6KQ
Date:   Mon, 13 May 2019 18:21:23 +0000
Message-ID: <BN7PR08MB568438668FC7C90A1284F53DDB0F0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
 <1557758186-18706-3-git-send-email-stanley.chu@mediatek.com>
In-Reply-To: <1557758186-18706-3-git-send-email-stanley.chu@mediatek.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.80.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e905364-6b9e-4550-d84d-08d6d7cfce30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN7PR08MB5537;
x-ms-traffictypediagnostic: BN7PR08MB5537:|BN7PR08MB5537:
x-microsoft-antispam-prvs: <BN7PR08MB553757C2B02303588760BB9EDB0F0@BN7PR08MB5537.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(110136005)(99286004)(54906003)(229853002)(73956011)(9686003)(256004)(74316002)(66556008)(14444005)(66476007)(64756008)(66946007)(66446008)(2201001)(5660300002)(7416002)(4744005)(86362001)(7696005)(6506007)(76176011)(76116006)(4326008)(3846002)(6116002)(53936002)(66066001)(81166006)(81156014)(25786009)(102836004)(316002)(55016002)(8676002)(486006)(71200400001)(6436002)(52536014)(71190400001)(14454004)(55236004)(33656002)(11346002)(476003)(305945005)(2501003)(2906002)(68736007)(186003)(7736002)(446003)(8936002)(26005)(6246003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB5537;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6A+z/BY7l3S1p8EMS/pDKFxtSp1S5N3L524N7fxBTRSZtpBL8ni0j6/BsDr1sy/RiY2qP5Gvo/2L/qYDvEx/PWg/fYNyQ6TG+/NZHVYeIXTz1GtmmZjGFKlkuLU5MyNpucxPWYgnR8CS2Il3koCZpdKvgrO04zoz07MORhN2C8/W7hLmI31PqqQpoodEhIaVtOt1Gm/0VYvQ2jKscAkeXITG940YgrysBSUNCd1lPa6rYBhWFF/YQBl1VA5G7IfCbUyQr61zJ9nlWXydACmC8vwRWodfpBhyfvkr5OSA7pneMXZxMWJQ8NrWHIsMJPFSeKRRI2+wKMa2r0I3nrvwJUH1r653QyGCIvSTsDbJYL/E/KwwZj3Gh1ir7CsYz7NFCxs5/3bfnyW4xz2NPsr19B63ePQgPDt2rpmzvBzxTlw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e905364-6b9e-4550-d84d-08d6d7cfce30
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 18:21:23.5594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5537
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi, Stanley

>+
>+static inline bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
>+						u32 intr_mask)
>+{
>+	return (ufshcd_is_auto_hibern8_supported(hba) &&
>+		!hba->uic_async_done &&

Here check if uic_async_done is NULL, no big problem so far, but not safe e=
nough.
How about setting a flag in ufshcd_auto_hibern8_enable(),

I concern about how to compatible with auto_hibern8 disabled condition.


//Bean
