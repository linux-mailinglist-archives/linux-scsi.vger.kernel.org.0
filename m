Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F05792EE
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 20:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfG2STY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 14:19:24 -0400
Received: from us-smtp-delivery-107.mimecast.com ([63.128.21.107]:26923 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729123AbfG2STY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 14:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com;
        s=mimecast20180821; t=1564424362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1/91h50K5gnhTZriE/GgKKkatAyvn31FP0X0rMOjAM=;
        b=KTUrTMtPa8U8cHJhxcC9wPAmQT9RO9+8NWf0b+DCj36VirKuZVmeqmrSJQZPFf1e4YWQRi
        PqpsIEkVGsfs0K9pXEAX8NbxAXKZQfh8OYu5MxznDwQUPEubRngjXni4kr7zJ3USXSh3Kv
        KbrBW1x5dsUZSW+uvV1V3Z6jT+4qIEs=
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam05lp2054.outbound.protection.outlook.com [104.47.50.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-boFmke7rN3OgtI5aE1_3ew-1; Mon, 29 Jul 2019 14:18:18 -0400
Received: from DM6PR01MB3674.prod.exchangelabs.com (20.176.69.140) by
 DM6PR01MB4090.prod.exchangelabs.com (20.176.105.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Mon, 29 Jul 2019 18:18:16 +0000
Received: from DM6PR01MB3674.prod.exchangelabs.com
 ([fe80::bd8a:a988:374e:2e3b]) by DM6PR01MB3674.prod.exchangelabs.com
 ([fe80::bd8a:a988:374e:2e3b%5]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 18:18:16 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
CC:     linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: Mark expected switch fall-throughs
Thread-Topic: [PATCH] scsi: ibmvscsi_tgt: Mark expected switch fall-throughs
Thread-Index: AQHVRgPdiOzLCs+KY0WIiAZngZu4Uqbh5/KA
Date:   Mon, 29 Jul 2019 18:18:16 +0000
Message-ID: <2F37FBA0-0AD3-49AB-8FF7-551421F46441@catalogicsoftware.com>
References: <20190729112902.GA3768@embeddedor>
In-Reply-To: <20190729112902.GA3768@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edb05785-0d91-4ffc-02aa-08d714512091
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR01MB4090;
x-ms-traffictypediagnostic: DM6PR01MB4090:
x-microsoft-antispam-prvs: <DM6PR01MB409058AB9BB91D72952B7042B4DD0@DM6PR01MB4090.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:20;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(376002)(396003)(136003)(189003)(199004)(26005)(1671002)(11346002)(102836004)(2616005)(476003)(446003)(4326008)(7736002)(6246003)(316002)(486006)(25786009)(64756008)(6486002)(450100002)(99286004)(229853002)(66946007)(14444005)(6506007)(33656002)(186003)(76176011)(53936002)(66556008)(71200400001)(71190400001)(66476007)(66446008)(109986005)(91956017)(76116006)(86362001)(256004)(6436002)(8936002)(81166006)(81156014)(5660300002)(14454004)(6512007)(53546011)(8676002)(68736007)(305945005)(59246006)(478600001)(2906002)(54906003)(66066001)(3846002)(36756003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4090;H:DM6PR01MB3674.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cj/uO0O6TMgkV91iW6ai3LH/6F+EuYSAHzUftARUnA4ypKVbb2TFnwSz5QWSq91kTPablzzN5AXzspsSgL4LzG9hq35ZIkqgJCk0M9R+4wxszVESI208G9RUR4ChpODlw8z+MqsJfnYO7AZCoSwknBkJ7UXCXpe7IOPWmy4Zh3GL9o6My679zo1G/EPAPCGWQVE5Bg3NK0WdYmkjtdsu8TObM0FVqeGJAM9prS8wkseKWRyPwlsm8NgAN/drAm00fcZShJ+cQ8t4lJ2g9rjp0Sfnt+wlEgXcfFxGNo4/zq7MPsjmMiCCtmbmWidfefNVl/eiTyr2gtu2uT/V8t7ZGNrKt2gbaFxrxelLIpZwnYoIDzeV8rfEvLn6euzcz3F/GtSPoF5vV3KwY1cuwd/E/1jDoq5yCaU8nH1jdIkVnVc=
Content-ID: <A58307AFDBAF1547B613295B6BC7F4C5@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb05785-0d91-4ffc-02aa-08d714512091
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:18:16.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bly@catalogicsoftware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4090
X-MC-Unique: boFmke7rN3OgtI5aE1_3ew-1
X-Mimecast-Spam-Score: 2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQoNCj4gT24gSnVsIDI5LCAyMDE5LCBhdCA2OjI5IEFNLCBHdXN0YXZvIEEuIFIuIFNpbHZhIDxn
dXN0YXZvQGVtYmVkZGVkb3IuY29tPiB3cm90ZToNCj4gDQo+IE1hcmsgc3dpdGNoIGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzIChCdWlsZGluZzogcG93ZXJwYyBhbGx5ZXNjb25m
aWcpOg0KPiANCj4gZHJpdmVycy9zY3NpL2libXZzY3NpX3RndC9pYm12c2NzaV90Z3QuYzogSW4g
ZnVuY3Rpb24gJ2libXZzY3Npc19hZGFwdGVyX2luZm8nOg0KPiBkcml2ZXJzL3Njc2kvaWJtdnNj
c2lfdGd0L2libXZzY3NpX3RndC5jOjE1ODI6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5
IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgaWYgKGNvbm5lY3Rp
b25fYnJva2VuKHZzY3NpKSkNCj4gICAgICBeDQo+IGRyaXZlcnMvc2NzaS9pYm12c2NzaV90Z3Qv
aWJtdnNjc2lfdGd0LmM6MTU4NDoyOiBub3RlOiBoZXJlDQo+ICBkZWZhdWx0Og0KPiAgXn5+fn5+
fg0KPiBkcml2ZXJzL3Njc2kvaWJtdnNjc2lfdGd0L2libXZzY3NpX3RndC5jOiBJbiBmdW5jdGlv
biAnaWJtdnNjc2lzX3BpbmdfcmVzcG9uc2UnOg0KPiBkcml2ZXJzL3Njc2kvaWJtdnNjc2lfdGd0
L2libXZzY3NpX3RndC5jOjI0OTQ6MTY6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxs
IHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0KPiAgIHZzY3NpLT5mbGFncyB8PSBD
TElFTlRfRkFJTEVEOw0KPiBkcml2ZXJzL3Njc2kvaWJtdnNjc2lfdGd0L2libXZzY3NpX3RndC5j
OjI0OTU6Mjogbm90ZTogaGVyZQ0KPiAgY2FzZSBIX0RST1BQRUQ6DQo+ICBefn5+DQo+IGRyaXZl
cnMvc2NzaS9pYm12c2NzaV90Z3QvaWJtdnNjc2lfdGd0LmM6MjQ5NjoxNjogd2FybmluZzogdGhp
cyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+
ICAgdnNjc2ktPmZsYWdzIHw9IFJFU1BPTlNFX1FfRE9XTjsNCj4gZHJpdmVycy9zY3NpL2libXZz
Y3NpX3RndC9pYm12c2NzaV90Z3QuYzoyNDk3OjI6IG5vdGU6IGhlcmUNCj4gIGNhc2UgSF9SRU1P
VEVfUEFSTToNCj4gIF5+fn4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBTdGVwaGVuIFJvdGh3ZWxsIDxz
ZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2
YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4g4oCUDQoNClJldmlld2VkLWJ5OiBCcnlhbnQg
Ry4gTHkgPGJseUBjYXRhbG9naWNzb2Z0d2FyZS5jb20+DQoNCihQcmV2aW91cyBpYm12c2NzaXNf
dGd0IG1haW50YWluZXIsIE1pa2UgZG9lc27igJl0IGNoZWNrIGhpcyBsaW51eCBlbWFpbCBvZnRl
biBhbmQgbWlnaHQgbm90IHNlZSB0aGlzKQ0KDQotQnJ5YW50DQoNCg==

