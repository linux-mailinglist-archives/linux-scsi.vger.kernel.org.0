Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9067659
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfGLV7Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 17:59:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9748 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727245AbfGLV7Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Jul 2019 17:59:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CLjlM7002057;
        Fri, 12 Jul 2019 14:46:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+6yvsjRZs/ixs0XnYTIUDLH9xik+z8lhrGX/GSbi0qQ=;
 b=GY/FY7vwCvIfu15q1a/nU1o8hDXfmRRs9vCOEN56KqpEq1cUfWtAxB/t4y3iM//B8SpM
 9mPtAdBH3ccNcnv1z0zsgJU5FxEJjDDdaLyoivcBLF9MFCimERkJeyrFJhUk3nUMRZFa
 8/WCwtEO0vfhuqzi3LJZwJl/7BECTKO9vfs2c1Iz8lascKgE4+WHvCP4EjLf8GAIl7QZ
 NBSpMwDL9WFUS1PVR1Ms40pbkPF7DbJrVczN2IN7mHXUnVoAygTsXIVEVtW7nwFSaZKr
 RcHHGrNXrcf7GXH6Hyag/+4eBPKs17WoV4JOc/vwQLdb3ISIRKVCwcJJGw4d3Jqvou3e 9Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tq1f1r6gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 14:46:42 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 12 Jul
 2019 14:46:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 12 Jul 2019 14:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVKNP2rXyUfD4QyRk71iAUP3ZcyaVF4RWxyCpGXYOfWLrg7a7LHjxa5onLj7q5DJUklb4ymVBIrF4F5N+iIT/jchBln0qQQC0MSycAXKh8KosZRmxSPRQiP+u5feABQzOVBdlTtQqZZUk9NVuZp3QsRzfuZ7TMpQeW57PBliW9NCQhfQcpAfdMYVlqp/vTQKrDafPJYu4RI57xDuugvmKVGHQD/c8M2GvBuwB2p9I2AbacuOIq0BNvk4xs7qp/V+0ZrHLMefJsY8G4+qC9bMlYSu00c8zfmkaC16HAz5JUL7pIdLqbWkmO7xh0EHBYbeefAhXhYnS/asn/jk/tpMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6yvsjRZs/ixs0XnYTIUDLH9xik+z8lhrGX/GSbi0qQ=;
 b=CAmVvY6Uuh/q4RxHUwE6K0XhmEbxWLYzw7StfUjw9Rs/pK8Natw1r2OWXUi/5VBPl8t2c4/CY9PL8KYWQiClCZ9eyxLiqImrrisJikBZWBdYc6ko3V90PqE/euYO4QvQ6e3IccAGZASnZMK9FxM2/CsI1h/wYcocyWwlvHSpdPP+uTqRMTyDFTSihyC70Z94muo/Volu1M62fSvxsEFQlQcY7bD4HlpSFxKyhHBAOcvRxZK5Qy2iGgCEpPM2zjdQZs759qIVWwK9Bm5z/YUZd+4IuceVnXRcUNWjMv+mmapQ23uY4hKqytothc/9TFwgIS9d8O7nPDSjO1CnbOXnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6yvsjRZs/ixs0XnYTIUDLH9xik+z8lhrGX/GSbi0qQ=;
 b=ZJXThphKv7ltrNyGATctXWsHV8jNZppE78Rcd61uSDu6pquyOq78npME/1qYnJQCnFgXnM7NPAVI/t/Py77k78npdLIe0sAhptRqLYZjtOd6ooD5F+/mA52wex75r47J8ZbHEILPB/CBO+OVwQstnbLu4K65u+6CTDHTfMunlec=
Received: from MWHPR18MB1488.namprd18.prod.outlook.com (10.175.7.135) by
 MWHPR18MB1262.namprd18.prod.outlook.com (10.175.8.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 12 Jul 2019 21:46:39 +0000
Received: from MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::cdcc:ee64:9865:a5fa]) by MWHPR18MB1488.namprd18.prod.outlook.com
 ([fe80::cdcc:ee64:9865:a5fa%10]) with mapi id 15.20.2073.012; Fri, 12 Jul
 2019 21:46:39 +0000
From:   Quinn Tran <qutran@marvell.com>
To:     Martin Wilck <mwilck@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "Tran,Quinn" <Quinn.Tran@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>
CC:     James Bottomley <james.bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] qla2xxx: always allocate qla_tgt_wq
Thread-Topic: [PATCH] qla2xxx: always allocate qla_tgt_wq
Thread-Index: AQHVBmpDlxkVPmr1bUO998NpspGiiqZi0+AAgABRsYCAY8y7gIAAghcA
Date:   Fri, 12 Jul 2019 21:46:39 +0000
Message-ID: <AC10E957-3A32-448C-BBDB-D0D990A7A240@marvell.com>
References: <20190509131821.87338-1-hare@suse.de>
 <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
 <aa620cdf3f987107656adab7e4825d3ca583ee09.camel@redhat.com>
 <8aaff38833d8105782caf3e98e1c6e1855b35bdf.camel@suse.de>
