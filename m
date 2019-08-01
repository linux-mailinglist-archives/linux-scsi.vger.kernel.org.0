Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5157E181
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfHAR4X (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41917 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4X (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so32421616pls.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QeZ/UX2i389M1wQ/CKZfcEdPNklX6puE1FH2henJ8As=;
        b=Ogw8JvFwjLpCAA+xJrEjyMCRSyUEx2KFnCwv3tTrBFATiBddIQyIiSBMbjLtUJye3c
         Kzzr+gCTK32RFh78FYH91YI2zX9w4Bj6U/W7FvSjQamOc7xRGAOs1m/H2E9kbLePCvDZ
         q8vQ/Ui5SLyjB2uyaWlRS50gF7wa1w6QfSACkgimRmGFgMo2VbFKsGXR+wumA1ye4Svo
         G/0yQGgrz9J7o112ejPg5xYT8VMUX5bRbY5ZUMCmL3ulHgaUj8IIcWUdNIRK/eLREG7V
         aW7vzxqZbGsOUwbAxpzVFaJCCIA59P2mOw++YaSJOeAE65ihit7VqHsVipP80iAUV5sU
         XkLA==
X-Gm-Message-State: APjAAAX2mFZ3mtbbRfO2mwmINY/YVd058CbqJjheBUeOoPXOiK/iHfhN
        g+GhSkWoGwActI8cPpKUS1c=
X-Google-Smtp-Source: APXvYqzLKVo0DKhYjnwSrUz7dBRuFPUEPKHxq9Q265LmYIwwqMQzUOskmgJssIf7+cyclChDWrQt3Q==
X-Received: by 2002:a17:902:7c90:: with SMTP id y16mr129382370pll.238.1564682182122;
        Thu, 01 Aug 2019 10:56:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/59] qla2xxx patches for kernel v5.4
Date:   Thu,  1 Aug 2019 10:55:15 -0700
Message-Id: <20190801175614.73655-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

The patches in this series improve the robustness of the QLogic Fibre Channel
initiator and target drivers. These patches are a result of manual code
inspection, analysis of Coverity reports and stress testing of these two
drivers. Please consider these patches for kernel version v5.4.

Thanks,

Bart.

Bart Van Assche (59):
  qla2xxx: Make qla2x00_abort_srb() again decrease the sp reference
    count
  qla2xxx: Really fix qla2xxx_eh_abort()
  qla2xxx: Improve Linux kernel coding style conformance
  qla2xxx: Use tabs instead of spaces for indentation
  qla2xxx: Include the <asm/unaligned.h> header file from qla_dsd.h
  qla2xxx: Remove an include directive from qla_mr.c
  qla2xxx: Remove a superfluous forward declaration
  qla2xxx: Declare the fourth ql_dump_buffer() argument const
  qla2xxx: Change the return type of qla2x00_update_ms_fdmi_iocb() into
    void
  qla2xxx: Reduce the scope of three local variables in
    qla2xxx_queuecommand()
  qla2xxx: Declare qla_tgt_cmd.cdb const
  qla2xxx: Change data_dsd into an array
  qla2xxx: Verify locking assumptions at runtime
  qla2xxx: Reduce the number of casts in GID list code
  qla2xxx: Simplify qlt_lport_dump()
  qla2xxx: Remove a superfluous pointer check
  qla2xxx: Remove two superfluous tests
  qla2xxx: Simplify qla24xx_abort_sp_done()
  qla2xxx: Fix session lookup in qlt_abort_work()
  qla2xxx: Report the firmware status code if a mailbox command fails
  qla2xxx: Do not corrupt vha->plogi_ack_list
  qla2xxx: Use strlcpy() instead of strncpy()
  qla2xxx: Complain if a mailbox command times out
  qla2xxx: Complain if parsing the version string fails
  qla2xxx: Remove dead code
  qla2xxx: Simplify a debug statement
  qla2xxx: Fix qla24xx_process_bidir_cmd()
  qla2xxx: Remove unreachable code from qla83xx_idc_lock()
  qla2xxx: Suppress a Coveritiy complaint about integer overflow
  qla2xxx: Suppress multiple Coverity complaint about out-of-bounds
    accesses
  qla2xxx: Always check the qla2x00_wait_for_hba_online() return value
  qla2xxx: Declare fourth qla2x00_set_model_info() argument const
  qla2xxx: Complain if waiting for pending commands times out
  qla2xxx: Check the PCI info string output buffer size
  qla2xxx: Use memcpy() and strlcpy() instead of strcpy() and strncpy()
  qla2xxx: Complain if a soft reset fails
  qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst
    IDs
  qla2xxx: Change the return type of qla24xx_read_flash_data()
  qla2xxx: Check secondary image if reading the primary image fails
  qla2xxx: Make it explicit that ELS pass-through IOCBs use little
    endian
  qla2xxx: Set the responder mode if appropriate for ELS pass-through
    IOCBs
  qla2xxx: Rework key encoding in qlt_find_host_by_d_id()
  qla2xxx: Enable type checking for the SRB free and done callback
    functions
  qla2xxx: Introduce the function qla2xxx_init_sp()
  qla2xxx: Fix a race condition between aborting and completing a SCSI
    command
  qla2xxx: Make qlt_handle_abts_completion() more robust
  qla2xxx: Modify NVMe include directives
  qla2xxx: Rename qla24xx_async_abort_command() into
    qla24xx_sync_abort_command()
  qla2xxx: Introduce qla2xxx_get_next_handle()
  qla2xxx: Make sure that aborted commands are freed
  qla2xxx: Complain if sp->done() is not called from the completion path
  qla2xxx: Let the compiler check the type of the SCSI command context
    pointer
  qla2xxx: Remove superfluous sts_entry_* casts
  qla2xxx: Report invalid mailbox status codes
  qla2xxx: Inline the qla2x00_fcport_event_handler() function
  qla2xxx: Introduce qla2x00_els_dcmd2_free()
  qla2xxx: Remove two superfluous if-tests
  qla2xxx: Simplify qla24xx_async_abort_cmd()
  qla2xxx: Fix a NULL pointer dereference

 drivers/scsi/qla2xxx/qla_attr.c    |   6 +-
 drivers/scsi/qla2xxx/qla_bsg.c     |  19 +-
 drivers/scsi/qla2xxx/qla_dbg.c     |   3 +-
 drivers/scsi/qla2xxx/qla_def.h     | 130 ++++++++++----
 drivers/scsi/qla2xxx/qla_dfs.c     |   9 +-
 drivers/scsi/qla2xxx/qla_dsd.h     |   2 +
 drivers/scsi/qla2xxx/qla_fw.h      |   8 +-
 drivers/scsi/qla2xxx/qla_gbl.h     |  35 ++--
 drivers/scsi/qla2xxx/qla_gs.c      | 219 +++++++++--------------
 drivers/scsi/qla2xxx/qla_init.c    | 267 +++++++++++------------------
 drivers/scsi/qla2xxx/qla_inline.h  |  28 +--
 drivers/scsi/qla2xxx/qla_iocb.c    | 221 +++++++++---------------
 drivers/scsi/qla2xxx/qla_isr.c     |  24 ++-
 drivers/scsi/qla2xxx/qla_mbx.c     |  12 +-
 drivers/scsi/qla2xxx/qla_mid.c     |   4 +-
 drivers/scsi/qla2xxx/qla_mr.c      |  67 ++++----
 drivers/scsi/qla2xxx/qla_nvme.c    |  28 +--
 drivers/scsi/qla2xxx/qla_nvme.h    |   5 +-
 drivers/scsi/qla2xxx/qla_nx.c      |  16 +-
 drivers/scsi/qla2xxx/qla_nx.h      |  14 +-
 drivers/scsi/qla2xxx/qla_nx2.c     |   2 +-
 drivers/scsi/qla2xxx/qla_os.c      | 222 ++++++++++--------------
 drivers/scsi/qla2xxx/qla_sup.c     |   8 +-
 drivers/scsi/qla2xxx/qla_target.c  | 209 +++++++++-------------
 drivers/scsi/qla2xxx/qla_target.h  |  35 ++--
 drivers/scsi/qla2xxx/qla_tmpl.c    |   7 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  27 ++-
 include/linux/nvme-fc-driver.h     |   2 +
 28 files changed, 685 insertions(+), 944 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

