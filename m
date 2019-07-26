Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C392976E8C
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfGZQHt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:07:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3376 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbfGZQHt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6wS9025944;
        Fri, 26 Jul 2019 09:07:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=FX6wALfTpZCnINzv/umKgMd0uDaJok7KxUziBz+YtFE=;
 b=kcsDPVnCrQpyg07IQAolgXT/jmar0L0KOhxiY5B01lTIVwfkRiN792+AynOlln4e851h
 oTflmbMgotWNoy3HyeacM/0NS2ldpy6Z/Q2aqML1G8VBvptCv6/JoFu5tkupPUq9GMnK
 MkhTSp0uSbtXtq8dZPA4eGUPKVFPzTwJBhNNEi57fOPgZM81+HymcQZRaKP01uGexC6m
 pM5Zt9Oqf2WE33TUbIAUkLfvii8Zg5G4GqM1U7vYE/tzThDBGyzBJHWrAwg0iiwG0SM1
 kgbvZRo8bJiOeAUU4+/H4+r1VQqnzXaePZ+Dp9RUisw0A7qS9kHpwcdfaYTtJR2bxjII GA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:07:42 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:07:41 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:41 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id CCEA83F703F;
        Fri, 26 Jul 2019 09:07:40 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7eMG025722;
        Fri, 26 Jul 2019 09:07:40 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7e0s025721;
        Fri, 26 Jul 2019 09:07:40 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 00/15] qla2xxx: Bug fixes for the driver
Date:   Fri, 26 Jul 2019 09:07:25 -0700
Message-ID: <20190726160740.25687-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin, 

This series contains bug fixes for the driver. Most of the fixes are obvious memory
leak and/or error handling fixes.

Please apply this series to 5.4/scsi-queue at your earliest convenience. 

Thanks,
Himanshu

Andrew Vasquez (2):
  qla2xxx: Correct error handling during initialization failures
  qla2xxx: Use common update-firmware-options routine for ISP27xx+

Arun Easi (1):
  qla2xxx: Fix failed NVME port discovery after a short device port loss

Himanshu Madhani (2):
  qla2xxx: Fix DMA unmap leak
  qla2xxx: Update driver version to 10.01.00.18-k

Quinn Tran (10):
  qla2xxx: Fix different size DMA Alloc/Unmap
  qla2xxx: Fix abort timeout race condition.
  qla2xxx: Use Correct index for Q-Pair array
  qla2xxx: Skip FW dump on LOOP initialization error
  qla2xxx: Reject EH_{abort|device_reset|target_request}
  qla2xxx: Fix Relogin to prevent modifying scan_state flag
  qla2xxx: Fix premature timer expiration
  qla2xxx: Retry fabric Scan on IOCB queue full
  qla2xxx: Fix hang in fcport delete path
  qla2xxx: Allow NVME IO to resume with short cable pull

 drivers/scsi/qla2xxx/qla_bsg.c     |  4 +++
 drivers/scsi/qla2xxx/qla_def.h     |  2 ++
 drivers/scsi/qla2xxx/qla_gs.c      | 30 ++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_init.c    | 54 +++++++++++++++++++++++++++++---------
 drivers/scsi/qla2xxx/qla_iocb.c    |  5 +++-
 drivers/scsi/qla2xxx/qla_isr.c     |  1 -
 drivers/scsi/qla2xxx/qla_nvme.c    |  4 ++-
 drivers/scsi/qla2xxx/qla_os.c      | 28 +++++++++++++++-----
 drivers/scsi/qla2xxx/qla_target.c  |  3 ++-
 drivers/scsi/qla2xxx/qla_version.h |  2 +-
 10 files changed, 102 insertions(+), 31 deletions(-)

-- 
2.12.0

