Return-Path: <linux-scsi+bounces-12445-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D498A43244
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Feb 2025 02:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D914F7A7921
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Feb 2025 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41706AA7;
	Tue, 25 Feb 2025 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AClHL9Lx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PRZOEBIS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F38200CD;
	Tue, 25 Feb 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445698; cv=fail; b=PsF+lcllocj772cr5OImNP6G7wFJQEqTNbGbhk6ECMtEjbx3Yq8K6wSXriZuASW6SMfoqSdxSZDEilb08TKap5QluCAC3JstYBZRG9+L9QT4N9vhxc2AIip/ssLYb3HWxWZ20XumhBSZJd8As+xHtK9Vg476jou8uvjotv7cLVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445698; c=relaxed/simple;
	bh=Hb85dk0eROBvBgVQ0+z5Aaxyzw0+tecJPsVQjdDxNGs=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=YxaFebGWr4fmnkUJ3y70GTCO84Pm3bE7QPORdUZEvjAEl3AWvqbrG661Yy7nHoiic4Dq/Fayj2o7cPbCovG/TOua0qUzdZqmZprMrGPQra92nwrXOB2C0zRXRMK9tNcCRgTilLRDQKqqRXEl9tTSHE4oqy3yRxq8ldlaJsVoE48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AClHL9Lx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PRZOEBIS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OMK4Bn025220;
	Tue, 25 Feb 2025 01:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+wm0HCCIOsMG3gMv4r
	OQZRC1Gv6vUrkAe4+t3OR+y/4=; b=AClHL9Lxw8SrOHWHvmMM1jtYA/aREAHOYr
	Dlv2EE8DFKiz7RqG/Q/+UDS/jRBIWtWXdU5VRRF4I2l/Qh1QycrmQ8SOi2/wjhHK
	DfXIIp5eDDzD4tXZLBDAa/59LlGU/3/QUiX3yyf23ROEuE/CWj8/uFTjukeUwggW
	WYQ6YRKYIlbEJfXqgZbD7mJoQi+biwtxM2mtLUnYgkrHZWZlEHLjb3+7djYxhGuR
	/rRdJBQHDLIE/KorSAsQ99EWgUspiR8POt3R5V7E7K4b3Hvs84kMpicHLB8Kn483
	xJ58VxJ6d9ho918I46HgXGmuCKetOY0gt7XDpxD+df3LUAtSBpXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bkxgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:08:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P010xS010107;
	Tue, 25 Feb 2025 01:08:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5188cq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgB1IwtwBC+Gm8cicCCkJ2i4TVj3/KFLq0Yu9jOOcxozxHKM84/dbW8mIHTy1JaBxB3WuzCSW5pezy7gvJyCv1xRWcxRrNHZDmhJI5N4Nwt0pg+b6leqeC3ciEp/ipwFlbm6Xqyof2ML0QWmfAHhMHoIofXHYfrcYKgKnkJaam3eloI81skWkRYWMly+SVY57vRCdLfgNxG7qgddBJMKHj1rdVLGgF+DWOz21K5dpsV4p34PEh8XiE6fEjRcdq0DFe+kmuJHvATdGvddkv9vnXZ4NefEVxJzvvtED4C+5YEHzg4nhZIACE9/4en6iFCOjY6To6QVw6TvPMq+UPlcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wm0HCCIOsMG3gMv4rOQZRC1Gv6vUrkAe4+t3OR+y/4=;
 b=O8BVy7S8ozRIoKBXg0mW50Vgq27MyTxae3xP40Yu/lhLeAoilum3SI4khRql9Ji5yEwpIqdYRtb6xCey/7uXE+OGS6xXqEWRNMkDztAGeL41v7Hs7KZvM4qx+HEh8AIl7p2eM7clxXah3FN925bk7LRtQn3WcIVeZkcsBDoeX02YVozNJ2ujNzJAx/gOL8/DAwSHM13kQx1upIAB8VM8rA4Tdp4InHsQXbMrZXkwqv8zHScvRk0cXL/Rojmod/IISzL+wkDDLhaLAYXaXVy3nNDKlO4Lfw8Y8vYQwm/oZqFvGvn/J9lI8vXduZMI+BvrJx3yGeNNoIfL1qmMwkyM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wm0HCCIOsMG3gMv4rOQZRC1Gv6vUrkAe4+t3OR+y/4=;
 b=PRZOEBISkZwm9fmsX8GjWxPkS/i3MBogVWKWhTlT4q0QkUuaL1EP4wDtf3d+LE/8AEKQzmqoGZdxFyKCCwtr5Ghpv61cYWNDCvqFl2dAufW6GSYlWhBXatHBjZva0vPK1GaAXDxX1ZQZAWl9BdD3QHZwdIurvpaMg9mr/tx21ps=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN7PR10MB6449.namprd10.prod.outlook.com (2603:10b6:806:2a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 01:08:05 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:08:05 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
 <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Fix spelling mistake "receveid" ->
 "received"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250221083253.77496-1-colin.i.king@gmail.com> (Colin Ian King's
	message of "Fri, 21 Feb 2025 08:32:53 +0000")
Organization: Oracle Corporation
Message-ID: <yq1a5aade6o.fsf@ca-mkp.ca.oracle.com>
References: <20250221083253.77496-1-colin.i.king@gmail.com>
Date: Mon, 24 Feb 2025 20:08:04 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0699.namprd03.prod.outlook.com
 (2603:10b6:408:ef::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN7PR10MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: ea95c6fd-0624-4ff3-f4be-08dd5538dc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V77v2bWfJMKAJYv45RlV3xIRP5l4zs4lXN+00jyD1SwCf6PU82C0maHaUctt?=
 =?us-ascii?Q?amKgAsJr/QVMWQTAdDi0JyoIUo32YH5CdRQExhMdJUVQJAajjfjCHVe9BGcd?=
 =?us-ascii?Q?/XDTsrvpGFJN31xOBC5VN/g9gVfPQMW/pZqR5R91BuUAPu6jGEABfyBEn9uQ?=
 =?us-ascii?Q?QFsW2Xgkl+Zr0cQQXgbRL6dOMElWamaJerob9b3jwVVhXJ0+adnjCztKBPlG?=
 =?us-ascii?Q?+EKnqHUELEz6qn2R4IyB0D5j4lJDdMiOglQNkesqE1wgwN+oOJ+o4F88HOKk?=
 =?us-ascii?Q?CsLW8SlU7qvkoewgHYfRBVEuXL67d912W8QG9TBwrhlPDhxn04YJxAB3cVFQ?=
 =?us-ascii?Q?uTYW4H4gwtwlyekyPDZstrpiVizt0zCempsSa05Wk4foUNYwdEVRtliO5s5x?=
 =?us-ascii?Q?9YJcoaO8sFh7/gzMa0X1WN63UGG+gJ5c+mIxMcfII7GWSGmzqVyUWe0/1Mu/?=
 =?us-ascii?Q?uK0OLtFU59Aem+i7ZSsIQCqj7WTeMzJvnvh8Aq8QvZ1c90YezPPo/NFtQ/qo?=
 =?us-ascii?Q?hFVSx03COthNFPoBivwsj4BCiaSUagUuehR9bKr4KennwBM3ak31ccZmzxi2?=
 =?us-ascii?Q?KHjQoeQ4DR6CQeK5uJckAORbI+yqs41ig41UBNtsUIrwM4Xu3q4rrqdXQPLF?=
 =?us-ascii?Q?FlwRBJiLcHbp/RSjNPQT/Ni9w5kkEjMr3Qd09caa9+Y0NW7vxibUogxfv1Rn?=
 =?us-ascii?Q?hGtyM4qjiP3FfwNnMlSvc6rn6iDKkGucuGiHgh8rIhrimdzcDF3+39osbuGL?=
 =?us-ascii?Q?lQHLmit59Y7HYEYRPaI8y+TbA2ICz7fxpMiHt08dXHWbhhkJQcWycc2DlP45?=
 =?us-ascii?Q?WSuVRv7UF2CB8kxv9K0IRckISOoTLHdjCckhv4WL1HcGtU0MHp81dzcV+l12?=
 =?us-ascii?Q?om3GPH71gJpeHQ3KlB/adCAAZnBF2+Y/B6DEz45NrmGk2CnytD3sQ4/NLixq?=
 =?us-ascii?Q?KLbiHLI9nudj6x4YhEE8sYLKn6mm2hWnjrP0VnEYlotQhypWZ8X/7q6xsGic?=
 =?us-ascii?Q?0bSKinVZDvNb/vTnoS6x7CTwMTX/fYIcdeZtlRugnYbTnaFZrSsUaaq2+lgU?=
 =?us-ascii?Q?G+c1A4BFmKR3UiSJx+PFPtte4eNXknVLwvaVa+YahcSbd/c7QMQNtySV9Qzr?=
 =?us-ascii?Q?3CbQE5Uoeum9upccZ255OSyhYVukw54TD/UdAC7YVWH58ep9vtGJM1bnji/a?=
 =?us-ascii?Q?v33zxZwfFJYnvcO52PUhOwcyvK/ZY5xh6tvFR/4uRWuPfAaMV3PCDHOttJ+1?=
 =?us-ascii?Q?RJlWdbC+NzuUuR9FHuW1k8Ujera7TjspuKSzSe7ld1YtcWI/yhmRHewFhBAf?=
 =?us-ascii?Q?PNvk59ng/q+qQWWET6PBqN2aSyz3Cf0wgt/OrmF7P32AtqUoFdJOzUr3vwQ1?=
 =?us-ascii?Q?/vtK+pDhQCCE+duq/e4wiXDrc3pc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BodcvaCvAi73f7zzBTVWUg0vGdKmDatBln4PLKnH9c0L5N/nbsEFh5Mgozsh?=
 =?us-ascii?Q?KLWY8Ukwz4d4S2iOXXv5R4TBouHV0z4S/QmJeXwd/YiKiUBr3VSnCj0BqyuW?=
 =?us-ascii?Q?nEw2HmIBIu3DT8zVneJBY3IQOvoNtA41lgns/HF9YPL5bRUUKT87xGfHu1Hw?=
 =?us-ascii?Q?xYXFeJ0faED5SLCn7q1UHPegStLUrWCxZEwHmMiMyn6VtaYN1IwI9LmhdfvY?=
 =?us-ascii?Q?96FtJ1JyK98TbkocCJjZIPLYXHnd8kFMFKOewoBGCzItLvthHbkz8D+1gU55?=
 =?us-ascii?Q?EAfCFbkliyacK2IsdLhx1P2AAwGbJC/+Mxhkoh3b5aoYac9Ib0eZVqZb9Op8?=
 =?us-ascii?Q?Gjq13X/i7Cx5vx4HsHO4h5+96xNx0Wfh2r8BXh0h82OADT8oRjQm62RVadwR?=
 =?us-ascii?Q?itdONX0nzWj0RRl3C7h60OF/pwuZkkdQztKzrFIrckrDz3lDn3CYdGw1n38A?=
 =?us-ascii?Q?JPzbtOy87CECHBCvlrO//puL+AH4PPQxmK5Y8GOHmk8A2c4vNkbVdiSiPnev?=
 =?us-ascii?Q?mgbiZBs3DfXw97o+FNfm4bs2aJrGcdX3QTZeyY83heRrfz8giSeruFDzPZCe?=
 =?us-ascii?Q?YoZbrf5T23MRsL+qTHx+7/xLu8DveQClEm6F+2seHdlmVAC+tfytTIDwkabU?=
 =?us-ascii?Q?hKU7cB46nRx0y9thahyulnx55bY/ALzBt6dyzRIugHlbsgVjxNzQdpac/mEb?=
 =?us-ascii?Q?i/ucrpNliw2wdY/I4MmQR4nd0ZE5KRMinyp9f44l+JjYLIEU/GDLgYYamQVd?=
 =?us-ascii?Q?BS14jc1yTwNx9zCa4DgAYFfzwao4c1ctOJqr6R1MHAame5CPbM5E3K0U/3Jl?=
 =?us-ascii?Q?fvy3e2uG2/QQn4qbNMvKyWbPtEh6qFlyP3JNTJxR9ggMLgQHTjzYQzuAv1Ki?=
 =?us-ascii?Q?PwpHRC64i3hWEOxNRodcaVZZdbdDqZoxVnRyOMQ3J+60pjJjffr+MqGmxQ8n?=
 =?us-ascii?Q?9wEKT51E8JLV12kxWqe4eGrYoOQI48Hs/VHIUh1ZXpohyYK9YRPYOGcauM+E?=
 =?us-ascii?Q?TloGdI+rxcO8QV7W/b4AQYoVrCulkCIvOJ6ene0EtbaC/87PwhQzlXoQneBn?=
 =?us-ascii?Q?LalzhrxSOz9JdaHL64x+u8sfwstRiDJkiObtJ2SYVGvXLE9SyXHGDUWTJ5uh?=
 =?us-ascii?Q?aAMiThiRJqfg4gscsJh1fekDQsJwhrRSr2EXE6SyuofDeaZDMnbMNhDVB01M?=
 =?us-ascii?Q?N6p9M/E26YTGetg1+dHpD3JFChsdIqd9se8Lqm4ulvr/up7hPDmeJA0Ux+ys?=
 =?us-ascii?Q?Mkv1r+68IKwSQM6xyt5YRI04PY1m/GMmUalc/xoaPScl0PsnoyD96FwwHpaf?=
 =?us-ascii?Q?+rF9kIl7Ggvi3IKF7/hgjOr81buWVEfEGW1CktoCwSoTGSB5tKDFyphiNnyF?=
 =?us-ascii?Q?Bfz5UcLN0B8qHh53lvRGHTjdwgY6ltg+a4KemgZvPMhdWsl1w/tmfDnhLjyB?=
 =?us-ascii?Q?zv5VT4peMHz5y7x933Ld959OAHHgHAoUBhO/DrbXjrgClEPAG3M6VlU1/WSl?=
 =?us-ascii?Q?Ms9B8h1r2sjzXbdWBkFJEWQGIsJzvG+VRyrnl80Lw95LsjHm1h4PsKqcDCFC?=
 =?us-ascii?Q?IW21yI08LwJszhWWbOC6TvgXVgFZ+fgAUB9LmHCqrrweXPC27JRKPabTShH8?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4eDYTBD5eSav4gVIzYMp3hTsEF/chr/yBe+oBCu0ZEcPnjmT40koSGLd6cTuwKY4wSmdfveWFQNqE27G8GoYa2KbCUZzni0xqCq+u562RVmn36Q4R0ghGScgkuei8RvLsY+Ngi/NvXGmf9EZStDCiiPU8INKf0T9dCH1xNWFuuUvGWQBTzv0Nt9zCi5h6XV6tySYC5Kus8s/3otNWiwxChtzWg8GCAAHiWmXJKe3ExEemEeVwADRHuVpJoT/tdkPxYKIgAmVmsVt/BMv7knp2vY9071JnD9Qd/xSYu0MqGP4OAR2aQXqhAnDyLzcB9KeId3+zpHK5FBO1LPfUSv/vyquyZbMuciX+1tjZtSajtItZdUf1N9YGvIJkxBBHIkCFMABN0JRyyKqkBsbAAFO4RHBCdaFReXs8PGquOQt4jcYiDlDJlLxP4ck2ImMI+6LaUHiUvlUQzyGv35hUMQV8D/TqWKq/vcq9/uG158YpQnH6QCAUEUEg1muucEc0lggCd3zRD8kWa3t1U2FmGBo1Pi8ebrPiH66+qpM6eDBrf/R6dxjzf5+VjDoDlA9aGb2hvVN6vllJ2wMln/F/VHie+bw0pLkiLT33f4dyaNsAck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea95c6fd-0624-4ff3-f4be-08dd5538dc19
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:08:05.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ltJv2X3vjhBIvP81VdGZttktSlOaAv6P0apbr/xY4mXcEWUJi21cj5m599etUUdQXy0dk6K6wvlglxZlDJsj11F8Yhpf3R0Jk5oEmLLp+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=849 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250005
X-Proofpoint-ORIG-GUID: 290xjb6MG0_nHaQfVNaWtXEKjDDpOLy3
X-Proofpoint-GUID: 290xjb6MG0_nHaQfVNaWtXEKjDDpOLy3


Colin,

> There is a spelling mistake in a ioc_err message. Fix it.

Applied to 6.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

