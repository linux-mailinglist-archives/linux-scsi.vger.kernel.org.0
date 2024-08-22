Return-Path: <linux-scsi+bounces-7567-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1866E95BE55
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2024 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1A0284E32
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2024 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2491D0DC4;
	Thu, 22 Aug 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzZttTLD"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D2EC5;
	Thu, 22 Aug 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351870; cv=none; b=h9ZjD4rNEt3+dtPcXrPi4nWX5cqhtAnE9+537rBVShbKfxMabwycbYY4KTovlbNJGU2Ps44t2zqn19Sl0hLsCCaZuE0xENe2tSAVGIjzD+4QSvNqK6EiRw8o0B6Zom3vi2aVyICAkMtQg3EwJNfodIuhUWhMaz1r//rdR2vhJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351870; c=relaxed/simple;
	bh=1MYOjGCIldHgAGMqPUKMCrh2+ldW4PHbipuyT3s2aA8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sjp+13dZHw7HZOvPxfm6rdrX4e3QsJHk071PFel0YeOm0y17628jBfjn4Ntn471XAcxsHBhZQYJEd2Tt0aQAZYk5qqMqF4cb3Gr/BK3caIgYpOPYXjHMSwR3Wzi9HEYg4DOk/4jIwl5iaPYLKVGRTRbnJlVl2L4Ntth86DLcAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzZttTLD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201e52ca0caso8967555ad.3;
        Thu, 22 Aug 2024 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351867; x=1724956667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjfMtdcDLGDQnBLpB5ievgILoCMnyG9pAUBPHV8Ka68=;
        b=EzZttTLDRnrQZ1OMSLYFaYoxLcomxvv8vmcoj0MUUW2IWXK9bKE64cYxPQHWshyEWd
         6AL+nxcxxo+cvRZtEqn8OUBHTLpTHEHu5Dbn96pzOmtM3Wf99fYdly9u0k1HTJVT6mPx
         kYmDSvgqooZrGUsQWAZKGMFElor18IOgXmdPy3X396lVPfTH204BzKsL+FkpLvn8kfO0
         meyAYORHsC+x016OeY0kmzFpuiMUbRPqck/qeyUKI8iTunhOYXvvVzcJj4P39r3cO0aq
         Q3E67xE5TwIYhamlwCqlsfT3tKwuZX/urfxQe3813bcdw4jMsGy05AYK+CZyseorpmvQ
         Ooow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351867; x=1724956667;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjfMtdcDLGDQnBLpB5ievgILoCMnyG9pAUBPHV8Ka68=;
        b=wjt94UsKOyt8VEeLgqYRYJEuu4yy17Uv9aNbXDGD9kj6r6Vz1AIU5BUevCdDPP3n7N
         iaTcgW9kHRi+DmhkpYY7BHeLhotLcQfpbGHe2AjN41jCAoid9BY9oQIYDD+yFp6vEmFO
         9kYkovXf6BnBY5nYhNLsiqX/5hDYM+xzuIY7av/c/1sxEpdLvQBmTyafXfgfnu/m6iW5
         eUPSzCwnkbLilVQJtx9b595od0++2CLSzCghQ5RLmUx82lKnVglEpA0fT9Vd8W+A9380
         64fJGrup6+BTfhSXZX/IR4rPWdBf6Br5KCR0EfJBC9OKNPq9w02XKNIgbSyq09/zYnsv
         PlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDYn+V/nEydRRnXKYigTiBl38bbJW0ylGoHmTMQaVEjPs58W6Zh/1JLtyrMMK/fkfXBL62IgHKL1VyNR4=@vger.kernel.org, AJvYcCUg+eVhEvOUgkx6aru/gxaiWiX6OJg08mybEW3pQw2/yfqWUpRi6hue3Znzb+03OarcDZnFeXhWooVUJQ==@vger.kernel.org, AJvYcCV4D8EFUoc/MLNSIV6OnVON9FcK1iWxineP32+zoSWBS84/xVf3odMFC8cJu8rj33kzzOR9kVA4Tq98YiDD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw524xlW0klrHsz108qW7eekYWfXL1Ri7Lm5p2KNQXNNn5AUV4G
	yrOvRLeBBsX8D67VdsWdM/wyKLgL7bX0alwO7UfgUokqAh8Hyqz8
