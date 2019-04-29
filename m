Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D9EBA2
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfD2U37 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 16:29:59 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729212AbfD2U37 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Apr 2019 16:29:59 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TKQCtO016729;
        Mon, 29 Apr 2019 13:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=qPKz61ftp7IyCtuKka8M4aK7rBmLN2hRUSlDB1Vm684=;
 b=aNVPdsd2uUxt8cjzhPCwVRsCP/yOQuudjeFUqIHAeNSxpxGR9+hYTVuVsGBTRV90v0p8
 JwG4KfOnOcrePvnPTciL4LfghD+6v5ptDg1y4FkhYnMyVaj/hMsnwTrrZJbkxe65cTAD
 8YRUCcPmJD1EaGhk+rd55bY6ngjt/kxMNXGvsfUq2dS2i7YN+zkFqF4ppU+GjvfkVGq1
 axNc70tocfQzhqvNmPYowrj6+fxjLTDJoxxPSWDkk0ODDWudbaE0fGKDez0Wu1oBKA6b
 8DjWJF7YuWINewfjX2mYNRiSux44sjj8qvf4hXvKuYWkgy3wy2mACsAeAAA05Kr6iT+4 bw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2s61eb9mjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Apr 2019 13:29:43 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 29 Apr
 2019 13:29:42 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 29 Apr 2019 13:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPKz61ftp7IyCtuKka8M4aK7rBmLN2hRUSlDB1Vm684=;
 b=evUCpNoI/pfjnLu9RhfUfqau+zbSqsGVduSa23hUa0rjKxCPoX9pA5Kpd0977zwlO/YUZ7Ad/hFggel/QOywVExkxh60AyeXduW5OLy+dFdAhuHkAHSvbcmvUoSbefeUq99BEpikn2W+98ck+cpEx4QAVhLTy2bOx6GziA58eqI=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2688.namprd18.prod.outlook.com (20.179.83.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 20:29:40 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::fcf8:e2cb:431f:2608]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::fcf8:e2cb:431f:2608%5]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019
 20:29:40 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/35] qla2xxx source code cleanup and bug fixes
Thread-Topic: [PATCH 00/35] qla2xxx source code cleanup and bug fixes
Thread-Index: AQHU9WbeiItrBKI1gkqDLEMOTh6FgqZNeueA//+bvQCABmkpW///tJWA
Date:   Mon, 29 Apr 2019 20:29:40 +0000
Message-ID: <A8B86CFE-4C10-4654-9AC3-5614CE1E8539@marvell.com>
References: <20190417214443.243152-1-bvanassche@acm.org>
 <1556229869.161891.147.camel@acm.org>
 <61A50A60-DF18-4EF3-83C4-124BA6AEFE9D@marvell.com>
 <yq15zqwzo9f.fsf@oracle.com>
In-Reply-To: <yq15zqwzo9f.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6516cf7b-0394-4696-82d8-08d6cce1684f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB2688;
x-ms-traffictypediagnostic: MN2PR18MB2688:
x-microsoft-antispam-prvs: <MN2PR18MB26885EE7A86797BDF0D0CF44D6390@MN2PR18MB2688.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(81156014)(476003)(25786009)(83716004)(99286004)(71200400001)(71190400001)(33656002)(5660300002)(316002)(6512007)(8936002)(6916009)(53936002)(486006)(54906003)(81166006)(478600001)(82746002)(2906002)(66066001)(68736007)(76176011)(4326008)(97736004)(6506007)(102836004)(2616005)(6246003)(8676002)(446003)(14454004)(11346002)(66446008)(6436002)(64756008)(66476007)(4744005)(7736002)(26005)(229853002)(76116006)(73956011)(6486002)(93886005)(186003)(36756003)(91956017)(6116002)(66946007)(3846002)(305945005)(256004)(66556008)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2688;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y+SX7xN8SBgaBepE9MfLZpYCVo1wRWeeZ8coBU9LHqV9lW0RGu+SAEN82rZwCSROs8D51dt3czxfEnnupc0zD0O5cPciF8M9pR4FS0T7+oAtfgfkxlNYdPxtEcO2PMjIAeZ1gg9iPxgvszjb+Axbzx7aaXq6++KW3aVxsQvkznfCWLc1BS7JwWXW2hpDCxBiZYaWnSUGOeGnCgIDw5+ZLw+VTp6AosizAsLttL+mw8yGBw+yakDxojA3LzSIwjydmetkaUu7Spndm29Db08MGAHPBM2cxwXgWAo0YYZUQCT/TM90geCc5Famho3mBu7eTCXJm2CH8Ei1S3zy47SNVD5KmUz78ZhdhBFUX8ylz/8/Y1X0oy00jffVml/YUwdYR0bfJ7y5/EbU/00RRLo4k6UCM0pVXarKDPg7M0LKDDQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71FA268F49CA9E4580B0894164887F88@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6516cf7b-0394-4696-82d8-08d6cce1684f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 20:29:40.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2688
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_12:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgTWFydGluLCANCg0KUGxlYXNlIGFkZCBmb3IgdGhlIHNlcmllcywgDQoNCkFja2VkLWJ5OiBI
aW1hbnNodSBNYWRoYW5pIDxobWFkaGFuaUBtYXJ2ZWxsLmNvbT4gDQoNCg0K77u/T24gNC8yOS8x
OSwgMTA6NTkgQU0sICJsaW51eC1zY3NpLW93bmVyQHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYg
b2YgTWFydGluIEsuIFBldGVyc2VuIiA8bGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPiB3cm90ZToNCg0KICAgIA0K
ICAgIEhpbWFuc2h1LA0KICAgIA0KICAgID4gU3RpbGwgcmV2aWV3aW5nIGl0LiBBYm91dCBoYWxm
IHdheSBkb25lLiBXaWxsIEFDSyBpZiBubyBpc3N1ZXMgZm91bmQNCiAgICA+IGR1cmluZyB0ZXN0
aW5nLg0KICAgIA0KICAgIEdlbnRsZSBwb2tlLiBUaGVyZSBhcmUganVzdCBhIGNvdXBsZSBvZiBk
YXlzIGxlZnQgYmVmb3JlIHRoZSBtZXJnZQ0KICAgIHdpbmRvdyBhbmQgd2UnbGwgbmVlZCBzb21l
IC1uZXh0LzAtZGF5IGNvdmVyYWdlLg0KICAgIA0KICAgIC0tIA0KICAgIE1hcnRpbiBLLiBQZXRl
cnNlbglPcmFjbGUgTGludXggRW5naW5lZXJpbmcNCg0KDQpUaGFua3MsDQpIaW1hbnNodQ0KICAg
IA0KDQo=
