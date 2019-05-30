Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1368D2F77C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfE3Gjl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 02:39:41 -0400
Received: from mail-eopbgr1310109.outbound.protection.outlook.com ([40.107.131.109]:22016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3Gjk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 02:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=CUpsQyXuQKnjnMerSWxNdniUQpaNx9Z7U26dDLsyNRv4Z9hWO9TUrjFzWSy5aFuW5xT3WmJj/F2R12rf841ftKTKAOEohrZ8b/3sOtKsYmfk+jr7mLFS7+hRKBXVz+R/c/kKanCug2jxE4k3WY7nAOVYmth3CLwfrNr/lc3O7wA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teQJIy7TJqZ6rDqFZl95edA89q3SgB7VUlYq91n7Tmg=;
 b=blu5JrUZNIK12j//7TvPCr9FuxbvJ/hNRIhcVIpFjXKCGycO6kWfJLHsDJiWR57QIqxSk9oYu+uh6jEP2vrP4Br4YbXnfoH7Km7unSLKgtpcRT430airD+HOvWZ3yDDzbqw4dGf0nrOc710Vf4uXH6UGhaPaT6Sj7XcNXKTCXcY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teQJIy7TJqZ6rDqFZl95edA89q3SgB7VUlYq91n7Tmg=;
 b=is8MY7anEWBsEwXfdFi/ij0dLX50y520OXJ+rDYknfkmwqZGcvnpapM2APJQRGO5mgIjg3RDB+LfZ4tsSq6ZHTUB0yczLQCw0PHwgmLeSxJxbGcxM5k/gx8wJGUAiW5glRvJ3b92/oD0VRkoxeptQbnStc13YVDPab2RAT3w33s=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0185.APCP153.PROD.OUTLOOK.COM (10.170.187.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.1; Thu, 30 May 2019 06:39:32 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%3]) with mapi id 15.20.1965.003; Thu, 30 May 2019
 06:39:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <tom.leiming@gmail.com>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>, Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: SCSI adapter: how to freeze and thaw I/O on hibernation?
