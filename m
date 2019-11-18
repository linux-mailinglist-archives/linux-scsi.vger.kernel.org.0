Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA631005A2
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRMaP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 07:30:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:59964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfKRMaP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 07:30:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE865AD49;
        Mon, 18 Nov 2019 12:30:13 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
Date:   Mon, 18 Nov 2019 13:30:12 +0100
Message-Id: <20191118123012.99664-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The lpfc driver allocates a cpu_map based on the number of possible
cpus during startup. If a CPU hotplug occurs the number of CPUs
might change, causing an out-of-bounds access when trying to lookup
the hardware index for a given CPU.

Suggested-by: Daniel Wagner <daniel.wagner@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ba26df90a36a..2380452a8efd 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -642,7 +642,8 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	int tag;
 	struct fcp_cmd_rsp_buf *tmp = NULL;
 
-	cpu = raw_smp_processor_id();
+	cpu = min_t(u32, raw_smp_processor_id(),
+		    phba->sli4_hba.num_possible_cpu);
 	if (cmnd && phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ) {
 		tag = blk_mq_unique_tag(cmnd->request);
 		idx = blk_mq_unique_tag_to_hwq(tag);
-- 
2.16.4

