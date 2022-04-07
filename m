Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8154F80C0
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Apr 2022 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbiDGNib (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Apr 2022 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbiDGNhg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Apr 2022 09:37:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D262BD4
        for <linux-scsi@vger.kernel.org>; Thu,  7 Apr 2022 06:35:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237B1wgh012558
        for <linux-scsi@vger.kernel.org>; Thu, 7 Apr 2022 13:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=7uHcMyTq6xXoHfnKRdgC4J8MK7V+HyvsDJw5Mai7BhA=;
 b=u+1Jjm9C8mOn2O0yoNZNBjg3Apbz6MYphF/oclw1oL7t6BmrVlomJeEJXOQDz9zWyCZK
 XMM0Rka2zq/zyy3u5ZltoGT7r3SEYqIadVr9QN0QVXEsw/3VUB+MYsYHniXVQko9Yvwd
 N6C5Hul0Uv1/YPzyB/vtrWoI1KqtvCRxz439snLM3LONVu/H4bxvrbeba6ed7OSegecb
 FeMtfp0w6bLsaBhP+A1KtrtJYjDW0nHQu4p8J7yK0eojSFUkIpXEe9kaqY2qdOVGbedM
 9GKN0pSSm/0lB+qE+d65z/N3xrLy8HZJyt7tAwlb6P3F6TodZEPye4X8r+JpoJO4h7Wj UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwckm06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-scsi@vger.kernel.org>; Thu, 07 Apr 2022 13:35:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237DLVcI036832
        for <linux-scsi@vger.kernel.org>; Thu, 7 Apr 2022 13:35:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtw04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-scsi@vger.kernel.org>; Thu, 07 Apr 2022 13:35:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 237DZJMI032479
        for <linux-scsi@vger.kernel.org>; Thu, 7 Apr 2022 13:35:32 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtvpy-19;
        Thu, 07 Apr 2022 13:35:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] scsi: target: tcmu: Fix possible page UAF
Date:   Thu,  7 Apr 2022 09:35:18 -0400
Message-Id: <164929678998.15424.5620374167103783972.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220311132206.24515-1-xiaoguang.wang@linux.alibaba.com>
References: <20220311132206.24515-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1B2hT_OULWa2XLkffNPYrGUMx-FgLzo9
X-Proofpoint-GUID: 1B2hT_OULWa2XLkffNPYrGUMx-FgLzo9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 11 Mar 2022 21:22:05 +0800, Xiaoguang Wang wrote:

> tcmu_try_get_data_page() looks up pages under cmdr_lock, but it don't
> take refcount properly and just return page pointer.
> 
> When tcmu_try_get_data_page() returns, the returned page may have been
> freed by tcmu_blocks_release(), need to get_page() under cmdr_lock to
> avoid concurrent tcmu_blocks_release().
> 
> [...]

Applied to 5.18/scsi-fixes, thanks!

[1/2] scsi: target: tcmu: Fix possible page UAF
      https://git.kernel.org/mkp/scsi/c/a6968f7a367f

-- 
Martin K. Petersen	Oracle Linux Engineering
