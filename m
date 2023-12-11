Return-Path: <linux-scsi+bounces-830-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C830E80D403
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6591C215D5
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDCB4E1DC;
	Mon, 11 Dec 2023 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JpTqsB3Y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1687BD5;
	Mon, 11 Dec 2023 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7085; q=dns/txt; s=iport;
  t=1702316189; x=1703525789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qwwY/uFA8S6JXaGXNqn1SvKTk5spXoxgr24xxgmRk2I=;
  b=JpTqsB3YCwVdInk5W2jlKz5Ct9Vg7SZVYEh2GAw42Yg2URo/hIiqgG/K
   gliLnfKWMqBa9UHKPaaaWsyqoHuQxaWFdLEyJT36kAUnwQV+V/0XewNn8
   MfJFUwn93xVivYcHR5AlbFO0upIGdDP+8k5LtS8o+cmjaWj1E4j9UK7vk
   A=;
X-CSE-ConnectionGUID: 7Be1vfFcQZOfNb5CKDhjcQ==
X-CSE-MsgGUID: vrpfkwZPR0uoFx34DuORyw==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="186631691"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:36:28 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKqs009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:36:27 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 00/13] Introduce support for multiqueue (MQ) in fnic 
Date: Mon, 11 Dec 2023 09:36:04 -0800
Message-Id: <20231211173617.932990-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-1.cisco.com

Hi Martin, reviewers,

This cover letter describes the feature: add support for multiqueue (MQ)
to fnic driver.

Background: The Virtual Interface Card (VIC) firmware exposes several
queues that can be configured for sending IOs and receiving IO
responses. Unified Computing System Manager (UCSM) and Intersight
Manager (IMM) allows users to configure the number of queues to be
used for IOs.

The number of IO queues to be used is stored in a configuration file
by the VIC firmware. The fNIC driver reads the configuration file and sets
the number of queues to be used. Previously, the driver was hard-coded
to use only one queue. With this set of changes, the fNIC driver will
configure itself to use multiple queues. This feature takes advantage of
the block multiqueue layer to parallelize IOs being sent out of the VIC
card.

Here's a brief description of some of the salient patches:

- vnic_scsi.h needs to be in sync with VIC firmware to be able to read
the number of queues from the firmware config file. A patch has been
created for this.
- In an environment with many fnics (like we see in our customer
environments), it is hard to distinguish which fnic is printing logs.
Therefore, an fnic number has been included in the logs.
- read the number of queues from the firmware config file.
- include definitions in fnic.h to support multiqueue.
- modify the interrupt service routines (ISRs) to read from the
correct registers. The numbers that are used here come from discussions
with the VIC firmware team.
- track IO statistics for different queues.
- remove usage of host_lock, and only use fnic_lock in the fnic driver.
- use a hardware queue based spinlock to protect io_req.
- replace the hard-coded zeroth queue with a hardware queue number.
This presents a bulk of the changes.
- modify the definition of fnic_queuecommand to accept multiqueue tags.
- improve log messages, and indicate fnic number and multiqueue tags for
effective debugging.

Even though the patches have been made into a series, some patches are
heavier than others.
But, every effort has been made to keep the purpose of each patch as
a single-purpose, and to compile cleanly.

This patchset has been tested as a whole. Therefore, the tested-by fields
have been added only to two patches
in the set. All the individual patches compile cleanly. However,
I've refrained from adding tested-by to
most of the patches, so as to not mislead the reviewer/reader.

A brief note on the unit tests:

1. Increase number of queues to 64. Load driver. Run IOs via Medusa.
12+ hour run successful.
2. Configure multipathing, and run link flaps on single link.
IOs drop briefly, but pick up as expected.
3. Configure multipathing, and run link flaps on two links, with a
30 second delay in between. IOs drop briefly, but pick up as expected.

Repeat the above tests with 1 queue and 32 queues.
All tests were successful.

Please consider this patch series for the next merge window.

Changes between v1 and v2:
        Suppress a warning raised by a kernel test bot,
        Incorporate the following review comments from Bart:
        Remove outdated comment,
        Remove unnecessary out of range tag checks,
        Remove unnecessary local variable,
        Modify function name.

