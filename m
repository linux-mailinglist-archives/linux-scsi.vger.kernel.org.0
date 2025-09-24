Return-Path: <linux-scsi+bounces-17478-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78DB985B8
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5293419C4249
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Sep 2025 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882F23FC41;
	Wed, 24 Sep 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="B2fxht3N"
X-Original-To: linux-scsi@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88B23E350;
	Wed, 24 Sep 2025 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694408; cv=fail; b=AsVgvFFDKSTyjTi6s/+I42F3b92IjnSSpTkYyYhn7/YWyLZLR54dOvZuTpD3CzekNyoU4fO/xl0gir+j6LhIPwQuyrAspi/FLCCyj4fVzS0t9H7xJ0GokjKmDx96XzhDvRdMKJGWnbuM65OqOKQzdiJORFeeyVIw2adR7FEq0Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694408; c=relaxed/simple;
	bh=JgeQbQ7WyVysvf2/WvD3pjTzp3U/2MNcUSblhNN7XD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YdvkEMU/2+FGW85LUCfSBGHZXRWZdn08KrN6qvvW6mFhlMD67+noLPBmv1mfOHI2JlfPxiOieDPr4u3+l8Nl7jqclUb913xEUPB7ChIuxs/KWFUJ6myuS2NtRfLgnRYjo7wQXXuLfBYq+mkvVDHE97F7HIw1s75P7lVsd3oQol0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=B2fxht3N; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1758694407; x=1790230407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgeQbQ7WyVysvf2/WvD3pjTzp3U/2MNcUSblhNN7XD8=;
  b=B2fxht3NJ8fcC1J9h8BM25icVDtYyfD5lAE3+Ljallk3p27V9vIt/4uq
   Vz252WSgp2d4UN3u2gcFfu69GcBxceshLljCS6btESSQMlAMdx6RCZBpN
   mk1IifjtZGE7FRgwH1amAtcs1YtD/5qMu+83dJRxrNZcoN5RjaibnfyJN
   E7AS/jOyP1bHofuU0Bh4QvjS7iJUy4orviWF5/sCYuxDsb7+Sih/3bm5R
   D0r8yhIM/UagLW0wWWY0KctuL48hFwZNZdxH4cqWGR5Eyk+i3Vm+cusDg
   aWYSbQDwGoienOwvTHRyfo+G4DZp7jFWNGN56ljmaGHZIGi6xfR3s4pSX
   w==;
X-CSE-ConnectionGUID: Sk1Gd34iTQqVpqu0qvTOog==
X-CSE-MsgGUID: Gv+bQsFnQOKqqWMWgvsgDg==
Received: from mail-eastus2azon11021143.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.143])
  by ob1.hc6817-7.iphmx.com with ESMTP; 23 Sep 2025 23:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz1A6yXufRD59NpxCUMJVqxe77QGWN+qYrtnrxmXl2ONKRp1+upZmeGFIaXlZOltUEuN/8hsc+KEtcrpHnwB3JY2Wugl8lxPwIcTGkzNP6jBvxuAO8Q3tRtGXT/3ophtlTuIa/GMFiek6wi0M1zJ4DX2QGeWjOcSmXMM955sf3UzIW+sk3fcvNilIAcjsbJTcGkKqlVkSzojAPKRwYT+dKkm0d7cfa1xqqFg9PQhpnv2h7tiZMNpN3ag2vuUh3oMjc9/Ixf2Jj9PLCLbNSNk9gVRqsCBNdVCML9bAiHRhshk+BTLztOV9RMkC/63uKY/yL/ekFt3xQEkCpWSm46+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgeQbQ7WyVysvf2/WvD3pjTzp3U/2MNcUSblhNN7XD8=;
 b=GtZmfZXWeg4WUToWqc6tJZuTKtxYDKnGrcc2BZlMcUgPlwp7IDAV4TcFPvXwceqKJP4+BrokAIV0nHS9KPbefW9HEsCjiz/iJOblv2A6RwHd+DuZCtt6SSNFnpkS8mUzayEfANELkcoTbv2xGHl2KrZ7+b8F9jWspLWXdDVqT9OqrsiUERYKTp3keFNVDJ13jvl8lmtm+2tgP0akBd/wkmEq3daqPbb17MZBO3uTxpYiaZ6z0+tfLWfc6/cdAxWaeol9CgHYR68RfVRlmh5QaqP9WOxu+H2cECZCDS8knTsuu66eN6LPaD5/pVFE0mzHpIaqktD2k8jv7xGqU6T4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CO6PR16MB4131.namprd16.prod.outlook.com (2603:10b6:303:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:12:14 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491%5]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 06:12:14 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Bean Huo <beanhuo@iokpp.de>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"can.guo@oss.qualcomm.com" <can.guo@oss.qualcomm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "beanhuo@micron.com"
	<beanhuo@micron.com>, "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] rpmb: move rpmb_frame struct and constants to
 common header
