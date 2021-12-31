Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0A48216E
	for <lists+linux-scsi@lfdr.de>; Fri, 31 Dec 2021 03:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbhLaCQR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Dec 2021 21:16:17 -0500
Received: from smtp.infotech.no ([82.134.31.41]:46084 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242549AbhLaCQM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Dec 2021 21:16:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 59C5E2041AF;
        Fri, 31 Dec 2021 03:08:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dT7yDEVat46h; Fri, 31 Dec 2021 03:08:44 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-208-241.dyn.295.ca [45.58.208.241])
        by smtp.infotech.no (Postfix) with ESMTPA id 4174F2041D4;
        Fri, 31 Dec 2021 03:08:39 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
Subject: [PATCH 8/9] scsi_debug: change store from vmalloc to sgl
Date:   Thu, 30 Dec 2021 21:08:28 -0500
Message-Id: <20211231020829.29147-9-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231020829.29147-1-dgilbert@interlog.com>
References: <20211231020829.29147-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A long time ago this driver's store was allocated by kmalloc() or
alloc_pages(). When this was switched to vmalloc() the author
noticed slower ramdisk access times and more variability in repeated
tests. So try going back with sgl_alloc_order() to get uniformly
sized allocations in a sometimes large scatter gather _array_. That
array is the basis of maintaining O(1) access to the store.

Using sgl_alloc_order() and friends requires CONFIG_SGL_ALLOC
so add a 'select' to the Kconfig file.

Remove kcalloc() in resp_verify() as sgl_s can now be compared
directly without forming an intermediate buffer. This is a
performance win for the SCSI VERIFY command implementation.

Make the SCSI COMPARE AND WRITE command yield the offset of the
first miscompared byte when the compare fails (as required by
T10).

This patch previously depended on: "[PATCH v4 0/4] scatterlist:
add new capabilities". However while that patchset is being
considered, those functions have been replicated by the previous
patch with a "sdeb_" prefix so they can be used by this patch.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/Kconfig      |   3 +-
 drivers/scsi/scsi_debug.c | 491 ++++++++++++++++++++++++++------------
 2 files changed, 347 insertions(+), 147 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6e3a04107bb6..39bd9ee2b07e 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1240,13 +1240,14 @@ config SCSI_DEBUG
 	tristate "SCSI debugging host and device simulator"
 	depends on SCSI
 	select CRC_T10DIF
+	select SGL_ALLOC
 	help
 	  This pseudo driver simulates one or more hosts (SCSI initiators),
 	  each with one or more targets, each with one or more logical units.
 	  Defaults to one of each, creating a small RAM disk device. Many
 	  parameters found in the /sys/bus/pseudo/drivers/scsi_debug
 	  directory can be tweaked at run time.
-	  See <http://sg.danny.cz/sg/sdebug26.html> for more information.
+	  See <https://sg.danny.cz/sg/scsi_debug.html> for more information.
 	  Mainly used for testing and best as a module. If unsure, say N.
 
 config SCSI_MESH
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 464467fbbf1a..ba4a5a7dd25f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -222,6 +222,7 @@ static const char *sdebug_version_date = "20210520";
 #define SDEBUG_CANQUEUE_WORDS  3	/* a WORD is bits in a long */
 #define SDEBUG_CANQUEUE  (SDEBUG_CANQUEUE_WORDS * BITS_PER_LONG)
 #define DEF_CMD_PER_LUN  SDEBUG_CANQUEUE
+#define SDEB_ORDER_TOO_LARGE 4096
 
 /* UA - Unit Attention; SA - Service Action; SSU - Start Stop Unit */
 #define F_D_IN			1	/* Data-in command (e.g. READ) */
@@ -315,8 +316,11 @@ struct sdebug_host_info {
 
 /* There is an xarray of pointers to this struct's objects, one per host */
 struct sdeb_store_info {
+	unsigned int n_elem;    /* number of sgl elements */
+	unsigned int order;	/* as used by alloc_pages() */
+	unsigned int elem_pow2;	/* PAGE_SHIFT + order */
 	rwlock_t macc_lck;	/* for atomic media access on this store */
-	u8 *storep;		/* user data storage (ram) */
+	struct scatterlist *sgl;  /* main store: n_elem array of same sized allocs */
 	struct t10_pi_tuple *dif_storep; /* protection info */
 	void *map_storep;	/* provisioning map */
 };
@@ -879,19 +883,6 @@ static inline bool scsi_debug_lbp(void)
 		(sdebug_lbpu || sdebug_lbpws || sdebug_lbpws10);
 }
 
