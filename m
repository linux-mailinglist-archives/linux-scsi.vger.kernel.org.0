Return-Path: <linux-scsi+bounces-5751-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94609080D1
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 03:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6956C1F21B8B
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 01:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A791822D9;
	Fri, 14 Jun 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8hRwgPk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nzRJ96/B"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D265C;
	Fri, 14 Jun 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329328; cv=fail; b=Q3vbcHW9HtxrCY5CpsQ4LcBocM46VMtCLysVuBQayeAK59VvvDFOkbcX2S7T3qYQFOT53zUBF9VRcMWQBtx2TmdMNV//OOM/qLWStiwPUdtSNeiplhlFulp7AlZ1v88AgudbasgT7MP+xk5+ZwZgC29K5C+G6xDMDIAydM2HfK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329328; c=relaxed/simple;
	bh=Yu0xRH5Jjx4LtxkFEF56W+1H1sXDbn2VxS33QlCrdXc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EmvimgtMpPOLSQQltUmCaGGm2JxeMAqVbg90UI4TeOyWwspzIu7jh80vemqWHIufEVdCcdHVLOPp+ddHjLMeebg87PYhT0mXvcBtJZ14e2IuBZFtON2WwV27QuzNF8mSk6FXfM2mN6FkbxsrWQgCtmPeNFT85fX1+UTv3MDlQug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8hRwgPk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nzRJ96/B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fX5X003274;
	Fri, 14 Jun 2024 01:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=YsTri5LDgJOZ7r
	OHk62Dvpk2ux3OuDk+pxi14XzdcgM=; b=U8hRwgPkdyU8FwbVw4Cqt9AIdeXZu6
	Nrn1hqnrcqHZLslcahQ2Jd2tCxBuoX9+DVbGd/Olkp7csjp1L3JfzqmuI4Ens5Wa
	lZtyqXGl3dad+D4vt5B68J13RuiYk1yStsra8YqZ3CkJwTjHa7OGSXePwTAaBXxd
	l/N3ZpxlnyDzFG66Ew3w6DYvJSVA7ZZ+BBCN71coVIc+bf53LhDp2tqQH2CM4Ty3
	3gkJRKd1WOMxP82wZ/NQlRhHR+nQdbpJxGA8r0JnAAC93QwBHdhg1tCwn7SXJddb
	1WGT3rvVio4DLTeb24oVKLqBETad+MkC3qCcnI+SMQmHaqCP49pkje5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhajat17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 01:41:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E1JCkc014165;
	Fri, 14 Jun 2024 01:41:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncexqd8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 01:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZP3sdNOEkKZHdvO4AmZZCc2/Z64i6VEzdJL8DfNnfJNc++djEHvtVmQIWVggqkxkb2S0r03GgfU4YTvPq6ItwCVnBYgVPo75M8LWsTNQhlMKhKJetDek5o5pAQnjtRpGDFOlLlK/L4VPrB0jhp+E9deARVoQkwCTjylwr6IebMFtZauzTlLbRi0IfUjCILY+yt5RNayqb0MO21QsX4Tl3k6YtBCs+G5xBL12/FRoj60rg8UsFff23hmK3awMqdxnVn//7ttxVTz2Ee/9166XzLcxiAZyEA+wYFsfyTWGT993Pr3j081jkONsuoPa5Wri4gUdJ9Nb3yfM40tX5qk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsTri5LDgJOZ7rOHk62Dvpk2ux3OuDk+pxi14XzdcgM=;
 b=YSlQJmjetA1m7vYDyIL5Sc6dqarC2HenhoHgmFUrEXKAVS6tiSSPGMn1KH2VeEJ/AcKH/xAKhxthdakWBmd7N4cnao8MU9Np8cDkHfNV4iDbx9LK5XjGXB44pGSDHRhZdiovX0ziHpVekZ7/odD3h+AKw/u8VtjptY4E8yXt9jmlqaGEKID2/Q0XeT+ZTi8+0L7hcDo3XUiTlMZeswwMW8Hr+kAXNy06j3aVGpZ6lMe0EYi18owONAGz2m7BJYbN2J09VDrmxeU9YNI8adzWHkPeMD1jlUebo8/6mueqQjUhadcMCG7nsr791br3vQJRmerrsfRJX9imdVkeJGk4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsTri5LDgJOZ7rOHk62Dvpk2ux3OuDk+pxi14XzdcgM=;
 b=nzRJ96/B5zCEBqYhVdG+oyO59jmjPbnZq2nCQLJ/ZLTAz2tr+Cj2Vo13ysLrpdM3y5Hq+A0aZV8JcAcch7sE8/kXia67cGYw7BBKScjt1+mOW7NlgcB8Zjqz7HRrnBWw3sIuz7f1GPzwyU/WEGXuAEXK4kBlKqIlPu2w0KUAZik=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 01:41:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 01:41:30 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Anton
 Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>, Ilya
 Dryomov <idryomov@gmail.com>,
        Dongsheng Yang
 <dongsheng.yang@easystack.cn>,
        Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        Bart Van
 Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 05/14] sd: simplify the ZBC case in provisioning_mode_store
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240531074837.1648501-6-hch@lst.de> (Christoph Hellwig's
	message of "Fri, 31 May 2024 09:48:00 +0200")
