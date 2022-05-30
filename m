Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72190538000
	for <lists+linux-scsi@lfdr.de>; Mon, 30 May 2022 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiE3OJn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 May 2022 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiE3OFW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 May 2022 10:05:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EBADEB6;
        Mon, 30 May 2022 06:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D430B80AE8;
        Mon, 30 May 2022 13:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B83C3411F;
        Mon, 30 May 2022 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918077;
        bh=DtOx1O0XiaLlxSWEw4zXLFc27dFqLNs2qRbn4pPwBT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUXjqNKFVmCeEWcYXs0r3kp345AyoHdGId3XMbCOmWrMnlYk9BFWMBKt86upxpmcV
         PoMy/zrdCybOGJz2jkO5s13UGVd9T4dDmfRHLkzVZd3uM6SE+48w1pcvgFV1nu9g0O
         S338/1SSM7SBl5+b7+vtln6eYjdr10Q/MEizUERr1DoqKTBG3tDp3JJgMDVKJZ43wq
         p2ZtkgRsQETfZHuGU73nwx95iGdi6I7ugQHV01J01trj1FYTztVs4oQIbPsEoF2Hez
         RIoKaQji2qRhOBTgXcxQbFrDywf3VxMuydvcB1NVw4dxw4IudHnoO7k1ZmHkmCMdju
         1m1yTNLg+s95A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 051/109] scsi: target: tcmu: Fix possible data corruption
Date:   Mon, 30 May 2022 09:37:27 -0400
Message-Id: <20220530133825.1933431-51-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

[ Upstream commit bb9b9eb0ae2e9d3f6036f0ad907c3a83dcd43485 ]

When tcmu_vma_fault() gets a page successfully, before the current context
completes page fault procedure, find_free_blocks() may run and call
unmap_mapping_range() to unmap the page. Assume that when
find_free_blocks() initially completes and the previous page fault
procedure starts to run again and completes, then one truncated page has
been mapped to userspace. But note that tcmu_vma_fault() has gotten a
refcount for the page so any other subsystem won't be able to use the page
unless the userspace address is unmapped later.

If another command subsequently runs and needs to extend dbi_thresh it may
reuse the corresponding slot for the previous page in data_bitmap. Then
though we'll allocate new page for this slot in data_area, no page fault
will happen because we have a valid map and the real request's data will be
lost.

Filesystem implementations will also run into this issue but they usually
lock the page when vm_operations_struct->fault gets a page and unlock the
page after finish_fault() completes. For truncate filesystems lock pages in
truncate_inode_pages() to protect against racing wrt. page faults.

To fix this possible data corruption scenario we can apply a method similar
to the filesystems.  For pages that are to be freed, tcmu_blocks_release()
locks and unlocks. Make tcmu_vma_fault() also lock found page under
cmdr_lock. At the same time, since tcmu_vma_fault() gets an extra page
refcount, tcmu_blocks_release() won't free pages if pages are in page fault
procedure, which means it is safe to call tcmu_blocks_release() before
unmap_mapping_range().

With these changes tcmu_blocks_release() will wait for all page faults to
be completed before calling unmap_mapping_range(). And later, if
unmap_mapping_range() is called, it will ensure stale mappings are removed.

Link: https://lore.kernel.org/r/20220421023735.9018-1-xiaoguang.wang@linux.alibaba.com
Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_user.c | 40 ++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 0ca5ec14d3db..0173f44b015a 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -20,6 +20,7 @@
 #include <linux/configfs.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <linux/pagemap.h>
 #include <net/genetlink.h>
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_proto.h>
@@ -1667,6 +1668,26 @@ static u32 tcmu_blocks_release(struct tcmu_dev *udev, unsigned long first,
 	xas_lock(&xas);
 	xas_for_each(&xas, page, (last + 1) * udev->data_pages_per_blk - 1) {
 		xas_store(&xas, NULL);
+		/*
+		 * While reaching here there may be page faults occurring on
+		 * the to-be-released pages. A race condition may occur if
+		 * unmap_mapping_range() is called before page faults on these
+		 * pages have completed; a valid but stale map is created.
+		 *
+		 * If another command subsequently runs and needs to extend
+		 * dbi_thresh, it may reuse the slot corresponding to the
+		 * previous page in data_bitmap. Though we will allocate a new
+		 * page for the slot in data_area, no page fault will happen
+		 * because we have a valid map. Therefore the command's data
+		 * will be lost.
+		 *
+		 * We lock and unlock pages that are to be released to ensure
+		 * all page faults have completed. This way
+		 * unmap_mapping_range() can ensure stale maps are cleanly
+		 * removed.
+		 */
+		lock_page(page);
+		unlock_page(page);
 		__free_page(page);
 		pages_freed++;
 	}
@@ -1822,6 +1843,7 @@ static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
 	page = xa_load(&udev->data_pages, dpi);
 	if (likely(page)) {
 		get_page(page);
+		lock_page(page);
 		mutex_unlock(&udev->cmdr_lock);
 		return page;
 	}
@@ -1863,6 +1885,7 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long offset;
 	void *addr;
+	vm_fault_t ret = 0;
 
 	int mi = tcmu_find_mem_index(vmf->vma);
 	if (mi < 0)
@@ -1887,10 +1910,11 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 		page = tcmu_try_get_data_page(udev, dpi);
 		if (!page)
 			return VM_FAULT_SIGBUS;
+		ret = VM_FAULT_LOCKED;
 	}
 
 	vmf->page = page;
-	return 0;
+	return ret;
 }
 
 static const struct vm_operations_struct tcmu_vm_ops = {
@@ -3153,12 +3177,22 @@ static void find_free_blocks(void)
 			udev->dbi_max = block;
 		}
 
+		/*
+		 * Release the block pages.
+		 *
+		 * Also note that since tcmu_vma_fault() gets an extra page
+		 * refcount, tcmu_blocks_release() won't free pages if pages
+		 * are mapped. This means it is safe to call
+		 * tcmu_blocks_release() before unmap_mapping_range() which
+		 * drops the refcount of any pages it unmaps and thus releases
+		 * them.
+		 */
+		pages_freed = tcmu_blocks_release(udev, start, end - 1);
+
 		/* Here will truncate the data area from off */
 		off = udev->data_off + (loff_t)start * udev->data_blk_size;
 		unmap_mapping_range(udev->inode->i_mapping, off, 0, 1);
 
-		/* Release the block pages */
-		pages_freed = tcmu_blocks_release(udev, start, end - 1);
 		mutex_unlock(&udev->cmdr_lock);
 
 		total_pages_freed += pages_freed;
-- 
2.35.1

