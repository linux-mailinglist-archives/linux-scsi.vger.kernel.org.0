Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A733872A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 09:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCLIQv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Mar 2021 03:16:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:29915 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhCLIQY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Mar 2021 03:16:24 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210312081622epoutp04af9cb375e2cee0ca710e398d2661350a~rilNxZAqj1442314423epoutp04S
        for <linux-scsi@vger.kernel.org>; Fri, 12 Mar 2021 08:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210312081622epoutp04af9cb375e2cee0ca710e398d2661350a~rilNxZAqj1442314423epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615536982;
        bh=dV4HuFX6eysddMYt0vRR9lnMe2OPE06nfjkUdoDul+A=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=KIaKE10FR/ae5gv8bxz9oivlZ6x5LTtem9t5/xYHB73IjpSs1019K1RJcL4SHFQgz
         6eIuKEafWM2y9pj+PHO6cX3w/6HjWDtkaZwtg5d25UTfw3iikLWe3lDbasmqwbqTT9
         u3xOn4PH+y4JfD4uvaBepFaWJcBFQxvG/tcMSjh8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210312081621epcas2p1a9161b9028234baac1707cb82252e6ae~rilNGKj_y2590925909epcas2p17;
        Fri, 12 Mar 2021 08:16:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.185]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Dxdtp23Lrz4x9Q0; Fri, 12 Mar
        2021 08:16:18 +0000 (GMT)
X-AuditID: b6c32a47-b81ff7000000148e-a9-604b2352c22c
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.E2.05262.2532B406; Fri, 12 Mar 2021 17:16:18 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v28 0/4] scsi: ufs: Add Host Performance Booster Support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "huobean@gmail.com" <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        JinHwan Park <jh.i.park@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210312081617epcms2p3ee7fe8f1c63cee74e7d79d786937990b@epcms2p3>
Date:   Fri, 12 Mar 2021 17:16:17 +0900
X-CMS-MailID: 20210312081617epcms2p3ee7fe8f1c63cee74e7d79d786937990b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLsWRmVeSWpSXmKPExsWy7bCmmW6QsneCwedn3BYP5m1js9jbdoLd
        4uXPq2wWh2+/Y7eY9uEns8Wn9ctYLV4e0rRY9SDconnxejaLOWcbmCx6+7eyWTy+85ndYtGN
        bUwW/f/aWSwu75rDZtF9fQebxfLj/5gsbm/hsli69SajRef0NSwOIh6Xr3h7XO7rZfLYOesu
        u8eERQcYPfbPXcPu0XJyP4vHx6e3WDz6tqxi9Pi8Sc6j/UA3UwBXVAOjTWJRckZmWapCal5y
        fkpmXrqtUmiIm66FkkJGfnGJrVK0oYWRnqGlqZ6JpZ6ReayVoYGBkamSQl5ibqqtUoUuVLeS
        QlFyAVB1SWpxSVFqcipQqMihuCQxPVWvODG3uDQvXS85P1dJoSwxpxSoT0nfziYjNTEltUgh
        4QljRtPJI4wF/4wqFv7YzNrAOEOji5GTQ0LARGLzwZdsXYxcHEICOxglTjVuZ+1i5ODgFRCU
        +LtDGKRGWMBDYs/9a0wgtpCAksT6i7PYIeJ6ErcermEEsdkEdCSmn7jPDjJHRKCVRWLbt4tg
        DrPAbyaJxSf/s0Fs45WY0f6UBcKWlti+fCsjhK0h8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33
        zkLVCEo8+LkbKi4pcWz3ByYIu15i651fjCCLJQR6GCUO77zFCpHQl7jWsRFsMa+Ar8T+OTvB
        FrAIqEpMnrIKapCLxOrzzWCDmAXkJba/ncMMCglmAU2J9bv0QUwJAWWJI7dYYF5p2PibHZ3N
        LMAn0XH4L1x8x7wnUKepSaz7uZ4JYoyMxK15jBMYlWYhQnoWkrWzENYuYGRexSiWWlCcm55a
        bFRgjBzRmxjByV/LfQfjjLcf9A4xMnEwHmKU4GBWEuG98NIrQYg3JbGyKrUoP76oNCe1+BBj
        FdDDE5mlRJPzgfknryTe0MzAyMzU2MTY2NTElGxhUyMzMwNLUwtTMyMLJXHeYoMH8UIC6Ykl
        qdmpqQWpRTDLmTg4pRqYbNtXSRi1ailwn6s4IWsza55/d47szCufppyxz+YXnX96/SJxsyk9
        YVd2pexS8A6yunnr8voTTYu16ufu2xhpUZZxuGalaNKF6QJ34+LZ9h3wtGWKVv6z6toXRr+F
        G4KmfFrIw5s9c5pW4++b6dbmsmINZUcMIw7FH07y6JIvlzu0c7H7zIfGkianFx/qW60e9yZi
        1xmOu3vkdfNFmiZeDV69TufjH77ZHdEPFzfwfXZ04j86fb/BisvvE2rqq8x0Kj7du7pwY++8
        x/zfzwnXvPWbapgdHmgT+e7hzVu9t+YesVo36bj6kheLdLOXaMfmTNPYv8xN1tnvwcIEHQF5
        o+bv4rPSjR5e/OsQVx/kpcRSnJFoqMVcVJwIABLmR+TMBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210312081617epcms2p3ee7fe8f1c63cee74e7d79d786937990b
