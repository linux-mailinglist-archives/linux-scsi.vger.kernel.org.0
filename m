Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4353E175245
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 04:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCBDd0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 1 Mar 2020 22:33:26 -0500
Received: from smtp.infotech.no ([82.134.31.41]:60627 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgCBDd0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 1 Mar 2020 22:33:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id F0EDB204269;
        Mon,  2 Mar 2020 04:33:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u64eH0IwH7Ld; Mon,  2 Mar 2020 04:33:22 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 96646204255;
        Mon,  2 Mar 2020 04:33:17 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v8 22/38] sg: printk change %p to %pK
Date:   Sun,  1 Mar 2020 22:32:33 -0500
Message-Id: <20200302033249.4515-23-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302033249.4515-1-dgilbert@interlog.com>
References: <20200302033249.4515-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This driver does a lot of buffer juggling in an attempt to
take some of that chore away from its users. When debugging
problems associated with that buffer juggling getting
sensible pointer values is a major aid. So change %p
to %pK. The system administrator can choose to obfuscate
%pK pointers. The "pK" is also easier to search for in the
code if further changes are required.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d931ead5cd43..0073272a069f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -907,7 +907,7 @@ sg_receive_v3(struct sg_fd *sfp, struct sg_request *srp, size_t count,
 		err = -EINVAL;
 		goto err_out;
 	}
-	SG_LOG(3, sfp, "%s: srp=0x%p\n", __func__, srp);
+	SG_LOG(3, sfp, "%s: srp=0x%pK\n", __func__, srp);
 	err = sg_rec_state_v3(sfp, srp);
 	if (hp->masked_status || hp->host_status || hp->driver_status)
 		hp->info |= SG_INFO_CHECK;
@@ -1694,7 +1694,7 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -ENXIO;
 	}
 	req_sz = vma->vm_end - vma->vm_start;
-	SG_LOG(3, sfp, "%s: vm_start=%p, len=%d\n", __func__,
+	SG_LOG(3, sfp, "%s: vm_start=%pK, len=%d\n", __func__,
 	       (void *)vma->vm_start, (int)req_sz);
 	if (vma->vm_pgoff)
 		return -EINVAL; /* only an offset of 0 accepted */
@@ -1742,7 +1742,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 		WARN_ONCE(1, "%s: sfp unexpectedly NULL\n", __func__);
 		return;
 	}
-	SG_LOG(3, sfp, "%s: srp=0x%p\n", __func__, srp);
+	SG_LOG(3, sfp, "%s: srp=0x%pK\n", __func__, srp);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
@@ -1915,7 +1915,7 @@ sg_add_device_helper(struct gendisk *disk, struct scsi_device *scsidp)
 	k = error;
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, scsidp,
-			 "%s: dev=%d, sdp=0x%p ++\n", __func__, k, sdp));
+			 "%s: dev=%d, sdp=0x%pK ++\n", __func__, k, sdp));
 	sprintf(disk->disk_name, "sg%d", k);
 	disk->first_minor = k;
 	sdp->disk = disk;
@@ -2033,7 +2033,7 @@ sg_device_destroy(struct kref *kref)
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
 
