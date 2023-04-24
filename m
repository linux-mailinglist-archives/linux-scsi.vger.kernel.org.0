Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B456D965B
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Apr 2023 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjDFLw5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Apr 2023 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjDFLwn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Apr 2023 07:52:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419393D7;
        Thu,  6 Apr 2023 04:49:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n21so681100ejz.4;
        Thu, 06 Apr 2023 04:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680781700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Quh4QY3JnRLocKgz5XvptYfn++I40WaZ7uMI+HRYfMU=;
        b=ZGdouI6IPZUuoJk4ngSx1QiKmoxJ0Bn7LlXYHaWGRk9IwPFgfcar8HVvUWmQPWfzeC
         9RjChwfOoYNoLrMnimufRmNV4gPocHuqK8KSIZGONkiaTVpKcs4m9j7Fux097wo3PiAX
         zQkjFHdnkHsf/4ec4Jh0HhTy2WL2DQg+jjmOHhc00Cue05pN+vW4doLdc3mQJZ+pLv1U
         2hLJfKPB6lWDgr8G48VyocsKCp27b7dGk5RIsveailW14MgGIwWz7sHwoAfaAKucj5Xm
         jXixW31h56cxCZIzQdMWZS4b7o9Gb1DqTGSE1AnTH/3qBfjwndYiG4vjkOX8vBQ4Cs/K
         CHIQ==
X-Gm-Message-State: AAQBX9fWwOo1ZhMEiFjLFmPXIaCNCXlQmBvK6v9tiA/JK0j4cwhP8IR1
        n35kQMtS15FsngAokdAogPRfMq43sAPXYQ==
X-Google-Smtp-Source: AKy350bODNvPb/AfY03iDk1K3+tRvaoChWKENP827zQVkOp9ya89ohnXFbQefu/vdAH25SlPstmTZg==
X-Received: by 2002:ac2:55a8:0:b0:4e8:3fc7:9483 with SMTP id y8-20020ac255a8000000b004e83fc79483mr2656419lfg.23.1680780855722;
        Thu, 06 Apr 2023 04:34:15 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.246.252])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b004b5480edf67sm227344lft.36.2023.04.06.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:34:15 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 629E9122F; Thu,  6 Apr 2023 13:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680780853; bh=lq+efUuexgFuVDcbIeczEsr6ki0PJAiMIYS0ueAY2P8=;
        h=From:To:Cc:Subject:Date:From;
        b=sBrM6Vz1+x3GsTzgwm2H/i29ghQse86q+XR1aguStNyR2F2P44TEcaTO2pC8u4LGD
         ZnLYw3OKAMZPJrRnOQgICvA9Z2zvEMcZvnBWFonrj566jEhvv4ouBZvwm1zys863Oq
         aQY3tSb5vTa+zMAuqliNUUl04dNsLFkm1gwPF/hg=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id B27051F7;
        Thu,  6 Apr 2023 13:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680780785; bh=lq+efUuexgFuVDcbIeczEsr6ki0PJAiMIYS0ueAY2P8=;
        h=From:To:Cc:Subject:Date:From;
        b=X/vbD5qXbCGSlMwaITxA2I/hKAc+VVzYgLu+Pna+wn9PNiUXH4FUu5szs4GsKZSm+
         p2RyUYWMS4tD6B/AJG/U/tkzwXlknvGhw7V1ZLUy1dU7yac2s8HVcIdnDhlcjVdfzj
         4n4XhdLaxlOYrc5xADZtRkRs0icQvio77O2gAUHc=
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@fastmail.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v6 00/19] Add Command Duration Limits support
Date:   Thu,  6 Apr 2023 13:32:29 +0200
Message-Id: <20230406113252.41211-1-nks@flawful.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Hello,

This series adds support for Command Duration Limits.
The series is based on linux tag: v6.3-rc5
The series can also be found in git:
https://github.com/floatious/linux/commits/cdl-v6


=================
CDL in ATA / SCSI
=================
Command Duration Limits is defined in:
T13 ATA Command Set - 5 (ACS-5) and
T10 SCSI Primary Commands - 6 (SPC-6) respectively
(a simpler version of CDL is defined in T10 SPC-5).

