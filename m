Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB72E614
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2U2j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35858 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so2375072pfm.3
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMtlP+wQmunNVPzgnPuafJ+m3ccUeeK2SJZs6Nyfyh0=;
        b=kR0ju0kNgunfht9okQcP+7cV0Y0U4r0HLBF+LuzCtaJNjbXnPO1TM5qHxQ/ajJJFid
         6zKqAcDUQRDOoBnV+eJcyruBwRR875WI8W4E/0YOW/kwTPVfGs/kRGs60YaoPzRZEK96
         S6aMpjOwUwv5ZEYQ8Q3t8btCTIyT65Zy63XbdlE2nKBGUuzdbKPHGgmjgjmfCiOnxF09
         xe3rexq8K0U4iiK+6KDGCyW02965LagbczwbSJMhFy2TVjRQmxlcajU3jLgzj5kb7n7e
         +DX1u55bp1wRUBXHWbaKPJdkZhwLw08vb/awSV11AY61+7g66GZM9K+w7AR1Lt0t/lft
         bExw==
X-Gm-Message-State: APjAAAWRS2MI6BVkOFA3/c/5NtHFyI0D4WJdIlckCJ1xMd5lV51ojNM2
        PS3i/7mtIVKTVto/IPLYfek=
X-Google-Smtp-Source: APXvYqxmVG9yYZeIM2MyqzEjwk5NX/Y3m2E/4sNpoqhOT/q8c9S9NLzaayxL1wm2mOi80tEfr90xSQ==
X-Received: by 2002:a17:90a:207:: with SMTP id c7mr14605125pjc.94.1559161718263;
        Wed, 29 May 2019 13:28:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/20] qla2xxx Patches
Date:   Wed, 29 May 2019 13:28:06 -0700
Message-Id: <20190529202826.204499-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This patch series is the result of code review, inspection of the Coverity
output and actual testing. The first two patches in this series are intended
for the current release cycle (kernel v5.2) and the other 18 patches are
intended for the kernel v5.3 merge window. Please consider these patches.

Thanks,

Bart.

Bart Van Assche (20):
  qla2xxx: Include the <asm/unaligned.h> header file from qla_dsd.h
  qla2xxx: Really fix abort handling
  qla2xxx: Remove an include directive from qla_mr.c
  qla2xxx: Remove a forward declaration
  qla2xxx: Declare the fourth ql_dump_buffer() argument const
  qla2xxx: Change the return type of qla2x00_update_ms_fdmi_iocb() into
    void
  qla2xxx: Reduce the scope of three local variables in
    qla2xxx_queuecommand()
  qla2xxx: Declare qla_tgt_cmd.cdb const
  qla2xxx: Change data_dsd into an array
  qla2xxx: Verify locking assumptions at runtime
  qla2xxx: Reduce the number of casts in GID list code
  qla2xxx: Improve Linux kernel coding style conformance
  qla2xxx: Remove two superfluous if-tests
  qla2xxx: Simplify qlt_lport_dump()
  qla2xxx: Introduce qla2x00_els_dcmd2_free()
  qla2xxx: Remove a superfluous pointer check
  qla2xxx: Remove two superfluous tests
  qla2xxx: Fix session lookup in qlt_abort_work()
  qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst
    IDs
  qla2xxx: Fix qla24xx_abort_sp_done()

 drivers/scsi/qla2xxx/qla_dbg.c     |   3 +-
 drivers/scsi/qla2xxx/qla_def.h     |  75 ++++++++++--
 drivers/scsi/qla2xxx/qla_dfs.c     |   9 +-
 drivers/scsi/qla2xxx/qla_dsd.h     |   2 +
 drivers/scsi/qla2xxx/qla_gbl.h     |   4 +-
 drivers/scsi/qla2xxx/qla_gs.c      |  41 +++----
 drivers/scsi/qla2xxx/qla_init.c    |  42 +++----
 drivers/scsi/qla2xxx/qla_iocb.c    |  44 ++++----
 drivers/scsi/qla2xxx/qla_mr.c      |   1 -
 drivers/scsi/qla2xxx/qla_nvme.c    |   4 +-
 drivers/scsi/qla2xxx/qla_nvme.h    |   2 +-
 drivers/scsi/qla2xxx/qla_nx.c      |  10 +-
 drivers/scsi/qla2xxx/qla_nx.h      |  14 +--
 drivers/scsi/qla2xxx/qla_os.c      |  40 ++++---
 drivers/scsi/qla2xxx/qla_target.c  | 176 +++++++++++------------------
 drivers/scsi/qla2xxx/qla_target.h  |  35 ++----
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  23 +---
 17 files changed, 250 insertions(+), 275 deletions(-)

-- 
2.22.0.rc1