References: <CGME20210312081617epcms2p3ee7fe8f1c63cee74e7d79d786937990b@epcms2p3>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Changelog:

v27 -> v28
1. Fix wrong return value of ufshpb_prep.

v26 -> v27
1. Fix wrong refernce of sense buffer in pre_req complete function.
2. Fix read_id error.
3. Fix chunk size checking for HPB 1.0.
4. Mute unnecessary messages before HPB initialization.

v25 -> v26
1. Fix wrong chunk size checking for HPB 1.0.
2. Fix wrong max data size for HPB single command.
3. Fix typo error.

v24 -> v25
1. Change write buffer API for unmap region.
2. Add checking hpb_enable for avoiding unnecessary memory allocation.
3. Change pr_info to dev_info.
4. Change default requeue timeout value for HPB read.
5. Fix wrong offset manipulation on ufshpb_prep_entry.

v23 -> v24
1. Fix build error reported by kernel test robot.

v22 -> v23
1. Add support compatibility of HPB 1.0.
2. Fix read id for single HPB read command.
3. Fix number of pre-allocated requests for write buffer.
4. Add fast path for response UPIU that has same LUN in sense data.
5. Remove WARN_ON for preventing kernel crash.
7. Fix wrong argument for read buffer command.

v21 -> v22
1. Add support processing response UPIU in suspend state.
2. Add support HPB hint from other LU.
3. Add sending write buffer with 0x03 after HPB init.

v20 -> v21
1. Add bMAX_DATA_SIZE_FOR_HPB_SINGLE_CMD attr. and fHPBen flag support.

v19 -> v20
1. Add documentation for sysfs entries of hpb->stat.
2. Fix read buffer command for under-sized sub-region.
3. Fix wrong condition checking for kick map work.
4. Delete redundant response UPIU checking.
5. Add LUN checking in response UPIU.
6. Fix possible deadlock problem due to runtime PM.
7. Add instant changing of sub-region state from response UPIU.
8. Fix endian problem in prefetched PPN.
9. Add JESD220-3A (HPB v2.0) support.

