Return-Path: <linux-scsi+bounces-7762-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D436961F8A
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Aug 2024 08:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FD0288D01
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Aug 2024 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3D1BC2F;
	Wed, 28 Aug 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EhMnIbww";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Genl+TYI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CE49641
	for <linux-scsi@vger.kernel.org>; Wed, 28 Aug 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825894; cv=fail; b=WDDS0ChU5UShsxZVS3Q4EIDqjnv6a3claM2ftYEWsOui+nEAz/wy43ZLXLr1dY4ATIcQuaiIh2076FV8hxOzWcA3lAtodQ8iS9A5Cn3yvipWBOd4K/5qyeFsEMYFOZDP1rHyUyHeZZaMALc5Z5q/3JI9dTf7CaTvSL9wTmC2i8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825894; c=relaxed/simple;
	bh=GpxiTYM+kAeU05wwKXiR++tB1d/gD7ZG/Klgcp+49oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lda8xbIHVKQP8fANk0DhauTAZHziq1g/szMLXlznJsqegMuBowAQ3DM0ufX+PFjzj60C7Cd9wIrouzkBZxJ1PW+PC9+kL4ecWVAmBrLPMNcysJS4QTVJDctDfv9c5iv5vfHVUx4SX+gDXv+TJdPZXvXJzBGt8Bf/Z5/NQow3Mfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EhMnIbww; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Genl+TYI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 42b97254650511ef8593d301e5c8a9c0-20240828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GpxiTYM+kAeU05wwKXiR++tB1d/gD7ZG/Klgcp+49oc=;
	b=EhMnIbwwZ1yupzDCcljqPett6MkDmozHyhJn/q4XeTbcw8EnnZRE0B0L+/stX9s32f9ti/4Kfy0vy3XqlhH1gnJ6XoPwVN4Xy39e2bnQntg+RzpwAqzLAgOJIq3j8NrCzTPZ6RIEc9NbkBgBmPaDhIVZp7iDtwIIQL//S6XIyQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:4540cb44-4fb5-4a09-8ed5-628ad7fb2cbf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:b17c4bcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42b97254650511ef8593d301e5c8a9c0-20240828
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1561926642; Wed, 28 Aug 2024 14:17:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Aug 2024 14:17:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Aug 2024 14:17:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsH1Zh7T3KFVhUE1SLhIDd2yUf7hPm4jdxOCvsiAQfpY/Y6C3DNbAJjkPvBzr8oFJQ5CIOuJ3jdiIytMkN6lljCqt2gVCRd5O1zD5yuEbUmZ/t5f+fFBTRQTWHnCleXUGhB4JEtImPdrRfv0ph5lXl8WeicNrteOYCL3Eafb+Ka72phe03SI5uPbkJa40PmvuT0TJX5r8wqYFQL267YwSA6HScCuea5KtChjQ8kuFGvjzKaF0pxEAWx+AKSRNMNx4aCsG41diAkuV784/O1pKqHbS0931/2yLrTXs7s6ozoph/LKmMAH/SzQ3Cvqqkp1ccWQ15vVxIp0+GolcNMGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpxiTYM+kAeU05wwKXiR++tB1d/gD7ZG/Klgcp+49oc=;
 b=g0/pPNQ42eCCoKMDyC4kaS47l9/s6GeM4rPiIhGounnmwWa4HRF4qLDBhwb0QINQoreBCYSbkEA+cneFxZOWnRLB0mRRBb0Or2IFAVtuf7FU8lARI8DVm41o4FgPN2ZhXBT2rrA9JJkIWcYLdozpx00zctOxL4tvKKlKjXi2wlEMV6ma2uIm0Oq0H9X0SDR+I9SXVJwlHbIIF7Gtc7G6hedgz/+ORkF8z6VOgC5tQzxwTGz0qERlA5nvqDsZm6QDHpdrnO4JrX5tYs+5yv1AxYw7kV3netxBGE2q0C3FKhDafYPFT3TEdx+oDDExGCRCO/NieX6TqBtO9ZCOmVJemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpxiTYM+kAeU05wwKXiR++tB1d/gD7ZG/Klgcp+49oc=;
 b=Genl+TYIXz3cGfXtbX/NZLQuHYdzj6UlY4Qsu8HmlBqDYkWascVDSLJ+rv5T6+czx30ifSJ95Ywj5QxT8VSVQVAzQ4dqR4vmvjwe2oDI+jQv3GlnhrpONP3IK6w5zSqiwz3kETswRoHl2uiYeQqxvrNqjz6uB2Q+ae7uSl7MJhw=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by SEZPR03MB8184.apcprd03.prod.outlook.com (2603:1096:101:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 06:17:53 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 06:17:52 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "bvanassche@acm.org" <bvanassche@acm.org>, "quic_nguyenb@quicinc.com"
	<quic_nguyenb@quicinc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "ebiggers@google.com" <ebiggers@google.com>, "ahalaney@redhat.com"
	<ahalaney@redhat.com>, "quic_mnaresh@quicinc.com" <quic_mnaresh@quicinc.com>,
	"beanhuo@micron.com" <beanhuo@micron.com>, "avri.altman@wdc.com"
	<avri.altman@wdc.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "minwoo.im@samsung.com"
	<minwoo.im@samsung.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 2/2] scsi: ufs: core: Fix the code for entering
 hibernation
Thread-Topic: [PATCH 2/2] scsi: ufs: core: Fix the code for entering
 hibernation
