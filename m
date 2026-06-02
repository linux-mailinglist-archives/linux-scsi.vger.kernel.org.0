Return-Path: <linux-scsi+bounces-24357-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIYdM8dfHmo/iwkAu9opvQ
	(envelope-from <linux-scsi+bounces-24357-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 06:44:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 463A26282A8
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 06:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CFB23029746
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jun 2026 04:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CFD2DC350;
	Tue,  2 Jun 2026 04:43:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC71A681B;
	Tue,  2 Jun 2026 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375406; cv=none; b=HdPfPXG2QAE7FttBDiRcL05a9eknPUCvfuHQhtNLK3TTVeMV1mJCPw/3n1J8q7c0/T8ti7PxyZGS+X5AJ6I9p/7wCOAAQyLanAdyco3SbswN7TtYuyY21wQ9/zVhG0uZyr2MUYmj1crL/PNFZfN4itor5zZP7WSzyNEuKS2pdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375406; c=relaxed/simple;
	bh=DQbD86EAaR+AbloyTT128cCPXbevYTgQwsV6+1GHiIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HJUA5eUy81w5sJz0R40SSlTefxthDDRatwVexH2dKQWSjLb4JVT8JGDPCuNCnz2lvFVCScmRdbdM8+v9NHkyfdBaKzlPR4N2Q6dya3cHs89cEhGfKJtr+R+CCbqFzRggxNqU4RXbqRDIV7CMyx5rN+YYdpSLelLjnedABCxnxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch02.asrmicro.com (exch02.asrmicro.com [10.1.24.122])
	by spam.asrmicro.com with ESMTPS id 6524gY02034112
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Tue, 2 Jun 2026 12:42:34 +0800 (GMT-8)
	(envelope-from hongjiefang@asrmicro.com)
Received: from exch02.asrmicro.com (10.1.24.122) by exch02.asrmicro.com
 (10.1.24.122) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 2 Jun
 2026 12:42:36 +0800
Received: from exch02.asrmicro.com ([::1]) by exch02.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Tue, 2 Jun 2026 12:42:36 +0800
From: =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= <hongjiefang@asrmicro.com>
To: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>,
        "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] scsi: ufs: core: handle PM SSU timeout before SCSI EH
Thread-Topic: [PATCH v3] scsi: ufs: core: handle PM SSU timeout before SCSI
 EH
Thread-Index: AQHc8YM5kTD4w00lK0W0zHRuj40B8rYpeauAgAEdvbCAAAAlAA==
Date: Tue, 2 Jun 2026 04:42:36 +0000
Message-ID: <4bb33ee3a8ba462fa1007334e9d95fba@exch02.asrmicro.com>
References: <20260601045658.1232848-1-hongjiefang@asrmicro.com>
 <c3f4df6820edbdcaa04622f7fc06fa706a685163.camel@mediatek.com>
 <a8867cc460c44391bd942f0708cc2037@exch02.asrmicro.com>
In-Reply-To: <a8867cc460c44391bd942f0708cc2037@exch02.asrmicro.com>
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
X-MAIL:spam.asrmicro.com 6524gY02034112
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-24357-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[asrmicro.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongjiefang@asrmicro.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 463A26282A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+ID4gQEAgLTY1MTcsNiArNjU0OCw4IEBAIHN0YXRpYyB2b2lkIHVmc2hjZF9jb21wbGV0ZV9y
ZXF1ZXN0cyhzdHJ1Y3QNCj4gPiB1ZnNfaGJhICpoYmEsIGJvb2wgZm9yY2VfY29tcGwpDQo+ID4g
wqB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGhiYS0+bWNxX2VuYWJsZWQpDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVmc2hjZF9tY3FfY29tcGxfcGVuZGluZ190cmFuc2Zl
cihoYmEsIGZvcmNlX2NvbXBsKTsNCj4gPiArwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGZvcmNlX2Nv
bXBsKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVmc2hjZF9mb3JjZV9jb21w
bF9wZW5kaW5nX3RyYW5zZmVyKGhiYSk7DQo+ID4NCj4gDQo+IEhpIEhvbmdqaWUsDQo+IA0KPiBX
aHkgd2lsbCBhbiBTU1UgdGltZW91dCBpbnZva2UgdWZzaGNkX2NvbXBsZXRlX3JlcXVlc3RzDQo+
IGlmIFNDU0lfRUhfRE9ORSBpcyByZXR1cm5lZCBpbiB1ZnNoY2RfZWhfdGltZWRfb3V0Pw0KPiAN
CkFuIFNTVSB0aW1lb3V0IHJlYWNoZXMgdWZzaGNkX2NvbXBsZXRlX3JlcXVlc3RzKGhiYSwgdHJ1
ZSkgdGhyb3VnaCB0aGUNCmRpcmVjdCByZWNvdmVyeSBwYXRoOg0KICAgIHVmc2hjZF9laF90aW1l
ZF9vdXQoKQ0KICAgICAgICB1ZnNoY2RfbGlua19yZWNvdmVyeSgpDQogICAgICAgICAgICB1ZnNo
Y2RfaG9zdF9yZXNldF9hbmRfcmVzdG9yZSgpDQogICAgICAgICAgICAgICAgdWZzaGNkX2NvbXBs
ZXRlX3JlcXVlc3RzKGhiYSwgdHJ1ZSkNCg0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVmc2hjZF90cmFuc2Zlcl9yZXFfY29t
cGwoaGJhKTsNCj4gPg0KPiA+IEBAIC05NDY2LDcgKzk0OTksNyBAQCBzdGF0aWMgZW51bSBzY3Np
X3RpbWVvdXRfYWN0aW9uDQo+ID4gdWZzaGNkX2VoX3RpbWVkX291dChzdHJ1Y3Qgc2NzaV9jbW5k
ICpzY21kKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB1ZnNfaGJhICpoYmEg
PSBzaG9zdF9wcml2KHNjbWQtPmRldmljZS0+aG9zdCk7DQo+ID4NCj4gPiAtwqDCoMKgwqDCoMKg
IGlmICghaGJhLT5zeXN0ZW1fc3VzcGVuZGluZykgew0KPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFo
YmEtPnBtX29wX2luX3Byb2dyZXNzIHx8ICF1ZnNoY2RfaXNfc2NzaV9jbWQoc2NtZCkpIHsNCj4g
Pg0KPiANCj4gVUZTIGludGVybmFsIGRldmljZS1tYW5hZ2VtZW50IGNvbW1hbmQgdGltZW91dHMg
d2lsbCBuZXZlcg0KPiByZWFjaCB1ZnNoY2RfZWhfdGltZWRfb3V0LCByaWdodD8NCg0KVGhleSBh
cmUgc3RpbGwgZXhlY3V0ZWQgdmlhIGJsa19leGVjdXRlX3JxKCksIHNvIHRoZWlyIHRpbWVvdXQg
aGFuZGxpbmcgc3RpbGwgZ29lcw0KdGhyb3VnaCBzY3NpX3RpbWVvdXQoKSBhbmQgdGhlIGhvc3Qg
ZWhfdGltZWRfb3V0KCkgY2FsbGJhY2suDQoNCg0KQmVzdC4NCg==