X-Google-Smtp-Source: AGHT+IF9sdhX5APdafE8rQTPJt8ZBQnqDD/V3BB+n+PgpkNa+qh0s6M1LpksFMMVRYmHv6tGpAsIfg==
X-Received: by 2002:a17:902:ea02:b0:1fd:d56e:2c0d with SMTP id d9443c01a7336-20368197745mr58216485ad.31.1724351866979;
        Thu, 22 Aug 2024 11:37:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:46 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 1/7] swiotlb: Introduce swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:12 -0700
Message-Id: <20240822183718.1234-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Implement throttling of swiotlb map requests. Because throttling requires
temporarily pending some requests, throttling can only be used by map
requests made in contexts that can block. Detecting such contexts at
runtime is infeasible, so device driver code must be updated to add
DMA_ATTR_MAY_BLOCK on map requests done in a context that can block.
Even if a map request is throttled, the corresponding unmap request will
never block, so unmap has no context restrictions, just like current code.
If a swiotlb map request does *not* have DMA_ATTR_MAY_BLOCK, no throttling
is done and there is no functional change.

The goal of throttling is to reduce peak usage of swiotlb memory,
particularly in environments like CoCo VMs which must use bounce buffering
for all DMA I/O. These VMs currently allocate up to 1 GiB for swiotlb
memory to ensure that it isn't exhausted. But for many workloads, this
memory is effectively wasted because it can't be used for other purposes.
Throttling can lower the swiotlb memory requirements without unduly raising
the risk of exhaustion, thus making several hundred MiBs of additional
memory available for general usage.

The high-level implementation is as follows:

1.  Each struct io_tlb_mem has a semaphore that is initialized to 1.  A
semaphore is used instead of a mutex because the semaphore likely won't
be released by the same thread that obtained it.

2. Each struct io_tlb_mem has a swiotlb space usage level above which
throttling is done. This usage level is initialized to 70% of the total
size of that io_tlb_mem, and is tunable at runtime via /sys if
CONFIG_DEBUG_FS is set.

3. When swiotlb_tbl_map_single() is invoked with throttling allowed, if
the current usage of that io_tlb_mem is above the throttle level, the
semaphore must be obtained before proceeding. The semaphore is then
released by the corresponding swiotlb unmap call. If the semaphore is
already held when swiotlb_tbl_map_single() must obtain it, the calling
thread blocks until the semaphore is available. Once the thread obtains
the semaphore, it proceeds to allocate swiotlb space in the usual way.
The swiotlb map call saves throttling information in the io_tlb_slot, and
then swiotlb unmap uses that information to determine if the semaphore
is held. If so, it releases the semaphore, potentially allowing a
queued request to proceed. Overall, the semaphore queues multiple waiters
and wakes them up in the order in which they waited. Effectively, the
semaphore single threads map/unmap pairs to reduce peak usage.

4. A "low throttle" level is also implemented and initialized to 65% of
the total size of the io_tlb_mem. If the current usage is between the
throttle level and the low throttle level, AND the semaphore is held, the
requestor must obtain the semaphore. Consider if throttling occurs, so
that one map request holds the semaphore, and three others are queued
waiting for the semaphore. If swiotlb usage then drops because of
unrelated unmap's, a new incoming map request may not get throttled, and
bypass the three requests waiting in the semaphore queue. There's not
a forward progress issue because the requests in the queue will complete
as long as the underlying I/Os make forward progress. But to somewhat
address the fairness issue, the low throttle level provides hysteresis
in that new incoming requests continue to queue on the semaphore as long
as used swiotlb memory is above that lower limit.

5. SGLs are handled in a subsequent patch.

