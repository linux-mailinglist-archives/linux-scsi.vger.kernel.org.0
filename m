Return-Path: <linux-scsi+bounces-13043-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D08AA6E76B
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Mar 2025 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0247116D776
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Mar 2025 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0283B666;
	Tue, 25 Mar 2025 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Aimb5AQO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669D2F42
	for <linux-scsi@vger.kernel.org>; Tue, 25 Mar 2025 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742861789; cv=fail; b=MXUtBTo27rTVn8p3RzgAgTRGI6dql1Bc6nujqSWuY8lIuopdnalNvuJvzqkyyIPrcV//OqMvWnozX+0YydpNgQKy6GVAfeURi92XVSMzHIpGDAn5I2orVGUNZ1X3JcdfnFEV+8ae6mitc9I4ef5nXmnGOR0INLKNlUcIjplzOJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742861789; c=relaxed/simple;
	bh=yBRXmzP2xdiSCzAoL1Ut5bDo95SKo4wKcZHkKW4GUsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxldJhfYtrv36EPKO5hBEdTvg1oHbb+zhYeXeDvJAZXBiQ9HSlXu5RvORBgoFTtBfdcOr3T6pujdqTPEOnCM5q3IjAbO2ij8spu+4JD7sbSj4YwafO9AqPs3wU56GxSXw1l2lvlG5s7lz92HU4a3+yZN0qKa4F0JA1TWSa/w8pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Aimb5AQO; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs3PJwnD3OEaUpcpKhDBGKOoTVVEW5eDd9hF0zXIPUcNOcwCkpbJlidWyxLRzFDhtVjf6wJJN5vSFUrqLNfxz3v7vhZ631mepvAtNwB/P+DSeUfFHYFwS9gAyACCh1b2zznMPNBhTLOw+mGEIWgesh7oFfUYXW8BB1iJS91saliNgY4VJOt31/zlohiKqI+TGF9Jtyt1XYAVOp1rYGda8bHkrPhc7Dj70gWwNK5zTVa/kqUvOivKiOiO5CADOWWzmODSu/iCWZmJnE+ttSsh1ZX/oyQBpco+7E5TujE6FNlfRrRePoaZGX/8Q9zBjtSvpUX49J/1TxHeRW5krRyAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBRXmzP2xdiSCzAoL1Ut5bDo95SKo4wKcZHkKW4GUsA=;
 b=XZN1VKXDxD5I20+G0vnwd0XtsDgmtAyJ1NN5hcVKkL0ZCfrASF+k9ltRKrwjMH8TahyAytsQdrs2CPfwhPZwk6o1LplGhZxpX0s3K50qYyIi1L0BvkyuB8sIt4N71xjVG7AKKj52c5XD6AZG76Po9iFTGcSvjMLwwOP4UG5RwCsiGmSWFcCOxgRcn4ap7yxUwzeFzU0VBZfGzZJS3o2nLtc3pZ3VaTGM+10ECUKaBknfb+5uTXR5+eUVEFaPDOELz1saVQceybCPOYVQjY0esME8DxubUd7EAtI/k6Ct36LAt/JEG0nE2gecZdj0MVCN9TvEBD6XxTNfgsU5AoEsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBRXmzP2xdiSCzAoL1Ut5bDo95SKo4wKcZHkKW4GUsA=;
 b=Aimb5AQOvBJrEOE3kgVFgmwSI7qZBjB83AiGpVE49ne/T2NDEz+9z5KLcYAbs/sAsOiIqe8xmkGXhr2Rdcpw2iDhk2HhodxjNnUGn7DViyL/IppNtusHFv1E6hvXZPOtOUseqFh7cx2CxEtMHi16ml8o7GWbh0hmj6jcndmVReu4B+UWkJIks1MQRxuXUYJjsqMYrb3NlFl1xDJoKhBKtiCIKDwKT6c2Ihz8+hgMqqOjT7B5SvFfmb8zsWOJq8MaRnVTduRhMSXqiiYaP8x2uzFyZEklY2zswZw01LrBx03MPvtl3SbwKpRMbmg5oHCVSqw20MSKBe++Z0esYBSX6A==
