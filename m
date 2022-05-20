Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817152E199
	for <lists+linux-scsi@lfdr.de>; Fri, 20 May 2022 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbiETBJ7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 May 2022 21:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbiETBJq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 May 2022 21:09:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400BD135688
        for <linux-scsi@vger.kernel.org>; Thu, 19 May 2022 18:09:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0J2kn017741;
        Fri, 20 May 2022 01:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=v8jMuknP621gJgrRIspFvXH4QVaZOhbCl3Az8t7IctA=;
 b=grhwRbXGELvbEdxJZU2vV2enjpUfCbAqwTQuxZX2j0smBlEI+++rWSoCZCFos3Gv/jT9
 oxegJwC4CYvKxT9IN7jwHGXjMw4LWLfAEYo6Un9KE6B6YnSqqIjkAAtXt2HWRYSk5aBu
 4mjQYFNBY3CyYlh4/DeCIcGbacs5Sf5/tFI4GAIM/9fq85cHDCaOtKhoZl1amJ/xYXyp
 59fjSTu9blEGYUXPZ5pNrCvuvWcb1x1U25Hgu1HHqBRhwmjJOxFJCORUBPj5rJv3XJtL
 gtJM2mZnTgpsXsfceG2SP8K7SJ5Y4C8BLkYbwIcINQuMWheQuXf5kvMLAZGc6UPCu+l/ sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sdte7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15ova020237;
        Fri, 20 May 2022 01:09:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKZ030710;
        Fri, 20 May 2022 01:09:35 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-16;
        Fri, 20 May 2022 01:09:35 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 0/2] mpi3mr: Add shost & device sysfs attributes
Date:   Thu, 19 May 2022 21:09:15 -0400
Message-Id: <165300891231.11465.17838408969631929162.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220517115310.13062-1-sreekanth.reddy@broadcom.com>
References: <20220517115310.13062-1-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KtDxMXaGWneTBHeVd4zCDMIiNMGyqkfE
X-Proofpoint-ORIG-GUID: KtDxMXaGWneTBHeVd4zCDMIiNMGyqkfE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 17 May 2022 17:23:08 +0530, Sreekanth Reddy wrote:

> Added shost & device related sysfs attributes
> 
> Changes from v1:
> Used sysfs_emit() instead of snprintf() api.
> 
> Sreekanth Reddy (2):
>   mpi3mr: Add shost related sysfs attributes
>   mpi3mr: Add target device related sysfs attributes
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/2] mpi3mr: Add shost related sysfs attributes
      https://git.kernel.org/mkp/scsi/c/e51e76edddb1
[2/2] mpi3mr: Add target device related sysfs attributes
      https://git.kernel.org/mkp/scsi/c/9feb5c4c3f95

-- 
Martin K. Petersen	Oracle Linux Engineering
