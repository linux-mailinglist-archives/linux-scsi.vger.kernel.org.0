Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2862E438
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Nov 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiKQSaB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Nov 2022 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiKQS3p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Nov 2022 13:29:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E087D531;
        Thu, 17 Nov 2022 10:29:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIEfqn007339;
        Thu, 17 Nov 2022 18:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=pexBRG6B02DwG176kdgjzWsk1LpbrtqJOu7kx2u4xlo=;
 b=GWqGnfUaFtFZEJqgooPpU10d6uKbKDBRtkEfqZm5GueuUpUqT0vyppEC8Cw+PL9Bj8X/
 1JT/YT1qxECvPYYQBgc16W8zcAk0++/9ql1x49hT8T9PJ796a89eIOF/LjFEgDqefvGz
 bS1LGaNpPutq8s9ffWQNa2PZ+9PmYTUcPb7Bi8Nz4xhUkDrA2CumFUCqc7tPFkMHEY83
 Jmru8NjSa6gkVVBLtSAPWxB4eVBKGUS8pVfft9V53DpTCqpKmNI+k093TQKAfJHXeeOI
 nja1l2q5LNFoEY5EtEqjbpMw3rdFUT6KIYxl2hxgvyJmsTywM9KTisdW1SrM7ftb23OQ cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3nsa6nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGUnx010859;
        Thu, 17 Nov 2022 18:29:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapH022894;
        Thu, 17 Nov 2022 18:29:41 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-9;
        Thu, 17 Nov 2022 18:29:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: Remove unused variable unit_serial_len
Date:   Thu, 17 Nov 2022 13:29:31 -0500
Message-Id: <166870943121.1584889.10526347288138102346.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221101105326.31037-1-colin.i.king@gmail.com>
References: <20221101105326.31037-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: XQ-akj4hUGoW5gMar1vpkpN0OgePmT_M
X-Proofpoint-ORIG-GUID: XQ-akj4hUGoW5gMar1vpkpN0OgePmT_M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 1 Nov 2022 10:53:26 +0000, Colin Ian King wrote:

> Variable unit_serial_len is just being assigned and it's never used
> anywhere else. The variable is redundant so remove it.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: target: core: Remove unused variable unit_serial_len
      https://git.kernel.org/mkp/scsi/c/bc81131813aa

-- 
Martin K. Petersen	Oracle Linux Engineering