-static void *lba2fake_store(struct sdeb_store_info *sip,
-			    unsigned long long lba)
-{
-	struct sdeb_store_info *lsip = sip;
-
-	lba = do_div(lba, sdebug_store_sectors);
-	if (!sip || !sip->storep) {
-		WARN_ON_ONCE(true);
-		lsip = xa_load(per_store_ap, 0);  /* should never be NULL */
-	}
-	return lsip->storep + lba * sdebug_sector_size;
-}
-
 static struct t10_pi_tuple *dif_store(struct sdeb_store_info *sip,
 				      sector_t sector)
 {
@@ -1000,7 +991,6 @@ static int scsi_debug_ioctl(struct scsi_device *dev, unsigned int cmd,
 				    __func__, cmd);
 	}
 	return -EINVAL;
-	/* return -ENOTTY; // correct return but upsets fdisk */
 }
 
 static void config_cdb_len(struct scsi_device *sdev)
@@ -1206,6 +1196,38 @@ static int p_fill_from_dev_buffer(struct scsi_cmnd *scp, const void *arr,
 	return 0;
 }
 
+static struct scatterlist *sdeb_sgl_alloc_order(unsigned long long length, unsigned int order,
+						gfp_t gfp, unsigned int *nent_p)
+{
+	struct scatterlist *sgl, *sg;
+	struct page *page;
+	unsigned int nent, nalloc;
+	u32 elem_len;
+
+	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
+	nalloc = nent;
+	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist), gfp & ~GFP_DMA);
+	if (!sgl)
+		return NULL;
+
+	sg_init_table(sgl, nalloc);
+	sg = sgl;
+	while (length) {
+		elem_len = min_t(u64, length, PAGE_SIZE << order);
+		page = alloc_pages(gfp, order);
+		if (!page) {
+			sgl_free_order(sgl, order);
+			return NULL;
+		}
+		sg_set_page(sg, page, elem_len, 0);
+		length -= elem_len;
+		sg = sg_next(sg);
+	}
+	if (nent_p)
+		*nent_p = nent;
+	return sgl;
+}
+
 /*
  * The following 4 functions are proposed for lib/scatterlist.c (without the
  * "sdeb_" prefix) and will be removed from this driver if the proposal is accepted.
@@ -1300,13 +1322,15 @@ static bool sdeb_sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_n
 	return equ;
 }
 
-static bool sdeb_sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
-				 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
-				 size_t n_bytes)
-{
-	return sdeb_sgl_compare_sgl_idx(x_sgl, x_nents, x_skip, y_sgl, y_nents, y_skip, n_bytes,
-					NULL);
-}
+/*
+ * static bool sdeb_sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
+ *                                  struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
+ *                                  size_t n_bytes)
+ * {
+ *      return sdeb_sgl_compare_sgl_idx(x_sgl, x_nents, x_skip, y_sgl, y_nents, y_skip, n_bytes,
+ *                                      NULL);
+ * }
+ */
 
 static size_t sdeb_sgl_memset(struct scatterlist *sgl, unsigned int nents, off_t skip,
 			      u8 val, size_t n_bytes)
@@ -1347,6 +1371,54 @@ static int fetch_to_dev_buffer(struct scsi_cmnd *scp, unsigned char *arr,
 	return scsi_sg_copy_to_buffer(scp, arr, arr_len);
 }
 