Thread-Topic: [PATCH v1 1/3] rpmb: move rpmb_frame struct and constants to
 common header
Thread-Index: AQHcLKBk9K6n/AHCckaM7aGTNHWx87Sh2FRw
Date: Wed, 24 Sep 2025 06:12:14 +0000
Message-ID:
 <PH7PR16MB6196C3B7F5186F3E63C05A3FE51CA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250923153906.1751813-1-beanhuo@iokpp.de>
 <20250923153906.1751813-2-beanhuo@iokpp.de>
In-Reply-To: <20250923153906.1751813-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CO6PR16MB4131:EE_
x-ms-office365-filtering-correlation-id: abd8ccbf-24d2-4bc2-1f30-08ddfb314e49
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SndJUURrbnJrS3M2cVNOdlo3SFZ6Vjg2QzlSNnlVQXFVVDJDdFgyNVpOUXA3?=
 =?utf-8?B?U0xGVHRHYjZxRUZ6aWM2YVVkOUNNcEtFUm1WcHp6NXpUTkZtRnE3YWtuS3Mw?=
 =?utf-8?B?MExVa3hGeUp3azlaOVFSZjE5OEVtd3dPd3BTWlpMWmxZUnMya3NQakdsZG51?=
 =?utf-8?B?Qk5Vb3g0VGU5STNja2ttcEJ1aWorVW5ybkkwTmNBT2FEUG5iaUJ0ZVlYNkVD?=
 =?utf-8?B?cnRvUDZKQjNVcW1GRXo5OFVGNjZnSm0wYzVick9BOGJFaDBmOFNvRllYNk42?=
 =?utf-8?B?b2hNK0RGNEJEZmFtY2l6WGdGMzJmbGxFYytUdllqUFp0NitKZkR5WHhiS1lR?=
 =?utf-8?B?Y3UrZkcvbEQxMHN2MnRhUzlQanpydEE3ZWFoVGFha1A5SE1KY1o4Sk51NjBK?=
 =?utf-8?B?TTEzV2Y0aTA4RWpKM1k2VkNMclFRZzU0a3pXOXlFWVFXNlMwcXVqb0JLMDVU?=
 =?utf-8?B?RVNvZklENGVncEN5WldrSEU3UDE1UG0zaFpVL3dkdmU5cUhkQVJDaUhaNXVN?=
 =?utf-8?B?ZnVxNlI0OThzMlk1blV3em9wNERrdHVYL0cvVzlhakZ4QzZQdytOWXRReE5E?=
 =?utf-8?B?OG1KbHlGTUh4cGFXTnEraE1QbDlvV3ROR05TNFFKVGVuTytodlpDWGNScHpV?=
 =?utf-8?B?cWxGRURrV250TU94eHFFenR3TlpaTXgwcWJMM3NFcGtZekZWaG1XT3kvQmc3?=
 =?utf-8?B?cmw2aUpZRzk5OVkweEVUcDdRR2E4TmUwc2YwSEtNWXJQR25Ma0Y2OFBFVDhw?=
 =?utf-8?B?a1dSV1FjY1g1b3ZlbGFkUGVndmJaWHN5bGdJb1gzLy9xZnRYMEVSQ2pEQWpy?=
 =?utf-8?B?OHRLK09wVnVhWVdzUnVTdGdYdnZic0pHTEpkVmNyRWVHVUR0Vm1ZV2xxVk91?=
 =?utf-8?B?czcxZHZOTmUzR2JNd25MT2Vtelk0V3R3d3ZSQmtqdUlLbDdwUStLNHRvYUFr?=
 =?utf-8?B?c3F6ajJTTTEvVTNLUEJxTEhNM25LRGwycjJOaUhITWNwaFFLbk1NSGhGbDU0?=
 =?utf-8?B?SVFhR1JVdmg0Z2MwRUdVR0ZBdnM2TXZiTzFoN011WUZ5QmJYakhIdVpLVFVa?=
 =?utf-8?B?dGdXbTFNZHJwcFp6YTdWZ2NaSGxGRjIxOUFXSEhSME1xMXZCd29nL3hpRmds?=
 =?utf-8?B?bjBwRUVCMjJJSEVSbFVML1RoMFZOdi9VZ25UcDFGUEw3K3hScXFIZWVIL1JR?=
 =?utf-8?B?Rkg2NGRvQUJmZDQ0R25rUTg0Vy91OUZmMDdJTHYzUGtmN3NzaE9PRW5DV0pY?=
 =?utf-8?B?NUoxcnU5VjRxM1NtU3hnNVBlQ1BXWkpyZ3JoTUVjbXErREpFRGIrN2s1UDJ0?=
 =?utf-8?B?bkh0NS84YkpNbjVlaFlmajNDNGxPSFgrS0pkY25nQVpTZkVYdFZxRmY5dkMr?=
 =?utf-8?B?MWxvMEF5OGVnYlg1K2VWRm53d0JtUHVyR0JiY01aZmErVEE4MTFQUE5wQmZp?=
 =?utf-8?B?NUF4MzdnRkNVUC9JdDd0TVZtemhaaTlnb2hpU1BwMy9VM2lOVUN5NW9Wd0pr?=
 =?utf-8?B?Zjg5QWg3NG5oRmxiaHJsMkdvREI4NUVsMmZ2Z2RJOGsyNE1sWUlYN0pqei81?=
 =?utf-8?B?aTdzWEtkOTFERGZPUUsrQlN3UGJkMVVMbmpGVDFJUncrSnRrL1hqbCtWMUU4?=
 =?utf-8?B?aUNsUGFPNm1FVFJGRmIxR1VodGdISU9ZejF1U0lxUEZCSkg4eDU3UVYxS3ov?=
 =?utf-8?B?bDdKNlhrV2ZqZERXYUMxTExqNUxybDJpNWM2NTRGQnBSTVR0VXZmZ2ZHSGJu?=
 =?utf-8?B?OWNCTnRDeUxWcHlhSDRnQlNRQklPMVh1K1hhb09hVmE5Vm16ZExXN2JUZG5L?=
 =?utf-8?B?b2pOWmM4SkorU2FqVVNMcFI1aU1XdmpYZnhnMk5SazVYbXlRa3lnL3IxVlUx?=
 =?utf-8?B?STBTbndRbXRQVEI5ajdvZW5DaW9KczJKaXFCZnpHNEJBb0VSL21TM0lrMUVK?=
 =?utf-8?B?b052Y3ZtbU93UGtvcWQ5M2ZFSnpPbGZ1aDVFSXZqMkp1d25zWXcveHhMMncy?=
 =?utf-8?Q?NSgJ8wrH3wH1eVEIufe802ru/SnbGc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHhLSDEzcWcrdHlyS0pMampVV2MvWFZ0aGZIcW5NOWJXVVJZMFFieWlYbTVO?=
 =?utf-8?B?STZMeHNYa1Y1UTF0WFZpWjkwaXlORmlMazhyUVJjK1Q4c1JTQ1VNaml1eDVh?=
 =?utf-8?B?M2lUcUorN1VqWllZcjZTVXZxL1RiRmQ2L20xNGVMa3l1aE54a0twQThVNlNZ?=
 =?utf-8?B?STFLa3oyTnZMd2c2RWxpQzAwKzUydjlUNzBZZUlWUCtrN3dqWTkvS0pHV3V4?=
 =?utf-8?B?SlBTc1ZGTDVFdnMyaXdKZnRsRE04MnIwUU1WQXBDV0FqWFlSSUZlZWF3TjlJ?=
 =?utf-8?B?U0xMZFVOUlg5eEowemVtYmJ3a0lGMkdUNHBuS2ZVOEdlUGFPZlZTdjB5UmU1?=
 =?utf-8?B?cFZLbG9JNTN2b2FuMjN4RlVWRzFqRnFUYURwbHJ2U1J4cHFzZlZ4VEtDVllN?=
 =?utf-8?B?UVl6OXhHdkR4cXNOL2ppZjBzODhaNTF4bEZNNmkyTTNXOHl2bmVJNkxrWTYr?=
 =?utf-8?B?eHNYZzh1T05nT1ROTlkvWGZQQzg5aGFWMTJlUElsNU1sKzhVT1JiY0hHeXVp?=
 =?utf-8?B?ZTdLNWJoQnYzOUhScDhtbDNaSk80OVEzN1JQdHZqZG93SzRGTi94OG5JSXR2?=
 =?utf-8?B?cWUzeVJEcHJuWTB6SFJ0dnJlVnpreHdWTXdITmdHTjZYUjFqZ2t3QkM2aXZJ?=
 =?utf-8?B?STd1VTdISE9kMTR0OG8yaXFzVDNVNXl2YnduNzhVeldNRzBTQXc5R2gramNY?=
 =?utf-8?B?WE5MTWZiN0pQbHlMV0t2eFh1emhiUDY1VWdYcHpxYVA1bTM4a3BzbXFpblla?=
 =?utf-8?B?Y0lUSGhHdHhXUCtnaFRTN0QxL09VRWsySUJMRVFabWVIYkxaVHBleFlJeXg5?=
 =?utf-8?B?TmRMY3FKRlpacnkzQVk5RW1yTnkwQWZuK0kzWmpsVDY3ZG9hLzN6c2w0QlVB?=
 =?utf-8?B?UmJkMVhBU3V6ZVhiczZCbzk2K3FSRDlXWGdQOTVWeHJSbHhVSnNFS2xkZXZl?=
 =?utf-8?B?Sis4eEdvQkFMd0lacVBvNWpJSWJVM1E0YWJGQzFTTkthN2NhR1dITnB2ODRo?=
 =?utf-8?B?bzY3ZGw4MUcxT3FsUnpLWTQ0eElkN3ZsL0pxTmN5T1IxZXY0dWlVekVDZE9F?=
 =?utf-8?B?NFI2cEV4ZFhIWkZCK3E2VzlKTzhBMytIZTlTNlhJd3JOQVpHR1J6ckFOejB3?=
 =?utf-8?B?bjNLdzNqK2d6eW5GUXY0UTBKSkR4UzIxQnA1YXpsdk5yYzlmakNDaWxlOVhI?=
 =?utf-8?B?NkpqWmdhRkd0bCt6ODYzMFkxVTM0QnVINzZmSmtaNHd0MVp2Yis3S3RvTkRS?=
 =?utf-8?B?VVhDTWxyS0IrbmdxS3VZb1laUHZtdnl2dnlEK2pjOFBYdDZGZ3hHN3kzTTRy?=
 =?utf-8?B?UFdCckcySXRvVVprUElyUnB4aDJER0RnOW5EYUpiUjRXN3BjRldacmxSQ3F6?=
 =?utf-8?B?cm1FUXVWM3BqUTdTSWQ5c2ZRR2NibHRBYmd6T3krMFZNV1dIRVFBQ3F3a1Vn?=
 =?utf-8?B?VFdWQ1ZBeG9LazAydE9YRy9FM0pkRXZtWWlHcGlydENJK2VRSzI0UHdDRlkr?=
 =?utf-8?B?ZTN1NUNhRTg0SzFqVkpaRmlOS3RiMFFkcTQwMElUb2V5SjU1ZFF6OVJxcWdX?=
 =?utf-8?B?Y3NEdGlSTTl2RFpNWWNPME9lNWJ3RGt3Y2czQ0UvSnVhR2l4Zk4zcHM4WGFK?=
 =?utf-8?B?eDV5TURCd3I1THlocFk1c2ZVZWVrZzlOSXhONmpWekF1VysyUGhVcndLQTh1?=
 =?utf-8?B?S1F0VDV2QXdhZTRNQnBXcXdmaFM0TXA3d3E2cWdHVFJnNEttanloSzI4Sisr?=
 =?utf-8?B?amZUSjZIaHR5cWRqOEozUUxoR3Vva01XbkR1bnh1c0tzNSsyVVM1ZXdSSnVV?=
 =?utf-8?B?Y2RjU1B4M3ZOelR4VU5wYkN1bmVLUWhJYUJUTFZLZzB4Q2kzMDZXdXRFTDEz?=
 =?utf-8?B?ekRhMGkvQ01JMmlIZ0dzY3lNMkcvUGRLUkFtQWswNWdQbTJiTmsyQVppeXpU?=
 =?utf-8?B?S3dwRnJRQ1pJemRYNjU4L0NweStUZ0psUFdGSDk3R1VHcERvZTdyRFNFejh4?=
 =?utf-8?B?U2hjQ01CcEl5cFUvM3U2ajFjVGFqM2Z2Zld2dDIzL2N2eVc0OEsxUGw2RjY4?=
 =?utf-8?B?Z0pUVmpaeU5Ub0Q0R1hVd0ZyVDR3TmI0STF5dldmSm5RY1hVOEMvY2ZPRERP?=
 =?utf-8?Q?QquNL6oif92LXsayoJHnHEZxp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GED+7wlwCEZxR7XPmP5Zfp270VSCIS+F6ZOtzT95lgsU8JTNjsSX/5wqK/Q53drRKbJj5vkWleoEEPNihV2LPis7/MhdKBP9Gi5Ya3TQb4YROYdgLOAymKfnfQiT6XP0Ltiw1vAk6Mumj9dDF98yZi5Dhu9jUBGzFRaDYmyYrJ9pH1AsVwBUdCYRfneEim2o+ZOqovlPaoBkFSwfLLcCCJ6+vz8htYcDBjC0iAMaCG3CTZSNiOZso8JQhIyKcuBCjFNoTlTK1ww1rv7WqYTBicLVXuhKET5gXz3C2fKKa3bgI5Gu/BvH1ggC9VVCW1vvZcKvouM7GPBVMT2cMnpH5i8gafas4n3lAK5jNiaTsFjimnx7chHmIRLrpuBY/FPoORvxyWmNVceg7T8hPnnjCfJqQurCI15W+V67Ih1I3KmR+qyRpfTmpv2q3UjzFuQiiA+CRAtM0qt4gJdn8oYAbFAMdrDaI9k2DDtH7Gu3tSRqHQbUZsPeoCBlxFDzkJWLgK/SL+1T+Y0a4dz41s4j/RayskMktVZRqT2JOVIWYEVf/oDtkeLHOirOJenO52KuWKb8fvdIs8XI8c4+okWqo+wL1sKagUIvY+omfC6mAIT6jYFlhidnrgJ7xpRKOE0aOZjds6Donuz/bP/W5kUNIw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8ccbf-24d2-4bc2-1f30-08ddfb314e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 06:12:14.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwC9+eyRlWJIKweZJ1KL9yZLsmH5pwD746/SsilKnpR7kgJ1f3R2ZfXJxbUUqjF73WRjFlDHkwsbINYnXCmOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4131

