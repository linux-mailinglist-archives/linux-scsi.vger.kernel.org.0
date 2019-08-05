Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4A81E50
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHEN7R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:59:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28370 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728851AbfHEN7R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Aug 2019 09:59:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x75Dt0C7024534;
        Mon, 5 Aug 2019 06:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=26ntCocQhz/qEffHtFIiZCmccGnP3hMSNhwBK7VXrsc=;
 b=efnPxRXHKMpUVKjj/x2S6GlQWL+Gmr3ZIg0vNYrMcz7yHDvIYGyE5Yru7RfEnMMvWAj+
 qq7V9smjG1yJpnEyS6LX1ZrbIEoTrenxfPPGMC6UkA3qhMBHkn1ZUc/BWo0JOLLl1ip9
 5FnpymtakOcgfNeQiweyw4CoGvTgqOaciYoJgBIWYUKDPNkqjw5ieIPTQN+QVAmp9h2X
 IXDKrxpgZNbb/kJahT9rMMkX3WWnUtkiuSAKOhe8jAmwnKLqR/dR++H1ito+zx5zE8ZB
 6XfPJ57EKE5JfRF0fz+Z3t4u38y59Qzy11UN29eHnoskmGikhpPVgn3uiBFWNdOK8Rmm dw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u57mqy47h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 06:59:03 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 5 Aug
 2019 06:59:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 5 Aug 2019 06:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWhD6craX8o+ha6OkGJRfUmFqtfe+uq8YZhhlHeBdKIfApRn3xuS6zDeRUN7KZOn/2A9sGOAjsptAbZOUp7V4amwyfZl7PVGf/GLq2GwmBVL7fIO0ka7YK+GthAjhC7G4xVlUi1f4k+3xtcaWEdtu29OCil9IDfL2mxJCXXcdUK++82i/w7xfxzmCqtQLj5bMRrjjzb9BQC7cuoaYJJ28JKDhZf0dpA9fd4LJupfnSKcVMGsK+Rm5xgumVgLJT/pVT2aq2EdMGLdpKUQobZPV0T6S4A0iej1b5z56+sNTDlFTQi0h2gRCfVtC9PTh9I0G4nEpbaLYFx5OBojzFKqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26ntCocQhz/qEffHtFIiZCmccGnP3hMSNhwBK7VXrsc=;
 b=DMu5WWTgpGzqA60Z5TJDrf4dEiLaI0AxAHuv943BVLlgLPAqYMHtAcb/83OG7NbeKW6PIIH7ABxT/lbELzsKmRDHN2U9OCzN6U0QXwWb4zWNXJeaO80IxjOPuGxAhZUyZBdzSvKUkYsKW8I7NtFyPBb39/uLoivQyVY28KyPsnQ8bka/uJgnafRcaYNgoOC/nStGXmtsk2f2YnwTkwR9Y4/qroUdFJotIZiH7Req7czvRInzzalyTccB4kTcvIIsgkbsjoOPIx58GZDoSDTLMcvllWjHFZFZuFmX7BpIIUkqO95z4YPzQazp/GGf0fwsCJ6ur6oZ5sDxWFLSstPiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26ntCocQhz/qEffHtFIiZCmccGnP3hMSNhwBK7VXrsc=;
 b=F5F/CzlN99Gm3Bk+TgR6Qr8CLJj9usDSqm/54Iw8+KfRFdlvnpAshCWi/kvnal4LO0t9jYOOb+T15hjB/kIXQpliH1v12j1I8xrAZrxzsiTu26DrN+OQt3PJtPH6LW8m2WSGBJ5eBdTrFfmVlTu3FsVOGAbfxMVGSY0iI3HVvmc=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3389.namprd18.prod.outlook.com (10.255.238.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Mon, 5 Aug 2019 13:58:57 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::c8fc:cffe:3499:b43a]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::c8fc:cffe:3499:b43a%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 13:58:57 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/59] qla2xxx patches for kernel v5.4
