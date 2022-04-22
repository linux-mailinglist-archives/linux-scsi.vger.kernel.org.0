Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3D50B69A
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Apr 2022 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447212AbiDVL6D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Apr 2022 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447211AbiDVL56 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Apr 2022 07:57:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C531C908
        for <linux-scsi@vger.kernel.org>; Fri, 22 Apr 2022 04:55:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j8so10314014pll.11
        for <linux-scsi@vger.kernel.org>; Fri, 22 Apr 2022 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=cH0tTqiDcyh9ph2+DK4SjFI/qMUjhiQP2iCA8uASj2w=;
        b=H0KQyU0guUwHjEwQH+qKD3Q7I5nvcz4d1oZ1nuuZSWMG3a/MvG0B4nHuaBLdD9dt4G
         qI7QxrMNwIYdCiuVTq1gPxL7bOmmIo6unAvSO6jRzZI7+DKob+KKTUfWiSbagYA3MkaE
         +0hdLEovhBIwXfJBiC3HlLrErQeWO6qLcS3TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=cH0tTqiDcyh9ph2+DK4SjFI/qMUjhiQP2iCA8uASj2w=;
        b=YI7Oo99ata2zyusq7gAM7yxx1vFbFjm90nASFq3uPEs+GFTmmuybavRc6gckbfdho0
         Qe9CM/MAAAFS2kNqhVlCavbLJJCKmFRMG/H8jNJuZjLPUrz1ULz5OL3ymcWly3JbvghP
         3x59RHpzGhX3HYLDIaYR4X+pB3gbj8mP2SPBc4yhcFB60f9SL4cTwA9zfvQa2L+n5y8H
         RsHr/+P0ndRpMqvihNigDYkU71PjLovHyScPGS+pMi26lDrCKKi1+rgq9U58Tuccjgmx
         MP3nhCXpBkxfy1HDartcP9f/O1pG50P+ER0yTqDmi8xOBp+WD/uaBwQhA56eMlxD8Gvx
         sEcg==
X-Gm-Message-State: AOAM530Y2JJjl4c82MvtOYfIplK5zOICZbm2XosrsVBoaMcg5rtPIcNu
        ULsFt6R7SXub5DbdoC0Xkwtxo3o6e5z4+S4yFHautgItq40zOWA8+aN0VP2LWdzcsc3acI9mYaa
        sDsqCBt1jIY89I41YUoMWEZ/OI8Z6ecWhyh+7zIC3juUHkdN6gqFm/GBcsemOTwREz89pe2vsh6
        Ns61KLrHs=
X-Google-Smtp-Source: ABdhPJyZq5Ou3EJOcS3BmOpO/8e7fge6P5ZENZ3du2cln/pLBlqCtHPZxIS9U2NVhvbvGbz10ISVtQ==
X-Received: by 2002:a17:90b:1a87:b0:1d5:2320:9b6b with SMTP id ng7-20020a17090b1a8700b001d523209b6bmr11834113pjb.90.1650628502950;
        Fri, 22 Apr 2022 04:55:02 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a714600b001d7f3bb11d7sm2367981pjs.53.2022.04.22.04.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:55:01 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, bvanassche@acm.org, hch@lst.de,
        hare@suse.de, himanshu.madhani@oracle.com,
        sathya.prakash@broadcom.com, kashyap.desai@broadcom.com,
        chandrakanth.patil@broadcom.com, sreekanth.reddy@broadcom.com,
        prayas.patel@broadcom.com, Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v5 2/8] mpi3mr: add support for driver commands
Date:   Fri, 22 Apr 2022 07:54:17 -0400
Message-Id: <20220422115423.279805-3-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220422115423.279805-1-sumit.saxena@broadcom.com>
References: <20220422115423.279805-1-sumit.saxena@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a1816505dd3ce5fd"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000a1816505dd3ce5fd
Content-Transfer-Encoding: 8bit

There are certain BSG commands which is to be completed
by driver without involving firmware. These requests are termed
as driver commands. This patch adds support for the same.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h        |  16 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c    | 390 +++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_debug.h  |  12 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c     |  21 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c     |   3 +
 include/uapi/scsi/scsi_bsg_mpi3mr.h | 433 ++++++++++++++++++++++++++++
 6 files changed, 863 insertions(+), 12 deletions(-)
 create mode 100644 include/uapi/scsi/scsi_bsg_mpi3mr.h

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index f0515f929110..877b0925dbc5 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -89,7 +89,7 @@ extern int prot_mask;
 /* Reserved Host Tag definitions */
 #define MPI3MR_HOSTTAG_INVALID		0xFFFF
 #define MPI3MR_HOSTTAG_INITCMDS		1
-#define MPI3MR_HOSTTAG_IOCTLCMDS	2
+#define MPI3MR_HOSTTAG_BSG_CMDS		2
 #define MPI3MR_HOSTTAG_BLK_TMS		5
 
 #define MPI3MR_NUM_DEVRMCMD		16
