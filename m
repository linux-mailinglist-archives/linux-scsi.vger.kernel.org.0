Return-Path: <linux-scsi+bounces-962-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172181267A
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 05:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36EB282781
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 04:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4368BF7;
	Thu, 14 Dec 2023 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfVV1zXr"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F9B9;
	Wed, 13 Dec 2023 20:29:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0S5Bn004524;
	Thu, 14 Dec 2023 04:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=0X3+fdRFzvEhD957wPV3grzj5bB7Y6RcxFvRN/wYaRQ=;
 b=bfVV1zXrAZKMKizAxVCWzMh8k4ruUmpQovhN8b7OQVLO67SbVNvPWqyeGyFjsy21AnbJ
 jEwamSjFyPqYi4oegjmUM+WdV2OUHetLTulVjzbvs2/dI8AdHuY45fhTw7cwVNQnEDvJ
 LzK6v3JGkwTFBoPnxJ6p/bnqAV6Bvw/iZ/oil2LHR6ZzSuXdWOoFnN0fWOGrnC4kstNo
 pZmz95TUrvI1Qm2e+6kscVroDhZE9DxY7lJsXQYkrNyT+qrKWusb7a6uAQaKxREkiqWo
 yelG0vBB1goJD9hserSYIZNvpp8koegpPN5Q9DieiaF3G6h/fzpPR6SjPr1H4xpn8sgG gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d9x66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:29:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE38M5m009842;
	Thu, 14 Dec 2023 04:29:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9ev0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:29:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4TQM4035965;
	Thu, 14 Dec 2023 04:29:26 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9ev0g-1;
	Thu, 14 Dec 2023 04:29:26 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] scsi: fnic: return error if vmalloc failed
Date: Wed, 13 Dec 2023 23:29:06 -0500
Message-ID: <170205513086.1790765.12387126447114972285.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
References: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
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
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=688 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-GUID: wXUn-rRvv0VGWEDUitwVoxsxs_3NAc99
X-Proofpoint-ORIG-GUID: wXUn-rRvv0VGWEDUitwVoxsxs_3NAc99

On Tue, 28 Nov 2023 14:10:08 +0300, Artem Chernyshev wrote:

> In fnic_init_module() exists redundant check for return value
> from fnic_debugfs_init(), because at moment it only can
> return zero. It make sense to process theoretical vmalloc failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: fnic: return error if vmalloc failed
      https://git.kernel.org/mkp/scsi/c/f5f27a332a14

-- 
Martin K. Petersen	Oracle Linux Engineering