In #3 above the check for being above the throttle level is an
instantaneous check with no locking and no reservation of space, to avoid
atomic operations. Consequently, multiple threads could all make the check
and decide they are under the throttle level. They can all proceed without
obtaining the semaphore, and potentially generate a peak in usage.
Furthermore, other DMA map requests that don't have throttling enabled
proceed without even checking, and hence can also push usage toward a peak.
So throttling can blunt and reduce peaks in swiotlb memory usage, but
does it not guarantee to prevent exhaustion.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/dma-mapping.h |   8 +++
 include/linux/swiotlb.h     |  15 ++++-
 kernel/dma/Kconfig          |  13 ++++
 kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
 4 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..7b78294813be 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -62,6 +62,14 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_MAY_BLOCK: Indication by a driver that the DMA map request is
+ * allowed to block. This flag must only be used on DMA map requests made in
+ * contexts that allow blocking. The corresponding unmap request will not
+ * block.
+ */
+#define DMA_ATTR_MAY_BLOCK		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..10d07d0ee00c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -89,6 +89,10 @@ struct io_tlb_pool {
  * @defpool:	Default (initial) IO TLB memory pool descriptor.
  * @pool:	IO TLB memory pool descriptor (if not dynamic).
  * @nslabs:	Total number of IO TLB slabs in all pools.
+ * @high_throttle: Slab count above which requests are throttled.
+ * @low_throttle: Slab count abouve which requests are throttled when
+ *		throttle_sem is already held.
+ * @throttle_sem: Semaphore that throttled requests must obtain.
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
@@ -104,10 +108,17 @@ struct io_tlb_pool {
  *		in debugfs.
  * @transient_nslabs: The total number of slots in all transient pools that
  *		are currently used across all areas.
+ * @high_throttle_count: Count of requests throttled because high_throttle
+ *		was exceeded.
+ * @low_throttle_count: Count of requests throttled because low_throttle was
+ *		exceeded and throttle_sem was already held.
  */
 struct io_tlb_mem {
 	struct io_tlb_pool defpool;
 	unsigned long nslabs;
+	unsigned long high_throttle;
+	unsigned long low_throttle;
+	struct semaphore throttle_sem;
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
@@ -118,11 +129,11 @@ struct io_tlb_mem {
 	struct list_head pools;
 	struct work_struct dyn_alloc;
 #endif
-#ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
 	atomic_long_t transient_nslabs;
-#endif
+	unsigned long high_throttle_count;
+	unsigned long low_throttle_count;
 };
 
 struct io_tlb_pool *__swiotlb_find_pool(struct device *dev, phys_addr_t paddr);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c06e56be0ca1..d45ba62f58c8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -103,6 +103,19 @@ config SWIOTLB_DYNAMIC
 
 	  If unsure, say N.
 
+config SWIOTLB_THROTTLE
+	bool "Throttle DMA map requests from enabled drivers"
+	default n
+	depends on SWIOTLB
+	help
+	  Enable throttling of DMA map requests to help avoid exhausting
+	  bounce buffer space, causing request failures. Throttling
+	  applies only where the calling driver has enabled blocking in
+	  DMA map requests. This option is most useful in CoCo VMs where
+	  all DMA operations must go through bounce buffers.
+
+	  If unsure, say N.
+
 config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index df68d29740a0..940b95cf02b7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/semaphore.h>
 #include <linux/pfn.h>
 #include <linux/rculist.h>
 #include <linux/scatterlist.h>
@@ -71,12 +72,15 @@
  *		from each index.
  * @pad_slots:	Number of preceding padding slots. Valid only in the first
  *		allocated non-padding slot.
+ * @throttled:  Boolean indicating the slot is used by a request that was
+ *		throttled. Valid only in the first allocated non-padding slot.
  */
 struct io_tlb_slot {
 	phys_addr_t orig_addr;
 	size_t alloc_size;
 	unsigned short list;
-	unsigned short pad_slots;
+	u8 pad_slots;
+	u8 throttled;
 };
 
 static bool swiotlb_force_bounce;
@@ -249,6 +253,31 @@ static inline unsigned long nr_slots(u64 val)
 	return DIV_ROUND_UP(val, IO_TLB_SIZE);
 }
 
+#ifdef CONFIG_SWIOTLB_THROTTLE
+static void init_throttling(struct io_tlb_mem *mem)
+{
+	sema_init(&mem->throttle_sem, 1);
+
+	/*
+	 * The default thresholds are somewhat arbitrary. They are
+	 * conservative to allow space for devices that can't throttle and
+	 * because the determination of whether to throttle is done without
+	 * any atomicity. The low throttle exists to provide a modest amount
+	 * of hysteresis so that the system doesn't flip rapidly between
+	 * throttling and not throttling when usage fluctuates near the high
+	 * throttle level.
+	 */
+	mem->high_throttle = (mem->nslabs * 70) / 100;
+	mem->low_throttle = (mem->nslabs * 65) / 100;
+}
+#else
+static void init_throttling(struct io_tlb_mem *mem)
+{
+	mem->high_throttle = 0;
+	mem->low_throttle = 0;
+}
+#endif
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -415,6 +444,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
+
+	init_throttling(&io_tlb_default_mem);
 }
 
 void __init swiotlb_init(bool addressing_limit, unsigned int flags)
