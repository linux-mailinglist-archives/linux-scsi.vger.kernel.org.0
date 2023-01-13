Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425F666A465
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Jan 2023 21:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjAMUtW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Jan 2023 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjAMUtN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Jan 2023 15:49:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02E25F1;
        Fri, 13 Jan 2023 12:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673642952; x=1705178952;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3p7LKiK4I8XfQpqtK9+9G8RPx5ZVzRpVR/QKdA0IHCo=;
  b=kBO5b1HZt3BtAOqTedZqkd2IueAHf/7vB8L/I6CAEN03un6KqtNhcq3c
   N0xiMDXdvgGkx4MoZz8cJPTnkHwP1t+QgTU5chqG72B09DSYPuHkoaeTc
   7SnZIV7IaC4amFTkTrUcBUqZpWCpImKpcNiioRryaSGepQH8jJD53Q99j
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jan 2023 12:49:11 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 12:49:11 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 12:49:11 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v13 00/15] Add Multi Circular Queue Support 
Date:   Fri, 13 Jan 2023 12:48:37 -0800
Message-ID: <cover.1673557949.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This patch series is an implementation of UFS Multi-Circular Queue.
Please consider this series for next merge window.
This implementation has been verified on a Qualcomm & MediaTek platform.

Thanks,
Asutosh


UFS Multi-Circular Queue (MCQ) has been added in UFSHCI v4.0 to improve storage performance.
The implementation uses the shared tagging mechanism so that tags are shared
among the hardware queues. The number of hardware queues is configurable.
This series doesn't include the ESI implementation for completion handling.

Please take a look and let us know your thoughts.

v12 -> v13:
- Rebased on top of latest Martin's tree and fixed conflicts 
- Fixed merged conflicts due to (3d2f12b Merge patch series "ufs: qcom: Add HS-G4 support") in
  0003-ufs-core-Defer-adding-host-to-scsi-if-mcq-is-support.patch to support the reinitialization
  needed on Qualcomm platforms for HS-G4.
 
v11 -> v12:
- Dropped 0001-ufs-core-Optimize-duplicate-code-to-read-extended-fe.patch.
  Arthur's change series
  (https://lore.kernel.org/r/1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com) makes this change unnecessary.
- Pass hwq as a parameter to ufshcd_send_command() in ufshcd_advanced_rpmb_req_handler()
- Added Stanley Chu's Reviewed-by tags

v10 -> v11:
- Added Stanley Chu's Reviewed-by tags

v9 -> v10:
- Fix few checkpatch warnings
- Use div_u64() instead of direct division in ufshcd_mcq_get_tag() to fix a LKP
warning

v8 -> v9:
- Added missing Reviewed-by tags.

v7 -> v8:
- Addressed Eddie's comments

v6 -> v7:
- Added missing Reviewed-by tags.

v5 -> v6:
- Addressed Mani's comments
- Addressed Bart's comments

v4 -> v5:
- Fixed failure to fallback to SDB during initialization
- Fixed failure when rpm-lvl=5 in the ufshcd_host_reset_and_restore() path
- Improved ufshcd_mcq_config_nr_queues() to handle different configurations
- Addressed Bart's comments
- Verified read/write using FIO, clock gating, runtime-pm[lvl=3, lvl=5]

v3 -> v4:
- Added a kernel module parameter to disable MCQ mode
- Added Bart's reviewed-by tag for some patches
- Addressed Bart's comments

v2 -> v3:
- Split ufshcd_config_mcq() into ufshcd_alloc_mcq() and ufshcd_config_mcq()
- Use devm_kzalloc() in ufshcd_mcq_init()
- Free memory and resource allocation on error paths
- Corrected typos in code comments

v1 -> v2:
- Added a non MCQ related change to use a function to extrace ufs extended
feature
- Addressed Mani's comments
- Addressed Bart's comments

v1:
- Split the changes
- Addressed Bart's comments
- Addressed Bean's comments

* RFC versions:
v2 -> v3:
- Split the changes based on functionality
- Addressed queue configuration issues
- Faster SQE tail pointer increments
- Addressed comments from Bart and Manivannan

v1 -> v2:
- Enabled host_tagset
- Added queue num configuration support
- Added one more vops to allow vendor provide the wanted MAC
- Determine nutrs and can_queue by considering both MAC, bqueuedepth and EXT_IID support
- Postponed MCQ initialization and scsi_add_host() to async probe
- Used (EXT_IID, Task Tag) tuple to support up to 4096 tasks (theoretically)


Asutosh Das (15):
  ufs: core: Probe for ext_iid support
  ufs: core: Introduce Multi-circular queue capability
  ufs: core: Defer adding host to scsi if mcq is supported
  ufs: core: mcq: Add support to allocate multiple queues
  ufs: core: mcq: Configure resource regions
  ufs: core: mcq: Calculate queue depth
  ufs: core: mcq: Allocate memory for mcq mode
  ufs: core: mcq: Configure operation and runtime interface
  ufs: core: mcq: Use shared tags for MCQ mode
  ufs: core: Prepare ufshcd_send_command for mcq
  ufs: core: mcq: Find hardware queue to queue request
  ufs: core: Prepare for completion in mcq
  ufs: mcq: Add completion support of a cqe
  ufs: core: mcq: Add completion support in poll
  ufs: core: mcq: Enable Multi Circular Queue

 drivers/ufs/core/Makefile      |   2 +-
 drivers/ufs/core/ufs-mcq.c     | 415 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  92 ++++++++-
 drivers/ufs/core/ufshcd.c      | 377 +++++++++++++++++++++++++++++++------
 drivers/ufs/host/ufs-qcom.c    | 146 +++++++++++++++
 drivers/ufs/host/ufs-qcom.h    |   5 +
 include/ufs/ufs.h              |   7 +
 include/ufs/ufshcd.h           | 129 +++++++++++++
 include/ufs/ufshci.h           |  64 +++++++
 9 files changed, 1177 insertions(+), 60 deletions(-)
 create mode 100644 drivers/ufs/core/ufs-mcq.c

-- 
2.7.4