Thread-Topic: SCSI adapter: how to freeze and thaw I/O on hibernation?
Thread-Index: AdURELHvLfnzwMBzRu65bCFYUUVo1AFgqkQAAActBeA=
Date:   Thu, 30 May 2019 06:39:31 +0000
Message-ID: <PU1P153MB01699F65095D947340015CC9BF180@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB016617EB56A9B6ED55B8CFD0BF010@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <CACVXFVOmgZthx433vSAtpJKkbpmU-9EGTuJEcmcmQt2PCwTLhg@mail.gmail.com>
In-Reply-To: <CACVXFVOmgZthx433vSAtpJKkbpmU-9EGTuJEcmcmQt2PCwTLhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-30T06:39:28.1152347Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3552791b-904e-41f0-a672-92df927f33bc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:8c48:e0c2:695a:866b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 860f9c07-42ba-405e-71cf-08d6e4c992c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0185;
x-ms-traffictypediagnostic: PU1P153MB0185:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01858702A753B821C86E3D13BF180@PU1P153MB0185.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(9686003)(55016002)(102836004)(5660300002)(68736007)(7696005)(2906002)(6916009)(54906003)(10290500003)(6436002)(6116002)(7736002)(74316002)(229853002)(8936002)(76176011)(33656002)(86362001)(478600001)(25786009)(305945005)(52536014)(476003)(486006)(66946007)(46003)(8990500004)(53936002)(22452003)(64756008)(66556008)(14454004)(256004)(14444005)(66446008)(81166006)(446003)(73956011)(8676002)(4326008)(6506007)(81156014)(11346002)(53546011)(6246003)(107886003)(71200400001)(71190400001)(66476007)(10090500001)(186003)(99286004)(76116006)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0185;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IhmAurdtc2BW0c/V+Jxf0O0mH00AQYCy8XdQ0zh7XXc/wo/iAE2dwSON57+ceUcq8ndJStrjZvV5oYWJHZd5sFTtcqoidVoQlngL/nneoWqOzOK58ZunZadPo911tkCfJx4y/Nn7/P6o858yDfmSZun630OJx5/dUZKh8FdTYKWMMkNstFN1Rqo2D+gQYfhKq/N2XG/hLJx9xZvNd9466BJIJwcn6wxCVpYKrJ/42GFBKfCCcBZonYD1P2u63tBef26BdArijuFL6GYD2CEbP6tLbR1Wfa8wJbf16WGHdlKSw8RQxAbYlDpWQlxD/dmFYpZ+bYghSdP24ogIsz0OQqrj4+lroHIkuzqIXke17az+lHH+4ppOzjpn+Kb4Z0K656P/BbArmR7lP9m5pEUXjA6GtkZeDtG5Uua4UNhgH+A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860f9c07-42ba-405e-71cf-08d6e4c992c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 06:39:31.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0185
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiBGcm9tOiBNaW5nIExlaSA8dG9tLmxlaW1pbmdAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE1heSAyOSwgMjAxOSA3OjU3IFBNDQo+IE9uIFRodSwgTWF5IDIzLCAyMDE5IGF0IDExOjE4
IEFNIERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+IC4uLg0KPiA+
IEkgY2hlY2tlZCBzb21lIFBDSSBIQkEgZHJpdmVycywgYW5kIHRoZXkgdXNlIHNjc2lfYmxvY2tf
cmVxdWVzdHMoKSwgYnV0DQo+ID4gYXMgSSBkZXNjcmliZWQgYWJvdmUsIEkgZG9uJ3Qga25vdyBo
b3cgc2V0dGluZyBhIGZsYWcgY2FuIHByZXZlbnQgYW5vdGhlcg0KPiA+IENQVSBmcm9tIHN1Ym1p
dHRpbmcgSS9PIHJlcXVlc3RzLg0KPiA+DQo+IHNjc2lfZGV2aWNlX3F1aWVzY2UoKSBoYXMgYmVl
biBjYWxsZWQgYnkgc2NzaV9kZXZfdHlwZV9zdXNwZW5kKCkgdG8gcHJldmVudA0KPiBhbnkgbm9u
LXBtIHJlcXVlc3QgZnJvbSBlbnRlcmluZyBxdWV1ZS4NCg0KT2gsIHllcywgeW91J3JlIHJpZ2h0
ISBJIHRoaW5rIEkgb3Zlcmxvb2tlZCB0aGlzIGZ1bmN0aW9uLiBTbyBpdCBsb29rcyBhbGwgdGhl
IHNkZXZzDQphcmUgc3VzcGVuZGVkIGFuZCByZXN1bWVkIGF1dG9tYXRpY2FsbHkgaW4gZHJpdmVy
cy9zY3NpL3Njc2lfcG0uYywgYW5kIHRoZQ0KbG93IGxldmVsIFNDU0kgYWRhcHRlciBkcml2ZXIg
b25seSBuZWVkcyB0byBzdXNwZW5kL3Jlc3VtZSB0aGUgc3RhdGUgb2YgdGhlDQphZGFwdGVyLiAN
Cg0KQnV0IHdoeSBkbyB3ZSBuZWVkIHRvIGNhbGwgc2NzaV9ibG9ja19yZXF1ZXN0cygpIGluIHNv
bWUgbG93IGxldmVsIFNDU0kgYWRhcHRlcg0KZHJpdmVycydzIC5zdXNwZW5kPyBlLmcuIGluIG1w
dDNzYXNfZHJpdmVyJ3Mgc2NzaWhfc3VzcGVuZCgpOiBpZiBubyBuZXcgSS9PDQpyZXF1ZXN0cyBj
YW4gYmUgc3VibWl0dGVkIGZyb20gdGhlIHNkZXZzIGluIHRoZSBoaWJlcm5hdGlvbiBzY2VuYXJp
bywgY2FuIHlvdQ0KcGxlYXNlIGV4cGxhaW4gd2h5IHdlIG5lZWQgdGhlIHNjc2lfYmxvY2tfcmVx
dWVzdHMoKSBoZXJlPw0KDQo+IE9yIGRvIHlvdSBzdGlsbCBzZWUgSU8gcmVxdWVzdHMgY29taW5n
IGR1cmluZyBoaWJlcm5hdGlvbj8NCk5vLiBJIGp1c3QgZGlkbid0IHJlYWxpemUgaG93IHNjc2lf
YnVzX3BtX29wcyB3b3Jrcy4gVGhhbmtzIGZvciB5b3VyIHJlcGx5IQ0KDQpUaGFua3MsDQotLSBE
ZXh1YW4NCg==