Thread-Topic: [PATCH 00/59] qla2xxx patches for kernel v5.4
Thread-Index: AQHVSJJ022sCI1XYH0SMvtN3Wp3gXKbsmrKA
Date:   Mon, 5 Aug 2019 13:58:56 +0000
Message-ID: <58DF2E9F-7984-4B8C-BBC1-5575955B64B1@marvell.com>
References: <20190801175614.73655-1-bvanassche@acm.org>
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2600:1700:211:eb30:31ac:c67b:b861:f055]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d47ce51-623c-42f1-207a-08d719ad0f3a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3389;
x-ms-traffictypediagnostic: MN2PR18MB3389:
x-microsoft-antispam-prvs: <MN2PR18MB3389FB553904CAE346DCC28BD6DA0@MN2PR18MB3389.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(51914003)(189003)(199004)(6916009)(91956017)(76116006)(46003)(14444005)(2616005)(256004)(486006)(446003)(229853002)(50226002)(316002)(11346002)(476003)(57306001)(54906003)(33656002)(2906002)(68736007)(25786009)(4326008)(305945005)(53936002)(81156014)(7736002)(5660300002)(14454004)(53546011)(6506007)(76176011)(186003)(478600001)(81166006)(102836004)(99286004)(36756003)(71200400001)(71190400001)(66946007)(6436002)(8676002)(8936002)(66446008)(6116002)(6486002)(6512007)(86362001)(64756008)(6246003)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3389;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GHallnynwSLMB92iOVt4Bxb537rggKzHCRIKco5yUnkfVfimIGR0kQP+8bTyY2waD7ytEjD1H9WVdqEbSccFR5KDORR0cWqzMaA0fPHanp5gJufQQ5CuHv0XP82EnDxxBYkL073irDdHVLTM2tBlxSeJ71j00Jaf6bl2Fp5san7s84b3vegyogEZqCRDpRB4/FjIn0JAaOXF0OMTTISjPigSh0BYYAj2jwyIm+Mh45kTxl1UHx8G3Dbh/gjiS7RJdD1Snz8Ur6ihMC7AkohwdgnDdJpxXutvJ9Xat4LQa+jUdN2J7WzDPGbt0fxhSiXrNyondmVr7zp3IUXDUFFeN0AmfSb6qj342niVRRAlx3TSGVhpL//7ZkY/V4nstk6lfJf4MMNlFUpId5HWEBeAJe7lTAQPsnY93NMkln1Jiz0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <318D1B2191FF5545B4B112659ED7F305@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d47ce51-623c-42f1-207a-08d719ad0f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 13:58:56.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3389
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-05_07:2019-07-31,2019-08-05 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgQmFydCwgDQoNCg0KPiBPbiBBdWcgMSwgMjAxOSwgYXQgMTI6NTUgUE0sIEJhcnQgVmFuIEFz
c2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPiB3cm90ZToNCj4gDQo+IEhpIE1hcnRpbiwNCj4gDQo+
IFRoZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGltcHJvdmUgdGhlIHJvYnVzdG5lc3Mgb2YgdGhl
IFFMb2dpYyBGaWJyZSBDaGFubmVsDQo+IGluaXRpYXRvciBhbmQgdGFyZ2V0IGRyaXZlcnMuIFRo
ZXNlIHBhdGNoZXMgYXJlIGEgcmVzdWx0IG9mIG1hbnVhbCBjb2RlDQo+IGluc3BlY3Rpb24sIGFu
YWx5c2lzIG9mIENvdmVyaXR5IHJlcG9ydHMgYW5kIHN0cmVzcyB0ZXN0aW5nIG9mIHRoZXNlIHR3
bw0KPiBkcml2ZXJzLiBQbGVhc2UgY29uc2lkZXIgdGhlc2UgcGF0Y2hlcyBmb3Iga2VybmVsIHZl
cnNpb24gdjUuNC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQo+IA0KPiBCYXJ0IFZhbiBB
c3NjaGUgKDU5KToNCj4gIHFsYTJ4eHg6IE1ha2UgcWxhMngwMF9hYm9ydF9zcmIoKSBhZ2FpbiBk
ZWNyZWFzZSB0aGUgc3AgcmVmZXJlbmNlDQo+ICAgIGNvdW50DQo+ICBxbGEyeHh4OiBSZWFsbHkg
Zml4IHFsYTJ4eHhfZWhfYWJvcnQoKQ0KPiAgcWxhMnh4eDogSW1wcm92ZSBMaW51eCBrZXJuZWwg
Y29kaW5nIHN0eWxlIGNvbmZvcm1hbmNlDQo+ICBxbGEyeHh4OiBVc2UgdGFicyBpbnN0ZWFkIG9m
IHNwYWNlcyBmb3IgaW5kZW50YXRpb24NCj4gIHFsYTJ4eHg6IEluY2x1ZGUgdGhlIDxhc20vdW5h
bGlnbmVkLmg+IGhlYWRlciBmaWxlIGZyb20gcWxhX2RzZC5oDQo+ICBxbGEyeHh4OiBSZW1vdmUg
YW4gaW5jbHVkZSBkaXJlY3RpdmUgZnJvbSBxbGFfbXIuYw0KPiAgcWxhMnh4eDogUmVtb3ZlIGEg
c3VwZXJmbHVvdXMgZm9yd2FyZCBkZWNsYXJhdGlvbg0KPiAgcWxhMnh4eDogRGVjbGFyZSB0aGUg
Zm91cnRoIHFsX2R1bXBfYnVmZmVyKCkgYXJndW1lbnQgY29uc3QNCj4gIHFsYTJ4eHg6IENoYW5n
ZSB0aGUgcmV0dXJuIHR5cGUgb2YgcWxhMngwMF91cGRhdGVfbXNfZmRtaV9pb2NiKCkgaW50bw0K
PiAgICB2b2lkDQo+ICBxbGEyeHh4OiBSZWR1Y2UgdGhlIHNjb3BlIG9mIHRocmVlIGxvY2FsIHZh
cmlhYmxlcyBpbg0KPiAgICBxbGEyeHh4X3F1ZXVlY29tbWFuZCgpDQo+ICBxbGEyeHh4OiBEZWNs
YXJlIHFsYV90Z3RfY21kLmNkYiBjb25zdA0KPiAgcWxhMnh4eDogQ2hhbmdlIGRhdGFfZHNkIGlu
dG8gYW4gYXJyYXkNCj4gIHFsYTJ4eHg6IFZlcmlmeSBsb2NraW5nIGFzc3VtcHRpb25zIGF0IHJ1
bnRpbWUNCj4gIHFsYTJ4eHg6IFJlZHVjZSB0aGUgbnVtYmVyIG9mIGNhc3RzIGluIEdJRCBsaXN0
IGNvZGUNCj4gIHFsYTJ4eHg6IFNpbXBsaWZ5IHFsdF9scG9ydF9kdW1wKCkNCj4gIHFsYTJ4eHg6
IFJlbW92ZSBhIHN1cGVyZmx1b3VzIHBvaW50ZXIgY2hlY2sNCj4gIHFsYTJ4eHg6IFJlbW92ZSB0
d28gc3VwZXJmbHVvdXMgdGVzdHMNCj4gIHFsYTJ4eHg6IFNpbXBsaWZ5IHFsYTI0eHhfYWJvcnRf
c3BfZG9uZSgpDQo+ICBxbGEyeHh4OiBGaXggc2Vzc2lvbiBsb29rdXAgaW4gcWx0X2Fib3J0X3dv
cmsoKQ0KPiAgcWxhMnh4eDogUmVwb3J0IHRoZSBmaXJtd2FyZSBzdGF0dXMgY29kZSBpZiBhIG1h
aWxib3ggY29tbWFuZCBmYWlscw0KPiAgcWxhMnh4eDogRG8gbm90IGNvcnJ1cHQgdmhhLT5wbG9n
aV9hY2tfbGlzdA0KPiAgcWxhMnh4eDogVXNlIHN0cmxjcHkoKSBpbnN0ZWFkIG9mIHN0cm5jcHko
KQ0KPiAgcWxhMnh4eDogQ29tcGxhaW4gaWYgYSBtYWlsYm94IGNvbW1hbmQgdGltZXMgb3V0DQo+
ICBxbGEyeHh4OiBDb21wbGFpbiBpZiBwYXJzaW5nIHRoZSB2ZXJzaW9uIHN0cmluZyBmYWlscw0K
PiAgcWxhMnh4eDogUmVtb3ZlIGRlYWQgY29kZQ0KPiAgcWxhMnh4eDogU2ltcGxpZnkgYSBkZWJ1
ZyBzdGF0ZW1lbnQNCj4gIHFsYTJ4eHg6IEZpeCBxbGEyNHh4X3Byb2Nlc3NfYmlkaXJfY21kKCkN
Cj4gIHFsYTJ4eHg6IFJlbW92ZSB1bnJlYWNoYWJsZSBjb2RlIGZyb20gcWxhODN4eF9pZGNfbG9j
aygpDQo+ICBxbGEyeHh4OiBTdXBwcmVzcyBhIENvdmVyaXRpeSBjb21wbGFpbnQgYWJvdXQgaW50
ZWdlciBvdmVyZmxvdw0KPiAgcWxhMnh4eDogU3VwcHJlc3MgbXVsdGlwbGUgQ292ZXJpdHkgY29t
cGxhaW50IGFib3V0IG91dC1vZi1ib3VuZHMNCj4gICAgYWNjZXNzZXMNCj4gIHFsYTJ4eHg6IEFs
d2F5cyBjaGVjayB0aGUgcWxhMngwMF93YWl0X2Zvcl9oYmFfb25saW5lKCkgcmV0dXJuIHZhbHVl
DQo+ICBxbGEyeHh4OiBEZWNsYXJlIGZvdXJ0aCBxbGEyeDAwX3NldF9tb2RlbF9pbmZvKCkgYXJn
dW1lbnQgY29uc3QNCj4gIHFsYTJ4eHg6IENvbXBsYWluIGlmIHdhaXRpbmcgZm9yIHBlbmRpbmcg
Y29tbWFuZHMgdGltZXMgb3V0DQo+ICBxbGEyeHh4OiBDaGVjayB0aGUgUENJIGluZm8gc3RyaW5n
IG91dHB1dCBidWZmZXIgc2l6ZQ0KPiAgcWxhMnh4eDogVXNlIG1lbWNweSgpIGFuZCBzdHJsY3B5
KCkgaW5zdGVhZCBvZiBzdHJjcHkoKSBhbmQgc3RybmNweSgpDQo+ICBxbGEyeHh4OiBDb21wbGFp
biBpZiBhIHNvZnQgcmVzZXQgZmFpbHMNCj4gIHFsYTJ4eHg6IEludHJvZHVjZSB0aGUgYmVfaWRf
dCBhbmQgbGVfaWRfdCBkYXRhIHR5cGVzIGZvciBGQyBzcmMvZHN0DQo+ICAgIElEcw0KPiAgcWxh
Mnh4eDogQ2hhbmdlIHRoZSByZXR1cm4gdHlwZSBvZiBxbGEyNHh4X3JlYWRfZmxhc2hfZGF0YSgp
DQo+ICBxbGEyeHh4OiBDaGVjayBzZWNvbmRhcnkgaW1hZ2UgaWYgcmVhZGluZyB0aGUgcHJpbWFy
eSBpbWFnZSBmYWlscw0KPiAgcWxhMnh4eDogTWFrZSBpdCBleHBsaWNpdCB0aGF0IEVMUyBwYXNz
LXRocm91Z2ggSU9DQnMgdXNlIGxpdHRsZQ0KPiAgICBlbmRpYW4NCj4gIHFsYTJ4eHg6IFNldCB0
aGUgcmVzcG9uZGVyIG1vZGUgaWYgYXBwcm9wcmlhdGUgZm9yIEVMUyBwYXNzLXRocm91Z2gNCj4g
ICAgSU9DQnMNCj4gIHFsYTJ4eHg6IFJld29yayBrZXkgZW5jb2RpbmcgaW4gcWx0X2ZpbmRfaG9z
dF9ieV9kX2lkKCkNCj4gIHFsYTJ4eHg6IEVuYWJsZSB0eXBlIGNoZWNraW5nIGZvciB0aGUgU1JC
IGZyZWUgYW5kIGRvbmUgY2FsbGJhY2sNCj4gICAgZnVuY3Rpb25zDQo+ICBxbGEyeHh4OiBJbnRy
b2R1Y2UgdGhlIGZ1bmN0aW9uIHFsYTJ4eHhfaW5pdF9zcCgpDQo+ICBxbGEyeHh4OiBGaXggYSBy
YWNlIGNvbmRpdGlvbiBiZXR3ZWVuIGFib3J0aW5nIGFuZCBjb21wbGV0aW5nIGEgU0NTSQ0KPiAg
ICBjb21tYW5kDQo+ICBxbGEyeHh4OiBNYWtlIHFsdF9oYW5kbGVfYWJ0c19jb21wbGV0aW9uKCkg
bW9yZSByb2J1c3QNCj4gIHFsYTJ4eHg6IE1vZGlmeSBOVk1lIGluY2x1ZGUgZGlyZWN0aXZlcw0K
PiAgcWxhMnh4eDogUmVuYW1lIHFsYTI0eHhfYXN5bmNfYWJvcnRfY29tbWFuZCgpIGludG8NCj4g
ICAgcWxhMjR4eF9zeW5jX2Fib3J0X2NvbW1hbmQoKQ0KPiAgcWxhMnh4eDogSW50cm9kdWNlIHFs
YTJ4eHhfZ2V0X25leHRfaGFuZGxlKCkNCj4gIHFsYTJ4eHg6IE1ha2Ugc3VyZSB0aGF0IGFib3J0
ZWQgY29tbWFuZHMgYXJlIGZyZWVkDQo+ICBxbGEyeHh4OiBDb21wbGFpbiBpZiBzcC0+ZG9uZSgp
IGlzIG5vdCBjYWxsZWQgZnJvbSB0aGUgY29tcGxldGlvbiBwYXRoDQo+ICBxbGEyeHh4OiBMZXQg
dGhlIGNvbXBpbGVyIGNoZWNrIHRoZSB0eXBlIG9mIHRoZSBTQ1NJIGNvbW1hbmQgY29udGV4dA0K
PiAgICBwb2ludGVyDQo+ICBxbGEyeHh4OiBSZW1vdmUgc3VwZXJmbHVvdXMgc3RzX2VudHJ5Xyog
Y2FzdHMNCj4gIHFsYTJ4eHg6IFJlcG9ydCBpbnZhbGlkIG1haWxib3ggc3RhdHVzIGNvZGVzDQo+
ICBxbGEyeHh4OiBJbmxpbmUgdGhlIHFsYTJ4MDBfZmNwb3J0X2V2ZW50X2hhbmRsZXIoKSBmdW5j
dGlvbg0KPiAgcWxhMnh4eDogSW50cm9kdWNlIHFsYTJ4MDBfZWxzX2RjbWQyX2ZyZWUoKQ0KPiAg
cWxhMnh4eDogUmVtb3ZlIHR3byBzdXBlcmZsdW91cyBpZi10ZXN0cw0KPiAgcWxhMnh4eDogU2lt
cGxpZnkgcWxhMjR4eF9hc3luY19hYm9ydF9jbWQoKQ0KPiAgcWxhMnh4eDogRml4IGEgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlDQo+IA0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfYXR0ci5j
ICAgIHwgICA2ICstDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9ic2cuYyAgICAgfCAgMTkg
Ky0NCj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2RiZy5jICAgICB8ICAgMyArLQ0KPiBkcml2
ZXJzL3Njc2kvcWxhMnh4eC9xbGFfZGVmLmggICAgIHwgMTMwICsrKysrKysrKystLS0tDQo+IGRy
aXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kZnMuYyAgICAgfCAgIDkgKy0NCj4gZHJpdmVycy9zY3Np
L3FsYTJ4eHgvcWxhX2RzZC5oICAgICB8ICAgMiArDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9mdy5oICAgICAgfCAgIDggKy0NCj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2dibC5oICAg
ICB8ICAzNSArKy0tDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9ncy5jICAgICAgfCAyMTkg
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2luaXQu
YyAgICB8IDI2NyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBkcml2ZXJzL3Njc2kv
cWxhMnh4eC9xbGFfaW5saW5lLmggIHwgIDI4ICstLQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9x
bGFfaW9jYi5jICAgIHwgMjIxICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiBkcml2ZXJzL3Nj
c2kvcWxhMnh4eC9xbGFfaXNyLmMgICAgIHwgIDI0ICsrLQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4
eC9xbGFfbWJ4LmMgICAgIHwgIDEyICstDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9taWQu
YyAgICAgfCAgIDQgKy0NCj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX21yLmMgICAgICB8ICA2
NyArKysrLS0tLQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5jICAgIHwgIDI4ICst
LQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5oICAgIHwgICA1ICstDQo+IGRyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV9ueC5jICAgICAgfCAgMTYgKy0NCj4gZHJpdmVycy9zY3NpL3Fs
YTJ4eHgvcWxhX254LmggICAgICB8ICAxNCArLQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFf
bngyLmMgICAgIHwgICAyICstDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9vcy5jICAgICAg
fCAyMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9zdXAuYyAgICAgfCAgIDggKy0NCj4gZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX3RhcmdldC5j
ICB8IDIwOSArKysrKysrKystLS0tLS0tLS0tLS0tDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV90YXJnZXQuaCAgfCAgMzUgKystLQ0KPiBkcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfdG1wbC5j
ICAgIHwgICA3ICstDQo+IGRyaXZlcnMvc2NzaS9xbGEyeHh4L3RjbV9xbGEyeHh4LmMgfCAgMjcg
KystDQo+IGluY2x1ZGUvbGludXgvbnZtZS1mYy1kcml2ZXIuaCAgICAgfCAgIDIgKw0KPiAyOCBm
aWxlcyBjaGFuZ2VkLCA2ODUgaW5zZXJ0aW9ucygrKSwgOTQ0IGRlbGV0aW9ucygtKQ0KPiANCj4g
LS0gDQo+IDIuMjIuMC43NzAuZzBmMmM0YTM3ZmQtZ29vZw0KPiANCg0KVGhhbmtzIGZvciB0aGUg
c2VyaWVzLiAgSeKAmWxsIHJ1biB0aGlzIHNlcmllcyB0aHJvdWdoIG91ciByZWdyZXNzaW9uIGN5
Y2xlIGJlZm9yZSBJIHByb3ZpZGUgQUNLLiANCg0KVGhhbmtzLA0KSGltYW5zaHU=
