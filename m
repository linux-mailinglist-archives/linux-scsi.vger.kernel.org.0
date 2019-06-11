Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58493D547
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2019 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406864AbfFKSMY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 14:12:24 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44066 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406685AbfFKSMX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Jun 2019 14:12:23 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BHxx5F023610;
        Tue, 11 Jun 2019 11:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QlqBl3MjvW4i8lQGA7IU7LqIkAhT6W9YG/5heNC5ceA=;
 b=olEiXiGWw1TWzE27jEZsG0d0Mq+m7fzSxceDCiWgHQoHzfxP4pm7DCmHRpnjSGSEHOdK
 gW6tBKKIlVpR1fMlWM+PlcMZO8DOZaErax4ZV6zAO6FYe+q3HNXkA2Up+6sBbI3aVLUR
 4NIJYWkYE1+YQhK0qcNTbFSO7AZtMCFl6tasTrTW1fWyihF0tnCnzVkqZwkzJkWHGWEY
 hnIWrTPHsRzSAUdkyGd1iZolOldYsQJKG9U18SgFxTcLUgcGaIUdMN6Mz2Uxlymq1W2i
 5Xb05k7t+cp2ARMFGPwvGhASQxCI3Z69G+J7hvnXjx+VgR2Cr+Qtsv1xQaUW5OvqWdvN Qg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t29sca5x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 11:12:09 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 11 Jun
 2019 11:12:09 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 11 Jun 2019 11:12:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlqBl3MjvW4i8lQGA7IU7LqIkAhT6W9YG/5heNC5ceA=;
 b=mJXwr5O4I+on/bkOekVqrl6WZj7p8XrDf8ptCyvl50+d7h6tnUZe3H/XiHikDwdbSnahtb/aU0gm9Mvn3bNo7WYpz6iDVK5j2ENsPrx2yOUYCgQwcUE4Cf6TR2Hw8P6N9/5DC2DS1zXBoL+LwwEzClkh5Rw5XZ6VSdZa0S7mYpc=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2718.namprd18.prod.outlook.com (20.179.21.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 18:12:03 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 18:12:03 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [EXT] [PATCH 00/20] qla2xxx Patches
Thread-Topic: [EXT] [PATCH 00/20] qla2xxx Patches
Thread-Index: AQHVHIAi6DovyqkmX0G6hNswo3cLP6aPLNtogAecegA=
Date:   Tue, 11 Jun 2019 18:12:03 +0000
Message-ID: <BF5C02E6-89E5-493E-953A-A34B196BBD30@marvell.com>
References: <20190529202826.204499-1-bvanassche@acm.org>
 <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
 <yq1y32fo4d9.fsf@oracle.com>
 <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com>
 <yq1o93aml62.fsf@oracle.com>
In-Reply-To: <yq1o93aml62.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e44a4519-c74f-4c17-4dbf-08d6ee984e50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2718;
x-ms-traffictypediagnostic: MN2PR18MB2718:
x-microsoft-antispam-prvs: <MN2PR18MB2718D1D00523177811336190D6ED0@MN2PR18MB2718.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(8936002)(305945005)(7736002)(71200400001)(71190400001)(33656002)(50226002)(6486002)(99286004)(82746002)(68736007)(66066001)(6512007)(2906002)(83716004)(229853002)(36756003)(76176011)(53936002)(6916009)(6436002)(476003)(2616005)(54906003)(11346002)(6246003)(256004)(6506007)(14454004)(478600001)(73956011)(102836004)(66476007)(53546011)(57306001)(81156014)(66446008)(66946007)(66556008)(76116006)(186003)(4744005)(3846002)(64756008)(4326008)(486006)(81166006)(91956017)(446003)(6116002)(8676002)(316002)(26005)(86362001)(25786009)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2718;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v356WTb7iq23Vg8g4QbCr062tUMeHzq9x92+HXwCFw7ErSr9XbDxHwdo+eRwOvkLgP7Azzz30G+/SNuFqoT4XlmOJ6GpjjD1BKXra73vTYCwsRDOeNrCUfiQiGq1kAU/mlh3B2k4Qxnv5tdnO8Nk1gEBJlpno1krliXWT8GN2J8ooVRsvd91ceswd6pydkZWXHhq0mcUbDcYXq5EYTjpk7e036/Q9DX5/tMRVc8WFAxs5FAgZugQ/r4/1DUAhC41qTDKZKVJB6PT0F7FAc2/kcdL8UcuOHc4N9j5sMrFWKl7dlEx2aWuqR/cseil5X26Nzjxw1jrSvG7ZHgsFeXFAkueGtx0UG1XuV/lyqjbesZtzM80RdnSvTGQC7d1v1dgxCthaYANlKvTD6AGMD9/zpw4jo9eFOPURsSbsGTNbPo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E77E5131E8DED4388CE94AC56190D0B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a4519-c74f-4c17-4dbf-08d6ee984e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 18:12:03.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2718
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,=20

> On Jun 6, 2019, at 2:57 PM, Martin K. Petersen <martin.petersen@oracle.co=
m> wrote:
>=20
>=20
> Himanshu,
>=20
>> Sorry for delay. I need bit more time. I will let my automation work
>> thru weekend and will respond in early next week
>=20
> OK, thanks!
>=20

I am running into issue with this series applied on my tree while executing=
 abort path.=20

Investigating if the issue is introduced by this series or not.

stack trace does not have qla2xxx signature but since this series has chang=
es for abort path I am holding off on providing=20
ACK on this series until we fully understand what is triggering issue.

> --=20
> Martin K. Petersen	Oracle Linux Engineering

Thanks,
Himanshu

