Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCF181FF
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfEHWUu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 May 2019 18:20:50 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54386 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728754AbfEHWUt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 May 2019 18:20:49 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48MKjIv030697;
        Wed, 8 May 2019 15:20:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=BhDK6FT+Ukt/b5OnQNgSZETrXWtrMQKe6MBlHa5Aca4=;
 b=vYgJa5EEmS/t4jSYN6tKKbUo6MBeKr35MjfG2tfqH1TQkyOrWesyEEQgsKOYIy+e5Hf/
 Yvsa4GSAlR3iv7INuETLH4bOG8nlijyYdQ+jHgZkn3mEjP4oi1sfxdFPb2bbSkWtqzsB
 u146yd5SjSPokF8trhxdUY9dBWwcV4C/BG/kzMIGF/vBVs8s79UOWdW/Vxx2XkfiUApN
 lEjiIJsSCHSUm3u/EJLdwOCnYDL589FJuGGnmlR4zoLBjvUGl5X3c+YD2+HAty1MAWfZ
 4W6rmphHer+oLcxx+XFr2lques2jkuu53wIPuR4PvVBy06VKO+h7Hme+wkDvX0HYEvWJ /w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sc7r6g0py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 15:20:47 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 8 May
 2019 15:20:46 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 8 May 2019 15:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhDK6FT+Ukt/b5OnQNgSZETrXWtrMQKe6MBlHa5Aca4=;
 b=X8oWTWe9BQmToRY4fkzQTGOYB78CFINgK/hyGiG2VUGegBhJIcBl1lXLVOd0D/mMLr53JsuKggqNv5vqaoPzV7fVxL/cqLPUFvFgyN1dr78bwHuvZcGa3WEgZe/GMfYgvpC7ZsSly2zIWOxwITPz5EwNDIkokjZkVW7Yd3mlj/E=
