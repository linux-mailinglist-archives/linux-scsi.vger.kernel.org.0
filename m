Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9B7508E5
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jul 2023 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjGLM4c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jul 2023 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjGLM42 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Jul 2023 08:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70F1BC5
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jul 2023 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689166537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nk/Wqaa+Kq1K/rJO90p9bF5IpxDn2p06PBFgsL5mmuI=;
        b=JjTMe04OpwbKbtG09Lwx9P272mWIoJL3qnPDR+AdGu9zOefQOFd1FJwzuASoruhaww1bXw
        5P+mTrmxN73cbTuNNMTBxG49JcruCAFyLGkw741GG6uH3rgOPTNOVaZkEDypQG7/jry1D4
        GrfjmqQhjvOoGotpiLi51owCQFYCFeI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-FEyENvIFP9Gm5X0qWJ9PYQ-1; Wed, 12 Jul 2023 08:55:31 -0400
X-MC-Unique: FEyENvIFP9Gm5X0qWJ9PYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4943C0FC94;
        Wed, 12 Jul 2023 12:55:30 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC6362017EB9;
        Wed, 12 Jul 2023 12:55:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 7/8] scsi: mpt3sas: take blk_mq_max_nr_hw_queues() into account for calculating io vectors
Date:   Wed, 12 Jul 2023 20:54:54 +0800
Message-Id: <20230712125455.1986455-8-ming.lei@redhat.com>
In-Reply-To: <20230712125455.1986455-1-ming.lei@redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Take blk-mq's knowledge into account for calculating io queues.

Fix wrong queue mapping in case of kdump kernel.

On arm and ppc64, 'maxcpus=1' is passed to kdump kernel command line,
see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 53f5492579cb..18a73d3ff00b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3332,8 +3332,8 @@ _base_alloc_irq_vectors(struct MPT3SAS_ADAPTER *ioc)
 	 * Don't allocate msix vectors for poll_queues.
 	 * msix_vectors is always within a range of FW supported reply queue.
 	 */
-	int nr_msix_vectors = ioc->iopoll_q_start_index;
-
+	int nr_msix_vectors = min_t(unsigned int, ioc->iopoll_q_start_index,
+			blk_mq_max_nr_hw_queues());
 
 	if (ioc->smp_affinity_enable)
 		irq_flags |= PCI_IRQ_AFFINITY | PCI_IRQ_ALL_TYPES;
-- 
2.40.1