Changes between v2 and v3:
    Incorporate review comment from Hannes:
        Modify FNIC_MAIN_DBG to prepend fnic number.
    Modify FNIC_MAIN_DBG definition to prepend function name
    and line number.
    Modify FNIC_FCS_DBG definition to prepend function name
    and line number.
    Replace FNIC_MAIN_DBG with FNIC_FCS_DBG in fnic_fcs.c
    Use fnic_num as an argument to FNIC_MAIN_DBG and FNIC_FCS_DBG.
        Host number is still used as an argument to
        FNIC_MAIN_DBG and FNIC_FCS_DBG since it in turn
        uses shost_printk.
    Replace cpy_wq_base with copy_wq_base.
    Incorporate the following review comments from Hannes:
        Replace cpy_wq_base with copy_wq_base.
        Remove C99 style comment.
        Extend review comments of FNIC_MAIN_DBG and FNIC_SCSI_DBG
        to FNIC_ISR_DBG:
                Use fnic_num as an argument to FNIC_ISR_DBG.
                Modify definition of FNIC_ISR_DBG.
                Host number is still used as an argument to
                FNIC_ISR_DBG since it in turn uses
                shost_printk.
                Removed reviewed by tag from Hannes due to
                additional modifications.
    Squash the following commits into one:
    scsi: fnic: Remove usage of host_lock
    scsi: fnic: Use fnic_lock to protect fnic structures
    in queuecommand
    Incorporate review comment from Hannes:
        Replace cpy_wq_base with copy_wq_base.
    Incorporate review comment from John Garry:
         Replace code in fnic_mq_map_queues_cpus
         with blk_mq_pci_map_queues.
    Replace shost_printk logs with FNIC_MAIN_DBG.
    Incorporate the following review comments from Hannes:
        Replace cpy_wq_base with copy_wq_base.
        Remove hwq as an argument to fnic_queuecommand_int.
    Suppress warning from kernel test robot.
    Replace new shost_printk comments with FNIC_SCSI_DBG.
    Replace fnic_queuecommand_int with fnic_queuecommand.
    Incorporate the following review comment from Hannes:
        Use fnic_num as an argument to FNIC_SCSI_DBG.
        Modify definition of FNIC_SCSI_DBG.
                Host number is still an argument since
        FNIC_SCSI_DBG in turn uses shost_printk.
        Create a separate patch to increment driver version.
        Increment driver version number to 1.7.0.0.

Changes between v3 and v4:
	Incorporate review comments from Martin and Hannes:
		Undo the change to replace host number with fnic
		number in debugfs since kernel stack uses host number.
		Use ida_alloc to allocate ID for fnic number.

Changes between v4 and v5:
	Incorporate review comments from Martin:
		Modify patch commits to include a "---" separator.

Changes between v5 and v6:
    Incorporate comments from Martin:
		Rebase changes to 6.8/scsi-queue,
		Resolve merge conflicts.

Thanks and regards,
Karan


Karan Tilak Kumar (13):
  scsi: fnic: Modify definitions to sync with VIC firmware
  scsi: fnic: Add and use fnic number
  scsi: fnic: Add and improve log messages
  scsi: fnic: Rename wq_copy to hw_copy_wq
  scsi: fnic: Get copy workqueue count and interrupt mode from config
  scsi: fnic: Refactor and redefine fnic.h for multiqueue
  scsi: fnic: Modify ISRs to support multiqueue(MQ)
  scsi: fnic: Define stats to track multiqueue (MQ) IOs
  scsi: fnic: Remove usage of host_lock
  scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
  scsi: fnic: Add support for multiqueue (MQ) in fnic driver
  scsi: fnic: Improve logs and add support for multiqueue (MQ)
  scsi: fnic: Increment driver version

 drivers/scsi/fnic/fnic.h       |  68 ++-
 drivers/scsi/fnic/fnic_fcs.c   |  63 +--
 drivers/scsi/fnic/fnic_isr.c   | 168 +++++--
 drivers/scsi/fnic/fnic_main.c  | 144 ++++--
 drivers/scsi/fnic/fnic_res.c   |  48 +-
 drivers/scsi/fnic/fnic_scsi.c  | 868 ++++++++++++++++++---------------
 drivers/scsi/fnic/fnic_stats.h |   3 +
 drivers/scsi/fnic/fnic_trace.c |  11 +
 drivers/scsi/fnic/vnic_dev.c   |   4 +
 drivers/scsi/fnic/vnic_scsi.h  |  13 +-
 10 files changed, 847 insertions(+), 543 deletions(-)

-- 
2.31.1