Thread-Index: AQHa8/g1O9xCFCXi4kKybU2KvbfJOrIz76mAgAAqm4CAAA4hgIABJXwAgAPJKoCAAMcMAIAAfgUAgADrb4CAAPSJgA==
Date: Wed, 28 Aug 2024 06:17:52 +0000
Message-ID: <0476168b16b4ba6a2b52cad23714206c6e386d80.camel@mediatek.com>
References: <20240821182923.145631-1-bvanassche@acm.org>
	 <20240821182923.145631-3-bvanassche@acm.org>
	 <ba9ae5a8-6021-f906-9ce1-d637534ac9cf@quicinc.com>
	 <20c1866f-9bb2-406f-a819-74ad936d92d5@acm.org>
	 <471e5a037f5fcc996e36b6112dc011731e75b66d.camel@mediatek.com>
	 <63b82e64-e968-4704-85b8-fad919994432@acm.org>
	 <b7b0395a59e275c5e43cb282b827b39416a5b4ad.camel@mediatek.com>
	 <082b7053-e7f4-4dd9-9d84-c8d9c7d75faf@acm.org>
	 <37fc6433d70483b7a889ff804e56023b1081b7b6.camel@mediatek.com>
	 <f7f0ca00-a8ce-4841-8483-5ad886da82ad@acm.org>