@@ -202,10 +202,10 @@ enum mpi3mr_iocstate {
 enum mpi3mr_reset_reason {
 	MPI3MR_RESET_FROM_BRINGUP = 1,
 	MPI3MR_RESET_FROM_FAULT_WATCH = 2,
-	MPI3MR_RESET_FROM_IOCTL = 3,
+	MPI3MR_RESET_FROM_APP = 3,
 	MPI3MR_RESET_FROM_EH_HOS = 4,
 	MPI3MR_RESET_FROM_TM_TIMEOUT = 5,
-	MPI3MR_RESET_FROM_IOCTL_TIMEOUT = 6,
+	MPI3MR_RESET_FROM_APP_TIMEOUT = 6,
 	MPI3MR_RESET_FROM_MUR_FAILURE = 7,
 	MPI3MR_RESET_FROM_CTLR_CLEANUP = 8,
 	MPI3MR_RESET_FROM_CIACTIV_FAULT = 9,
@@ -698,6 +698,7 @@ struct scmd_priv {
  * @chain_bitmap_sz: Chain buffer allocator bitmap size
  * @chain_bitmap: Chain buffer allocator bitmap
  * @chain_buf_lock: Chain buffer list lock
+ * @bsg_cmds: Command tracker for BSG command
  * @host_tm_cmds: Command tracker for task management commands
  * @dev_rmhs_cmds: Command tracker for device removal commands
  * @evtack_cmds: Command tracker for event ack commands
@@ -729,6 +730,10 @@ struct scmd_priv {
  * @requested_poll_qcount: User requested poll queue count
  * @bsg_dev: BSG device structure
  * @bsg_queue: Request queue for BSG device
+ * @stop_bsgs: Stop BSG request flag
+ * @logdata_buf: Circular buffer to store log data entries
+ * @logdata_buf_idx: Index of entry in buffer to store
+ * @logdata_entry_sz: log data entry size
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -835,6 +840,7 @@ struct mpi3mr_ioc {
 	void *chain_bitmap;
 	spinlock_t chain_buf_lock;
 
+	struct mpi3mr_drv_cmd bsg_cmds;
 	struct mpi3mr_drv_cmd host_tm_cmds;
 	struct mpi3mr_drv_cmd dev_rmhs_cmds[MPI3MR_NUM_DEVRMCMD];
 	struct mpi3mr_drv_cmd evtack_cmds[MPI3MR_NUM_EVTACKCMD];
@@ -872,6 +878,10 @@ struct mpi3mr_ioc {
 
 	struct device *bsg_dev;
 	struct request_queue *bsg_queue;
+	u8 stop_bsgs;
+	u8 *logdata_buf;
+	u16 logdata_buf_idx;
+	u16 logdata_entry_sz;
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 9b6698525990..901a927cf4e0 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -9,6 +9,379 @@
 
 #include "mpi3mr.h"
 #include <linux/bsg-lib.h>
+#include <uapi/scsi/scsi_bsg_mpi3mr.h>
+
+/**
+ * mpi3mr_bsg_verify_adapter - verify adapter number is valid
+ * @ioc_number: Adapter number
+ *
+ * This function returns the adapter instance pointer of given
+ * adapter number. If adapter number does not match with the
+ * driver's adapter list, driver returns NULL.
+ *
+ * Return: adapter instance reference
+ */
+static struct mpi3mr_ioc *mpi3mr_bsg_verify_adapter(int ioc_number)
+{
+	struct mpi3mr_ioc *mrioc = NULL;
+
+	spin_lock(&mrioc_list_lock);
+	list_for_each_entry(mrioc, &mrioc_list, list) {
+		if (mrioc->id == ioc_number) {
+			spin_unlock(&mrioc_list_lock);
+			return mrioc;
+		}
+	}
+	spin_unlock(&mrioc_list_lock);
+	return NULL;
+}
+
+/**
+ * mpi3mr_enable_logdata - Handler for log data enable
+ * @mrioc: Adapter instance reference
+ * @job: BSG job reference
+ *
+ * This function enables log data caching in the driver if not
+ * already enabled and return the maximum number of log data
+ * entries that can be cached in the driver.
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_enable_logdata(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	struct mpi3mr_logdata_enable logdata_enable;
+
+	if (!mrioc->logdata_buf) {
+		mrioc->logdata_entry_sz =
+		    (mrioc->reply_sz - (sizeof(struct mpi3_event_notification_reply) - 4))
+		    + MPI3MR_BSG_LOGDATA_ENTRY_HEADER_SZ;
+		mrioc->logdata_buf_idx = 0;
+		mrioc->logdata_buf = kcalloc(MPI3MR_BSG_LOGDATA_MAX_ENTRIES,
+		    mrioc->logdata_entry_sz, GFP_KERNEL);
+
+		if (!mrioc->logdata_buf)
+			return -ENOMEM;
+	}
+
+	memset(&logdata_enable, 0, sizeof(logdata_enable));
+	logdata_enable.max_entries =
+	    MPI3MR_BSG_LOGDATA_MAX_ENTRIES;
+	if (job->request_payload.payload_len >= sizeof(logdata_enable)) {
+		sg_copy_from_buffer(job->request_payload.sg_list,
+				    job->request_payload.sg_cnt,
+				    &logdata_enable, sizeof(logdata_enable));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+/**
+ * mpi3mr_get_logdata - Handler for get log data
+ * @mrioc: Adapter instance reference
+ * @job: BSG job pointer
+ * This function copies the log data entries to the user buffer
+ * when log caching is enabled in the driver.
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_get_logdata(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	u16 num_entries, sz, entry_sz = mrioc->logdata_entry_sz;
+
+	if ((!mrioc->logdata_buf) || (job->request_payload.payload_len < entry_sz))
+		return -EINVAL;
+
+	num_entries = job->request_payload.payload_len / entry_sz;
+	if (num_entries > MPI3MR_BSG_LOGDATA_MAX_ENTRIES)
+		num_entries = MPI3MR_BSG_LOGDATA_MAX_ENTRIES;
+	sz = num_entries * entry_sz;
+
+	if (job->request_payload.payload_len >= sz) {
+		sg_copy_from_buffer(job->request_payload.sg_list,
+				    job->request_payload.sg_cnt,
+				    mrioc->logdata_buf, sz);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * mpi3mr_get_all_tgt_info - Get all target information
+ * @mrioc: Adapter instance reference
+ * @job: BSG job reference
+ *
+ * This function copies the driver managed target devices device
+ * handle, persistent ID, bus ID and taret ID to the user
+ * provided buffer for the specific controller. This function
+ * also provides the number of devices managed by the driver for
+ * the specific controller.
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_get_all_tgt_info(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	long rval = -EINVAL;
+	u16 num_devices = 0, i = 0, size;
+	unsigned long flags;
+	struct mpi3mr_tgt_dev *tgtdev;
+	struct mpi3mr_device_map_info *devmap_info = NULL;
+	struct mpi3mr_all_tgt_info *alltgt_info = NULL;
+	uint32_t min_entrylen = 0, kern_entrylen = 0, usr_entrylen = 0;
+
+	if (job->request_payload.payload_len < sizeof(u32)) {
+		dprint_bsg_err(mrioc, "%s: invalid size argument\n",
+		    __func__);
+		return rval;
+	}
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list)
+		num_devices++;
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
+	if ((job->request_payload.payload_len == sizeof(u32)) ||
+		list_empty(&mrioc->tgtdev_list)) {
+		sg_copy_from_buffer(job->request_payload.sg_list,
+				    job->request_payload.sg_cnt,
+				    &num_devices, sizeof(num_devices));
+		return 0;
+	}
+
+	kern_entrylen = (num_devices - 1) * sizeof(*devmap_info);
+	size = sizeof(*alltgt_info) + kern_entrylen;
+	alltgt_info = kzalloc(size, GFP_KERNEL);
+	if (!alltgt_info)
+		return -ENOMEM;
+
+	devmap_info = alltgt_info->dmi;
+	memset((u8 *)devmap_info, 0xFF, (kern_entrylen + sizeof(*devmap_info)));
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list) {
+		if (i < num_devices) {
+			devmap_info[i].handle = tgtdev->dev_handle;
+			devmap_info[i].perst_id = tgtdev->perst_id;
+			if (tgtdev->host_exposed && tgtdev->starget) {
+				devmap_info[i].target_id = tgtdev->starget->id;
+				devmap_info[i].bus_id =
+				    tgtdev->starget->channel;
+			}
+			i++;
+		}
+	}
+	num_devices = i;
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
+	memcpy(&alltgt_info->num_devices, &num_devices, sizeof(num_devices));
+
+	usr_entrylen = (job->request_payload.payload_len - sizeof(u32)) / sizeof(*devmap_info);
+	usr_entrylen *= sizeof(*devmap_info);
+	min_entrylen = min(usr_entrylen, kern_entrylen);
+	if (min_entrylen && (!memcpy(&alltgt_info->dmi, devmap_info, min_entrylen))) {
+		dprint_bsg_err(mrioc, "%s:%d: device map info copy failed\n",
+		    __func__, __LINE__);
+		rval = -EFAULT;
+		goto out;
+	}
+
+	sg_copy_from_buffer(job->request_payload.sg_list,
+			    job->request_payload.sg_cnt,
+			    alltgt_info, job->request_payload.payload_len);
+	rval = 0;
+out:
+	kfree(alltgt_info);
+	return rval;
+}
+
+/**
+ * mpi3mr_get_change_count - Get topology change count
+ * @mrioc: Adapter instance reference
+ * @job: BSG job reference
+ *
+ * This function copies the toplogy change count provided by the
+ * driver in events and cached in the driver to the user
+ * provided buffer for the specific controller.
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_get_change_count(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	struct mpi3mr_change_count chgcnt;
+
+	memset(&chgcnt, 0, sizeof(chgcnt));
+	chgcnt.change_count = mrioc->change_count;
+	if (job->request_payload.payload_len >= sizeof(chgcnt)) {
+		sg_copy_from_buffer(job->request_payload.sg_list,
+				    job->request_payload.sg_cnt,
+				    &chgcnt, sizeof(chgcnt));
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * mpi3mr_bsg_adp_reset - Issue controller reset
+ * @mrioc: Adapter instance reference
+ * @job: BSG job reference
+ *
+ * This function identifies the user provided reset type and
+ * issues approporiate reset to the controller and wait for that
+ * to complete and reinitialize the controller and then returns
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_bsg_adp_reset(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	long rval = -EINVAL;
+	u8 save_snapdump;
+	struct mpi3mr_bsg_adp_reset adpreset;
+
+	if (job->request_payload.payload_len !=
+			sizeof(adpreset)) {
+		dprint_bsg_err(mrioc, "%s: invalid size argument\n",
+		    __func__);
+		goto out;
+	}
+
+	sg_copy_to_buffer(job->request_payload.sg_list,
+			  job->request_payload.sg_cnt,
+			  &adpreset, sizeof(adpreset));
+
+	switch (adpreset.reset_type) {
+	case MPI3MR_BSG_ADPRESET_SOFT:
+		save_snapdump = 0;
+		break;
+	case MPI3MR_BSG_ADPRESET_DIAG_FAULT:
+		save_snapdump = 1;
+		break;
+	default:
+		dprint_bsg_err(mrioc, "%s: unknown reset_type(%d)\n",
+		    __func__, adpreset.reset_type);
+		goto out;
+	}
+
+	rval = mpi3mr_soft_reset_handler(mrioc, MPI3MR_RESET_FROM_APP,
+	    save_snapdump);
+
+	if (rval)
+		dprint_bsg_err(mrioc,
+		    "%s: reset handler returned error(%ld) for reset type %d\n",
+		    __func__, rval, adpreset.reset_type);
+out:
+	return rval;
+}
+
+/**
+ * mpi3mr_bsg_populate_adpinfo - Get adapter info command handler
+ * @mrioc: Adapter instance reference
+ * @job: BSG job reference
+ *
+ * This function provides adapter information for the given
+ * controller
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_bsg_populate_adpinfo(struct mpi3mr_ioc *mrioc,
+	struct bsg_job *job)
+{
+	enum mpi3mr_iocstate ioc_state;
+	struct mpi3mr_bsg_in_adpinfo adpinfo;
+
+	memset(&adpinfo, 0, sizeof(adpinfo));
+	adpinfo.adp_type = MPI3MR_BSG_ADPTYPE_AVGFAMILY;
+	adpinfo.pci_dev_id = mrioc->pdev->device;
+	adpinfo.pci_dev_hw_rev = mrioc->pdev->revision;
+	adpinfo.pci_subsys_dev_id = mrioc->pdev->subsystem_device;
+	adpinfo.pci_subsys_ven_id = mrioc->pdev->subsystem_vendor;
+	adpinfo.pci_bus = mrioc->pdev->bus->number;
+	adpinfo.pci_dev = PCI_SLOT(mrioc->pdev->devfn);
+	adpinfo.pci_func = PCI_FUNC(mrioc->pdev->devfn);
+	adpinfo.pci_seg_id = pci_domain_nr(mrioc->pdev->bus);
+	adpinfo.app_intfc_ver = MPI3MR_IOCTL_VERSION;
+
+	ioc_state = mpi3mr_get_iocstate(mrioc);
+	if (ioc_state == MRIOC_STATE_UNRECOVERABLE)
+		adpinfo.adp_state = MPI3MR_BSG_ADPSTATE_UNRECOVERABLE;
+	else if ((mrioc->reset_in_progress) || (mrioc->stop_bsgs))
+		adpinfo.adp_state = MPI3MR_BSG_ADPSTATE_IN_RESET;
+	else if (ioc_state == MRIOC_STATE_FAULT)
+		adpinfo.adp_state = MPI3MR_BSG_ADPSTATE_FAULT;
+	else
+		adpinfo.adp_state = MPI3MR_BSG_ADPSTATE_OPERATIONAL;
+
+	memcpy((u8 *)&adpinfo.driver_info, (u8 *)&mrioc->driver_info,
+	    sizeof(adpinfo.driver_info));
+
+	if (job->request_payload.payload_len >= sizeof(adpinfo)) {
+		sg_copy_from_buffer(job->request_payload.sg_list,
+				    job->request_payload.sg_cnt,
+				    &adpinfo, sizeof(adpinfo));
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * mpi3mr_bsg_process_drv_cmds - Driver Command handler
+ * @job: BSG job reference
+ *
+ * This function is the top level handler for driver commands,
+ * this does basic validation of the buffer and identifies the
+ * opcode and switches to correct sub handler.
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static long mpi3mr_bsg_process_drv_cmds(struct bsg_job *job)
+{
+	long rval = -EINVAL;
+	struct mpi3mr_ioc *mrioc = NULL;
+	struct mpi3mr_bsg_packet *bsg_req = NULL;
+	struct mpi3mr_bsg_drv_cmd *drvrcmd = NULL;
+
+	bsg_req = job->request;
+	drvrcmd = &bsg_req->cmd.drvrcmd;
+
+	mrioc = mpi3mr_bsg_verify_adapter(drvrcmd->mrioc_id);
+	if (!mrioc)
+		return -ENODEV;
+
+	if (drvrcmd->opcode == MPI3MR_DRVBSG_OPCODE_ADPINFO) {
+		rval = mpi3mr_bsg_populate_adpinfo(mrioc, job);
+		return rval;
+	}
+
+	if (mutex_lock_interruptible(&mrioc->bsg_cmds.mutex))
+		return -ERESTARTSYS;
+
+	switch (drvrcmd->opcode) {
+	case MPI3MR_DRVBSG_OPCODE_ADPRESET:
+		rval = mpi3mr_bsg_adp_reset(mrioc, job);
+		break;
+	case MPI3MR_DRVBSG_OPCODE_ALLTGTDEVINFO:
+		rval = mpi3mr_get_all_tgt_info(mrioc, job);
+		break;
+	case MPI3MR_DRVBSG_OPCODE_GETCHGCNT:
+		rval = mpi3mr_get_change_count(mrioc, job);
+		break;
+	case MPI3MR_DRVBSG_OPCODE_LOGDATAENABLE:
+		rval = mpi3mr_enable_logdata(mrioc, job);
+		break;
+	case MPI3MR_DRVBSG_OPCODE_GETLOGDATA:
+		rval = mpi3mr_get_logdata(mrioc, job);
+		break;
+	case MPI3MR_DRVBSG_OPCODE_UNKNOWN:
+	default:
+		pr_err("%s: unsupported driver command opcode %d\n",
+		    MPI3MR_DRIVER_NAME, drvrcmd->opcode);
+		break;
+	}
+	mutex_unlock(&mrioc->bsg_cmds.mutex);
+	return rval;
+}
 
 /**
  * mpi3mr_bsg_request - bsg request entry point
@@ -20,6 +393,23 @@
  */
 int mpi3mr_bsg_request(struct bsg_job *job)
 {
+	long rval = -EINVAL;
+	unsigned int reply_payload_rcv_len = 0;
+
+	struct mpi3mr_bsg_packet *bsg_req = job->request;
+
+	switch (bsg_req->cmd_type) {
+	case MPI3MR_DRV_CMD:
+		rval = mpi3mr_bsg_process_drv_cmds(job);
+		break;
+	default:
+		pr_err("%s: unsupported BSG command(0x%08x)\n",
+		    MPI3MR_DRIVER_NAME, bsg_req->cmd_type);
+		break;
+	}
+
+	bsg_job_done(job, rval, reply_payload_rcv_len);
+
 	return 0;
 }
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr_debug.h b/drivers/scsi/mpi3mr/mpi3mr_debug.h
index c7982443f45a..65bfac72948c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_debug.h
+++ b/drivers/scsi/mpi3mr/mpi3mr_debug.h
@@ -23,8 +23,8 @@
 #define MPI3_DEBUG_RESET		0x00000020
 #define MPI3_DEBUG_SCSI_ERROR		0x00000040
 #define MPI3_DEBUG_REPLY		0x00000080
-#define MPI3_DEBUG_IOCTL_ERROR		0x00008000
-#define MPI3_DEBUG_IOCTL_INFO		0x00010000
+#define MPI3_DEBUG_BSG_ERROR		0x00008000
+#define MPI3_DEBUG_BSG_INFO		0x00010000
 #define MPI3_DEBUG_SCSI_INFO		0x00020000
 #define MPI3_DEBUG			0x01000000
 #define MPI3_DEBUG_SG			0x02000000
@@ -110,15 +110,15 @@
 	} while (0)
 
 
-#define dprint_ioctl_info(ioc, fmt, ...) \
+#define dprint_bsg_info(ioc, fmt, ...) \
 	do { \
-		if (ioc->logging_level & MPI3_DEBUG_IOCTL_INFO) \
+		if (ioc->logging_level & MPI3_DEBUG_BSG_INFO) \
 			pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__); \
 	} while (0)
 
-#define dprint_ioctl_err(ioc, fmt, ...) \
+#define dprint_bsg_err(ioc, fmt, ...) \
 	do { \
-		if (ioc->logging_level & MPI3_DEBUG_IOCTL_ERROR) \
+		if (ioc->logging_level & MPI3_DEBUG_BSG_ERROR) \
 			pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__); \
 	} while (0)
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index e25c02466043..480730721f50 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -297,6 +297,8 @@ mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 host_tag,
 	switch (host_tag) {
 	case MPI3MR_HOSTTAG_INITCMDS:
 		return &mrioc->init_cmds;
+	case MPI3MR_HOSTTAG_BSG_CMDS:
+		return &mrioc->bsg_cmds;
 	case MPI3MR_HOSTTAG_BLK_TMS:
 		return &mrioc->host_tm_cmds;
 	case MPI3MR_HOSTTAG_INVALID:
@@ -865,10 +867,10 @@ static const struct {
 } mpi3mr_reset_reason_codes[] = {
 	{ MPI3MR_RESET_FROM_BRINGUP, "timeout in bringup" },
 	{ MPI3MR_RESET_FROM_FAULT_WATCH, "fault" },
-	{ MPI3MR_RESET_FROM_IOCTL, "application invocation" },
+	{ MPI3MR_RESET_FROM_APP, "application invocation" },
 	{ MPI3MR_RESET_FROM_EH_HOS, "error handling" },
 	{ MPI3MR_RESET_FROM_TM_TIMEOUT, "TM timeout" },
-	{ MPI3MR_RESET_FROM_IOCTL_TIMEOUT, "IOCTL timeout" },
+	{ MPI3MR_RESET_FROM_APP_TIMEOUT, "application command timeout" },
 	{ MPI3MR_RESET_FROM_MUR_FAILURE, "MUR failure" },
 	{ MPI3MR_RESET_FROM_CTLR_CLEANUP, "timeout in controller cleanup" },
 	{ MPI3MR_RESET_FROM_CIACTIV_FAULT, "component image activation fault" },
@@ -2813,6 +2815,10 @@ static int mpi3mr_alloc_reply_sense_bufs(struct mpi3mr_ioc *mrioc)
 	if (!mrioc->init_cmds.reply)
 		goto out_failed;
 
+	mrioc->bsg_cmds.reply = kzalloc(mrioc->reply_sz, GFP_KERNEL);
+	if (!mrioc->bsg_cmds.reply)
+		goto out_failed;
+
 	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++) {
 		mrioc->dev_rmhs_cmds[i].reply = kzalloc(mrioc->reply_sz,
 		    GFP_KERNEL);
@@ -3948,6 +3954,8 @@ void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
 
 	if (mrioc->init_cmds.reply) {
 		memset(mrioc->init_cmds.reply, 0, sizeof(*mrioc->init_cmds.reply));
+		memset(mrioc->bsg_cmds.reply, 0,
+		    sizeof(*mrioc->bsg_cmds.reply));
 		memset(mrioc->host_tm_cmds.reply, 0,
 		    sizeof(*mrioc->host_tm_cmds.reply));
 		for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
@@ -4050,6 +4058,9 @@ void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 	kfree(mrioc->init_cmds.reply);
 	mrioc->init_cmds.reply = NULL;
 
+	kfree(mrioc->bsg_cmds.reply);
+	mrioc->bsg_cmds.reply = NULL;
+
 	kfree(mrioc->host_tm_cmds.reply);
 	mrioc->host_tm_cmds.reply = NULL;
 
@@ -4235,6 +4246,8 @@ static void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc)
 
 	cmdptr = &mrioc->init_cmds;
 	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
+	cmdptr = &mrioc->bsg_cmds;
+	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
 	cmdptr = &mrioc->host_tm_cmds;
 	mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
 
@@ -4258,7 +4271,7 @@ static void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc)
  * This is an handler for recovering controller by issuing soft
  * reset are diag fault reset.  This is a blocking function and
  * when one reset is executed if any other resets they will be
- * blocked. All IOCTLs/IO will be blocked during the reset. If
+ * blocked. All BSG requests will be blocked during the reset. If
  * controller reset is successful then the controller will be
  * reinitalized, otherwise the controller will be marked as not
  * recoverable
@@ -4305,6 +4318,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	    mpi3mr_reset_rc_name(reset_reason));
 
 	mrioc->reset_in_progress = 1;
+	mrioc->stop_bsgs = 1;
 	mrioc->prev_reset_result = -1;
 
 	if ((!snapdump) && (reset_reason != MPI3MR_RESET_FROM_FAULT_WATCH) &&
@@ -4377,6 +4391,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 			    &mrioc->watchdog_work,
 			    msecs_to_jiffies(MPI3MR_WATCHDOG_INTERVAL));
 		spin_unlock_irqrestore(&mrioc->watchdog_lock, flags);
+		mrioc->stop_bsgs = 0;
 	} else {
 		mpi3mr_issue_reset(mrioc,
 		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT, reset_reason);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index faf14a5f9123..a03e39083a42 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3589,6 +3589,7 @@ static int mpi3mr_scan_finished(struct Scsi_Host *shost,
 
 	mpi3mr_start_watchdog(mrioc);
 	mrioc->is_driver_loading = 0;
+	mrioc->stop_bsgs = 0;
 	return 1;
 }
 
@@ -4259,6 +4260,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&mrioc->reset_mutex);
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
 	mpi3mr_init_drv_cmd(&mrioc->host_tm_cmds, MPI3MR_HOSTTAG_BLK_TMS);
+	mpi3mr_init_drv_cmd(&mrioc->bsg_cmds, MPI3MR_HOSTTAG_BSG_CMDS);
 
 	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
 		mpi3mr_init_drv_cmd(&mrioc->dev_rmhs_cmds[i],
@@ -4271,6 +4273,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mrioc->logging_level = logging_level;
 	mrioc->shost = shost;
 	mrioc->pdev = pdev;
+	mrioc->stop_bsgs = 1;
 
 	/* init shost parameters */
 	shost->max_cmd_len = MPI3MR_MAX_CDB_LENGTH;
diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
new file mode 100644
index 000000000000..2319fc48ed78
--- /dev/null
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -0,0 +1,433 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Broadcom MPI3 Storage Controllers
+ *
+ * Copyright (C) 2017-2022 Broadcom Inc.
+ *  (mailto: mpi3mr-linuxdrv.pdl@broadcom.com)
+ *
+ */
+
+#ifndef SCSI_BSG_MPI3MR_H_INCLUDED
+#define SCSI_BSG_MPI3MR_H_INCLUDED
+
+/* Definitions for BSG commands */
+#define MPI3MR_IOCTL_VERSION			0x06
+
+#define MPI3MR_APP_DEFAULT_TIMEOUT		(60) /*seconds*/
+
+#define MPI3MR_BSG_ADPTYPE_UNKNOWN		0
+#define MPI3MR_BSG_ADPTYPE_AVGFAMILY		1
+
+#define MPI3MR_BSG_ADPSTATE_UNKNOWN		0
+#define MPI3MR_BSG_ADPSTATE_OPERATIONAL		1
+#define MPI3MR_BSG_ADPSTATE_FAULT		2
+#define MPI3MR_BSG_ADPSTATE_IN_RESET		3
+#define MPI3MR_BSG_ADPSTATE_UNRECOVERABLE	4
+
+#define MPI3MR_BSG_ADPRESET_UNKNOWN		0
+#define MPI3MR_BSG_ADPRESET_SOFT		1
+#define MPI3MR_BSG_ADPRESET_DIAG_FAULT		2
+
+#define MPI3MR_BSG_LOGDATA_MAX_ENTRIES		400
+#define MPI3MR_BSG_LOGDATA_ENTRY_HEADER_SZ	4
+
+#define MPI3MR_DRVBSG_OPCODE_UNKNOWN		0
+#define MPI3MR_DRVBSG_OPCODE_ADPINFO		1
+#define MPI3MR_DRVBSG_OPCODE_ADPRESET		2
+#define MPI3MR_DRVBSG_OPCODE_ALLTGTDEVINFO	4
+#define MPI3MR_DRVBSG_OPCODE_GETCHGCNT		5
+#define MPI3MR_DRVBSG_OPCODE_LOGDATAENABLE	6
+#define MPI3MR_DRVBSG_OPCODE_PELENABLE		7
+#define MPI3MR_DRVBSG_OPCODE_GETLOGDATA		8
+#define MPI3MR_DRVBSG_OPCODE_QUERY_HDB		9
+#define MPI3MR_DRVBSG_OPCODE_REPOST_HDB		10
+#define MPI3MR_DRVBSG_OPCODE_UPLOAD_HDB		11
+#define MPI3MR_DRVBSG_OPCODE_REFRESH_HDB_TRIGGERS	12
+
+
+#define MPI3MR_BSG_BUFTYPE_UNKNOWN		0
+#define MPI3MR_BSG_BUFTYPE_RAIDMGMT_CMD		1
+#define MPI3MR_BSG_BUFTYPE_RAIDMGMT_RESP	2
+#define MPI3MR_BSG_BUFTYPE_DATA_IN		3
+#define MPI3MR_BSG_BUFTYPE_DATA_OUT		4
+#define MPI3MR_BSG_BUFTYPE_MPI_REPLY		5
+#define MPI3MR_BSG_BUFTYPE_ERR_RESPONSE		6
+#define MPI3MR_BSG_BUFTYPE_MPI_REQUEST		0xFE
+
+#define MPI3MR_BSG_MPI_REPLY_BUFTYPE_UNKNOWN	0
+#define MPI3MR_BSG_MPI_REPLY_BUFTYPE_STATUS	1
+#define MPI3MR_BSG_MPI_REPLY_BUFTYPE_ADDRESS	2
+
+#define MPI3MR_HDB_BUFTYPE_UNKNOWN		0
+#define MPI3MR_HDB_BUFTYPE_TRACE		1
+#define MPI3MR_HDB_BUFTYPE_FIRMWARE		2
+#define MPI3MR_HDB_BUFTYPE_RESERVED		3
+
+#define MPI3MR_HDB_BUFSTATUS_UNKNOWN		0
+#define MPI3MR_HDB_BUFSTATUS_NOT_ALLOCATED	1
+#define MPI3MR_HDB_BUFSTATUS_POSTED_UNPAUSED	2
+#define MPI3MR_HDB_BUFSTATUS_POSTED_PAUSED	3
+#define MPI3MR_HDB_BUFSTATUS_RELEASED		4
+
+#define MPI3MR_HDB_TRIGGER_TYPE_UNKNOWN		0
+#define MPI3MR_HDB_TRIGGER_TYPE_DIAGFAULT	1
+#define MPI3MR_HDB_TRIGGER_TYPE_ELEMENT		2
+#define MPI3MR_HDB_TRIGGER_TYPE_MASTER		3
+
+
+/* Supported BSG commands */
+enum command {
+	MPI3MR_DRV_CMD = 1,
+	MPI3MR_MPT_CMD = 2,
+};
+
+/**
+ * struct mpi3mr_bsg_in_adpinfo - Adapter information request
+ * data returned by the driver.
+ *
+ * @adp_type: Adapter type
+ * @rsvd1: Reserved
+ * @pci_dev_id: PCI device ID of the adapter
+ * @pci_dev_hw_rev: PCI revision of the adapter
+ * @pci_subsys_dev_id: PCI subsystem device ID of the adapter
+ * @pci_subsys_ven_id: PCI subsystem vendor ID of the adapter
+ * @pci_dev: PCI device
+ * @pci_func: PCI function
+ * @pci_bus: PCI bus
+ * @rsvd2: Reserved
+ * @pci_seg_id: PCI segment ID
+ * @app_intfc_ver: version of the application interface definition
+ * @rsvd3: Reserved
+ * @rsvd4: Reserved
+ * @rsvd5: Reserved
+ * @driver_info: Driver Information (Version/Name)
+ */
+struct mpi3mr_bsg_in_adpinfo {
+	uint32_t adp_type;
+	uint32_t rsvd1;
+	uint32_t pci_dev_id;
+	uint32_t pci_dev_hw_rev;
+	uint32_t pci_subsys_dev_id;
+	uint32_t pci_subsys_ven_id;
+	uint32_t pci_dev:5;
+	uint32_t pci_func:3;
+	uint32_t pci_bus:8;
+	uint16_t rsvd2;
+	uint32_t pci_seg_id;
+	uint32_t app_intfc_ver;
+	uint8_t adp_state;
+	uint8_t rsvd3;
+	uint16_t rsvd4;
+	uint32_t rsvd5[2];
+	struct mpi3_driver_info_layout driver_info;
+};
+
+/**
+ * struct mpi3mr_bsg_adp_reset - Adapter reset request
+ * payload data to the driver.
+ *
+ * @reset_type: Reset type
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ */
+struct mpi3mr_bsg_adp_reset {
+	uint8_t reset_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+};
+
+/**
+ * struct mpi3mr_change_count - Topology change count
+ * returned by the driver.
+ *
+ * @change_count: Topology change count
+ * @rsvd: Reserved
+ */
+struct mpi3mr_change_count {
+	uint16_t change_count;
+	uint16_t rsvd;
+};
+
+/**
+ * struct mpi3mr_device_map_info - Target device mapping
+ * information
+ *
+ * @handle: Firmware device handle
+ * @perst_id: Persistent ID assigned by the firmware
+ * @target_id: Target ID assigned by the driver
+ * @bus_id: Bus ID assigned by the driver
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ */
+struct mpi3mr_device_map_info {
+	uint16_t handle;
+	uint16_t perst_id;
+	uint32_t target_id;
+	uint8_t bus_id;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+};
+
+/**
+ * struct mpi3mr_all_tgt_info - Target device mapping
+ * information returned by the driver
+ *
+ * @num_devices: The number of devices in driver's inventory
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @dmi: Variable length array of mapping information of targets
+ */
+struct mpi3mr_all_tgt_info {
+	uint16_t num_devices;
+	uint16_t rsvd1;
+	uint32_t rsvd2;
+	struct mpi3mr_device_map_info dmi[1];
+};
+
+/**
+ * struct mpi3mr_logdata_enable - Number of log data
+ * entries saved by the driver returned as payload data for
+ * enable logdata BSG request by the driver.
+ *
+ * @max_entries: Number of log data entries cached by the driver
+ * @rsvd: Reserved
+ */
+struct mpi3mr_logdata_enable {
+	uint16_t max_entries;
+	uint16_t rsvd;
+};
+
+/**
+ * struct mpi3mr_bsg_out_pel_enable - PEL enable request payload
+ * data to the driver.
+ *
+ * @pel_locale: PEL locale to the firmware
+ * @pel_class: PEL class to the firmware
+ * @rsvd: Reserved
+ */
+struct mpi3mr_bsg_out_pel_enable {
+	uint16_t pel_locale;
+	uint8_t pel_class;
+	uint8_t rsvd;
+};
+
+/**
+ * struct mpi3mr_logdata_entry - Log data entry cached by the
+ * driver.
+ *
+ * @valid_entry: Is the entry valid
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @data: Variable length Log entry data
+ */
+struct mpi3mr_logdata_entry {
+	uint8_t valid_entry;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint8_t data[1]; /* Variable length Array */
+};
+
+/**
+ * struct mpi3mr_bsg_in_log_data - Log data entries saved by
+ * the driver returned as payload data for Get logdata request
+ * by the driver.
+ *
+ * @entry: Variable length Log data entry array
+ */
+struct mpi3mr_bsg_in_log_data {
+	struct mpi3mr_logdata_entry entry[1];
+};
+
+/**
+ * struct mpi3mr_hdb_entry - host diag buffer entry.
+ *
+ * @buf_type: Buffer type
+ * @status: Buffer status
+ * @trigger_type: Trigger type
+ * @rsvd1: Reserved
+ * @size: Buffer size
+ * @rsvd2: Reserved
+ * @trigger_data: Trigger specific data
+ * @rsvd3: Reserved
+ * @rsvd4: Reserved
+ */
+struct mpi3mr_hdb_entry {
+	uint8_t buf_type;
+	uint8_t status;
+	uint8_t trigger_type;
+	uint8_t rsvd1;
+	uint16_t size;
+	uint16_t rsvd2;
+	uint64_t trigger_data;
+	uint32_t rsvd3;
+	uint32_t rsvd4;
+};
+
+
+/**
+ * struct mpi3mr_bsg_in_hdb_status - This structure contains
+ * return data for the BSG request to retrieve the number of host
+ * diagnostic buffers supported by the driver and their current
+ * status and additional status specific data if any in forms of
+ * multiple hdb entries.
+ *
+ * @num_hdb_types: Number of host diag buffer types supported
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @rsvd3: Reserved
+ * @entry: Variable length Diag buffer status entry array
+ */
+struct mpi3mr_bsg_in_hdb_status {
+	uint8_t num_hdb_types;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t rsvd3;
+	struct mpi3mr_hdb_entry entry[1];
+};
+
+/**
+ * struct mpi3mr_bsg_out_repost_hdb - Repost host diagnostic
+ * buffer request payload data to the driver.
+ *
+ * @buf_type: Buffer type
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ */
+struct mpi3mr_bsg_out_repost_hdb {
+	uint8_t buf_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+};
+
+/**
+ * struct mpi3mr_bsg_out_upload_hdb - Upload host diagnostic
+ * buffer request payload data to the driver.
+ *
+ * @buf_type: Buffer type
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @start_offset: Start offset of the buffer from where to copy
+ * @length: Length of the buffer to copy
+ */
+struct mpi3mr_bsg_out_upload_hdb {
+	uint8_t buf_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t start_offset;
+	uint32_t length;
+};
+
+/**
+ * struct mpi3mr_bsg_out_refresh_hdb_triggers - Refresh host
+ * diagnostic buffer triggers request payload data to the driver.
+ *
+ * @page_type: Page type
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ */
+struct mpi3mr_bsg_out_refresh_hdb_triggers {
+	uint8_t page_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+};
+/**
+ * struct mpi3mr_bsg_drv_cmd -  Generic bsg data
+ * structure for all driver specific requests.
+ *
+ * @mrioc_id: Controller ID
+ * @opcode: Driver specific opcode
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ */
+struct mpi3mr_bsg_drv_cmd {
+	uint8_t mrioc_id;
+	uint8_t opcode;
+	uint16_t rsvd1;
+	uint32_t rsvd2[4];
+};
+/**
+ * struct mpi3mr_bsg_in_reply_buf - MPI reply buffer returned
+ * for MPI Passthrough request .
+ *
+ * @mpi_reply_type: Type of MPI reply
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @reply_buf: Variable Length buffer based on mpirep type
+ */
+struct mpi3mr_bsg_in_reply_buf {
+	uint8_t mpi_reply_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint8_t reply_buf[1];
+};
+
+/**
+ * struct mpi3mr_buf_entry - User buffer descriptor for MPI
+ * Passthrough requests.
+ *
+ * @buf_type: Buffer type
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @buf_len: Buffer length
+ */
+struct mpi3mr_buf_entry {
+	uint8_t buf_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t buf_len;
+};
+/**
+ * struct mpi3mr_bsg_buf_entry_list - list of user buffer
+ * descriptor for MPI Passthrough requests.
+ *
+ * @num_of_entries: Number of buffer descriptors
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @rsvd3: Reserved
+ * @buf_entry: Variable length array of buffer descriptors
+ */
+struct mpi3mr_buf_entry_list {
+	uint8_t num_of_entries;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t rsvd3;
+	struct mpi3mr_buf_entry buf_entry[1];
+};
+/**
+ * struct mpi3mr_bsg_mptcmd -  Generic bsg data
+ * structure for all MPI Passthrough requests .
+ *
+ * @mrioc_id: Controller ID
+ * @rsvd1: Reserved
+ * @timeout: MPI request timeout
+ * @buf_entry_list: Buffer descriptor list
+ */
+struct mpi3mr_bsg_mptcmd {
+	uint8_t mrioc_id;
+	uint8_t rsvd1;
+	uint16_t timeout;
+	uint32_t rsvd2;
+	struct mpi3mr_buf_entry_list buf_entry_list;
+};
+
+/**
+ * struct mpi3mr_bsg_packet -  Generic bsg data
+ * structure for all supported requests .
+ *
+ * @cmd_type: represents drvrcmd or mptcmd
+ * @rsvd1: Reserved
+ * @rsvd2: Reserved
+ * @drvrcmd: driver request structure
+ * @mptcmd: mpt request structure
+ */
+struct mpi3mr_bsg_packet {
+	uint8_t cmd_type;
+	uint8_t rsvd1;
+	uint16_t rsvd2;
+	uint32_t rsvd3;
+	union {
+		struct mpi3mr_bsg_drv_cmd drvrcmd;
+		struct mpi3mr_bsg_mptcmd mptcmd;
+	} cmd;
+};
+#endif
-- 
2.27.0


--000000000000a1816505dd3ce5fd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GmgWG68YahkDuVSTTt2beZdyMeDwq/KifJFo18EkhcL3e7rmDAh8SniUI/0o3HX6hrgdmUI1wSdz
uIVL/m6Ok9mIl2U5kvguitOSC0bVaQPfNzlj+7PCKBECAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUNz+JSIXEXl2uQ4Utcnx7FnFi
hhowDQYJKoZIhvcNAQELBQADggEBAL0HLbxgPSW4BFbbIMN3A/ifBg4Lzaph8ARJOnZpGQivo9jG
kQOd95knQi9Lm95JlBAJZCqXXj7QS+dnE71tsFeHWcHNNxHrTSwn4Xi5EqaRjLC6g4IEPyZHWDrD
zzJidgfwQvfZONkf4IXnnrIEFle+26/gPs2kOjCeLMo6XGkNC4HNla1ol1htToQaNN8974pCqwIC
rTXcWqD03VkqSOo+oPP/NAgFAZVfpeuBoK2Xv8zYlrF49Q4hxgFpWhaiDsZUSdWIS7vg1ak1n+6L
3aHRY/lheSkOn/uJWXsqsTDp613hVtOTEDsHSQK32yTGr8jN/oRQgJASuUqQFdD4VzAxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwoQTpBmhDxj9JoN1ow
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPHQwPtCL5TAyjaxuZPF1reZXLtWiY80
dT2k3WaA2Ax7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDQy
MjExNTUwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBTnXMyjx+gbxujqrRjWcdoAiv+6db8z9F4EJveBLhifHxDiLqY
cmLLR7B0qWsnVLgwKszTrc0zls3W9wjRSAjqkT7KIcypZl4fVCOU/MWY6v1L3+ktoH5Io0ndfi81
rz40DicEftv7Qk4xLhgoINfhOUM1GBvLSEQmJJwPzSykW+zGEUnLSiTQtzYNuxjjEqxUvePQZLcE
9abNORjIZI7xlceT7MehBtJ5Rw8eGVxdFGB/G7j4EcveYhxJFZ6QQly6mmtxDcnDkjzVZ5xngrYE
eN8rb4mIX5B/CI/VBe1l8jxnkEEdNhXKrmGnwFBwtZ+fwzgLpP3Wwis3ClpKKenQ
--000000000000a1816505dd3ce5fd--