Received: from BYAPR18MB2870.namprd18.prod.outlook.com (20.179.58.144) by
 BYAPR18MB2678.namprd18.prod.outlook.com (20.179.94.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Wed, 8 May 2019 22:20:45 +0000
Received: from BYAPR18MB2870.namprd18.prod.outlook.com
 ([fe80::d8f4:f572:22d4:5b0d]) by BYAPR18MB2870.namprd18.prod.outlook.com
 ([fe80::d8f4:f572:22d4:5b0d%5]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 22:20:45 +0000
From:   Giridhar Malavali <gmalavali@marvell.com>
To:     Shivaram Upadhyayula <shivaram.u@quadstor.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: Problems with logout in qlt_free_session_done
Thread-Topic: Problems with logout in qlt_free_session_done
Thread-Index: AQHVBd6Scek6KkX43kiIUPtDWuYppKZhV3gA
Date:   Wed, 8 May 2019 22:20:45 +0000
Message-ID: <5973BD42-5E6A-4937-BFC6-8A09F04014FB@marvell.com>
References: <CAN-_EfwKNP5bK-ew7d+T4k8V3faOeFpR8-s_k6PGECSUFoMH9w@mail.gmail.com>
In-Reply-To: <CAN-_EfwKNP5bK-ew7d+T4k8V3faOeFpR8-s_k6PGECSUFoMH9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aaabc35-61dd-49dc-45fa-08d6d4036a5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR18MB2678;
x-ms-traffictypediagnostic: BYAPR18MB2678:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR18MB2678B7F110AB9ECA2564FB6AAC320@BYAPR18MB2678.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(6486002)(6306002)(2906002)(33656002)(6512007)(14454004)(66946007)(966005)(66556008)(66476007)(64756008)(66446008)(478600001)(2501003)(36756003)(73956011)(229853002)(76116006)(8936002)(76176011)(7736002)(305945005)(6506007)(102836004)(6436002)(99286004)(8676002)(68736007)(81156014)(81166006)(3846002)(486006)(6116002)(2616005)(110136005)(476003)(11346002)(446003)(26005)(316002)(186003)(66066001)(83716004)(86362001)(53936002)(6246003)(71200400001)(71190400001)(5660300002)(25786009)(82746002)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2678;H:BYAPR18MB2870.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QoF+JLnJF032A0waHRF2jyq9v71ADOI0k4DxS02JXx85k++hUHvLK4xW/eofxnKSPBkL/iJBxNRnTdttZWIbw62KQ7CMWw0UmgeY48r78iChF4B0WR2CPKNdxVBopmW16QuWmAgklPrHXednTsXlXzz56/rGz1VkM8pna5FjdM5Rbijms8KDECSDd4T+n9LFpOtru6G7zv4m1ScSkr/F+6KbITaM4tWNVarrcAjnJYBITHRU1MOqXGm+cFjJG1keshRjUcTLA5re9D82vQs28E3xcktZq3y4zHQx5w1PUiV+THADMeazrqFlZXfORXbXtGI24X+B2pAEM3V1yD4kCVDXC7RyMa7vDiDODR4N37CWt9P0Ct4HSLtGpAmTp4uriihafYygZsUwd7fkb/hi+m4g2eGHFu6DXoapzURbxoQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32763B174670D44785C71123ED630EC9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaabc35-61dd-49dc-45fa-08d6d4036a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 22:20:45.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2678
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_12:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQoNCu+7v09uIDUvOC8xOSwgMTo0MiBQTSwgImxpbnV4LXNjc2ktb3duZXJAdmdlci5rZXJuZWwu
b3JnIG9uIGJlaGFsZiBvZiBTaGl2YXJhbSBVcGFkaHlheXVsYSIgPGxpbnV4LXNjc2ktb3duZXJA
dmdlci5rZXJuZWwub3JnIG9uIGJlaGFsZiBvZiBzaGl2YXJhbS51QHF1YWRzdG9yLmNvbT4gd3Jv
dGU6DQoNCiAgICBIaSwNCiAgICANCiAgICBUaGVyZSBzZWVtIHRvIGJlIGEgZmV3IGlzc3VlcyB3
aGVuIHRyeWluZyB0byBkbyBhIGxvZ291dA0KICAgIHFsYV90YXJnZXQuYzpxbHRfZnJlZV9zZXNz
aW9uX2RvbmUgaW4gNC4xOS40MQ0KICAgIA0KICAgIDEuIFdoZW4gdGhlIGxvZ291dCB0aW1lc291
dCBxbGEyeDAwX3NwX3RpbWVvdXQgaXMgY2FsbGVkLiBUaGlzDQogICAgZnVuY3Rpb24gYXNzdW1l
cyBzcC0+cXBhaXIgaXMgdmFsaWQsIGJ1dCB0aGlzIGlzbid0IHRoZSBjYXNlIGlmIG1xIGlzDQog
ICAgbm90IGVuYWJsZWQNCiAgICANCiAgICAyLiBxbGEyeDAwX2FzeW5jX2lvY2JfdGltZW91dCBh
bHNvIGFzc3VtZXMgdGhhdCBzcC0+cXBhaXIgaXMgdmFsaWQuDQogICAgQWxzbyBvbmx5IGlmIHFs
YTI0eHhfYXN5bmNfYWJvcnRfY21kKCkgZmFpbHMgaXMgc3AtPmRvbmUoKSBjYWxsZWQsDQogICAg
c3AtPmRvbmUgaW4gdGhpcyBjYXNlIGlzIHFsdF9sb2dvX2NvbXBsZXRpb25faGFuZGxlcigpIHdo
aWNoIHdpbGwNCiAgICBuZXZlciBiZSBjYWxsZWQgaWYgcWxhMjR4eF9hc3luY19hYm9ydF9jbWQo
KSBzdWNjZWVkcw0KICAgIA0KICAgIDMuIHFsYTI0eHhfYXN5bmNfYWJvcnRfY21kKCkgY2FuIGxl
YWQgdG8gInNjaGVkdWxpbmcgd2hpbGUgYXRvbWljIiBpZg0KICAgIGNhbGxlZCBmcm9tIHFsYTJ4
MDBfYXN5bmNfaW9jYl90aW1lb3V0LiBUaGUgd2FpdCBwYXJhbWV0ZXIgY2FuIGJlIHVzZWQNCiAg
ICB0byBhbGxvYyB3aXRoIEdGUF9BVE9NSUMNCiAgICANCiAgICBQbGVhc2Ugc2VlIGRpZmYgaHR0
cHM6Ly93d3cucXVhZHN0b3IuY29tL3BhdGNoZXMvc3JiLWxvZ291dC5kaWZmDQogICAgZ2VuZXJh
dGVkIGFnYWluc3QgNC45LjQxDQoNCj4+IFdlIGhhdmUgYWRkcmVzc2VkIGlzc3VlcyByZWxhdGVk
IHRvIGFib3ZlIGluIG91ciBsYXRlc3QgdXBzdHJlYW0gZHJpdmVyLiBDYW4geW91IGNoZWNrIGFu
ZCBsZXQgdXMga25vdyB3aGV0aGVyIHlvdSBzdGlsbCBzZWUgdGhlIGFib3ZlIGlzc3Vlcy4gDQoN
Ci0tIEdpcmkNCiAgIA0KICAgIFJlZ2FyZHMsDQogICAgU2hpdmFyYW0NCiAgICANCiAgICAtLSAN
CiAgICBWaXJ0dWFsIFRhcGUgTGlicmFyeSBodHRwczovL3d3dy5xdWFkc3Rvci5jb20vdmlydHVh
bC10YXBlLWxpYnJhcnkuaHRtbA0KICAgIFN0b3JhZ2UgVmlydHVhbGl6YXRpb24gd2l0aCBWQUFJ
DQogICAgaHR0cHM6Ly93d3cucXVhZHN0b3IuY29tL3N0b3JhZ2UtdmlydHVhbGl6YXRpb24uaHRt
bA0KICAgIA0KDQo=
