Return-Path: <linux-scsi+bounces-23660-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMSpL9S1+mk/SAMAu9opvQ
	(envelope-from <linux-scsi+bounces-23660-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 05:30:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE34D5E54
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 05:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8285301F3CB
	for <lists+linux-scsi@lfdr.de>; Wed,  6 May 2026 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808752ED860;
	Wed,  6 May 2026 03:30:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0E2E541F;
	Wed,  6 May 2026 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778038219; cv=none; b=BHF4QiJ3TFJqXRpJoMYMH1vo3uR5Ev35NhcIxS2EL6aarCDwvxIgB3ocpxkgmy3VEdZRoA2KazmELnf9/ARpTAa4tjk3jnjOttiwooSQhUG4d5AgCgVXNcU//0GK/ETM158lBS4i7RNLTfaujTUuLn0PO9U0Gg6NHoBRI5yNwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778038219; c=relaxed/simple;
	bh=oqD5909smyDRI/Uhfc79pzY4boEVs25ZEDD8pMrbP3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvBF1RtD+SlxG5e18M8kR3RT7rqPDybSZZOW+HFipxTr1+ZI0/+w0OLq0lBdlGztmmQWVYPVE16zSYs3ZL8JjmNtVRq/a+I77a+ZVRZKVIS23+sDwHWMgE8AksoOd4MUz1LLTGGj+b9HCJiKVGdRXsvKiTobJUJlKj400WuMMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch02.asrmicro.com (exch02.asrmicro.com [10.1.24.122])
	by spam.asrmicro.com with ESMTPS id 6463Tdls044797
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 6 May 2026 11:29:39 +0800 (GMT-8)
	(envelope-from hongjiefang@asrmicro.com)
Received: from exch02.asrmicro.com (10.1.24.122) by exch02.asrmicro.com
 (10.1.24.122) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 6 May
 2026 11:29:41 +0800
Received: from exch02.asrmicro.com ([::1]) by exch02.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Wed, 6 May 2026 11:29:41 +0800
From: =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= <hongjiefang@asrmicro.com>
To: Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] scsi: ufs: core: call hibern8 notify when hibern8
 cmd failed
Thread-Topic: [PATCH v5] scsi: ufs: core: call hibern8 notify when hibern8
 cmd failed
Thread-Index: AQHc3Fofud/MF+W+vEKD4imTEpLr3LYAVKsA
Date: Wed, 6 May 2026 03:29:40 +0000
Message-ID: <67965bf50abc4300ac9bd3aced2f18d8@exch02.asrmicro.com>
References: <20260502143012.2859480-1-hongjiefang@asrmicro.com>
 <897db8bf4c82af97cd7bbb2b908bb9e2654b3103.camel@iokpp.de>
In-Reply-To: <897db8bf4c82af97cd7bbb2b908bb9e2654b3103.camel@iokpp.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 6463Tdls044797
X-Rspamd-Queue-Id: 64EE34D5E54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23660-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[asrmicro.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongjiefang@asrmicro.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]

DQo+IEZyb206IEJlYW4gSHVvIFttYWlsdG86YmVhbmh1b0Bpb2twcC5kZV0NCj4gU2VudDogVHVl
c2RheSwgTWF5IDUsIDIwMjYgMjo0MSBQTQ0KPiBUbzogRmFuZyBIb25namllIDxob25namllZmFu
Z0Bhc3JtaWNyby5jb20+Ow0KPiBhbGltLmFraHRhckBzYW1zdW5nLmNvbTsgYXZyaS5hbHRtYW5A
d2RjLmNvbTsgYnZhbmFzc2NoZUBhY20ub3JnOw0KPiBKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFy
dG5lcnNoaXAuY29tOyBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0KPiBDYzogbGludXgtc2Nz
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NV0gc2NzaTogdWZzOiBjb3JlOiBjYWxsIGhpYmVybjggbm90aWZ5IHdo
ZW4gaGliZXJuOCBjbWQNCj4gZmFpbGVkDQo+IA0KPiBPbiBTYXQsIDIwMjYtMDUtMDIgYXQgMjI6
MzAgKzA4MDAsIEhvbmdqaWUgRmFuZyB3cm90ZToNCj4gPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0
Og0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgfQ0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3Vmcy91ZnNoY2QuaCBiL2luY2x1ZGUvdWZzL3Vmc2hjZC5oDQo+ID4g
aW5kZXggODU2M2I2NjQ4OTc2Li40ZjdjNjE5ZGIzMjQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS91ZnMvdWZzaGNkLmgNCj4gPiArKysgYi9pbmNsdWRlL3Vmcy91ZnNoY2QuaA0KPiA+IEBAIC0y
NzAsNiArMjcwLDcgQEAgc3RydWN0IHVmc19jbGtfaW5mbyB7DQo+ID4gwqBlbnVtIHVmc19ub3Rp
ZnlfY2hhbmdlX3N0YXR1cyB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoFBSRV9DSEFOR0UsDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoFBPU1RfQ0hBTkdFLA0KPiA+ICvCoMKgwqDCoMKgwqDCoFJPTExCQUNL
X0NIQU5HRSwNCj4gPiDCoH07DQo+ID4NCj4gPiDCoHN0cnVjdCB1ZnNfcGFfbGF5ZXJfYXR0ciB7
DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gDQo+IENvdWxkIHlvdSBpbmNsdWRlIHRoZSBwbGF0Zm9y
bSBkcml2ZXIgdGhhdCBhY3R1YWxseSBoYW5kbGVzDQo+IFJPTExCQUNLX0NIQU5HRSBpbg0KPiB0
aGlzIHNlcmllcz8gQWRkaW5nICB0aGlzIG5ldyByb2xsYmFja19jaGFuZ2Ugd2l0aG91dCBhbiB1
c2FnZSBtYWtlcyBpdCBoYXJkDQo+IHRvICB2ZXJpZnkgdGhlIGRlc2lnbiBpcyBjb3JyZWN0Lg0K
PiANCg0KVGhlIHBsYXRmb3JtIGRyaXZlciBjb2RlIGlzIHN0aWxsIHVuZGVyIGRldmVsb3BtZW50
LCBhbmQgd2UgcGxhbiB0byBzdWJtaXQgaXQNCmluIHRoZSBmdXR1cmUuIFRoZSBwdXJwb3NlIG9m
IHRoaXMgcGF0Y2ggaXMgdG8gZmlyc3QgcHJvdmlkZSBhIG1lY2hhbmlzbSB0aGF0DQphbGxvd3Mg
dmVuZG9yIGNhbGxiYWNrcyBwZXJmb3JtIHJlbGV2YW50IHJvbGxiYWNrIHdoZW4gaGliZXJuOCBm
YWlscy4NCg0KPiBLaW5kIHJlZ2FyZHMsDQo+IEJlYW4NCg0KQmVzdC4NCg0K