+static bool sdeb_sgl_cmp_buf(struct scatterlist *sgl, unsigned int nents,
+			     const void *buf, size_t buflen, off_t skip)
+{
+	bool equ = true;
+	size_t offset = 0;
+	size_t len;
+	struct sg_mapping_iter miter;
+
+	if (buflen == 0)
+		return true;
+	sg_miter_start(&miter, sgl, nents, SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+	if (!sg_miter_skip(&miter, skip))
+		goto fini;
+
+	while (equ && (offset < buflen) && sg_miter_next(&miter)) {
+		len = min(miter.length, buflen - offset);
+		equ = memcmp(buf + offset, miter.addr, len) == 0;
+		offset += len;
+		miter.consumed = len;
+		sg_miter_stop(&miter);
+	}
+fini:
+	sg_miter_stop(&miter);
+	return equ;
+}
+
+static void sdeb_sgl_prefetch(struct scatterlist *sgl, unsigned int nents,
+			      off_t skip, size_t n_bytes)
+{
+	size_t offset = 0;
+	size_t len;
+	struct sg_mapping_iter miter;
+	unsigned int sg_flags = SG_MITER_FROM_SG;
+
+	if (n_bytes == 0)
+		return;
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+	if (!sg_miter_skip(&miter, skip))
+		goto fini;
+
+	while ((offset < n_bytes) && sg_miter_next(&miter)) {
+		len = min(miter.length, n_bytes - offset);
+		prefetch_range(miter.addr, len);
+		offset += len;
+	}
+fini:
+	sg_miter_stop(&miter);
+}
 
 static char sdebug_inq_vendor_id[9] = "Linux   ";
 static char sdebug_inq_product_id[17] = "scsi_debug      ";
@@ -3046,13 +3118,14 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 data_inout_off, u64 lba, u32 n_blks, bool do_write)
 {
 	int ret;
-	u64 block, rest = 0;
+	u32 lb_size = sdebug_sector_size;
+	u64 block, sgl_i, rem, lba_start, rest = 0;
 	enum dma_data_direction dir;
 	struct scsi_data_buffer *sdb = &scp->sdb;
-	u8 *fsp;
+	struct scatterlist *store_sgl;
 
 	if (do_write) {
 		dir = DMA_TO_DEVICE;
@@ -3065,25 +3138,38 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 		return 0;
 	if (scp->sc_data_direction != dir)
 		return -1;
-	fsp = sip->storep;
-
 	block = do_div(lba, sdebug_store_sectors);
-	if (block + num > sdebug_store_sectors)
-		rest = block + num - sdebug_store_sectors;
+	if (block + n_blks > sdebug_store_sectors)
+		rest = block + n_blks - sdebug_store_sectors;
+	lba_start = block * lb_size;
+	sgl_i = lba_start >> sip->elem_pow2;
+	rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+	store_sgl = sip->sgl + sgl_i;	/* O(1) to each store sg element */
+
+	if (do_write)
+		ret = sdeb_sgl_copy_sgl(store_sgl, sip->n_elem - sgl_i, rem,
+					sdb->table.sgl, sdb->table.nents, data_inout_off,
+					(n_blks - rest) * lb_size);
+	else
+		ret = sdeb_sgl_copy_sgl(sdb->table.sgl, sdb->table.nents, data_inout_off,
+					store_sgl, sip->n_elem - sgl_i, rem,
+					(n_blks - rest) * lb_size);
 
-	ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
-		   fsp + (block * sdebug_sector_size),
-		   (num - rest) * sdebug_sector_size, sg_skip, do_write);
-	if (ret != (num - rest) * sdebug_sector_size)
+	if (ret != (n_blks - rest) * lb_size)
 		return ret;
 
-	if (rest) {
-		ret += sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
-			    fsp, rest * sdebug_sector_size,
-			    sg_skip + ((num - rest) * sdebug_sector_size),
-			    do_write);
-	}
-
+	if (rest == 0)
+		goto fini;
+	if (do_write)
+		ret += sdeb_sgl_copy_sgl(sip->sgl, sip->n_elem, 0, sdb->table.sgl,
+					 sdb->table.nents,
+					 data_inout_off + ((n_blks - rest) * lb_size),
+					 rest * lb_size);
+	else
+		ret += sdeb_sgl_copy_sgl(sdb->table.sgl, sdb->table.nents,
+					 data_inout_off + ((n_blks - rest) * lb_size),
+					 sip->sgl, sip->n_elem, 0, rest * lb_size);
+fini:
 	return ret;
 }
 
@@ -3100,37 +3186,66 @@ static int do_dout_fetch(struct scsi_cmnd *scp, u32 num, u8 *doutp)
 			      num * sdebug_sector_size, 0, true);
 }
 