Received: from PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 00:16:23 +0000
Received: from PH7PR11MB7570.namprd11.prod.outlook.com
 ([fe80::f249:c679:94d9:9898]) by PH7PR11MB7570.namprd11.prod.outlook.com
 ([fe80::f249:c679:94d9:9898%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 00:16:23 +0000
From: <Sagar.Biradar@microchip.com>
To: <jmeneghi@redhat.com>, <hare@suse.de>, <martin.petersen@oracle.com>,
	<pheidologeton@protonmail.com>, <kernel@roadkil.net>, <maokaman@gmail.com>
CC: <James.Bottomley@HansenPartnership.com>, <linux-scsi@vger.kernel.org>,
	<thenzl@redhat.com>, <mpatalan@redhat.com>, <Scott.Benesh@microchip.com>,
	<Don.Brace@microchip.com>, <Tom.White@microchip.com>,
	<Abhinav.Kuchibhotla@microchip.com>
Subject: RE: [PATCH] [v2]aacraid: Reply queue mapping to CPUs based on IRQ
 affinity
Thread-Topic: [PATCH] [v2]aacraid: Reply queue mapping to CPUs based on IRQ
 affinity
Thread-Index:
 AQHbcz0tB0IW0OqxSE2ZE7WljSjIKbNEoY/mgAEygn2AAAvHAIALTSb+gAXu44CAFbT0AIACK52AgBRSlDA=
Date: Tue, 25 Mar 2025 00:16:22 +0000
Message-ID:
 <PH7PR11MB7570A7E66942E50167648A56FAA72@PH7PR11MB7570.namprd11.prod.outlook.com>
References: <20250130173314.608836-1-sagar.biradar@microchip.com>
 <yq1mseqwoaa.fsf@ca-mkp.ca.oracle.com>
 <PH7PR11MB757026166DDB8068830AE420FAFF2@PH7PR11MB7570.namprd11.prod.outlook.com>
 <8433b8b8-bb9a-43e0-a760-d8745d28d0d9@redhat.com>
 <yq1eczsjaaz.fsf@ca-mkp.ca.oracle.com>
 <2eca14e0-3978-440f-a4a4-32c9c61baad4@redhat.com>
 <84a87c16-0738-460d-b83f-55f8181d536e@suse.de>
 <c3f77605-3061-461f-8406-8eb0493c71cd@redhat.com>
In-Reply-To: <c3f77605-3061-461f-8406-8eb0493c71cd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7570:EE_|SJ2PR11MB7502:EE_
x-ms-office365-filtering-correlation-id: 895c4f48-d78b-4eff-1843-08dd6b324661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDFwMEo3cjg0M1FOSnJtWkp0UmxYNmF0OUFFV3pPVEkvYUZib0lqaVJQdWZB?=
 =?utf-8?B?Q29pN090b0Y3M1BPcUgrNFVkbFhDc05VK2ExL3QwMmFCTW1SdFkwZSsrWUov?=
 =?utf-8?B?cGlqS0UrbXVDTzJ1SkQ0Vm1UZmVIdFlGZjFTOEZGWFdMdnR6eXkwTVJkYkpT?=
 =?utf-8?B?N1pJVDVmdnREeWpjT251TDdxNHBVVE93KzdvSzROUUJsS0NQQ0xnRjNIRHFM?=
 =?utf-8?B?cGdiWXczQXY4ODd2TUZyVDJ5YTVwNHhJZEpLa3FYenJSTXcrZUF3alZzZE9X?=
 =?utf-8?B?REQ2ZGZMMmtvSDlLbmd5b3NJemhXZHo4WjhLdzcxMHZNQ3lPNUxqbXYrdW5I?=
 =?utf-8?B?MkxteG5FZS9zZ2EwZVBPV1pTRURKb3JDZVRSQ1pib2lZbGh1QzUzV3ovVExq?=
 =?utf-8?B?MnpZSENaM3pBN0VqWFk3QXlscGIyVW1XVTdndk9QejFDZUZYZFhnWUpOclJG?=
 =?utf-8?B?enh6Q3pmUWhObEFRNDJ3OHhLd1VWY05qQlo5VlBDRGo5NGV4UE5KRUxkZzVy?=
 =?utf-8?B?VVp5eG1TM29NanJTcHU4NktWZ29DYWFhMTU3dy9sKzhTZkExV2lNQ0E2aE9q?=
 =?utf-8?B?QStpUERiS1VaS2d6WGRBYjdJbndDbkRUQlJhM3RiYkpkUjlqaTRvU0liTTJm?=
 =?utf-8?B?enFqWE9pdTQ4NVdGTHNUajVMeEdObDhFVUZXUE1jSGJmMmh4ZEQ2cUdhMExl?=
 =?utf-8?B?WmNSZHdNVng3ckMvdExKb2lvV1NSMWtieVFncE1QUUdSNjdneE5sVHh2M1la?=
 =?utf-8?B?OVRGWm9Od2ZmM2dDWERPV01BV3hndEp6a3NPazJpYnlnTm5rZWNTQitOVmMx?=
 =?utf-8?B?L204dSsvSHp0L3ZjdURHMDFHb1VKcjB6Y0k3Rit1cU1zTm1KejFxZ1dHMXFL?=
 =?utf-8?B?ZndJTW1DQUVCaDZORGlTNW9IMWdIV3paMGdWRXhHdkFsT2V4RURoZ09TSXd0?=
 =?utf-8?B?R2FHRlIrWmNOMXV1NTZ1VjVtRUdFNmdjdFNRWWgyS0NUS042WmxLS1NnM2Rm?=
 =?utf-8?B?U2hCVjE2Sm1kUzk4bEFkS2E4WDIzenY3OEkxUVBQRnZrVXkyQTVpNzZ1MUxP?=
 =?utf-8?B?VTBvRExTRlZuOXY3ZXZ5K0w2RW82c1d0RnN6RSsxeDZFeVZScTcrNHJhYStI?=
 =?utf-8?B?VzZwWC9YcWVqbWxuYktsY0k5RUNKVElBMDlSTXdmS0kwWFN4dTBQbThoN29H?=
 =?utf-8?B?REwvZEppeTZjdjdVSXQ3dUxDT1NNZ0lENmVVclFNblFWdDFMYkdNOHFkdnBE?=
 =?utf-8?B?Z2tVcFdndmxLbEV4Z0xMMHQ3NVlVUk9IazNWOEsxVlkxK09SVWhPbzZ6YmhL?=
 =?utf-8?B?c0V3R0t5Q2ZjT3BlYVZESmtwNmNvOEJPdVo3U1FlQWNRd3FQeE52TVhIUm1w?=
 =?utf-8?B?ZjhFQStUVDVjbFFwSUlLVkdaQ2JqYXF3Z2JWT2xiZTFYeWJ0dnVpNDV3Y0wz?=
 =?utf-8?B?eVZxOW9ldkk0NXhKcFpWay9mbVI5WVVlV2loNjBVM2syWUJJbHVycGxtdXB1?=
 =?utf-8?B?dUVWWjJRaDNpSkg0dWlDUzEvcmwvcWNlNTl2Rk9QVWdjY3V0Rk1Ha29FYjcv?=
 =?utf-8?B?V2NxeGxUek45YUZvelo5aldnUVRsZ1c2TkFvWGcydjhoZFhVUXpicUtoellD?=
 =?utf-8?B?YmxjcU5La1FxeUpnZWpscXNvMEdNRndFVmFMVzNoR0hIUThFcnFZeGJJalN6?=
 =?utf-8?B?SVZTT0hUbUdtR1o3Vklad3RKcTZhdzZnVytKdTlSSVpaNW1FeHdGUG55TEwy?=
 =?utf-8?B?ZjVPdG9uOWpQR3oyb2E4alNhaWtBUS9MWWY4YzJWY1hnV3orWjN1bGlQMnRz?=
 =?utf-8?B?NHZGZ1BWTlRrUVc0b0VYKzNhelRINll0OXVlajMzZDA5ci9OSVE1L1VVb0pu?=
 =?utf-8?B?QVA4M05yaDZqc3BWWENGSGZPVGhkTjVxMWduenkwVFNjcW9FbmxIa1VicnZW?=
 =?utf-8?Q?q1+hhTu+SZNFc3Q584MRjHYvvKHA3xmn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEJrQVVIbGRnUW1GM3dEWWlnZzd6SUZTT1RCbHB1VTh5TkxuVXl2b1FOUW1E?=
 =?utf-8?B?NXcxUmdoVGllbkRzdTQ3aklUU1FvZEM0NzRZS1pRc0ZoSFJDZHlLTEM3Y0N4?=
 =?utf-8?B?Y1QraDdNK0FKUkRvSlorbzlweGtjNUdGNW1PNVhYZHMzdTYyaFQyNHFsZUZv?=
 =?utf-8?B?OERIcDV0aVBtVG42RUtMQUhwMXpYdmxJNlBhVnJFNXM2dkxYWFF3dFVQRWs4?=
 =?utf-8?B?MUNJVkJvbWxmR0dIaGtCYzBNQkRaUWlxeGhQcXRqSWxGZmY0UnM2dWlRZ1d5?=
 =?utf-8?B?bCthUmVxRUdRK1dhQTNsbU1ISTk3Rm5SMWRNQ3NadkhPY2lzcTJIMkV5QlZ4?=
 =?utf-8?B?R3Ztbm9WNmZORUxVMmphVDMydEJjWlUrM2pRVENzWmNoNVg5SGdPVmFTUlQ0?=
 =?utf-8?B?aXluZ3MxUU5JMWw5NUZYMi9CdWs4V3JaZzYyZzJBRHJUeGd6YnI1QlowNjFL?=
 =?utf-8?B?L1V0eW9hbDRoa0tzRWZhcmFGODJiYUgvVjE4ejBTb1VVK0NSc0ErK3FIQnJK?=
 =?utf-8?B?RWxjV2ZtNjNJVjJ0RktsSkhvYUJ0Z1FkUkZaVGlIMzRJeFFkNUtlb0txRHNJ?=
 =?utf-8?B?a3RYNjZ6WFgxSlJnV1pad3htKytZdEZNd2JZek5zL08walJWeUVOL3gwME1X?=
 =?utf-8?B?bzZkSDE1dU9Oa003b3AvUjc2U25ON0U2Ti9PQTlQUzczRmpQZmpaQUw5Mm4z?=
 =?utf-8?B?ckkzMHVOam0vMHMvUWI1SXpBVm1IKytqNWpxY1liaG42OStMK3FaSEdkZ1B5?=
 =?utf-8?B?dWNWd1JGUFYrMzZyc0w0c2ZCQ29jblpYMm41Y3ZFZGJkU1Z1c1lRZVRuREVw?=
 =?utf-8?B?S1F1eURUVW9xODQva0NLOVVrekQzRk11NWkzNC81bkFJNlFLZ0hpdDVQZUF6?=
 =?utf-8?B?NTBtNGhkaXNEdXQ3cWNXYlFORksyaUtES0phSGUwbktuMHkxQ0hISEl3ODBZ?=
 =?utf-8?B?aTZVL0IxeS9MQmVSZ1VKWE9Bcmhjam9ka1MveFk2V2xYNk40U1JaMFVOM0lB?=
 =?utf-8?B?QkpGTzBnMkt5eG5qZGJpT1JodEFqTGZkck8ycGMyVDU3MDRqMzA1Qk9WUnQ1?=
 =?utf-8?B?SS81WGFqWStSVTNmSjd0K0NXS0ZHZEN2LzlzVVZKa1NyTjcxYitMSmtQQzBt?=
 =?utf-8?B?bWU3bjFocUdraURZRTc0bU1zSllFUkRUM1RNTHlRNmZDK0JSZ2lhSU1VOW1z?=
 =?utf-8?B?dE03ME1WTkRtU3JDaWhwMUZiZjl6WnppS2lxMWd2dmpBdVg5bTVhRUJ0eXg2?=
 =?utf-8?B?eGlZcDVFR3FHNUEwUUZkZGIzK1VHYVRCSU5rVUUzY0FhRGNkZWZ5TUt3clZs?=
 =?utf-8?B?dDBxeHBORDk1UHdlS0p2dDVZa0MvUTRSVk80ZnhZaW5FUEQ0TWxBWWdXd0VW?=
 =?utf-8?B?ZEpxZmt1LzJhVDliNU5ObloxYWFwZEpmYU01R2pOblhSblR6cGpOU0NGdlE5?=
 =?utf-8?B?SEJzRGNoTzU5MTdiY2k2eVN2a3ppQWJ4N1NKK3pIbW5UUW1HTFJCREJEYm95?=
 =?utf-8?B?SE5DcU5FK0pObitUWExTV0xVQngzNDZEd0kxYWlETVR4dUFCbjdxTmloaXll?=
 =?utf-8?B?RzVZc3AyamJYMEM3WUFZYmhOQm9EZm03WllZSG1mQm1wRGlrTkNKaU9uL2Rq?=
 =?utf-8?B?NE9maEVKcjVTRDlGdUdrY0daQ0hqdnBIekpSbnlwRlp6WkJSd0NxbUJDeXM4?=
 =?utf-8?B?SmV1WkQ4N014MVkxT3FZSktDYXo3US9jVDhIWmdxQ29yV2puWFdPQTJibFBY?=
 =?utf-8?B?b0VCYk01bmVPR216TjdpcEt5Zml5djBXcktGWVFwQVVvNWlUKzYreUdObnJZ?=
 =?utf-8?B?enJOQzJDV2Z1U2hzT3dSN1V3a1liVDJNbGpCU3RYNDZMOEViSDlvMitITjYw?=
 =?utf-8?B?ckJoVFVVbG5VWENVc0xyYk9GVUNKMXNpRVJldmxmUzJDTDZmMTFEOVRVMkgx?=
 =?utf-8?B?RmswUEVZN3Vwb3dHdXJBTEY3T2NqWVgybmVHVCt6ZWRzNkcxWEJmNHpDeldB?=
 =?utf-8?B?SlZmTWJmcXNyb1VwTUFtYWo3cmpSMFhmU2VGNmdMV01Ka0VzbmJMZ0t5VXpM?=
 =?utf-8?B?K1JPTlpQb3FjOUNaTFh1SjhhRW5NU0lINzBWdnc3T3JYelQwc3NUR1B2ekJ2?=
 =?utf-8?Q?AikGW1LL+WEFLU87PV6x/pDrx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c4f48-d78b-4eff-1843-08dd6b324661
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 00:16:22.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXFzZbv8pZo5K8CuLeiEsHK8/Og6ymnRDckkz+Qo72rEjvQGfJtBTHYaNMIFILwseaQ7ZApKdy+avw9WaJ4UQmXyeuImPma0vrPO0+7Sz6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBNZW5lZ2hpbmkg
PGptZW5lZ2hpQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDExLCAyMDI1IDY6
NTMgUE0NCj4gVG86IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPjsgTWFydGluIEsuIFBl
dGVyc2VuDQo+IDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT47IHBoZWlkb2xvZ2V0b25AcHJv
dG9ubWFpbC5jb207DQo+IGtlcm5lbEByb2Fka2lsLm5ldDsgbWFva2FtYW5AZ21haWwuY29tDQo+
IENjOiBTYWdhciBCaXJhZGFyIC0gQzM0MjQ5IDxTYWdhci5CaXJhZGFyQG1pY3JvY2hpcC5jb20+
OyBKYW1lcyBFLkouDQo+IEJvdHRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJz
aGlwLmNvbT47IGxpbnV4LQ0KPiBzY3NpQHZnZXIua2VybmVsLm9yZzsgdGhlbnpsQHJlZGhhdC5j
b207IG1wYXRhbGFuQHJlZGhhdC5jb207IFNjb3R0DQo+IEJlbmVzaCAtIEMzMzcwMyA8U2NvdHQu
QmVuZXNoQG1pY3JvY2hpcC5jb20+OyBEb24gQnJhY2UgLSBDMzM3MDYNCj4gPERvbi5CcmFjZUBt
aWNyb2NoaXAuY29tPjsgVG9tIFdoaXRlIC0gQzMzNTAzDQo+IDxUb20uV2hpdGVAbWljcm9jaGlw
LmNvbT47IEFiaGluYXYgS3VjaGliaG90bGEgLSBDNzAzMjINCj4gPEFiaGluYXYuS3VjaGliaG90
bGFAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gW3YyXWFhY3JhaWQ6IFJl
cGx5IHF1ZXVlIG1hcHBpbmcgdG8gQ1BVcyBiYXNlZCBvbiBJUlENCj4gYWZmaW5pdHkNCj4gDQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMy8xMC8yNSAx
Mjo0NCBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiA+IE9uIDIvMjQvMjUgMjI6MTUsIEpv
aG4gTWVuZWdoaW5pIHdyb3RlOg0KPiA+PiBPbiAyLzIwLzI1IDk6MzggUE0sIE1hcnRpbiBLLiBQ
ZXRlcnNlbiB3cm90ZToNCj4gPj4+IElmIGdvLWZhc3RlciBzdHJpcGVzIGFyZSBkZXNpcmVkIGlu
IHNwZWNpZmljIGNvbmZpZ3VyYXRpb25zLCB0aGVuIG1ha2UNCj4gPj4+IHRoZSBwZXJmb3JtYW5j
ZSBtb2RlIGFuIG9wdC1pbi4gQmFzZWQgb24geW91ciBiZW5jaG1hcmtzLCBob3dldmVyLA0KPiBJ
J20NCj4gPj4+IG5vdCBlbnRpcmVseSBjb252aW5jZWQgaXQncyB3b3J0aCBpdC4uLg0KPiA+Pg0K
PiA+PiBJIGFncmVlLiAgU28gaG93IGFib3V0IGlmIHdlIGNhbiBqdXN0IHRha2Ugb3V0IHRoZSBh
YWNfY3B1X29mZmxpbmVfZmVhdHVyZQ0KPiBtb2RwYXJhbS4uLj8NCj4gPj4NCj4gPj4gQWx0ZXJu
YXRpdmVseSB3ZSBjYW4gcmVwbGFjZSB0aGUgbW9kcGFyYW0gd2l0aCBhIGtDb25maWcgb3B0aW9u
LiBUaGUNCj4gZGVmYXVsdCBzZXR0aW5nIGZvciB0aGUgbmV3IEtjb25maWcNCj4gPj4gb3B0aW9u
IHdpbGwgYmUgb2ZmbGluZV9jcHVfc3VwcG9ydF9vbiBhbmQgcGVyZm9ybWFuY2VfbW9kZV9vZmYu
IFRoYXQNCj4gd2F5IHdlIGNhbiBzaGlwIGEgZGVmYXVsdCBrZXJuZWwgY29uZmlndXJhdGlvbiB0
aGF0DQo+ID4+IHByb3ZpZGVzIGEgd29ya2luZyBhYWNyYWlkIGRyaXZlciB3aGljaCBzYWZlbHkg
c3VwcG9ydHMgb2ZmLWxpbmluZw0KPiA+PiBDUFVTLiBJZiBwZW9wbGUgYXJlIHJlYWxseSB1bmhh
cHB5IHdpdGggdGhlIHBlcmZvcm1hbmNlLCBhbmQgdGhleQ0KPiA+PiBkb24ndCBjYXJlIGFib3V0
IG9mZmxpbmUgY3B1IHN1cHBvcnQsIHRoZXkgY2FuIHJlLWNvbmZpZyB0aGVpciBrZXJuZWwuDQo+
ID4+DQo+ID4+IFBlcnNvbmFsbHkgSSBwcmVmZXIgb3B0aW9uIDEsIGJ1dCB3ZSB0aGUgdGhvdWdo
dHMgb2YgdGhlIHVwc3RyZWFtIHVzZXJzLg0KPiA+Pg0KPiA+PiBJJ3ZlIGFkZGVkIHRoZSBvcmln
aW5hbCBhdXRob3JzIG9mIEJ1Z3ppbGxhIDIxNzU5OVsxXSB0byB0aGUgY2MgbGlzdCB0bw0KPiA+
PiBnZXQgdGhlaXIgYXR0ZW50aW9uIGFuZCByZXZpZXcuDQo+ID4+DQpIaXN0b3JpY2FsbHksIHRo
ZSBhYWNyYWlkIGRyaXZlciByZWxpZWQgb24gdGhlIGNhbl9xdWV1ZSBtZW1iZXIgb2YgdGhlIHNj
c2lfaG9zdCBzdHJ1Y3R1cmUgdG8gZGV0ZXJtaW5lIHRoZSB0b3RhbCBudW1iZXIgb2YgY21kcyB0
aGUgRlcgY291bGQgbWFuYWdlLiANCldpdGggRlcgc3VwcG9ydGluZyAzMiBxdWV1ZXMsIGVhY2gg
Y2FwYWJsZSBvZiBoYW5kbGluZyAzMiBjb21tYW5kcywgdGhlIHRvdGFsIGNvbW1hbmQgY2FwYWNp
dHkgd2FzIGVmZmVjdGl2ZWx5IDEwMjQgKDMyKjMyKS4NCg0KVGhpcyBsaW1pdCBpcyBhIEhXL0ZX
IGxpbWl0YXRpb24gc3BlY2lmaWMgdG8gdGhlIGFhY3JhaWQgY29udHJvbGxlciwgd2hpY2ggcmVz
dHJpY3RzIGVhY2ggcXVldWUgdG8gYSBtYXhpbXVtIG9mIDMyIGNtZHMuDQoNClN0YXJ0aW5nIGZy
b20ga2VybmVsIHZlcnNpb24gNi40LCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBtYXAgcXVldWUg
bWVjaGFuaXNtIHRyZWF0ZWQgYWxsIHF1ZXVlcyBhcyBoYXZpbmcgdGhlIHNhbWUgY2FwYWNpdHkg
YXMgY2FuX3F1ZXVlLCBpbmFkdmVydGVudGx5IGV4Y2VlZGluZyB0aGUgMTAyNCBjb21tYW5kIGxp
bWl0LiANCkNvbnNlcXVlbnRseSwgcmVseWluZyBzb2xlbHkgb24gc2NzaV9ob3N0LT5jYW5fcXVl
dWUgYmVjYW1lIHVuZmVhc2libGUuIA0KVG8gYWRkcmVzcyB0aGlzLCB0aGUgcGF0Y2ggaW50cm9k
dWNlcyBsb2dpYyB0byBkeW5hbWljYWxseSBhc3NpZ24gY2FuX3F1ZXVlIGJhc2VkIG9uIHRoZSBu
dW1iZXIgb2YgYXZhaWxhYmxlIE1TSVggdmVjdG9ycyAoaS5lLiwgdGhlIG51bWJlciBvZiBxdWV1
ZXMpIG11bHRpcGxpZWQgYnkgMzIuIA0KVGhpcyBhcHByb2FjaCBlbnN1cmVzIGNhbl9xdWV1ZSBj
b3JyZWN0bHkgcmVmbGVjdHMgdGhlIGhhcmR3YXJl4oCZcyB0b3RhbCBjb21tYW5kIGNhcGFjaXR5
LCBwcmV2ZW50aW5nIGlzc3VlcyBjYXVzZWQgYnkgZXhjZWVkaW5nIHRoZSAxMDI0IGxpbWl0Lg0K
QnV0IHRoaXMgY2hhbmdlIGNhdXNlcyBhIHBlcmZvcm1hbmNlIGRyb3AgaW4gc29tZSBjb25maWd1
cmF0aW9ucy4gDQpJdCdzIGltcG9ydGFudCB0byBtZW50aW9uIHRoYXQgdGhlIHBhdGNoIGRvZXMg
bm90IG1vZGlmeSB0aGUgcXVldWUgZGVwdGggaXRzZWxmIGJ1dCByYXRoZXIgYWxpZ25zIGNhbl9x
dWV1ZSB3aXRoIHRoZSBoYXJkd2FyZSdzIGZpeGVkIGxpbWl0Lg0KDQpGb3IgY29tcGFyaXNvbiwg
Y29tcGV0aXRvciBjb250cm9sbGVycyB0eXBpY2FsbHkgc3VwcG9ydCB1cCB0byAyNTYgY29tbWFu
ZHMgcGVyIHF1ZXVlIHdpdGggYW4gb3ZlcmFsbCBjYXBhY2l0eSBvZiA4MTkyICgyNTYqMzIpIGNt
ZHMgb3IgbW9yZS4gDQpXaGlsZSB0aGUgYWFjcmFpZCBjb250cm9sbGVyJ3MgZGVzaWduIGhhcyBz
dHJpY3RlciBoYXJkd2FyZSBjb25zdHJhaW50cywgdGhlIHBhdGNoIGVuc3VyZXMgaXQgZnVuY3Rp
b25zIG9wdGltYWxseSB3aXRoaW4gdGhlc2UgbGltaXRzIGFuZCBoZW5jZSB0aGUgcmVkdWNlZCBw
ZXJmb3JtYW5jZS4gDQoNCkNvbmNsdXNpb24gOiANCkEgZ2VuZXJpYyBmaXggaXMgbm90IHByYWN0
aWNhbCAtIGdpdmVuIHRoZSBwZXJmb3JtYW5jZSBkcm9wLg0KQXMgSm9obiBNZW5lZ2hpbmkgc3Vn
Z2VzdGVkLCBpbnN0ZWFkIG9mIGEgbW9kcGFyYW0gd2UgY291bGQgZW1iZWQgdGhlIHNhbWUgZml4
IGluc2lkZSBhIGtjb25maWcgb3B0aW9uLg0KDQpTaG91bGQgSSBzdWJtaXQgYSBuZXcgdmVyc2lv
biB3aXRoIHRoZSBrY29uZmlnIG9wdGlvbj8NCg0KVGhhbmtzDQo+ID4gRG8gd2UgaGF2ZSBhbiBp
ZGVhIHdoYXQgdGhlc2UgJ3NwZWNpZmljIHVzZS1jYXNlcycgYXJlPw0KPiANCj4gWWVzLiBUaGUg
dXNlIGNhc2UgaXMgb2ZmbGluZSBDUFUgc3VwcG9ydC4gIFdlIGhhdmUgY3VzdG9tZXJzIHdobyBh
cmUgdXNpbmcNCj4gdGhlIGFhY3JhaWQgZHJpdmVyIHRvIHN1cHBvcnQgdGhlaXIgbWFpbg0KPiBz
dG9yYWdlLiBUaGV5IGhhdmUgaHVuZHJlZHMgb2Ygc3lzdGVtIGRlcGxveWVkIGxpa2UgdGhpcyBh
bmQgdGhleSBzdGFydGVkDQo+IHVzaW5nIHRoZSBvZmZsaW5lIENQVSBmdW5jdGlvbiBhbmQgZm91
bmQNCj4gdGhlIHByb2JsZW0gaW4gQnVnemlsbGEgMjE3NTk5LiBUaGUgY3VzdG9tZXIgaXMgY3Vy
cmVudGx5IHVzaW5nIHRoaXMgcGF0Y2gNCj4gKG1pbnVzIHRoZSBtb2RwYXJhbSkgYW5kIGl0IHNv
bHZlcyB0aGVyZQ0KPiBwcm9ibGVtLg0KPiANCj4gPiBBbmQgaG93IG11Y2ggcGVyZm9ybWFuY2Ug
aW1wYWN0IHdlIGhhdmU/DQo+IA0KPiBUaGlzIHdhcyBkaXNjdXNzZWQgZWFybGllciBpbiB0aGlz
IHRocmVhZC4NCj4gDQo+IFdpdGggYWFjX2NwdV9vZmZsaW5lX2ZlYXR1cmU9MSBmaW8gc3RhdGlz
dGljcyBzaG93Og0KPiANCj4gIyBmaW8gLWZpbGVuYW1lPS9ob21lL3Rlc3QxRy5pbWcgLWlvZGVw
dGg9NjQgLXRocmVhZCAtcnc9cmFuZHdyaXRlIC0NCj4gaW9lbmdpbmU9bGliYWlvIC1icz00SyAt
ZGlyZWN0PTEgLXJ1bnRpbWU9MzAwIC10aW1lX2Jhc2VkIC1zaXplPTFHIC0NCj4gZ3JvdXBfcmVw
b3J0aW5nIC1uYW1lPW15dGVzdCAtbnVtam9icz00DQo+IA0KPiAgICBXUklURTogYnc9NDk1TWlC
L3MgKDUxOU1CL3MpLCA0OTVNaUIvcy00OTVNaUIvcyAoNTE5TUIvcy0NCj4gNTE5TUIvcyksIGlv
PTE0NUdpQiAoMTU2R0IpLCBydW49MzAwMDAxLTMwMDAwMW1zZWMNCj4gDQo+IFdpdGggYWFjX2Nw
dV9vZmZsaW5lX2ZlYXR1cmU9MCBmaW8gc3RhdGlzdGljcyBzaG93Og0KPiANCj4gIyBmaW8gLWZp
bGVuYW1lPS9ob21lL3Rlc3QxRy5pbWcgLWlvZGVwdGg9NjQgLXRocmVhZCAtcnc9cmFuZHdyaXRl
IC0NCj4gaW9lbmdpbmU9bGliYWlvIC1icz00SyAtZGlyZWN0PTEgLXJ1bnRpbWU9MzAwIC10aW1l
X2Jhc2VkIC1zaXplPTFHIC0NCj4gZ3JvdXBfcmVwb3J0aW5nIC1uYW1lPW15dGVzdCAtbnVtam9i
cz00DQo+IA0KPiAgICBXUklURTogYnc9NTA1TWlCL3MgKDUyOU1CL3MpLCA1MDVNaUIvcy01MDVN
aUIvcyAoNTI5TUIvcy0NCj4gNTI5TUIvcyksIGlvPTE0OEdpQiAoMTU5R0IpLCBydW49MzAwMDAx
LTMwMDAwMW1zZWMNCj4gDQo+IE9mIGNvdXJzZSB0aGlzIGlzIHdpdGggYSB2ZXJ5IHByaW1pdGl2
ZSB0ZXN0LiAgQXMgYWx3YXlzIHlvdXIgcGVyZm9ybWFuY2UgcmVzdWx0cw0KPiB3aWxsIHZhcnkg
YmFzZWQgdXBvbiB3b3JrbG9hZCwgc3lzdGVtIHNpemUsIGV0Yy4uDQo+IA0KPiBPdXIgY3VzdG9t
ZXIgcmVwb3J0ZWQgdGhlIGZvbGxvd2luZyByZXN1bHRzIHdpdGggdGhpcyBwYXRjaCB3aGVuDQo+
IGFhY19jcHVfb2ZmbGluZV9mZWF0dXJlPTEuICBUaGlzIHdhcyB3aXRoIHRoZWlyIHNwZWNpZmlj
IHdvcmtsb2FkLg0KPiANCj4gVGhlIHRlc3QgY29uZmlndXJhdGlvbiBpczogM3ggRGlzayBSYWlk
IDU6DQo+IA0KPiBDaHVuay9TdHJpcGUgU2l6ZToNCj4gU3RyaXBlLXVuaXQgc2l6ZSA6IDI1NiBL
Qg0KPiBGdWxsIFN0cmlwZSBTaXplIDogNTEyIEtCDQo+IA0KPiBEZXNjcmlwdGlvbiAgICAgVW5w
YXRjaGVkICAgICAgIFBhdGNoZWQNCj4gUmFuZG9tIHJlYWRzICAgIDEwM0sgICAgICAgICAgICAx
MTRLDQo+IGNsYXQgYXZnICAgICAgICAyNTAwICAgICAgICAgICAgMjEwMA0KPiANCj4gRGVzY3Jp
cHRpb24gICAgIFVucGF0Y2hlZCAgICAgICBQYXRjaGVkDQo+IFJhbmRvbSB3cml0ZXMgICAxNy43
ICAgICAgICAgICAgMThLDQo+IGNsYXQgYXZnICAgICAgICAxNDQwMCAgICAgICAgICAgMTMzMDAN
Cj4gDQo+IGZpbyB3YXMgdXNlZCB0byBwZXJmb3JtIDRrIHJhbmRvbSBpbyB3aXRoIDE2IGpvYnMg
YW5kIGlvZGVwdGggb2YgMTYgd2hpY2gNCj4gbWltaWNzIHRoZQ0KPiBjdXN0b21lcidzIHdvcmtp
bmcgZW52aXJvbm1lbnQvYXBwbGljYXRpb24gaW8uDQo+IA0KPiA+IEkgY291bGQgaW1hZ2luZSBh
IHNpbmdsZS10aHJlYWRlZCB3b3JrbG9hZCBkcml2aW5nIGp1c3Qgb25lIGJsay1tcSBxdWV1ZQ0K
PiB3b3VsZCBiZW5lZml0IGZyb20gc3ByZWFkaW5nIG91dCBvbnRvIHNldmVyYWwgaW50ZXJydXB0
cy4NCj4gDQo+IFllcywgSSB0aGluayB0aGUgcGVyZm9ybWFuY2UgcmVzdWx0cyB3aXRoIHRoaXMg
cGF0Y2ggY2FuIHZhcnkgZ3JlYXRseS4NCj4gDQo+ID4gQnV0IHRoZW4sIHRoaXMgd291bGQgYmUg
dHJ1ZSBmb3IgbW9zdCBvZiB0aGUgbXVsdGlxdWV1ZSBkcml2ZXJzOyBhbmQgaW5kZWVkDQo+IHF1
aXRlIHNvbWUgZHJpdmVycw0KPiA+IChlZyBtZWdhcmFpZF9zYXMgJiBtcHQzc2FzICdzbXBfYWZm
aW5pdHlfZW5hYmxlJykgaGF2ZSB0aGUgdmVyeSBzYW1lDQo+IG1vZHVsZSBvcHRpb24uDQo+IE9L
LCBmaW5lLi4uIGJ1dCB1bnRpbCB0aGF0IG9wdGlvbiBpcyBhdmFpbGJsZS4uLiBJIHRoaW5rIHdl
IG5lZWQgdG8gZG8gc29tZXRoaW5nDQo+IHdpdGggdGhpcyBkcml2ZXIuDQo+IA0KPiA+IFdvdWxk
bid0IGl0IGJlIGFuIGlkZWEgdG8gY2hlY2sgaWYgd2UgY2FuIG1ha2UgdGhpcyBhIGdlbmVyaWMg
LyBibGstbXENCj4gPiBxdWV1ZSBvcHRpb24gaW5zdGVhZCBvZiBoYXZpbmcgZWFjaCBkcml2ZXIg
dG8gaW1wbGVtZW50IHRoZSBzYW1lDQo+IGZ1bmN0aW9uYWxpdHkgb24gaXQncyBvd24/DQo+IA0K
PiA+IFRvcGljIGZvciBMU0Y/DQo+IA0KPiBJJ2QgYmUgaGFwcHkgdG8gdGFsayBhYm91dCB0aGlz
IGF0IExTRi4NCj4gDQo+ID4gQ2hlZXJzLA0KPiA+DQo+ID4gSGFubmVzDQoNCg==