Organization: Oracle Corporation
Message-ID: <yq1a5joti66.fsf@ca-mkp.ca.oracle.com>
References: <20240531074837.1648501-1-hch@lst.de>
	<20240531074837.1648501-6-hch@lst.de>
Date: Thu, 13 Jun 2024 21:41:28 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 89baff4a-c066-4599-ae3e-08dc8c131cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?87qcYGriZHmZbob+Uwc3AZhTiaeNOh2+FuL6xY2eMhFm68VolehHHIxo0ULt?=
 =?us-ascii?Q?lILiXTbuZQlbpRK1KEknEOf/s/KGohklp0LGp9ycmO2B0Zy6LVjqIKRziXuz?=
 =?us-ascii?Q?l7UmYoUwmQUo2GGqtNVcB0xyXV4SWipYpd7R8FM4UlyROyDEnp8PTyfHYMsl?=
 =?us-ascii?Q?3eJU8tQqFIr0wWJk5+meSFTmKKJm8ets3qKPaDMp77XSUr9om4KG2qWefdWE?=
 =?us-ascii?Q?Sa36XYb7fVRopaO+o48RjA7yVPew0/UR+LTv9KHHg7+tM2sLNoU3eOsV34ty?=
 =?us-ascii?Q?PJxj0beGUcYwGLa3DnDgysMqebuh5T57qUSTreFYth1uKV17YR8oKkyhEC9E?=
 =?us-ascii?Q?29ohKXBo+d0lzH6jB0vY/LFJjburhj73JoLrKU5L+xtNhbTRDOSJXQQpJWBe?=
 =?us-ascii?Q?I2wQs7dtqahI3c6JLIHwvtRA3Q/SiqsNTXP3LVgeIbTh3e6oVoPM24WY/i/I?=
 =?us-ascii?Q?NXbT4DtJlTqSnqFwz79ZQOGHoZJYiMctO3NoWOPXplIivUleSrQ0VuDHncRZ?=
 =?us-ascii?Q?2hXyoFQkHZH2N2pSoy6/MXhvxssdcExq8Jg4ehPybht1WopcB30ufnL3wd5c?=
 =?us-ascii?Q?HXdEhX1DJhydKDvYMD60T/WkjxlPH7gA9Tcuw/uOjOwVNCSdRTTukTIwTKuh?=
 =?us-ascii?Q?hxTF3fWUv3HaXsi/zhroDU/jF1vgq5JDNnXksBirQkWHEUQE/xhVBhwmFRYn?=
 =?us-ascii?Q?Xw1R7HjyJf2TllgHIToGnShOUmmKqqEeQae9E8TsYCayQUvSDo5HqxIlkSvP?=
 =?us-ascii?Q?TqSCqekd9faGL6vOPb0Xuc8EGVesYmd3Ah9uYEDP2oc8ovdDIvL4Lq/b5Mts?=
 =?us-ascii?Q?hUUejfIQ8AZnPb+sHBKY6GkR8mT03lZ3G/kaxu+PV7HHVHNQ2j1CxEv+sDdZ?=
 =?us-ascii?Q?C0hXAVNnmg0ugwUDlDJBTaDRyxBaLCcdtnULMMmIpQNGcAUVkV97ceh1Nb/G?=
 =?us-ascii?Q?Sqt+m7FHntFEXUoqsmDdhSw31YJLZZFPFzfsfRqtTHc29qYvQGhpkj6jRJ6c?=
 =?us-ascii?Q?RcM2I4rP9a9NbKr1k/Te3rjljdnXcZ/49LRHnyX2lTFaarvK63H44pwdGA6B?=
 =?us-ascii?Q?i0rDEAfF6l0D+9qqxgV+mXy4Ul0BYwYiVye4e+I2fNFhFqhh3PHJCqRtnHn0?=
 =?us-ascii?Q?SChzOtcWMsiEtYQoRXLHPAERehmwn2LComqvRbpD8zX4wCPCSIZoA5puXe4q?=
 =?us-ascii?Q?Y1MtvU703PnbgyRDl77tURA4Fu/LyQjFxbJF+4kAosOrcQRE1DJ5TDIpVkC+?=
 =?us-ascii?Q?o0XOqQxeM6k9/vRmHtOapY6tVsY8mRkONleORo1eQG4MFlKYt+R403NATT5H?=
 =?us-ascii?Q?kwlMgJX98kgJliLm0+FfACd1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KVD8EfdpweX5O5glbi+GUvLbeMZrF/SXWSVu+xsMCKvP0+2wirWh8PzI//yi?=
 =?us-ascii?Q?hq4onyt+fY5242dSD4GaQOyghCi9lzpNYUKeyo+aA1e70pqvj02O0RI6uxJg?=
 =?us-ascii?Q?R7yNg7Ib6DGOlCjzZkmMdpXfCb0bhFtvGebFnEcGbgUqXZnGDtBOk/Wuv7I/?=
 =?us-ascii?Q?e5N9+w56bVprALJP5IhoxMPgzlLHunVG5tdtXYJTtwDpJgtVu5/k+jOX76YR?=
 =?us-ascii?Q?xQFrzSLlZl9VEAYXctoW59wvVKQZ/dUe0MeAFNjXtbVJHWwlC+P33KDzWOlA?=
 =?us-ascii?Q?TSjGlBs+oOlIYejbHjxfEpKjSdOALmBVu+d9Yviu+qEk1RRWP880jnS3KZ9w?=
 =?us-ascii?Q?c1/XSoQsCzs7HNMx3K/0SRuLZfLBCtx/ErjFNEbRb7qP8JPLqqIkVMZ39yOF?=
 =?us-ascii?Q?d2T3ThhRXtIVPDwdPLClginqjCcOC6vJrCTovKOksRIwTFh2PWykPbrDYmbt?=
 =?us-ascii?Q?bYQ3xske6uUuSZEfRHKIny6jM+3EGG1VD+uvBL6ubY0Qih8lLnTdDo0xfDja?=
 =?us-ascii?Q?syX9UebE+UKXdVnDdK2zrb9v0sjpR+cZSjPf0ox8I8pF6XBypLeGTr+7emLL?=
 =?us-ascii?Q?4R4pIM/Uc6qD77Whx55c0wkALJFbUjpJ4P+LyIppLj9jVhF21SXwx0J4OZ9l?=
 =?us-ascii?Q?/SxMuBfaGsywP2Tn4XWGX6FdcWRrkTrVxc7SamU+GmXt+KsU13iWDt7Z7mf4?=
 =?us-ascii?Q?5RPxCun7POh1KVhpX4ICGqbUs87gkkPCwmqjTI5CRW7yPurKxTpHYm1zOEM4?=
 =?us-ascii?Q?q5rgCeiYkuoTpm+O42HgPtopxv9l5dNVipGDgMNpSJFBhiLzfVUXgXsDwQIM?=
 =?us-ascii?Q?Wjt4VZdUfmb+Afi6XmNXnmGbr+Oql8fIXmQpyw4iDrniy7HgghlyWscENMFP?=
 =?us-ascii?Q?ED9cOeFOUjgS3w2wOO20Z0NuGpfwBq8Cgne2ZCjbCef3l1fF6rphJr/Ner2n?=
 =?us-ascii?Q?v4ZNzuP/YnzBl59kcI0ccbB/LvsBl0p/Ap7DOjqUQiDCMBm1VniQbPxnk++G?=
 =?us-ascii?Q?XjX3FoqFjcl2m/2v7h9b5UFrK9szjWXaUZ+IR5O2M2crBhjAYcEWJgi9zFjY?=
 =?us-ascii?Q?iZbpBxuuXGMlX+8iicDdAFQvcAFi25xdrAtUxa2v+Wo9DZLvJKVSggntUwlE?=
 =?us-ascii?Q?10PQ3WnUuqajQmz3UGxKJMjsv7BxyafdfrCItUnVglSSXuQb4FUVDKcE0d7b?=
 =?us-ascii?Q?saY7GDBMSjcRr0iyQ9bHIy5yBFPjSpfCopKj9gQdL+Idsu6su24i081oovcO?=
 =?us-ascii?Q?eGZkhaTFBW//rAjC8x0QjW1gM0laSL5/ZNDIP3HzsaG7RUj/jjQiJDKuCZ0a?=
 =?us-ascii?Q?/Yu7JYBOyQsGx6aGellLJ2rvxY7wEgFWe4YpSC7KRDPzJh5w3g5Qp3BB1V3O?=
 =?us-ascii?Q?ganHZ4sWDthfUkR1fH/kyXIyXe7Cz42OfTbqCMMwnWipVIVkPPSt8GFo+Aa/?=
 =?us-ascii?Q?Ht6exraakW88QAFJdqv6hZ+xWhcH+C9HEQY5mXgbR5vCzM0/jZPD8Sucnz3B?=
 =?us-ascii?Q?bkWVQP0luxQaE6904rRHoqMMsZ21XXWQosK9Lr5JV1PZeL8PelQrD4a/c6Qw?=
 =?us-ascii?Q?e6H4/+9maJk2Y0HvTHz7U4pfaSlfGLEqdoEAmOgEqwVoKVzXg0BOaYE8q99b?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MqN2bmH7/QyAfgUuCOKwP6cpU7yFUA73t3EhNtQENb38971AoR/88vUfuhVXo+G+9zseYm+hNhW5K7+81orMjfxTmavzIIhp/IA0CM17gg9TLCT4TiRnhN8uY8NRGgFWuZXZIKAppMTar5Je+1qGiP80UzfgfQK9irbCIM3eftjtnObxd1E9F1lZsM1EZQOOO25ISHUndoHQf9wh20KbDhYFv+YAX3oE7+Zx6FTscKn7uOKlGDdaB2KhUUp1lRGV7LW0wOJhqDFa6YdCbQXIYt1ER9mfKvgOtfscSgZqC5/wUYq43fOcauTRBvKNF+z9aLr+E59TnHd958JzDol1w8x1AbgrVuWS3B4g7MBrcMXl4azua1aTBFsm5e8zYpEKPovNo/rW3+DdQSJ4LwblXkfRxikFQJMsdQCoxTEPkgjH7wEQrKSkk3rEXK2P6O61+hNfBjNq/DbYuz2svwl36renQAh0gktquEE5Y0AJyWXElOZs4CAQcji90GZnFftJPu63eT8GfI45BI8PnopoUNAbJEcKn+ttsUUaRYxwnEbWSeD4APJmPV0vhki8lNq08DHRqBLJzSeyjUEawjhLXZRN3SXxZBs2QyaU1bDTm38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89baff4a-c066-4599-ae3e-08dc8c131cfb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:41:29.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+V1PMFhTTh3/NoEbKBuWJSdRwoK8lebPM9KeaLEDO7sIsalSxvM/DCLT2CgbFADjenCllX60QXF+n+vuK5kUkNUpbMdq6kNcj2zFPfjaYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140008
X-Proofpoint-GUID: _WTIVA9pCJ9hEPIW6wKhmC3rJT9iqBtM
X-Proofpoint-ORIG-GUID: _WTIVA9pCJ9hEPIW6wKhmC3rJT9iqBtM


Christoph,

> Don't reset the discard settings to no-op over and over when a user
> writes to the provisioning attribute as that is already the default
> mode for ZBC devices.  In hindsight we should have made writing to
> the attribute fail for ZBC devices, but the code has probably been
> around for far too long to change this now.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

