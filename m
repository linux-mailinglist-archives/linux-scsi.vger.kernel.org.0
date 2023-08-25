Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56378787CED
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Aug 2023 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjHYBOG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Aug 2023 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjHYBNv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Aug 2023 21:13:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF29D1BF1
        for <linux-scsi@vger.kernel.org>; Thu, 24 Aug 2023 18:13:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEROa016881;
        Fri, 25 Aug 2023 01:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=6nra13DHOfHkJEs/OMrnRhL6peHQ0ePmKUzhMCWKCy0=;
 b=SCGL1ZN5cu7RNWJXDiNw7OlTTL1XAK/eGDs2NyTyHFg3AmwG0jl2nuphq1MVnDXsl4y+
 Pz0FLu3nMQJVPVNn8CILTsOOMRRz7m/7LlLX0psK0iKfYCLWK/diOtMO482ZaFNOrHNC
 D1Mn1hpwXom4PHjcaMYoS5vcAPsVjwk+8lEH4MPX4jn7qSN3OAAr4xLJDqWN6YKzAdgN
 pwcaqM4KkOJ/OXm1MxW5BsddPLCd0fM9xuzm750JuJvqc8nyDhPAcd45B+RknqjHdT7U
 7cl/8cEn+6gVQe8ZS8rmNvqx9yHgHqXjoJ56VmBQRCdyj23DpioimPXFpy82FMKQRK6G Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxnch1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ONx0CA036073;
        Fri, 25 Aug 2023 01:13:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVEO019787;
        Fri, 25 Aug 2023 01:13:41 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-16;
        Fri, 25 Aug 2023 01:13:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, qutran@marvell.com,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: qla2xxx: Remove unused declarations
Date:   Thu, 24 Aug 2023 21:13:02 -0400
Message-Id: <169292577163.789945.12677096098476159948.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816130842.16684-1-yuehaibing@huawei.com>
References: <20230816130842.16684-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=601 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: 2yeEjFKWrZjhGcbXUnBT9xahjarAxuSD
X-Proofpoint-ORIG-GUID: 2yeEjFKWrZjhGcbXUnBT9xahjarAxuSD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 16 Aug 2023 21:08:42 +0800, Yue Haibing wrote:

> These declarations are not used anymore, remove it.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Remove unused declarations
      https://git.kernel.org/mkp/scsi/c/1e4474c84554

-- 
Martin K. Petersen	Oracle Linux Engineering
