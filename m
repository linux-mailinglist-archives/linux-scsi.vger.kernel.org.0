Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C95194EF
	for <lists+linux-scsi@lfdr.de>; Wed,  4 May 2022 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiEDCBi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 May 2022 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiEDCA0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 May 2022 22:00:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB425C4F
        for <linux-scsi@vger.kernel.org>; Tue,  3 May 2022 18:56:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242N6sYQ018740;
        Tue, 3 May 2022 00:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Svm5L4vd+psknhhhfxR468I8FTBZUDU0xFGag1czixU=;
 b=LqytFagz4NN2Uhboxv+NHF9BYcrJ17bqc3Z6A8JxLRYR67Sgm/RauIi745vol5B4zmDt
 Ee3ELHaddErJpdgJqb5E/q0yIDrm5EVCTwIMTPvYh4HSdLKgrnTbKjsnnreM3WiICdbF
 qeClkn4u/U+hWlanwT20S8baaLvs5XN8soRSE5+Js6NrLiHjjXAWUCECL8CP/LcWJVUQ
 oA7xQzf2Iom0lG4tCdNIFvUeGbdxh+Ts6cNuY3IUsDTtvRHArPMY33mPMIEf85qBmb4e
 94uJUPnwoipD/lJ0HSSujVNMxEfQiWW1Ts0dR9W8N6mDik9w5x5QXZx+UdzoGnz00KBM Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430op61008954;
        Tue, 3 May 2022 00:52:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plji010389;
        Tue, 3 May 2022 00:52:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-24;
        Tue, 03 May 2022 00:52:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nigel Kirkland <nigel.kirkland@broadcom.com>
Subject: Re: [PATCH] lpfc: Fix additional reference counting in lpfc_bsg_rport_els()
Date:   Mon,  2 May 2022 20:51:34 -0400
Message-Id: <165153836364.24053.18331726423388674581.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220427222158.57867-1-jsmart2021@gmail.com>
References: <20220427222158.57867-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V7LfiIwUCPuYdOQIW3Irg-WoviD0D1m8
X-Proofpoint-GUID: V7LfiIwUCPuYdOQIW3Irg-WoviD0D1m8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 27 Apr 2022 15:21:58 -0700, James Smart wrote:

> Code inspection has found an additional reference is taken in
> lpfc_bsg_rport_els(). Results in the ndlp not being freed thus is
> leaked.
> 
> Fix by removing the redundant refcount taken before WQE submission.
> 
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] lpfc: Fix additional reference counting in lpfc_bsg_rport_els()
      https://git.kernel.org/mkp/scsi/c/92bd903da12b

-- 
Martin K. Petersen	Oracle Linux Engineering
