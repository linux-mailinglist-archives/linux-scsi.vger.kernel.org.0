Return-Path: <linux-scsi+bounces-148-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12297F884D
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 05:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E71C20B49
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F990566D
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V3P31Tcn"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705F199A;
	Fri, 24 Nov 2023 18:54:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1jAnk020953;
	Sat, 25 Nov 2023 02:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=83tAjd3c0cNOySMl+swY7Wc/iliUtZENenIoQXddSr0=;
 b=V3P31TcnYAgfkx1IYCzf6MM/BSTPW8ReuC0H4VS+CgZXyErpl77OmQKf4bJYWtvQ1Jbj
 YnX5S1TBeIzkXczlqCuqImUOgNPDrJq76xuNbms0RzwmoldRpeKnGUlMBo9rluwK9tfE
 izRgdNvO8lV5CfuNRIXK+GEbp4vqFZeJ/6IOGFkAF3p7adnseqJlEuD/y7vB32hit771
 k8FdbaTyUYUUDNbjq5dkYOVnqwkXpZNhu6C/giqLSdUhVVyXakHu54lF1puBZ9/fg+63
 fnlwxHO2UP6hhVr6BJoebMLha7nxDdp/7Cgx3bgkaT3vrPvfnFjMPFxeK4eTodK0GBQ9 Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2g1du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1XxBs027101;
	Sat, 25 Nov 2023 02:54:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 02:54:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRSt011828;
	Sat, 25 Nov 2023 02:54:28 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-4;
	Sat, 25 Nov 2023 02:54:28 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ch: replace deprecated strncpy with strscpy
Date: Fri, 24 Nov 2023 21:54:16 -0500
Message-ID: <170087016625.1036733.2666443911958079380.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
References: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
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
 suspectscore=0 spamscore=0 mlxlogscore=946 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: HZHnAW8uNVrr-zJyWs9_i7_60HuVzDxS
X-Proofpoint-ORIG-GUID: HZHnAW8uNVrr-zJyWs9_i7_60HuVzDxS

On Mon, 23 Oct 2023 20:20:14 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> These labels get copied out to the user so lets make sure they are
> NUL-terminated and NUL-padded.
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: ch: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/dc7a7f10e673

-- 
Martin K. Petersen	Oracle Linux Engineering

