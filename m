Return-Path: <linux-scsi+bounces-2046-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74715843481
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 04:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9B1F26ABB
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84517BD3;
	Wed, 31 Jan 2024 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ES1quwDm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QS4jI1In"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FA16436
	for <linux-scsi@vger.kernel.org>; Wed, 31 Jan 2024 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672154; cv=fail; b=nYAGkx/lvnGITYE6AwEARX+XjYzpL8w6957TN1PFJtfPHr5ijMaL98nUG5G52Y1O1oR3T9GuMddqf8lwl3KW1wYU1VEARUhjM7i/uU+12ir7KJzekSukw7rscv1/jtlu6meLKE7lyqcDzS/KQsXfX0ZW1weevt7zoTbVpCXdwKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672154; c=relaxed/simple;
	bh=+QF5fkN+rAx6IP/cKuRW2fOP5RWVA1Z3sV7dlySSjTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWOI5MiiaZZdLJkWDuS1OtSQ7u/MLlhmgBJyW/f3YeFcDkyFzq263CPUPSXoRBPgRTwPbLRrqhQk5N8mDPRD2azwcBiakixwnR/KWi2alpmkqc+B5yy1PoAdleco6QSrHoK1tgoRPiwYmuw10flkIE0E155T8rI76KZ1LumT3Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ES1quwDm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QS4jI1In; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UKx2pC021878;
	Wed, 31 Jan 2024 03:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mrgR027yb5c/swaICxu0QACd+4zTsKoyRoOowBkXM+Y=;
 b=ES1quwDm4hDo1aqAuuSbQzwU51Khr0Tn1v4Et8WDD+XkxkxK/7/wIr8C9GXljX0jhMWI
 FfUBuQyFxfquJDZV6zCSUOg0ffgW6PIC3DuDn17r2bpk1irpHN86KnAw3jk/SBb0Mfou
 LnkzBsHAjlOjTkIeSadjfbLpLyOxTeJ77riqRZTZvv/kLNfj2a1LOfUO1X2xDOSru3zY
 6oRXJyhbfzlzX+R0ReSfmMb6h7dAPkav4uoMYGtWQ7YdN1JcUyaEe7fcvhOKc31N3Dka
 L25mHmJmAcl/so0I7rCJwJDhEOiLDhuEIWpxgOcGlD06gqGwyeEFcqDVc8A0Jxu7XPZu 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm40qqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 03:35:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V1DRvT014596;
	Wed, 31 Jan 2024 03:35:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ef3f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 03:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeIK7UhVtJD5XlPGPBLk0A48fjEtLhFMLnqXX6z6odHi7m5Rf1SB1LWuFjC6hkG8o8sKYVLBWZ7/9TlC2Gcoxp4MxBVc/NvuM21bvupo7roBEdzOnhieFY6DcyIUNWJSZoBKKRbcAMYfiIrcqCF/SbCaPoNZQBBpUFM7pN6VcuXv8oVJFxqCietD+w6Kgb5N8B+zEwJZiSwP2NIRWvFa7KbWRe4xX5IHwkPkqHNitjVAUkZGcKp6tL1yWlzZOGobO9jC5asE+vCQsgAdWnkRwSgRFtrdMzGqX0Ol3d4ZYS8NpP6CyDhr5wUPIwfUctueTKHmVOwDWbiHNGHISrT1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrgR027yb5c/swaICxu0QACd+4zTsKoyRoOowBkXM+Y=;
 b=bAEmx6PLBzUfJiB1b0CoT0BUPl4vS2GMO2W+RBIwa6BSxXWUQP5oGr+u1zSaxzd1JCT2LxjnPss9jAK6xprhw1t6UKUa4/CROHxY6ACzhFceTh+2+g7Oi6ItpCkvIgnns2ezBlcpkZVW3AypYjteRVSznpsyS/d76P5AwCph3INEKG9lzTnu8ZRmy2oJ7Bhu7zrdkjWFstdJG7ZAmD465osQwD0bLKsJo9nUaHe78OLhuUtnOrMkPHq0r7MgzTfxA1C16UAkuQGYVavdZDkIn37VQaLeyVOHBjdJF95dUqkLfjIcYTZVTd2JrCm1rv7USH3XFvuUelrVPrvRPy2WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrgR027yb5c/swaICxu0QACd+4zTsKoyRoOowBkXM+Y=;
 b=QS4jI1Inna9IoiMPywTPEeODl4wTlY6rT9qvEXQl12pZaCiZReskFEKu8QbLXUaesNThqhn2pTyv7HaNhcitDlnzEsWryaER7Y9ewlJiHARmaBVKSUB/arhcQ1HpEM9Va8NbBxuvIgzUAWiKOa0AB0Y0plBiEIlfFmsKV+niddI=
Received: from CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12)
 by PH0PR10MB4487.namprd10.prod.outlook.com (2603:10b6:510:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 03:35:38 +0000
Received: from CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::284b:c3bb:c95:de8b]) by CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::284b:c3bb:c95:de8b%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 03:35:37 +0000
Message-ID: <a0674221-3587-4802-a3d2-c8d54f0c4eb2@oracle.com>
Date: Tue, 30 Jan 2024 19:35:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] lpfc: Change lpfc_vport fc_flag member into a
 bitmask
Content-Language: en-US
To: Justin Tee <justintee8345@gmail.com>, linux-scsi@vger.kernel.org
Cc: jsmart2021@gmail.com, justin.tee@broadcom.com
References: <20240131003549.147784-1-justintee8345@gmail.com>
 <20240131003549.147784-15-justintee8345@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle America Inc
In-Reply-To: <20240131003549.147784-15-justintee8345@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To CH3PR10MB7959.namprd10.prod.outlook.com
 (2603:10b6:610:1c1::12)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7959:EE_|PH0PR10MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3e8260-c504-4863-f1f9-08dc220db0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9fA1gvM3pAajn1rfwjGymW2xIULbT7Oqbh/ZaZnw0OSyPFT8oxI2KjjLklmuD2xxvjJD6HqMwxH4M0qLvJMCIMdeXdJorabrKm22H0B7VBn7l03z/vQKU002oIvXvTBXjtfIQ5rFv47JLwjupwoDCn3/TohBVIxDlwSKQH1SHP1pIrzWLEAatiHeAgMtjbYSKXMcwhOwmC2xFvx+/cHCFuMl9R/7E6Je7y61sDd5rSImtinjcC4Oos8bxn9YNcrcuUUvy99x+cJSfpETMFAZaZnIalKz7RYyHGVmiKSP9fzVPXQH8iYUTmupuNxEdh9LRgYUETTiLU6Q4VgTV5RRUvwr17PLKtb8IYsfQZMw7ZvgWg3WJMLxMFD3BuSBLF5I731sUkt5+1M441aS4Feia3KWquUxPRT5KjGggCprljQTEBQUeBCR4nFSjApHeNXoBf26ieMAMU6RXphs0lLj5RDlKc5YbZ0RWU8EDO4p34Gs5am6aZYw6bu3VYW94oEw8hIh3rYCp86r0PtvzhVi7L2vtBRIOOCBs/HQP6X2nht4Gt6Y1FUp986C29k7vg+n9BLvCM6+TxE2pXVqYjBbXReRmGYTb9OfhhH06nHi+9ipD1xciRe6aMgHhntR9zhbX1OVdkAKxnX5qlCwiG0ztOuTQbgSDPNba3ToFS5vivDpMPE6yhsTkOmqwYyVt9lr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7959.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(44832011)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(36756003)(4326008)(6512007)(86362001)(31696002)(5660300002)(38100700002)(30864003)(31686004)(83380400001)(66574015)(26005)(2616005)(6486002)(6506007)(36916002)(41300700001)(478600001)(53546011)(43740500002)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXNKU3NWenA4WGNOYVFvNzlaMXVTZkN3aGVQV1VSV0Z1SDdHdUVqcGtNM1B1?=
 =?utf-8?B?aWh2Q1pHK2NOZXJ1bXpacVpNMVYrNnQ1bU9JY0VnaUVBUHhrbFJLSUl6NVJM?=
 =?utf-8?B?aGlObnRMbVlCUk1EQmpCMDBHTGQ5OWR4VWQvMUl1c0hDcXFJQ1hXNDZ6RUxw?=
 =?utf-8?B?Q0pUMUwzampuMGh1MzliZXkwVEF4a0J6UUpEbjFNQmtVaFpOSjNER2V1Undj?=
 =?utf-8?B?enhUNDFhZ0JSaHVqeTVYTlFNeGFoQS9wcTBEY0lQRGdXVXkvanhYVXJrV1Ux?=
 =?utf-8?B?bmgvMkRmR0toSTlqYU9EWERYcmhOMy8xSjBYZ2NkWVIyd2M0YUcrNEtCaGFM?=
 =?utf-8?B?alV6WWwza2pycHMwMW9UdlpPYW94Zk9zZzNnRzFMTDVSQWFaM2I1UDBwU0NJ?=
 =?utf-8?B?amR2N2tydDlsc1ZQRVI4ZzJQZlBJK0FoRjlTbVVxbDZ5cGk4V0RHMWFlZnlO?=
 =?utf-8?B?QlVoU1hoRmRERlB5YTlXWjNsZjEyL1Z1WXhQdmNhNlNQNW9sWmQvR3NFUnVE?=
 =?utf-8?B?bm9Jd1J5R3EwWVRNNm90djZRTXJGajBnb1d6bWx5cVNuTW1qV0JRSXBRMUhl?=
 =?utf-8?B?SWF0eHRQZDVXL1BBWHVvVHU4Tk9SSFpWRkpZYlMxSnpWVm92ZUtkTExSQVFD?=
 =?utf-8?B?U0wwUURMdXRyT2YxYjRhVm5Oa2ExbFh6Ti9JaHlpTVRIYjJpV3Y5TUhqS3N3?=
 =?utf-8?B?dVVpZXV6M1RVQjNUZ3UyOEJQTWx3OEdFTW9MdjdrRnNUWHJ5RlJJdzV3aENE?=
 =?utf-8?B?T1NIdFdZRGFOUW9ZL05lZG5YTEludnlpT0VtdW9tMkk2RlRGbEJ1OVltblhU?=
 =?utf-8?B?dSt5UlYzNmI1K0pSdExua20vdHhnS0VhUnREVGlwZzRCZmFXeHNJdktjeHlR?=
 =?utf-8?B?bk5Lelh1bzhJazJOSnlUUnJVdHJYd1BYMWJwSGpkWG9TZnJ5VXg5cUVYMncw?=
 =?utf-8?B?UHFyMXBCNmV6V0NpWnpJYlhKZG9ZV21GaG85SDhXOTBvdFpoQ0p5dUNQSjll?=
 =?utf-8?B?QllYeTVOSStSSDZvaUJnOXJGa3ZwRHNXMUhnSkovRjJML1doMnFGenJkeTlQ?=
 =?utf-8?B?RnFYYnJTK0podXZvVld1dUN2elFUd1lPUlpJeHA5elVPNUNHYTJ5bEhJNENn?=
 =?utf-8?B?NEY5VzZIVGhVM3J6ZGVDemlnVlNNYmlwWHc0eU1XWmRrc3hYdlB5WCtsb1Jm?=
 =?utf-8?B?R3dTOC9uSzVIUG1mM2pIR3paVHZJUU9oTFV1WDZFWVMvMzNtYmJ2Ulh5aVNB?=
 =?utf-8?B?aDdiU2hJR0pIejB0NlZNWHRmMFZneTFzMTd4WkxyUzNldnBLNzJlb2hZd1VT?=
 =?utf-8?B?UkFGOGk3KzNUTWMzUitFeldEQWFuQlBESEVTeUxpTkN0MjVPVTFxcTVvem02?=
 =?utf-8?B?cm1CVmFmWkVSU1krRm55cXpUWXBRdGVhZHZxRnZBY0c2ZGZlWWN5cXd5Yi9I?=
 =?utf-8?B?SjRLSm5GZUFnNkhZdWlBRjcvMVZaVXVITHpUbVVSMzFrTDZ4Yitoa05wNGho?=
 =?utf-8?B?aklRMjNTd09wQzEycFhVT2R1TktvUTJ1bWFUeklQN3ZvQi9zZC8wcHRmNnUr?=
 =?utf-8?B?bUJyT2VNL2tDSnUwb1BuUFhMN2poMlZIWFRld1NDS2dPbnR6cndUVmF2UzBu?=
 =?utf-8?B?V3JHL2lqQ21pU1gra3FMZWYxSlprZi8wSDdQdm1vWFNnMlN1ekhFclBFMGdi?=
 =?utf-8?B?bHE3VWtzZVp2K1ZCR3poNE5FZjRCMDRTWE1hVThsL0EvSWNXWUZ6VUVhNkdy?=
 =?utf-8?B?SStPUE85WXZhR2xBSWM0eUZ6bjNSS0FUODJWajlsWFlYSkxKYzk5MGRsNmZT?=
 =?utf-8?B?TkJkT0g4WGFuMXd0RW53TnJ3cnRUVDNlbnllU3JCd29qZFhUSEhaenFqWHd6?=
 =?utf-8?B?Q1BteXBIUUphZzYvYnVDb2ZkbTRWUFhtcUM3dmgwU3lKZlFoTFp1ZW1hZnZM?=
 =?utf-8?B?cjViTnlRVWkvQzNsMk9UY1BoUHpCdjNGY3RXZ2craUhncjNoL0xOUTZReHE0?=
 =?utf-8?B?WWxjaXdkSE4rTG4yWUFzV2k1ZnAzQUloL1UrRE8rWmk0MFR6emh6RmNLVUFi?=
 =?utf-8?B?emNjYjYxelE5VkhVNE8ySFhWa2VMN2VIcU1TejN2UmN1d0JsWW9wdkVjS2pr?=
 =?utf-8?B?dTIwN0M1UE5mWlNEK1gvMmVNMkhUakxwbW1OQzlKQy8wcDMvRzgxNDRQTlhM?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sk3Ne/XivxOYXul31OA0x9PJ0O2oJRNLjNKK7FO1hxUJA9vDKb5hi6umGESstp9VlJGqH9QUacL9zTjVpWZKlnI9qqnU+kMjEfwlrnVtmykqUd/O/YwB8GxXuQ0wpF7ZJcOS93VQSYHMQDAOFdSbWiH6CqgdcKaB70J9qiTqSi+62smCQjp53yilEZsyyU2ezXcUokQYghvftt02Ag8BZ9AvleWFmu4vtam58citLjun8WY7iiRvXeC5RNpY/1SIH24H5iDE9Hi6rKVE0xzGiJs84U57pJh2AWmsWNlZprUjwQQRBvCMTnfeJFjs1w8Fvn46VSZ1zQImgCUm/7QCzOrmKtg5Y988g3jwjYhn3rRnOmMKOQwd/NKehnh2OkroW+KnlzssIAlOSI5hI9siNArO5/r3bacaoJn98dFoohpKVXq3WRjb2mdOik6l2YfcOMh1B3h9Dlfoe+4S3VygyamE2cBVVkPwSz+Qf8JiRPYDPXFxj3J9oS3Jnyex2Z9w7oXA8TetbWwebYjSNhQb8ahKc68QO/RzX5/RpaBgV6h5ezH3Rkb7JbuEpAdYzggNVI6Zq4O+zXpOyh60ZJZPafNzaoX0Gpm6SA95m1ctY/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3e8260-c504-4863-f1f9-08dc220db0c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7959.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:35:37.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO1VLWtTMqIITo+dAXHBnKYG4s3an1nofesAimMfckjX+WoeKZAfuNeqygp4SKZpWLFsfa0fv6HpO0WONCqTZ/PzG2Y1ATck1s2UpjuMzmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310027
X-Proofpoint-GUID: qGMNxhswDyRmOqYxrPc0oMuMvNEPvbSc
X-Proofpoint-ORIG-GUID: qGMNxhswDyRmOqYxrPc0oMuMvNEPvbSc



