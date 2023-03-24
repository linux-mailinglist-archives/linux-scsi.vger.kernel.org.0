Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6A6C84D1
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Mar 2023 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCXSUq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Mar 2023 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjCXSUh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Mar 2023 14:20:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E92007C;
        Fri, 24 Mar 2023 11:20:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OI5CAc002432;
        Fri, 24 Mar 2023 18:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=5R47IUH5V0bCRYNW6W9PBkUNA79uHRpMXhrvr1HPRu0=;
 b=gUNjSdXINEwgb5rhCLlrDuHDJeU0wJtMGfKiS9G5arekL+5avlxSZaRa/rk362LjBdSZ
 rJxleuoQGfyNPRCLhOh8nLJhh5TDXnI90NOSM90PjcKjM1Q2nWvlPau8TOpNVxw7otLy
 pTAORFZXU32xUSXVTZQVqdhBkFjYVA6hvdBwrW/eFjrsg53sMPOWS1OQ6lqQEoPNmk9a
 M3VSU8AMsHd4xcL3tVogLAKULi7RA7yepxBAsHsYfbmaEr/RQNjR014wNtIefh19XBD5
 s+ZVw9EqO2wYA/Y+WTfWStBccYbsjGsQfT/03uXSAfJ8v3H56bbDNZUMqIEHLkttdfIO mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phgtr80xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 18:18:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OGHS91001364;
        Fri, 24 Mar 2023 18:18:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4bxk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 18:18:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OIHiEh021017;
        Fri, 24 Mar 2023 18:18:13 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-153-54.vpn.oracle.com [10.154.153.54])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4bx19-13;
        Fri, 24 Mar 2023 18:18:13 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 12/18] nvme: Add a nvme_pr_type enum
Date:   Fri, 24 Mar 2023 13:17:35 -0500
Message-Id: <20230324181741.13908-13-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324181741.13908-1-michael.christie@oracle.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=829 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240143
X-Proofpoint-ORIG-GUID: dnKdv8ClMWGHI_2KslURdpQT0zGwRIb8
X-Proofpoint-GUID: dnKdv8ClMWGHI_2KslURdpQT0zGwRIb8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The next patch adds support to report the reservation type, so we need to
be able to convert from the NVMe PR value we get from the device to the
linux block layer PR value that will be returned to callers. To prepare
for that, this patch adds a nvme_pr_type enum and renames the nvme_pr_type
function.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pr.c | 24 ++++++++++++------------
 include/linux/nvme.h   |  9 +++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 6aadcc25f3e2..c550c172ff0d 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -9,24 +9,24 @@
 
 #include "nvme.h"
 
-static char nvme_pr_type(enum pr_type type)
+static enum nvme_pr_type nvme_pr_type_from_blk(enum pr_type type)
 {
 	switch (type) {
 	case PR_WRITE_EXCLUSIVE:
-		return 1;
+		return NVME_PR_WRITE_EXCLUSIVE;
 	case PR_EXCLUSIVE_ACCESS:
-		return 2;
+		return NVME_PR_EXCLUSIVE_ACCESS;
 	case PR_WRITE_EXCLUSIVE_REG_ONLY:
-		return 3;
+		return NVME_PR_WRITE_EXCLUSIVE_REG_ONLY;
 	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
-		return 4;
+		return NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY;
 	case PR_WRITE_EXCLUSIVE_ALL_REGS:
-		return 5;
+		return NVME_PR_WRITE_EXCLUSIVE_ALL_REGS;
 	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
-		return 6;
-	default:
-		return 0;
+		return NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS;
 	}
+
+	return 0;
 }
 
 static int nvme_send_ns_head_pr_command(struct block_device *bdev,
@@ -127,7 +127,7 @@ static int nvme_pr_reserve(struct block_device *bdev, u64 key,
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = nvme_pr_type(type) << 8;
+	cdw10 = nvme_pr_type_from_blk(type) << 8;
 	cdw10 |= ((flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0);
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_acquire);
 }
@@ -135,7 +135,7 @@ static int nvme_pr_reserve(struct block_device *bdev, u64 key,
 static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
-	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
+	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (abort ? 2 : 1);
 
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
 }
@@ -149,7 +149,7 @@ static int nvme_pr_clear(struct block_device *bdev, u64 key)
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
-	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 0 : 1 << 3);
+	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (key ? 0 : 1 << 3);
 
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c18bd55a4ead..182b6d614eb1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -759,6 +759,15 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
+enum nvme_pr_type {
+	NVME_PR_WRITE_EXCLUSIVE			= 1,
+	NVME_PR_EXCLUSIVE_ACCESS		= 2,
+	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY	= 3,
+	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY	= 4,
+	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS	= 5,
+	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS	= 6,
+};
+
 enum nvme_eds {
 	NVME_EXTENDED_DATA_STRUCT	= 0x1,
 };
-- 
2.25.1