-	sdev_printk(KERN_INFO, sdp->device, "[tid=%d] %s: sdp=0x%p --\n",
+	sdev_printk(KERN_INFO, sdp->device, "[tid=%d] %s: sdp=0x%pK --\n",
 		    (current ? current->pid : -1), __func__, sdp);
 
 	put_disk(sdp->disk);
@@ -2055,7 +2055,7 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 		return; /* only want to do following once per device */
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, sdp->device,
-					"%s: 0x%p\n", __func__, sdp));
+					"%s: 0x%pK\n", __func__, sdp));
 
 	read_lock_irqsave(&sdp->sfd_lock, iflags);
 	list_for_each_entry(sfp, &sdp->sfds, sfd_entry) {
@@ -2184,7 +2184,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 		long_cmdp = kzalloc(hp->cmd_len, GFP_KERNEL);
 		if (!long_cmdp)
 			return -ENOMEM;
-		SG_LOG(5, sfp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
+		SG_LOG(5, sfp, "%s: long_cmdp=0x%pK ++\n", __func__, long_cmdp);
 	}
 	SG_LOG(4, sfp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
 	       (r0w ? "OUT" : "IN"));
@@ -2299,7 +2299,7 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 	struct sg_fd *sfp = srp->parentfp;
 	struct sg_scatter_hold *req_schp = &srp->data;
 
-	SG_LOG(4, sfp, "%s: srp=0x%p%s\n", __func__, srp,
+	SG_LOG(4, sfp, "%s: srp=0x%pK%s\n", __func__, srp,
 	       (srp->res_used) ? " rsv" : "");
 	if (!srp->sg_io_owned) {
 		atomic_dec(&sfp->submitted);
@@ -2346,7 +2346,7 @@ sg_mk_sgat(struct sg_scatter_hold *schp, struct sg_fd *sfp, int minlen)
 	align_sz = ALIGN(m_size, SG_DEF_SECTOR_SZ);
 
 	schp->pages = kcalloc(mx_sgat_elems, struct_page_sz, mask_kz);
-	SG_LOG(4, sfp, "%s: minlen=%d, align_sz=%d [sz=%zu, 0x%p ++]\n",
+	SG_LOG(4, sfp, "%s: minlen=%d, align_sz=%d [sz=%zu, 0x%pK ++]\n",
 	       __func__, minlen, align_sz, mx_sgat_elems * struct_page_sz,
 	       schp->pages);
 	if (unlikely(!schp->pages))
@@ -2366,7 +2366,7 @@ sg_mk_sgat(struct sg_scatter_hold *schp, struct sg_fd *sfp, int minlen)
 		schp->pages[k] = alloc_pages(mask_ap, order);
 		if (!schp->pages[k])
 			goto err_out;
-		SG_LOG(5, sfp, "%s: k=%d, rup_sz=%d [0x%p ++]\n", __func__, k,
+		SG_LOG(5, sfp, "%s: k=%d, rup_sz=%d [0x%pK ++]\n", __func__, k,
 		       rup_sz, schp->pages[k]);
 	}
 	schp->page_order = order;
@@ -2400,12 +2400,12 @@ sg_remove_sgat_helper(struct sg_fd *sfp, struct sg_scatter_hold *schp)
 		return;
 	for (k = 0; k < schp->num_sgat; ++k) {
 		p = schp->pages[k];
-		SG_LOG(5, sfp, "%s: pg[%d]=0x%p --\n", __func__, k, p);
+		SG_LOG(5, sfp, "%s: pg[%d]=0x%pK --\n", __func__, k, p);
 		if (unlikely(!p))
 			continue;
 		__free_pages(p, schp->page_order);
 	}
-	SG_LOG(5, sfp, "%s: pg_order=%u, free pgs=0x%p --\n", __func__,
+	SG_LOG(5, sfp, "%s: pg_order=%u, free pgs=0x%pK --\n", __func__,
 	       schp->page_order, schp->pages);
 	kfree(schp->pages);
 }
@@ -2642,7 +2642,7 @@ sg_add_sfp(struct sg_device *sdp)
 	}
 	list_add_tail(&sfp->sfd_entry, &sdp->sfds);
 	write_unlock_irqrestore(&sdp->sfd_lock, iflags);
-	SG_LOG(3, sfp, "%s: sfp=0x%p\n", __func__, sfp);
+	SG_LOG(3, sfp, "%s: sfp=0x%pK\n", __func__, sfp);
 	if (unlikely(sg_big_buff != def_reserved_size))
 		sg_big_buff = def_reserved_size;
 
@@ -2652,7 +2652,7 @@ sg_add_sfp(struct sg_device *sdp)
 
 	kref_get(&sdp->d_ref);
 	__module_get(THIS_MODULE);
-	SG_LOG(3, sfp, "%s: success, sfp=0x%p ++\n", __func__, sfp);
+	SG_LOG(3, sfp, "%s: success, sfp=0x%pK ++\n", __func__, sfp);
 	return sfp;
 }
 
@@ -2695,7 +2695,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		sg_remove_sgat(sfp, &sfp->reserve);
 	}
 
-	SG_LOG(6, sfp, "%s: sfp=0x%p\n", __func__, sfp);
+	SG_LOG(6, sfp, "%s: sfp=0x%pK\n", __func__, sfp);
 	kfree(sfp);
 
 	if (sdp) {
-- 
2.25.1