-/* If sip->storep+lba compares equal to arr(num), then copy top half of
- * arr into sip->storep+lba and return true. If comparison fails then
- * return false. */
+/* If sip->storep+lba compares equal to arr(num) or scp->sdb, then if miscomp_idxp is non-NULL,
+ * copy top half of arr into sip->storep+lba and return true. If comparison fails then return
+ * false and write the miscompare_idx via miscomp_idxp. This is the COMAPARE AND WRITE case.
+ * For VERIFY(BytChk=1), set arr to NULL which causes a sgl (store) to sgl (data-out buffer)
+ * compare to be done. VERIFY(BytChk=3) sets arr to a valid address and sets miscomp_idxp
+ * to NULL.
+ */
 static bool comp_write_worker(struct sdeb_store_info *sip, u64 lba, u32 num,
-			      const u8 *arr, bool compare_only)
+			      const u8 *arr, struct scsi_cmnd *scp, size_t *miscomp_idxp)
 {
-	bool res;
-	u64 block, rest = 0;
+	bool equ;
+	u64 block, lba_start, sgl_i, rem, rest = 0;
 	u32 store_blks = sdebug_store_sectors;
-	u32 lb_size = sdebug_sector_size;
-	u8 *fsp = sip->storep;
+	const u32 lb_size = sdebug_sector_size;
+	u32 top_half = num * lb_size;
+	struct scsi_data_buffer *sdb = &scp->sdb;
+	struct scatterlist *store_sgl;
 
 	block = do_div(lba, store_blks);
 	if (block + num > store_blks)
 		rest = block + num - store_blks;
+	lba_start = block * lb_size;
+	sgl_i = lba_start >> sip->elem_pow2;
+	rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+	store_sgl = sip->sgl + sgl_i;	/* O(1) to each store sg element */
+
+	if (!arr) {	/* sgl to sgl compare */
+		equ = sdeb_sgl_compare_sgl_idx(store_sgl, sip->n_elem - sgl_i, rem,
+					       sdb->table.sgl, sdb->table.nents, 0,
+					       (num - rest) * lb_size, miscomp_idxp);
+		if (!equ)
+			return equ;
+		if (rest > 0)
+			equ = sdeb_sgl_compare_sgl_idx(sip->sgl, sip->n_elem, 0, sdb->table.sgl,
+						       sdb->table.nents, (num - rest) * lb_size,
+						       rest * lb_size, miscomp_idxp);
+	} else {
+		equ = sdeb_sgl_cmp_buf(store_sgl, sip->n_elem - sgl_i, arr,
+				       (num - rest) * lb_size, 0);
+		if (!equ)
+			return equ;
+		if (rest > 0)
+			equ = sdeb_sgl_cmp_buf(sip->sgl, sip->n_elem, arr,
+					       (num - rest) * lb_size, 0);
+	}
+	if (!equ || !miscomp_idxp)
+		return equ;
 
-	res = !memcmp(fsp + (block * lb_size), arr, (num - rest) * lb_size);
-	if (!res)
-		return res;
-	if (rest)
-		res = memcmp(fsp, arr + ((num - rest) * lb_size),
-			     rest * lb_size);
-	if (!res)
-		return res;
-	if (compare_only)
-		return true;
-	arr += num * lb_size;
-	memcpy(fsp + (block * lb_size), arr, (num - rest) * lb_size);
-	if (rest)
-		memcpy(fsp, arr + ((num - rest) * lb_size), rest * lb_size);
-	return res;
+	/* Copy "top half" of dout (args: 4, 5 and 6) into store sgl (args 1, 2 and 3) */
+	sdeb_sgl_copy_sgl(store_sgl, sip->n_elem - sgl_i, rem,
+			  sdb->table.sgl, sdb->table.nents, top_half,
+			  (num - rest) * lb_size);
+	if (rest > 0) {	/* for virtual_gb need to handle wrap-around of store */
+		u32 src_off =  top_half + ((num - rest) * lb_size);
+
+		sdeb_sgl_copy_sgl(sip->sgl, sip->n_elem, 0,
+				  sdb->table.sgl, sdb->table.nents, src_off,
+				  rest * lb_size);
+	}
+	return true;
 }
 
 static __be16 dif_compute_csum(const void *buf, int len)
@@ -3223,13 +3338,22 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
 {
 	int ret = 0;
 	unsigned int i;
+	const u32 lb_size = sdebug_sector_size;
 	sector_t sector;
+	u64 lba, lba_start, block, rem, sgl_i;
 	struct sdeb_store_info *sip = devip2sip((struct sdebug_dev_info *)
 						scp->device->hostdata, true);
 	struct t10_pi_tuple *sdt;
+	struct scatterlist *store_sgl;
+	u8 *arr;
+
+	arr = kzalloc(lb_size, GFP_ATOMIC);
+	if (!arr)
+		return -1;	/* mkp, is this correct? */
 
 	for (i = 0; i < sectors; i++, ei_lba++) {
 		sector = start_sec + i;
+		lba = sector;
 		sdt = dif_store(sip, sector);
 
 		if (sdt->app_tag == cpu_to_be16(0xffff))
@@ -3243,11 +3367,19 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
 		 * have to iterate over the PI twice.
 		 */
 		if (scp->cmnd[1] >> 5) { /* RDPROTECT */
-			ret = dif_verify(sdt, lba2fake_store(sip, sector),
-					 sector, ei_lba);
+			block = do_div(lba, sdebug_store_sectors);
+			lba_start = block * lb_size;
+			sgl_i = lba_start >> sip->elem_pow2;
+			rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+			store_sgl = sip->sgl + sgl_i;
+
+			ret = sg_copy_buffer(store_sgl, sip->n_elem - sgl_i, arr, lb_size, rem, true);
+
+			ret = dif_verify(sdt, arr, sector, ei_lba);
+
 			if (ret) {
 				dif_errors++;
-				break;
+				goto fini;
 			}
 		}
 	}
@@ -3255,6 +3387,8 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
 	dif_copy_prot(scp, start_sec, sectors, true);
 	dix_reads++;
 
+fini:
+	kfree(arr);
 	return ret;
 }
 
