Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD31EB99
	for <lists+linux-scsi@lfdr.de>; Wed, 15 May 2019 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfEOKD0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 May 2019 06:03:26 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:16193
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfEOKDZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 May 2019 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr/uAY0iWx3uH1mnSXPkUxU9OMotqiEfy7YjeCTLLwA=;
 b=wJz4QJFMpBR7U3UxQPJPUj530Hs9ng7K8rPwwSPUZDmCDJVc792cnckKtXHJLe79xf/HWH8zrsZgmOKht5kQ69LYzDd038sbhXkqtylvk2gyYi0y//Q90AfhVGy4OPGZYrmqmsdPoddg/XrK7i9Phm1rUnJy16RAARHJaxkO95g=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4161.namprd08.prod.outlook.com (52.132.222.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 10:03:21 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532%4]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 10:03:21 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [EXT] [PATCH v2 2/3] scsi: ufs: Add error-handling of
 Auto-Hibernate
Thread-Topic: [EXT] [PATCH v2 2/3] scsi: ufs: Add error-handling of
 Auto-Hibernate
Thread-Index: AQHVCwG9zw5ZZRItY0K7gltI9BKRQqZr82aw
Date:   Wed, 15 May 2019 10:03:21 +0000
Message-ID: <BN7PR08MB568475028C7E94A333ACACDDDB090@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
 <1557912988-26758-3-git-send-email-stanley.chu@mediatek.com>
In-Reply-To: <1557912988-26758-3-git-send-email-stanley.chu@mediatek.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.80.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef4933b-0d9e-43b8-9c9b-08d6d91c8fad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN7PR08MB4161;
x-ms-traffictypediagnostic: BN7PR08MB4161:|BN7PR08MB4161:
x-microsoft-antispam-prvs: <BN7PR08MB4161B0D04056ED22F1473DB5DB090@BN7PR08MB4161.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(366004)(376002)(199004)(189003)(558084003)(305945005)(7696005)(71190400001)(71200400001)(229853002)(2906002)(6116002)(25786009)(316002)(66946007)(66446008)(64756008)(66556008)(66476007)(66066001)(76176011)(2201001)(74316002)(53936002)(86362001)(7736002)(99286004)(3846002)(9686003)(486006)(33656002)(476003)(7416002)(55236004)(11346002)(2501003)(4326008)(54906003)(110136005)(478600001)(14454004)(55016002)(446003)(26005)(6506007)(8936002)(102836004)(8676002)(81166006)(81156014)(14444005)(76116006)(73956011)(256004)(5660300002)(186003)(6436002)(52536014)(6246003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4161;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: alu2oFiygNWeqoiaWdsc+1syvb16N+Y8QG6NMBEDP6kZRR8yPegXMghrY1TpLyCe0Cmyzf59i3yXFNEbpJPLSetgVYUh1T8+olyFg3LQKUGaodO+ZHLlgs3VqiU5zTsRT7VQdUWk7L/2/h1ueC4ZmXJwxgR2vB9h8XLFwUBbt0lUsOIBhtMSYviLs4GB5eyIJHwcVnE0bhcpfuq9sP6nogsHwhqGfdm1teYq1Xo3grBaYzJLgC5CvigQEmSFZFSF9z9dANr+BsFS+rtplBvkGSrkg612TUxLuiLnt/chM1oQtkS4y7+hJDhXlxkFElve/an3qg13e/JMOn4udlGhy+VgMb1fHqPel78ALkhSwSuHzZoK9yWcnOkJY0hASpNIiBmKOIg7il3PIsnFQKHhNfERAqLenoSOJE1yI5ym0rw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef4933b-0d9e-43b8-9c9b-08d6d91c8fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:03:21.1026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4161
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi, Stanley
Thanks for update.

>Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>

>2.18.0