v18 -> 19
1. Fix null pointer error when printing sysfs from non-HPB LU.
2. Apply HPB read opcode in lrbp->cmd->cmnd (from Can Guo's review).
3. Rebase the patch on 5.12/scsi-queue.

v17 -> v18
Fix build error which reported by kernel test robot.

v16 -> v17
1. Rename hpb_state_lock to rgn_state_lock and move it to corresponding
patch.
2. Remove redundant information messages.

v15 -> v16
1. Add missed sysfs ABI documentation.

v14 -> v15
1. Remove duplicated sysfs ABI entries in documentation.
2. Add experiment result of HPB performance testing with iozone.

v13 -> v14
1. Cleanup codes by commentted in Greg's review.
2. Add documentation for sysfs entries (from Greg's review).
3. Add experiment result of HPB performance testing.

v12 -> v13
1. Cleanup codes by comments from Can Guo.
2. Add HPB related descriptor/flag/attributes in sysfs.
3. Change base commit from 5.10/scsi-queue to 5.11/scsi-queue.

v11 -> v12
1. Fixed to return error value when HPB fails to initialize pinned active 
region.
2. Fixed to disable HPB feature if HPB fails to allocate essential memory
and workqueue.
3. Fixed to change proper sub-region state when region is already evicted.

v10 -> v11
Add a newline at end the last line on Kconfig file.

v9 -> v10
1. Fixed 64-bit division error
2. Fixed problems commentted in Bart's review.

v8 -> v9
1. Change sysfs initialization.
2. Change reading descriptor during HPB initialization
3. Fixed problems commentted in Bart's review.
4. Change base commit from 5.9/scsi-queue to 5.10/scsi-queue.

v7 -> v8
Remove wrongly added tags.

v6 -> v7
1. Remove UFS feature layer.
2. Cleanup for sparse error.

v5 -> v6
Change base commit to b53293fa662e28ae0cdd40828dc641c09f133405

v4 -> v5
Delete unused macro define.

v3 -> v4
1. Cleanup.

v2 -> v3
1. Add checking input module parameter value.
2. Change base commit from 5.8/scsi-queue to 5.9/scsi-queue.
3. Cleanup for unused variables and label.

v1 -> v2
1. Change the full boilerplate text to SPDX style.
2. Adopt dynamic allocation for sub-region data structure.
3. Cleanup.

NAND flash memory-based storage devices use Flash Translation Layer (FTL)
to translate logical addresses of I/O requests to corresponding flash
memory addresses. Mobile storage devices typically have RAM with
constrained size, thus lack in memory to keep the whole mapping table.
Therefore, mapping tables are partially retrieved from NAND flash on
demand, causing random-read performance degradation.

To improve random read performance, JESD220-3 (HPB v1.0) proposes HPB
(Host Performance Booster) which uses host system memory as a cache for the
FTL mapping table. By using HPB, FTL data can be read from host memory
faster than from NAND flash memory. 

The current version only supports the DCM (device control mode).
This patch consists of 3 parts to support HPB feature.

1) HPB probe and initialization process
2) READ -> HPB READ using cached map information
3) L2P (logical to physical) map management

In the HPB probe and init process, the device information of the UFS is
queried. After checking supported features, the data structure for the HPB
is initialized according to the device information.

A read I/O in the active sub-region where the map is cached is changed to
HPB READ by the HPB.

The HPB manages the L2P map using information received from the
device. For active sub-region, the HPB caches through ufshpb_map
request. For the in-active region, the HPB discards the L2P map.
When a write I/O occurs in an active sub-region area, associated dirty
bitmap checked as dirty for preventing stale read.

HPB is shown to have a performance improvement of 58 - 67% for random read
workload. [1]

[1]:
https://www.usenix.org/conference/hotstorage17/program/presentation/jeong


Daejun Park (4):
  scsi: ufs: Introduce HPB feature
  scsi: ufs: L2P map management for HPB read
  scsi: ufs: Prepare HPB read for cached sub-region
  scsi: ufs: Add HPB 2.0 support

 Documentation/ABI/testing/sysfs-driver-ufs |  162 ++
 drivers/scsi/ufs/Kconfig                   |    9 +
 drivers/scsi/ufs/Makefile                  |    1 +
 drivers/scsi/ufs/ufs-sysfs.c               |   22 +
 drivers/scsi/ufs/ufs.h                     |   54 +-
 drivers/scsi/ufs/ufshcd.c                  |   74 +-
 drivers/scsi/ufs/ufshcd.h                  |   29 +
 drivers/scsi/ufs/ufshpb.c                  | 2396 ++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h                  |  276 +++
 9 files changed, 3021 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

-- 
2.25.1

