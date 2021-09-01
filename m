Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58863FD910
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Sep 2021 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbhIAL4r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Sep 2021 07:56:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48533 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbhIAL4q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 Sep 2021 07:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630497349; x=1662033349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6U2TK9QjVqkyk0vG/Sbi4g2ABM+KW5dDJ4ANmk+Cjqo=;
  b=tlplKlShM9geT0dkalr6ZztdyFuC4POw/2FckmjVGyvuK7W+uwlXSx2X
   NlqijoT/jGhiJNjLcc3/x2d5+8DXYV9dyaETKaO9AVnc+viAa+7j5KWOC
   tuITg9DnihyLxp3F6t8X98YeLjSbPfI81JImznjowkiIqh55NV3q1jMom
   3eY7NRmH4sE1PDC420JaxIBZLceVTXg87BJFX7BsvincPOyAo/dDH6KRy
   8G+cNdAla1begrNj+RGUUxNtKhTeOORwXAClqUtiH6KspCXjdwDBqfr6j
   NnA6QHR7VtGRd53C+nlHdstC1xUeniu7kHSUFxVwa41txEAyFpXot/TYX
   w==;
IronPort-SDR: E2EfJnZW69gd2QFxCc4OmfqzxVzM+CZtm37pM2bZyYkPoedseFbA/Z9Fn1jQWyVetOVHPTfAI+
 /rAcJ0HnrcmvsRPifiqONZcvFisFDGdsDzHO8PVq1MIr7ZY8bDXCN7F9oyx+aiVpGajBThqEPZ
 d9D9O+Tg0y10yn3Kj1czgz+JWV/qKBvAz+hdnKDuASfL0CCkJtW1N1KzHInAIQJ64AOvTFsbdE
 Hm6G35BKkbPuaqsQiPdC5eeWttVyyBghD0K2QRc/yUa5AvClVlMAS8u5Pf9AzYUDG38OAtIbvN
 LiIF7hjPzMC4wyHCc1wxp+/f
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="127843351"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 04:55:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 04:55:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Wed, 1 Sep 2021 04:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZdExmho2/QX5DAY1I7j/FpbYs2f0SYxc+NL/RPFqsv/Jir7uJJq3NBT2ugDYTy1yJsgCodL+QGq2Bu45garExQZsjp7k9M5qhrNde7Vd9CQe+z56ZMFsoSssvdaIE1v/Z8FO+sUd06F/xWWrgadjcGAE5qNG0NuBDSBWSYD3ykZMll8/SeIlDhmSADeb+LMeuUm8CT87bjyjosDFsoe1ROM8j+PV+0MFL8kcKvmNbqOuJoWK7oFRaVVrI7MnaR9fzpWM+NZ60A+RHkraoa5Tge4/sXg50LSgtFSHOvqmiSbV1Hb3Cr4eVNB89Yyl30x0i3x0bbx12J11rfyfNMrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U2TK9QjVqkyk0vG/Sbi4g2ABM+KW5dDJ4ANmk+Cjqo=;
 b=jvhjTVUWNJQH9B3yisd9VJ7wat3eDPH2uiTBrlhZh6DJV+/6YxtsukIwitCOPysXzTb9iMJ7KjrUjBqZBycDXliUlePjjcGfAxnSfr5+zzf+gn2Unwy4mHBvEO9rmKsVySEmvyTdIMZY7fZztH9MrmccpPaIREmKtoSfiOdFOcqi1FhOVHd/Zia8sX9xY6WB5REyg7u33MlMU1Bd+S2yjc3iXWT7ItSM1/GQsdNsl2fONLsxIm75otYUOfsZIEUHpM1fgxFzSq94BJK1ILvtErFZtjtPojiwhh1WJJFERbHCr0hWc1YZ426YtXzdWidlGqnyv6v/POc8YeHtaryqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U2TK9QjVqkyk0vG/Sbi4g2ABM+KW5dDJ4ANmk+Cjqo=;
 b=qsLALIa4Nsg961iqFj7MWk26E1En77uuSsh224HmtGQApLZ/Vzez/xsAYBdJapiHuX74w0YvXaXuHpHObwEtnbEa/YvWJ8dg3DPC5KRsvhgUrKosVS5rp9ZCFeUzH9QIu2PQwVipheN8NFkT+jDNugqZRxXsFm7RZzh7xNFSWG4=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 11:55:47 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::e95b:92f5:e104:8bdb]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::e95b:92f5:e104:8bdb%5]) with mapi id 15.20.4436.029; Wed, 1 Sep 2021
 11:55:47 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <jinpu.wang@ionos.com>
CC:     <linux-scsi@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <Ashokkumar.N@microchip.com>, <jinpu.wang@cloud.ionos.com>
Subject: RE: [PATCH 2/4] scsi: pm80xx: fix lockup due to commit <1f02beff224e>
Thread-Topic: [PATCH 2/4] scsi: pm80xx: fix lockup due to commit
 <1f02beff224e>