In-Reply-To: <f7f0ca00-a8ce-4841-8483-5ad886da82ad@acm.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|SEZPR03MB8184:EE_
x-ms-office365-filtering-correlation-id: d0502f03-f2ca-47f6-b4a0-08dcc729260b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXN2VFBJclgwV2dYbWNWak5lOU83ZDRkWlA0WTFHWXdVMXFvWjJ2QlpmalNT?=
 =?utf-8?B?ckJaaENxYmMwMXdkZUtVZDA0ZWFzeDQ2bVRKRWtldmtDbVhqRFdSVUF6UGx0?=
 =?utf-8?B?VUlKbzVlbmFMM0wwSkpocUxoSElwQ0tYYmdEcHJvVDh0eE04bkRubEtVb045?=
 =?utf-8?B?bGFDUG5RV0R3YldLbU1IQjdha3I1ODc4QThlOWNRNUtqMU5lRUgxblNSOC9K?=
 =?utf-8?B?VWl6QTkrRUQyVlgrbTRqcGpUT1A5Y09oNGlwVUJxQnd3alJJcnJZeXpVVVZW?=
 =?utf-8?B?a2Q0SHJ6b2hSMi9VUCsvV0F5QjJ1WHlvRzlBeDFiek9oNmhXaUo1SldZeEJD?=
 =?utf-8?B?TllRMlhqYUQxdGZ3d214R2diTHpMOUR2bkdudklJbVhGTk01c29jN2szcWVi?=
 =?utf-8?B?azUrdXI1RmxYYnd6QkhhODRZOWtYZEg5ZEZSOVhXemxFR0cyU0JwUVZGRnZE?=
 =?utf-8?B?NDlDTFRTc3pWcGhhZEtCWWZHQVBrSFpRN0tQUnlVVDY0N1pPY1lGeXJxYXRC?=
 =?utf-8?B?Rk9hQ2NNbHJ4RFNmdFlSajlvLzA2YnZOU0hwNWEyZ0wrZE92RWZQTnBWM2Ju?=
 =?utf-8?B?TDNLdFNNUENpbjkySGR0Ym9OWENwcDZxdmJlZmpHWVhORytGMHFJVUZXVVpJ?=
 =?utf-8?B?VzNVcVQzbUZxR216aFhYSW1HTkU5cmhQM3g0NTByb3V4ZWZxdlhjSzNhbnhY?=
 =?utf-8?B?NGtUc3FyKzRjNjhvMGtidVFWaURNTzg3TVZ5QmNjaFNKOVNYbERaR3dEUnVG?=
 =?utf-8?B?OFZ0RWw3Skp5Y0VFRmZXWndRWkovMWYwMEliQVJPaTdxZ3FuMmJ6QlVnQlFr?=
 =?utf-8?B?aC9vKzAvbzhBamJWNG1RMlcxNFF6RlQ4RngreVRBbjlENDFuKzNFV0dDdm5H?=
 =?utf-8?B?NTVmaW0rTjR4OUUrVzVUTzZySDNVcjQvaWxIUjc4WktRMHNXbkh0MU1yZkhq?=
 =?utf-8?B?MW9mamxYcHBIUVh0c3hrQ0QvNFcySW1QcVVlMU45VmdIV2NOZEtlREhIVURW?=
 =?utf-8?B?cWhTZ0kyclNmQklMUnpXZ2NLczdOWExXK2hXODJlZGdZMW9vT2dwRGo1TzZ3?=
 =?utf-8?B?a21tRzlRYTFkUXdLTllOb1BWN3h1S2NLQ1pjZXdvNzhyT3FRRVBQckVPUkpG?=
 =?utf-8?B?TGNJdVZ6Y01hak9mUmhXQU1ucmZ6K0gvWVVOZWdvc0duaFIzVUd3and1U0dm?=
 =?utf-8?B?VG1vTko2bW1ZNEpscEQ2U01sZmhBU1BPeGV2dzdydnVQOVV2Mk1acWZjTFMx?=
 =?utf-8?B?RENPVHQ3bU9CVWx3NHdXUWc1Y0hGckU5VDlROWJHSU5EQUVNaHRZUlI2Q21Z?=
 =?utf-8?B?WHI2b2FQQk9YdVJ3T084STRYeUZReFFmS2JveFBIbWpYZXBiblV5eXNCQkNU?=
 =?utf-8?B?Uk9CTGNCcWdWSEh4ZnJCbnMzZ3ZjeTlSVkpnT01hbzVGSktOR2phUjA4YXhK?=
 =?utf-8?B?eFR4VUl6UXBlclpIek96YS90TFg2RTMzRG5tLy9sLzlybHB5N1FyRDJwb2Vz?=
 =?utf-8?B?Tnc2YVlocHFqYk96WVhtMmpTQjROaVhudGdvZWpNNzFBYmhMQzNtdHg4T2ls?=
 =?utf-8?B?Y2R5c2R2aE9Gbms0dFRDQnpoN0VLc1J2Y3RLeVNqd21zSzJ4aWJXU3VsUUEy?=
 =?utf-8?B?UDFHTERWeUhwUytaTmVpOTVNbXd3cXFGSDdiQy9wZC9nU2xrV3VpSloyS1Bs?=
 =?utf-8?B?TkxBWHZ5RGd1Q21JYjRoZEo5bXVBaDRqN0VFL25oRUoyQ2owM0lmSW5WZFNr?=
 =?utf-8?B?OVVsWUUrNlpQNWhGOVRDVVpTdDhTRXduNjlwMGNacnJyaGRWVWhNa2pKcjdF?=
 =?utf-8?B?Z2NUOXFKeFgzQjlkOGdMaW56ZTdDQzZqU2trdVpkTG01byt5L3NzbERaYWlM?=
 =?utf-8?B?aEwxc3pVaVluY2NvYUpncEJpSnVSZ1dqM05qeVMvb1lKM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2dXQmpHempmbStrZGx6eEZaNTllTXlnSmFWOE5yOHgwdXIySFRQSitnbTVG?=
 =?utf-8?B?a01kWjNZTVZHYzZoV2RMVTh6SUJ0WUMrc3dSZytwN2U1dWlFTTI5VzhDb09M?=
 =?utf-8?B?MDFEY3ZiaE95MGdFVnpHMDFoRU1oZlZEdzlISy9iM2lUcmM1ckZGMDZna0dX?=
 =?utf-8?B?cTBTdHcyZDZGQ0Z1bGFZWnZhVHpzZGI0NGpCQWdBclJrazJIb1d5YTNpOEEz?=
 =?utf-8?B?TzJlbHdTSG1Cd3ZieVY4SmF1WEdIQkZPc2dSSU9udThtWlFSdm1YR3FRelUw?=
 =?utf-8?B?Q0h6MnRRekJITU5aZVhSeFNld1NpMFc3OFd1YkQ0MmVSNUpqcnorNWVFR0tX?=
 =?utf-8?B?ZEVIQVlVeDhPR3huenhCcitjRUxyZE1PZFRQYTQzSldSalByOVZidWpiU1I5?=
 =?utf-8?B?eUdOMUZ5emZpK1BVRGJPMkVEVmMyQTQ0MlE0VG9OZnBpcGR1TFRwZDZPUG02?=
 =?utf-8?B?Zk9Jekt5YmpBVGZ1SG05VWQzd0E3Ym81WElPVStpZEx5akFHRUVzSWtUSjY1?=
 =?utf-8?B?K0NJWFVFVW15QnZaRVlKQUMxVHA3NmZCN2c1OHpwanVhTkh5K1hwbFo0V0h0?=
 =?utf-8?B?OVlYVWFITkZYWG1jZkdWSm1EeDRISXJuZ0tOay9UTHZuSnA2UEs5eVcySUlC?=
 =?utf-8?B?THBSU0xXdU9maGgvUVJGVElJSDZYOFRlWmhGbU1lVno3N2dTY1BGd2lBTThr?=
 =?utf-8?B?N3E0dXZiZDUydEg1SStZbGFZY25HelFwRm9GK29RSjNqZTlsS0lPdXIzd1ZV?=
 =?utf-8?B?RGU0RVo2SStsZ3psYmJiZXZ3MVF0a2hVSCtBd2huTFI4eHY2SDFZbDI2MWR3?=
 =?utf-8?B?Q2x5ODZHNDhTWFpjTkYvSWlrUDZ0ZzRPUUFicTZlTDNDbHNwSHYzM1BKWHRr?=
 =?utf-8?B?KzJHL0p0USsvbVNLb1BRZ20wTjdFQkdLem1NUDlvQlAyeFNWWnNCTlVKcldL?=
 =?utf-8?B?NEVFY1JTTXhRSE12NXNSOWg1cENlbDRlNEtPbms3TEpkbWxXMGpCam9mV1Nw?=
 =?utf-8?B?UVRrRXBRNEt4S3NTR3NVZ2hOcWdFZE9XY1dTenBvS3U1M01kdDJmaS8zV2xt?=
 =?utf-8?B?S0MxT3BZT1pkamxMQUpRcFpIQ01HVWNudXVxbkNRQk9OUnFQV0cvMWJqbjJC?=
 =?utf-8?B?eWJwV1QyeXY1UW9jUHF4VTQ4QWU0U2JlUXBDN2ZGbkdaYWpzRDBESnFyWllt?=
 =?utf-8?B?UXhPZER6VktFUW1YZE5SRjBkTjhxUEpLa1B5NlBRWjI1bENRUzk4aldPbDFV?=
 =?utf-8?B?NHN1VmpJTmd5R0hPTjFkaXB0Y2FkUEYwZFFZcTZGRG83SW8xYXlOM3NXb1pX?=
 =?utf-8?B?NE9SdnlsSUVrZHA1ZC93LzdLWHBLQmJ0NktycWtwbjMwSlB0MVlIQ3B1KzJV?=
 =?utf-8?B?SHAyaFJZOU95NXRHenBKWkh6dVV3aytYMWZLcXRRZ013Ry9PamdrcjB4Rjht?=
 =?utf-8?B?OUNrREU5Q0F6TjFZdmxSWS9xVDY2ZzU0aGxOZTJ3U01BWVRIOUd0L29sOURk?=
 =?utf-8?B?Z2xQcUtDVEJRRDA1RmlCSytOTFR6eUhzUFkvdllTZE9Ddk5Rb21ZdEo5YWQr?=
 =?utf-8?B?S1dHR0dtRUpnWGxxSm9uWWtMSEJVRWFidnB4QWpET2gwNnpIVEh2NlN0NEFo?=
 =?utf-8?B?dS9LcjFDc1U2dG13SFVYUDBTbWVVdnUyajBhb2NOUVEzY05NRTBsdVVsdEcy?=
 =?utf-8?B?em9XemZta0t5dXdpR09oalBoLzdkRm9qa0JwT20rUHVUTTY3MytOZnF0WW96?=
 =?utf-8?B?dDZkQlJOMFBreVZzVFIrT1dpUzkxWDlSd200ZnE5RmM1MVNMTFZuUk1TMVRJ?=
 =?utf-8?B?V0RLVFc0dDZWM3hOWkJBTC9WN05XSEY4Ym1oZlNDaUM4RVdpbTFDbXl6eDhC?=
 =?utf-8?B?TWRzYkVtZjRPYW5YUzdoWjd6RlczUEJoZDNkMU1KdytScURxMHJmbDc3V01o?=
 =?utf-8?B?N21nV1JERzVXY21TTnBmQ3VjOUgxVFc3ZnQrbmQrSG9FUUd1TXpIUVE2VFFi?=
 =?utf-8?B?aXNMREN2YkxCdTJvSEZGVXoxM3RhNEpXVHZsVkIzQXZ6TGJadFN0S2pwQXNQ?=
 =?utf-8?B?MFN5OFJpbXRSTE1GRzNxaWwxVXllbFN1SWlsWnowbndPWUk3VjRraUhOQzAy?=
 =?utf-8?B?K3FDRDc3a1BWVEpXdWR6ZXIxT3o2ZFQ1ZjhiaWNBVVY3NEtRTFZoSlVxd0Mr?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E0EE0040E9D9940BCC37FEE2C9B984C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0502f03-f2ca-47f6-b4a0-08dcc729260b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 06:17:52.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQew95ePCqlBCJFX6qtKQGBud/wqOxmtnvmvkHToK5ilZ0XsP0eBLa/X3shbAb/71tYbo8h+t35Wu/AJlmOuwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8184
