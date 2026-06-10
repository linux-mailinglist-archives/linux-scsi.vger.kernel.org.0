Return-Path: <linux-scsi+bounces-24639-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJVSMVgyKWroSAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24639-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 11:46:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24402667F72
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 11:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b="a06/KZVX";
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=YelHbKhQ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24639-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24639-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A1E30E33B7
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76339A7F0;
	Wed, 10 Jun 2026 09:39:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC971358363;
	Wed, 10 Jun 2026 09:39:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084353; cv=fail; b=bYYpioDKzb8TgFvfp6LYubY7MzESe47zsXgWdkrfBYBgP9k2PacncBDRQDM3zkhfMG6CwvW5h9dyJUiqf/8OdSYAlavruR+NChZ/lzxlZPCXkVglgjH0TDTU7gkINySC9o2lZI7E4JX4f3cNCxTNIEw6gOptMBLqfwyfHVTS1CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084353; c=relaxed/simple;
	bh=X2MwNVRvWvWt8mpd1fZlQIvA5DHPKAB3Mz5zfeFb6Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XnSeAJSfm0dMi9cR6JTLRYSajMhaZGLx/Rt4zTlnBDra0XzaqnB+ArdRVRaY0uy+DjhB+NvVVUFWVJNSuAwaqNle3C3zQSmQt6iZImy+afPLv1r3rAVkzPkWKiQC3xVwTnaSGSYbe/s/n/e3DI3fgJ/jkbwIH0TzKNT/gZb9SW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a06/KZVX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YelHbKhQ; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6MnHZ1108512;
	Wed, 10 Jun 2026 09:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AD+k00bCpxMiV/g4k2tbO308Nag68oY55tF/EpbDdFc=; b=
	a06/KZVX6oXXPBrwLbuPI647eIzVf8jFgpGWhwm4qWmci3IryBL8Dp0bvau645cP
	/Ol5LM+iBXrxWBteCoElnsle8yHVUBfnJdfugflRa2IV8E9lkbpHDGCqhbqhMzBo
	ZG96JrIRtPtMJ40V7Z8eMDOG8ewcy0JgqcrQ1hJrJWS5hZy6XM/5zSORc+7qHbUO
	1pZdyW/QH8iVEeDSY8LcEiPUEWbDQsIr6wJ1kPJeDXdpc7aGO6w3CXb68fbM9/ON
	V1Dmn2afvcMEaUsjRwppbw81si1G7CirQ61CvdiSmqmK0tttdo3tOEwyoEn9aF2W
	4rZvQC2lx3pll16m35wxpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5sx7px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:38:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A9X83n020394;
	Wed, 10 Jun 2026 09:38:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eq56yrq13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:38:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0u7RvE0GTvh1wWnWNYAtYr+8ClgLukB+rnSwXK4cqlN5tbIT/0wyMdBvBXhJsT3ICFGj9K8Tb7uJnArgHIJCjYk2ozWh8V78qdwFzu6zLsrmyyX3Kg9boSWAFHGJrH9SOPZVakou4lKwUxs4WhNzErwSlAxndI1iJU8E/OcNFiO2NCU03vdW6a4p1wJ8S2cJiuPMDdiY14xWkmlXIHvuslYeqW27c2L0HqZ21u5IzbP/CU+2aag3hZ9repjgYPlrFDAe9X/gGm9Vyd5bEbBp7FLuPPY0X45eiKY84tRuSMywjNp5q1D9cYQ8LP81G1DAaSl2QrL63EShrr4pRw58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD+k00bCpxMiV/g4k2tbO308Nag68oY55tF/EpbDdFc=;
 b=w+4RrriGA9or6WK+hGvhYqDz/MV3WZtA64FX3+p9c5lW98iRTx0gGz49mquFwaTPMDLS+8J8QBrlWTpi0M64A8Bi++EECzNdBAbMVPwKIolsbiWymWhD8DouDOOvRo93hPALHOpKBK1r2rcRI7ub0KP+Yd/XhtLvSkJeEkDilv8K1DS1n8nX2HCZtw/lZKDtCuYT8yFKmAfSWVsGc62/w2buaZsf7tKVgMjVWwIJ+1Gly0CPbKOHJVy125J7ur2TdAVI9pfHNqNhKf1S7a6L7k09C5ajmObLld2486/E6d4m4I1ythE2EuLzT4e2fshEdmxu9WlBIYi15gpgE/KndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD+k00bCpxMiV/g4k2tbO308Nag68oY55tF/EpbDdFc=;
 b=YelHbKhQpwqmhC49NKkUqn1mdZ71b1ZWTDlfpQkk8S+M1BYPM7Kjkj3IcrgcyWk2+PJMsXQKTx/O5gvaVL0B0ICoHc0NKdLGDwkj39ZrgtPeRLeyCF+nKKt7noMB7txQhZfVuM/Hdxtq1irhfkleZAuvdGVTnP+ZBo9Fk10UcKA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH0PR10MB6981.namprd10.prod.outlook.com
 (2603:10b6:510:282::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:37:49 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:37:49 +0000
Message-ID: <f51b19e3-0848-4384-85d7-8fe7a7b11754@oracle.com>
Date: Wed, 10 Jun 2026 10:37:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] scsi: libsas: Add linkrate and sas_addr change
 detection in rediscover
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liyihang9@h-partners.com, liuyonglong@huawei.com,
        kangfenglong@huawei.com