Thread-Index: AQHXnXgp7iEvlKhpJ0ihw5Fih2R4jKuPE9HA
Date:   Wed, 1 Sep 2021 11:55:47 +0000
Message-ID: <PH0PR11MB51122A89F8BE013A83969E11ECCD9@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20210823082338.67309-1-Ajish.Koshy@microchip.com>
 <20210823082338.67309-3-Ajish.Koshy@microchip.com>
 <CAMGffE=NFchDVbnC1X0yaGW7dXmeYvVz+fgo7bZfzX12DzooJA@mail.gmail.com>
In-Reply-To: <CAMGffE=NFchDVbnC1X0yaGW7dXmeYvVz+fgo7bZfzX12DzooJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b26b8a4-8c9e-4469-44e8-08d96d3f6fd3
x-ms-traffictypediagnostic: PH0PR11MB4984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB498452ABC7E025674BB9CD25ECCD9@PH0PR11MB4984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOpusiQfGeEBHfJR1tlkpi4qisJe6ierwSunFDbiqa0TAB9Q0U04kQMDR/2sAAoUHg3IYfaLcpgNl59+fG9d8yROJHmxnWtnbVpF7qE4IW0523HoYvQccQS21VT5OzpMAb6XJ04qg6xYDicEiHGMAyw2ZKrIKIfs0mJCwUJrec+codSGIAGWcVPv07zdw/lzM2kEfqGHD902rK0EKyPoULxB0YPh0hfG7v5Oy7eiTBRrcYMgnd5vIHrba+L8+vVVrhfbg3IvyW2U3n6NBzbpLc7shAQTQKlvdGqUmNaPWdt/Db1sNxCwvWuDr6h9SlHK1GcGmQHlSCyH+MRv31Jr2fCbNFFx/HGv9JI7a0VeQ0y+ok4Wx3r5GbRdnUWUIENOknoHfQhDDJxp+zA7XW7rdUOFPSsYTU2xAmJBaJUowS9FnxwHGAFj5knQX7pxPb7liGcMjWk/cre5CKrAopVGipvebuyL87hfrm8bVTPGZYcPtiKmXWYmCdVEeKZLvHJOREgi1nAwyKAFrWGEU+MI1d+muWkThv7+9HemaMsBbb7UiB+g45dSntd4RzBtOuL8k93LiDjVVJWsCbio8dF9TR7daIabd9Y3vLjAKffjuyVS1As9YzOXYVVIlcLy5hE5CWh5jVpgLux2PCh8+iXK6IstY2SX/p7UAkzzZs6y8BXURCni0ZmtQGulQcP8fFR3Cnh3rGg5tIXdFDr2srjL4zdejVWNN/TFcL5DbBk3b7QCfA+naSJfk22yaCj0fZUm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(6916009)(38100700002)(26005)(86362001)(122000001)(53546011)(478600001)(6506007)(8676002)(186003)(966005)(8936002)(2906002)(66446008)(76116006)(316002)(52536014)(66556008)(55016002)(64756008)(54906003)(5660300002)(4326008)(66946007)(33656002)(9686003)(83380400001)(7696005)(38070700005)(66476007)(71200400001)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZ2YVlwOFlCTVZxZzVQNFZTcXJHV2ZiVzhIK0NxMTRqTGx5NEpqdHhHZkll?=
 =?utf-8?B?L3k0WkpVZ2hOaG5yQ092bDdZdEVtN29oTjJTTCtWTVBLMU91UFdHeWxoK3F2?=
 =?utf-8?B?TEh3b1VqQ21QTmUyQlE4YmpLZk9Mb3JJUm5uQ0xiNHhhUTNCcDcwNVFwa3Zw?=
 =?utf-8?B?T2E4TE16VVhQcUdvY3V4eVpoRGprNk1qaWdIMGxXbGIyKzlkME1nTTNHT2Mz?=
 =?utf-8?B?VXNMT21QOGhiR0Nhc3FWcXRsVWQwS2xPckY2MVcxUTJpM1QzWGpwTlVMK0Np?=
 =?utf-8?B?TEExT2E0MXh4SStwbmVud21LMTVPbGhMSkFTbHVMbnNpd05hUjRRUEJNQzVx?=
 =?utf-8?B?bHpyMnBmSU5MbWthV1I5RFllbDluTy9uVlNrNmtLR292ZmIzbjhhS0Z2V0o1?=
 =?utf-8?B?aEFZOTNxMy8yZzBIZkxmdURTR0Uxd3QvMEhFeDN4U001c1NWem9pcVF5KzRG?=
 =?utf-8?B?WTE5VmdIREV3c1h0QWVKc1hEeHFKRURGRFNaZHdBYUI0VHUvc2dtUU9tZUxs?=
 =?utf-8?B?RysxNGtHSVBLTUtZSzlqZmhnVTYwdlQ2dXR0R2RKOVJPcllTVVh0RS9aajBU?=
 =?utf-8?B?SXlOS1oxdE5GTjZ1cFg0c0htb24zYzIzMmNuRGtvdG1wa1NHc0F0SkZyZTll?=
 =?utf-8?B?UXpKc3hVTm9VdmpQUCtXbk9HdWdRQ09yVFp4QkRBajlJRVA3TzBNazhMMDQx?=
 =?utf-8?B?TFYzUGFFRWpIa3VBblNONE12dVFwZFEwVEtxZFY3UW9ycVBpVG5FZEdCbDdv?=
 =?utf-8?B?UHpVNjFNZDhTTi8vZURiUDVURStQZGFEYlFPQXgwSmsxc3FYOUd0a3ZGaFcr?=
 =?utf-8?B?d080U2V5RFlHSnBSbGQ3cVNsRTJ6Um1TalV3bklIY3FRZTlkUng2N2dDeWZG?=
 =?utf-8?B?ZXkxWW4yYmpNU2ZWeGpCTFc3RHpXSk1pU0x6eGEzUUhkY2Uzd2FsMVZnckpz?=
 =?utf-8?B?UDdFbmdmWDNOVjBnUW9sODRGYnFEYUxkM1hTdUNMUUJyd2hSTTNhdGVwQWd6?=
 =?utf-8?B?VDhvYTRvVTlmNkNzcGlBeUw3NWZTLzZaejB0aEVxcDRiUVVmRUVEOEdHUGlm?=
 =?utf-8?B?RHAyVHZrVFhrWGxGejIyZzY5K2ZHQkFiMjlmdDBBL0c5czhYcTNHeDlzSmlJ?=
 =?utf-8?B?V3FReEJpMnk2OHk1M2srNUpyRXQyc3pJcjVmWGFQK2J5aGsxc3JHTjBVOHNt?=
 =?utf-8?B?VHQ5VDdlWDBvTHdHMmx4bExCL0o1SVEvcFJWS0hxT0IyazdQTDk1OWRzVWZs?=
 =?utf-8?B?T0NGdk4xOU01VkdRUlQ5YUdQNzdjWktYVXpQR1lRbVRBQkpwY0pibEowbXIx?=
 =?utf-8?B?dDBPVHlTTjBtWFhLRU9HSS9HcnRBeGpOKzBla2t1MmpZUEVWd2s3ZS9kVG53?=
 =?utf-8?B?UHB6Y1JYMnU1Yit2L3pkWXBJQlBkZkVQWjNxSkt3cnpUT0RMSk9peUdlcnRq?=
 =?utf-8?B?M1I0WXFXY1gvZ1M5cnltQ25EamZIZ1g1c1Z1ZFJRSVZ1YlVieHljSjNJSDZG?=
 =?utf-8?B?T05aN2VBSHBHcHdhbEZlZC9pc3BUcUw3QkJRZHVLMSsvb0NVdDM3My9nVzFZ?=
 =?utf-8?B?aVZZbng2cGsxS09lRTFqeHZqcjdtTU12ZEprTUJLTjNGam1NZTFGTnVsUWts?=
 =?utf-8?B?TTEreHBkbWZMNTR2QVI2a3YwSVVkT2tmL1ZVWWJFT3VlZ2MvYzlpd1BudVBm?=
 =?utf-8?B?WnUzdXowYnozb0ppZnJMclhURGdKUHJXTklEQkJLUlJrUDlIa3BFQ3JjVDZL?=
 =?utf-8?Q?XFszNvR+MvpMb1oN1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b26b8a4-8c9e-4469-44e8-08d96d3f6fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 11:55:47.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNGQl4c1fLVnfO8/HDmtU7OhfrV0m6d8YGjcDA77Q2pKk2RiDyTj//vrQVkuCZxUW6l4p43LiXpl2qqP0i4/n0bOyqpwWJALZSKffMjB+Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgSmlucHUsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KV2Ugd2lsbCBtYWtlIGNoYW5n
