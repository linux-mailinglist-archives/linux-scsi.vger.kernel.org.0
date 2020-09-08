Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFD260D3E
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgIHIP7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 04:15:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgIHIPZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 8 Sep 2020 04:15:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 340BDACF2;
        Tue,  8 Sep 2020 08:15:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Martin Wilck <mwilck@suse.com>, Arun Easi <aeasi@marvell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/4] qla2xxx: A couple crash fixes
Date:   Tue,  8 Sep 2020 10:15:12 +0200
Message-Id: <20200908081516.8561-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The first crash we observed is due memory corruption in the srb memory
pool. Unforuntatly, I couldn't find the source of the problem but the
workaround by resetting the cleanup callbacks 'fixes' this problem
(patch #1). I think as intermeditate step this should be merged until
the real cause can be identified.

The second crash is due a race condition(?) in the firmware. The sts
entries are not updated in time which leads to this crash pattern
which several customers have reported:

 #0 [c00000ffffd1bb80] scsi_dma_unmap at d00000001e4904d4 [scsi_mod]
 #1 [c00000ffffd1bbe0] qla2x00_sp_compl at d0000000204803cc [qla2xxx]
 #2 [c00000ffffd1bc20] qla24xx_process_response_queue at d0000000204c5810 [qla2xxx]
 #3 [c00000ffffd1bd50] qla24xx_msix_rsp_q at d0000000204c8fd8 [qla2xxx]
 #4 [c00000ffffd1bde0] __handle_irq_event_percpu at c000000000189510
 #5 [c00000ffffd1bea0] handle_irq_event_percpu at c00000000018978c
 #6 [c00000ffffd1bee0] handle_irq_event at c00000000018984c
 #7 [c00000ffffd1bf10] handle_fasteoi_irq at c00000000018efc0
 #8 [c00000ffffd1bf40] generic_handle_irq at c000000000187f10
 #9 [c00000ffffd1bf60] __do_irq at c000000000018784
 #10 [c00000ffffd1bf90] call_do_irq at c00000000002caa4
 #11 [c00000ecca417a00] do_IRQ at c000000000018970
 #12 [c00000ecca417a50] restore_check_irq_replay at c00000000000de98

From analyzing the crash dump it was clear that
qla24xx_mbx_iocb_entry() calls sp->done (qla2x00_sp_compl) which
crashes because the response is not a mailbox entry, it is a status
entry. Patch #4 changes the process logic for mailbox commands so that
the sp is parsed before calling the correct proccess function.


changes since v1:
 - addressed review comments by Martin
   - patch#1: added dummy warn function
   - patch#4: added log entry

changes since v2:
 - added reviewed tags by Martin
 - addressed review comments by Arun
   - patch#1: add srb pointer to log message
   - patch#3: print calling func name in qla2x00_get_sp_from_handle()
   - patch#4: dropped comment, reset HBA


Daniel Wagner (4):
  qla2xxx: Warn if done() or free() are called on an already freed srb
  qla2xxx: Simplify return value logic in qla2x00_get_sp_from_handle()
  qla2xxx: Log calling function name in qla2x00_get_sp_from_handle()
  qla2xxx: Handle incorrect entry_type entries

 drivers/scsi/qla2xxx/qla_init.c   | 10 +++++++++
 drivers/scsi/qla2xxx/qla_inline.h |  5 +++++
 drivers/scsi/qla2xxx/qla_isr.c    | 47 ++++++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 11 deletions(-)

-- 
2.16.4

