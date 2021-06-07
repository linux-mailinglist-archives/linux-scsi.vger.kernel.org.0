Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6822439D3D0
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Jun 2021 06:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFGESq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Jun 2021 00:18:46 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44429 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGESq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Jun 2021 00:18:46 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210607041654epoutp03d672ccabcd433a833a655f655920af83~GMb_JFOOD0381903819epoutp038
        for <linux-scsi@vger.kernel.org>; Mon,  7 Jun 2021 04:16:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210607041654epoutp03d672ccabcd433a833a655f655920af83~GMb_JFOOD0381903819epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623039414;
        bh=dg0ViRQXf59KgLE+aaog3vHoNrF4U9sjn7HqrktvH4o=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=jK7DBYRdQJWiECFwEB5K6zqLY09YX0Yvf7nT5MO97jKMp3oALwUm00a5RjmizVywq
         CSxJSrzPy5aq9OI0g8LPkeA9yVbPN+WH1fXI3uwWLtDsNfo5nlRmCAkbvPiyHLcrwP
         X/WHonEMP7Tk1+8CQHZgcBbB7BoTwFlbYdSxf9M4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210607041653epcas2p411a46b85be4428b38d8135c963499e1a~GMb9aErur1246412464epcas2p46;
        Mon,  7 Jun 2021 04:16:53 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Fz0SL5JSNz4x9Pt; Mon,  7 Jun
        2021 04:16:50 +0000 (GMT)
X-AuditID: b6c32a47-f61ff700000024d9-8e-60bd9db20b0a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.47.09433.2BD9DB06; Mon,  7 Jun 2021 13:16:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v36 0/4] scsi: ufs: Add Host Performance Booster Support
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
Message-ID: <20210607041650epcms2p29002c9d072738bbf21fb4acf31847e8e@epcms2p2>
Date:   Mon, 07 Jun 2021 13:16:50 +0900
X-CMS-MailID: 20210607041650epcms2p29002c9d072738bbf21fb4acf31847e8e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmhe6muXsTDK5/U7V4MG8bm8XethPs
        Fi9/XmWzmPbhJ7PFp/XLWC1eHtK02HXwIJvFqgfhFs2L17NZzDnbwGTR27+VzWLzwQ3MFo/v
        fGa3WHRjG5NF/792FottnwUtjp98x2hxedccNovu6zvYLJYf/8dksXTrTUaLzulrWBzEPC5f
        8fa43NfL5LFz1l12jwmLDjB67J+7ht2j5eR+Fo+PT2+xePRtWcXo8XmTnEf7gW6mAK6oHJuM
        1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoDeVFMoSc0qB
        QgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGhgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5Gf8/
        2Bbcsqh4tPQuewPjPZ0uRk4OCQETiVWnv7J1MXJxCAnsYJS4OOc5cxcjBwevgKDE3x3CIDXC
        Ah4SPRfOsoDYQgJKEusvzmKHiOtJ3Hq4hhHEZhPQkZh+4j47yBwRgVYWiW3fLoI5zALnmSX2
        3GhnhNjGKzGj/SkLhC0tsX35Vqi4hsSPZb3MELaoxM3Vb9lh7PfH5kPViEi03jsLVSMo8eDn
        bqi4pMSx3R+YIOx6ia13fjGCLJYQ6GGUOLzzFitEQl/iWsdGsMW8Ar4S3atWsoHYLAKqEtO/
        rGaDqHGR+PJmK9ggZgF5ie1v54BDgllAU2L9Ln0QU0JAWeLILRaYVxo2/mZHZzML8El0HP4L
        F98x7wnUaWoS636uZ4IYIyNxax7jBEalWYiQnoVk7SyEtQsYmVcxiqUWFOempxYbFRgjx+0m
        RnCK13LfwTjj7Qe9Q4xMHIyHGCU4mJVEeL1k9iQI8aYkVlalFuXHF5XmpBYfYjQFengis5Ro
        cj4wy+SVxBuaGpmZGViaWpiaGVkoifP+TK1LEBJITyxJzU5NLUgtgulj4uCUamBSqdHPajg7
        Y3+0x8tttp6tMlb8zQo/PA52TGF2W2xvl7pigovdnOZ/ZzbFKX3junbi4LLZlSvWpQd8q7P/
        1DS/9nPE1BsPnrNuCThUyiusWeorcGWf/AIntyOuNj6+p+NUviU4/z1fsXPWq59/om7/0Mw/
        s+/UmolCRV+Dl3q2rPxw1Pg6B+MulT+OGyp3l5clrDRd4RctfOZW4U/v6GftYT/n5FiwKhfd
        Ll3Br31r5hy9LMfbb/O0NS7bbu7zLCopePh9p5LYmpTKXZsSM7dt/n1s7Ru3wACuTUvjZ60O
        e92fGMn14KhP949LfX/NN72o8QotP2c3oaBbcsNGkxMB6vlFoSn3P4jNENprtjxLiaU4I9FQ
        i7moOBEAnZY9UXoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210607041650epcms2p29002c9d072738bbf21fb4acf31847e8e
References: <CGME20210607041650epcms2p29002c9d072738bbf21fb4acf31847e8e@epcms2p2>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Changelog:

v35 -> v36
1. Changed ppn variable type from u64 to __be64.
2. Added WARN_ON_ONCE() to check for HPB read IO size exceeded.

v34 -> v35
1. Addressed Bart's comments (type casting)
2. Rebase 5.14 scsi-queue

v33 -> v34
Fix warning about NULL check before some freeing functions is not needed.

v32 -> v33
1. Fix wrong usage of scsi_command_normalize_sense.
2. Addressed Bart's comments (func. name, type casting, parentheses)

v31 -> v32
Delete unused parameter of unmap API.

v30 -> v31
Delete unnecessary debug message.

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

 Documentation/ABI/testing/sysfs-driver-ufs |  162 ++
 drivers/scsi/ufs/Kconfig                   |    9 +
 drivers/scsi/ufs/Makefile                  |    1 +
 drivers/scsi/ufs/ufs-sysfs.c               |   22 +
 drivers/scsi/ufs/ufs.h                     |   54 +-
 drivers/scsi/ufs/ufshcd.c                  |   74 +-
 drivers/scsi/ufs/ufshcd.h                  |   30 +
 drivers/scsi/ufs/ufshpb.c                  | 2384 ++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h                  |  277 +++
 9 files changed, 3011 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

-- 
2.25.1

