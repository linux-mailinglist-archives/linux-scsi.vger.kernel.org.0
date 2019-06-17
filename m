Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50950486D3
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfFQPSd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 11:18:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35502 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPSc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 11:18:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so5866556pfd.2
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsnxCpD5pGX+zHARFTc2bFyrGv0dNr5vaju+kWZ+mfs=;
        b=HOzganM3V/Pz2fKArSQcRRrjW03MT8rqN7f0th/sv1GQ3uhXSgnhoSpoAdoiDuu0Ty
         36sbsQOrXroeeErseFS1scQdP2G61LezlAxciuQ1u4N+X0owNA2CocYN0qvCv3gvk1fq
         0UU7mAOtJP5fO/OlzOxciNn94vuUQnRAIH+lmiJToeGto14yBKVhraIJOLWXPU8usyme
         sZmf0sjnyJUMVkiUQkYlQm3fRD82aSxv4aDv5Wz3AuXPtUpDfQQ88OXBeulHRszVB6+8
         i+AIL5hEqK3VWlgRSQI41aR75YEYQIHzhhLzxRcVd14tlhWpw+FSian5KbKjXgPkt78l
         Okkw==
X-Gm-Message-State: APjAAAW+vlIglKW9q6MvktDc1L6C4qnSnSKf7SL0YDD4vbOXgVPki9A7
        w4TnxIlJynvO6Of6cO0yxck=
X-Google-Smtp-Source: APXvYqxJ2IUudiiaM04BPTkPilE6PfBPR4KbDK+6xosfohTFi1z3zECLZE7i7pR+EJ5GuBwOk5kXvw==
X-Received: by 2002:a63:a514:: with SMTP id n20mr20131078pgf.438.1560784711962;
        Mon, 17 Jun 2019 08:18:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n5sm12529949pgd.26.2019.06.17.08.18.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:18:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH v4 3/3] RDMA/srp: Fix a sleep-in-invalid-context bug
Date:   Mon, 17 Jun 2019 08:18:20 -0700
Message-Id: <20190617151820.241583-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617151820.241583-1-bvanassche@acm.org>
References: <20190617151820.241583-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The previous patch guarantees that srp_queuecommand() does not get
invoked while reconnecting occurs. Hence remove the code from
srp_queuecommand() that prevents command queueing while reconnecting.
This patch avoids that the following can appear in the kernel log:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747
in_atomic(): 1, irqs_disabled(): 0, pid: 5600, name: scsi_eh_9
1 lock held by scsi_eh_9/5600:
 #0:  (rcu_read_lock){....}, at: [<00000000cbb798c7>] __blk_mq_run_hw_queue+0xf1/0x1e0
Preemption disabled at:
[<00000000139badf2>] __blk_mq_delay_run_hw_queue+0x78/0xf0
CPU: 9 PID: 5600 Comm: scsi_eh_9 Tainted: G        W        4.15.0-rc4-dbg+ #1
Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS 2.5.4 01/22/2016
Call Trace:
 dump_stack+0x67/0x99
 ___might_sleep+0x16a/0x250 [ib_srp]
 __mutex_lock+0x46/0x9d0
 srp_queuecommand+0x356/0x420 [ib_srp]
 scsi_dispatch_cmd+0xf6/0x3f0
 scsi_queue_rq+0x4a8/0x5f0
 blk_mq_dispatch_rq_list+0x73/0x440
 blk_mq_sched_dispatch_requests+0x109/0x1a0
 __blk_mq_run_hw_queue+0x131/0x1e0
 __blk_mq_delay_run_hw_queue+0x9a/0xf0
 blk_mq_run_hw_queue+0xc0/0x1e0
 blk_mq_start_hw_queues+0x2c/0x40
 scsi_run_queue+0x18e/0x2d0
 scsi_run_host_queues+0x22/0x40
 scsi_error_handler+0x18d/0x5f0
 kthread+0x11c/0x140
 ret_from_fork+0x24/0x30

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index be9ddcad8f28..b7c5a35f7daa 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2338,7 +2338,6 @@ static void srp_handle_qp_err(struct ib_cq *cq, struct ib_wc *wc,
 static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(shost);
-	struct srp_rport *rport = target->rport;
 	struct srp_rdma_ch *ch;
 	struct srp_request *req;
 	struct srp_iu *iu;
@@ -2348,16 +2347,6 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	u32 tag;
 	u16 idx;
 	int len, ret;
-	const bool in_scsi_eh = !in_interrupt() && current == shost->ehandler;
-
-	/*
-	 * The SCSI EH thread is the only context from which srp_queuecommand()
-	 * can get invoked for blocked devices (SDEV_BLOCK /
-	 * SDEV_CREATED_BLOCK). Avoid racing with srp_reconnect_rport() by
-	 * locking the rport mutex if invoked from inside the SCSI EH.
-	 */
-	if (in_scsi_eh)
-		mutex_lock(&rport->mutex);
 
 	scmnd->result = srp_chkready(target->rport);
 	if (unlikely(scmnd->result))
@@ -2426,13 +2415,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 		goto err_unmap;
 	}
 
-	ret = 0;
-
-unlock_rport:
-	if (in_scsi_eh)
-		mutex_unlock(&rport->mutex);
-
-	return ret;
+	return 0;
 
 err_unmap:
 	srp_unmap_data(scmnd, ch, req);
@@ -2454,7 +2437,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 		ret = SCSI_MLQUEUE_HOST_BUSY;
 	}
 
-	goto unlock_rport;
+	return ret;
 }
 
 /*
-- 
2.22.0.rc3