References: <20260603092124.2221524-1-yangxingui@huawei.com>
 <20260603092124.2221524-3-yangxingui@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260603092124.2221524-3-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0013.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::18) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: c940aec7-def2-46d7-fa8a-08dec6d3ef75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kmaKUiHO7h3+STbz3ik0el3JFdgrAvxlBaozAgsQtTkIKnb4ECkF16mBYpuhrn8hniW3hkkMaVJIbCuGSwqPq3o6IZy3J5OJ4yHnvBbMQsDSXDeOsWmbF99kUW9Ov5otKb6ysAhmS4/YPiHPS+va01wsHPmg9HN/tptaQ6Fo95f7DfYtqsV8BYvWZ92BDKcL6SNKEKgzHFP/QNcYVE6I+FOWVcxNEztG461/nwIQS1jcUjLYI7paLsA26BM9nyMX3B/AbN/9DiO+Ze8uJ9Kx07ypPdyfMuiGfV/RqGtBDohGCkQqWUFmn5KEyQAAXKIHtyP6XoMSurgc8rUX1hUhEy0DjAtAf4bLOpu1epg/JkzJIn6wPRgAhwSgmMiG/PBUNUDIm2Kf8pGdupcmcitcAwG6PePIce/3tlwS+52dc4/AIOfkqHoU2SrUeVybP2H0bXYJbEymnDteJUGtJk7BYCcOVdCrVsG6XkLCVh1A2uiQzQl0UX9H+aPWAuBepA6m+0YCcLSsQ9/VN5WKZcxWxEbm7mQITXslzjGjY7rZyxMd5Y9Kk57LwhGgQ681dIMYr11oSH/VmFZFxRL7whLHqr5W3lX0u+mnp71io3EBL++H5BpdaN7CJ+A1kakc206Ma9F5LwcBVis2ZouLAzZ6sDuHAshXmUQfiigHZ8Z8OUYGg04HSeKy9VOJ+vwkOkTd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFQzeW9rb2Z4czcxbDNNdzRuY05aS0RFQWxHZjliSU9tSktnSHlOSHIwTDIr?=
 =?utf-8?B?bUlablBaUnRqb1VFZVp0OXN3dk50eGR6UGR4NU5nTkhMWXdCTHNWTEQ3NjdC?=
 =?utf-8?B?allZZ2d2TnNWNHVCcDErZUNMTGFMUHZIb29KVFFiblFBK0MxaDVVT2RUMzJl?=
 =?utf-8?B?RTdNcnZBNFBOdFZRVERoUDBWRWZTZXdaemhLOFpBL0l1eTBGcGUyK1oyV2Rl?=
 =?utf-8?B?UStPcEJ5QkQ3YmZEK3ZLakRKYlRiNHltTytzZFlGODZXbmU4ZHQ4NTNtVUVE?=
 =?utf-8?B?L2pVejk1VSsxNjZsV2ZRRmw5SFFmRkFWSE5IOC9lZ1M4czBrZUp6cU5DcS9B?=
 =?utf-8?B?ZEowcStEcjZoN3pCZXBuNzdXZzNqb1RsdE1nNlk3QkhhMEI0YzYvdkZmMUZD?=
 =?utf-8?B?SUxKUHZ6OGttL3AxR1NESmlDeXc0YStRV2lTL2tiMHpTUUoyNzUzNDhKQ1Vz?=
 =?utf-8?B?OGJ4bmJiNjFPT3A0WE5aWmk4OXF0RGd1NTUvMG1kUFM0VUdDUXhRTFg0OUsz?=
 =?utf-8?B?enQxeGpoK2lRcEZaQ21VQ3RpMnprTTNWZXE4UEptVWJUYW9udXpzbE5xSkRH?=
 =?utf-8?B?dzFFOW12R3pyVkNyRjRwK3NrSncvYWYzdEF4V0E1N3lHaTZNL0NGSkVsb2xv?=
 =?utf-8?B?UURCd0lxbExpMUJzNm9YUzkvalNNWDBPUjZTcThyaTlZZkRFVmhZSTAxcVVw?=
 =?utf-8?B?a1VvQWtMckF3VHV2UkJmNmhSSFpxckhNeVNUNEJwYTF0RC9QNjBpZm0zTnV0?=
 =?utf-8?B?Zkw1Q2ZyV0M1WmZoSzVVOUFNRFY5SE16SzY1R0ZzSzJMNTh3K05oaUIwM2Nk?=
 =?utf-8?B?ajkrcFRZTmUyVVEyUjlTZS9xODlpUXRMQXJveUg5WXZkNzBJeDVvaTZEdkdj?=
 =?utf-8?B?ZlpEQk9yZWlVdUdCYmVlWkdLS1pOR0U3cTcrUzE4T2w5N0ZhcjU1eVl1aEIx?=
 =?utf-8?B?cEdMSGVPN1A3QjNJRnNGdkVzT0lEalRLZ3F4ZjhOMWJFQTZ5dTBjQURDcndD?=
 =?utf-8?B?OHB4MTRKWGtLMTV2ejNlUnVDNGltN3JxdGt4dGNLRFdWVXFTRmJUUFo5YUhJ?=
 =?utf-8?B?V1Q4OHczajVrRnpkV3J6Mi9nWXI3N0Vwd3lGUmp5SHU3MmdLbzRHTDJ3ckZr?=
 =?utf-8?B?QkIvdDVjK1VCL2hmNHR2L1BGeXJCdDNsR0hDemsyNTR0U0VxdHZoQWR6enFI?=
 =?utf-8?B?UWF0SjMybXhHL3VKRTAyRDYvMHNnMGRFejE5TTJPSGpUNm5jUUdKRW9aQy9Y?=
 =?utf-8?B?cUZLN2tNZ2F2dkQ3REY0Y3RHZUU5UEVHazRsdDZsaXZsYW8wRkhMdDI4WWxY?=
 =?utf-8?B?TTlpVDhHVHBuZjNnazBYOG84dWwydXhVcGViTXVUQXBSZ3h1SVNSUG9HL1F3?=
 =?utf-8?B?dWRpUlpmYjVrazhQTjNlcHlzQ2FJVmIzK2NEeWZwQzhVYjkzZXBiaWtJTTRt?=
 =?utf-8?B?ZHB2WTlZZFRQeGVpcUN4YTZlSEtCd0t0VE9acWh2djl5TTQzUGpnelFnRG9W?=
 =?utf-8?B?L01VdkpncmNlZ29jQlBaWHJUOXRLaG5BOVE3cU9NelJOK1B6dzIzR3B0Y2hp?=
 =?utf-8?B?eFE1aWpSS0EyMFRrQkhrc0NTMSt2Mlh4cTZKWW16MUFGSzRXY2ZuZHZMdEpS?=
 =?utf-8?B?V013WG4yeURpK0pPdjVLYm92T1RUMUk5QlFXcytUejlwc2xwWVFEdG04LzlY?=
 =?utf-8?B?clEzcjd4WFU5RlBYaFFPbEZrWlJmc090OUNDMCtLQW5kSWIwRG9hWWpZRUxr?=
 =?utf-8?B?VTdUenhCV2NVeExuVmh2dlE3eVpwSGRaNjFoMEo5dFFINzBvS2NkUlBVb2ta?=
 =?utf-8?B?R2k1ak9CUnk4VWlseDBXQ3Z0WlFTUkprT1F0NVVsZHRmaUlaYjRYRHloakVX?=
 =?utf-8?B?UlNRaDdTVi9KK3lteitLazhPWFRWVWxFY016aDJ2dE9mYVp2YjFSVVFLT2lN?=
 =?utf-8?B?TGY1eFJjTlp6eVNsQTFJZ0NOVGNVcGRCSWhVQWVBTWhKOG80emN3MG1XVWlH?=
 =?utf-8?B?N2Y4T0pJRTI3WEdMbDZVS2RkKy9TTEVjRmFFMXBpbG04UEJrNWw1UncxaFVU?=
 =?utf-8?B?TENvNzlReTlJSkE3N3lIVllRRExSVjlNZ0cvdHFxb3FDcmhoVTl5SWMrZ0t1?=
 =?utf-8?B?RUJuS1JRb1NIODRKVjUwWTE2SUtSMjk3NGtlSXdXdm1QS2xVS3poWmZKMmRZ?=
 =?utf-8?B?eThzZnVmbkpwYkNKaFp6Qm44L24zN2dDZ2I5LzVDT21ZQkxqd2h4UDZoWEhZ?=
 =?utf-8?B?ejFkeGErZVByb0lkdFBBNW5pekNUOG9jMUltWkVtcFQ3OFlRblNROGFTNjJB?=
 =?utf-8?B?a1c5WWdzMTN0aHY1Wm9vQ1hIalFWYmVvTmFzYk5tRmYrelN2bU9CTG1yTjVH?=
 =?utf-8?Q?cBGfH+l4qi0y6elc=3D?=
