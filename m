Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C845F74C
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jul 2019 13:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGDLn6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jul 2019 07:43:58 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:51917
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfGDLn6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 4 Jul 2019 07:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL0MffnH/K68iCfyGWbILxpR5kgJo/55+JosbuLVVGI=;
 b=ADCBDPcmVC0/JJdFW72TCD3qGH6NlHkkDo7RfG2nomXIZ+L4TYT2Ck7FhXA71BUW4oWTwBMS5UNqS4wY87csyQfXY+bVuOKecUcQT+DRFEinPETCVVivwjgdqrX55Q3SN7Wsq5A3MhRMznDuO1gRIWZHzSxcL0kIXruCTK2lbyw=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4372.namprd08.prod.outlook.com (52.135.251.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 11:43:14 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0%3]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 11:43:14 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Pedro Sousa <PedroM.Sousa@synopsys.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-@mx0a-00230701.pphosted.com" 
        <linux-@mx0a-00230701.pphosted.com>,
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
CC:     Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Arthur Simchaev <Arthur.Simchaev@sandisk.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [EXT] RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool
 v1.0
Thread-Topic: [EXT] RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool
 v1.0
Thread-Index: AQHVMlT+ykLyY5FioEuDavl9kb+FgKa6U0VQ
Date:   Thu, 4 Jul 2019 11:43:14 +0000
Message-ID: <BN7PR08MB5684FC6EECF227274B6F58E9DBFA0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
 <MN2PR12MB316796A709A4A0358D530A3CCCFA0@MN2PR12MB3167.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB316796A709A4A0358D530A3CCCFA0@MN2PR12MB3167.namprd12.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eff0707c-b06e-4cc9-f13e-08d70074ccbe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4372;
x-ms-traffictypediagnostic: BN7PR08MB4372:|BN7PR08MB4372:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BN7PR08MB437223617F9BA31FE3978C7ADBFA0@BN7PR08MB4372.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(13464003)(26005)(11346002)(110136005)(316002)(68736007)(6436002)(74316002)(76116006)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(486006)(102836004)(55236004)(966005)(7696005)(3846002)(6116002)(14454004)(2501003)(476003)(55016002)(7736002)(25786009)(229853002)(446003)(81166006)(81156014)(33656002)(4326008)(256004)(7416002)(2906002)(14444005)(8676002)(66066001)(71200400001)(71190400001)(6246003)(9686003)(99286004)(8936002)(6306002)(305945005)(52536014)(478600001)(76176011)(186003)(86362001)(2201001)(45080400002)(6506007)(5660300002)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4372;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RStTCSz++El7z6vs8mVHXO6VLwemrK21o5VXmy6qGUm7poa2CqLGtpOdTcqygTfTnRfGlPgqZQFm3AqT+s5VjP++6RTPgAQbAtaJnZl//0GWzC2PVsRYkYUgZ7hNl8y+A9474zpwfOJbI/TRx4OUnMB94Zc4YJAaklW2ysRdNn02ZRMQI2Y6Vb/C7A+d2W3hUPRLAySVZpdUKTjJxu6c/MBmBMSHdlLx6e62RTZN8wEtTpdwTItkZGLyDH3jeeQrZwJm+GLuuZa4/Hi8Wf3dJ93BMAT5Lm7CPrznVtR7KkhdIbDoUA1KoIT0dfSk93xSQYGfQVEI4OpVatXrmNSfgJ5qCqQ8NzVhakgI3t37n/FrJ2Z+sidT4OyJuN5a6RzkN2/pkcwNVVUymzjJ859pLD9JRjk+xutavZft95KPGiU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff0707c-b06e-4cc9-f13e-08d70074ccbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 11:43:14.6267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4372
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi, Pedro
Thanks for your positive affirmation.=20
For the UFS, we need this kind of tool which is be exclusively used for UFS=
 device.

Two years ago, I asked the question about " UFS utilities" and " is it nece=
ssary to have a ufs-utils tool?" in SCSI mail list.=20
In the end, I suffered a rebuff, was rejected.

                                                     --Bean Huo

>-----Original Message-----
>From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org>
>On Behalf Of Pedro Sousa
>Sent: Thursday, July 4, 2019 12:40 PM
>To: Arthur Simchaev <Arthur.Simchaev@wdc.com>; Bean Huo (beanhuo)
><beanhuo@micron.com>; James E . J . Bottomley <jejb@linux.vnet.ibm.com>;
>Martin K . Petersen <martin.petersen@oracle.com>; linux-
>scsi@vger.kernel.org; linux-@mx0a-00230701.pphosted.com;
>kernel@vger.kernel.org; Arnd Bergmann <arnd@arndb.de>; Alim Akhtar
><alim.akhtar@samsung.com>; Avri Altman <avri.altman@wdc.com>
>Cc: Stanley Chu <stanley.chu@mediatek.com>; Doug Anderson
><dianders@chromium.org>; Evan Green <evgreen@chromium.org>; Adrian
>Hunter <adrian.hunter@intel.com>; Avi Shchislowski
><avi.shchislowski@wdc.com>; Alex Lemberg <alex.lemberg@wdc.com>; Arthur
>Simchaev <Arthur.Simchaev@sandisk.com>; Joao Pinto
><Joao.Pinto@synopsys.com>
>Subject: [EXT] RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.=
0
>
>Hello Arthur,
>
>Very glad to see the ufs-tool coming to light! I will try to give it a run=
 as soon
>as I get free time slot.
>
>The "maintenance" of the tool will be through github, correct?
>I took a fast look at the Bean Huo pull request (especially the UniPro
>command part) and it would be very useful, if I get the time to test it sh=
ould I
>mention that in the github pull-request?
>
>Thank you,
>Pedro Sousa
>
>
>From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
>Date: Tue, Jun 25, 2019 at 13:36:00
>
>> From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
>>
>> The ufs-tool stable release v1.0 is available at
>> https://nam01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
>> ub.com%2Fwesterndigitalcorporation%2Fufs-
>tool&amp;data=3D02%7C01%7Cbeanh
>>
>uo%40micron.com%7C887a4692da7b4503241308d7006c1fa6%7Cf38a5ecd281
>34862b
>>
>11bac1d563c806f%7C0%7C1%7C636978336710114637&amp;sdata=3DgeK7Ml7ku
>n3P12p
>> f01e6ts2%2FFzJU%2FFK4n6nAyZ0hITY%3D&amp;reserved=3D0=3D
>>
>> Feedback and bug reports, as always, are welcomed.
>>
>> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
>> ---
>>  Documentation/scsi/ufs.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
>> index 1769f71..ae4643f 100644
>> --- a/Documentation/scsi/ufs.txt
>> +++ b/Documentation/scsi/ufs.txt
>> @@ -158,6 +158,11 @@ send SG_IO with the applicable sg_io_v4:
>>  If you wish to read or write a descriptor, use the appropriate xferp
>> of  sg_io_v4.
>>
>> +The user-space tool that interacts with the ufs-bsg endpoint and uses
>> +its upiu-based protocol, is available at
>>
>+https://nam01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
>b.com%2Fwesterndigitalcorporation%2Fufs-
>tool&amp;data=3D02%7C01%7Cbeanhuo%40micron.com%7C887a4692da7b4503
>241308d7006c1fa6%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C1%7C636
>978336710114637&amp;sdata=3DgeK7Ml7kun3P12pf01e6ts2%2FFzJU%2FFK4n6n
>AyZ0hITY%3D&amp;reserved=3D0=3D .
>> +For more detailed information about the tool and the tool's supported
>> +features, please see the tool's README.
>>
>>  UFS Specifications can be found at,
>>  UFS -
>>
>https://nam01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.j
>>
>edec.org%2Fsites%2Fdefault%2Ffiles%2Fdocs%2FJESD220.pdf&amp;data=3D02%7
>C
>>
>01%7Cbeanhuo%40micron.com%7C887a4692da7b4503241308d7006c1fa6%7Cf
>38a5ec
>>
>d28134862b11bac1d563c806f%7C0%7C1%7C636978336710114637&amp;sdata
>=3DzSSL4
>> iTVsy6m1dQORu6FyDzCzWf%2BL94ftaMR2YN53cI%3D&amp;reserved=3D0=3D
>> --
>> 2.7.4
>

