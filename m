Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0F57912C
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jul 2022 05:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiGSDJV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Jul 2022 23:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiGSDJS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Jul 2022 23:09:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E603C8EC;
        Mon, 18 Jul 2022 20:09:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKjwhF024475;
        Tue, 19 Jul 2022 03:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=EhK03EMlUDGB+SLLQY9upu0YPqtq6O0uRRm+mmeO0Kk=;
 b=YfTTtH76K/dsGvRsfpkNBJRVVz9pw92PNIKAkL6IaN7OxNabUAlF7VE+2+p94Zv4SDZA
 GTWHrjdkWR+2t0U2DEXFPuM4SZBLkbUJ/UuO3d8TDX6AzqB13FeMhq4/bY+gCYd6A4uE
 g9r2633Neni/ad7Tb47EaJiavy93CeDiFjPj/xlomhUuU8l8mul7/luzIXDb31M7rD5s
 yTGdgL7XPd8sG0dvxhgUoRMBkujlz2hAtS4TVFP9MSOgCFAX7xuCo2CtdBFtwsJHnjfY
 VqhCRheO94W3F/iFDcnCi3UVUdkLgQBMx7DlY76nlaotz0j9n609dLbeT5Pt5KDqXsPr zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42cymd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:09:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMKsrc002459;
        Tue, 19 Jul 2022 03:09:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2yptq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:09:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J391U7016855;
        Tue, 19 Jul 2022 03:09:04 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hc1k2ypt1-4;
        Tue, 19 Jul 2022 03:09:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     beanhuo@micron.com, Daejun Park <daejun7.park@samsung.com>,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        ALIM AKHTAR <alim.akhtar@samsung.com>, adrian.hunter@intel.com,
        bvanassche@acm.org, Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
Date:   Mon, 18 Jul 2022 23:08:57 -0400
Message-Id: <165820009734.29375.8836907731969047574.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
References: <CGME20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2> <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=929 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190011
X-Proofpoint-ORIG-GUID: ZACum0aTZbp5zYCEwrXyUlFqJDTkDIBd
X-Proofpoint-GUID: ZACum0aTZbp5zYCEwrXyUlFqJDTkDIBd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 08 Jul 2022 14:20:06 +0900, Keoseong Park wrote:

> Commit 4db7a2360597 ("scsi: ufs: Fix concurrency of error handler
> and other error recovery paths") removed all callers of
> UIC_HIBERN8_ENTER_RETRIES. Hence also remove the macro itself.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
      https://git.kernel.org/mkp/scsi/c/c641ffdb5904

-- 
Martin K. Petersen	Oracle Linux Engineering