@@ -511,6 +542,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
 				 nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
+	init_throttling(&io_tlb_default_mem);
 
 	swiotlb_print_info();
 	return 0;
@@ -947,7 +979,7 @@ static unsigned int wrap_area_index(struct io_tlb_pool *mem, unsigned int index)
  * function gives imprecise results because there's no locking across
  * multiple areas.
  */
-#ifdef CONFIG_DEBUG_FS
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_SWIOTLB_THROTTLE)
 static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots)
 {
 	unsigned long old_hiwater, new_used;
@@ -966,14 +998,14 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 	atomic_long_sub(nslots, &mem->total_used);
 }
 
-#else /* !CONFIG_DEBUG_FS */
+#else /* !CONFIG_DEBUG_FS && !CONFIG_SWIOTLB_THROTTLE*/
 static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots)
 {
 }
 static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 {
 }
-#endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_DEBUG_FS || CONFIG_SWIOTLB_THROTTLE */
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 #ifdef CONFIG_DEBUG_FS
@@ -1277,7 +1309,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 #endif /* CONFIG_SWIOTLB_DYNAMIC */
 
-#ifdef CONFIG_DEBUG_FS
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_SWIOTLB_THROTTLE)
 
 /**
  * mem_used() - get number of used slots in an allocator
@@ -1293,7 +1325,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 	return atomic_long_read(&mem->total_used);
 }
 
-#else /* !CONFIG_DEBUG_FS */
+#else /* !CONFIG_DEBUG_FS && !CONFIG_SWIOTLB_THROTTLE */
 
 /**
  * mem_pool_used() - get number of used slots in a memory pool
@@ -1373,6 +1405,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset;
 	struct io_tlb_pool *pool;
+	bool throttle = false;
 	unsigned int i;
 	size_t size;
 	int index;
@@ -1398,6 +1431,32 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	dev_WARN_ONCE(dev, alloc_align_mask > ~PAGE_MASK,
 		"Alloc alignment may prevent fulfilling requests with max mapping_size\n");
 
+	if (IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) && attrs & DMA_ATTR_MAY_BLOCK) {
+		unsigned long used = atomic_long_read(&mem->total_used);
+
+		/*
+		 * Determining whether to throttle is intentionally done without
+		 * atomicity. For example, multiple requests could proceed in
+		 * parallel when usage is just under the threshold, putting
+		 * usage above the threshold by the aggregate size of the
+		 * parallel requests. The thresholds must already be set
+		 * conservatively because of drivers that can't enable
+		 * throttling, so this slop in the accounting shouldn't be
+		 * problem. It's better than the potential bottleneck of a
+		 * globally synchronzied reservation mechanism.
+		 */
+		if (used > mem->high_throttle) {
+			throttle = true;
+			mem->high_throttle_count++;
+		} else if ((used > mem->low_throttle) &&
+					(mem->throttle_sem.count <= 0)) {
+			throttle = true;
+			mem->low_throttle_count++;
+		}
+		if (throttle)
+			down(&mem->throttle_sem);
+	}
+
 	offset = swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
 	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
 	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
@@ -1406,6 +1465,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 				 size, mem->nslabs, mem_used(mem));
+		if (throttle)
+			up(&mem->throttle_sem);
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -1424,6 +1485,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	offset &= (IO_TLB_SIZE - 1);
 	index += pad_slots;
 	pool->slots[index].pad_slots = pad_slots;
