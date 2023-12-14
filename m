Return-Path: <linux-scsi+bounces-970-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997381268C
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 05:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204F01F21B63
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 04:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C779F2;
	Thu, 14 Dec 2023 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2LlWeJy"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7F10C9;
	Wed, 13 Dec 2023 20:29:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0T42K005350;
	Thu, 14 Dec 2023 04:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=mJ3451zkdfGLDhRtPu1QT4Ogrv1lFk0jYww8GFnhT6w=;
 b=U2LlWeJyoEvG60Zl1CPswOTt+Dv4MlQ1L7zM+KsisneYtJcLi7RuXbbvNafRJ2Vp8h2w
 aiYncTvHMZmBinxZUSma3yHXQi4PjsdMvI8DAc2LEP89YPBHart+gADQD9nkkx4PSOyk
 a0bPgI0+0xWoNU7TNbFI39uL8UPVD9AesJKShIhuWJohzfMn51H79Xl3/2ZyU8ghzZvs
 Ro8mbAINDkt0JOisrn2QbuY3FAPQ/t95igLx0lz28QCBTqtE9+0BPbX9u6yVcyYUf04R
 Bkhfp44GiElJ4Jwnr333tOfju+4QHEAdY8tu+hfgcxAKxndQRzqvFEpeTVTD03axvBMv Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d9x6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:29:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE34td0010087;
	Thu, 14 Dec 2023 04:29:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9ev4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:29:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4TQMO035965;
	Thu, 14 Dec 2023 04:29:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9ev0g-11;
	Thu, 14 Dec 2023 04:29:30 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: quic_asutoshd@quicinc.com, quic_cang@quicinc.com, bvanassche@acm.org,
        mani@kernel.org, stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        Ziqi Chen <quic_ziqichen@quicinc.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: ufs: Add msi-parent for UFS MCQ
Date: Wed, 13 Dec 2023 23:29:16 -0500
Message-ID: <170205513080.1790765.11260329706297347985.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <1701144469-1018-1-git-send-email-quic_ziqichen@quicinc.com>
References: <1701144469-1018-1-git-send-email-quic_ziqichen@quicinc.com>
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
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=778 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-GUID: VUFW3WOjV65xTw0QVW4TCYaIcvdFt6qr
X-Proofpoint-ORIG-GUID: VUFW3WOjV65xTw0QVW4TCYaIcvdFt6qr

On Tue, 28 Nov 2023 12:07:47 +0800, Ziqi Chen wrote:

> The Message Signaled Interrupts (MSI) support has been introduced in
> UFSHCI version 4.0 (JESD223E). The MSI is the recommended interrupt
> approach for MCQ. If choose to use MSI, In UFS DT, we need to provide
> msi-parent property that point to the hardware entity which serves as
> the MSI controller for this UFS controller.
> 
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] dt-bindings: ufs: Add msi-parent for UFS MCQ
      https://git.kernel.org/mkp/scsi/c/af85d689ae08

-- 
Martin K. Petersen	Oracle Linux Engineering