X-Exchange-RoutingPolicyChecked:
	Xo1cjAiiUE6HYgQsedh4vu3SyA5VgEWtpNP0fq7RD3Frmne+gYd6s/1YxJ3G40gezrviE67VQnjnasqZWH+FmUXs68TrttRRVUbLIarsTYzA0dAWugc0BcYG6L/HxEJtwMJSfWWnHVV0e9OmvPvT2QVfwOIKTiwLEwXT43BkxctteVVGFIPpEzghRQywaVlQVl81hi1qb4v2Ikd8gSTXZbCgMVKgQCqrRM6FL0YbMrT19wXEzuynrwYUBbLyZMlKhun7KbiH4HMZd325IZV7Q44ia/w4DXmdb87uu6lHPRQppxy4Wkr3Op/M9Z5L+4EdEquV5i/be/nBYo1PSMrTZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V+9WjAlCgVQ8e57INriXminm99wAlO7LKOTCVHxWB9W3pAt1qY7BP6QGF/C8yNPJwHHt+KzPSJfc6MMEhoS07ou57ojoBY/weCYJ4EAstPIihPSuFkLoknqfd/tsPW+vGAzlVU77EqaPKxpR/3O9BP0Sgvzp556OSHzJ0CX+52XKOEEYqq11ILtBbRI4/GmQ/6X56PgAG+x9wykFSojbZ1FQWGkryi9qVuh7mQLa4bP+sjDuyHv0BpYxVhdCb4Y8v1H/umamJ1Omp0U0AvS6eiPN0cZWKTD8a31NrdvuEmXiRc3x/ap3OtNl/9PREyanMFP2HDmB/s6MQCwBr5AUDxfcHYp3H0bLesiu58cSnEo1jI4fgCX8SfrImlwxDa95/S/o3pBUtDRAfrbHm7EvvhNc/4SFyN3K7/H8h9B/n0MMi9ewlOHvldaXlHD6XNffgok6P11aDI2Cjq+5mEO3xA76QqZKWkv+Qw3fZYPcuE+ZlN7e6DnDmPaU4R0cABzNvehy0JwZaad7KFM8JdF4TbW+uhgwjwEiAkAFa2EIO9jVm9yZGLE16D1f4+MQ3QKeSZSNSUoainGXJ21v+zfgv6QEJ6dov1txuzP17uvMocY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c940aec7-def2-46d7-fa8a-08dec6d3ef75
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:37:49.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+6RsE31/YkErMmwxgFsxxOS1hmh/oAhFe6J2DOLYqm1ipksP93RhkNcCYmdVccYSR6vMamjBrq67laylrhxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5MSBTYWx0ZWRfX0NHfSfx69d0z
 tmiueDzTf9WQoeAWjfE+9qMMc5JL57D4TeUNJxLkkrXJ54nqySLfM2Z3LpgfM41rz62evFbdmrX
 407EQCiA72Pn9rwXLJhRRi/RgMGoDMs0Nm+sjFsUzKXILZVy6oyN+tNnGj42i+pXc0ud/vMl2LR
 31/c227azQoReu89GSF3etDnlTGsqO7c5yyRsNcpy0EFxMOkGXBoo6IrzCo17NjJYIeuz1yOKdk
 ExSXv2YO+bnm0jlhijktNAihuQss/LzKwgv1ilIhkReDwen9tVVG0shC0GYuQ9/VW8lBXeU+JeC
 qe//rh5++tcZud2VB/HpsrjdKVtiWf7PspcghFvZB5GgvaXQWUfsdoJMZJW5UzLhE8SZCvc8wFQ
 QloDPTfIsH3mpFkEh24GbzZ+1hbKjkWlHZEeDLAclyWQCGT1sMN0dEl8TCmsDh5/886ttA8E+GM
 Dy7E/dI9Ad96+x/3ArA==
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2930ab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=fcgfppVIOv0AmPHSFeYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vSToUfCeoO_sCdSDnSU8hK595umqxTyr
X-Proofpoint-GUID: vSToUfCeoO_sCdSDnSU8hK595umqxTyr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24639-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,oracle.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER(0.00)[john.g.garry@oracle.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yangxingui@huawei.com,m:yanaijie@huawei.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24402667F72

On 03/06/2026 10:21, Xingui Yang wrote:
> +		return false;
> +	} else if (SAS_ADDR(child_dev->sas_addr) != SAS_ADDR(phy->attached_sas_addr)) {
> +		pr_info("ex %016llx phy%02d sas_addr changed from %016llx to %016llx\n",
> +			SAS_ADDR(dev->sas_addr), phy_id,
> +			SAS_ADDR(child_dev->sas_addr),
> +			SAS_ADDR(phy->attached_sas_addr));
> +		memcpy(phy->attached_sas_addr, child_dev->sas_addr, SAS_ADDR_SIZE);

can you comment in the code why you are going this?

Thanks

> +		return false;
> +	}
> +out:


