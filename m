Return-Path: <linux-scsi+bounces-957-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B979812667
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 05:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19021F21A83
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40041C36;
	Thu, 14 Dec 2023 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UulgMjq+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A49A3;
	Wed, 13 Dec 2023 20:28:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0SHM9009710;
	Thu, 14 Dec 2023 04:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=1/KqAcKuPT5e0GNlztVWEDS6q59GexzaQ6GUU6wEltU=;
 b=UulgMjq+gdwuZiSpeWKrmqwzAJsE7OCEgo1KjRckX977HJeLQNO7TYMLAfDueaXZSL2G
 CQQP4gMQOJ0W+O000k6Vr7+ISQu1UEq7pfOUSNBlJJu/X5LSId7+Tdii5clegovgdtE1
 VeFzMUdZCFBtWqLb05vW9GOxWnpDB9+SAoFYzfi1wJGaBXNWkJSUvG7CeOjStivZiAaJ
 kp2WAH3IXXHMi1+XAuShefT8TDvwIHmKFvjGRdGlkDagzrb5J2cRAwAEjWuXdzwXDdNO
 IPPTxZUxv9tVKSUz3CKs1+hpr9Aee7rniQVhkdVJYL75/bHaYJDPNvUPvnLxwdexqhV+ TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu29sg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:28:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE4I5fu018872;
	Thu, 14 Dec 2023 04:28:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9frp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:28:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4SpUX015815;
	Thu, 14 Dec 2023 04:28:51 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9frn4-1;
	Thu, 14 Dec 2023 04:28:51 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V5] scsi: ufs: core: store min and max clk freq from OPP table
Date: Wed, 13 Dec 2023 23:28:43 -0500
Message-ID: <170252810433.2596318.11576813186795542043.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208131331.12596-1-quic_nitirawa@quicinc.com>
References: <20231208131331.12596-1-quic_nitirawa@quicinc.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140024
X-Proofpoint-ORIG-GUID: lmNGB9ENgdmMDEj4Kyt9NwHjuKMxCgGQ
X-Proofpoint-GUID: lmNGB9ENgdmMDEj4Kyt9NwHjuKMxCgGQ

On Fri, 08 Dec 2023 18:43:31 +0530, Nitin Rawat wrote:

> OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
> for parsing OPP") doesn't update the min_freq and max_freq of each clocks
> in 'struct ufs_clk_info'.
> 
> But these values are used by the host drivers internally for controller
> configuration. When the OPP support is enabled in devicetree, these
> values will be 0, causing boot issues on the respective platforms.
> 
> [...]

Applied to 6.7/scsi-fixes, thanks!

[1/1] scsi: ufs: core: store min and max clk freq from OPP table
      https://git.kernel.org/mkp/scsi/c/77a672556096

-- 
Martin K. Petersen	Oracle Linux Engineering

