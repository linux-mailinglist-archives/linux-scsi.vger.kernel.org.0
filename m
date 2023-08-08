Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29540773CEA
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Aug 2023 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjHHQLp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Aug 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjHHQJo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Aug 2023 12:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744A7688
        for <linux-scsi@vger.kernel.org>; Tue,  8 Aug 2023 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5vWqgVWZ30SumBVkEoD+1IKC/3TIbPs2fN+ccFAG78=;
        b=Qc3mQm44NdPKkw+rmI4arLzhuWmPRklf1CDFz/dVftSHcNKiojpkCrPsOwypamLFIRju1E
        Aw3+P9x8ouI2gSaslQsPCHiIkvuxJTnX5C+IKLTbTgFdwIRBRjDyOIusd3ldXmfNlYdLwJ
        ZRQ0M9U+W6EofBY8bywfp/IW0LFgdSI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-vLpqu9fwMnezhqdyB-j8NQ-1; Tue, 08 Aug 2023 06:43:23 -0400
X-MC-Unique: vLpqu9fwMnezhqdyB-j8NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C6F3815EF3;
        Tue,  8 Aug 2023 10:43:22 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13BA11121314;
        Tue,  8 Aug 2023 10:43:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH V3 10/14] scsi: pm8001: take blk_mq_max_nr_hw_queues() into account for calculating io vectors
Date:   Tue,  8 Aug 2023 18:42:35 +0800
Message-Id: <20230808104239.146085-11-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 4995e1ef4e0e..220ae504e5a5 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -965,6 +965,8 @@ static u32 pm8001_setup_msix(struct pm8001_hba_info *pm8001_ha)
 		rc = pci_alloc_irq_vectors(pm8001_ha->pdev, 1, 1,
 					   PCI_IRQ_MSIX);
 	} else {
+		unsigned int max_vecs = min_t(unsigned int, PM8001_MAX_MSIX_VEC,
+				scsi_max_nr_hw_queues() + 1);
 		/*
 		 * Queue index #0 is used always for housekeeping, so don't
 		 * include in the affinity spreading.
@@ -973,7 +975,7 @@ static u32 pm8001_setup_msix(struct pm8001_hba_info *pm8001_ha)
 			.pre_vectors = 1,
 		};
 		rc = pci_alloc_irq_vectors_affinity(
-				pm8001_ha->pdev, 2, PM8001_MAX_MSIX_VEC,
+				pm8001_ha->pdev, 2, max_vecs,
 				PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &desc);
 	}
 
-- 
2.40.1