@@ -3449,6 +3583,7 @@ static int prot_verify_write(struct scsi_cmnd *SCpnt, sector_t start_sec,
 			     unsigned int sectors, u32 ei_lba)
 {
 	int ret;
+	const u32 lb_size = sdebug_sector_size;
 	struct t10_pi_tuple *sdt;
 	void *daddr;
 	sector_t sector = start_sec;
@@ -3498,7 +3633,7 @@ static int prot_verify_write(struct scsi_cmnd *SCpnt, sector_t start_sec,
 
 			sector++;
 			ei_lba++;
-			dpage_offset += sdebug_sector_size;
+			dpage_offset += lb_size;
 		}
 		diter.consumed = dpage_offset;
 		sg_miter_stop(&diter);
@@ -3573,8 +3708,8 @@ static void map_region(struct sdeb_store_info *sip, sector_t lba,
 static void unmap_region(struct sdeb_store_info *sip, sector_t lba,
 			 unsigned int len)
 {
+	const u32 lb_size = sdebug_sector_size;
 	sector_t end = lba + len;
-	u8 *fsp = sip->storep;
 
 	while (lba < end) {
 		unsigned long index = lba_to_map_index(lba);
@@ -3584,10 +3719,26 @@ static void unmap_region(struct sdeb_store_info *sip, sector_t lba,
 		    index < map_size) {
 			clear_bit(index, sip->map_storep);
 			if (sdebug_lbprz) {  /* for LBPRZ=2 return 0xff_s */
-				memset(fsp + lba * sdebug_sector_size,
-				       (sdebug_lbprz & 1) ? 0 : 0xff,
-				       sdebug_sector_size *
-				       sdebug_unmap_granularity);
+				int val = (sdebug_lbprz & 1) ? 0 : 0xff;
+				u32 num = sdebug_unmap_granularity;
+				u64 lbaa = lba;
+				u64 rest = 0;
+				u64 block, lba_start, sgl_i, rem;
+				struct scatterlist *store_sgl;
+
+				block = do_div(lbaa, sdebug_store_sectors);
+				if (block + num > sdebug_store_sectors)
+					rest = block + num - sdebug_store_sectors;
+				lba_start = block * lb_size;
+				sgl_i = lba_start >> sip->elem_pow2;
+				rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+				store_sgl = sip->sgl + sgl_i;
+
+				sdeb_sgl_memset(store_sgl, sip->n_elem - sgl_i, rem, val,
+						num * lb_size);
+				if (rest)
+					sdeb_sgl_memset(sip->sgl, sip->n_elem, rem, val,
+							(num - rest) * lb_size);
 			}
 			if (sip->dif_storep) {
 				memset(sip->dif_storep + lba, 0xff,
@@ -3745,7 +3896,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 	u8 wrprotect;
 	u16 lbdof, num_lrd, k;
 	u32 num, num_by, bt_len, lbdof_blen, sg_off, cum_lb;
-	u32 lb_size = sdebug_sector_size;
+	const u32 lb_size = sdebug_sector_size;
 	u32 ei_lba;
 	u64 lba;
 	int ret, res;
@@ -3903,13 +4054,12 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	struct scsi_device *sdp = scp->device;
 	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
 	unsigned long long i;
-	u64 block, lbaa;
-	u32 lb_size = sdebug_sector_size;
+	u64 block, lbaa, sgl_i, lba_start, rem;
+	const u32 lb_size = sdebug_sector_size;
 	int ret;
 	struct sdeb_store_info *sip = devip2sip((struct sdebug_dev_info *)
 						scp->device->hostdata, true);
-	u8 *fs1p;
-	u8 *fsp;
+	struct scatterlist *store_sgl;
 
 	sdeb_write_lock(sip);
 
@@ -3925,15 +4075,17 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	}
 	lbaa = lba;
 	block = do_div(lbaa, sdebug_store_sectors);
-	/* if ndob then zero 1 logical block, else fetch 1 logical block */
-	fsp = sip->storep;
-	fs1p = fsp + (block * lb_size);
-	if (ndob) {
-		memset(fs1p, 0, lb_size);
-		ret = 0;
-	} else
-		ret = fetch_to_dev_buffer(scp, fs1p, lb_size);
 
+	/* if ndob then zero 1 logical block, else fetch 1 logical block */
+	lba_start = block * lb_size;
+	sgl_i = lba_start >> sip->elem_pow2;
+	rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+	store_sgl = sip->sgl + sgl_i;
+	ret = 0;
+	if (ndob)
+		sdeb_sgl_memset(store_sgl, sip->n_elem - sgl_i, rem, 0, lb_size);
+	else
+		ret = do_device_access(sip, scp, 0, lba, 1, true);
 	if (-1 == ret) {
 		sdeb_write_unlock(sip);
 		return DID_ERROR << 16;
@@ -3944,9 +4096,11 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 
 	/* Copy first sector to remaining blocks */
 	for (i = 1 ; i < num ; i++) {
-		lbaa = lba + i;
-		block = do_div(lbaa, sdebug_store_sectors);
-		memmove(fsp + (block * lb_size), fs1p, lb_size);
+		ret = do_device_access(sip, scp, 0, lba + i, 1, true);
+		if (-1 == ret) {
+			write_unlock(&sip->macc_lck);
+			return DID_ERROR << 16;
+		}
 	}
 	if (scsi_debug_lbp())
 		map_region(sip, lba, num);
@@ -3955,7 +4109,6 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 		zbc_inc_wp(devip, lba, num);
 out:
 	sdeb_write_unlock(sip);
-
 	return 0;
 }
 
@@ -4061,15 +4214,14 @@ static int resp_write_buffer(struct scsi_cmnd *scp,
 	return 0;
 }
 
-static int resp_comp_write(struct scsi_cmnd *scp,
-			   struct sdebug_dev_info *devip)
+static int resp_comp_write(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	u8 *cmd = scp->cmnd;
-	u8 *arr;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u64 lba;
+	size_t miscomp_idx;
 	u32 dnum;
-	u32 lb_size = sdebug_sector_size;
+	const u32 lb_size = sdebug_sector_size;
 	u8 num;
 	int ret;
 	int retval = 0;
@@ -4092,25 +4244,21 @@ static int resp_comp_write(struct scsi_cmnd *scp,
 	if (ret)
 		return ret;
 	dnum = 2 * num;
-	arr = kcalloc(lb_size, dnum, GFP_ATOMIC);
-	if (NULL == arr) {
-		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
-				INSUFF_RES_ASCQ);
-		return check_condition_result;
-	}
 
 	sdeb_write_lock(sip);
-
-	ret = do_dout_fetch(scp, dnum, arr);
-	if (ret == -1) {
-		retval = DID_ERROR << 16;
+	if (scp->sdb.length < dnum * lb_size || scp->sc_data_direction != DMA_TO_DEVICE) {
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, PARAMETER_LIST_LENGTH_ERR, 0);
+		retval = check_condition_result;
+		if (sdebug_verbose)
+			sdev_printk(KERN_INFO, scp->device,
+				    "%s::%s: cdb indicated=%u, IO sent=%d bytes\n", my_name,
+				    __func__, dnum * lb_size, ret);
 		goto cleanup;
-	} else if (sdebug_verbose && (ret < (dnum * lb_size)))
-		sdev_printk(KERN_INFO, scp->device, "%s: compare_write: cdb "
-			    "indicated=%u, IO sent=%d bytes\n", my_name,
-			    dnum * lb_size, ret);
-	if (!comp_write_worker(sip, lba, num, arr, false)) {
+	}
+
+	if (!comp_write_worker(sip, lba, num, NULL, scp, &miscomp_idx)) {
 		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
+		scsi_set_sense_information(scp->sense_buffer, SCSI_SENSE_BUFFERSIZE, miscomp_idx);
 		retval = check_condition_result;
 		goto cleanup;
 	}
@@ -4118,7 +4266,6 @@ static int resp_comp_write(struct scsi_cmnd *scp,
 		map_region(sip, lba, num);
 cleanup:
 	sdeb_write_unlock(sip);
-	kfree(arr);
 	return retval;
 }
 
@@ -4264,12 +4411,12 @@ static int resp_pre_fetch(struct scsi_cmnd *scp,
 			  struct sdebug_dev_info *devip)
 {
 	int res = 0;
-	u64 lba;
-	u64 block, rest = 0;
+	const u32 lb_size = sdebug_sector_size;
+	u64 lba, block, sgl_i, rem, lba_start, rest = 0;
 	u32 nblks;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
-	u8 *fsp = sip->storep;
+	struct scatterlist *store_sgl;
 
 	if (cmd[0] == PRE_FETCH) {	/* 10 byte cdb */
 		lba = get_unaligned_be32(cmd + 2);
@@ -4282,21 +4429,21 @@ static int resp_pre_fetch(struct scsi_cmnd *scp,
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, LBA_OUT_OF_RANGE, 0);
 		return check_condition_result;
 	}
-	if (!fsp)
-		goto fini;
 	/* PRE-FETCH spec says nothing about LBP or PI so skip them */
 	block = do_div(lba, sdebug_store_sectors);
 	if (block + nblks > sdebug_store_sectors)
 		rest = block + nblks - sdebug_store_sectors;
+	lba_start = block * lb_size;
+	sgl_i = lba_start >> sip->elem_pow2;
+	rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+	store_sgl = sip->sgl + sgl_i;	/* O(1) to each store sg element */
 
 	/* Try to bring the PRE-FETCH range into CPU's cache */
 	sdeb_read_lock(sip);
-	prefetch_range(fsp + (sdebug_sector_size * block),
-		       (nblks - rest) * sdebug_sector_size);
+	sdeb_sgl_prefetch(store_sgl, sip->n_elem - sgl_i, rem, (nblks - rest) * lb_size);
 	if (rest)
-		prefetch_range(fsp, rest * sdebug_sector_size);
+		sdeb_sgl_prefetch(sip->sgl, sip->n_elem, 0, rest * lb_size);
 	sdeb_read_unlock(sip);
-fini:
 	if (cmd[1] & 0x2)
 		res = SDEG_RES_IMMED_MASK;
 	return res | condition_met_result;
@@ -4413,7 +4560,7 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u32 vnum, a_num, off;
 	const u32 lb_size = sdebug_sector_size;
 	u64 lba;
-	u8 *arr;
+	u8 *arr = NULL;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 
@@ -4447,30 +4594,31 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	if (ret)
 		return ret;
 
-	arr = kcalloc(lb_size, vnum, GFP_ATOMIC);
-	if (!arr) {
-		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
-				INSUFF_RES_ASCQ);
-		return check_condition_result;
+	if (is_bytchk3) {
+		arr = kcalloc(lb_size, vnum, GFP_ATOMIC);
+		if (!arr) {
+			mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC, INSUFF_RES_ASCQ);
+			return check_condition_result;
+		}
 	}
 	/* Not changing store, so only need read access */
 	sdeb_read_lock(sip);
 
-	ret = do_dout_fetch(scp, a_num, arr);
-	if (ret == -1) {
-		ret = DID_ERROR << 16;
-		goto cleanup;
-	} else if (sdebug_verbose && (ret < (a_num * lb_size))) {
-		sdev_printk(KERN_INFO, scp->device,
-			    "%s: %s: cdb indicated=%u, IO sent=%d bytes\n",
-			    my_name, __func__, a_num * lb_size, ret);
-	}
 	if (is_bytchk3) {
+		ret = do_dout_fetch(scp, a_num, arr);
+		if (ret == -1) {
+			ret = DID_ERROR << 16;
+			goto cleanup;
+		} else if (sdebug_verbose && (ret < (a_num * lb_size))) {
+			sdev_printk(KERN_INFO, scp->device,
+				    "%s: %s: cdb indicated=%u, IO sent=%d bytes\n",
+				    my_name, __func__, a_num * lb_size, ret);
+		}
 		for (j = 1, off = lb_size; j < vnum; ++j, off += lb_size)
 			memcpy(arr + off, arr, lb_size);
 	}
 	ret = 0;
-	if (!comp_write_worker(sip, lba, vnum, arr, true)) {
+	if (!comp_write_worker(sip, lba, vnum, arr, scp, NULL)) {
 		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
 		ret = check_condition_result;
 		goto cleanup;
@@ -4841,9 +4989,16 @@ static void zbc_rwp_zone(struct sdebug_dev_info *devip,
 	if (zsp->z_cond == ZC4_CLOSED)
 		devip->nr_closed--;
 
-	if (zsp->z_wp > zsp->z_start)
-		memset(sip->storep + zsp->z_start * sdebug_sector_size, 0,
-		       (zsp->z_wp - zsp->z_start) * sdebug_sector_size);
+	if (zsp->z_wp > zsp->z_start) {
+		u32 lb_size = sdebug_sector_size;
+		u64 lba_start = zsp->z_start * lb_size;
+		u64 sgl_i = lba_start >> sip->elem_pow2;
+		u64 rem = lba_start - (sgl_i ? (sgl_i << sip->elem_pow2) : 0);
+		struct scatterlist *store_sgl = sip->sgl + sgl_i;
+
+		sdeb_sgl_memset(store_sgl, sip->n_elem - sgl_i, rem, 0,
+				(zsp->z_wp - zsp->z_start) * lb_size);
+	}
 
 	zsp->z_non_seq_resource = false;
 	zsp->z_wp = zsp->z_start;
@@ -6106,15 +6261,15 @@ static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 				   sdhp->shost->host_no, idx);
 			++j;
 		}
-		seq_printf(m, "\nper_store array [most_recent_idx=%d]:\n",
+		seq_printf(m, "\nper_store array [most_recent_idx=%d] sgl_s:\n",
 			   sdeb_most_recent_idx);
 		j = 0;
 		xa_for_each(per_store_ap, l_idx, sip) {
 			niu = xa_get_mark(per_store_ap, l_idx,
 					  SDEB_XA_NOT_IN_USE);
 			idx = (int)l_idx;
-			seq_printf(m, "  %d: idx=%d%s\n", j, idx,
-				   (niu ? "  not_in_use" : ""));
+			seq_printf(m, "  %d: idx=%d%s, n_elems=%u, elem_sz=%u\n", j, idx,
+				   (niu ? "  not_in_use" : ""), sip->n_elem, 1 << sip->elem_pow2);
 			++j;
 		}
 	}
@@ -7251,7 +7406,8 @@ static void sdebug_erase_store(int idx, struct sdeb_store_info *sip)
 	}
 	vfree(sip->map_storep);
 	vfree(sip->dif_storep);
-	vfree(sip->storep);
+	if (sip->sgl)
+		sgl_free_n_order(sip->sgl, sip->n_elem, sip->order);
 	xa_erase(per_store_ap, idx);
 	kfree(sip);
 }
@@ -7272,6 +7428,41 @@ static void sdebug_erase_all_stores(bool apart_from_first)
 		sdeb_most_recent_idx = sdeb_first_idx;
 }
 
+/* Want uniform sg element size, the last one can be less. */
+static int sdeb_store_sgat(struct sdeb_store_info *sip, int sz_mib)
+{
+	unsigned int order;
+	unsigned long sz_b = (unsigned long)sz_mib * 1048576;
+	gfp_t mask_ap = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
+
+	if (sz_mib <= 128)
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 32 * 1024));
+	else if (sz_mib <= 256)
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 64 * 1024));
+	else if (sz_mib <= 512)
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 128 * 1024));
+	else if (sz_mib <= 1024)
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 256 * 1024));
+	else if (sz_mib <= 2048)
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 512 * 1024));
+	else
+		order = get_order(max_t(unsigned int, PAGE_SIZE, 1024 * 1024));
+	sip->sgl = sdeb_sgl_alloc_order(sz_b, order, mask_ap, &sip->n_elem);
+	if (!sip->sgl && order > 0) {
+		sip->sgl = sdeb_sgl_alloc_order(sz_b, --order, mask_ap, &sip->n_elem);
+		if (!sip->sgl && order > 0)
+			sip->sgl = sdeb_sgl_alloc_order(sz_b, --order, mask_ap, &sip->n_elem);
+	}
+	if (!sip->sgl) {
+		pr_info("%s: unable to obtain %d MiB, last element size: %u kiB\n", __func__,
+			sz_mib, (1 << (PAGE_SHIFT + order)) / 1024);
+		return -ENOMEM;
+	}
+	sip->order = order;
+	sip->elem_pow2 = PAGE_SHIFT + order;
+	return 0;
+}
+
 /*
  * Returns store xarray new element index (idx) if >=0 else negated errno.
  * Limit the number of stores to 65536.
@@ -7303,13 +7494,21 @@ static int sdebug_add_store(void)
 	xa_unlock_irqrestore(per_store_ap, iflags);
 
 	res = -ENOMEM;
-	sip->storep = vzalloc(sz);
-	if (!sip->storep) {
-		pr_err("user data oom\n");
+	res = sdeb_store_sgat(sip, sdebug_dev_size_mb);
+	if (res) {
+		pr_err("sgat: user data oom\n");
 		goto err;
 	}
-	if (sdebug_num_parts > 0)
-		sdebug_build_parts(sip->storep, sz);
+	if (sdebug_num_parts > 0) {
+		const int a_len = 1024;
+		u8 *arr = kzalloc(a_len, GFP_KERNEL);
+
+		if (arr) {
+			sdebug_build_parts(arr, sz);
+			sg_copy_from_buffer(sip->sgl, sip->n_elem, arr, a_len);
+			kfree(arr);
+		}
+	}
 
 	/* DIF/DIX: what T10 calls Protection Information (PI) */
 	if (sdebug_dix) {
-- 
2.25.1

