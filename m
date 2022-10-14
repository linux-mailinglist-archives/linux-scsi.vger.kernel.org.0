Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2A5FED53
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Oct 2022 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJNLqQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Oct 2022 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJNLqL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Oct 2022 07:46:11 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE239B9A;
        Fri, 14 Oct 2022 04:46:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D003A41221;
        Fri, 14 Oct 2022 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1665747962; x=
        1667562363; bh=ahlSnG95Xtsu+0T2AjOccxYoUBX+Q73S3C5lgCqaICU=; b=a
        cuhxxWRehjMclmVi2Av7mh+gzr/HaN2cnYO4Vn1AZznBtkBaWQu5hYLDqgoAqWaL
        oww5xwUH9stA1F7E+LVc09JaUEvlrSnUPoUVESabC9cPnv4TfMCpg1qetPGrXhKJ
        Q3fP3s+KBT4gYShSq4bA/3EWtRm5zb5bJ7gq0Cspv0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cNp73C1AD4fI; Fri, 14 Oct 2022 14:46:02 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DD8DD4120D;
        Fri, 14 Oct 2022 14:46:02 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 14 Oct 2022 14:46:02 +0300
Received: from localhost (10.199.23.220) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Fri, 14 Oct
 2022 14:46:02 +0300
From:   Anastasia Kovaleva <a.kovaleva@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>
Subject: [v2,PATCH 0/3] Make target send correct io limits
Date:   Fri, 14 Oct 2022 14:45:46 +0300
Message-ID: <20221014114549.32888-1-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.23.220]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently iblock always reports MAXIMUM TRANSFER LENGTH in 512b units
regardless of the LU block size.

Target block size:
  target:~ # fdisk -l /dev/nullb0
  Disk /dev/nullb0: 250 GiB, 268435456000 bytes, 65536000 sectors
  Units: sectors of 1 * 4096 = 4096 bytes
  Sector size (logical/physical): 4096 bytes / 4096 bytes
  I/O size (minimum/optimal): 4096 bytes / 4096 bytes

Initiator block size:
  initiator:~ # fdisk -l /dev/sdc
  Disk /dev/sdc: 250 GiB, 268435456000 bytes, 65536000 sectors
  Disk model: nullb0
  Units: sectors of 1 * 4096 = 4096 bytes
  Sector size (logical/physical): 4096 bytes / 4096 bytes
  I/O size (minimum/optimal): 4096 bytes / 131072 bytes

target max transfer length limit:
  target:~ # cat /sys/block/nullb0/queue/max_hw_sectors_kb
  128

So the maximum transfer length should be 128 * 1024 / 4096 = 32 blocks
But the target sends MTL in 512b units, so the initiators see 256 blocks
instead.

  initiator:~ # sg_inq -p 0xb0 /dev/sdc
  VPD INQUIRY: Block limits page (SBC)
    Maximum compare and write length: 1 blocks
    Optimal transfer length granularity: 1 blocks
    Maximum transfer length: 256 blocks
    Optimal transfer length: 32 blocks
    Maximum prefetch transfer length: 0 blocks [ignored]

This happens because MAXIMUM TRANSFER LENGTH field in VPD Block Limits
page is derived from dev->dev_attrib.hw_max_sectors which happens to be
in 512b units for iblock. This patch series fixes this issue and removes
some special-casing for other backstores.

The last time this patch set was sent, a kernel bot found some issues
with building a kernel for i586 and m68k using a cross-compiler. I tried
to reproduce this issues locally but didn't succeed. Even with given
configs all things are built correctly without errors. For m68k I used
m68k-linux-gnu-gcc version 11.2.0, for i586 I used
i586-unknown-linux-gnu-gcc version 8.3.0. It would be great if you could
share the kernel bot’s cross-compilers.

Anastasia Kovaleva (3):
  target: core: Send mtl in blocks
  target: core: make hw_max_sectors store the sectors amount in blocks
  target: core: Change the way target_xcopy_do_work sets restiction on
    max io

 drivers/target/target_core_configfs.c |  2 -
 drivers/target/target_core_file.c     |  1 -
 drivers/target/target_core_iblock.c   |  4 +-
 drivers/target/target_core_spc.c      |  6 +-
 drivers/target/target_core_xcopy.c    | 96 ++++++++++++++-------------
 drivers/target/target_core_xcopy.h    |  2 +-
 include/target/target_core_base.h     |  1 -
 7 files changed, 59 insertions(+), 53 deletions(-)

-- 
2.30.2