+	pool->slots[index].throttled = throttle;
 	for (i = 0; i < (nr_slots(size) - pad_slots); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -1440,7 +1502,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
+static bool swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 				  struct io_tlb_pool *mem)
 {
 	unsigned long flags;
@@ -1448,8 +1510,10 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 	int index, nslots, aindex;
 	struct io_tlb_area *area;
 	int count, i;
+	bool throttled;
 
 	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
+	throttled = mem->slots[index].throttled;
 	index -= mem->slots[index].pad_slots;
 	nslots = nr_slots(mem->slots[index].alloc_size + offset);
 	aindex = index / mem->area_nslabs;
@@ -1478,6 +1542,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 		mem->slots[i].pad_slots = 0;
+		mem->slots[i].throttled = 0;
 	}
 
 	/*
@@ -1492,6 +1557,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 	spin_unlock_irqrestore(&area->lock, flags);
 
 	dec_used(dev->dma_io_tlb_mem, nslots);
+
+	return throttled;
 }
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -1501,6 +1568,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
  * @dev:	Device which mapped the buffer.
  * @tlb_addr:	Physical address within a bounce buffer.
  * @pool:       Pointer to the transient memory pool to be checked and deleted.
+ * @throttled:	If the function returns %true, return boolean indicating
+ *		if the transient allocation was throttled. Not set if the
+ *		function returns %false.
  *
  * Check whether the address belongs to a transient SWIOTLB memory pool.
  * If yes, then delete the pool.
@@ -1508,11 +1578,18 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
  * Return: %true if @tlb_addr belonged to a transient pool that was released.
  */
 static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr,
-		struct io_tlb_pool *pool)
+		struct io_tlb_pool *pool, bool *throttled)
 {
+	unsigned int offset;
+	int index;
+
 	if (!pool->transient)
 		return false;
 
+	offset = swiotlb_align_offset(dev, 0, tlb_addr);
+	index = (tlb_addr - offset - pool->start) >> IO_TLB_SHIFT;
+	*throttled = pool->slots[index].throttled;
+
 	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
 	swiotlb_del_pool(dev, pool);
 	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
@@ -1522,7 +1599,7 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr,
 #else  /* !CONFIG_SWIOTLB_DYNAMIC */
 
 static inline bool swiotlb_del_transient(struct device *dev,
-		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
+		phys_addr_t tlb_addr, struct io_tlb_pool *pool, bool *throttled)
 {
 	return false;
 }
@@ -1536,6 +1613,8 @@ void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 		size_t mapping_size, enum dma_data_direction dir,
 		unsigned long attrs, struct io_tlb_pool *pool)
 {
+	bool throttled;
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
@@ -1544,9 +1623,11 @@ void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 		swiotlb_bounce(dev, tlb_addr, mapping_size,
 						DMA_FROM_DEVICE, pool);
 
-	if (swiotlb_del_transient(dev, tlb_addr, pool))
-		return;
-	swiotlb_release_slots(dev, tlb_addr, pool);
+	if (!swiotlb_del_transient(dev, tlb_addr, pool, &throttled))
+		throttled = swiotlb_release_slots(dev, tlb_addr, pool);
+
+	if (throttled)
+		up(&dev->dma_io_tlb_mem->throttle_sem);
 }
 
 void __swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
@@ -1719,6 +1800,14 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
+	debugfs_create_ulong("high_throttle", 0600, mem->debugfs,
+			&mem->high_throttle);
+	debugfs_create_ulong("low_throttle", 0600, mem->debugfs,
+			&mem->low_throttle);
+	debugfs_create_ulong("high_throttle_count", 0600, mem->debugfs,
+			&mem->high_throttle_count);
+	debugfs_create_ulong("low_throttle_count", 0600, mem->debugfs,
+			&mem->low_throttle_count);
 	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
 			&fops_io_tlb_used);
 	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
@@ -1841,6 +1930,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		INIT_LIST_HEAD_RCU(&mem->pools);
 #endif
 		add_mem_pool(mem, pool);
+		init_throttling(mem);
 
 		rmem->priv = mem;
 
-- 
2.25.1


