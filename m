Return-Path: <linux-scsi+bounces-146-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD917F884B
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 05:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A57B20B44
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAC4435
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+NCnrhm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4271990;
	Fri, 24 Nov 2023 18:54:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1aDuJ027085;
	Sat, 25 Nov 2023 02:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=V1EvjHFDdB5RgF7K1AGuoYod4vq925hfukjjcv5bSVE=;
 b=M+NCnrhmf3RV4wjHIHmHFcUE+moSwhGGtbfpd6BNwiYAsWZMVlCBvNqmYWppYlMzAtuS
 rwe0ojbvYHGYQBg5NiVvTXn/QoPbd6Y9jV1Oxt/aV/1Z/PLftg/VdUHc6S9r2sanVY4R
 QnfSzB63SCseJ8qbpbkRUZaBqIbnaLQOcD213xu90F1O8Ld3zc76PUD2BeJzFqq3hVji
 xmjJYqJeReUGm0hAv0n1mBZlNvGRn3Cok5ydr6qyHdkdO1eJ/suGrJBrcMTH5qpqg8uh
 ZGJJZjyqvE6dRrMzR7dKNvnSX6a4Vc4i9JMwCS3EoYg7JO2okKd8CTQlB9DL8gYyGrI0 6Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bkxgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1YA0O027690;
	Sat, 25 Nov 2023 02:54:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSv011828;
	Sat, 25 Nov 2023 02:54:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-5;
	Sat, 25 Nov 2023 02:54:29 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: replace deprecated strncpy with strscpy
Date: Fri, 24 Nov 2023 21:54:17 -0500
Message-ID: <170087016625.1036733.15170921326314557519.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>
References: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>
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
 suspectscore=0 spamscore=0 mlxlogscore=876 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: jTpubG0R1qsZjTe4kAiIn0aH34t4wsAj
X-Proofpoint-ORIG-GUID: jTpubG0R1qsZjTe4kAiIn0aH34t4wsAj

On Mon, 23 Oct 2023 20:26:13 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `hw` is kzalloc'd just before this string assignment:
> |       hw = kzalloc(sizeof(struct csio_hw), GFP_KERNEL);
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: csiostor: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/4592411784cc

-- 
Martin K. Petersen	Oracle Linux Engineering