In-Reply-To: <8aaff38833d8105782caf3e98e1c6e1855b35bdf.camel@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.186.1.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32159e58-abbd-43b7-2f31-08d707126be0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR18MB1262;
x-ms-traffictypediagnostic: MWHPR18MB1262:
x-microsoft-antispam-prvs: <MWHPR18MB12622463C02548E44E5F9BFBD5F20@MWHPR18MB1262.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(68736007)(14454004)(53936002)(76176011)(305945005)(26005)(7736002)(25786009)(53546011)(4326008)(54906003)(186003)(36756003)(33656002)(316002)(110136005)(6506007)(102836004)(66066001)(6246003)(71190400001)(71200400001)(5660300002)(229853002)(8936002)(66556008)(76116006)(91956017)(66446008)(64756008)(66946007)(66476007)(6486002)(3846002)(6436002)(6116002)(81166006)(446003)(11346002)(2616005)(476003)(86362001)(478600001)(81156014)(486006)(8676002)(256004)(14444005)(6512007)(2906002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR18MB1262;H:MWHPR18MB1488.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZbiETCfQrXBRYxGSyidX/n0jyHn6scTFk8Ia6i4LPfzoU8ubEu/IPMKeBgcDWsvI6d+qZOFRlTDgY/RZzZv1+URCu72Bhv+JWjqjg7TvDw7/yXXjTHqYHR46JAd+E/UBujV0LZ/Cfww3klSAimpsExA9yx2Wifd4nvDTAPdvVApvlaQjWH4N/AZeAoyjdet9ghKoYpcIFMv748w7Hh7svH2KKnLm1lkhyPjj42ifCQ41jzs2jPbkGkPHPaLjm1TiY+WIOnxcllP7RT3gClowdftoUzXHgGOjZAVm8K3NXOhWyYTz9BeUBS6+jth9/7RSjGUwBNI3x8t786nsvy/0b4IEWxwBPxothJ2Whi8yeowmt+6PPhsmVIFRvcZ60kkbHbfyDD6nQqDS2ua/ZNmfyRdLNnPfcHfJTRbhCzK2V1U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E827A479C36CD40B9CB3165EE810EB2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32159e58-abbd-43b7-2f31-08d707126be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 21:46:39.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qutran@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1262
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGFubmVzLA0KDQpJdCBhc3N1bWVkIHlvdSdyZSBydW5uaW5nIGp1c3QgSW5pdGlhdG9yIE1vZGUu
ICBPdXIgRlcgc2hvdWxkIGJlIGhhbmRsaW5nIEFCVFMgYmVsb3cgdXMgd2l0aCBJbml0aWF0b3Ig
TW9kZS4gIFNvLCB3ZSBkb24ndCBleHBlY3QgdG8gc2VlIEFCVFMgKEFCVFNfUkVDVl8yNFhYKSB0
byBjb21lIHRvIGRyaXZlciB3aXRoIEluaXRpYXRvciBNb2RlLiAgVW5sZXNzIHNvbWV0aGluZyBh
Y2NpZGVudGFsbHkgdHVybnMgb24gVGFyZ2V0IE1vZGUgd2hlbiB0aW1lcyB0byBJbml0aWFsaXpl
IEZXLg0KDQpJbml0aWF0b3Igc2lkZSBlaF9hYm9ydCBnb2VzIHRocm91Z2ggYSBzcGVjaWZpYyBJ
T0NCIGNhbGwgIkFib3J0IElPIiB0aGF0IGNhbiBlbnRlciB0aHJvdWdoIG91ciBSZXF1ZXN0IElP
Q0IgUSBvciBNYWlsYm94IGludGVyZmFjZS4gIEFib3J0IElPIGNvbXBsZXRpb24gd291bGQgJ05P
VCcgcmV0dXJuIGJhY2sgdG8gZHJpdmVyIGFzIEFCVFNfUkVDVl8yNFhYLg0KDQpSZWdhcmRzLA0K
UXVpbm4gVHJhbiANCg0K77u/T24gNy8xMi8xOSwgMTI6MDEgQU0sICJsaW51eC1zY3NpLW93bmVy
QHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2YgTWFydGluIFdpbGNrIiA8bGludXgtc2NzaS1v
d25lckB2Z2VyLmtlcm5lbC5vcmcgb24gYmVoYWxmIG9mIG13aWxja0BzdXNlLmRlPiB3cm90ZToN
Cg0KICAgIE9uIFRodSwgMjAxOS0wNS0wOSBhdCAxNDo1OCAtMDQwMCwgIEV3YW4gRC4gTWlsbmUg
d3JvdGU6DQogICAgPiBPbiBUaHUsIDIwMTktMDUtMDkgYXQgMDc6MDYgLTA3MDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCiAgICA+ID4gT24gNS85LzE5IDY6MTggQU0sIEhhbm5lcyBSZWluZWNr
ZSB3cm90ZToNCiAgICA+ID4gPiBUaGUgJ3FsYV90Z3Rfd3EnIHdvcmtxdWV1ZSBpcyB1c2VkIGZv
ciBnZW5lcmljIGNvbW1hbmQgYWJvcnRzLA0KICAgID4gPiA+IG5vdCBqdXN0IHRhcmdldC1yZWxh
dGVkIGZ1bmN0aW9ucy4gU28gYWxsb2NhdGUgdGhlIHdvcmtxdWV1ZQ0KICAgID4gPiA+IGFsd2F5
cyB0byBhdm9pZCBhIGtlcm5lbCBjcmFzaCB3aGVuIGFib3J0aW5nIGNvbW1hbmRzLg0KICAgID4g
PiANCiAgICA+ID4gSGkgSGFubmVzLA0KICAgID4gPiANCiAgICA+ID4gQ2FuIHRoZSBhYm9ydCBj
b2RlIGJlIGNhbGxlZCBkaXJlY3RseT8gVGhpcyBtZWFucyBub3QgcXVldWVpbmcgdGhlDQogICAg
PiA+IGFib3J0DQogICAgPiA+IHdvcms/IERvIHlvdSBwZXJoYXBzIGtub3cgd2h5IHRoZSB0YXJn
ZXQgd29ya3F1ZXVlIGlzIHVzZWQgZm9yDQogICAgPiA+IHByb2Nlc3NpbmcgYWJvcnRzPyBJbiBv
dGhlciB3b3JkcywgY2FuIHRoZSBhYm9ydCBmdW5jdGlvbnMgYmUNCiAgICA+ID4gbW9kaWZpZWQN
CiAgICA+ID4gdG8gdXNlIG9uZSBvZiB0aGUgc3lzdGVtIHdvcmtxdWV1ZXMgaW5zdGVhZCBvZiBh
bHdheXMgYWxsb2NhdGluZw0KICAgID4gPiB0aGUNCiAgICA+ID4gdGFyZ2V0IHdvcmtxdWV1ZT8N
CiAgICA+ID4gDQogICAgPiA+IFRoYW5rcywNCiAgICA+ID4gDQogICAgPiA+IEJhcnQuDQogICAg
PiANCiAgICA+IEhvdyBleGFjdGx5IGlzIHRoZSBxbGFfdGd0X3dxIHVzZWQgZm9yIGdlbmVyaWMg
Y29tbWFuZCBhYm9ydHM/DQogICAgPiBEbyB5b3UgbWVhbiBpbml0aWF0b3IgbW9kZSBhYm9ydHMg
ZnJvbSB0aGUgU0NTSSBFSCBjYWxscz8gIFRob3NlIGxvb2sNCiAgICA+IGxpa2UgdGhleSBpc3N1
ZSBtYWlsYm94IGNvbW1hbmRzIHRvIHRoZSBIQkEgZGlyZWN0bHkuDQogICAgPiBPciBkbyB3ZSBn
ZXQgZnJhbWVzIHJlY2VpdmVkIGV2ZW4gaWYgd2UgYXJlIG5vdCB1c2luZyB0YXJnZXQgbW9kZSBv
cg0KICAgID4gc29tZXRoaW5nPw0KICAgIA0KICAgIFNvcnJ5IGZvciBqdW1waW5nIGxhdGUgb250
byB0aGlzIHRocmVhZC4NCiAgICANCiAgICBUaGUgY29kZSBpbiBxdWVzdGlvbiBoYXMgYmVlbiBp
bnRyb2R1Y2VkIGJ5IDJmNDI0YjliMzZhZCAicWxhMnh4eDogTW92ZQ0KICAgIGF0aW9xIHRvIGEg
ZGlmZmVyZW50IGxvY2sgdG8gcmVkdWNlIGxvY2sgY29udGVudGlvbiIsIHdpdGggdGhlIHB1cnBv
c2UNCiAgICB0byAiZW5zdXJlIHRoYXQgdGhlIEFUSU8gcXVldWUgaXMgZW1wdHkiLCBmb3IgY2Vy
dGFpbiBjb250cm9sbGVyIHR5cGVzLA0KICAgIGlmIGEgQUJUU19SRUNWXzI0WFggZWxlbWVudCBp
cyBlbmNvdW50ZXJlZCBvbiB0aGUgcmVzcG9uc2UgcXVldWUuDQogICAgDQogICAgTWF5YmUgUXVp
bm4gb3IgSGltYW5zaHUgY2FuIHNoZWQgbGlnaHQgb24gdGhlIHF1ZXN0aW9uIHVuZGVyIHdoaWNo
DQogICAgY29uZGl0aW9ucyB0aGlzIHdvdWxkIGhhcHBlbi4NCiAgICANCiAgICBNYXJ0aW4NCiAg
ICANCiAgICANCiAgICANCg0K
