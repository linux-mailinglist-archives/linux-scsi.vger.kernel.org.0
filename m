Return-Path: <linux-scsi+bounces-153-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41407F8852
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 05:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019C81C20B49
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCE814
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIFwoogH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007319A7;
	Fri, 24 Nov 2023 18:54:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1a7wc027073;
	Sat, 25 Nov 2023 02:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=K7jMtRbm8/3e9jSFRh1rR8pLgVX6BikWUzpJbkHIpbw=;
 b=eIFwoogHNCNuDgJgkFxd6bUhGxsVQf/BOSftVjKZxp3ngLPN+YJ1t3lnIbpjetZUoZkB
 Ur9XhJ+VKBPQkevqWtXs4pN/txniuhjqLU1fQpuJbARxezN9CrUAaoqBkbsTz+TaAI0/
 5hCfZ3y0kDPQNEaO2SHtAmZSLDznQrz1hfbI+tje41Da9YV1/TxjZJPOUjBb9/WV1xme
 8ED2pk4c+We02BSkZViN2itPt3Lyu6ATT85nxaW/YTlgMZrpuDiaWIhwY8J0nUKNt70Z
 LmqPIpdyz98u8hSW14jh9/e4Y4PdUu2KTYwqTiIae6wCGE/Bw30w8sQBcORrC+G4AIGt mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bkxgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1Xm0b026991;
	Sat, 25 Nov 2023 02:54:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSn011828;
	Sat, 25 Nov 2023 02:54:27 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-1;
	Sat, 25 Nov 2023 02:54:27 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        James Seo <james@equiv.tech>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a few cleanups
Date: Fri, 24 Nov 2023 21:54:13 -0500
Message-ID: <170087016621.1036733.18221067551058409419.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20230806170604.16143-1-james@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: ELDKgNLqVdfqSQd3bBOKeQnbdrxjsUHc
X-Proofpoint-ORIG-GUID: ELDKgNLqVdfqSQd3bBOKeQnbdrxjsUHc

On Sun, 06 Aug 2023 10:05:52 -0700, James Seo wrote:

> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") has
> resulted in the only arrays that UBSAN_BOUNDS considers unbounded
> being trailing arrays declared with [] as the last member of a
> struct. Unbounded trailing arrays declared with [1] are common in
> mpt3sas, which is causing spurious warnings to appear in some
> situations, e.g. when more than one physical disk is connected:
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[01/12] scsi: mpt3sas: Use flexible arrays when obviously possible
        https://git.kernel.org/mkp/scsi/c/aa4db51bbd51
[02/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible array
        https://git.kernel.org/mkp/scsi/c/f7830af68eb6
[03/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_RAID_VOL_0::PhysDisk[] a flexible array
        https://git.kernel.org/mkp/scsi/c/cb7c03c5d357
[04/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_0::PhyData[] a flexible array
        https://git.kernel.org/mkp/scsi/c/dccc1e3ed9e3
[05/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_1::PhyData[] a flexible array
        https://git.kernel.org/mkp/scsi/c/e249a957ce43
[06/12] scsi: mpt3sas: Make MPI26_CONFIG_PAGE_PIOUNIT_1::PhyData[] a flexible array
        https://git.kernel.org/mkp/scsi/c/1f1126609969
[07/12] scsi: mpt3sas: Use struct_size() for struct size calculations
        https://git.kernel.org/mkp/scsi/c/f4f76e141769
[08/12] scsi: mpt3sas: Remove the iounit_pg8 member of the per-adapter struct
        https://git.kernel.org/mkp/scsi/c/66f2a53fc620
[09/12] scsi: mpt3sas: Fix an outdated comment
        https://git.kernel.org/mkp/scsi/c/8a3db51e01d5
[10/12] scsi: mpt3sas: Fix typo of "TRIGGER"
        https://git.kernel.org/mkp/scsi/c/e5035459d302
[11/12] scsi: mpt3sas: Replace a dynamic allocation with a local variable
        https://git.kernel.org/mkp/scsi/c/dde41e0c1cc2
[12/12] scsi: mpt3sas: Replace dynamic allocations with local variables
        https://git.kernel.org/mkp/scsi/c/e18821556272

-- 
Martin K. Petersen	Oracle Linux Engineering

