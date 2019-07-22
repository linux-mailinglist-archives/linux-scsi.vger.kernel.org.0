Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302186F95A
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfGVGKz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 02:10:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52473 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfGVGKz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 02:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563775854; x=1595311854;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1z0fPG4ODXUuRK5B2usOH1yIwOkSIaN900JZfbTFX8M=;
  b=gAD4+g16n4ruM1EJSvI4vuqSI8JEOztZEinQtFppR8Qg/S2r5NyqivAV
   aAbB+ycnqcVC2W/AgEYOr9Ed+Bk+dKjOug/0MRfld395jSTtyvjuz/SGU
   peFup+XXHknmhI17Pn6rfkqvCrr2k9agCKIF7aF4O1YNS3h3ee0l+Mt1r
   ftEWxX+rr54z4nP/EZ8u0+Mr2QdZvU9LjF4HliNE2sgfhrV/B7rM0FJlD
   iHAK3mKns9WUl1Y1VDTPI+tRdY35D90i7Ff3UVdzJMO/3/XqBkjVxaH7l
   myAvbv533T0viWiOF6wy2GT6PxZqi1p1PHF3BZQSHhwdSFjmb+zUGOBYl
   g==;
IronPort-SDR: TMsJvBfOFpSpZt+SRvrM/LIgqY8DOU1JclVoxx+It/mNjOj4iq4rBkuiwgAYAWw5R+f5ZJmBJR
 9nfTK+9o/a7Gfm8FvBkoVmZDPPtM6RSmIgt7B/YLHY4mx5+wIJGbl0UlOPD2nnfdnsw2l8BHXT
 ccJ48Wg48dnimvosiDMrMxgLPq7o0hDoWXjN1jiPdeRTasTHQGGENzF27JGIhjWOl/ZOce2CHn
 pV86FrYp6824LuZrmrxKzVnnWNUk2fOLb6R+nvhPXF14VkE3UFRGU01iL/0QM4V74wi4MLrebC
 gww=
X-IronPort-AV: E=Sophos;i="5.64,294,1559491200"; 
   d="scan'208";a="220092472"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2019 14:10:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWOm+ro7sYhFa8Bi2crXa/4kfvtclXGkmcWs9Zv6oa95uEzEsK0+IbvqcpMzWmXOqlIqs8ECIKhzE4yNQwCRQKcMn5BPjhY/iXkwd19QdvkwGA6zVZVVoEsbRp3PcRNNnuvml+snrZ6kZf5u7nstNcpu+XUE0U+a50a9H2err30tLLcn+5A/4iLS1AI/S/oRAEpFQyrdQzRtxxMvcVSYbeqDkN0jsKdCvCeIhxiIh+cIgzPR6rZ7QLIE8L9KwzIuJqEaQk03h7wsksAs8tPU8s0TAe3+dW8UDfcdiYun2AlW5EiTlhT1CVLzrNyCFfpD19qM4VepaDBmA7pOZM6VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z0fPG4ODXUuRK5B2usOH1yIwOkSIaN900JZfbTFX8M=;
 b=TxyFnGLDXzTYjWWfrUaT3ci7jG+HGzobMbgO3gzGXVpZnCGz6pSP7HIWr9J3MTyqyKD74HiyLiq1bsy/tV5kK1hovABnJWxJSFYXyyPP5e+7KTT1XFPTFMsPoW85p96rIs9n8rPs1fLtkJkK7XAZRbyYBzJ/JMt1e2liR6Gl+eD2bosbLNOYTAo18MEeIsBvuu7eFBxANkJ51kaxo+32l/lJ3FSXDO78US1HOaf/r6XzUDWlIZI2SWo1gW+HbKP3GbmulflyANgAYCUFjUKzRzt+TY7Q5/X8FbWhqSf4mkKBqHw8vHgBDUcrtT8/gYlhaLyAtP74qKkM+V8gHTsUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z0fPG4ODXUuRK5B2usOH1yIwOkSIaN900JZfbTFX8M=;
 b=s81HSn6NWlLlQ+eed9EckkJnhkcJJva1y/yCAIyexF5qQ+whNByqn2+PptToZOM4/lTe+6xM53qTVgDttSK5eLAIe1Ib2v4QC29N6tODFaJLNo/5pqOLR9uYKoZs92vSZ3fyXOkBV9PSqW36PMMXC+YHKaQk+YornMr9t8A28AM=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5200.namprd04.prod.outlook.com (20.178.6.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 06:10:25 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3%5]) with mapi id 15.20.2094.011; Mon, 22 Jul 2019
 06:10:25 +0000
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
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
Thread-Topic: [PATCH v1 0/2] scsi: ufs: Fix broken hba->outstanding_tasks
Thread-Index: AQHVOGx9NdHB1Jz3wEWNwY1jARxa+abVESuAgAADy1CAAR6tgA==
Date:   Mon, 22 Jul 2019 06:10:25 +0000
Message-ID: <SN6PR04MB49256F66F259185F3876CCABFCC40@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
 <SN6PR04MB4925208835D4760249E82DB7FCC50@SN6PR04MB4925.namprd04.prod.outlook.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4230b482-7ea0-4486-2546-08d70e6b49db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5200;