X-MTK: N

T24gVHVlLCAyMDI0LTA4LTI3IGF0IDExOjQyIC0wNDAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gOC8yNi8yNCA2OjM5IFBNLCBQZXRlciBXYW5nICjnjovkv6Hl
j4spIHdyb3RlOg0KPiA+IEl0IGlzIG5vdCBhIG5ldyB2ZW5kb3IgaG9vaywgdWZzaGNkX3ZvcHNf
aGliZXJuOF9ub3RpZnkgaXMgZXhpc3QNCj4gPiBpbiBjdXJyZW50IGtlcm5lbC4NCj4gSGkgUGV0
ZXIsDQo+IA0KPiBJcyBzb21ldGhpbmcgbGlrZSB0aGUgdW50ZXN0ZWQgcGF0Y2ggYmVsb3cgcGVy
aGFwcyB3aGF0IHlvdSBoYXZlIGluDQo+IG1pbmQ/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0
Lg0KPiANCg0KSGkgQmFydCwNCg0KTm8sIEkgbWVhbnMgeW91IGNhbiByZWZlcmVuY2UgdWZzLXNw
cmQuYyBkcml2ZXIuIHdoaWNoIG1heSBoYXZlIHRoZQ0Kc2FtZSBpc3N1ZT8NCg0KCQkJLyoNCgkJ
CSAqIERpc2FibGUgVUlDIENPTVBMIElOVFIgdG8gcHJldmVudCBhY2Nlc3MgdG8NClVGU0hDSSBh
ZnRlcg0KCQkJICogY2hlY2tpbmcgSENTLlVQTUNSUw0KCQkJICovDQoJCQl1ZnNfc3ByZF9jdHJs
X3VpY19jb21wbChoYmEsIGZhbHNlKTsNCg0KVGhlbiBhZnRlciBlbnRlciBoaWJlcm50ZSwgeW91
IGNhbiBwcmV2ZW50IGFjY2VzcyB0byBVRlNIQ0kuDQpBZnRlciBleGl0IGhpYmVybmF0ZSwgZW5h
YmxlIHVpYyBjb21wbGV0ZSBpbnRlcnJ1cHQgYWdhaW4gZm9yDQp3b3JrYXJvdW5kLg0KDQpUaGFu
a3MuDQpQZXRlcg0KDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC1wcml2LmgNCj4gYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC1wcml2LmgNCj4gaW5kZXggY2Uz
NjE1NGNlOTYzLi42OWVlNDlhNzVjMDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUv
dWZzaGNkLXByaXYuaA0KPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC1wcml2LmgNCj4g
QEAgLTE3NiwxMiArMTc2LDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCANCj4gdWZzaGNkX3ZvcHNf
c2V0dXBfdGFza19tZ210KHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+ICAgcmV0dXJuIGhiYS0+dm9w
cy0+c2V0dXBfdGFza19tZ210KGhiYSwgdGFnLCB0bV9mdW5jdGlvbik7DQo+ICAgfQ0KPiANCj4g
LXN0YXRpYyBpbmxpbmUgdm9pZCB1ZnNoY2Rfdm9wc19oaWJlcm44X25vdGlmeShzdHJ1Y3QgdWZz
X2hiYSAqaGJhLA0KPiAtZW51bSB1aWNfY21kX2RtZSBjbWQsDQo+IC1lbnVtIHVmc19ub3RpZnlf
Y2hhbmdlX3N0YXR1cyBzdGF0dXMpDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQNCj4gK3Vmc2hjZF92
b3BzX2hpYmVybjhfbm90aWZ5KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gdWljX2NtZF9kbWUN
Cj4gY21kLA0KPiArICAgZW51bSB1ZnNfbm90aWZ5X2NoYW5nZV9zdGF0dXMgc3RhdHVzLA0KPiAr
ICAgYm9vbCAqZGlzYWJsZV91aWNfY29tcGxfaW50cikNCj4gICB7DQo+ICAgaWYgKGhiYS0+dm9w
cyAmJiBoYmEtPnZvcHMtPmhpYmVybjhfbm90aWZ5KQ0KPiAtcmV0dXJuIGhiYS0+dm9wcy0+aGli
ZXJuOF9ub3RpZnkoaGJhLCBjbWQsIHN0YXR1cyk7DQo+ICtyZXR1cm4gaGJhLT52b3BzLT5oaWJl
cm44X25vdGlmeShoYmEsIGNtZCwgc3RhdHVzLA0KPiArIGRpc2FibGVfdWljX2NvbXBsX2ludHIp
Ow0KPiAgIH0NCj4gDQo+ICAgc3RhdGljIGlubGluZSBpbnQgdWZzaGNkX3ZvcHNfYXBwbHlfZGV2
X3F1aXJrcyhzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMv
Y29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gaW5kZXggZTEzYjlh
YzE0NWY2Li42MTRiMjRmMmViN2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZz
aGNkLmMNCj4gKysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiBAQCAtMjU0MSw5ICsy
NTQxLDggQEAgdWZzaGNkX3dhaXRfZm9yX3VpY19jbWQoc3RydWN0IHVmc19oYmEgKmhiYSwgDQo+
IHN0cnVjdCB1aWNfY29tbWFuZCAqdWljX2NtZCkNCj4gICAgKg0KPiAgICAqIFJldHVybjogMCBv
bmx5IGlmIHN1Y2Nlc3MuDQo+ICAgICovDQo+IC1zdGF0aWMgaW50DQo+IC1fX3Vmc2hjZF9zZW5k
X3VpY19jbWQoc3RydWN0IHVmc19oYmEgKmhiYSwgc3RydWN0IHVpY19jb21tYW5kDQo+ICp1aWNf
Y21kLA0KPiAtICAgICAgYm9vbCBjb21wbGV0aW9uKQ0KPiArc3RhdGljIGludCBfX3Vmc2hjZF9z
ZW5kX3VpY19jbWQoc3RydWN0IHVmc19oYmEgKmhiYSwNCj4gKyBzdHJ1Y3QgdWljX2NvbW1hbmQg
KnVpY19jbWQpDQo+ICAgew0KPiAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmhiYS0+dWljX2NtZF9t
dXRleCk7DQo+IA0KPiBAQCAtMjU1Myw4ICsyNTUyLDcgQEAgX191ZnNoY2Rfc2VuZF91aWNfY21k
KHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+IHN0cnVjdCANCj4gdWljX2NvbW1hbmQgKnVpY19jbWQs
DQo+ICAgcmV0dXJuIC1FSU87DQo+ICAgfQ0KPiANCj4gLWlmIChjb21wbGV0aW9uKQ0KPiAtaW5p
dF9jb21wbGV0aW9uKCZ1aWNfY21kLT5kb25lKTsNCj4gK2luaXRfY29tcGxldGlvbigmdWljX2Nt
ZC0+ZG9uZSk7DQo+IA0KPiAgIHVpY19jbWQtPmNtZF9hY3RpdmUgPSAxOw0KPiAgIHVmc2hjZF9k
aXNwYXRjaF91aWNfY21kKGhiYSwgdWljX2NtZCk7DQo+IEBAIC0yNTgwLDcgKzI1NzgsNyBAQCBp
bnQgdWZzaGNkX3NlbmRfdWljX2NtZChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCANCj4gc3RydWN0IHVp
Y19jb21tYW5kICp1aWNfY21kKQ0KPiAgIG11dGV4X2xvY2soJmhiYS0+dWljX2NtZF9tdXRleCk7
DQo+ICAgdWZzaGNkX2FkZF9kZWxheV9iZWZvcmVfZG1lX2NtZChoYmEpOw0KPiANCj4gLXJldCA9
IF9fdWZzaGNkX3NlbmRfdWljX2NtZChoYmEsIHVpY19jbWQsIHRydWUpOw0KPiArcmV0ID0gX191
ZnNoY2Rfc2VuZF91aWNfY21kKGhiYSwgdWljX2NtZCk7DQo+ICAgaWYgKCFyZXQpDQo+ICAgcmV0
ID0gdWZzaGNkX3dhaXRfZm9yX3VpY19jbWQoaGJhLCB1aWNfY21kKTsNCj4gDQo+IEBAIC00MjQz
LDcgKzQyNDEsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh1ZnNoY2RfZG1lX2dldF9hdHRyKTsNCj4g
ICAgKg0KPiAgICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBub24temVybyB2YWx1ZSBvbiBmYWls
dXJlLg0KPiAgICAqLw0KPiAtc3RhdGljIGludCB1ZnNoY2RfdWljX3B3cl9jdHJsKHN0cnVjdCB1
ZnNfaGJhICpoYmEsIHN0cnVjdA0KPiB1aWNfY29tbWFuZCANCj4gKmNtZCkNCj4gK3N0YXRpYyBp
bnQgdWZzaGNkX3VpY19wd3JfY3RybChzdHJ1Y3QgdWZzX2hiYSAqaGJhLCBzdHJ1Y3QNCj4gdWlj
X2NvbW1hbmQgDQo+ICpjbWQsDQo+ICsgICAgICAgYm9vbCBkaXNhYmxlX3VpY19jb21wbF9pbnRy
KQ0KPiAgIHsNCj4gICBERUNMQVJFX0NPTVBMRVRJT05fT05TVEFDSyh1aWNfYXN5bmNfZG9uZSk7
DQo+ICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gQEAgLTQyNjAsNyArNDI1OSw4IEBAIHN0YXRp
YyBpbnQgdWZzaGNkX3VpY19wd3JfY3RybChzdHJ1Y3QgdWZzX2hiYSANCj4gKmhiYSwgc3RydWN0
IHVpY19jb21tYW5kICpjbWQpDQo+ICAgZ290byBvdXRfdW5sb2NrOw0KPiAgIH0NCj4gICBoYmEt
PnVpY19hc3luY19kb25lID0gJnVpY19hc3luY19kb25lOw0KPiAtaWYgKHVmc2hjZF9yZWFkbCho
YmEsIFJFR19JTlRFUlJVUFRfRU5BQkxFKSAmIFVJQ19DT01NQU5EX0NPTVBMKSB7DQo+ICtpZiAo
ZGlzYWJsZV91aWNfY29tcGxfaW50ciAmJg0KPiArICAgIHVmc2hjZF9yZWFkbChoYmEsIFJFR19J
TlRFUlJVUFRfRU5BQkxFKSAmIFVJQ19DT01NQU5EX0NPTVBMKSB7DQo+ICAgdWZzaGNkX2Rpc2Fi
bGVfaW50cihoYmEsIFVJQ19DT01NQU5EX0NPTVBMKTsNCj4gICAvKg0KPiAgICAqIE1ha2Ugc3Vy
ZSBVSUMgY29tbWFuZCBjb21wbGV0aW9uIGludGVycnVwdCBpcyBkaXNhYmxlZCBiZWZvcmUNCj4g
QEAgLTQyNzAsNyArNDI3MCw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3VpY19wd3JfY3RybChzdHJ1
Y3QgdWZzX2hiYSANCj4gKmhiYSwgc3RydWN0IHVpY19jb21tYW5kICpjbWQpDQo+ICAgcmVlbmFi
bGVfaW50ciA9IHRydWU7DQo+ICAgfQ0KPiAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoaGJhLT5o
b3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsNCj4gLXJldCA9IF9fdWZzaGNkX3NlbmRfdWljX2NtZCho
YmEsIGNtZCwgZmFsc2UpOw0KPiArcmV0ID0gX191ZnNoY2Rfc2VuZF91aWNfY21kKGhiYSwgY21k
KTsNCj4gICBpZiAocmV0KSB7DQo+ICAgZGV2X2VycihoYmEtPmRldiwNCj4gICAicHdyIGN0cmwg
Y21kIDB4JXggd2l0aCBtb2RlIDB4JXggdWljIGVycm9yICVkXG4iLA0KPiBAQCAtNDI5NCw2ICs0
Mjk0LDE2IEBAIHN0YXRpYyBpbnQgdWZzaGNkX3VpY19wd3JfY3RybChzdHJ1Y3QgdWZzX2hiYSAN
Cj4gKmhiYSwgc3RydWN0IHVpY19jb21tYW5kICpjbWQpDQo+ICAgZ290byBvdXQ7DQo+ICAgfQ0K
PiANCj4gK2lmICghZGlzYWJsZV91aWNfY29tcGxfaW50ciAmJg0KPiArICAgIHVmc2hjZF9yZWFk
bChoYmEsIFJFR19JTlRFUlJVUFRfRU5BQkxFKSAmIFVJQ19DT01NQU5EX0NPTVBMKSB7DQo+ICty
ZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoDQo+ICsmY21kLT5kb25lLCBtc2Vjc190
b19qaWZmaWVzKHVpY19jbWRfdGltZW91dCkpOw0KPiAraWYgKHJldCA9PSAwKQ0KPiArZGV2X2Vy
cihoYmEtPmRldiwgInB3ciBjdHJsIGNtZCAlI3ggdGltZWQgb3V0XG4iLA0KPiArY21kLT5jb21t
YW5kKTsNCj4gK3JldCA9IDA7DQo+ICt9DQo+ICsNCj4gICBjaGVja191cG1jcnM6DQo+ICAgc3Rh
dHVzID0gdWZzaGNkX2dldF91cG1jcnMoaGJhKTsNCj4gICBpZiAoc3RhdHVzICE9IFBXUl9MT0NB
TCkgew0KPiBAQCAtNDM1Myw3ICs0MzYzLDcgQEAgaW50IHVmc2hjZF91aWNfY2hhbmdlX3B3cl9t
b2RlKHN0cnVjdCB1ZnNfaGJhIA0KPiAqaGJhLCB1OCBtb2RlKQ0KPiAgIH0NCj4gDQo+ICAgdWZz
aGNkX2hvbGQoaGJhKTsNCj4gLXJldCA9IHVmc2hjZF91aWNfcHdyX2N0cmwoaGJhLCAmdWljX2Nt
ZCk7DQo+ICtyZXQgPSB1ZnNoY2RfdWljX3B3cl9jdHJsKGhiYSwgJnVpY19jbWQsIHRydWUpOw0K
PiAgIHVmc2hjZF9yZWxlYXNlKGhiYSk7DQo+IA0KPiAgIG91dDoNCj4gQEAgLTQzOTYsMTEgKzQ0
MDYsMTMgQEAgaW50IHVmc2hjZF91aWNfaGliZXJuOF9lbnRlcihzdHJ1Y3QgdWZzX2hiYQ0KPiAq
aGJhKQ0KPiAgIC5jb21tYW5kID0gVUlDX0NNRF9ETUVfSElCRVJfRU5URVIsDQo+ICAgfTsNCj4g
ICBrdGltZV90IHN0YXJ0ID0ga3RpbWVfZ2V0KCk7DQo+ICtib29sIGRpc2FibGVfdWljX2NvbXBs
X2ludHIgPSB0cnVlOw0KPiAgIGludCByZXQ7DQo+IA0KPiAtdWZzaGNkX3ZvcHNfaGliZXJuOF9u
b3RpZnkoaGJhLCBVSUNfQ01EX0RNRV9ISUJFUl9FTlRFUiwNCj4gUFJFX0NIQU5HRSk7DQo+ICt1
ZnNoY2Rfdm9wc19oaWJlcm44X25vdGlmeShoYmEsIFVJQ19DTURfRE1FX0hJQkVSX0VOVEVSLCBQ
UkVfQ0hBTkdFLA0KPiArICAgJmRpc2FibGVfdWljX2NvbXBsX2ludHIpOw0KPiANCj4gLXJldCA9
IHVmc2hjZF91aWNfcHdyX2N0cmwoaGJhLCAmdWljX2NtZCk7DQo+ICtyZXQgPSB1ZnNoY2RfdWlj
X3B3cl9jdHJsKGhiYSwgJnVpY19jbWQsIGRpc2FibGVfdWljX2NvbXBsX2ludHIpOw0KPiAgIHRy
YWNlX3Vmc2hjZF9wcm9maWxlX2hpYmVybjgoZGV2X25hbWUoaGJhLT5kZXYpLCAiZW50ZXIiLA0K
PiAgICAgICAga3RpbWVfdG9fdXMoa3RpbWVfc3ViKGt0aW1lX2dldCgpLCBzdGFydCkpLCByZXQp
Ow0KPiANCj4gQEAgLTQ0MDksNyArNDQyMSw3IEBAIGludCB1ZnNoY2RfdWljX2hpYmVybjhfZW50
ZXIoc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gICBfX2Z1bmNfXywgcmV0KTsNCj4gICBlbHNl
DQo+ICAgdWZzaGNkX3ZvcHNfaGliZXJuOF9ub3RpZnkoaGJhLCBVSUNfQ01EX0RNRV9ISUJFUl9F
TlRFUiwNCj4gLVBPU1RfQ0hBTkdFKTsNCj4gKyAgIFBPU1RfQ0hBTkdFLCBOVUxMKTsNCj4gDQo+
ICAgcmV0dXJuIHJldDsNCj4gICB9DQo+IEBAIC00NDIzLDkgKzQ0MzUsMTAgQEAgaW50IHVmc2hj
ZF91aWNfaGliZXJuOF9leGl0KHN0cnVjdCB1ZnNfaGJhDQo+ICpoYmEpDQo+ICAgaW50IHJldDsN
Cj4gICBrdGltZV90IHN0YXJ0ID0ga3RpbWVfZ2V0KCk7DQo+IA0KPiAtdWZzaGNkX3ZvcHNfaGli
ZXJuOF9ub3RpZnkoaGJhLCBVSUNfQ01EX0RNRV9ISUJFUl9FWElULCBQUkVfQ0hBTkdFKTsNCj4g
K3Vmc2hjZF92b3BzX2hpYmVybjhfbm90aWZ5KGhiYSwgVUlDX0NNRF9ETUVfSElCRVJfRVhJVCwg
UFJFX0NIQU5HRSwNCj4gKyAgIE5VTEwpOw0KPiANCj4gLXJldCA9IHVmc2hjZF91aWNfcHdyX2N0
cmwoaGJhLCAmdWljX2NtZCk7DQo+ICtyZXQgPSB1ZnNoY2RfdWljX3B3cl9jdHJsKGhiYSwgJnVp
Y19jbWQsIHRydWUpOw0KPiAgIHRyYWNlX3Vmc2hjZF9wcm9maWxlX2hpYmVybjgoZGV2X25hbWUo
aGJhLT5kZXYpLCAiZXhpdCIsDQo+ICAgICAgICBrdGltZV90b191cyhrdGltZV9zdWIoa3RpbWVf
Z2V0KCksIHN0YXJ0KSksIHJldCk7DQo+IA0KPiBAQCAtNDQzNCw3ICs0NDQ3LDcgQEAgaW50IHVm
c2hjZF91aWNfaGliZXJuOF9leGl0KHN0cnVjdCB1ZnNfaGJhDQo+ICpoYmEpDQo+ICAgX19mdW5j
X18sIHJldCk7DQo+ICAgfSBlbHNlIHsNCj4gICB1ZnNoY2Rfdm9wc19oaWJlcm44X25vdGlmeSho
YmEsIFVJQ19DTURfRE1FX0hJQkVSX0VYSVQsDQo+IC1QT1NUX0NIQU5HRSk7DQo+ICsgICBQT1NU
X0NIQU5HRSwgTlVMTCk7DQo+ICAgaGJhLT51ZnNfc3RhdHMubGFzdF9oaWJlcm44X2V4aXRfdHN0
YW1wID0gbG9jYWxfY2xvY2soKTsNCj4gICBoYmEtPnVmc19zdGF0cy5oaWJlcm44X2V4aXRfY250
Kys7DQo+ICAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvaG9zdC9jZG5zLXBsdGZybS5j
IGIvZHJpdmVycy91ZnMvaG9zdC9jZG5zLQ0KPiBwbHRmcm0uYw0KPiBpbmRleCA2NjgxMWQ4ZDE5
MjkuLjI0YzA1ZTVjNDU1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvaG9zdC9jZG5zLXBs
dGZybS5jDQo+ICsrKyBiL2RyaXZlcnMvdWZzL2hvc3QvY2Rucy1wbHRmcm0uYw0KPiBAQCAtMTY0
LDcgKzE2NCw4IEBAIHN0YXRpYyBpbnQgY2Ruc191ZnNfaGNlX2VuYWJsZV9ub3RpZnkoc3RydWN0
DQo+IHVmc19oYmEgDQo+ICpoYmEsDQo+ICAgICogQHN0YXR1czogbm90aWZ5IHN0YWdlIChwcmUs
IHBvc3QgY2hhbmdlKQ0KPiAgICAqLw0KPiAgIHN0YXRpYyB2b2lkIGNkbnNfdWZzX2hpYmVybjhf
bm90aWZ5KHN0cnVjdCB1ZnNfaGJhICpoYmEsIGVudW0gDQo+IHVpY19jbWRfZG1lIGNtZCwNCj4g
LSAgICBlbnVtIHVmc19ub3RpZnlfY2hhbmdlX3N0YXR1cyBzdGF0dXMpDQo+ICsgICAgZW51bSB1
ZnNfbm90aWZ5X2NoYW5nZV9zdGF0dXMgc3RhdHVzLA0KPiArICAgIGJvb2wgKmRpc2FibGVfdWlj
X2NvbXBsX2ludHIpDQo+ICAgew0KPiAgIGlmIChzdGF0dXMgPT0gUFJFX0NIQU5HRSAmJiBjbWQg
PT0gVUlDX0NNRF9ETUVfSElCRVJfRU5URVIpDQo+ICAgY2Ruc191ZnNfZ2V0X2w0X2F0dHIoaGJh
KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2hvc3QvdWZzLWV4eW5vcy5jIGIvZHJpdmVy
cy91ZnMvaG9zdC91ZnMtDQo+IGV4eW5vcy5jDQo+IGluZGV4IDE2YWQzNTI4ZDgwYi4uZTk5MWQ5
ZTVlMmU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vmcy9ob3N0L3Vmcy1leHlub3MuYw0KPiAr
KysgYi9kcml2ZXJzL3Vmcy9ob3N0L3Vmcy1leHlub3MuYw0KPiBAQCAtMTYyNCw4ICsxNjI0LDkg
QEAgc3RhdGljIGludCBleHlub3NfdWZzX3B3cl9jaGFuZ2Vfbm90aWZ5KHN0cnVjdCANCj4gdWZz
X2hiYSAqaGJhLA0KPiAgIH0NCj4gDQo+ICAgc3RhdGljIHZvaWQgZXh5bm9zX3Vmc19oaWJlcm44
X25vdGlmeShzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KPiAtICAgICBlbnVtIHVpY19jbWRfZG1lIGVu
dGVyLA0KPiAtICAgICBlbnVtIHVmc19ub3RpZnlfY2hhbmdlX3N0YXR1cyBub3RpZnkpDQo+ICsg
ICAgICBlbnVtIHVpY19jbWRfZG1lIGVudGVyLA0KPiArICAgICAgZW51bSB1ZnNfbm90aWZ5X2No
YW5nZV9zdGF0dXMgbm90aWZ5LA0KPiArICAgICAgYm9vbCAqZGlzYWJsZV91aWNfY29tcGxfaW50
cikNCj4gICB7DQo+ICAgc3dpdGNoICgodTgpbm90aWZ5KSB7DQo+ICAgY2FzZSBQUkVfQ0hBTkdF
Og0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91ZnMvdWZzaGNkLmggYi9pbmNsdWRlL3Vmcy91ZnNo
Y2QuaA0KPiBpbmRleCBhNDNiMTQyNzZiYzMuLjU5YjkwMWQ2NzQwMCAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS91ZnMvdWZzaGNkLmgNCj4gKysrIGIvaW5jbHVkZS91ZnMvdWZzaGNkLmgNCj4gQEAg
LTM1NSw4ICszNTUsOSBAQCBzdHJ1Y3QgdWZzX2hiYV92YXJpYW50X29wcyB7DQo+ICAgdm9pZCgq
c2V0dXBfeGZlcl9yZXEpKHN0cnVjdCB1ZnNfaGJhICpoYmEsIGludCB0YWcsDQo+ICAgICBib29s
IGlzX3Njc2lfY21kKTsNCj4gICB2b2lkKCpzZXR1cF90YXNrX21nbXQpKHN0cnVjdCB1ZnNfaGJh
ICosIGludCwgdTgpOw0KPiAtdm9pZCAgICAoKmhpYmVybjhfbm90aWZ5KShzdHJ1Y3QgdWZzX2hi
YSAqLCBlbnVtIHVpY19jbWRfZG1lLA0KPiAtZW51bSB1ZnNfbm90aWZ5X2NoYW5nZV9zdGF0dXMp
Ow0KPiArdm9pZCgqaGliZXJuOF9ub3RpZnkpKHN0cnVjdCB1ZnNfaGJhICosIGVudW0gdWljX2Nt
ZF9kbWUsDQo+ICsgIGVudW0gdWZzX25vdGlmeV9jaGFuZ2Vfc3RhdHVzLA0KPiArICBib29sICpk
aXNhYmxlX3VpY19jb21wbF9pbnRyKTsNCj4gICBpbnQoKmFwcGx5X2Rldl9xdWlya3MpKHN0cnVj
dCB1ZnNfaGJhICpoYmEpOw0KPiAgIHZvaWQoKmZpeHVwX2Rldl9xdWlya3MpKHN0cnVjdCB1ZnNf
aGJhICpoYmEpOw0KPiAgIGludCAgICAgKCpzdXNwZW5kKShzdHJ1Y3QgdWZzX2hiYSAqLCBlbnVt
IHVmc19wbV9vcCwNCj4gDQo=