PiBGcm9tOiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiANCj4gTW92ZSBzdHJ1Y3Qg
cnBtYl9mcmFtZSBhbmQgUlBNQiBvcGVyYXRpb24gY29uc3RhbnRzIGZyb20gTU1DIGJsb2NrDQo+
IGRyaXZlciB0byBpbmNsdWRlL2xpbnV4L3JwbWIuaCBmb3IgcmV1c2UgYWNyb3NzIGRpZmZlcmVu
dCBSUE1CDQo+IGltcGxlbWVudGF0aW9ucyAoVUZTLCBOVk1lLCBldGMuKS4NClVGUyBSUE1CIGRp
ZmZlcnMgZnJvbSBtbWMgUlBNQiBpbiBzZXZlcmFsIGxldmVsczoNCiAtIDkgdnMuIDUgb3BlcmF0
aW9ucw0KIC0gZnJhbWUgc3RydWN0dXJlOiBleHRlbmRlZCA0aw0KIC0gcnBtYiB1bml0IGRlc2Ny
aXB0b3INCmV0Yy4NCkFuZCBhcyB0aW1lIGdvZXMgb24sIHRoaXMgZ2FwIGlzIGxpa2VseSB0byBi
ZWNvbWUgbGFyZ2VyLA0KQXMgbW1jIGlzIG5vdCB2ZXJ5IGxpa2VseSB0byBpbnRyb2R1Y2UgbWFq
b3IgY2hhbmdlcy4NCg0KVGh1cywgeW91IG1pZ2h0IHdhbnQgdG8gY29uc2lkZXIgaGF2aW5nIGFu
IGludGVybmFsIHVmcyBoZWFkZXIgLSB3aWxsIHNpbXBsaWZ5IHRoaW5ncyBpbiB0aGUgZnV0dXJl
Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlYW4gSHVvIDxiZWFu
aHVvQG1pY3Jvbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwgNDIg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgv
cnBtYi5oICAgICB8IDQ0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9t
bWMvY29yZS9ibG9jay5jDQo+IGluZGV4IGIzMmVlZmNjYTRiNy4uYmQ1ZjZmY2IwM2FmIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gKysrIGIvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jDQo+IEBAIC03OSw0OCArNzksNiBAQCBNT0RVTEVfQUxJQVMoIm1tYzpibG9j
ayIpOw0KPiAgI2RlZmluZSBNTUNfRVhUUkFDVF9JTkRFWF9GUk9NX0FSRyh4KSAoKHggJiAweDAw
RkYwMDAwKSA+PiAxNikNCj4gICNkZWZpbmUgTU1DX0VYVFJBQ1RfVkFMVUVfRlJPTV9BUkcoeCkg
KCh4ICYgMHgwMDAwRkYwMCkgPj4gOCkNCj4gDQo+IC0vKioNCj4gLSAqIHN0cnVjdCBycG1iX2Zy
YW1lIC0gcnBtYiBmcmFtZSBhcyBkZWZpbmVkIGJ5IGVNTUMgNS4xIChKRVNEODQtQjUxKQ0KPiAt
ICoNCj4gLSAqIEBzdHVmZiAgICAgICAgOiBzdHVmZiBieXRlcw0KPiAtICogQGtleV9tYWMgICAg
ICA6IFRoZSBhdXRoZW50aWNhdGlvbiBrZXkgb3IgdGhlIG1lc3NhZ2UgYXV0aGVudGljYXRpb24N
Cj4gLSAqICAgICAgICAgICAgICAgICBjb2RlIChNQUMpIGRlcGVuZGluZyBvbiB0aGUgcmVxdWVz
dC9yZXNwb25zZSB0eXBlLg0KPiAtICogICAgICAgICAgICAgICAgIFRoZSBNQUMgd2lsbCBiZSBk
ZWxpdmVyZWQgaW4gdGhlIGxhc3QgKG9yIHRoZSBvbmx5KQ0KPiAtICogICAgICAgICAgICAgICAg
IGJsb2NrIG9mIGRhdGEuDQo+IC0gKiBAZGF0YSAgICAgICAgIDogRGF0YSB0byBiZSB3cml0dGVu
IG9yIHJlYWQgYnkgc2lnbmVkIGFjY2Vzcy4NCj4gLSAqIEBub25jZSAgICAgICAgOiBSYW5kb20g
bnVtYmVyIGdlbmVyYXRlZCBieSB0aGUgaG9zdCBmb3IgdGhlIHJlcXVlc3RzDQo+IC0gKiAgICAg
ICAgICAgICAgICAgYW5kIGNvcGllZCB0byB0aGUgcmVzcG9uc2UgYnkgdGhlIFJQTUIgZW5naW5l
Lg0KPiAtICogQHdyaXRlX2NvdW50ZXI6IENvdW50ZXIgdmFsdWUgZm9yIHRoZSB0b3RhbCBhbW91
bnQgb2YgdGhlIHN1Y2Nlc3NmdWwNCj4gLSAqICAgICAgICAgICAgICAgICBhdXRoZW50aWNhdGVk
IGRhdGEgd3JpdGUgcmVxdWVzdHMgbWFkZSBieSB0aGUgaG9zdC4NCj4gLSAqIEBhZGRyICAgICAg
ICAgOiBBZGRyZXNzIG9mIHRoZSBkYXRhIHRvIGJlIHByb2dyYW1tZWQgdG8gb3IgcmVhZA0KPiAt
ICogICAgICAgICAgICAgICAgIGZyb20gdGhlIFJQTUIuIEFkZHJlc3MgaXMgdGhlIHNlcmlhbCBu
dW1iZXIgb2YNCj4gLSAqICAgICAgICAgICAgICAgICB0aGUgYWNjZXNzZWQgYmxvY2sgKGhhbGYg
c2VjdG9yIDI1NkIpLg0KPiAtICogQGJsb2NrX2NvdW50ICA6IE51bWJlciBvZiBibG9ja3MgKGhh
bGYgc2VjdG9ycywgMjU2QikgcmVxdWVzdGVkIHRvIGJlDQo+IC0gKiAgICAgICAgICAgICAgICAg
cmVhZC9wcm9ncmFtbWVkLg0KPiAtICogQHJlc3VsdCAgICAgICA6IEluY2x1ZGVzIGluZm9ybWF0
aW9uIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhlIHdyaXRlIGNvdW50ZXINCj4gLSAqICAgICAgICAg
ICAgICAgICAodmFsaWQsIGV4cGlyZWQpIGFuZCByZXN1bHQgb2YgdGhlIGFjY2VzcyBtYWRlIHRv
IHRoZSBSUE1CLg0KPiAtICogQHJlcV9yZXNwICAgICA6IERlZmluZXMgdGhlIHR5cGUgb2YgcmVx
dWVzdCBhbmQgcmVzcG9uc2UgdG8vZnJvbSB0aGUNCj4gbWVtb3J5Lg0KPiAtICoNCj4gLSAqIFRo
ZSBzdHVmZiBieXRlcyBhbmQgYmlnLWVuZGlhbiBwcm9wZXJ0aWVzIGFyZSBtb2RlbGVkIHRvIGZp
dCB0byB0aGUgc3BlYy4NCj4gLSAqLw0KPiAtc3RydWN0IHJwbWJfZnJhbWUgew0KPiAtICAgICAg
IHU4ICAgICBzdHVmZlsxOTZdOw0KPiAtICAgICAgIHU4ICAgICBrZXlfbWFjWzMyXTsNCj4gLSAg
ICAgICB1OCAgICAgZGF0YVsyNTZdOw0KPiAtICAgICAgIHU4ICAgICBub25jZVsxNl07DQo+IC0g
ICAgICAgX19iZTMyIHdyaXRlX2NvdW50ZXI7DQo+IC0gICAgICAgX19iZTE2IGFkZHI7DQo+IC0g
ICAgICAgX19iZTE2IGJsb2NrX2NvdW50Ow0KPiAtICAgICAgIF9fYmUxNiByZXN1bHQ7DQo+IC0g
ICAgICAgX19iZTE2IHJlcV9yZXNwOw0KPiAtfSBfX3BhY2tlZDsNCj4gLQ0KPiAtI2RlZmluZSBS
UE1CX1BST0dSQU1fS0VZICAgICAgIDB4MSAgICAvKiBQcm9ncmFtIFJQTUIgQXV0aGVudGljYXRp
b24gS2V5DQo+ICovDQo+IC0jZGVmaW5lIFJQTUJfR0VUX1dSSVRFX0NPVU5URVIgMHgyICAgIC8q
IFJlYWQgUlBNQiB3cml0ZSBjb3VudGVyICovDQo+IC0jZGVmaW5lIFJQTUJfV1JJVEVfREFUQSAg
ICAgICAgMHgzICAgIC8qIFdyaXRlIGRhdGEgdG8gUlBNQiBwYXJ0aXRpb24gKi8NCj4gLSNkZWZp
bmUgUlBNQl9SRUFEX0RBVEEgICAgICAgICAweDQgICAgLyogUmVhZCBkYXRhIGZyb20gUlBNQiBw
YXJ0aXRpb24gKi8NCj4gLSNkZWZpbmUgUlBNQl9SRVNVTFRfUkVBRCAgICAgICAweDUgICAgLyog
UmVhZCByZXN1bHQgcmVxdWVzdCAgKEludGVybmFsKSAqLw0KPiAtDQo+ICAjZGVmaW5lIFJQTUJf
RlJBTUVfU0laRSAgICAgICAgc2l6ZW9mKHN0cnVjdCBycG1iX2ZyYW1lKQ0KPiAgI2RlZmluZSBD
SEVDS19TSVpFX05FUSh2YWwpICgodmFsKSAhPSBzaXplb2Yoc3RydWN0IHJwbWJfZnJhbWUpKQ0K
PiAgI2RlZmluZSBDSEVDS19TSVpFX0FMSUdORUQodmFsKSBJU19BTElHTkVEKCh2YWwpLCBzaXpl
b2Yoc3RydWN0DQo+IHJwbWJfZnJhbWUpKQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9y
cG1iLmggYi9pbmNsdWRlL2xpbnV4L3JwbWIuaA0KPiBpbmRleCBjY2NkYTczZWVhNGQuLjE0MTVj
ZWI0NThmZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9ycG1iLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9ycG1iLmgNCj4gQEAgLTYxLDYgKzYxLDUwIEBAIHN0cnVjdCBycG1iX2RldiB7
DQo+IA0KPiAgI2RlZmluZSB0b19ycG1iX2Rldih4KSAgICAgICAgIGNvbnRhaW5lcl9vZigoeCks
IHN0cnVjdCBycG1iX2RldiwgZGV2KQ0KPiANCj4gKy8qKg0KPiArICogc3RydWN0IHJwbWJfZnJh
bWUgLSBSUE1CIGZyYW1lIHN0cnVjdHVyZSBmb3IgYXV0aGVudGljYXRlZCBhY2Nlc3MNCj4gKyAq
DQo+ICsgKiBAc3R1ZmYgICAgICAgIDogc3R1ZmYgYnl0ZXMsIGEgcGFkZGluZy9yZXNlcnZlZCBh
cmVhIG9mIDE5NiBieXRlcyBhdCB0aGUNCj4gKyAqICAgICAgICAgICAgICAgICBiZWdpbm5pbmcg
b2YgdGhlIFJQTUIgZnJhbWUuIFRoZXkgZG9u4oCZdCBjYXJyeSBtZWFuaW5nZnVsDQo+ICsgKiAg
ICAgICAgICAgICAgICAgZGF0YSBidXQgYXJlIHJlcXVpcmVkIHRvIG1ha2UgdGhlIGZyYW1lIGV4
YWN0bHkgNTEyIGJ5dGVzLg0KPiArICogQGtleV9tYWMgICAgICA6IFRoZSBhdXRoZW50aWNhdGlv
biBrZXkgb3IgdGhlIG1lc3NhZ2UgYXV0aGVudGljYXRpb24NCj4gKyAqICAgICAgICAgICAgICAg
ICBjb2RlIChNQUMpIGRlcGVuZGluZyBvbiB0aGUgcmVxdWVzdC9yZXNwb25zZSB0eXBlLg0KPiAr
ICogICAgICAgICAgICAgICAgIFRoZSBNQUMgd2lsbCBiZSBkZWxpdmVyZWQgaW4gdGhlIGxhc3Qg
KG9yIHRoZSBvbmx5KQ0KPiArICogICAgICAgICAgICAgICAgIGJsb2NrIG9mIGRhdGEuDQo+ICsg
KiBAZGF0YSAgICAgICAgIDogRGF0YSB0byBiZSB3cml0dGVuIG9yIHJlYWQgYnkgc2lnbmVkIGFj
Y2Vzcy4NCj4gKyAqIEBub25jZSAgICAgICAgOiBSYW5kb20gbnVtYmVyIGdlbmVyYXRlZCBieSB0
aGUgaG9zdCBmb3IgdGhlIHJlcXVlc3RzDQo+ICsgKiAgICAgICAgICAgICAgICAgYW5kIGNvcGll
ZCB0byB0aGUgcmVzcG9uc2UgYnkgdGhlIFJQTUIgZW5naW5lLg0KPiArICogQHdyaXRlX2NvdW50
ZXI6IENvdW50ZXIgdmFsdWUgZm9yIHRoZSB0b3RhbCBhbW91bnQgb2YgdGhlIHN1Y2Nlc3NmdWwN
Cj4gKyAqICAgICAgICAgICAgICAgICBhdXRoZW50aWNhdGVkIGRhdGEgd3JpdGUgcmVxdWVzdHMg
bWFkZSBieSB0aGUgaG9zdC4NCj4gKyAqIEBhZGRyICAgICAgICAgOiBBZGRyZXNzIG9mIHRoZSBk
YXRhIHRvIGJlIHByb2dyYW1tZWQgdG8gb3IgcmVhZA0KPiArICogICAgICAgICAgICAgICAgIGZy
b20gdGhlIFJQTUIuIEFkZHJlc3MgaXMgdGhlIHNlcmlhbCBudW1iZXIgb2YNCj4gKyAqICAgICAg
ICAgICAgICAgICB0aGUgYWNjZXNzZWQgYmxvY2sgKGhhbGYgc2VjdG9yIDI1NkIpLg0KPiArICog
QGJsb2NrX2NvdW50ICA6IE51bWJlciBvZiBibG9ja3MgKGhhbGYgc2VjdG9ycywgMjU2QikgcmVx
dWVzdGVkIHRvIGJlDQo+ICsgKiAgICAgICAgICAgICAgICAgcmVhZC9wcm9ncmFtbWVkLg0KPiAr
ICogQHJlc3VsdCAgICAgICA6IEluY2x1ZGVzIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzdGF0dXMg
b2YgdGhlIHdyaXRlIGNvdW50ZXINCj4gKyAqICAgICAgICAgICAgICAgICAodmFsaWQsIGV4cGly
ZWQpIGFuZCByZXN1bHQgb2YgdGhlIGFjY2VzcyBtYWRlIHRvIHRoZSBSUE1CLg0KPiArICogQHJl
cV9yZXNwICAgICA6IERlZmluZXMgdGhlIHR5cGUgb2YgcmVxdWVzdCBhbmQgcmVzcG9uc2UgdG8v
ZnJvbSB0aGUNCj4gbWVtb3J5Lg0KPiArICoNCj4gKyAqIFRoZSBzdHVmZiBieXRlcyBhbmQgYmln
LWVuZGlhbiBwcm9wZXJ0aWVzIGFyZSBtb2RlbGVkIHRvIGZpdCB0byB0aGUgc3BlYy4NCj4gKyAq
Lw0KPiArc3RydWN0IHJwbWJfZnJhbWUgew0KPiArICAgICAgIHU4ICAgICBzdHVmZlsxOTZdOw0K
PiArICAgICAgIHU4ICAgICBrZXlfbWFjWzMyXTsNCj4gKyAgICAgICB1OCAgICAgZGF0YVsyNTZd
Ow0KPiArICAgICAgIHU4ICAgICBub25jZVsxNl07DQo+ICsgICAgICAgX19iZTMyIHdyaXRlX2Nv
dW50ZXIgICAgX19wYWNrZWQ7DQo+ICsgICAgICAgX19iZTE2IGFkZHIgICAgICAgICAgICAgX19w
YWNrZWQ7DQo+ICsgICAgICAgX19iZTE2IGJsb2NrX2NvdW50ICAgICAgX19wYWNrZWQ7DQo+ICsg
ICAgICAgX19iZTE2IHJlc3VsdCAgICAgICAgICAgX19wYWNrZWQ7DQo+ICsgICAgICAgX19iZTE2
IHJlcV9yZXNwICAgICAgICAgX19wYWNrZWQ7DQo+ICt9Ow0KPiArDQo+ICsjZGVmaW5lIFJQTUJf
UFJPR1JBTV9LRVkgICAgICAgMHgxICAgIC8qIFByb2dyYW0gUlBNQiBBdXRoZW50aWNhdGlvbg0K
PiBLZXkgKi8NCj4gKyNkZWZpbmUgUlBNQl9HRVRfV1JJVEVfQ09VTlRFUiAweDIgICAgLyogUmVh
ZCBSUE1CIHdyaXRlIGNvdW50ZXIgKi8NCj4gKyNkZWZpbmUgUlBNQl9XUklURV9EQVRBICAgICAg
ICAweDMgICAgLyogV3JpdGUgZGF0YSB0byBSUE1CIHBhcnRpdGlvbiAqLw0KPiArI2RlZmluZSBS
UE1CX1JFQURfREFUQSAgICAgICAgIDB4NCAgICAvKiBSZWFkIGRhdGEgZnJvbSBSUE1CIHBhcnRp
dGlvbiAqLw0KPiArI2RlZmluZSBSUE1CX1JFU1VMVF9SRUFEICAgICAgIDB4NSAgICAvKiBSZWFk
IHJlc3VsdCByZXF1ZXN0ICAoSW50ZXJuYWwpICovDQo+ICsNCj4gICNpZiBJU19FTkFCTEVEKENP
TkZJR19SUE1CKQ0KPiAgc3RydWN0IHJwbWJfZGV2ICpycG1iX2Rldl9nZXQoc3RydWN0IHJwbWJf
ZGV2ICpyZGV2KTsNCj4gIHZvaWQgcnBtYl9kZXZfcHV0KHN0cnVjdCBycG1iX2RldiAqcmRldik7
DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

