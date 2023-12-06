Return-Path: <linux-scsi+bounces-590-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A1806653
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 05:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A148C28233B
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 04:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFB101CA
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="omyYhveJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE021B6;
	Tue,  5 Dec 2023 19:21:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61xv4n019441;
	Wed, 6 Dec 2023 03:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=gHF9gt+wxPSycQDz96zpJxYO1dVGhK3QJDsE/GyVbXc=;
 b=omyYhveJiYSzaagBU1EnhSGJWf5fhaThHmoBF0Mu++Z4D3DXyDr26PxS7XBzW+xUvLi8
 qxPfRLOWe/Ea4PXy5OD4cATXzSK5W5za29TkxTEcisU7JF7JhSVsryf5Yb1dQknxY30L
 626ZzcTbovkjgaonyCC6DpxdqCncK6d5CkHkhNtrjI6bgzQRJWRlhmAbNeWjdxoVOMXG
 Cl+lVKlAHJoE5Y6/mOMKxPhqL1eaWSAX74e9qyWGBZndcNOs8ATl8LoQiSqbw3I9z/GX
 Assyxgxay1gHR7wLIBXKNRPnOkhRavuEUAnE0eoSGGjk5n6YRBENq64VOpwlmHSsbtms uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc187c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 03:16:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B62PYHM036596;
	Wed, 6 Dec 2023 03:16:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utan96859-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 03:16:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B63GCYP014062;
	Wed, 6 Dec 2023 03:16:13 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3utan9684d-4;
	Wed, 06 Dec 2023 03:16:13 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: oliver@neukum.org, aliakc@web.de, lenehan@twibble.org, jejb@linux.ibm.com,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver: scsi: Fix warning using plain integer as NULL
Date: Tue,  5 Dec 2023 22:16:01 -0500
Message-ID: <170182644884.1446429.3315147571093159185.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231109215049.1466431-1-singhabhinav9051571833@gmail.com>
References: <20231109215049.1466431-1-singhabhinav9051571833@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=690 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060026
X-Proofpoint-GUID: Bp8fEVr36pMoA9ITtrjNJwmahn1FZ15a
X-Proofpoint-ORIG-GUID: Bp8fEVr36pMoA9ITtrjNJwmahn1FZ15a

On Fri, 10 Nov 2023 03:20:49 +0530, Abhinav Singh wrote:

> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> 

Applied to 6.8/scsi-queue, thanks!

[1/1] driver: scsi: Fix warning using plain integer as NULL
      https://git.kernel.org/mkp/scsi/c/f38d4eda25e2

-- 
Martin K. Petersen	Oracle Linux Engineering

