Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FBD4C61EA
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Feb 2022 04:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiB1DoP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 27 Feb 2022 22:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiB1DoN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 27 Feb 2022 22:44:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEE3A705
        for <linux-scsi@vger.kernel.org>; Sun, 27 Feb 2022 19:43:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RN22iK030109;
        Mon, 28 Feb 2022 03:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=azXL8wOR0/g9yJROqs2Ok2c7gbTkfFg2xCS4N0xOi04=;
 b=kMwBp596L/Mk+SFdicF7kKeCChCDMbX5rnI/gDNzMK70OvOJMgsh+48lEdzZZwFSLi7b
 STXeaTWk42/WEvLq2GwhpneW8wdmej/vjZ0ivwzbZiaDeo+/Awo0mIAGvE2ZJV6HFjRp
 4ZHlY5af3WggUL3aaLBKCzSUcXPeUTQfbC+XKqFPxFJQSlxCf9UeV5i5xYJtNhkyqEEm
 ozNNEA3H+XkCJ/GI7LVJ400t320ox3Ij7IGDDoO8hIysKHZ9I8+bUE3AryebwOnX3IEo
 /tjjXlLH2y03SdtDx4rSEPIhVSy1uFvoMDwbGNa4yj6ghQ/xw+th80PIsK25WtK6lgg1 og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamcb0p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3bFBg157815;
        Mon, 28 Feb 2022 03:43:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:34 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21S3hPw2165853;
        Mon, 28 Feb 2022 03:43:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnt3-9;
        Mon, 28 Feb 2022 03:43:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com
Subject: Re: [PATCH] mpi3mr: Fix flushing !WQ_MEM_RECLAIM events warning
Date:   Sun, 27 Feb 2022 22:43:23 -0500
Message-Id: <164601967777.4503.10263826717475110463.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218180515.27455-1-sreekanth.reddy@broadcom.com>
References: <20220218180515.27455-1-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SaUYvLIeB8WqnFvB142XAsrVyELHF9HJ
X-Proofpoint-GUID: SaUYvLIeB8WqnFvB142XAsrVyELHF9HJ
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 18 Feb 2022 23:35:15 +0530, Sreekanth Reddy wrote:

> Fix below warning by not allocating driver's event handling
> worker queue with WQ_MEM_RECLAIM flag enabled.
> 
> workqueue: WQ_MEM_RECLAIM
> mpi3mr_fwevt_worker [mpi3mr] is flushing !WQ_MEM_RECLAIM events
> 
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] mpi3mr: Fix flushing !WQ_MEM_RECLAIM events warning
      https://git.kernel.org/mkp/scsi/c/334ae6459aa3

-- 
Martin K. Petersen	Oracle Linux Engineering