ZXMgYWNjb3JkaW5nbHkgaW4gVjIgcGF0Y2ggc2V0IGNvbW1pdCBtZXNzYWdlLg0KDQpUaGFua3Ms
DQpBamlzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmlucHUgV2FuZyA8
amlucHUud2FuZ0Bpb25vcy5jb20+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMzAsIDIwMjEgMDE6
NTIgUE0NClRvOiBBamlzaCBLb3NoeSAtIEkzMDkyMyA8QWppc2guS29zaHlAbWljcm9jaGlwLmNv
bT4NCkNjOiBMaW51eCBTQ1NJIE1haWxpbmdsaXN0IDxsaW51eC1zY3NpQHZnZXIua2VybmVsLm9y
Zz47IFZhc2FudGhhbGFrc2htaSBUaGFybWFyYWphbiAtIEkzMDY2NCA8VmFzYW50aGFsYWtzaG1p
LlRoYXJtYXJhamFuQG1pY3JvY2hpcC5jb20+OyBWaXN3YXMgRyAtIEkzMDY2NyA8Vmlzd2FzLkdA
bWljcm9jaGlwLmNvbT47IFJ1a3NhciBEZXZhZGkgLSBJNTIzMjcgPFJ1a3Nhci5kZXZhZGlAbWlj
cm9jaGlwLmNvbT47IEFzaG9ra3VtYXIgTiAtIFg1MzUzNSA8QXNob2trdW1hci5OQG1pY3JvY2hp
cC5jb20+OyBKaW5wdSBXYW5nIDxqaW5wdS53YW5nQGNsb3VkLmlvbm9zLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi80XSBzY3NpOiBwbTgweHg6IGZpeCBsb2NrdXAgZHVlIHRvIGNvbW1pdCA8
MWYwMmJlZmYyMjRlPg0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGppbnB1Lndh
bmdAaW9ub3MuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cDovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24uXQ0KDQpFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCg0KT24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgOToyOCBBTSBBamlzaCBL
b3NoeSA8QWppc2guS29zaHlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+DQo+IFVwc3RyZWFtIGNv
bW1pdCA8MWYwMmJlZmYyMjRlPiBpbnRyb2R1Y2VkIGEgbG9jayBwZXIgb3V0Ym91bmQgcXVldWUs
IA0KPiB3aGVyZSB0aGUgZHJpdmVyIGJlZm9yZSB0aGF0IHdhcyB1c2luZyBhIGdsb2JhbCBsb2Nr
IGZvciBhbGwgb3V0Ym91bmQgDQo+IHF1ZXVlcy4gV2hpbGUgcHJvY2Vzc2luZyB0aGUgSU8gcmVz
cG9uc2VzIGFuZCBldmVudHMsIGRyaXZlciB0YWtlcyB0aGUgDQo+IG91dGJvdW5kIHF1ZXVlIHNw
aW5sb2NrIGFuZCBsYXRlciBpdCBpcyBzdXBwb3NlZCB0byByZWxlYXNlIHRoZSBzYW1lIA0KPiBz
cGluIGxvY2sgaW4NCj4gcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9uZSgpIGJlZm9yZSBjYWxsaW5n
IGNvbW1hbmQgZG9uZSgpLg0KPiBTaW5jZSB0aGUgb2xkZXIgY29kZSB3YXMgdXNpbmcgYSBnbG9i
YWwgbG9jaywNCj4gcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9uZSgpIHdhcyBhbHNvIHJlbGVhc2lu
ZyB0aGUgZ2xvYmFsIHNwaW4gbG9jay4gDQo+IFdpdGggdGhlIGNvbW1pdCA8MWYwMmJlZmYyMjRl
PiwNCj4gcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9uZSgpIHJlbWFpbnMgdGhlIHNhbWUgYW5kIGl0
IHdhcyBzdGlsbCB1c2luZyANCj4gdGhlIGdsb2JhbCBsb2NrLg0KPg0KPiBTbyB3aGVuIGRyaXZl
ciBjb21wbGV0ZXMgYSBTQVRBIGNvbW1hbmQsdGhlIGdsb2JhbCBzcGlubG9jayB3aWxsIGJlIGlu
IA0KPiBhIGxvY2tlZCBzdGF0ZS4NCj4gbXBpX3NhdGFfY29tcGxldGlvbigpLT5zcGluX2xvY2so
JnBtODAwMV9oYS0+bG9jayk7DQo+DQo+IExhdGVyIHdoZW4gZHJpdmVyIGdldHMgYSBzY3NpIGNv
bW1hbmQgZm9yIFNBVEEgZHJpdmUsDQo+IHBtODAwMV90YXNrX2V4ZWMoKSB0cmllcyB0byBhY3F1
aXJlIHRoZSBnbG9iYWwgbG9jayBhbmQgbGVhZHMgdG8gDQo+IGxvY2t1cCBjcmFzaC4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQWppc2ggS29zaHkgPEFqaXNoLktvc2h5QG1pY3JvY2hpcC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFZpc3dhcyBHIDxWaXN3YXMuR0BtaWNyb2NoaXAuY29tPg0KVGhlIGNv
ZGUgbG9va3MgY29ycmVjdCwganVzdCBwbGVhc2UgcmVmZXIgdGhlIGNvbW1pdCB3aXRoIHN0YW5k
YXJkIHdheSBlZzoNCjFmMDJiZWZmMjI0ZSAoInNjc2k6IHBtODB4eDogUmVtb3ZlIGdsb2JhbCBs
b2NrIGZyb20gb3V0Ym91bmQgcXVldWUgcHJvY2Vzc2luZyIpDQoNClBsZWFzZSBhbHNvIGFkZCB0
aGUgZml4ZXMgdGFnIGFzIGFib3ZlLCBzbyB0aGUgc3RhYmxlIHRyZWUgY2FuIHBpY2sgaXQgdXAu
DQpUaGFua3MhDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Njc2kvcG04MDAxL3BtODAwMV9zYXMuaCB8
ICAzICstICANCj4gZHJpdmVycy9zY3NpL3BtODAwMS9wbTgweHhfaHdpLmMgfCA1MyArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9w
bTgwMDEvcG04MDAxX3Nhcy5oIA0KPiBiL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MDAxX3Nhcy5o
DQo+IGluZGV4IDFhMDE2YTQyMTI4MC4uMzI3NGQ4OGE5Y2NjIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3Njc2kvcG04MDAxL3BtODAwMV9zYXMuaA0KPiArKysgYi9kcml2ZXJzL3Njc2kvcG04MDAx
L3BtODAwMV9zYXMuaA0KPiBAQCAtNDU4LDYgKzQ1OCw3IEBAIHN0cnVjdCBvdXRib3VuZF9xdWV1
ZV90YWJsZSB7DQo+ICAgICAgICAgX19sZTMyICAgICAgICAgICAgICAgICAgcHJvZHVjZXJfaW5k
ZXg7DQo+ICAgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgY29uc3VtZXJfaWR4Ow0KPiAg
ICAgICAgIHNwaW5sb2NrX3QgICAgICAgICAgICAgIG9xX2xvY2s7DQo+ICsgICAgICAgdW5zaWdu
ZWQgbG9uZyAgICAgICAgICAgbG9ja19mbGFnczsNCj4gIH07DQo+ICBzdHJ1Y3QgcG04MDAxX2hi
YV9tZW1zcGFjZSB7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgKm1lbXZpcnRh
ZGRyOw0KPiBAQCAtNzQwLDkgKzc0MSw3IEBAIHBtODAwMV9jY2JfdGFza19mcmVlX2RvbmUoc3Ry
dWN0IHBtODAwMV9oYmFfaW5mbyANCj4gKnBtODAwMV9oYSwgIHsNCj4gICAgICAgICBwbTgwMDFf
Y2NiX3Rhc2tfZnJlZShwbTgwMDFfaGEsIHRhc2ssIGNjYiwgY2NiX2lkeCk7DQo+ICAgICAgICAg
c21wX21iKCk7IC8qaW4gb3JkZXIgdG8gZm9yY2UgQ1BVIG9yZGVyaW5nKi8NCj4gLSAgICAgICBz
cGluX3VubG9jaygmcG04MDAxX2hhLT5sb2NrKTsNCj4gICAgICAgICB0YXNrLT50YXNrX2RvbmUo
dGFzayk7DQo+IC0gICAgICAgc3Bpbl9sb2NrKCZwbTgwMDFfaGEtPmxvY2spOw0KPiAgfQ0KPg0K
PiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvcG04MDAxL3BtODB4eF9od2ku
YyANCj4gYi9kcml2ZXJzL3Njc2kvcG04MDAxL3BtODB4eF9od2kuYw0KPiBpbmRleCBjZWM5MzJm
ODMwYjguLjFhZTJmNWM2MDQyYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3BtODAwMS9w
bTgweHhfaHdpLmMNCj4gKysrIGIvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgweHhfaHdpLmMNCj4g
QEAgLTIzNzksNyArMjM3OSw4IEBAIHN0YXRpYyB2b2lkIG1waV9zc3BfZXZlbnQoc3RydWN0IHBt
ODAwMV9oYmFfaW5mbyANCj4gKnBtODAwMV9oYSwgdm9pZCAqcGlvbWIpDQo+DQo+ICAvKlNlZSB0
aGUgY29tbWVudHMgZm9yIG1waV9zc3BfY29tcGxldGlvbiAqLyAgc3RhdGljIHZvaWQgDQo+IC1t
cGlfc2F0YV9jb21wbGV0aW9uKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8gKnBtODAwMV9oYSwgdm9p
ZCAqcGlvbWIpDQo+ICttcGlfc2F0YV9jb21wbGV0aW9uKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8g
KnBtODAwMV9oYSwNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBvdXRib3VuZF9xdWV1ZV90YWJs
ZSAqY2lyY3VsYXJRLCB2b2lkICpwaW9tYikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3Qgc2FzX3Rh
c2sgKnQ7DQo+ICAgICAgICAgc3RydWN0IHBtODAwMV9jY2JfaW5mbyAqY2NiOw0KPiBAQCAtMjYx
Niw3ICsyNjE3LDExIEBAIG1waV9zYXRhX2NvbXBsZXRpb24oc3RydWN0IHBtODAwMV9oYmFfaW5m
byAqcG04MDAxX2hhLCB2b2lkICpwaW9tYikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBJT19PUEVOX0NOWF9FUlJPUl9JVF9ORVhVU19MT1NTKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgdHMtPnJlc3AgPSBTQVNfVEFTS19VTkRFTElWRVJFRDsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgdHMtPnN0YXQgPSBTQVNfUVVFVUVfRlVMTDsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2lyY3VsYXJRLT5vcV9sb2NrLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2Zs
YWdzKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9u
ZShwbTgwMDFfaGEsIHQsIGNjYiwgDQo+IHRhZyk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5fbG9ja19pcnFzYXZlKCZjaXJjdWxhclEtPm9xX2xvY2ssDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjaXJjdWxhclEtPmxvY2tfZmxhZ3MpOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gQEAgLTI2MzIsNyArMjYzNywxMSBAQCBtcGlfc2F0YV9jb21w
bGV0aW9uKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8gKnBtODAwMV9oYSwgdm9pZCAqcGlvbWIpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9fT1BFTl9DTlhfRVJST1JfSVRfTkVY
VVNfTE9TUyk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRzLT5yZXNwID0gU0FTX1RBU0tf
VU5ERUxJVkVSRUQ7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRzLT5zdGF0ID0gU0FTX1FV
RVVFX0ZVTEw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmNpcmN1bGFyUS0+b3FfbG9jaywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNpcmN1bGFyUS0+bG9ja19mbGFncyk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHBtODAwMV9jY2JfdGFza19mcmVlX2RvbmUocG04MDAxX2hhLCB0LCBjY2IsIA0KPiB0YWcp
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmY2lyY3VsYXJR
LT5vcV9sb2NrLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2ly
Y3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IEBAIC0yNjU2
LDcgKzI2NjUsMTEgQEAgbXBpX3NhdGFfY29tcGxldGlvbihzdHJ1Y3QgcG04MDAxX2hiYV9pbmZv
ICpwbTgwMDFfaGEsIHZvaWQgKnBpb21iKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElPX09QRU5fQ05YX0VSUk9SX1NUUF9SRVNPVVJDRVNfQlVTWSk7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHRzLT5yZXNwID0gU0FTX1RBU0tfVU5ERUxJVkVSRUQ7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHRzLT5zdGF0ID0gU0FTX1FVRVVFX0ZVTEw7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNpcmN1bGFyUS0+b3FfbG9jaywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNpcmN1bGFyUS0+bG9j
a19mbGFncyk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBtODAwMV9jY2JfdGFza19mcmVl
X2RvbmUocG04MDAxX2hhLCB0LCBjY2IsIA0KPiB0YWcpOw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmY2lyY3VsYXJRLT5vcV9sb2NrLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+IEBAIC0yNzI3LDcgKzI3NDAsMTEgQEAgbXBpX3NhdGFf
Y29tcGxldGlvbihzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEsIHZvaWQgKnBpb21i
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9fRFNfTk9OX09Q
RVJBVElPTkFMKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdHMtPnJlc3AgPSBTQVNfVEFT
S19VTkRFTElWRVJFRDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdHMtPnN0YXQgPSBTQVNf
UVVFVUVfRlVMTDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmY2lyY3VsYXJRLT5vcV9sb2NrLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9uZShwbTgwMDFfaGEsIHQsIGNjYiwgDQo+IHRh
Zyk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZjaXJjdWxh
clEtPm9xX2xvY2ssDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
aXJjdWxhclEtPmxvY2tfZmxhZ3MpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47
DQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gQEAgLTI3
NDcsNyArMjc2NCwxMSBAQCBtcGlfc2F0YV9jb21wbGV0aW9uKHN0cnVjdCBwbTgwMDFfaGJhX2lu
Zm8gKnBtODAwMV9oYSwgdm9pZCAqcGlvbWIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJT19EU19JTl9FUlJPUik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHRzLT5yZXNwID0gU0FTX1RBU0tfVU5ERUxJVkVSRUQ7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHRzLT5zdGF0ID0gU0FTX1FVRVVFX0ZVTEw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNpcmN1bGFyUS0+b3FfbG9jaywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNpcmN1bGFyUS0+bG9ja19mbGFncyk7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHBtODAwMV9jY2JfdGFza19mcmVlX2RvbmUocG04MDAx
X2hhLCB0LCBjY2IsIA0KPiB0YWcpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xv
Y2tfaXJxc2F2ZSgmY2lyY3VsYXJRLT5vcV9sb2NrLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+IEBAIC0yNzg1LDEyICsyODA2LDE3IEBAIG1waV9zYXRhX2NvbXBsZXRpb24o
c3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLCB2b2lkICpwaW9tYikNCj4gICAgICAg
ICAgICAgICAgIHBtODAwMV9jY2JfdGFza19mcmVlKHBtODAwMV9oYSwgdCwgY2NiLCB0YWcpOw0K
PiAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ0LT50YXNrX3N0YXRlX2xvY2ssIGZsYWdzKTsNCj4gKyAgICAgICAgICAgICAgIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmNpcmN1bGFyUS0+b3FfbG9jaywNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjaXJjdWxhclEtPmxvY2tfZmxhZ3MpOw0KPiAgICAgICAgICAgICAg
ICAgcG04MDAxX2NjYl90YXNrX2ZyZWVfZG9uZShwbTgwMDFfaGEsIHQsIGNjYiwgdGFnKTsNCj4g
KyAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZjaXJjdWxhclEtPm9xX2xvY2ssDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsN
Cj4gICAgICAgICB9DQo+ICB9DQo+DQo+ICAvKlNlZSB0aGUgY29tbWVudHMgZm9yIG1waV9zc3Bf
Y29tcGxldGlvbiAqLyAtc3RhdGljIHZvaWQgDQo+IG1waV9zYXRhX2V2ZW50KHN0cnVjdCBwbTgw
MDFfaGJhX2luZm8gKnBtODAwMV9oYSwgdm9pZCAqcGlvbWIpDQo+ICtzdGF0aWMgdm9pZCBtcGlf
c2F0YV9ldmVudChzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEsDQo+ICsgICAgICAg
ICAgICAgICBzdHJ1Y3Qgb3V0Ym91bmRfcXVldWVfdGFibGUgKmNpcmN1bGFyUSwgdm9pZCAqcGlv
bWIpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IHNhc190YXNrICp0Ow0KPiAgICAgICAgIHN0cnVj
dCB0YXNrX3N0YXR1c19zdHJ1Y3QgKnRzOyBAQCAtMjg5MCw3ICsyOTE2LDExIEBAIHN0YXRpYyAN
Cj4gdm9pZCBtcGlfc2F0YV9ldmVudChzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEs
IHZvaWQgKnBpb21iKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPX09QRU5f
Q05YX0VSUk9SX0lUX05FWFVTX0xPU1MpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0cy0+
cmVzcCA9IFNBU19UQVNLX0NPTVBMRVRFOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0cy0+
c3RhdCA9IFNBU19RVUVVRV9GVUxMOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZjaXJjdWxhclEtPm9xX2xvY2ssDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjaXJjdWxhclEtPmxvY2tfZmxhZ3MpOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwbTgwMDFfY2NiX3Rhc2tfZnJlZV9kb25lKHBtODAwMV9oYSwgdCwg
Y2NiLCANCj4gdGFnKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJmNpcmN1bGFyUS0+b3FfbG9jaywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNpcmN1bGFyUS0+bG9ja19mbGFncyk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybjsNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiBAQCAtMzAwMiw3ICszMDMyLDExIEBAIHN0YXRpYyB2b2lkIG1waV9zYXRhX2V2ZW50KHN0
cnVjdCBwbTgwMDFfaGJhX2luZm8gKnBtODAwMV9oYSwgdm9pZCAqcGlvbWIpDQo+ICAgICAgICAg
ICAgICAgICBwbTgwMDFfY2NiX3Rhc2tfZnJlZShwbTgwMDFfaGEsIHQsIGNjYiwgdGFnKTsNCj4g
ICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmdC0+dGFza19zdGF0ZV9sb2NrLCBmbGFncyk7DQo+ICsgICAgICAgICAgICAgICBzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZjaXJjdWxhclEtPm9xX2xvY2ssDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4gICAgICAgICAgICAgICAg
IHBtODAwMV9jY2JfdGFza19mcmVlX2RvbmUocG04MDAxX2hhLCB0LCBjY2IsIHRhZyk7DQo+ICsg
ICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmY2lyY3VsYXJRLT5vcV9sb2NrLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNpcmN1bGFyUS0+bG9ja19mbGFncyk7DQo+
ICAgICAgICAgfQ0KPiAgfQ0KPg0KPiBAQCAtMzkwNiw3ICszOTQwLDggQEAgc3RhdGljIGludCBz
c3BfY29hbGVzY2VkX2NvbXBfcmVzcChzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEs
DQo+ICAgKiBAcG04MDAxX2hhOiBvdXIgaGJhIGNhcmQgaW5mb3JtYXRpb24NCj4gICAqIEBwaW9t
YjogSU8gbWVzc2FnZSBidWZmZXINCj4gICAqLw0KPiAtc3RhdGljIHZvaWQgcHJvY2Vzc19vbmVf
aW9tYihzdHJ1Y3QgcG04MDAxX2hiYV9pbmZvICpwbTgwMDFfaGEsIHZvaWQgDQo+ICpwaW9tYikN
Cj4gK3N0YXRpYyB2b2lkIHByb2Nlc3Nfb25lX2lvbWIoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAq
cG04MDAxX2hhLA0KPiArICAgICAgICAgICAgICAgc3RydWN0IG91dGJvdW5kX3F1ZXVlX3RhYmxl
ICpjaXJjdWxhclEsIHZvaWQgKnBpb21iKQ0KPiAgew0KPiAgICAgICAgIF9fbGUzMiBwSGVhZGVy
ID0gKihfX2xlMzIgKilwaW9tYjsNCj4gICAgICAgICB1MzIgb3BjID0gKHUzMikoKGxlMzJfdG9f
Y3B1KHBIZWFkZXIpKSAmIDB4RkZGKTsgQEAgLTM5NDgsMTEgDQo+ICszOTgzLDExIEBAIHN0YXRp
YyB2b2lkIHByb2Nlc3Nfb25lX2lvbWIoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hh
LCB2b2lkICpwaW9tYikNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2Ug
T1BDX09VQl9TQVRBX0NPTVA6DQo+ICAgICAgICAgICAgICAgICBwbTgwMDFfZGJnKHBtODAwMV9o
YSwgTVNHLCAiT1BDX09VQl9TQVRBX0NPTVBcbiIpOw0KPiAtICAgICAgICAgICAgICAgbXBpX3Nh
dGFfY29tcGxldGlvbihwbTgwMDFfaGEsIHBpb21iKTsNCj4gKyAgICAgICAgICAgICAgIG1waV9z
YXRhX2NvbXBsZXRpb24ocG04MDAxX2hhLCBjaXJjdWxhclEsIHBpb21iKTsNCj4gICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2UgT1BDX09VQl9TQVRBX0VWRU5UOg0KPiAgICAg
ICAgICAgICAgICAgcG04MDAxX2RiZyhwbTgwMDFfaGEsIE1TRywgIk9QQ19PVUJfU0FUQV9FVkVO
VFxuIik7DQo+IC0gICAgICAgICAgICAgICBtcGlfc2F0YV9ldmVudChwbTgwMDFfaGEsIHBpb21i
KTsNCj4gKyAgICAgICAgICAgICAgIG1waV9zYXRhX2V2ZW50KHBtODAwMV9oYSwgY2lyY3VsYXJR
LCBwaW9tYik7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICBjYXNlIE9QQ19P
VUJfU1NQX0VWRU5UOg0KPiAgICAgICAgICAgICAgICAgcG04MDAxX2RiZyhwbTgwMDFfaGEsIE1T
RywgIk9QQ19PVUJfU1NQX0VWRU5UXG4iKTsgQEAgDQo+IC00MTIxLDcgKzQxNTYsNiBAQCBzdGF0
aWMgaW50IHByb2Nlc3Nfb3Eoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hhLCB1OCB2
ZWMpDQo+ICAgICAgICAgdm9pZCAqcE1zZzEgPSBOVUxMOw0KPiAgICAgICAgIHU4IGJjOw0KPiAg
ICAgICAgIHUzMiByZXQgPSBNUElfSU9fU1RBVFVTX0ZBSUw7DQo+IC0gICAgICAgdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gICAgICAgICB1MzIgcmVndmFsOw0KPg0KPiAgICAgICAgIGlmICh2ZWMg
PT0gKHBtODAwMV9oYS0+bWF4X3FfbnVtIC0gMSkpIHsgQEAgLTQxMzgsNyArNDE3Miw3IEBAIA0K
PiBzdGF0aWMgaW50IHByb2Nlc3Nfb3Eoc3RydWN0IHBtODAwMV9oYmFfaW5mbyAqcG04MDAxX2hh
LCB1OCB2ZWMpDQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAgICAgICAgIGNp
cmN1bGFyUSA9ICZwbTgwMDFfaGEtPm91dGJuZF9xX3RibFt2ZWNdOw0KPiAtICAgICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZjaXJjdWxhclEtPm9xX2xvY2ssIGZsYWdzKTsNCj4gKyAgICAgICBzcGlu
X2xvY2tfaXJxc2F2ZSgmY2lyY3VsYXJRLT5vcV9sb2NrLCBjaXJjdWxhclEtPmxvY2tfZmxhZ3Mp
Ow0KPiAgICAgICAgIGRvIHsNCj4gICAgICAgICAgICAgICAgIC8qIHNwdXJpb3VzIGludGVycnVw
dCBkdXJpbmcgc2V0dXAgaWYga2V4ZWMtaW5nIGFuZA0KPiAgICAgICAgICAgICAgICAgICogZHJp
dmVyIGRvaW5nIGEgZG9vcmJlbGwgYWNjZXNzIHcvIHRoZSBwcmUta2V4ZWMgb3EgDQo+IEBAIC00
MTQ5LDcgKzQxODMsOCBAQCBzdGF0aWMgaW50IHByb2Nlc3Nfb3Eoc3RydWN0IHBtODAwMV9oYmFf
aW5mbyAqcG04MDAxX2hhLCB1OCB2ZWMpDQo+ICAgICAgICAgICAgICAgICByZXQgPSBwbTgwMDFf
bXBpX21zZ19jb25zdW1lKHBtODAwMV9oYSwgY2lyY3VsYXJRLCAmcE1zZzEsICZiYyk7DQo+ICAg
ICAgICAgICAgICAgICBpZiAoTVBJX0lPX1NUQVRVU19TVUNDRVNTID09IHJldCkgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBwcm9jZXNzIHRoZSBvdXRib3VuZCBtZXNzYWdlICovDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHByb2Nlc3Nfb25lX2lvbWIocG04MDAxX2hhLCAodm9p
ZCAqKShwTXNnMSAtIDQpKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJvY2Vzc19vbmVf
aW9tYihwbTgwMDFfaGEsIGNpcmN1bGFyUSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKikocE1zZzEgLSA0KSk7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qIGZyZWUgdGhlIG1lc3NhZ2UgZnJvbSB0aGUgb3V0Ym91bmQgY2lyY3Vs
YXIgYnVmZmVyICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBtODAwMV9tcGlfbXNnX2Zy
ZWVfc2V0KHBtODAwMV9oYSwgcE1zZzEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2lyY3VsYXJRLCANCj4gYmMpOyBAQCAtNDE2NCw3
ICs0MTk5LDcgQEAgc3RhdGljIGludCBwcm9jZXNzX29xKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8g
KnBtODAwMV9oYSwgdTggdmVjKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0gd2hpbGUgKDEpOw0KPiAtICAg
ICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNpcmN1bGFyUS0+b3FfbG9jaywgZmxhZ3MpOw0K
PiArICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNpcmN1bGFyUS0+b3FfbG9jaywgDQo+
ICsgY2lyY3VsYXJRLT5sb2NrX2ZsYWdzKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0K
Pg0KPiAtLQ0KPiAyLjI3LjANCj4NCg==