On 1/30/24 16:35, Justin Tee wrote:
> In attempt to reduce the amount of unnecessary shost_lock acquisitions in
> the lpfc driver, change fc_flag into an unsigned long bitmask and use
> clear_bit/test_bit bitwise atomic APIs instead of reliance on shost_lock
> for synchronization.
> 
> Signed-off-by: Justin Tee <justin.tee@broadcom.com>
> ---
>   drivers/scsi/lpfc/lpfc.h           |  59 ++---
>   drivers/scsi/lpfc/lpfc_attr.c      |  51 ++--
>   drivers/scsi/lpfc/lpfc_bsg.c       |   6 +-
>   drivers/scsi/lpfc/lpfc_ct.c        | 132 +++++------
>   drivers/scsi/lpfc/lpfc_els.c       | 360 +++++++++++------------------
>   drivers/scsi/lpfc/lpfc_hbadisc.c   | 218 +++++++----------
>   drivers/scsi/lpfc/lpfc_init.c      |  53 ++---
>   drivers/scsi/lpfc/lpfc_mbox.c      |   8 +-
>   drivers/scsi/lpfc/lpfc_nportdisc.c |  68 +++---
>   drivers/scsi/lpfc/lpfc_sli.c       |  14 +-
>   drivers/scsi/lpfc/lpfc_vport.c     |  46 ++--
>   11 files changed, 425 insertions(+), 590 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index da9f87f89941..18c0adceaa6f 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -535,6 +535,36 @@ struct lpfc_cgn_acqe_stat {
>   	atomic64_t warn;
>   };
>   
> +enum lpfc_fc_flag {
> +	/* Several of these flags are HBA centric and should be moved to
> +	 * phba->link_flag (e.g. FC_PTP, FC_PUBLIC_LOOP)
> +	 */
> +	FC_PT2PT,			/* pt2pt with no fabric */
> +	FC_PT2PT_PLOGI,			/* pt2pt initiate PLOGI */
> +	FC_DISC_TMO,			/* Discovery timer running */
> +	FC_PUBLIC_LOOP,			/* Public loop */
> +	FC_LBIT,			/* LOGIN bit in loopinit set */
> +	FC_RSCN_MODE,			/* RSCN cmd rcv'ed */
> +	FC_NLP_MORE,			/* More node to process in node tbl */
> +	FC_OFFLINE_MODE,		/* Interface is offline for diag */
> +	FC_FABRIC,			/* We are fabric attached */
> +	FC_VPORT_LOGO_RCVD,		/* LOGO received on vport */
> +	FC_RSCN_DISCOVERY,		/* Auth all devices after RSCN */
> +	FC_LOGO_RCVD_DID_CHNG,		/* FDISC on phys port detect DID chng */
> +	FC_PT2PT_NO_NVME,		/* Don't send NVME PRLI */
> +	FC_SCSI_SCAN_TMO,		/* scsi scan timer running */
> +	FC_ABORT_DISCOVERY,		/* we want to abort discovery */
> +	FC_NDISC_ACTIVE,		/* NPort discovery active */
> +	FC_BYPASSED_MODE,		/* NPort is in bypassed mode */
> +	FC_VPORT_NEEDS_REG_VPI,		/* Needs to have its vpi registered */
> +	FC_RSCN_DEFERRED,		/* A deferred RSCN being processed */
> +	FC_VPORT_NEEDS_INIT_VPI,	/* Need to INIT_VPI before FDISC */
> +	FC_VPORT_CVL_RCVD,		/* VLink failed due to CVL */
> +	FC_VFI_REGISTERED,		/* VFI is registered */
> +	FC_FDISC_COMPLETED,		/* FDISC completed */
> +	FC_DISC_DELAYED,		/* Delay NPort discovery */
> +};
> +
>   struct lpfc_vport {
>   	struct lpfc_hba *phba;
>   	struct list_head listentry;
> @@ -549,34 +579,7 @@ struct lpfc_vport {
>   	uint8_t vpi_state;
>   #define LPFC_VPI_REGISTERED	0x1
>   
> -	uint32_t fc_flag;	/* FC flags */
> -/* Several of these flags are HBA centric and should be moved to
> - * phba->link_flag (e.g. FC_PTP, FC_PUBLIC_LOOP)
> - */
> -#define FC_PT2PT                0x1	 /* pt2pt with no fabric */
> -#define FC_PT2PT_PLOGI          0x2	 /* pt2pt initiate PLOGI */
> -#define FC_DISC_TMO             0x4	 /* Discovery timer running */
> -#define FC_PUBLIC_LOOP          0x8	 /* Public loop */
> -#define FC_LBIT                 0x10	 /* LOGIN bit in loopinit set */
> -#define FC_RSCN_MODE            0x20	 /* RSCN cmd rcv'ed */
> -#define FC_NLP_MORE             0x40	 /* More node to process in node tbl */
> -#define FC_OFFLINE_MODE         0x80	 /* Interface is offline for diag */
> -#define FC_FABRIC               0x100	 /* We are fabric attached */
> -#define FC_VPORT_LOGO_RCVD      0x200    /* LOGO received on vport */
> -#define FC_RSCN_DISCOVERY       0x400	 /* Auth all devices after RSCN */
> -#define FC_LOGO_RCVD_DID_CHNG   0x800    /* FDISC on phys port detect DID chng*/
> -#define FC_PT2PT_NO_NVME        0x1000   /* Don't send NVME PRLI */
> -#define FC_SCSI_SCAN_TMO        0x4000	 /* scsi scan timer running */
> -#define FC_ABORT_DISCOVERY      0x8000	 /* we want to abort discovery */
> -#define FC_NDISC_ACTIVE         0x10000	 /* NPort discovery active */
> -#define FC_BYPASSED_MODE        0x20000	 /* NPort is in bypassed mode */
> -#define FC_VPORT_NEEDS_REG_VPI	0x80000  /* Needs to have its vpi registered */
> -#define FC_RSCN_DEFERRED	0x100000 /* A deferred RSCN being processed */
> -#define FC_VPORT_NEEDS_INIT_VPI 0x200000 /* Need to INIT_VPI before FDISC */
> -#define FC_VPORT_CVL_RCVD	0x400000 /* VLink failed due to CVL	 */
> -#define FC_VFI_REGISTERED	0x800000 /* VFI is registered */
> -#define FC_FDISC_COMPLETED	0x1000000/* FDISC completed */
> -#define FC_DISC_DELAYED		0x2000000/* Delay NPort discovery */
> +	unsigned long fc_flag;	/* FC flags */
>   
>   	uint32_t ct_flags;
>   #define FC_CT_RFF_ID		0x1	 /* RFF_ID accepted by switch */
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 023f4f2c62a6..55289abb6cf7 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -1092,14 +1092,14 @@ lpfc_link_state_show(struct device *dev, struct device_attribute *attr,
>   			break;
>   		}
>   		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
> -			if (vport->fc_flag & FC_PUBLIC_LOOP)
> +			if (test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))
>   				len += scnprintf(buf + len, PAGE_SIZE-len,
>   						"   Public Loop\n");
>   			else
>   				len += scnprintf(buf + len, PAGE_SIZE-len,
>   						"   Private Loop\n");
>   		} else {
> -			if (vport->fc_flag & FC_FABRIC) {
> +			if (test_bit(FC_FABRIC, &vport->fc_flag)) {
>   				if (phba->sli_rev == LPFC_SLI_REV4 &&
>   				    vport->port_type == LPFC_PHYSICAL_PORT &&
>   				    phba->sli4_hba.fawwpn_flag &
> @@ -1291,7 +1291,7 @@ lpfc_issue_lip(struct Scsi_Host *shost)
>   	 * If the link is offline, disabled or BLOCK_MGMT_IO
>   	 * it doesn't make any sense to allow issue_lip
>   	 */
> -	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag) ||
>   	    (phba->hba_flag & LINK_DISABLED) ||
>   	    (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO))
>   		return -EPERM;
> @@ -1305,8 +1305,8 @@ lpfc_issue_lip(struct Scsi_Host *shost)
>   	pmboxq->u.mb.mbxCommand = MBX_DOWN_LINK;
>   	pmboxq->u.mb.mbxOwner = OWN_HOST;
>   
> -	if ((vport->fc_flag & FC_PT2PT) && (vport->fc_flag & FC_PT2PT_NO_NVME))
> -		vport->fc_flag &= ~FC_PT2PT_NO_NVME;
> +	if (test_bit(FC_PT2PT, &vport->fc_flag))
> +		clear_bit(FC_PT2PT_NO_NVME, &vport->fc_flag);
>   
>   	mbxstatus = lpfc_sli_issue_mbox_wait(phba, pmboxq, LPFC_MBOX_TMO * 2);
>   
> @@ -1496,7 +1496,8 @@ lpfc_reset_pci_bus(struct lpfc_hba *phba)
>   		if (shost) {
>   			phba_other =
>   				((struct lpfc_vport *)shost->hostdata)->phba;
> -			if (!(phba_other->pport->fc_flag & FC_OFFLINE_MODE)) {
> +			if (!test_bit(FC_OFFLINE_MODE,
> +				      &phba_other->pport->fc_flag)) {
>   				lpfc_printf_log(phba_other, KERN_INFO, LOG_INIT,
>   						"8349 WWPN = 0x%02x%02x%02x%02x"
>   						"%02x%02x%02x%02x is not "
> @@ -1551,7 +1552,7 @@ lpfc_selective_reset(struct lpfc_hba *phba)
>   	if (!phba->cfg_enable_hba_reset)
>   		return -EACCES;
>   
> -	if (!(phba->pport->fc_flag & FC_OFFLINE_MODE)) {
> +	if (!test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag)) {
>   		status = lpfc_do_offline(phba, LPFC_EVT_OFFLINE);
>   
>   		if (status != 0)
> @@ -1690,7 +1691,7 @@ lpfc_sli4_pdev_reg_request(struct lpfc_hba *phba, uint32_t opcode)
>   {
>   	struct completion online_compl;
>   	struct pci_dev *pdev = phba->pcidev;
> -	uint32_t before_fc_flag;
> +	unsigned long before_fc_flag;
>   	uint32_t sriov_nr_virtfn;
>   	uint32_t reg_val;
>   	int status = 0, rc = 0;
> @@ -1761,7 +1762,7 @@ lpfc_sli4_pdev_reg_request(struct lpfc_hba *phba, uint32_t opcode)
>   	}
>   
>   	/* keep the original port state */
> -	if (before_fc_flag & FC_OFFLINE_MODE) {
> +	if (test_bit(FC_OFFLINE_MODE, &before_fc_flag)) {
>   		if (phba->fw_dump_cmpl)
>   			phba->fw_dump_cmpl = NULL;
>   		goto out;
> @@ -2099,7 +2100,7 @@ lpfc_board_mode_store(struct device *dev, struct device_attribute *attr,
>   			*board_mode_str = '\0';
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
>   				 "3097 Failed \"%s\", status(%d), "
> -				 "fc_flag(x%x)\n",
> +				 "fc_flag(x%lx)\n",
>   				 buf, status, phba->pport->fc_flag);
>   		return status;
>   	}
> @@ -2158,7 +2159,7 @@ lpfc_get_hba_info(struct lpfc_hba *phba,
>   	pmb->mbxOwner = OWN_HOST;
>   	pmboxq->ctx_buf = NULL;
>   
> -	if (phba->pport->fc_flag & FC_OFFLINE_MODE)
> +	if (test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		rc = MBX_NOT_FINISHED;
>   	else
>   		rc = lpfc_sli_issue_mbox_wait(phba, pmboxq, phba->fc_ratov * 2);
> @@ -6200,7 +6201,7 @@ sysfs_ctlreg_write(struct file *filp, struct kobject *kobj,
>   	if (memcmp(buf, LPFC_REG_WRITE_KEY, LPFC_REG_WRITE_KEY_SIZE))
>   		return -EINVAL;
>   
> -	if (!(vport->fc_flag & FC_OFFLINE_MODE))
> +	if (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
>   		return -EPERM;
>   
>   	spin_lock_irq(&phba->hbalock);
> @@ -6433,12 +6434,12 @@ lpfc_get_host_port_type(struct Scsi_Host *shost)
>   		fc_host_port_type(shost) = FC_PORTTYPE_NPIV;
>   	} else if (lpfc_is_link_up(phba)) {
>   		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
> -			if (vport->fc_flag & FC_PUBLIC_LOOP)
> +			if (test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))
>   				fc_host_port_type(shost) = FC_PORTTYPE_NLPORT;
>   			else
>   				fc_host_port_type(shost) = FC_PORTTYPE_LPORT;
>   		} else {
> -			if (vport->fc_flag & FC_FABRIC)
> +			if (test_bit(FC_FABRIC, &vport->fc_flag))
>   				fc_host_port_type(shost) = FC_PORTTYPE_NPORT;
>   			else
>   				fc_host_port_type(shost) = FC_PORTTYPE_PTP;
> @@ -6457,7 +6458,7 @@ lpfc_get_host_port_state(struct Scsi_Host *shost)
>   	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
>   	struct lpfc_hba   *phba = vport->phba;
>   
> -	if (vport->fc_flag & FC_OFFLINE_MODE)
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
>   		fc_host_port_state(shost) = FC_PORTSTATE_OFFLINE;
>   	else {
>   		switch (phba->link_state) {
> @@ -6571,10 +6572,10 @@ lpfc_get_host_fabric_name (struct Scsi_Host *shost)
>   	struct lpfc_hba   *phba = vport->phba;
>   	u64 node_name;
>   
> -	if ((vport->port_state > LPFC_FLOGI) &&
> -	    ((vport->fc_flag & FC_FABRIC) ||
> -	     ((phba->fc_topology == LPFC_TOPOLOGY_LOOP) &&
> -	      (vport->fc_flag & FC_PUBLIC_LOOP))))
> +	if (vport->port_state > LPFC_FLOGI &&
> +	    (test_bit(FC_FABRIC, &vport->fc_flag) ||
> +	     (phba->fc_topology == LPFC_TOPOLOGY_LOOP &&
> +	      test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))))
>   		node_name = wwn_to_u64(phba->fc_fabparam.nodeName.u.wwn);
>   	else
>   		/* fabric is local port if there is no F/FL_Port */
> @@ -6630,7 +6631,7 @@ lpfc_get_stats(struct Scsi_Host *shost)
>   	pmboxq->ctx_buf = NULL;
>   	pmboxq->vport = vport;
>   
> -	if (vport->fc_flag & FC_OFFLINE_MODE) {
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
>   		rc = lpfc_sli_issue_mbox(phba, pmboxq, MBX_POLL);
>   		if (rc != MBX_SUCCESS) {
>   			mempool_free(pmboxq, phba->mbox_mem_pool);
> @@ -6683,7 +6684,7 @@ lpfc_get_stats(struct Scsi_Host *shost)
>   	pmboxq->ctx_buf = NULL;
>   	pmboxq->vport = vport;
>   
> -	if (vport->fc_flag & FC_OFFLINE_MODE) {
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
>   		rc = lpfc_sli_issue_mbox(phba, pmboxq, MBX_POLL);
>   		if (rc != MBX_SUCCESS) {
>   			mempool_free(pmboxq, phba->mbox_mem_pool);
> @@ -6770,8 +6771,8 @@ lpfc_reset_stats(struct Scsi_Host *shost)
>   	pmboxq->ctx_buf = NULL;
>   	pmboxq->vport = vport;
>   
> -	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
> -		(!(psli->sli_flag & LPFC_SLI_ACTIVE))) {
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag) ||
> +	    !(psli->sli_flag & LPFC_SLI_ACTIVE)) {
>   		rc = lpfc_sli_issue_mbox(phba, pmboxq, MBX_POLL);
>   		if (rc != MBX_SUCCESS) {
>   			mempool_free(pmboxq, phba->mbox_mem_pool);
> @@ -6792,8 +6793,8 @@ lpfc_reset_stats(struct Scsi_Host *shost)
>   	pmboxq->ctx_buf = NULL;
>   	pmboxq->vport = vport;
>   
> -	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
> -	    (!(psli->sli_flag & LPFC_SLI_ACTIVE))) {
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag) ||
> +	    !(psli->sli_flag & LPFC_SLI_ACTIVE)) {
>   		rc = lpfc_sli_issue_mbox(phba, pmboxq, MBX_POLL);
>   		if (rc != MBX_SUCCESS) {
>   			mempool_free(pmboxq, phba->mbox_mem_pool);
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index 595dca92e8db..095914854dda 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -1977,7 +1977,7 @@ lpfc_sli4_bsg_set_loopback_mode(struct lpfc_hba *phba, int mode,
>   static int
>   lpfc_sli4_diag_fcport_reg_setup(struct lpfc_hba *phba)
>   {
> -	if (phba->pport->fc_flag & FC_VFI_REGISTERED) {
> +	if (test_bit(FC_VFI_REGISTERED, &phba->pport->fc_flag)) {
>   		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
>   				"3136 Port still had vfi registered: "
>   				"mydid:x%x, fcfi:%d, vfi:%d, vpi:%d\n",
> @@ -3448,7 +3448,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
>   	case MBX_RUN_DIAGS:
>   	case MBX_RESTART:
>   	case MBX_SET_MASK:
> -		if (!(vport->fc_flag & FC_OFFLINE_MODE)) {
> +		if (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
>   			lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
>   				"2743 Command 0x%x is illegal in on-line "
>   				"state\n",
> @@ -4886,7 +4886,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
>   	dd_data->context_un.mbox.outExtWLen = mbox_req->outExtWLen;
>   	job->dd_data = dd_data;
>   
> -	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag) ||
>   	    (!(phba->sli.sli_flag & LPFC_SLI_ACTIVE))) {
>   		rc = lpfc_sli_issue_mbox(phba, pmboxq, MBX_POLL);
>   		if (rc != MBX_SUCCESS) {
> diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> index 633b8ba25bc3..20520c7f58f6 100644
> --- a/drivers/scsi/lpfc/lpfc_ct.c
> +++ b/drivers/scsi/lpfc/lpfc_ct.c
> @@ -265,7 +265,7 @@ lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
>   	kfree(mp);
>   ct_exit:
>   	lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
> -			 "6440 Unsol CT: Rsp err %d Data: x%x\n",
> +			 "6440 Unsol CT: Rsp err %d Data: x%lx\n",
>   			 rc, vport->fc_flag);
>   }
>   
> @@ -298,7 +298,7 @@ lpfc_ct_handle_mibreq(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocbq)
>   	}
>   
>   	/* Ignore traffic received during vport shutdown */
> -	if (vport->fc_flag & FC_UNLOADING)
> +	if (test_bit(FC_UNLOADING, &vport->fc_flag))
>   		return;
>   
>   	ndlp = lpfc_findnode_did(vport, did);
> @@ -723,7 +723,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
>   
>   		if (ndlp) {
>   			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
> -				"Parse GID_FTrsp: did:x%x flg:x%x x%x",
> +				"Parse GID_FTrsp: did:x%x flg:x%lx x%x",
>   				Did, ndlp->nlp_flag, vport->fc_flag);
>   
>   			/* By default, the driver expects to support FCP FC4 */
> @@ -735,7 +735,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
>   
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0238 Process x%06x NameServer Rsp "
> -					 "Data: x%x x%x x%x x%x x%x\n", Did,
> +					 "Data: x%x x%x x%x x%lx x%x\n", Did,
>   					 ndlp->nlp_flag, ndlp->nlp_fc4_type,
>   					 ndlp->nlp_state, vport->fc_flag,
>   					 vport->fc_rscn_id_cnt);
> @@ -751,20 +751,20 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
>   			}
>   		} else {
>   			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
> -				"Skip1 GID_FTrsp: did:x%x flg:x%x cnt:%d",
> +				"Skip1 GID_FTrsp: did:x%x flg:x%lx cnt:%d",
>   				Did, vport->fc_flag, vport->fc_rscn_id_cnt);
>   
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0239 Skip x%06x NameServer Rsp "
> -					 "Data: x%x x%x x%px\n",
> +					 "Data: x%lx x%x x%px\n",
>   					 Did, vport->fc_flag,
>   					 vport->fc_rscn_id_cnt, ndlp);
>   		}
>   	} else {
> -		if (!(vport->fc_flag & FC_RSCN_MODE) ||
> +		if (!test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
>   		    lpfc_rscn_payload_check(vport, Did)) {
>   			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
> -				"Query GID_FTrsp: did:x%x flg:x%x cnt:%d",
> +				"Query GID_FTrsp: did:x%x flg:x%lx cnt:%d",
>   				Did, vport->fc_flag, vport->fc_rscn_id_cnt);
>   
>   			/*
> @@ -787,12 +787,12 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
>   				lpfc_setup_disc_node(vport, Did);
>   		} else {
>   			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
> -				"Skip2 GID_FTrsp: did:x%x flg:x%x cnt:%d",
> +				"Skip2 GID_FTrsp: did:x%x flg:x%lx cnt:%d",
>   				Did, vport->fc_flag, vport->fc_rscn_id_cnt);
>   
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0245 Skip x%06x NameServer Rsp "
> -					 "Data: x%x x%x\n", Did,
> +					 "Data: x%lx x%x\n", Did,
>   					 vport->fc_flag,
>   					 vport->fc_rscn_id_cnt);
>   		}
> @@ -914,7 +914,6 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_dmabuf *outp;
>   	struct lpfc_dmabuf *inp;
>   	struct lpfc_sli_ct_request *CTrsp;
> @@ -945,7 +944,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   
>   	/* Skip processing response on pport if unloading */
>   	if (vport == phba->pport && vport->load_flag & FC_UNLOADING) {
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		goto out;
>   	}
> @@ -953,7 +952,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	if (lpfc_els_chk_latt(vport)) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "0216 Link event during NS query\n");
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
>   		goto out;
> @@ -961,22 +960,18 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	if (lpfc_error_lost_link(vport, ulp_status, ulp_word4)) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "0226 NS query failed due to link event: "
> -				 "ulp_status x%x ulp_word4 x%x fc_flag x%x "
> +				 "ulp_status x%x ulp_word4 x%x fc_flag x%lx "
>   				 "port_state x%x gidft_inp x%x\n",
>   				 ulp_status, ulp_word4, vport->fc_flag,
>   				 vport->port_state, vport->gidft_inp);
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		if (vport->gidft_inp)
>   			vport->gidft_inp--;
>   		goto out;
>   	}
>   
> -	spin_lock_irq(shost->host_lock);
> -	if (vport->fc_flag & FC_RSCN_DEFERRED) {
> -		vport->fc_flag &= ~FC_RSCN_DEFERRED;
> -		spin_unlock_irq(shost->host_lock);
> -
> +	if (test_and_clear_bit(FC_RSCN_DEFERRED, &vport->fc_flag)) {
>   		/* This is a GID_FT completing so the gidft_inp counter was
>   		 * incremented before the GID_FT was issued to the wire.
>   		 */
> @@ -988,13 +983,12 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * Re-issue the NS cmd
>   		 */
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
> -				 "0151 Process Deferred RSCN Data: x%x x%x\n",
> +				 "0151 Process Deferred RSCN Data: x%lx x%x\n",
>   				 vport->fc_flag, vport->fc_rscn_id_cnt);
>   		lpfc_els_handle_rscn(vport);
>   
>   		goto out;
>   	}
> -	spin_unlock_irq(shost->host_lock);
>   
>   	if (ulp_status) {
>   		/* Check for retry */
> @@ -1018,7 +1012,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   					vport->gidft_inp--;
>   			}
>   		}
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
> @@ -1031,7 +1025,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		if (CTrsp->CommandResponse.bits.CmdRsp ==
>   		    cpu_to_be16(SLI_CT_RESPONSE_FS_ACC)) {
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -					 "0208 NameServer Rsp Data: x%x x%x "
> +					 "0208 NameServer Rsp Data: x%lx x%x "
>   					 "x%x x%x sz x%x\n",
>   					 vport->fc_flag,
>   					 CTreq->un.gid.Fc4Type,
> @@ -1051,7 +1045,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   				lpfc_printf_vlog(vport, KERN_INFO,
>   					LOG_DISCOVERY,
>   					"0269 No NameServer Entries "
> -					"Data: x%x x%x x%x x%x\n",
> +					"Data: x%x x%x x%x x%lx\n",
>   					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					(uint32_t) CTrsp->ReasonCode,
>   					(uint32_t) CTrsp->Explanation,
> @@ -1066,7 +1060,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   				lpfc_printf_vlog(vport, KERN_INFO,
>   					LOG_DISCOVERY,
>   					"0240 NameServer Rsp Error "
> -					"Data: x%x x%x x%x x%x\n",
> +					"Data: x%x x%x x%x x%lx\n",
>   					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					(uint32_t) CTrsp->ReasonCode,
>   					(uint32_t) CTrsp->Explanation,
> @@ -1084,7 +1078,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			/* NameServer Rsp Error */
>   			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
>   					"0241 NameServer Rsp Error "
> -					"Data: x%x x%x x%x x%x\n",
> +					"Data: x%x x%x x%x x%lx\n",
>   					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					(uint32_t) CTrsp->ReasonCode,
>   					(uint32_t) CTrsp->Explanation,
> @@ -1113,14 +1107,13 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * current driver state.
>   		 */
>   		if (vport->port_state >= LPFC_DISC_AUTH) {
> -			if (vport->fc_flag & FC_RSCN_MODE) {
> +			if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   				lpfc_els_flush_rscn(vport);
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag |= FC_RSCN_MODE; /* RSCN still */
> -				spin_unlock_irq(shost->host_lock);
> -			}
> -			else
> +				/* RSCN still */
> +				set_bit(FC_RSCN_MODE, &vport->fc_flag);
> +			} else {
>   				lpfc_els_flush_rscn(vport);
> +			}
>   		}
>   
>   		lpfc_disc_start(vport);
> @@ -1136,7 +1129,6 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_dmabuf *outp;
>   	struct lpfc_dmabuf *inp;
>   	struct lpfc_sli_ct_request *CTrsp;
> @@ -1168,7 +1160,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   
>   	/* Skip processing response on pport if unloading */
>   	if (vport == phba->pport && vport->load_flag & FC_UNLOADING) {
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		goto out;
>   	}
> @@ -1176,7 +1168,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	if (lpfc_els_chk_latt(vport)) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "4108 Link event during NS query\n");
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
>   		goto out;
> @@ -1184,22 +1176,18 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	if (lpfc_error_lost_link(vport, ulp_status, ulp_word4)) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "4166 NS query failed due to link event: "
> -				 "ulp_status x%x ulp_word4 x%x fc_flag x%x "
> +				 "ulp_status x%x ulp_word4 x%x fc_flag x%lx "
>   				 "port_state x%x gidft_inp x%x\n",
>   				 ulp_status, ulp_word4, vport->fc_flag,
>   				 vport->port_state, vport->gidft_inp);
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		if (vport->gidft_inp)
>   			vport->gidft_inp--;
>   		goto out;
>   	}
>   
> -	spin_lock_irq(shost->host_lock);
> -	if (vport->fc_flag & FC_RSCN_DEFERRED) {
> -		vport->fc_flag &= ~FC_RSCN_DEFERRED;
> -		spin_unlock_irq(shost->host_lock);
> -
> +	if (test_and_clear_bit(FC_RSCN_DEFERRED, &vport->fc_flag)) {
>   		/* This is a GID_PT completing so the gidft_inp counter was
>   		 * incremented before the GID_PT was issued to the wire.
>   		 */
> @@ -1211,13 +1199,12 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * Re-issue the NS cmd
>   		 */
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
> -				 "4167 Process Deferred RSCN Data: x%x x%x\n",
> +				 "4167 Process Deferred RSCN Data: x%lx x%x\n",
>   				 vport->fc_flag, vport->fc_rscn_id_cnt);
>   		lpfc_els_handle_rscn(vport);
>   
>   		goto out;
>   	}
> -	spin_unlock_irq(shost->host_lock);
>   
>   	if (ulp_status) {
>   		/* Check for retry */
> @@ -1237,7 +1224,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   					vport->gidft_inp--;
>   			}
>   		}
> -		if (vport->fc_flag & FC_RSCN_MODE)
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   			lpfc_els_flush_rscn(vport);
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
> @@ -1250,7 +1237,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
>   		    SLI_CT_RESPONSE_FS_ACC) {
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -					 "4105 NameServer Rsp Data: x%x x%x "
> +					 "4105 NameServer Rsp Data: x%lx x%x "
>   					 "x%x x%x sz x%x\n",
>   					 vport->fc_flag,
>   					 CTreq->un.gid.Fc4Type,
> @@ -1270,7 +1257,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   				lpfc_printf_vlog(
>   					vport, KERN_INFO, LOG_DISCOVERY,
>   					"4106 No NameServer Entries "
> -					"Data: x%x x%x x%x x%x\n",
> +					"Data: x%x x%x x%x x%lx\n",
>   					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					(uint32_t)CTrsp->ReasonCode,
>   					(uint32_t)CTrsp->Explanation,
> @@ -1286,7 +1273,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   				lpfc_printf_vlog(
>   					vport, KERN_INFO, LOG_DISCOVERY,
>   					"4107 NameServer Rsp Error "
> -					"Data: x%x x%x x%x x%x\n",
> +					"Data: x%x x%x x%x x%lx\n",
>   					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					(uint32_t)CTrsp->ReasonCode,
>   					(uint32_t)CTrsp->Explanation,
> @@ -1303,7 +1290,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			/* NameServer Rsp Error */
>   			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
>   					 "4109 NameServer Rsp Error "
> -					 "Data: x%x x%x x%x x%x\n",
> +					 "Data: x%x x%x x%x x%lx\n",
>   					 be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
>   					 (uint32_t)CTrsp->ReasonCode,
>   					 (uint32_t)CTrsp->Explanation,
> @@ -1333,11 +1320,10 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * current driver state.
>   		 */
>   		if (vport->port_state >= LPFC_DISC_AUTH) {
> -			if (vport->fc_flag & FC_RSCN_MODE) {
> +			if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   				lpfc_els_flush_rscn(vport);
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag |= FC_RSCN_MODE; /* RSCN still */
> -				spin_unlock_irq(shost->host_lock);
> +				/* RSCN still */
> +				set_bit(FC_RSCN_MODE, &vport->fc_flag);
>   			} else {
>   				lpfc_els_flush_rscn(vport);
>   			}
> @@ -1355,7 +1341,6 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_dmabuf *inp = cmdiocb->cmd_dmabuf;
>   	struct lpfc_dmabuf *outp = cmdiocb->rsp_dmabuf;
>   	struct lpfc_sli_ct_request *CTrsp;
> @@ -1445,7 +1430,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		}
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
>   				 "0267 NameServer GFF Rsp "
> -				 "x%x Error (%d %d) Data: x%x x%x\n",
> +				 "x%x Error (%d %d) Data: x%lx x%x\n",
>   				 did, ulp_status, ulp_word4,
>   				 vport->fc_flag, vport->fc_rscn_id_cnt);
>   	}
> @@ -1455,13 +1440,13 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	if (ndlp) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "0242 Process x%x GFF "
> -				 "NameServer Rsp Data: x%x x%x x%x\n",
> +				 "NameServer Rsp Data: x%x x%lx x%x\n",
>   				 did, ndlp->nlp_flag, vport->fc_flag,
>   				 vport->fc_rscn_id_cnt);
>   	} else {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "0243 Skip x%x GFF "
> -				 "NameServer Rsp Data: x%x x%x\n", did,
> +				 "NameServer Rsp Data: x%lx x%x\n", did,
>   				 vport->fc_flag, vport->fc_rscn_id_cnt);
>   	}
>   out:
> @@ -1480,14 +1465,13 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * current driver state.
>   		 */
>   		if (vport->port_state >= LPFC_DISC_AUTH) {
> -			if (vport->fc_flag & FC_RSCN_MODE) {
> +			if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   				lpfc_els_flush_rscn(vport);
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag |= FC_RSCN_MODE; /* RSCN still */
> -				spin_unlock_irq(shost->host_lock);
> -			}
> -			else
> +				/* RSCN still */
> +				set_bit(FC_RSCN_MODE, &vport->fc_flag);
> +			} else {
>   				lpfc_els_flush_rscn(vport);
> +			}
>   		}
>   		lpfc_disc_start(vport);
>   	}
> @@ -1949,7 +1933,7 @@ lpfc_ns_cmd(struct lpfc_vport *vport, int cmdcode,
>   
>   	/* NameServer Req */
>   	lpfc_printf_vlog(vport, KERN_INFO ,LOG_DISCOVERY,
> -			 "0236 NameServer Req Data: x%x x%x x%x x%x\n",
> +			 "0236 NameServer Req Data: x%x x%lx x%x x%x\n",
>   			 cmdcode, vport->fc_flag, vport->fc_rscn_id_cnt,
>   			 context);
>   
> @@ -2166,7 +2150,8 @@ lpfc_ns_cmd(struct lpfc_vport *vport, int cmdcode,
>   	kfree(mp);
>   ns_cmd_exit:
>   	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
> -			 "0266 Issue NameServer Req x%x err %d Data: x%x x%x\n",
> +			 "0266 Issue NameServer Req x%x err %d Data: x%lx "
> +			 "x%x\n",
>   			 cmdcode, rc, vport->fc_flag, vport->fc_rscn_id_cnt);
>   	return 1;
>   }
> @@ -2452,7 +2437,7 @@ lpfc_fdmi_change_check(struct lpfc_vport *vport)
>   		return;
>   
>   	/* Must be connected to a Fabric */
> -	if (!(vport->fc_flag & FC_FABRIC))
> +	if (!test_bit(FC_FABRIC, &vport->fc_flag))
>   		return;
>   
>   	ndlp = lpfc_findnode_did(vport, FDMI_DID);
> @@ -3232,7 +3217,7 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   
>   	/* FDMI request */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -			 "0218 FDMI Request x%x mask x%x Data: x%x x%x x%x\n",
> +			 "0218 FDMI Request x%x mask x%x Data: x%x x%lx x%x\n",
>   			 cmdcode, new_mask, vport->fdmi_port_mask,
>   			 vport->fc_flag, vport->port_state);
>   
> @@ -3469,15 +3454,8 @@ lpfc_delayed_disc_tmo(struct timer_list *t)
>   void
>   lpfc_delayed_disc_timeout_handler(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
> -
> -	spin_lock_irq(shost->host_lock);
> -	if (!(vport->fc_flag & FC_DISC_DELAYED)) {
> -		spin_unlock_irq(shost->host_lock);
> +	if (!test_and_clear_bit(FC_DISC_DELAYED, &vport->fc_flag))
>   		return;
> -	}
> -	vport->fc_flag &= ~FC_DISC_DELAYED;
> -	spin_unlock_irq(shost->host_lock);
>   
>   	lpfc_do_scr_ns_plogi(vport->phba, vport);
>   }
> @@ -3728,7 +3706,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
>   	INIT_LIST_HEAD(&bmp->list);
>   
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -			 "3275 VMID Request Data: x%x x%x x%x\n",
> +			 "3275 VMID Request Data: x%lx x%x x%x\n",
>   			 vport->fc_flag, vport->port_state, cmdcode);
>   	ctreq = (struct lpfc_sli_ct_request *)mp->virt;
>   	data = mp->virt;
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index e01583e2690b..a3b822e8c10a 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -93,7 +93,6 @@ static void lpfc_vmid_put_cs_ctl(struct lpfc_vport *vport, u32 ctcl_vmid);
>   int
>   lpfc_els_chk_latt(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	uint32_t ha_copy;
>   
> @@ -121,9 +120,7 @@ lpfc_els_chk_latt(struct lpfc_vport *vport)
>   	 * will cleanup any left over in-progress discovery
>   	 * events.
>   	 */
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag |= FC_ABORT_DISCOVERY;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
>   
>   	if (phba->link_state != LPFC_CLEAR_LA)
>   		lpfc_issue_clear_la(phba, vport);
> @@ -301,7 +298,7 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, u8 expect_rsp,
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   				 "0116 Xmit ELS command x%x to remote "
>   				 "NPORT x%x I/O tag: x%x, port state:x%x "
> -				 "rpi x%x fc_flag:x%x\n",
> +				 "rpi x%x fc_flag:x%lx\n",
>   				 elscmd, did, elsiocb->iotag,
>   				 vport->port_state, ndlp->nlp_rpi,
>   				 vport->fc_flag);
> @@ -310,7 +307,7 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, u8 expect_rsp,
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   				 "0117 Xmit ELS response x%x to remote "
>   				 "NPORT x%x I/O tag: x%x, size: x%x "
> -				 "port_state x%x  rpi x%x fc_flag x%x\n",
> +				 "port_state x%x  rpi x%x fc_flag x%lx\n",
>   				 elscmd, ndlp->nlp_DID, elsiocb->iotag,
>   				 cmd_size, vport->port_state,
>   				 ndlp->nlp_rpi, vport->fc_flag);
> @@ -452,7 +449,7 @@ lpfc_issue_reg_vfi(struct lpfc_vport *vport)
>   	/* move forward in case of SLI4 FC port loopback test and pt2pt mode */
>   	if ((phba->sli_rev == LPFC_SLI_REV4) &&
>   	    !(phba->link_flag & LS_LOOPBACK_MODE) &&
> -	    !(vport->fc_flag & FC_PT2PT)) {
> +	    !test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		ndlp = lpfc_findnode_did(vport, Fabric_DID);
>   		if (!ndlp) {
>   			rc = -ENODEV;
> @@ -467,7 +464,8 @@ lpfc_issue_reg_vfi(struct lpfc_vport *vport)
>   	}
>   
>   	/* Supply CSP's only if we are fabric connect or pt-to-pt connect */
> -	if ((vport->fc_flag & FC_FABRIC) || (vport->fc_flag & FC_PT2PT)) {
> +	if (test_bit(FC_FABRIC, &vport->fc_flag) ||
> +	    test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		rc = lpfc_mbox_rsrc_prep(phba, mboxq);
>   		if (rc) {
>   			rc = -ENOMEM;
> @@ -520,7 +518,6 @@ int
>   lpfc_issue_unreg_vfi(struct lpfc_vport *vport)
>   {
>   	struct lpfc_hba *phba = vport->phba;
> -	struct Scsi_Host *shost;
>   	LPFC_MBOXQ_t *mboxq;
>   	int rc;
>   
> @@ -546,10 +543,7 @@ lpfc_issue_unreg_vfi(struct lpfc_vport *vport)
>   		return -EIO;
>   	}
>   
> -	shost = lpfc_shost_from_vport(vport);
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VFI_REGISTERED;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VFI_REGISTERED, &vport->fc_flag);
>   	return 0;
>   }
>   
> @@ -577,7 +571,6 @@ lpfc_check_clean_addr_bit(struct lpfc_vport *vport,
>   {
>   	struct lpfc_hba *phba = vport->phba;
>   	uint8_t fabric_param_changed = 0;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	if ((vport->fc_prevDID != vport->fc_myDID) ||
>   		memcmp(&vport->fabric_portname, &sp->portName,
> @@ -599,11 +592,8 @@ lpfc_check_clean_addr_bit(struct lpfc_vport *vport,
>   	 * - lpfc_delay_discovery module parameter is set.
>   	 */
>   	if (fabric_param_changed && !sp->cmn.clean_address_bit &&
> -	    (vport->fc_prevDID || phba->cfg_delay_discovery)) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_DISC_DELAYED;
> -		spin_unlock_irq(shost->host_lock);
> -	}
> +	    (vport->fc_prevDID || phba->cfg_delay_discovery))
> +		set_bit(FC_DISC_DELAYED, &vport->fc_flag);
>   
>   	return fabric_param_changed;
>   }
> @@ -633,15 +623,12 @@ static int
>   lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			   struct serv_parm *sp, uint32_t ulp_word4)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct lpfc_nodelist *np;
>   	struct lpfc_nodelist *next_np;
>   	uint8_t fabric_param_changed;
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag |= FC_FABRIC;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_FABRIC, &vport->fc_flag);
>   
>   	phba->fc_edtov = be32_to_cpu(sp->cmn.e_d_tov);
>   	if (sp->cmn.edtovResolution)	/* E_D_TOV ticks are in nanoseconds */
> @@ -650,11 +637,8 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	phba->fc_edtovResol = sp->cmn.edtovResolution;
>   	phba->fc_ratov = (be32_to_cpu(sp->cmn.w2.r_a_tov) + 999) / 1000;
>   
> -	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_PUBLIC_LOOP;
> -		spin_unlock_irq(shost->host_lock);
> -	}
> +	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP)
> +		set_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   
>   	vport->fc_myDID = ulp_word4 & Mask_DID;
>   	memcpy(&ndlp->nlp_portname, &sp->portName, sizeof(struct lpfc_name));
> @@ -728,12 +712,12 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			lpfc_unregister_fcf_prep(phba);
>   
>   		/* This should just update the VFI CSPs*/
> -		if (vport->fc_flag & FC_VFI_REGISTERED)
> +		if (test_bit(FC_VFI_REGISTERED, &vport->fc_flag))
>   			lpfc_issue_reg_vfi(vport);
>   	}
>   
>   	if (fabric_param_changed &&
> -		!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)) {
> +		!test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag)) {
>   
>   		/* If our NportID changed, we need to ensure all
>   		 * remaining NPORTs get unreg_login'ed.
> @@ -753,20 +737,16 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   		if (phba->sli_rev == LPFC_SLI_REV4) {
>   			lpfc_sli4_unreg_all_rpis(vport);
>   			lpfc_mbx_unreg_vpi(vport);
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
> -			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   		}
>   
>   		/*
>   		 * For SLI3 and SLI4, the VPI needs to be reregistered in
>   		 * response to this fabric parameter change event.
>   		 */
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	} else if ((phba->sli_rev == LPFC_SLI_REV4) &&
> -		!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)) {
> +		   !test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag)) {
>   			/*
>   			 * Driver needs to re-reg VPI in order for f/w
>   			 * to update the MAC address.
> @@ -779,18 +759,18 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	if (phba->sli_rev < LPFC_SLI_REV4) {
>   		lpfc_nlp_set_state(vport, ndlp, NLP_STE_REG_LOGIN_ISSUE);
>   		if (phba->sli3_options & LPFC_SLI3_NPIV_ENABLED &&
> -		    vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)
> +		    test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag))
>   			lpfc_register_new_vport(phba, vport, ndlp);
>   		else
>   			lpfc_issue_fabric_reglogin(vport);
>   	} else {
>   		ndlp->nlp_type |= NLP_FABRIC;
>   		lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
> -		if ((!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)) &&
> -			(vport->vpi_state & LPFC_VPI_REGISTERED)) {
> +		if ((!test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag)) &&
> +		    (vport->vpi_state & LPFC_VPI_REGISTERED)) {
>   			lpfc_start_fdiscs(phba);
>   			lpfc_do_scr_ns_plogi(phba, vport);
> -		} else if (vport->fc_flag & FC_VFI_REGISTERED)
> +		} else if (test_bit(FC_VFI_REGISTERED, &vport->fc_flag))
>   			lpfc_issue_init_vpi(vport);
>   		else {
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
> @@ -826,15 +806,13 @@ static int
>   lpfc_cmpl_els_flogi_nport(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			  struct serv_parm *sp)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	LPFC_MBOXQ_t *mbox;
>   	int rc;
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> -	vport->fc_flag |= FC_PT2PT;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_FABRIC, &vport->fc_flag);
> +	clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
> +	set_bit(FC_PT2PT, &vport->fc_flag);
>   
>   	/* If we are pt2pt with another NPort, force NPIV off! */
>   	phba->sli3_options &= ~LPFC_SLI3_NPIV_ENABLED;
> @@ -842,10 +820,7 @@ lpfc_cmpl_els_flogi_nport(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	/* If physical FC port changed, unreg VFI and ALL VPIs / RPIs */
>   	if ((phba->sli_rev == LPFC_SLI_REV4) && phba->fc_topology_changed) {
>   		lpfc_unregister_fcf_prep(phba);
> -
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~FC_VFI_REGISTERED;
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_VFI_REGISTERED, &vport->fc_flag);
>   		phba->fc_topology_changed = 0;
>   	}
>   
> @@ -854,9 +829,7 @@ lpfc_cmpl_els_flogi_nport(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   
>   	if (rc >= 0) {
>   		/* This side will initiate the PLOGI */
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_PT2PT_PLOGI;
> -		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_PT2PT_PLOGI, &vport->fc_flag);
>   
>   		/*
>   		 * N_Port ID cannot be 0, set our Id to LocalID
> @@ -953,7 +926,6 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		    struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
>   	IOCB_t *irsp;
>   	struct lpfc_dmabuf *pcmd = cmdiocb->cmd_dmabuf, *prsp;
> @@ -1069,10 +1041,9 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		}
>   
>   		/* FLOGI failed, so there is no fabric */
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP |
> -				    FC_PT2PT_NO_NVME);
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_FABRIC, &vport->fc_flag);
> +		clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
> +		clear_bit(FC_PT2PT_NO_NVME, &vport->fc_flag);
>   
>   		/* If private loop, then allow max outstanding els to be
>   		 * LPFC_MAX_DISC_THREADS (32). Scanning in the case of no
> @@ -1081,15 +1052,14 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		if (phba->alpa_map[0] == 0)
>   			vport->cfg_discovery_threads = LPFC_MAX_DISC_THREADS;
>   		if ((phba->sli_rev == LPFC_SLI_REV4) &&
> -		    (!(vport->fc_flag & FC_VFI_REGISTERED) ||
> +		    (!test_bit(FC_VFI_REGISTERED, &vport->fc_flag) ||
>   		     (vport->fc_prevDID != vport->fc_myDID) ||
>   			phba->fc_topology_changed)) {
> -			if (vport->fc_flag & FC_VFI_REGISTERED) {
> +			if (test_bit(FC_VFI_REGISTERED, &vport->fc_flag)) {
>   				if (phba->fc_topology_changed) {
>   					lpfc_unregister_fcf_prep(phba);
> -					spin_lock_irq(shost->host_lock);
> -					vport->fc_flag &= ~FC_VFI_REGISTERED;
> -					spin_unlock_irq(shost->host_lock);
> +					clear_bit(FC_VFI_REGISTERED,
> +						  &vport->fc_flag);
>   					phba->fc_topology_changed = 0;
>   				} else {
>   					lpfc_sli4_unreg_all_rpis(vport);
> @@ -1104,10 +1074,8 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		}
>   		goto flogifail;
>   	}
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VPORT_CVL_RCVD;
> -	vport->fc_flag &= ~FC_VPORT_LOGO_RCVD;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VPORT_CVL_RCVD, &vport->fc_flag);
> +	clear_bit(FC_VPORT_LOGO_RCVD, &vport->fc_flag);
>   
>   	/*
>   	 * The FLOGI succeeded.  Sync the data for the CPU before
> @@ -1123,7 +1091,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	/* FLOGI completes successfully */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "0101 FLOGI completes successfully, I/O tag:x%x "
> -			 "xri x%x Data: x%x x%x x%x x%x x%x x%x x%x %d\n",
> +			 "xri x%x Data: x%x x%x x%x x%x x%x x%lx x%x %d\n",
>   			 cmdiocb->iotag, cmdiocb->sli4_xritag,
>   			 ulp_word4, sp->cmn.e_d_tov,
>   			 sp->cmn.w2.r_a_tov, sp->cmn.edtovResolution,
> @@ -1202,7 +1170,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			goto out;
>   		}
>   	} else if (vport->port_state > LPFC_FLOGI &&
> -		   vport->fc_flag & FC_PT2PT) {
> +		   test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		/*
>   		 * In a p2p topology, it is possible that discovery has
>   		 * already progressed, and this completion can be ignored.
> @@ -1506,8 +1474,9 @@ lpfc_els_abort_flogi(struct lpfc_hba *phba)
>   		if (ulp_command == CMD_ELS_REQUEST64_CR) {
>   			ndlp = iocb->ndlp;
>   			if (ndlp && ndlp->nlp_DID == Fabric_DID) {
> -				if ((phba->pport->fc_flag & FC_PT2PT) &&
> -				    !(phba->pport->fc_flag & FC_PT2PT_PLOGI))
> +				if (test_bit(FC_PT2PT, &phba->pport->fc_flag) &&
> +				    !test_bit(FC_PT2PT_PLOGI,
> +					      &phba->pport->fc_flag))
>   					iocb->fabric_cmd_cmpl =
>   						lpfc_ignore_els_cmpl;
>   				lpfc_sli_issue_abort_iotag(phba, pring, iocb,
> @@ -1562,7 +1531,7 @@ lpfc_initial_flogi(struct lpfc_vport *vport)
>   	}
>   
>   	/* Reset the Fabric flag, topology change may have happened */
> -	vport->fc_flag &= ~FC_FABRIC;
> +	clear_bit(FC_FABRIC, &vport->fc_flag);
>   	if (lpfc_issue_els_flogi(vport, ndlp, 0)) {
>   		/* A node reference should be retained while registered with a
>   		 * transport or dev-loss-evt work is pending.
> @@ -1645,12 +1614,12 @@ lpfc_more_plogi(struct lpfc_vport *vport)
>   	/* Continue discovery with <num_disc_nodes> PLOGIs to go */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   			 "0232 Continue discovery with %d PLOGIs to go "
> -			 "Data: x%x x%x x%x\n",
> +			 "Data: x%x x%lx x%x\n",
>   			 vport->num_disc_nodes,
>   			 atomic_read(&vport->fc_plogi_cnt),
>   			 vport->fc_flag, vport->port_state);
>   	/* Check to see if there are more PLOGIs to be sent */
> -	if (vport->fc_flag & FC_NLP_MORE)
> +	if (test_bit(FC_NLP_MORE, &vport->fc_flag))
>   		/* go thru NPR nodes and issue any remaining ELS PLOGIs */
>   		lpfc_els_disc_plogi(vport);
>   
> @@ -1769,7 +1738,7 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
>   	 * would have updated nlp_fc4_type in ndlp, so we must ensure
>   	 * new_ndlp has the right value.
>   	 */
> -	if (vport->fc_flag & FC_FABRIC) {
> +	if (test_bit(FC_FABRIC, &vport->fc_flag)) {
>   		keep_nlp_fc4_type = new_ndlp->nlp_fc4_type;
>   		new_ndlp->nlp_fc4_type = ndlp->nlp_fc4_type;
>   	}
> @@ -1930,21 +1899,17 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
>   void
>   lpfc_end_rscn(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
> -	if (vport->fc_flag & FC_RSCN_MODE) {
> +	if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   		/*
>   		 * Check to see if more RSCNs came in while we were
>   		 * processing this one.
>   		 */
>   		if (vport->fc_rscn_id_cnt ||
> -		    (vport->fc_flag & FC_RSCN_DISCOVERY) != 0)
> +		    test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag))
>   			lpfc_els_handle_rscn(vport);
> -		else {
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag &= ~FC_RSCN_MODE;
> -			spin_unlock_irq(shost->host_lock);
> -		}
> +		else
> +			clear_bit(FC_RSCN_MODE, &vport->fc_flag);
>   	}
>   }
>   
> @@ -2031,7 +1996,6 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		    struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
>   	IOCB_t *irsp;
>   	struct lpfc_nodelist *ndlp, *free_ndlp;
>   	struct lpfc_dmabuf *prsp;
> @@ -2178,9 +2142,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		lpfc_more_plogi(vport);
>   
>   		if (vport->num_disc_nodes == 0) {
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -			spin_unlock_irq(shost->host_lock);
> +			clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   
>   			lpfc_can_disctmo(vport);
>   			lpfc_end_rscn(vport);
> @@ -2242,7 +2204,7 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
>   	 */
>   	if ((ndlp->nlp_flag & (NLP_IGNR_REG_CMPL | NLP_UNREG_INP)) &&
>   	    ((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
> -	    !(vport->fc_flag & FC_OFFLINE_MODE)) {
> +	    !test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "4110 Issue PLOGI x%x deferred "
>   				 "on NPort x%x rpi x%x flg x%x Data:"
> @@ -2274,7 +2236,8 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
>   	 * If we are a N-port connected to a Fabric, fix-up paramm's so logins
>   	 * to device on remote loops work.
>   	 */
> -	if ((vport->fc_flag & FC_FABRIC) && !(vport->fc_flag & FC_PUBLIC_LOOP))
> +	if (test_bit(FC_FABRIC, &vport->fc_flag) &&
> +	    !test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))
>   		sp->cmn.altBbCredit = 1;
>   
>   	if (sp->cmn.fcphLow < FC_PH_4_3)
> @@ -2398,8 +2361,8 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		/* If we don't send GFT_ID to Fabric, a PRLI error
>   		 * could be expected.
>   		 */
> -		if ((vport->fc_flag & FC_FABRIC) ||
> -		    (vport->cfg_enable_fc4_type != LPFC_ENABLE_BOTH)) {
> +		if (test_bit(FC_FABRIC, &vport->fc_flag) ||
> +		    vport->cfg_enable_fc4_type != LPFC_ENABLE_BOTH) {
>   			mode = KERN_ERR;
>   			loglevel =  LOG_TRACE_EVENT;
>   		} else {
> @@ -2440,7 +2403,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		 * For P2P topology, retain the node so that PLOGI can be
>   		 * attempted on it again.
>   		 */
> -		if (vport->fc_flag & FC_PT2PT)
> +		if (test_bit(FC_PT2PT, &vport->fc_flag))
>   			goto out;
>   
>   		/* As long as this node is not registered with the SCSI
> @@ -2516,7 +2479,7 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	 * the remote NPort beng a NVME Target.
>   	 */
>   	if (phba->sli_rev == LPFC_SLI_REV4 &&
> -	    vport->fc_flag & FC_RSCN_MODE &&
> +	    test_bit(FC_RSCN_MODE, &vport->fc_flag) &&
>   	    vport->nvmei_support)
>   		ndlp->nlp_fc4_type |= NLP_FC4_NVME;
>   	local_nlp_type = ndlp->nlp_fc4_type;
> @@ -2713,7 +2676,6 @@ lpfc_rscn_disc(struct lpfc_vport *vport)
>   static void
>   lpfc_adisc_done(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host   *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba   *phba = vport->phba;
>   
>   	/*
> @@ -2721,7 +2683,7 @@ lpfc_adisc_done(struct lpfc_vport *vport)
>   	 * and continue discovery.
>   	 */
>   	if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
> -	    !(vport->fc_flag & FC_RSCN_MODE) &&
> +	    !test_bit(FC_RSCN_MODE, &vport->fc_flag) &&
>   	    (phba->sli_rev < LPFC_SLI_REV4)) {
>   
>   		/*
> @@ -2750,15 +2712,13 @@ lpfc_adisc_done(struct lpfc_vport *vport)
>   	if (vport->port_state < LPFC_VPORT_READY) {
>   		/* If we get here, there is nothing to ADISC */
>   		lpfc_issue_clear_la(phba, vport);
> -		if (!(vport->fc_flag & FC_ABORT_DISCOVERY)) {
> +		if (!test_bit(FC_ABORT_DISCOVERY, &vport->fc_flag)) {
>   			vport->num_disc_nodes = 0;
>   			/* go thru NPR list, issue ELS PLOGIs */
>   			if (atomic_read(&vport->fc_npr_cnt))
>   				lpfc_els_disc_plogi(vport);
>   			if (!vport->num_disc_nodes) {
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -				spin_unlock_irq(shost->host_lock);
> +				clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   				lpfc_can_disctmo(vport);
>   				lpfc_end_rscn(vport);
>   			}
> @@ -2785,12 +2745,12 @@ lpfc_more_adisc(struct lpfc_vport *vport)
>   	/* Continue discovery with <num_disc_nodes> ADISCs to go */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   			 "0210 Continue discovery with %d ADISCs to go "
> -			 "Data: x%x x%x x%x\n",
> +			 "Data: x%x x%lx x%x\n",
>   			 vport->num_disc_nodes,
>   			 atomic_read(&vport->fc_adisc_cnt),
>   			 vport->fc_flag, vport->port_state);
>   	/* Check to see if there are more ADISCs to be sent */
> -	if (vport->fc_flag & FC_NLP_MORE) {
> +	if (test_bit(FC_NLP_MORE, &vport->fc_flag)) {
>   		lpfc_set_disctmo(vport);
>   		/* go thru NPR nodes and issue any remaining ELS ADISCs */
>   		lpfc_els_disc_adisc(vport);
> @@ -3635,10 +3595,10 @@ lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry)
>   
>   	/* Not supported for private loop */
>   	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP &&
> -	    !(vport->fc_flag & FC_PUBLIC_LOOP))
> +	    !test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))
>   		return 1;
>   
> -	if (vport->fc_flag & FC_PT2PT) {
> +	if (test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		/* find any mapped nport - that would be the other nport */
>   		ndlp = lpfc_findnode_mapped(vport);
>   		if (!ndlp)
> @@ -4416,7 +4376,6 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
>   void
>   lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_work_evt *evtp;
>   
>   	if (!(nlp->nlp_flag & NLP_DELAY_TMO))
> @@ -4444,9 +4403,8 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
>   				/* Check if there are more PLOGIs to be sent */
>   				lpfc_more_plogi(vport);
>   				if (vport->num_disc_nodes == 0) {
> -					spin_lock_irq(shost->host_lock);
> -					vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -					spin_unlock_irq(shost->host_lock);
> +					clear_bit(FC_NDISC_ACTIVE,
> +						  &vport->fc_flag);
>   					lpfc_can_disctmo(vport);
>   					lpfc_end_rscn(vport);
>   				}
> @@ -4563,7 +4521,7 @@ lpfc_els_retry_delay_handler(struct lpfc_nodelist *ndlp)
>   		}
>   		break;
>   	case ELS_CMD_FDISC:
> -		if (!(vport->fc_flag & FC_VPORT_NEEDS_INIT_VPI))
> +		if (!test_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag))
>   			lpfc_issue_els_fdisc(vport, ndlp, retry);
>   		break;
>   	}
> @@ -4801,7 +4759,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		/* Added for Vendor specifc support
>   		 * Just keep retrying for these Rsn / Exp codes
>   		 */
> -		if ((vport->fc_flag & FC_PT2PT) &&
> +		if (test_bit(FC_PT2PT, &vport->fc_flag) &&
>   		    cmd == ELS_CMD_NVMEPRLI) {
>   			switch (stat.un.b.lsRjtRsnCode) {
>   			case LSRJT_UNABLE_TPC:
> @@ -4814,7 +4772,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   						 "support NVME, disabling NVME\n",
>   						 stat.un.b.lsRjtRsnCode);
>   				retry = 0;
> -				vport->fc_flag |= FC_PT2PT_NO_NVME;
> +				set_bit(FC_PT2PT_NO_NVME, &vport->fc_flag);
>   				goto out_retry;
>   			}
>   		}
> @@ -5037,7 +4995,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   
>   			/* If discovery / RSCN timer is running, reset it */
>   			if (timer_pending(&vport->fc_disctmo) ||
> -			    (vport->fc_flag & FC_RSCN_MODE))
> +			    test_bit(FC_RSCN_MODE, &vport->fc_flag))
>   				lpfc_set_disctmo(vport);
>   		}
>   
> @@ -5423,7 +5381,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		if (ulp_status == 0
>   		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
>   			if (!lpfc_unreg_rpi(vport, ndlp) &&
> -			    (!(vport->fc_flag & FC_PT2PT))) {
> +			    !test_bit(FC_PT2PT, &vport->fc_flag)) {
>   				if (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
>   				    ndlp->nlp_state ==
>   				     NLP_STE_REG_LOGIN_ISSUE) {
> @@ -5795,7 +5753,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "0128 Xmit ELS ACC response Status: x%x, IoTag: x%x, "
>   			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
> -			 "RPI: x%x, fc_flag x%x refcnt %d\n",
> +			 "RPI: x%x, fc_flag x%lx refcnt %d\n",
>   			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
>   			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
>   			 ndlp->nlp_rpi, vport->fc_flag, kref_read(&ndlp->kref));
> @@ -6001,7 +5959,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "0152 Xmit EDC ACC response Status: x%x, IoTag: x%x, "
>   			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
> -			 "RPI: x%x, fc_flag x%x\n",
> +			 "RPI: x%x, fc_flag x%lx\n",
>   			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
>   			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
>   			 ndlp->nlp_rpi, vport->fc_flag);
> @@ -6568,7 +6526,6 @@ lpfc_els_rsp_echo_acc(struct lpfc_vport *vport, uint8_t *data,
>   int
>   lpfc_els_disc_adisc(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp, *next_ndlp;
>   	int sentadisc = 0;
>   
> @@ -6603,18 +6560,13 @@ lpfc_els_disc_adisc(struct lpfc_vport *vport)
>   		vport->num_disc_nodes++;
>   		if (vport->num_disc_nodes >=
>   				vport->cfg_discovery_threads) {
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag |= FC_NLP_MORE;
> -			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_NLP_MORE, &vport->fc_flag);
>   			break;
>   		}
>   
>   	}
> -	if (sentadisc == 0) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~FC_NLP_MORE;
> -		spin_unlock_irq(shost->host_lock);
> -	}
> +	if (!sentadisc)
> +		clear_bit(FC_NLP_MORE, &vport->fc_flag);

this should be if (sentadisc == 0).

>   	return sentadisc;
>   }
>   
> @@ -6640,7 +6592,6 @@ lpfc_els_disc_adisc(struct lpfc_vport *vport)
>   int
>   lpfc_els_disc_plogi(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp, *next_ndlp;
>   	int sentplogi = 0;
>   
> @@ -6657,26 +6608,20 @@ lpfc_els_disc_plogi(struct lpfc_vport *vport)
>   			vport->num_disc_nodes++;
>   			if (vport->num_disc_nodes >=
>   					vport->cfg_discovery_threads) {
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag |= FC_NLP_MORE;
> -				spin_unlock_irq(shost->host_lock);
> +				set_bit(FC_NLP_MORE, &vport->fc_flag);
>   				break;
>   			}
>   		}
>   	}
>   
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -			 "6452 Discover PLOGI %d flag x%x\n",
> +			 "6452 Discover PLOGI %d flag x%lx\n",
>   			 sentplogi, vport->fc_flag);
>   
> -	if (sentplogi) {
> +	if (sentplogi)
>   		lpfc_set_disctmo(vport);
> -	}
> -	else {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~FC_NLP_MORE;
> -		spin_unlock_irq(shost->host_lock);
> -	}
> +	else
> +		clear_bit(FC_NLP_MORE, &vport->fc_flag);
>   	return sentplogi;
>   }
>   
> @@ -7087,7 +7032,7 @@ lpfc_rdp_res_attach_port_names(struct fc_rdp_port_name_desc *desc,
>   {
>   
>   	desc->tag = cpu_to_be32(RDP_PORT_NAMES_DESC_TAG);
> -	if (vport->fc_flag & FC_FABRIC) {
> +	if (test_bit(FC_FABRIC, &vport->fc_flag)) {
>   		memcpy(desc->port_names.wwnn, &vport->fabric_nodename,
>   		       sizeof(desc->port_names.wwnn));
>   
> @@ -7871,9 +7816,10 @@ lpfc_els_flush_rscn(struct lpfc_vport *vport)
>   		lpfc_in_buf_free(phba, vport->fc_rscn_id_list[i]);
>   		vport->fc_rscn_id_list[i] = NULL;
>   	}
> +	clear_bit(FC_RSCN_MODE, &vport->fc_flag);
> +	clear_bit(FC_RSCN_DISCOVERY, &vport->fc_flag);
>   	spin_lock_irq(shost->host_lock);
>   	vport->fc_rscn_id_cnt = 0;
> -	vport->fc_flag &= ~(FC_RSCN_MODE | FC_RSCN_DISCOVERY);
>   	spin_unlock_irq(shost->host_lock);
>   	lpfc_can_disctmo(vport);
>   	/* Indicate we are done walking this fc_rscn_id_list */
> @@ -7908,7 +7854,7 @@ lpfc_rscn_payload_check(struct lpfc_vport *vport, uint32_t did)
>   		return 0;
>   
>   	/* If we are doing a FULL RSCN rediscovery, match everything */
> -	if (vport->fc_flag & FC_RSCN_DISCOVERY)
> +	if (test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag))
>   		return did;
>   
>   	spin_lock_irq(shost->host_lock);
> @@ -8087,7 +8033,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	payload_len -= sizeof(uint32_t);	/* take off word 0 */
>   	/* RSCN received */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -			 "0214 RSCN received Data: x%x x%x x%x x%x\n",
> +			 "0214 RSCN received Data: x%lx x%x x%x x%x\n",
>   			 vport->fc_flag, payload_len, *lp,
>   			 vport->fc_rscn_id_cnt);
>   
> @@ -8099,10 +8045,10 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			FCH_EVT_RSCN, lp[i]);
>   
>   	/* Check if RSCN is coming from a direct-connected remote NPort */
> -	if (vport->fc_flag & FC_PT2PT) {
> +	if (test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		/* If so, just ACC it, no other action needed for now */
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
> -				 "2024 pt2pt RSCN %08x Data: x%x x%x\n",
> +				 "2024 pt2pt RSCN %08x Data: x%lx x%x\n",
>   				 *lp, vport->fc_flag, payload_len);
>   		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
>   
> @@ -8146,7 +8092,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			/* ALL NPortIDs in RSCN are on HBA */
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0219 Ignore RSCN "
> -					 "Data: x%x x%x x%x x%x\n",
> +					 "Data: x%lx x%x x%x x%x\n",
>   					 vport->fc_flag, payload_len,
>   					 *lp, vport->fc_rscn_id_cnt);
>   			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
> @@ -8157,7 +8103,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb,
>   				ndlp, NULL);
>   			/* Restart disctmo if its already running */
> -			if (vport->fc_flag & FC_DISC_TMO) {
> +			if (test_bit(FC_DISC_TMO, &vport->fc_flag)) {
>   				tmo = ((phba->fc_ratov * 3) + 3);
>   				mod_timer(&vport->fc_disctmo,
>   					  jiffies +
> @@ -8170,8 +8116,8 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	spin_lock_irq(shost->host_lock);
>   	if (vport->fc_rscn_flush) {
>   		/* Another thread is walking fc_rscn_id_list on this vport */
> -		vport->fc_flag |= FC_RSCN_DISCOVERY;
>   		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_RSCN_DISCOVERY, &vport->fc_flag);
>   		/* Send back ACC */
>   		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
>   		return 0;
> @@ -8184,24 +8130,23 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	/* If we are already processing an RSCN, save the received
>   	 * RSCN payload buffer, cmdiocb->cmd_dmabuf to process later.
>   	 */
> -	if (vport->fc_flag & (FC_RSCN_MODE | FC_NDISC_ACTIVE)) {
> +	if (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
> +	    test_bit(FC_NDISC_ACTIVE, &vport->fc_flag)) {
>   		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
>   			"RCV RSCN defer:  did:x%x/ste:x%x flg:x%x",
>   			ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
>   
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_RSCN_DEFERRED;
> +		set_bit(FC_RSCN_DEFERRED, &vport->fc_flag);
>   
>   		/* Restart disctmo if its already running */
> -		if (vport->fc_flag & FC_DISC_TMO) {
> +		if (test_bit(FC_DISC_TMO, &vport->fc_flag)) {
>   			tmo = ((phba->fc_ratov * 3) + 3);
>   			mod_timer(&vport->fc_disctmo,
>   				  jiffies + msecs_to_jiffies(1000 * tmo));
>   		}
>   		if ((rscn_cnt < FC_MAX_HOLD_RSCN) &&
> -		    !(vport->fc_flag & FC_RSCN_DISCOVERY)) {
> -			vport->fc_flag |= FC_RSCN_MODE;
> -			spin_unlock_irq(shost->host_lock);
> +		    !test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag)) {
> +			set_bit(FC_RSCN_MODE, &vport->fc_flag);
>   			if (rscn_cnt) {
>   				cmd = vport->fc_rscn_id_list[rscn_cnt-1]->virt;
>   				length = be32_to_cpu(*cmd & ~ELS_CMD_MASK);
> @@ -8223,16 +8168,15 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   			/* Deferred RSCN */
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0235 Deferred RSCN "
> -					 "Data: x%x x%x x%x\n",
> +					 "Data: x%x x%lx x%x\n",
>   					 vport->fc_rscn_id_cnt, vport->fc_flag,
>   					 vport->port_state);
>   		} else {
> -			vport->fc_flag |= FC_RSCN_DISCOVERY;
> -			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_RSCN_DISCOVERY, &vport->fc_flag);
>   			/* ReDiscovery RSCN */
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "0234 ReDiscovery RSCN "
> -					 "Data: x%x x%x x%x\n",
> +					 "Data: x%x x%lx x%x\n",
>   					 vport->fc_rscn_id_cnt, vport->fc_flag,
>   					 vport->port_state);
>   		}
> @@ -8248,9 +8192,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   		"RCV RSCN:        did:x%x/ste:x%x flg:x%x",
>   		ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag |= FC_RSCN_MODE;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_RSCN_MODE, &vport->fc_flag);
>   	vport->fc_rscn_id_list[vport->fc_rscn_id_cnt++] = pcmd;
>   	/* Indicate we are done walking fc_rscn_id_list on this vport */
>   	vport->fc_rscn_flush = 0;
> @@ -8300,7 +8242,7 @@ lpfc_els_handle_rscn(struct lpfc_vport *vport)
>   
>   	/* RSCN processed */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> -			 "0215 RSCN processed Data: x%x x%x x%x x%x x%x x%x\n",
> +			 "0215 RSCN processed Data: x%lx x%x x%x x%x x%x x%x\n",
>   			 vport->fc_flag, 0, vport->fc_rscn_id_cnt,
>   			 vport->port_state, vport->num_disc_nodes,
>   			 vport->gidft_inp);
> @@ -8389,7 +8331,7 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	LPFC_MBOXQ_t *mbox;
>   	uint32_t cmd, did;
>   	int rc;
> -	uint32_t fc_flag = 0;
> +	unsigned long fc_flag = 0;
>   	uint32_t port_state = 0;
>   
>   	/* Clear external loopback plug detected flag */
> @@ -8459,9 +8401,7 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   		return 0;
>   
>   	} else if (rc > 0) {	/* greater than */
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_PT2PT_PLOGI;
> -		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_PT2PT_PLOGI, &vport->fc_flag);
>   
>   		/* If we have the high WWPN we can assign our own
>   		 * myDID; otherwise, we have to WAIT for a PLOGI
> @@ -8480,17 +8420,17 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>   	spin_lock_irq(shost->host_lock);
>   	fc_flag = vport->fc_flag;
>   	port_state = vport->port_state;
> -	vport->fc_flag |= FC_PT2PT;
> -	vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> -
>   	/* Acking an unsol FLOGI.  Count 1 for link bounce
>   	 * work-around.
>   	 */
>   	vport->rcv_flogi_cnt++;
>   	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_PT2PT, &vport->fc_flag);
> +	clear_bit(FC_FABRIC, &vport->fc_flag);
> +	clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "3311 Rcv Flogi PS x%x new PS x%x "
> -			 "fc_flag x%x new fc_flag x%x\n",
> +			 "fc_flag x%lx new fc_flag x%lx\n",
>   			 port_state, vport->port_state,
>   			 fc_flag, vport->fc_flag);
>   
> @@ -10428,8 +10368,8 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   		goto dropit;
>   
>   	/* If NPort discovery is delayed drop incoming ELS */
> -	if ((vport->fc_flag & FC_DISC_DELAYED) &&
> -			(cmd != ELS_CMD_PLOGI))
> +	if (test_bit(FC_DISC_DELAYED, &vport->fc_flag) &&
> +	    cmd != ELS_CMD_PLOGI)
>   		goto dropit;
>   
>   	ndlp = lpfc_findnode_did(vport, did);
> @@ -10473,14 +10413,14 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   	/* ELS command <elsCmd> received from NPORT <did> */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "0112 ELS command x%x received from NPORT x%x "
> -			 "refcnt %d Data: x%x x%x x%x x%x\n",
> +			 "refcnt %d Data: x%x x%lx x%x x%x\n",
>   			 cmd, did, kref_read(&ndlp->kref), vport->port_state,
>   			 vport->fc_flag, vport->fc_myDID, vport->fc_prevDID);
>   
>   	/* reject till our FLOGI completes or PLOGI assigned DID via PT2PT */
>   	if ((vport->port_state < LPFC_FABRIC_CFG_LINK) &&
>   	    (cmd != ELS_CMD_FLOGI) &&
> -	    !((cmd == ELS_CMD_PLOGI) && (vport->fc_flag & FC_PT2PT))) {
> +	    !((cmd == ELS_CMD_PLOGI) && test_bit(FC_PT2PT, &vport->fc_flag))) {
>   		rjt_err = LSRJT_LOGICAL_BSY;
>   		rjt_exp = LSEXP_NOTHING_MORE;
>   		goto lsrjt;
> @@ -10495,7 +10435,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   		phba->fc_stat.elsRcvPLOGI++;
>   		ndlp = lpfc_plogi_confirm_nport(phba, payload, ndlp);
>   		if (phba->sli_rev == LPFC_SLI_REV4 &&
> -		    (phba->pport->fc_flag & FC_PT2PT)) {
> +		    test_bit(FC_PT2PT, &phba->pport->fc_flag)) {
>   			vport->fc_prevDID = vport->fc_myDID;
>   			/* Our DID needs to be updated before registering
>   			 * the vfi. This is done in lpfc_rcv_plogi but
> @@ -10513,15 +10453,15 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   		lpfc_send_els_event(vport, ndlp, payload);
>   
>   		/* If Nport discovery is delayed, reject PLOGIs */
> -		if (vport->fc_flag & FC_DISC_DELAYED) {
> +		if (test_bit(FC_DISC_DELAYED, &vport->fc_flag)) {
>   			rjt_err = LSRJT_UNABLE_TPC;
>   			rjt_exp = LSEXP_NOTHING_MORE;
>   			break;
>   		}
>   
>   		if (vport->port_state < LPFC_DISC_AUTH) {
> -			if (!(phba->pport->fc_flag & FC_PT2PT) ||
> -				(phba->pport->fc_flag & FC_PT2PT_PLOGI)) {
> +			if (!test_bit(FC_PT2PT, &phba->pport->fc_flag) ||
> +			    test_bit(FC_PT2PT_PLOGI, &phba->pport->fc_flag)) {
>   				rjt_err = LSRJT_UNABLE_TPC;
>   				rjt_exp = LSEXP_NOTHING_MORE;
>   				break;
> @@ -10547,7 +10487,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   		 * bounce the link.  There is some descrepancy.
>   		 */
>   		if (vport->port_state >= LPFC_LOCAL_CFG_LINK &&
> -		    vport->fc_flag & FC_PT2PT &&
> +		    test_bit(FC_PT2PT, &vport->fc_flag) &&
>   		    vport->rcv_flogi_cnt >= 1) {
>   			rjt_err = LSRJT_LOGICAL_BSY;
>   			rjt_exp = LSEXP_NOTHING_MORE;
> @@ -10670,7 +10610,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   
>   		phba->fc_stat.elsRcvPRLI++;
>   		if ((vport->port_state < LPFC_DISC_AUTH) &&
> -		    (vport->fc_flag & FC_FABRIC)) {
> +		    test_bit(FC_FABRIC, &vport->fc_flag)) {
>   			rjt_err = LSRJT_UNABLE_TPC;
>   			rjt_exp = LSEXP_NOTHING_MORE;
>   			break;
> @@ -10999,16 +10939,13 @@ void
>   lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
>   {
>   	struct lpfc_nodelist *ndlp;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	/*
>   	 * If lpfc_delay_discovery parameter is set and the clean address
>   	 * bit is cleared and fc fabric parameters chenged, delay FC NPort
>   	 * discovery.
>   	 */
> -	spin_lock_irq(shost->host_lock);
> -	if (vport->fc_flag & FC_DISC_DELAYED) {
> -		spin_unlock_irq(shost->host_lock);
> +	if (test_bit(FC_DISC_DELAYED, &vport->fc_flag)) {
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
>   				 "3334 Delay fc port discovery for %d secs\n",
>   				 phba->fc_ratov);
> @@ -11016,7 +10953,6 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
>   			jiffies + msecs_to_jiffies(1000 * phba->fc_ratov));
>   		return;
>   	}
> -	spin_unlock_irq(shost->host_lock);
>   
>   	ndlp = lpfc_findnode_did(vport, NameServer_DID);
>   	if (!ndlp) {
> @@ -11066,14 +11002,12 @@ static void
>   lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   {
>   	struct lpfc_vport *vport = pmb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
> +	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
>   	MAILBOX_t *mb = &pmb->u.mb;
>   	int rc;
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   
>   	if (mb->mbxStatus) {
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
> @@ -11090,16 +11024,13 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   		case 0x9602:	/* Link event since CLEAR_LA */
>   			/* giving up on vport registration */
>   			lpfc_vport_set_state(vport, FC_VPORT_FAILED);
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> -			spin_unlock_irq(shost->host_lock);
> +			clear_bit(FC_FABRIC, &vport->fc_flag);
> +			clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   			lpfc_can_disctmo(vport);
>   			break;
>   		/* If reg_vpi fail with invalid VPI status, re-init VPI */
>   		case 0x20:
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   			lpfc_init_vpi(phba, pmb, vport->vpi);
>   			pmb->vport = vport;
>   			pmb->mbox_cmpl = lpfc_init_vpi_cmpl;
> @@ -11120,13 +11051,11 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   			if (phba->sli_rev == LPFC_SLI_REV4)
>   				lpfc_sli4_unreg_all_rpis(vport);
>   			lpfc_mbx_unreg_vpi(vport);
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   			if (mb->mbxStatus == MBX_NOT_FINISHED)
>   				break;
>   			if ((vport->port_type == LPFC_PHYSICAL_PORT) &&
> -			    !(vport->fc_flag & FC_LOGO_RCVD_DID_CHNG)) {
> +			    !test_bit(FC_LOGO_RCVD_DID_CHNG, &vport->fc_flag)) {
>   				if (phba->sli_rev == LPFC_SLI_REV4)
>   					lpfc_issue_init_vfi(vport);
>   				else
> @@ -11187,7 +11116,6 @@ void
>   lpfc_register_new_vport(struct lpfc_hba *phba, struct lpfc_vport *vport,
>   			struct lpfc_nodelist *ndlp)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	LPFC_MBOXQ_t *mbox;
>   
>   	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
> @@ -11222,9 +11150,7 @@ lpfc_register_new_vport(struct lpfc_hba *phba, struct lpfc_vport *vport,
>   
>   mbox_err_exit:
>   	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	return;
>   }
>   
> @@ -11339,7 +11265,6 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		    struct lpfc_iocbq *rspiocb)
>   {
>   	struct lpfc_vport *vport = cmdiocb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
>   	struct lpfc_nodelist *np;
>   	struct lpfc_nodelist *next_np;
> @@ -11387,13 +11312,11 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   
>   	lpfc_check_nlp_post_devloss(vport, ndlp);
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VPORT_CVL_RCVD;
> -	vport->fc_flag &= ~FC_VPORT_LOGO_RCVD;
> -	vport->fc_flag |= FC_FABRIC;
> +	clear_bit(FC_VPORT_CVL_RCVD, &vport->fc_flag);
> +	clear_bit(FC_VPORT_LOGO_RCVD, &vport->fc_flag);
> +	set_bit(FC_FABRIC, &vport->fc_flag);
>   	if (vport->phba->fc_topology == LPFC_TOPOLOGY_LOOP)
> -		vport->fc_flag |=  FC_PUBLIC_LOOP;
> -	spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   
>   	vport->fc_myDID = ulp_word4 & Mask_DID;
>   	lpfc_vport_set_state(vport, FC_VPORT_ACTIVE);
> @@ -11410,7 +11333,7 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	memcpy(&vport->fabric_nodename, &sp->nodeName,
>   		sizeof(struct lpfc_name));
>   	if (fabric_param_changed &&
> -		!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)) {
> +		!test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag)) {
>   		/* If our NportID changed, we need to ensure all
>   		 * remaining NPORTs get unreg_login'ed so we can
>   		 * issue unreg_vpi.
> @@ -11431,15 +11354,13 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			lpfc_sli4_unreg_all_rpis(vport);
>   
>   		lpfc_mbx_unreg_vpi(vport);
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> +		set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   		if (phba->sli_rev == LPFC_SLI_REV4)
> -			vport->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
> +			set_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   		else
> -			vport->fc_flag |= FC_LOGO_RCVD_DID_CHNG;
> -		spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_LOGO_RCVD_DID_CHNG, &vport->fc_flag);
>   	} else if ((phba->sli_rev == LPFC_SLI_REV4) &&
> -		!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)) {
> +		   !test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag)) {
>   		/*
>   		 * Driver needs to re-reg VPI in order for f/w
>   		 * to update the MAC address.
> @@ -11449,9 +11370,9 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		goto out;
>   	}
>   
> -	if (vport->fc_flag & FC_VPORT_NEEDS_INIT_VPI)
> +	if (test_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag))
>   		lpfc_issue_init_vpi(vport);
> -	else if (vport->fc_flag & FC_VPORT_NEEDS_REG_VPI)
> +	else if (test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag))
>   		lpfc_register_new_vport(phba, vport, ndlp);
>   	else
>   		lpfc_do_scr_ns_plogi(phba, vport);
> @@ -11604,7 +11525,6 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   	struct lpfc_vport *vport = cmdiocb->vport;
>   	IOCB_t *irsp;
>   	struct lpfc_nodelist *ndlp;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	u32 ulp_status, ulp_word4, did, tmo;
>   
>   	ndlp = cmdiocb->ndlp;
> @@ -11635,10 +11555,8 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			 ndlp->fc4_xpt_flags);
>   
>   	if (ulp_status == IOSTAT_SUCCESS) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -		vport->fc_flag &= ~FC_FABRIC;
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
> +		clear_bit(FC_FABRIC, &vport->fc_flag);
>   		lpfc_can_disctmo(vport);
>   	}
>   
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 08acd5d398aa..42695159f697 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -1149,7 +1149,6 @@ lpfc_workq_post_event(struct lpfc_hba *phba, void *arg1, void *arg2,
>   void
>   lpfc_cleanup_rpis(struct lpfc_vport *vport, int remove)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct lpfc_nodelist *ndlp, *next_ndlp;
>   
> @@ -1180,9 +1179,7 @@ lpfc_cleanup_rpis(struct lpfc_vport *vport, int remove)
>   		if (phba->sli_rev == LPFC_SLI_REV4)
>   			lpfc_sli4_unreg_all_rpis(vport);
>   		lpfc_mbx_unreg_vpi(vport);
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	}
>   }
>   
> @@ -1210,7 +1207,7 @@ void
>   lpfc_linkdown_port(struct lpfc_vport *vport)
>   {
>   	struct lpfc_hba *phba = vport->phba;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
> +	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	if (vport->cfg_enable_fc4_type != LPFC_ENABLE_NVME)
>   		fc_host_post_event(shost, fc_get_event_number(),
> @@ -1223,9 +1220,7 @@ lpfc_linkdown_port(struct lpfc_vport *vport)
>   	lpfc_port_link_failure(vport);
>   
>   	/* Stop delayed Nport discovery */
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_DISC_DELAYED;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_DISC_DELAYED, &vport->fc_flag);
>   	del_timer_sync(&vport->delayed_disc_tmo);
>   
>   	if (phba->sli_rev == LPFC_SLI_REV4 &&
> @@ -1240,7 +1235,7 @@ int
>   lpfc_linkdown(struct lpfc_hba *phba)
>   {
>   	struct lpfc_vport *vport = phba->pport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
> +	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_vport **vports;
>   	LPFC_MBOXQ_t          *mb;
>   	int i;
> @@ -1273,9 +1268,7 @@ lpfc_linkdown(struct lpfc_hba *phba)
>   			phba->sli4_hba.link_state.logical_speed =
>   						LPFC_LINK_SPEED_UNKNOWN;
>   		}
> -		spin_lock_irq(shost->host_lock);
> -		phba->pport->fc_flag &= ~FC_LBIT;
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_LBIT, &phba->pport->fc_flag);
>   	}
>   	vports = lpfc_create_vport_work_array(phba);
>   	if (vports != NULL) {
> @@ -1313,7 +1306,7 @@ lpfc_linkdown(struct lpfc_hba *phba)
>   
>    skip_unreg_did:
>   	/* Setup myDID for link up if we are in pt2pt mode */
> -	if (phba->pport->fc_flag & FC_PT2PT) {
> +	if (test_bit(FC_PT2PT, &phba->pport->fc_flag)) {
>   		mb = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
>   		if (mb) {
>   			lpfc_config_link(phba, mb);
> @@ -1324,8 +1317,9 @@ lpfc_linkdown(struct lpfc_hba *phba)
>   				mempool_free(mb, phba->mbox_mem_pool);
>   			}
>   		}
> +		clear_bit(FC_PT2PT, &phba->pport->fc_flag);
> +		clear_bit(FC_PT2PT_PLOGI, &phba->pport->fc_flag);
>   		spin_lock_irq(shost->host_lock);
> -		phba->pport->fc_flag &= ~(FC_PT2PT | FC_PT2PT_PLOGI);
>   		phba->pport->rcv_flogi_cnt = 0;
>   		spin_unlock_irq(shost->host_lock);
>   	}
> @@ -1376,19 +1370,22 @@ lpfc_linkup_port(struct lpfc_vport *vport)
>   		(vport != phba->pport))
>   		return;
>   
> -	if (vport->cfg_enable_fc4_type != LPFC_ENABLE_NVME)
> -		fc_host_post_event(shost, fc_get_event_number(),
> -				   FCH_EVT_LINKUP, 0);
> +	if (phba->defer_flogi_acc_flag) {
> +		clear_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
> +		clear_bit(FC_RSCN_MODE, &vport->fc_flag);
> +		clear_bit(FC_NLP_MORE, &vport->fc_flag);
> +		clear_bit(FC_RSCN_DISCOVERY, &vport->fc_flag);
> +	} else {
> +		clear_bit(FC_PT2PT, &vport->fc_flag);
> +		clear_bit(FC_PT2PT_PLOGI, &vport->fc_flag);
> +		clear_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
> +		clear_bit(FC_RSCN_MODE, &vport->fc_flag);
> +		clear_bit(FC_NLP_MORE, &vport->fc_flag);
> +		clear_bit(FC_RSCN_DISCOVERY, &vport->fc_flag);
> +	}
> +	set_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   
>   	spin_lock_irq(shost->host_lock);
> -	if (phba->defer_flogi_acc_flag)
> -		vport->fc_flag &= ~(FC_ABORT_DISCOVERY | FC_RSCN_MODE |
> -				    FC_NLP_MORE | FC_RSCN_DISCOVERY);
> -	else
> -		vport->fc_flag &= ~(FC_PT2PT | FC_PT2PT_PLOGI |
> -				    FC_ABORT_DISCOVERY | FC_RSCN_MODE |
> -				    FC_NLP_MORE | FC_RSCN_DISCOVERY);
> -	vport->fc_flag |= FC_NDISC_ACTIVE;
>   	vport->fc_ns_retry = 0;
>   	spin_unlock_irq(shost->host_lock);
>   	lpfc_setup_fdmi_mask(vport);
> @@ -1439,7 +1436,6 @@ static void
>   lpfc_mbx_cmpl_clear_la(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   {
>   	struct lpfc_vport *vport = pmb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_sli   *psli = &phba->sli;
>   	MAILBOX_t *mb = &pmb->u.mb;
>   	uint32_t control;
> @@ -1478,9 +1474,7 @@ lpfc_mbx_cmpl_clear_la(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   			 "0225 Device Discovery completes\n");
>   	mempool_free(pmb, phba->mbox_mem_pool);
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_ABORT_DISCOVERY;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
>   
>   	lpfc_can_disctmo(vport);
>   
> @@ -1517,8 +1511,8 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   		return;
>   
>   	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP &&
> -	    vport->fc_flag & FC_PUBLIC_LOOP &&
> -	    !(vport->fc_flag & FC_LBIT)) {
> +	    test_bit(FC_PUBLIC_LOOP, &vport->fc_flag) &&
> +	    !test_bit(FC_LBIT, &vport->fc_flag)) {
>   			/* Need to wait for FAN - use discovery timer
>   			 * for timeout.  port_state is identically
>   			 * LPFC_LOCAL_CFG_LINK while waiting for FAN
> @@ -1560,7 +1554,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   			lpfc_initial_flogi(vport);
>   		}
>   	} else {
> -		if (vport->fc_flag & FC_PT2PT)
> +		if (test_bit(FC_PT2PT, &vport->fc_flag))
>   			lpfc_disc_start(vport);
>   	}
>   	return;
> @@ -1884,7 +1878,7 @@ lpfc_register_fcf(struct lpfc_hba *phba)
>   		phba->fcf.fcf_flag |= (FCF_SCAN_DONE | FCF_IN_USE);
>   		phba->hba_flag &= ~FCF_TS_INPROG;
>   		if (phba->pport->port_state != LPFC_FLOGI &&
> -		    phba->pport->fc_flag & FC_FABRIC) {
> +		    test_bit(FC_FABRIC, &phba->pport->fc_flag)) {
>   			phba->hba_flag |= FCF_RR_INPROG;
>   			spin_unlock_irq(&phba->hbalock);
>   			lpfc_initial_flogi(phba->pport);
> @@ -2742,7 +2736,7 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   				lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
>   						"2836 New FCF matches in-use "
>   						"FCF (x%x), port_state:x%x, "
> -						"fc_flag:x%x\n",
> +						"fc_flag:x%lx\n",
>   						phba->fcf.current_rec.fcf_indx,
>   						phba->pport->port_state,
>   						phba->pport->fc_flag);
> @@ -3218,7 +3212,6 @@ lpfc_init_vpi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   {
>   	struct lpfc_vport *vport = mboxq->vport;
>   	struct lpfc_nodelist *ndlp;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	if (mboxq->u.mb.mbxStatus) {
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
> @@ -3228,9 +3221,7 @@ lpfc_init_vpi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
>   		return;
>   	}
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_INIT_VPI;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   
>   	/* If this port is physical port or FDISC is done, do reg_vpi */
>   	if ((phba->pport == vport) || (vport->port_state == LPFC_FDISC)) {
> @@ -3328,7 +3319,8 @@ lpfc_start_fdiscs(struct lpfc_hba *phba)
>   						     FC_VPORT_LINKDOWN);
>   				continue;
>   			}
> -			if (vports[i]->fc_flag & FC_VPORT_NEEDS_INIT_VPI) {
> +			if (test_bit(FC_VPORT_NEEDS_INIT_VPI,
> +				     &vports[i]->fc_flag)) {
>   				lpfc_issue_init_vpi(vports[i]);
>   				continue;
>   			}
> @@ -3380,17 +3372,17 @@ lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   	 * Unless this was a VFI update and we are in PT2PT mode, then
>   	 * we should drop through to set the port state to ready.
>   	 */
> -	if (vport->fc_flag & FC_VFI_REGISTERED)
> +	if (test_bit(FC_VFI_REGISTERED, &vport->fc_flag))
>   		if (!(phba->sli_rev == LPFC_SLI_REV4 &&
> -		      vport->fc_flag & FC_PT2PT))
> +		      test_bit(FC_PT2PT, &vport->fc_flag)))
>   			goto out_free_mem;
>   
>   	/* The VPI is implicitly registered when the VFI is registered */
> +	set_bit(FC_VFI_REGISTERED, &vport->fc_flag);
> +	clear_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
> +	clear_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   	spin_lock_irq(shost->host_lock);
>   	vport->vpi_state |= LPFC_VPI_REGISTERED;
> -	vport->fc_flag |= FC_VFI_REGISTERED;
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_INIT_VPI;
>   	spin_unlock_irq(shost->host_lock);
>   
>   	/* In case SLI4 FC loopback test, we are ready */
> @@ -3401,8 +3393,8 @@ lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   	}
>   
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
> -			 "3313 cmpl reg vfi  port_state:%x fc_flag:%x myDid:%x "
> -			 "alpacnt:%d LinkState:%x topology:%x\n",
> +			 "3313 cmpl reg vfi  port_state:%x fc_flag:%lx "
> +			 "myDid:%x alpacnt:%d LinkState:%x topology:%x\n",
>   			 vport->port_state, vport->fc_flag, vport->fc_myDID,
>   			 vport->phba->alpa_map[0],
>   			 phba->link_state, phba->fc_topology);
> @@ -3412,14 +3404,14 @@ lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   		 * For private loop or for NPort pt2pt,
>   		 * just start discovery and we are done.
>   		 */
> -		if ((vport->fc_flag & FC_PT2PT) ||
> -		    ((phba->fc_topology == LPFC_TOPOLOGY_LOOP) &&
> -		    !(vport->fc_flag & FC_PUBLIC_LOOP))) {
> +		if (test_bit(FC_PT2PT, &vport->fc_flag) ||
> +		    (phba->fc_topology == LPFC_TOPOLOGY_LOOP &&
> +		    !test_bit(FC_PUBLIC_LOOP, &vport->fc_flag))) {
>   
>   			/* Use loop map to make discovery list */
>   			lpfc_disc_list_loopmap(vport);
>   			/* Start discovery */
> -			if (vport->fc_flag & FC_PT2PT)
> +			if (test_bit(FC_PT2PT, &vport->fc_flag))
>   				vport->port_state = LPFC_VPORT_READY;
>   			else
>   				lpfc_disc_start(vport);
> @@ -3496,11 +3488,9 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
>   {
>   	struct lpfc_vport *vport = phba->pport;
>   	LPFC_MBOXQ_t *sparam_mbox, *cfglink_mbox = NULL;
> -	struct Scsi_Host *shost;
>   	int i;
>   	int rc;
>   	struct fcf_record *fcf_record;
> -	uint32_t fc_flags = 0;
>   	unsigned long iflags;
>   
>   	spin_lock_irqsave(&phba->hbalock, iflags);
> @@ -3537,7 +3527,6 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
>   	phba->fc_topology = bf_get(lpfc_mbx_read_top_topology, la);
>   	phba->link_flag &= ~(LS_NPIV_FAB_SUPPORTED | LS_CT_VEN_RPA);
>   
> -	shost = lpfc_shost_from_vport(vport);
>   	if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
>   		phba->sli3_options &= ~LPFC_SLI3_NPIV_ENABLED;
>   
> @@ -3550,7 +3539,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
>   				"topology\n");
>   				/* Get Loop Map information */
>   		if (bf_get(lpfc_mbx_read_top_il, la))
> -			fc_flags |= FC_LBIT;
> +			set_bit(FC_LBIT, &vport->fc_flag);
>   
>   		vport->fc_myDID = bf_get(lpfc_mbx_read_top_alpa_granted, la);
>   		i = la->lilpBde64.tus.f.bdeSize;
> @@ -3599,16 +3588,10 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
>   				phba->sli3_options |= LPFC_SLI3_NPIV_ENABLED;
>   		}
>   		vport->fc_myDID = phba->fc_pref_DID;
> -		fc_flags |= FC_LBIT;
> +		set_bit(FC_LBIT, &vport->fc_flag);
>   	}
>   	spin_unlock_irqrestore(&phba->hbalock, iflags);
>   
> -	if (fc_flags) {
> -		spin_lock_irqsave(shost->host_lock, iflags);
> -		vport->fc_flag |= fc_flags;
> -		spin_unlock_irqrestore(shost->host_lock, iflags);
> -	}
> -
>   	lpfc_linkup(phba);
>   	sparam_mbox = NULL;
>   
> @@ -3751,13 +3734,11 @@ void
>   lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   {
>   	struct lpfc_vport *vport = pmb->vport;
> -	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_mbx_read_top *la;
>   	struct lpfc_sli_ring *pring;
>   	MAILBOX_t *mb = &pmb->u.mb;
>   	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
>   	uint8_t attn_type;
> -	unsigned long iflags;
>   
>   	/* Unblock ELS traffic */
>   	pring = lpfc_phba_elsring(phba);
> @@ -3779,12 +3760,10 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   
>   	memcpy(&phba->alpa_map[0], mp->virt, 128);
>   
> -	spin_lock_irqsave(shost->host_lock, iflags);
>   	if (bf_get(lpfc_mbx_read_top_pb, la))
> -		vport->fc_flag |= FC_BYPASSED_MODE;
> +		set_bit(FC_BYPASSED_MODE, &vport->fc_flag);
>   	else
> -		vport->fc_flag &= ~FC_BYPASSED_MODE;
> -	spin_unlock_irqrestore(shost->host_lock, iflags);
> +		clear_bit(FC_BYPASSED_MODE, &vport->fc_flag);
>   
>   	if (phba->fc_eventTag <= la->eventTag) {
>   		phba->fc_stat.LinkMultiEvent++;
> @@ -3832,20 +3811,20 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
>   				"1308 Link Down Event in loop back mode "
>   				"x%x received "
> -				"Data: x%x x%x x%x\n",
> +				"Data: x%x x%x x%lx\n",
>   				la->eventTag, phba->fc_eventTag,
>   				phba->pport->port_state, vport->fc_flag);
>   		else if (attn_type == LPFC_ATT_UNEXP_WWPN)
>   			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
>   				"1313 Link Down Unexpected FA WWPN Event x%x "
> -				"received Data: x%x x%x x%x x%x\n",
> +				"received Data: x%x x%x x%lx x%x\n",
>   				la->eventTag, phba->fc_eventTag,
>   				phba->pport->port_state, vport->fc_flag,
>   				bf_get(lpfc_mbx_read_top_fa, la));
>   		else
>   			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
>   				"1305 Link Down Event x%x received "
> -				"Data: x%x x%x x%x x%x\n",
> +				"Data: x%x x%x x%lx x%x\n",
>   				la->eventTag, phba->fc_eventTag,
>   				phba->pport->port_state, vport->fc_flag,
>   				bf_get(lpfc_mbx_read_top_fa, la));
> @@ -3949,9 +3928,10 @@ lpfc_mbx_cmpl_unreg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   			lpfc_workq_post_event(phba, NULL, NULL,
>   				LPFC_EVT_RESET_HBA);
>   	}
> +
> +	set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	spin_lock_irq(shost->host_lock);
>   	vport->vpi_state &= ~LPFC_VPI_REGISTERED;
> -	vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
>   	spin_unlock_irq(shost->host_lock);
>   	mempool_free(pmb, phba->mbox_mem_pool);
>   	lpfc_cleanup_vports_rrqs(vport, NULL);
> @@ -4002,9 +3982,8 @@ lpfc_mbx_cmpl_reg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   				 "0912 cmpl_reg_vpi, mb status = 0x%x\n",
>   				 mb->mbxStatus);
>   		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_FABRIC, &vport->fc_flag);
> +		clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   		vport->fc_myDID = 0;
>   
>   		if ((vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH) ||
> @@ -4017,9 +3996,9 @@ lpfc_mbx_cmpl_reg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   		goto out;
>   	}
>   
> +	clear_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	spin_lock_irq(shost->host_lock);
>   	vport->vpi_state |= LPFC_VPI_REGISTERED;
> -	vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
>   	spin_unlock_irq(shost->host_lock);
>   	vport->num_disc_nodes = 0;
>   	/* go thru NPR list and issue ELS PLOGIs */
> @@ -4027,9 +4006,7 @@ lpfc_mbx_cmpl_reg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   		lpfc_els_disc_plogi(vport);
>   
>   	if (!vport->num_disc_nodes) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   		lpfc_can_disctmo(vport);
>   	}
>   	vport->port_state = LPFC_VPORT_READY;
> @@ -4193,7 +4170,6 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   	struct lpfc_vport *vport = pmb->vport;
>   	MAILBOX_t *mb = &pmb->u.mb;
>   	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
> -	struct Scsi_Host *shost;
>   
>   	pmb->ctx_ndlp = NULL;
>   
> @@ -4232,14 +4208,8 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   	if (vport->port_state == LPFC_FABRIC_CFG_LINK) {
>   		/* when physical port receive logo donot start
>   		 * vport discovery */
> -		if (!(vport->fc_flag & FC_LOGO_RCVD_DID_CHNG))
> +		if (!test_and_clear_bit(FC_LOGO_RCVD_DID_CHNG, &vport->fc_flag))
>   			lpfc_start_fdiscs(phba);
> -		else {
> -			shost = lpfc_shost_from_vport(vport);
> -			spin_lock_irq(shost->host_lock);
> -			vport->fc_flag &= ~FC_LOGO_RCVD_DID_CHNG ;
> -			spin_unlock_irq(shost->host_lock);
> -		}
>   		lpfc_do_scr_ns_plogi(phba, vport);
>   	}
>   
> @@ -4998,7 +4968,6 @@ lpfc_drop_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
>   void
>   lpfc_set_disctmo(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	uint32_t tmo;
>   
> @@ -5020,9 +4989,7 @@ lpfc_set_disctmo(struct lpfc_vport *vport)
>   	}
>   
>   	mod_timer(&vport->fc_disctmo, jiffies + msecs_to_jiffies(1000 * tmo));
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag |= FC_DISC_TMO;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_DISC_TMO, &vport->fc_flag);
>   
>   	/* Start Discovery Timer state <hba_state> */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> @@ -5042,7 +5009,6 @@ lpfc_set_disctmo(struct lpfc_vport *vport)
>   int
>   lpfc_can_disctmo(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	unsigned long iflags;
>   
>   	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
> @@ -5050,11 +5016,9 @@ lpfc_can_disctmo(struct lpfc_vport *vport)
>   		vport->port_state, vport->fc_ns_retry, vport->fc_flag);
>   
>   	/* Turn off discovery timer if its running */
> -	if (vport->fc_flag & FC_DISC_TMO ||
> +	if (test_bit(FC_DISC_TMO, &vport->fc_flag) ||
>   	    timer_pending(&vport->fc_disctmo)) {
> -		spin_lock_irqsave(shost->host_lock, iflags);
> -		vport->fc_flag &= ~FC_DISC_TMO;
> -		spin_unlock_irqrestore(shost->host_lock, iflags);
> +		clear_bit(FC_DISC_TMO, &vport->fc_flag);
>   		del_timer_sync(&vport->fc_disctmo);
>   		spin_lock_irqsave(&vport->work_port_lock, iflags);
>   		vport->work_port_events &= ~WORKER_DISC_TMO;
> @@ -5064,7 +5028,7 @@ lpfc_can_disctmo(struct lpfc_vport *vport)
>   	/* Cancel Discovery Timer state <hba_state> */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   			 "0248 Cancel Discovery Timer state x%x "
> -			 "Data: x%x x%x x%x\n",
> +			 "Data: x%lx x%x x%x\n",
>   			 vport->port_state, vport->fc_flag,
>   			 atomic_read(&vport->fc_plogi_cnt),
>   			 atomic_read(&vport->fc_adisc_cnt));
> @@ -5353,7 +5317,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
>   				acc_plogi = 0;
>   			if (((ndlp->nlp_DID & Fabric_DID_MASK) !=
>   			    Fabric_DID_MASK) &&
> -			    (!(vport->fc_flag & FC_OFFLINE_MODE)))
> +			    (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)))
>   				ndlp->nlp_flag |= NLP_UNREG_INP;
>   
>   			lpfc_printf_vlog(vport, KERN_INFO,
> @@ -5725,7 +5689,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   	if (!ndlp) {
>   		if (vport->phba->nvmet_support)
>   			return NULL;
> -		if ((vport->fc_flag & FC_RSCN_MODE) != 0 &&
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag) &&
>   		    lpfc_rscn_payload_check(vport, did) == 0)
>   			return NULL;
>   		ndlp = lpfc_nlp_init(vport, did);
> @@ -5735,7 +5699,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "6453 Setup New Node 2B_DISC x%x "
> -				 "Data:x%x x%x x%x\n",
> +				 "Data:x%x x%x x%lx\n",
>   				 ndlp->nlp_DID, ndlp->nlp_flag,
>   				 ndlp->nlp_state, vport->fc_flag);
>   
> @@ -5749,8 +5713,8 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   	 * The goal is to allow the target to reset its state and clear
>   	 * pending IO in preparation for the initiator to recover.
>   	 */
> -	if ((vport->fc_flag & FC_RSCN_MODE) &&
> -	    !(vport->fc_flag & FC_NDISC_ACTIVE)) {
> +	if (test_bit(FC_RSCN_MODE, &vport->fc_flag) &&
> +	    !test_bit(FC_NDISC_ACTIVE, &vport->fc_flag)) {
>   		if (lpfc_rscn_payload_check(vport, did)) {
>   
>   			/* Since this node is marked for discovery,
> @@ -5760,7 +5724,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "6455 Setup RSCN Node 2B_DISC x%x "
> -					 "Data:x%x x%x x%x\n",
> +					 "Data:x%x x%x x%lx\n",
>   					 ndlp->nlp_DID, ndlp->nlp_flag,
>   					 ndlp->nlp_state, vport->fc_flag);
>   
> @@ -5784,7 +5748,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   		} else {
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   					 "6456 Skip Setup RSCN Node x%x "
> -					 "Data:x%x x%x x%x\n",
> +					 "Data:x%x x%x x%lx\n",
>   					 ndlp->nlp_DID, ndlp->nlp_flag,
>   					 ndlp->nlp_state, vport->fc_flag);
>   			ndlp = NULL;
> @@ -5792,7 +5756,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
>   	} else {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   				 "6457 Setup Active Node 2B_DISC x%x "
> -				 "Data:x%x x%x x%x\n",
> +				 "Data:x%x x%x x%lx\n",
>   				 ndlp->nlp_DID, ndlp->nlp_flag,
>   				 ndlp->nlp_state, vport->fc_flag);
>   
> @@ -5920,7 +5884,6 @@ lpfc_issue_reg_vpi(struct lpfc_hba *phba, struct lpfc_vport *vport)
>   void
>   lpfc_disc_start(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	uint32_t num_sent;
>   	uint32_t clear_la_pending;
> @@ -5948,7 +5911,7 @@ lpfc_disc_start(struct lpfc_vport *vport)
>   	/* Start Discovery state <hba_state> */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
>   			 "0202 Start Discovery port state x%x "
> -			 "flg x%x Data: x%x x%x x%x\n",
> +			 "flg x%lx Data: x%x x%x x%x\n",
>   			 vport->port_state, vport->fc_flag,
>   			 atomic_read(&vport->fc_plogi_cnt),
>   			 atomic_read(&vport->fc_adisc_cnt),
> @@ -5962,8 +5925,8 @@ lpfc_disc_start(struct lpfc_vport *vport)
>   
>   	/* Register the VPI for SLI3, NPIV only. */
>   	if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
> -	    !(vport->fc_flag & FC_PT2PT) &&
> -	    !(vport->fc_flag & FC_RSCN_MODE) &&
> +	    !test_bit(FC_PT2PT, &vport->fc_flag) &&
> +	    !test_bit(FC_RSCN_MODE, &vport->fc_flag) &&
>   	    (phba->sli_rev < LPFC_SLI_REV4)) {
>   		lpfc_issue_clear_la(phba, vport);
>   		lpfc_issue_reg_vpi(phba, vport);
> @@ -5978,16 +5941,14 @@ lpfc_disc_start(struct lpfc_vport *vport)
>   		/* If we get here, there is nothing to ADISC */
>   		lpfc_issue_clear_la(phba, vport);
>   
> -		if (!(vport->fc_flag & FC_ABORT_DISCOVERY)) {
> +		if (!test_bit(FC_ABORT_DISCOVERY, &vport->fc_flag)) {
>   			vport->num_disc_nodes = 0;
>   			/* go thru NPR nodes and issue ELS PLOGIs */
>   			if (atomic_read(&vport->fc_npr_cnt))
>   				lpfc_els_disc_plogi(vport);
>   
>   			if (!vport->num_disc_nodes) {
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -				spin_unlock_irq(shost->host_lock);
> +				clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   				lpfc_can_disctmo(vport);
>   			}
>   		}
> @@ -5999,18 +5960,17 @@ lpfc_disc_start(struct lpfc_vport *vport)
>   		if (num_sent)
>   			return;
>   
> -		if (vport->fc_flag & FC_RSCN_MODE) {
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   			/* Check to see if more RSCNs came in while we
>   			 * were processing this one.
>   			 */
> -			if ((vport->fc_rscn_id_cnt == 0) &&
> -			    (!(vport->fc_flag & FC_RSCN_DISCOVERY))) {
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag &= ~FC_RSCN_MODE;
> -				spin_unlock_irq(shost->host_lock);
> +			if (vport->fc_rscn_id_cnt == 0 &&
> +			    !test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag)) {
> +				clear_bit(FC_RSCN_MODE, &vport->fc_flag);
>   				lpfc_can_disctmo(vport);
> -			} else
> +			} else {
>   				lpfc_els_handle_rscn(vport);
> +			}
>   		}
>   	}
>   	return;
> @@ -6159,20 +6119,15 @@ lpfc_disc_timeout(struct timer_list *t)
>   static void
>   lpfc_disc_timeout_handler(struct lpfc_vport *vport)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba  *phba = vport->phba;
>   	struct lpfc_sli  *psli = &phba->sli;
>   	struct lpfc_nodelist *ndlp, *next_ndlp;
>   	LPFC_MBOXQ_t *initlinkmbox;
>   	int rc, clrlaerr = 0;
>   
> -	if (!(vport->fc_flag & FC_DISC_TMO))
> +	if (!test_and_clear_bit(FC_DISC_TMO, &vport->fc_flag))
>   		return;
>   
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag &= ~FC_DISC_TMO;
> -	spin_unlock_irq(shost->host_lock);
> -
>   	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
>   		"disc timeout:    state:x%x rtry:x%x flg:x%x",
>   		vport->port_state, vport->fc_ns_retry, vport->fc_flag);
> @@ -6326,7 +6281,7 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
>   		break;
>   
>   	case LPFC_VPORT_READY:
> -		if (vport->fc_flag & FC_RSCN_MODE) {
> +		if (test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
>   			lpfc_printf_vlog(vport, KERN_ERR,
>   					 LOG_TRACE_EVENT,
>   					 "0231 RSCN timeout Data: x%x "
> @@ -6758,7 +6713,7 @@ lpfc_fcf_inuse(struct lpfc_hba *phba)
>   		 * If dev_loss fires while we are waiting we do not want to
>   		 * unreg the fcf.
>   		 */
> -		if (!(vports[i]->fc_flag & FC_VPORT_CVL_RCVD)) {
> +		if (!test_bit(FC_VPORT_CVL_RCVD, &vports[i]->fc_flag)) {
>   			ret =  1;
>   			goto out;
>   		}
> @@ -6798,7 +6753,6 @@ void
>   lpfc_unregister_vfi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   {
>   	struct lpfc_vport *vport = mboxq->vport;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	if (mboxq->u.mb.mbxStatus) {
>   		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
> @@ -6806,9 +6760,7 @@ lpfc_unregister_vfi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
>   				"HBA state x%x\n",
>   				mboxq->u.mb.mbxStatus, vport->port_state);
>   	}
> -	spin_lock_irq(shost->host_lock);
> -	phba->pport->fc_flag &= ~FC_VFI_REGISTERED;
> -	spin_unlock_irq(shost->host_lock);
> +	clear_bit(FC_VFI_REGISTERED, &phba->pport->fc_flag);
>   	mempool_free(mboxq, phba->mbox_mem_pool);
>   	return;
>   }
> @@ -6872,9 +6824,9 @@ lpfc_unregister_fcf_prep(struct lpfc_hba *phba)
>   			lpfc_mbx_unreg_vpi(vports[i]);
>   			shost = lpfc_shost_from_vport(vports[i]);
>   			spin_lock_irq(shost->host_lock);
> -			vports[i]->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
>   			vports[i]->vpi_state &= ~LPFC_VPI_REGISTERED;
>   			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_VPORT_NEEDS_INIT_VPI, &vports[i]->fc_flag);
>   		}
>   	lpfc_destroy_vport_work_array(phba, vports);
>   	if (i == 0 && (!(phba->sli3_options & LPFC_SLI3_NPIV_ENABLED))) {
> @@ -6887,9 +6839,9 @@ lpfc_unregister_fcf_prep(struct lpfc_hba *phba)
>   		lpfc_mbx_unreg_vpi(phba->pport);
>   		shost = lpfc_shost_from_vport(phba->pport);
>   		spin_lock_irq(shost->host_lock);
> -		phba->pport->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
>   		phba->pport->vpi_state &= ~LPFC_VPI_REGISTERED;
>   		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_VPORT_NEEDS_INIT_VPI, &phba->pport->fc_flag);
>   	}
>   
>   	/* Cleanup any outstanding ELS commands */
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index c43118fab4aa..a71171669972 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -1269,9 +1269,9 @@ lpfc_hb_mbox_cmpl(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq)
>   
>   	/* Check and reset heart-beat timer if necessary */
>   	mempool_free(pmboxq, phba->mbox_mem_pool);
> -	if (!(phba->pport->fc_flag & FC_OFFLINE_MODE) &&
> -		!(phba->link_state == LPFC_HBA_ERROR) &&
> -		!(phba->pport->load_flag & FC_UNLOADING))
> +	if (!test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag) &&
> +	    !(phba->link_state == LPFC_HBA_ERROR) &&
> +	    !(phba->pport->load_flag & FC_UNLOADING))
>   		mod_timer(&phba->hb_tmofunc,
>   			  jiffies +
>   			  msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
> @@ -1302,7 +1302,7 @@ lpfc_idle_stat_delay_work(struct work_struct *work)
>   		return;
>   
>   	if (phba->link_state == LPFC_HBA_ERROR ||
> -	    phba->pport->fc_flag & FC_OFFLINE_MODE ||
> +	    test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag) ||
>   	    phba->cmf_active_mode != LPFC_CFG_OFF)
>   		goto requeue;
>   
> @@ -1363,7 +1363,7 @@ lpfc_hb_eq_delay_work(struct work_struct *work)
>   		return;
>   
>   	if (phba->link_state == LPFC_HBA_ERROR ||
> -	    phba->pport->fc_flag & FC_OFFLINE_MODE)
> +	    test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		goto requeue;
>   
>   	ena_delay = kcalloc(phba->sli4_hba.num_possible_cpu, sizeof(*ena_delay),
> @@ -1536,7 +1536,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
>   
>   	if ((phba->link_state == LPFC_HBA_ERROR) ||
>   		(phba->pport->load_flag & FC_UNLOADING) ||
> -		(phba->pport->fc_flag & FC_OFFLINE_MODE))
> +		test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		return;
>   
>   	if (phba->elsbuf_cnt &&
> @@ -3698,7 +3698,7 @@ lpfc_online(struct lpfc_hba *phba)
>   		return 0;
>   	vport = phba->pport;
>   
> -	if (!(vport->fc_flag & FC_OFFLINE_MODE))
> +	if (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
>   		return 0;
>   
>   	lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
> @@ -3738,20 +3738,18 @@ lpfc_online(struct lpfc_hba *phba)
>   	vports = lpfc_create_vport_work_array(phba);
>   	if (vports != NULL) {
>   		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
> -			struct Scsi_Host *shost;
> -			shost = lpfc_shost_from_vport(vports[i]);
> -			spin_lock_irq(shost->host_lock);
> -			vports[i]->fc_flag &= ~FC_OFFLINE_MODE;
> +			clear_bit(FC_OFFLINE_MODE, &vports[i]->fc_flag);
>   			if (phba->sli3_options & LPFC_SLI3_NPIV_ENABLED)
> -				vports[i]->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> +				set_bit(FC_VPORT_NEEDS_REG_VPI,
> +					&vports[i]->fc_flag);
>   			if (phba->sli_rev == LPFC_SLI_REV4) {
> -				vports[i]->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
> +				set_bit(FC_VPORT_NEEDS_INIT_VPI,
> +					&vports[i]->fc_flag);
>   				if ((vpis_cleared) &&
>   				    (vports[i]->port_type !=
>   					LPFC_PHYSICAL_PORT))
>   					vports[i]->vpi = 0;
>   			}
> -			spin_unlock_irq(shost->host_lock);
>   		}
>   	}
>   	lpfc_destroy_vport_work_array(phba, vports);
> @@ -3806,7 +3804,7 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
>   	int offline;
>   	bool hba_pci_err;
>   
> -	if (vport->fc_flag & FC_OFFLINE_MODE)
> +	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
>   		return;
>   
>   	lpfc_block_mgmt_io(phba, mbx_action);
> @@ -3825,9 +3823,9 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
>   			shost = lpfc_shost_from_vport(vports[i]);
>   			spin_lock_irq(shost->host_lock);
>   			vports[i]->vpi_state &= ~LPFC_VPI_REGISTERED;
> -			vports[i]->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -			vports[i]->fc_flag &= ~FC_VFI_REGISTERED;
>   			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_VPORT_NEEDS_REG_VPI, &vports[i]->fc_flag);
> +			clear_bit(FC_VFI_REGISTERED, &vports[i]->fc_flag);
>   
>   			list_for_each_entry_safe(ndlp, next_ndlp,
>   						 &vports[i]->fc_nodes,
> @@ -3910,7 +3908,7 @@ lpfc_offline(struct lpfc_hba *phba)
>   	struct lpfc_vport **vports;
>   	int i;
>   
> -	if (phba->pport->fc_flag & FC_OFFLINE_MODE)
> +	if (test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		return;
>   
>   	/* stop port and all timers associated with this hba */
> @@ -3941,14 +3939,14 @@ lpfc_offline(struct lpfc_hba *phba)
>   			shost = lpfc_shost_from_vport(vports[i]);
>   			spin_lock_irq(shost->host_lock);
>   			vports[i]->work_port_events = 0;
> -			vports[i]->fc_flag |= FC_OFFLINE_MODE;
>   			spin_unlock_irq(shost->host_lock);
> +			set_bit(FC_OFFLINE_MODE, &vports[i]->fc_flag);
>   		}
>   	lpfc_destroy_vport_work_array(phba, vports);
>   	/* If OFFLINE flag is clear (i.e. unloading), cpuhp removal is handled
>   	 * in hba_unset
>   	 */
> -	if (phba->pport->fc_flag & FC_OFFLINE_MODE)
> +	if (test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		__lpfc_cpuhp_remove(phba);
>   
>   	if (phba->cfg_xri_rebalancing)
> @@ -4767,7 +4765,7 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
>   	vport = (struct lpfc_vport *) shost->hostdata;
>   	vport->phba = phba;
>   	vport->load_flag |= FC_LOADING;
> -	vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> +	set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	vport->fc_rscn_flush = 0;
>   	atomic_set(&vport->fc_plogi_cnt, 0);
>   	atomic_set(&vport->fc_adisc_cnt, 0);
> @@ -6704,9 +6702,7 @@ lpfc_sli4_perform_vport_cvl(struct lpfc_vport *vport)
>   		return NULL;
>   	lpfc_linkdown_port(vport);
>   	lpfc_cleanup_pending_mbox(vport);
> -	spin_lock_irq(shost->host_lock);
> -	vport->fc_flag |= FC_VPORT_CVL_RCVD;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_VPORT_CVL_RCVD, &vport->fc_flag);
>   
>   	return ndlp;
>   }
> @@ -6903,9 +6899,9 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
>   		if (vports) {
>   			for (i = 0; i <= phba->max_vports && vports[i] != NULL;
>   					i++) {
> -				if ((!(vports[i]->fc_flag &
> -					FC_VPORT_CVL_RCVD)) &&
> -					(vports[i]->port_state > LPFC_FDISC)) {
> +				if (!test_bit(FC_VPORT_CVL_RCVD,
> +					      &vports[i]->fc_flag) &&
> +				    vports[i]->port_state > LPFC_FDISC) {
>   					active_vlink_present = 1;
>   					break;
>   				}
> @@ -12783,7 +12779,8 @@ static void __lpfc_cpuhp_remove(struct lpfc_hba *phba)
>   
>   static void lpfc_cpuhp_remove(struct lpfc_hba *phba)
>   {
> -	if (phba->pport && (phba->pport->fc_flag & FC_OFFLINE_MODE))
> +	if (phba->pport &&
> +	    test_bit(FC_OFFLINE_MODE, &phba->pport->fc_flag))
>   		return;
>   
>   	__lpfc_cpuhp_remove(phba);
> diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
> index cadcd16494e1..162a0df8b60e 100644
> --- a/drivers/scsi/lpfc/lpfc_mbox.c
> +++ b/drivers/scsi/lpfc/lpfc_mbox.c
> @@ -949,7 +949,7 @@ lpfc_reg_vpi(struct lpfc_vport *vport, LPFC_MBOXQ_t *pmb)
>   	 * Set the re-reg VPI bit for f/w to update the MAC address.
>   	 */
>   	if ((phba->sli_rev == LPFC_SLI_REV4) &&
> -		!(vport->fc_flag & FC_VPORT_NEEDS_REG_VPI))
> +		!test_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag))
>   		mb->un.varRegVpi.upd = 1;
>   
>   	mb->un.varRegVpi.vpi = phba->vpi_ids[vport->vpi];
> @@ -2244,7 +2244,7 @@ lpfc_reg_vfi(struct lpfcMboxq *mbox, struct lpfc_vport *vport, dma_addr_t phys)
>   
>   	/* Only FC supports upd bit */
>   	if ((phba->sli4_hba.lnk_info.lnk_tp == LPFC_LNK_TYPE_FC) &&
> -	    (vport->fc_flag & FC_VFI_REGISTERED) &&
> +	    test_bit(FC_VFI_REGISTERED, &vport->fc_flag) &&
>   	    (!phba->fc_topology_changed))
>   		bf_set(lpfc_reg_vfi_upd, reg_vfi, 1);
>   
> @@ -2271,8 +2271,8 @@ lpfc_reg_vfi(struct lpfcMboxq *mbox, struct lpfc_vport *vport, dma_addr_t phys)
>   	}
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_MBOX,
>   			"3134 Register VFI, mydid:x%x, fcfi:%d, "
> -			" vfi:%d, vpi:%d, fc_pname:%x%x fc_flag:x%x"
> -			" port_state:x%x topology chg:%d bbscn_fabric :%d\n",
> +			"vfi:%d, vpi:%d, fc_pname:%x%x fc_flag:x%lx "
> +			"port_state:x%x topology chg:%d bbscn_fabric :%d\n",
>   			vport->fc_myDID,
>   			phba->fcf.fcfi,
>   			phba->sli4_hba.vfi_ids[vport->vfi],
> diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
> index 0bc93f346d90..ab9b3585492c 100644
> --- a/drivers/scsi/lpfc/lpfc_nportdisc.c
> +++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
> @@ -382,7 +382,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	/* PLOGI chkparm OK */
>   	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
>   			 "0114 PLOGI chkparm OK Data: x%x x%x x%x "
> -			 "x%x x%x x%x\n",
> +			 "x%x x%x x%lx\n",
>   			 ndlp->nlp_DID, ndlp->nlp_state, ndlp->nlp_flag,
>   			 ndlp->nlp_rpi, vport->port_state,
>   			 vport->fc_flag);
> @@ -464,8 +464,8 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	save_iocb = NULL;
>   
>   	/* Check for Nport to NPort pt2pt protocol */
> -	if ((vport->fc_flag & FC_PT2PT) &&
> -	    !(vport->fc_flag & FC_PT2PT_PLOGI)) {
> +	if (test_bit(FC_PT2PT, &vport->fc_flag) &&
> +	    !test_bit(FC_PT2PT_PLOGI, &vport->fc_flag)) {
>   		/* rcv'ed PLOGI decides what our NPortId will be */
>   		if (phba->sli_rev == LPFC_SLI_REV4) {
>   			vport->fc_myDID = bf_get(els_rsp64_sid,
> @@ -580,7 +580,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	 * This only applies to a fabric environment.
>   	 */
>   	if ((ndlp->nlp_state == NLP_STE_PLOGI_ISSUE) &&
> -	    (vport->fc_flag & FC_FABRIC)) {
> +	    test_bit(FC_FABRIC, &vport->fc_flag)) {
>   		/* software abort outstanding PLOGI */
>   		lpfc_els_abort(phba, ndlp);
>   	}
> @@ -804,7 +804,6 @@ static int
>   lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	      struct lpfc_iocbq *cmdiocb, uint32_t els_cmd)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba    *phba = vport->phba;
>   	struct lpfc_vport **vports;
>   	int i, active_vlink_present = 0 ;
> @@ -837,19 +836,17 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   
>   	if (ndlp->nlp_DID == Fabric_DID) {
>   		if (vport->port_state <= LPFC_FDISC ||
> -		    vport->fc_flag & FC_PT2PT)
> +		    test_bit(FC_PT2PT, &vport->fc_flag))
>   			goto out;
>   		lpfc_linkdown_port(vport);
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_VPORT_LOGO_RCVD;
> -		spin_unlock_irq(shost->host_lock);
> +		set_bit(FC_VPORT_LOGO_RCVD, &vport->fc_flag);
>   		vports = lpfc_create_vport_work_array(phba);
>   		if (vports) {
>   			for (i = 0; i <= phba->max_vports && vports[i] != NULL;
>   					i++) {
> -				if ((!(vports[i]->fc_flag &
> -					FC_VPORT_LOGO_RCVD)) &&
> -					(vports[i]->port_state > LPFC_FDISC)) {
> +				if (!test_bit(FC_VPORT_LOGO_RCVD,
> +					      &vports[i]->fc_flag) &&
> +				    vports[i]->port_state > LPFC_FDISC) {
>   					active_vlink_present = 1;
>   					break;
>   				}
> @@ -876,23 +873,21 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
>   			vport->port_state = LPFC_FDISC;
>   		} else {
> -			spin_lock_irq(shost->host_lock);
> -			phba->pport->fc_flag &= ~FC_LOGO_RCVD_DID_CHNG;
> -			spin_unlock_irq(shost->host_lock);
> +			clear_bit(FC_LOGO_RCVD_DID_CHNG, &phba->pport->fc_flag);
>   			lpfc_retry_pport_discovery(phba);
>   		}
>   	} else {
>   		lpfc_printf_vlog(vport, KERN_INFO,
>   				 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
>   				 "3203 LOGO recover nport x%06x state x%x "
> -				 "ntype x%x fc_flag x%x\n",
> +				 "ntype x%x fc_flag x%lx\n",
>   				 ndlp->nlp_DID, ndlp->nlp_state,
>   				 ndlp->nlp_type, vport->fc_flag);
>   
>   		/* Special cases for rports that recover post LOGO. */
>   		if ((!(ndlp->nlp_type == NLP_FABRIC) &&
>   		     (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET) ||
> -		      vport->fc_flag & FC_PT2PT)) ||
> +		      test_bit(FC_PT2PT, &vport->fc_flag))) ||
>   		    (ndlp->nlp_state >= NLP_STE_ADISC_ISSUE ||
>   		     ndlp->nlp_state <= NLP_STE_PRLI_ISSUE)) {
>   			mod_timer(&ndlp->nlp_delayfunc,
> @@ -1057,9 +1052,10 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
>   		return 0;
>   	}
>   
> -	if (!(vport->fc_flag & FC_PT2PT)) {
> +	if (!test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		/* Check config parameter use-adisc or FCP-2 */
> -		if (vport->cfg_use_adisc && ((vport->fc_flag & FC_RSCN_MODE) ||
> +		if (vport->cfg_use_adisc &&
> +		    (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
>   		    ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) &&
>   		     (ndlp->nlp_type & NLP_FCP_TARGET)))) {
>   			spin_lock_irq(&ndlp->lock);
> @@ -1123,7 +1119,7 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
>   		}
>   
>   		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
> -		    (!(vport->fc_flag & FC_OFFLINE_MODE)))
> +		    (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)))
>   			ndlp->nlp_flag |= NLP_UNREG_INP;
>   
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
> @@ -1246,7 +1242,6 @@ static uint32_t
>   lpfc_rcv_plogi_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			   void *arg, uint32_t evt)
>   {
> -	struct Scsi_Host   *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_hba   *phba = vport->phba;
>   	struct lpfc_iocbq *cmdiocb = arg;
>   	struct lpfc_dmabuf *pcmd = cmdiocb->cmd_dmabuf;
> @@ -1281,9 +1276,7 @@ lpfc_rcv_plogi_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			/* Check if there are more PLOGIs to be sent */
>   			lpfc_more_plogi(vport);
>   			if (vport->num_disc_nodes == 0) {
> -				spin_lock_irq(shost->host_lock);
> -				vport->fc_flag &= ~FC_NDISC_ACTIVE;
> -				spin_unlock_irq(shost->host_lock);
> +				clear_bit(FC_NDISC_ACTIVE, &vport->fc_flag);
>   				lpfc_can_disctmo(vport);
>   				lpfc_end_rscn(vport);
>   			}
> @@ -1423,8 +1416,8 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
>   	ndlp->nlp_maxframe =
>   		((sp->cmn.bbRcvSizeMsb & 0x0F) << 8) | sp->cmn.bbRcvSizeLsb;
>   
> -	if ((vport->fc_flag & FC_PT2PT) &&
> -	    (vport->fc_flag & FC_PT2PT_PLOGI)) {
> +	if (test_bit(FC_PT2PT, &vport->fc_flag) &&
> +	    test_bit(FC_PT2PT_PLOGI, &vport->fc_flag)) {
>   		ed_tov = be32_to_cpu(sp->cmn.e_d_tov);
>   		if (sp->cmn.edtovResolution) {
>   			/* E_D_TOV ticks are in nanoseconds */
> @@ -1615,7 +1608,7 @@ lpfc_device_recov_plogi_issue(struct lpfc_vport *vport,
>   	/* Don't do anything that will mess up processing of the
>   	 * previous RSCN.
>   	 */
> -	if (vport->fc_flag & FC_RSCN_DEFERRED)
> +	if (test_bit(FC_RSCN_DEFERRED, &vport->fc_flag))
>   		return ndlp->nlp_state;
>   
>   	/* software abort outstanding PLOGI */
> @@ -1801,7 +1794,7 @@ lpfc_device_recov_adisc_issue(struct lpfc_vport *vport,
>   	/* Don't do anything that will mess up processing of the
>   	 * previous RSCN.
>   	 */
> -	if (vport->fc_flag & FC_RSCN_DEFERRED)
> +	if (test_bit(FC_RSCN_DEFERRED, &vport->fc_flag))
>   		return ndlp->nlp_state;
>   
>   	/* software abort outstanding ADISC */
> @@ -1991,13 +1984,13 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
>   		 * know what PRLI to send yet.  Figure that out now and
>   		 * call PRLI depending on the outcome.
>   		 */
> -		if (vport->fc_flag & FC_PT2PT) {
> +		if (test_bit(FC_PT2PT, &vport->fc_flag)) {
>   			/* If we are pt2pt, there is no Fabric to determine
>   			 * the FC4 type of the remote nport. So if NVME
>   			 * is configured try it.
>   			 */
>   			ndlp->nlp_fc4_type |= NLP_FC4_FCP;
> -			if ((!(vport->fc_flag & FC_PT2PT_NO_NVME)) &&
> +			if ((!test_bit(FC_PT2PT_NO_NVME, &vport->fc_flag)) &&
>   			    (vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH ||
>   			    vport->cfg_enable_fc4_type == LPFC_ENABLE_NVME)) {
>   				ndlp->nlp_fc4_type |= NLP_FC4_NVME;
> @@ -2029,7 +2022,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
>   			lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
>   		}
>   	} else {
> -		if ((vport->fc_flag & FC_PT2PT) && phba->nvmet_support)
> +		if (test_bit(FC_PT2PT, &vport->fc_flag) && phba->nvmet_support)
>   			phba->targetport->port_id = vport->fc_myDID;
>   
>   		/* Only Fabric ports should transition. NVME target
> @@ -2070,7 +2063,7 @@ lpfc_device_recov_reglogin_issue(struct lpfc_vport *vport,
>   	/* Don't do anything that will mess up processing of the
>   	 * previous RSCN.
>   	 */
> -	if (vport->fc_flag & FC_RSCN_DEFERRED)
> +	if (test_bit(FC_RSCN_DEFERRED, &vport->fc_flag))
>   		return ndlp->nlp_state;
>   
>   	ndlp->nlp_prev_state = NLP_STE_REG_LOGIN_ISSUE;
> @@ -2386,7 +2379,7 @@ lpfc_device_recov_prli_issue(struct lpfc_vport *vport,
>   	/* Don't do anything that will mess up processing of the
>   	 * previous RSCN.
>   	 */
> -	if (vport->fc_flag & FC_RSCN_DEFERRED)
> +	if (test_bit(FC_RSCN_DEFERRED, &vport->fc_flag))
>   		return ndlp->nlp_state;
>   
>   	/* software abort outstanding PRLI */
> @@ -2830,13 +2823,10 @@ static uint32_t
>   lpfc_cmpl_logo_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   			void *arg, uint32_t evt)
>   {
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
> -
>   	/* For the fabric port just clear the fc flags. */
>   	if (ndlp->nlp_DID == Fabric_DID) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag &= ~(FC_FABRIC | FC_PUBLIC_LOOP);
> -		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_FABRIC, &vport->fc_flag);
> +		clear_bit(FC_PUBLIC_LOOP, &vport->fc_flag);
>   	}
>   	lpfc_unreg_rpi(vport, ndlp);
>   	return ndlp->nlp_state;
> @@ -2908,7 +2898,7 @@ lpfc_device_recov_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
>   	/* Don't do anything that will mess up processing of the
>   	 * previous RSCN.
>   	 */
> -	if (vport->fc_flag & FC_RSCN_DEFERRED)
> +	if (test_bit(FC_RSCN_DEFERRED, &vport->fc_flag))
>   		return ndlp->nlp_state;
>   
>   	lpfc_cancel_retry_delay_tmo(vport, ndlp);
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 29fd2eda70d5..4b21c4d33533 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -2909,8 +2909,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
>   		shost = lpfc_shost_from_vport(vport);
>   		spin_lock_irq(shost->host_lock);
>   		vport->vpi_state |= LPFC_VPI_REGISTERED;
> -		vport->fc_flag &= ~FC_VPORT_NEEDS_REG_VPI;
>   		spin_unlock_irq(shost->host_lock);
> +		clear_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   	}
>   
>   	if (pmb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
> @@ -10888,7 +10888,7 @@ __lpfc_sli_prep_els_req_rsp_s4(struct lpfc_iocbq *cmdiocbq,
>   	 * all ELS pt2pt protocol traffic as well.
>   	 */
>   	if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) ||
> -	    (vport->fc_flag & FC_PT2PT)) {
> +	    test_bit(FC_PT2PT, &vport->fc_flag)) {
>   		if (expect_rsp) {
>   			bf_set(els_req64_sid, &wqe->els_req, vport->fc_myDID);
>   
> @@ -18552,8 +18552,8 @@ lpfc_fc_frame_to_vport(struct lpfc_hba *phba, struct fc_frame_header *fc_hdr,
>   
>   	if (did == Fabric_DID)
>   		return phba->pport;
> -	if ((phba->pport->fc_flag & FC_PT2PT) &&
> -		!(phba->link_state == LPFC_HBA_READY))
> +	if (test_bit(FC_PT2PT, &phba->pport->fc_flag) &&
> +	    phba->link_state != LPFC_HBA_READY)
>   		return phba->pport;
>   
>   	vports = lpfc_create_vport_work_array(phba);
> @@ -19507,8 +19507,8 @@ lpfc_sli4_handle_received_buffer(struct lpfc_hba *phba,
>   		 * The pt2pt protocol allows for discovery frames
>   		 * to be received without a registered VPI.
>   		 */
> -		if (!(vport->fc_flag & FC_PT2PT) ||
> -			(phba->link_state == LPFC_HBA_READY)) {
> +		if (!test_bit(FC_PT2PT, &vport->fc_flag) ||
> +		    phba->link_state == LPFC_HBA_READY) {
>   			lpfc_in_buf_free(phba, &dmabuf->dbuf);
>   			return;
>   		}
> @@ -22666,7 +22666,7 @@ lpfc_sli_prep_wqe(struct lpfc_hba *phba, struct lpfc_iocbq *job)
>   		if_type = bf_get(lpfc_sli_intf_if_type,
>   				 &phba->sli4_hba.sli_intf);
>   		if (if_type >= LPFC_SLI_INTF_IF_TYPE_2) {
> -			if (job->vport->fc_flag & FC_PT2PT) {
> +			if (test_bit(FC_PT2PT, &job->vport->fc_flag)) {
>   				bf_set(els_rsp64_sp, &wqe->xmit_els_rsp, 1);
>   				bf_set(els_rsp64_sid, &wqe->xmit_els_rsp,
>   				       job->vport->fc_myDID);
> diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
> index 6c7559cf1a4b..e2e0518e8387 100644
> --- a/drivers/scsi/lpfc/lpfc_vport.c
> +++ b/drivers/scsi/lpfc/lpfc_vport.c
> @@ -238,13 +238,9 @@ lpfc_unique_wwpn(struct lpfc_hba *phba, struct lpfc_vport *new_vport)
>   static void lpfc_discovery_wait(struct lpfc_vport *vport)
>   {
>   	struct lpfc_hba *phba = vport->phba;
> -	uint32_t wait_flags = 0;
>   	unsigned long wait_time_max;
>   	unsigned long start_time;
>   
> -	wait_flags = FC_RSCN_MODE | FC_RSCN_DISCOVERY | FC_NLP_MORE |
> -		     FC_RSCN_DEFERRED | FC_NDISC_ACTIVE | FC_DISC_TMO;
> -
>   	/*
>   	 * The time constraint on this loop is a balance between the
>   	 * fabric RA_TOV value and dev_loss tmo.  The driver's
> @@ -255,14 +251,19 @@ static void lpfc_discovery_wait(struct lpfc_vport *vport)
>   	start_time = jiffies;
>   	while (time_before(jiffies, wait_time_max)) {
>   		if ((vport->num_disc_nodes > 0)    ||
> -		    (vport->fc_flag & wait_flags)  ||
> +		    test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
> +		    test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag) ||
> +		    test_bit(FC_NLP_MORE, &vport->fc_flag) ||
> +		    test_bit(FC_RSCN_DEFERRED, &vport->fc_flag) ||
> +		    test_bit(FC_NDISC_ACTIVE, &vport->fc_flag) ||
> +		    test_bit(FC_DISC_TMO, &vport->fc_flag) ||
>   		    ((vport->port_state > LPFC_VPORT_FAILED) &&
>   		     (vport->port_state < LPFC_VPORT_READY))) {
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT,
> -					"1833 Vport discovery quiesce Wait:"
> -					" state x%x fc_flags x%x"
> -					" num_nodes x%x, waiting 1000 msecs"
> -					" total wait msecs x%x\n",
> +					"1833 Vport discovery quiesce Wait: "
> +					"state x%x fc_flags x%lx "
> +					"num_nodes x%x, waiting 1000 msecs "
> +					"total wait msecs x%x\n",
>   					vport->port_state, vport->fc_flag,
>   					vport->num_disc_nodes,
>   					jiffies_to_msecs(jiffies - start_time));
> @@ -270,9 +271,9 @@ static void lpfc_discovery_wait(struct lpfc_vport *vport)
>   		} else {
>   			/* Base case.  Wait variants satisfied.  Break out */
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT,
> -					 "1834 Vport discovery quiesced:"
> -					 " state x%x fc_flags x%x"
> -					 " wait msecs x%x\n",
> +					 "1834 Vport discovery quiesced: "
> +					 "state x%x fc_flags x%lx "
> +					 "wait msecs x%x\n",
>   					 vport->port_state, vport->fc_flag,
>   					 jiffies_to_msecs(jiffies
>   						- start_time));
> @@ -283,7 +284,7 @@ static void lpfc_discovery_wait(struct lpfc_vport *vport)
>   	if (time_after(jiffies, wait_time_max))
>   		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
>   				 "1835 Vport discovery quiesce failed:"
> -				 " state x%x fc_flags x%x wait msecs x%x\n",
> +				 " state x%x fc_flags x%lx wait msecs x%x\n",
>   				 vport->port_state, vport->fc_flag,
>   				 jiffies_to_msecs(jiffies - start_time));
>   }
> @@ -420,7 +421,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
>   	 * by the port.
>   	 */
>   	if ((phba->sli_rev == LPFC_SLI_REV4) &&
> -	    (pport->fc_flag & FC_VFI_REGISTERED)) {
> +	    test_bit(FC_VFI_REGISTERED, &pport->fc_flag)) {
>   		rc = lpfc_sli4_init_vpi(vport);
>   		if (rc) {
>   			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
> @@ -435,7 +436,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
>   		 * Driver cannot INIT_VPI now. Set the flags to
>   		 * init_vpi when reg_vfi complete.
>   		 */
> -		vport->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
> +		set_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   		lpfc_vport_set_state(vport, FC_VPORT_LINKDOWN);
>   		rc = VPORT_OK;
>   		goto out;
> @@ -535,7 +536,6 @@ disable_vport(struct fc_vport *fc_vport)
>   	struct lpfc_vport *vport = *(struct lpfc_vport **)fc_vport->dd_data;
>   	struct lpfc_hba   *phba = vport->phba;
>   	struct lpfc_nodelist *ndlp = NULL;
> -	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   
>   	/* Can't disable during an outstanding delete. */
>   	if (vport->load_flag & FC_UNLOADING)
> @@ -556,11 +556,8 @@ disable_vport(struct fc_vport *fc_vport)
>   	 * scsi_host_put() to release the vport.
>   	 */
>   	lpfc_mbx_unreg_vpi(vport);
> -	if (phba->sli_rev == LPFC_SLI_REV4) {
> -		spin_lock_irq(shost->host_lock);
> -		vport->fc_flag |= FC_VPORT_NEEDS_INIT_VPI;
> -		spin_unlock_irq(shost->host_lock);
> -	}
> +	if (phba->sli_rev == LPFC_SLI_REV4)
> +		set_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag);
>   
>   	lpfc_vport_set_state(vport, FC_VPORT_DISABLED);
>   	lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
> @@ -584,14 +581,13 @@ enable_vport(struct fc_vport *fc_vport)
>   
>   	spin_lock_irq(shost->host_lock);
>   	vport->load_flag |= FC_LOADING;
> -	if (vport->fc_flag & FC_VPORT_NEEDS_INIT_VPI) {
> -		spin_unlock_irq(shost->host_lock);
> +	spin_unlock_irq(shost->host_lock);
> +	if (test_bit(FC_VPORT_NEEDS_INIT_VPI, &vport->fc_flag)) {
>   		lpfc_issue_init_vpi(vport);
>   		goto out;
>   	}
>   
> -	vport->fc_flag |= FC_VPORT_NEEDS_REG_VPI;
> -	spin_unlock_irq(shost->host_lock);
> +	set_bit(FC_VPORT_NEEDS_REG_VPI, &vport->fc_flag);
>   
>   	/* Use the Physical nodes Fabric NDLP to determine if the link is
>   	 * up and ready to FDISC.

Rest of the patch looks fine.

Once you fix the small nit, you can add

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