x-ms-traffictypediagnostic: SN6PR04MB5200:
x-microsoft-antispam-prvs: <SN6PR04MB5200518FA375111CD6C9B3D4FCC40@SN6PR04MB5200.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(66066001)(64756008)(66946007)(66446008)(66476007)(66556008)(81166006)(81156014)(2201001)(76116006)(8936002)(25786009)(256004)(4326008)(7416002)(86362001)(478600001)(99286004)(14454004)(110136005)(54906003)(316002)(486006)(76176011)(476003)(26005)(5660300002)(6246003)(305945005)(7696005)(2906002)(6436002)(74316002)(229853002)(53936002)(6506007)(102836004)(52536014)(33656002)(186003)(71190400001)(71200400001)(2501003)(8676002)(9686003)(3846002)(55016002)(7736002)(6116002)(446003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5200;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UN4gjd8vM8Y28stlW6bY/iJhHEO1YnhfYZbcaIJ8ojZmIFtM6II9CQERWsndLVBpMCww4ABXCEGYiga06eWOte2A1SoEXdKyvBdEydflCOyXu+S1vPDEyPEKQBRqucdPfrinBQmlHdDgN206+hNpXJSr1IB/km/TDhvI9Fo8z+GpNG65oixgkz+qEhSq3PS1W66b5+k8qkE0zhkT7ic35VETBX5/41aq9cz1ezf71OPiN4FiZQhGkGCGuqvLKwZklSvi+PJc9iqXXO4qqzUfK8BfdHliIztX/KaZWu3BQYQ7QIh70spqEDXif6YufyRmO3DkDhxQfPT/pYw7QvOpr9278IxfIVuTSnI3rx4EcZ4/TFimyHbHL2hRkl7UWFEutzs/h3+NCoGVGVQj+Y6bvXQ5Q8NFl990x+LsI875SYM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4230b482-7ea0-4486-2546-08d70e6b49db
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 06:10:25.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5200
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

PiANCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gPg0KPiA+ID4gQ3VycmVudGx5IGJpdHMgaW4gaGJh
LT5vdXRzdGFuZGluZ190YXNrcyBhcmUgY2xlYXJlZCBvbmx5IGFmdGVyIHRoZWlyDQo+ID4gPiBj
b3JyZXNwb25kaW5nIHRhc2sgbWFuYWdlbWVudCBjb21tYW5kcyBhcmUgc3VjY2Vzc2Z1bGx5IGRv
bmUgYnkNCj4gPiA+IF9fdWZzaGNkX2lzc3VlX3RtX2NtZCgpLg0KPiA+ID4NCj4gPiA+IElmIHRp
bWVvdXQgaGFwcGVucyBpbiBhIHRhc2sgbWFuYWdlbWVudCBjb21tYW5kLCBpdHMgY29ycmVzcG9u
ZGluZw0KPiA+ID4gYml0IGluIGhiYS0+b3V0c3RhbmRpbmdfdGFza3Mgd2lsbCBub3QgYmUgY2xl
YXJlZCB1bnRpbCBuZXh0IHRhc2sNCj4gPiA+IG1hbmFnZW1lbnQgY29tbWFuZCB3aXRoIHRoZSBz
YW1lIHRhZyB1c2VkIHN1Y2Nlc3NmdWxseSBmaW5pc2hlcy7igKcNCj4gPiB1ZnNoY2RfY2xlYXJf
dG1fY21kIGlzIGFsc28gY2FsbGVkIGFzIHBhcnQgb2YgdWZzaGNkX2Vycl9oYW5kbGVyLg0KPiA+
IERvZXMgdGhpcyBjaGFuZ2Ugc29tZXRoaW5nIGluIHlvdXIgYXNzdW1wdGlvbnM/DQo+IEFuZCBC
VFcgdGhlcmUgaXMgYSBzcGVjaWZpYyBfX2NsZWFyX2JpdCBpbiBfX3Vmc2hjZF9pc3N1ZV90bV9j
bWQoKSBpbiBjYXNlDQo+IG9mIGEgVE8uDQoNCkdhdmUgaXQgYW5vdGhlciBsb29rIC0gDQpJZiBp
bmRlZWQgdGhpcyBiaXQgaXNuJ3QgY2xlYXJlZCBhcyBwYXJ0IG9mIHRoZSBlcnJvciBmbG93IHRo
YXQgdGhlIHRpbWVvdXQgdHJpZ2dlcnMsDQpJIHRoaW5rIHlvdSBzaG91bGQgcmVsYXRlIHRvIHVm
c2hjZF9jbGVhcl90bV9jbWQgc3BlY2lmaWNhbGx5IGluIHlvdXIgY29tbWl0IGxvZyAtIA0KQmVj
YXVzZSB0aGlzIGlzIHRoZSBvYnZpb3VzIHBsYWNlIHdoZXJlIHRoZSBiaXQgY2xlYW51cCBzaG91
bGQgdGFrZSBwbGFjZS4NCg0KQWxzbyB0aGUgZml4IHNob3VsZCBiZSBtdWNoIG1vcmUgaW50dWl0
aXZlIElNTyAtIA0KVG9kYXkgd2UgZG8gX19jbGVhcl9iaXQoKSBvbiBzdWNjZXNzLCB1ZnNoY2Rf
Y2xlYXJfdG1fY21kKCkgb24gZXJyb3IsDQpBbmQgYWxzbyB1ZnNoY2RfcHV0X3RtX3Nsb3QoKSBl
aXRoZXIgd2F5Pw0KDQpNYXliZSB5b3UgY2FuIGNob29zZSBhIHNpbmdsZSBwbGFjZSB0byBjbGVh
ciBpdCwgd2l0aG91dCBhbnkgYWRkaXRpb25hbCBjb2RlPw0KDQpUaGFua3MsDQpBdnJpDQo=