CDL defines Duration Limits Descriptors (DLD).
7 DLDs for read commands and 7 DLDs for write commands.
Simply put, a DLD contains a limit and a policy.

A command can specify that a certain limit should be applied by setting
the DLD index field (3 bits, so 0-7) in the command itself.

The DLD index points to one of the 7 DLDs.
DLD index 0 means no descriptor, so no limit.
DLD index 1-7 means DLD 1-7.

A DLD can have a few different policies, but the two major ones are:
-Policy 0xF (abort), command will be completed with command aborted error
(ATA) or status CHECK CONDITION (SCSI), with sense data indicating that
the command timed out.
-Policy 0xD (complete-unavailable), command will be completed without
error (ATA) or status GOOD (SCSI), with sense data indicating that the
command timed out. Note that the command will not have transferred any
data to/from the device when the command timed out, even though the
command returned success.

Regardless of the CDL policy, in case of a CDL timeout, the I/O will
result in a -ETIME error to user-space.

The DLDs are defined in the CDL log page(s) and are readable and writable.
Reading and writing the CDL DLDs are outside the scope of the kernel.
If a user wants to read or write the descriptors, they can do so using a
user-space application that sends passthrough commands, such as cdl-tools:
https://github.com/westerndigitalcorporation/cdl-tools/commits/cdl-v4


================================
The introduction of ioprio hints
================================
What the kernel does provide, is a method to let I/O use one of the CDL DLDs
defined in the device. Note that the kernel will simply forward the DLD index
to the device, so the kernel currently does not know, nor does it need to know,
how the DLDs are defined inside the device.

The way that the CDL DLD index is supplied to the kernel is by introducing a
new 10 bit "ioprio hint" field within the existing 16 bit ioprio definition.

Currently, only 6 out of the 16 ioprio bits are in use, the remaining 10 bits
are unused, and are currently explicitly disallowed to be set by the kernel.

For now, we only add ioprio hints representing CDL DLD index 1-7. Additional
ioprio hints for other QoS features could be defined in the future.

A theoretical future work could be to make an I/O scheduler aware of these
hints. E.g. for CDL, an I/O scheduler could make use of the duration limit
in each descriptor, and take that information into account while scheduling
commands. Right now, the ioprio hints will be ignored by the I/O schedulers.


==============================
How to use CDL from user-space
==============================
Since CDL is mutually exclusive with NCQ priority
(see ncq_prio_enable and sas_ncq_prio_enable in
Documentation/ABI/testing/sysfs-block-device),
CDL has to be explicitly enabled using:
echo 1 > /sys/block/$bdev/device/cdl_enable

Since the ioprio hints are supplied through the existing I/O priority API,
it should be simple for an application to make use of the ioprio hints.

It simply has to reuse one of the new macros defined in
include/uapi/linux/ioprio.h: IOPRIO_PRIO_HINT() or IOPRIO_PRIO_VALUE_HINT(),
and supply one of the new hints defined in include/uapi/linux/ioprio.h:
IOPRIO_HINT_DEV_DURATION_LIMIT_[1-7], which indicates that the I/O should
use the corresponding CDL DLD index 1-7.

By reusing the I/O priority API, the user can both define a DLD to use per
AIO (io_uring sqe->ioprio or libaio iocb->aio_reqprio) or per-thread
(ioprio_set()).


=======
Testing
=======
With the following fio patches:
https://github.com/floatious/fio/commits/cdl-v4

fio adds support for ioprio hints, such that CDL can be tested using e.g.:
fio --ioengine=io_uring --cmdprio_percentage=10 --cmdprio_hint=DLD_index

A simple way to test is to use a DLD with a very short duration limit,
and send large reads. Regardless of the CDL policy, in case of a CDL
timeout, the I/O will result in a -ETIME error to user-space.

We also provide a CDL test suite located in the cdl-tools repo, see:
https://github.com/westerndigitalcorporation/cdl-tools/blob/cdl-v4/README.md#testing-a-system-command-duration-limits-support


We have tested this patch series using:
-real hardware
-the following QEMU implementation:
https://github.com/floatious/qemu/tree/cdl
(NOTE: the QEMU implementation requires you to define the CDL policy at compile
time, so you currently need to recompile QEMU when switching between policies.)


===================
Further information
===================
For further information about CDL, see Damien's slides:

Presented at SDC 2021:
https://www.snia.org/sites/default/files/SDC/2021/pdfs/SNIA-SDC21-LeMoal-Be-On-Time-command-duration-limits-Feature-Support-in%20Linux.pdf

Presented at Lund Linux Con 2022:
https://drive.google.com/file/d/1I6ChFc0h4JY9qZdO1bY5oCAdYCSZVqWw/view?usp=sharing


================
Changes since V5
================
-Picked up Reviewed-by tags from Hannes (Thank you Hannes!)
-Picked up Reviewed-by tag from Igor (Thank you Igor!)
-Patch "scsi: allow enabling and disabling command duration limits" no longer
 requires CAP_SYS_ADMIN to store cdl_enable. This way, cdl_enable is in line
 with the existing ncq_prio_enable attribute. (Thank you Igor!)
-Clarified commit message for patch "ata: libata: set read/write commands CDL
 index". CDL index is 3 bits, not 2 bits. (Thank you Igor!)


For older change logs, see previous patch series versions:
https://lore.kernel.org/linux-scsi/20230404182428.715140-1-nks@flawful.org/
https://lore.kernel.org/linux-scsi/20230309215516.3800571-1-niklas.cassel@wdc.com/
https://lore.kernel.org/linux-scsi/20230124190308.127318-1-niklas.cassel@wdc.com/
https://lore.kernel.org/linux-scsi/20230112140412.667308-1-niklas.cassel@wdc.com/
https://lore.kernel.org/linux-scsi/20221208105947.2399894-1-niklas.cassel@wdc.com/


Kind regards,
Niklas & Damien

Damien Le Moal (13):
  ioprio: cleanup interface definition
  block: introduce ioprio hints
  block: introduce BLK_STS_DURATION_LIMIT
  scsi: support retrieving sub-pages of mode pages
  scsi: support service action in scsi_report_opcode()
  scsi: detect support for command duration limits
  scsi: allow enabling and disabling command duration limits
  scsi: sd: set read/write commands CDL index
  ata: libata: detect support for command duration limits
  ata: libata-scsi: handle CDL bits in ata_scsiop_maint_in()
  ata: libata-scsi: add support for CDL pages mode sense
  ata: libata: add ATA feature control sub-page translation
  ata: libata: set read/write commands CDL index

Niklas Cassel (6):
  scsi: core: allow libata to complete successful commands via EH
  scsi: rename and move get_scsi_ml_byte()
  scsi: sd: handle read/write CDL timeout failures
  ata: libata-scsi: remove unnecessary !cmd checks
  ata: libata: change ata_eh_request_sense() to not set CHECK_CONDITION
  ata: libata: handle completion of CDL commands using policy 0xD

 Documentation/ABI/testing/sysfs-block-device |  22 ++
 block/bfq-iosched.c                          |   8 +-
 block/blk-core.c                             |   3 +
 block/ioprio.c                               |   6 +-
 drivers/ata/libata-core.c                    | 204 +++++++++-
 drivers/ata/libata-eh.c                      | 130 ++++++-
 drivers/ata/libata-sata.c                    | 103 ++++-
 drivers/ata/libata-scsi.c                    | 384 +++++++++++++++----
 drivers/ata/libata.h                         |   2 +-
 drivers/scsi/scsi.c                          | 171 ++++++++-
 drivers/scsi/scsi_error.c                    |  48 ++-
 drivers/scsi/scsi_lib.c                      |  15 +-
 drivers/scsi/scsi_priv.h                     |   6 +
 drivers/scsi/scsi_scan.c                     |   3 +
 drivers/scsi/scsi_sysfs.c                    |  30 ++
 drivers/scsi/scsi_transport_sas.c            |   2 +-
 drivers/scsi/sd.c                            |  59 ++-
 drivers/scsi/sr.c                            |   2 +-
 include/linux/ata.h                          |  11 +-
 include/linux/blk_types.h                    |   6 +
 include/linux/libata.h                       |  42 +-
 include/scsi/scsi_cmnd.h                     |   5 +
 include/scsi/scsi_device.h                   |  18 +-
 include/uapi/linux/ioprio.h                  |  68 +++-
 24 files changed, 1198 insertions(+), 150 deletions(-)

-- 
2.39.2

