Return-Path: <linux-scsi+bounces-152-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A07F8851
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 05:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E323B21178
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD68F58
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L23o7vYU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1821998;
	Fri, 24 Nov 2023 18:54:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP282uB002747;
	Sat, 25 Nov 2023 02:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=DB//RmChznsOdm7RWNNcbB7S3LcEYo8EEQ97c7anty8=;
 b=L23o7vYU4NpPhEEbZ9feW37RTgyxzXLsZ9jirdI2hZrJ2zsNHfPr/jBDywf7mI36ATnF
 uVpsmZO/9OYsgj5GAZn/aMv0JhU/M9iQ5zkp2qzj0M/mJvOVCr4DMPuNKzZZXket6oQo
 O2+5qoyFhbkVBuNfWqpES1u3dRZSZRysdg0Wn/7D+5ZhamfCH92gdtx9dFe2p2+not+Y
 UATdjxesT0mnLMCb9GtikvcI9dvLZgxH1BNL/8Qk8fS5gugRiyhW0ruTt3bbhG0QhIQk
 RUbQKSGTOtzK59ag3DjxefP1EDQUc/o7mZl2EXgnrY1EDUUFD8wPHR6ro39BAyEuvLrO Tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucg12b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1XqlO027040;
	Sat, 25 Nov 2023 02:54:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSr011828;
	Sat, 25 Nov 2023 02:54:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-3;
	Sat, 25 Nov 2023 02:54:28 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: replace deprecated strncpy with strscpy
Date: Fri, 24 Nov 2023 21:54:15 -0500
Message-ID: <170087016625.1036733.14760172612221800618.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
References: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
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
 suspectscore=0 spamscore=0 mlxlogscore=687 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: y8uFlME6m-oVT9cPp01O0QjKBzo_CeVc
X-Proofpoint-ORIG-GUID: y8uFlME6m-oVT9cPp01O0QjKBzo_CeVc

On Mon, 23 Oct 2023 20:12:22 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect hba->chip_num to be NUL-terminated based on its usage with
> format strings:
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: bnx2fc: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/b04a2eff9e9c

-- 
Martin K. Petersen	Oracle Linux Engineering

