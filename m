Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F6343A03
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Mar 2021 07:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCVGwZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Mar 2021 02:52:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27725 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCVGvy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Mar 2021 02:51:54 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210322065152epoutp01fb2a849a1a7326603ca5345446ac190e~ul4SsEyOC1011010110epoutp01i
        for <linux-scsi@vger.kernel.org>; Mon, 22 Mar 2021 06:51:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210322065152epoutp01fb2a849a1a7326603ca5345446ac190e~ul4SsEyOC1011010110epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616395912;
        bh=QSzRsa3RtE+FVbv6pM4uLDobWPPHCXtNO3dkwc4+Fis=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=Br1kJWaLOM5n0XbQKJTV7mo4yptYoph22elMvFJHva4M495QdF+gjEXXdqSp27V7m
         RYXHOxT4QRwfU8cXWHZHk21g7wvCCjIpQH8c/JiDbAD/ybTd5IEyb/lMdzMviS7Cxa
         TD4k0yt8DiFpDXyVbPjRns2fl1CK0BGSn846oWXg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210322065132epcas2p43c590497146e64aacf6113e15ccba958~ul3-zqsMj1985019850epcas2p41;
        Mon, 22 Mar 2021 06:51:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F3lXK0CgNz4x9QJ; Mon, 22 Mar
        2021 06:51:29 +0000 (GMT)
X-AuditID: b6c32a46-1efff7000000dbf8-74-60583e70b006
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.48.56312.07E38506; Mon, 22 Mar 2021 15:51:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v31 0/4] scsi: ufs: Add Host Performance Booster Support
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
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        JinHwan Park <jh.i.park@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Dukhyun Kwon <d_hyun.kwon@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p5>
Date:   Mon, 22 Mar 2021 15:51:27 +0900
X-CMS-MailID: 20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA52TfUxTVxjGd3pLbyXrckFgBzSzXuPkQ0pbaD1lYND50cWxmUzDMiBwV27a
        Rmib3kIQNm3UCStDMDGihA8HmyCgHcpHKWNAcXwkc6LABg2fAYISERxsAxfZKC3T7M/998tz
        nvd53/ecHC7macP9uGqNgdZrqGSS485u6AhAwbq9HycKRydlaLykgYNaznfj6PHKAAddXljB
        0G/m627osS0AWdvbOahqPAadLTdzUNE9Iwvl5tVz0J327zA0ObyIo7LBBhbKW81io4ZFD9TV
        8xSgPmsRB+X8auGgiq5VFvq2fgigLwtq2FE+8r7+I/K+C7kseVPhCC7PL2sD8tbiGlx+rqeV
        LX82bWfLL9RVAfni7bfkWW05rKPunxhBBKVXqNRpNJ/WKLRJao0ykjx+7FAwIvkqLWOIJGNF
        SCwQySSCMJlAvCc+XCQUiiUkX0Ol0JFkerCrmuTrFbo1t4FmDHpaQa9J+ijGQClpAUOlMKka
        pUChTSH5aVRy6lodGbI3QkVTSbSenzgFVDMzc0BnlqYPTQy7GcFsoAls4kIiDN4/N8QxAXeu
        J2EBsHTiJm4CXC6P8IAvLJsdns2EHP45X4A52JMgoflBIe7UBdA+UQMczCF2w4LuMdyR40X0
        47BypAxzNuDBK1nTbCdvgY0V9cDJ/nD5eq7L4w2HqufwDZ7vLHV5vOAXo/dcHg84vtLs0n1h
        Z/MCy8mnYf3wc+BoDImvAOxosrs5D0LgL9m16415RDQsNy2u62xiJ3xiH3QVH4BXz/euh2LE
        Ntg4V4Q5lseIAGi2hjgQEjvgXTt7YxVj7V/4fxkj3oDZHS/+1S0lU670t+GtFTPLGbMV2ktc
        08vhxcaf3PLB9sKXF134ygiFL0e4BrAq4EPrmBQlzYh14lff+TZY/weBhyzg0tyCwAZYXGAD
        kIuRXrxuxbFET14SdTKD1msT9KnJNGMDGWvLX8T8vBXatY+kMSSIpEKxVBIaFhoqCZP8b1ki
        lkqFMgmSSMWIfJPHCMcTPAklZaBP0LSO1m80Z3E3+RlZ3skReMsjoqOrxNDV8lFWTOSZgyqp
        aHCbdSmurnFWvUddntD4R/7ZdGlv2uL+rKjwaTjfm3mktOfW5+FM9Z3u/o6yZO6VrUBUHSzC
        Aj+8qTDSPb6TgpnO3NGyNJvZvWn22vGHBbbnA9U/+lw9eGpJnfSeqlVVUu3xTbN1/40lplgY
        9CCWqnlYnPHuPqvAv7L7tfjvLW1PtRlxp3fKTMp9P5R6rV7+dGzX749eHxmY+WwxPmg8kzSc
        zDxcn01+vXz/1A3T6O7KvIaV4ktHE4xPfo5r4ttizmwhTphmprKbtt9tFnErDrSw697Z9T6+
        w3cg5INlsBQbHfXMPzfn71pZ9FhQCMlmVJQoENMz1D+/49uW1QQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860
References: <CGME20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p5>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Changelog:

v30 -> v31
Delete debug unnecessary debug message.

v29 -> v30
1. Add support to reuse bio of pre-request.
2. Delete unreached code in the ufshpb_issue_map_req.

v28 -> v29
1. Remove unused variable that reported by kernel test robot.

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
 drivers/scsi/ufs/ufshpb.c                  | 2388 ++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h                  |  277 +++
 9 files changed, 3014 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

-- 
2.25.1

