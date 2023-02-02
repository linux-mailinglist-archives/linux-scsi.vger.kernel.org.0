Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9812688307
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Feb 2023 16:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjBBPsK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Feb 2023 10:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBBPsG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Feb 2023 10:48:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0A12F3E;
        Thu,  2 Feb 2023 07:47:41 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312DWRv4003017;
        Thu, 2 Feb 2023 15:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bW5ONZKyBh+HuH5JTx/fRc1MHjIJBdd9ZKWk0FS0Xw8=;
 b=EQJi3zeXLy2CfHqZV4ZP5K48+BPqMHHET33knWIPjyzUvGJhvjOk4upZu3uIs35hZrmZ
 LAadrOYUYucGigIBSakOjrU6wtLD9vESm/GVsbSwbJlRuIdTY6SgBAPB8o6Mv3QaIr2s
 zr+4lGbZAbzrxgkaC0WhRjqDlAj7uAZNytzXVH7itk5dM6PsZorEodR2vNIOjJ81FTQ9
 52V9pZkG1nI/18rhtiIQNMPcpWeG1JliESH9tVTyEFUdO2/2CKST6pZweHX+6LElcvbm
 Mb/1Qvy/+Hs3iM2kiiWoOU1p6lqa5ZRv+I5LYbfWtGZA3XCd+WFhM+gm4Sy38wxZluZM MQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqsyb01x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 15:47:12 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312FlA5e029733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 15:47:10 GMT
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 07:47:06 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v4 0/1] scsi: ufs: Add hibernation callbacks
Date:   Thu, 2 Feb 2023 21:16:13 +0530
Message-ID: <20230202154614.31433-1-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -qJKmFV_nR8SAoIzkjzqkwN13k3d1M1V
X-Proofpoint-ORIG-GUID: -qJKmFV_nR8SAoIzkjzqkwN13k3d1M1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=780 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

v4:
-Addressed comments from Bart, removed runtime pm related
code.
-Removed extra hba->restore member introduced in previous
patch, moved the concerned code to ufshcd_system_restore.
-Address kernel bot compilation issues.

v3:
-Address compilation issues

v2:
- Addressed Bart's comments
- Moved core and host related changes to single patch
- Note to Bart: Regrading the comment to pass "restore" as an
argument instead of adding a new member to ufs_hba structure, adding
new function argument in core file (ufshcd.c) is forcing us to make
changes to other vendor files to fix the compilation errors. Hence
we have retained our original change. Please let us know your inputs
on this.

Initial version:
- Adds hibernation callbacks - freeze, restore and thaw,
	required for suspend to disk feature.

Anjana Hari (1):
  scsi: ufs: Add hibernation callbacks

 drivers/ufs/core/ufshcd.c   | 51 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  8 +++++-
 include/ufs/ufshcd.h        |  7 +++++
 3 files changed, 65 insertions(+), 1 deletion(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

