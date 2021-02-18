Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2133F31E7F3
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Feb 2021 10:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBRJX7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Feb 2021 04:23:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51418 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhBRJIJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Feb 2021 04:08:09 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210218090631epoutp0131830c645ded7e5f09e9b9452322bc65~kzEuugZW32547425474epoutp016
        for <linux-scsi@vger.kernel.org>; Thu, 18 Feb 2021 09:06:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210218090631epoutp0131830c645ded7e5f09e9b9452322bc65~kzEuugZW32547425474epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613639191;
        bh=8FCPGF+l9zEEbxzb4+FaTCGgxyfVg44YdbvL+4c+E+U=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=YoDg3lcCePO4AnlRoRtbJrwTOoUZ1DcpoJYRSIZqnjfFU7N9VZixdxugwoajFZFl+
         okos7MdHqPY3/ndco6nFBD75kprAkcOn2mtaehFA4mHuMaIs+aUhzSq9D0CzVYtAu8
         /nOvsWkvV49QKNSyBEOrMFls8q4RNGJLwBFSoQp4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210218090631epcas2p37a70bdf6f71208c628beddad2f0e1ad0~kzEt7pG9a0539305393epcas2p38;
        Thu, 18 Feb 2021 09:06:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Dh82q4CPJz4x9Pw; Thu, 18 Feb
        2021 09:06:27 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-05-602e2e136d09
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.7C.52511.31E2E206; Thu, 18 Feb 2021 18:06:27 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v21 0/4] scsi: ufs: Add Host Performance Booster Support
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
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210218090627epcms2p639c216ccebed773120121b1d53641d94@epcms2p6>
Date:   Thu, 18 Feb 2021 18:06:27 +0900
X-CMS-MailID: 20210218090627epcms2p639c216ccebed773120121b1d53641d94
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmha6wnl6CwdmJEhYP5m1js9jbdoLd
        4uXPq2wWh2+/Y7eY9uEns8Wn9ctYLV4e0rRY9SDconnxejaLOWcbmCx6+7eyWTy+85ndYtGN
        bUwW/f/aWSwu75rDZtF9fQebxfLj/5gsbm/hsli69SajRef0NSwWixbuZnEQ9bh8xdvjcl8v
        k8fOWXfZPSYsOsDosX/uGnaPlpP7WTw+Pr3F4tG3ZRWjx+dNch7tB7qZAriicmwyUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgD5UUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfmFpfmpesl5+daGRoYGJkCVSbkZLSt+cVYsFGz
        4szhI2wNjKcUuhg5OCQETCS+Nid3MXJxCAnsYJQ4uuk1G0icV0BQ4u8O4S5GTg5hAQ+JWVff
        sIDYQgJKEusvzmKHiOtJ3Hq4hhHEZhPQkZh+4j47yBwRgVYWiW3fLoI5zAJLmSVWP21gBqmS
        EOCVmNH+lAXClpbYvnwrI4StIfFjWS9UjajEzdVv2WHs98fmQ9WISLTeOwtVIyjx4OduqLik
        xLHdH5gg7HqJrXd+MYIslhDoYZQ4vPMWK0RCX+Jax0awxbwCvhJtDy+DxVkEVCX2tUyCanaR
        ePzxIFgNs4C8xPa3c5hBIcEsoCmxfpc+JLCUJY7cYoF5pWHjb3Z0NrMAn0TH4b9w8R3znkBN
        V5NY93M9E8QYGYlb8xgnMCrNQoT0LCRrZyGsXcDIvIpRLLWgODc9tdiowAQ5bjcxghO7lscO
        xtlvP+gdYmTiYDzEKMHBrCTCy/5ZK0GINyWxsiq1KD++qDQntfgQoynQwxOZpUST84G5Ja8k
        3tDUyMzMwNLUwtTMyEJJnLfI4EG8kEB6YklqdmpqQWoRTB8TB6dUA5NNa++718FTXlZOP/tg
        4YIAN/t3Oaz3p+dVLn14r6Zlcl7dvzOfD5+Kjz4Qt2P749+TvZvdu6rqA3e+f2CVtqM0TWqT
        qCmP4xrzty0r3SKXHmP7z/p9c6BAHZeh3va7QttNb/LkegRcm2PzZ2NkELfV3/K/Eb9+z2nk
        Y/OJ1TljtWd92oPPk0vytn2WnmdnHuHGqRF0Zw9fs6K3TwwXg+C5QDlvfT/hC2/tbho8VM2u
        jmPKq0vRNTn1j92a4d/cUOkle7acZ91fy7DfcUlO3OzPJ7w/P2Y511O/Y+m/zcyX2bwdUjPu
        rVPIC7FWMZ7b+0v1QECC7LRNV9OOmflt7eDbJ3h7S1T4xFcykTapFUosxRmJhlrMRcWJAFu0
        Y5R1BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210218090627epcms2p639c216ccebed773120121b1d53641d94
References: <CGME20210218090627epcms2p639c216ccebed773120121b1d53641d94@epcms2p6>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Changelog:

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

 Documentation/ABI/testing/sysfs-driver-ufs |  150 ++
 drivers/scsi/ufs/Kconfig                   |    9 +
 drivers/scsi/ufs/Makefile                  |    1 +
 drivers/scsi/ufs/ufs-sysfs.c               |   20 +
 drivers/scsi/ufs/ufs.h                     |   54 +-
 drivers/scsi/ufs/ufshcd.c                  |   69 +-
 drivers/scsi/ufs/ufshcd.h                  |   27 +
 drivers/scsi/ufs/ufshpb.c                  | 2280 ++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h                  |  270 +++
 9 files changed, 2878 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

-- 
2.25.1

