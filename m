Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80D5156A8
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Apr 2022 23:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiD2VUt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Apr 2022 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiD2VUs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 Apr 2022 17:20:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D15522F
        for <linux-scsi@vger.kernel.org>; Fri, 29 Apr 2022 14:17:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so9640545pjb.3
        for <linux-scsi@vger.kernel.org>; Fri, 29 Apr 2022 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=7iBIGSylyih6z2q5p/ylYO+D7S3tpqz1qCJfscWnh7Q=;
        b=bsl53wLn9Lc1f0X/1b5udRDaL2oRCBXYhaYEh2SUN/CzUeYyM/fb4wOUA1bK4WvT3X
         4pmuaRoj5IIxOMn7xJA0BXhYXxZ/L6BUYSglPbL3q5dnPcl8xcwueNG8FXlDHWfYe0aF
         YTGlTaYlkW11uTSozur6J/IVMA2V+YVdhZDNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=7iBIGSylyih6z2q5p/ylYO+D7S3tpqz1qCJfscWnh7Q=;
        b=O9g0FpfWljQWqQlMNnYzd9KdLDMqoNuaqzE+8RGbyLF1kCtvml7dnCQnATxuIvAzKB
         NZreSF5kOfOks7Ctewb8y5fTrTllg597axDT2DTtQ01F9+9FtR3C/1uyP+R5XjxkarhR
         4aFNojwVQ5NNaFvICMX7IcJ/dEJbuLhME4G6/4Sa85Qk94l8u0vB/yfrv6ek0m0atAmE
         Y45aBDrCi/3HbocI2ZScOn+xT+3jZQjSgXyaHvDNNkgzWDtfALXZ/4hH6D+pj0qOF5fC
         8+uqAV/6+7/Zo6xWnz7OJZ4POEAjbhpVD9mGldHI7GtCezDXPwlPCeVU7qVLE7DUJx+v
         3LQQ==
X-Gm-Message-State: AOAM532XBqb9416Hn2ut3nds7duuSBNqhWaYvsFfJ2Z90YO6bWKKG22u
        pkXWS/UO90awg1PITL/qpx9rvKXLt3ODoB357EbaULwDLDwW1coA1i7b1Ajr4/wIOjxJcIYJodn
        ECSbLtZyWxrL7PH0nGVe8qJo6sSVxqhdtZxZWQTBSYoGx+fQQ6A69TqXW7sGOiBajIxBzd1/h/C
        cQ8fcrhfE=
X-Google-Smtp-Source: ABdhPJzXBD72kCcFH7WwiNAsxZMTihrpy8JdTX2l53fgQ9iDQ10GoF5mwDsFre64mCTfP3sF1D6L/Q==
X-Received: by 2002:a17:902:ce11:b0:15b:4232:e5e7 with SMTP id k17-20020a170902ce1100b0015b4232e5e7mr937791plg.39.1651267046206;
        Fri, 29 Apr 2022 14:17:26 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a1f4900b001cd498dc153sm14494849pjy.3.2022.04.29.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:17:25 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, bvanassche@acm.org, hch@lst.de,
        hare@suse.de, himanshu.madhani@oracle.com,
        sathya.prakash@broadcom.com, kashyap.desai@broadcom.com,
        chandrakanth.patil@broadcom.com, sreekanth.reddy@broadcom.com,
        prayas.patel@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 2/8] mpi3mr: Add support for driver commands
Date:   Fri, 29 Apr 2022 17:16:35 -0400
Message-Id: <20220429211641.642010-3-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220429211641.642010-1-sumit.saxena@broadcom.com>
References: <20220429211641.642010-1-sumit.saxena@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c4c0fc05ddd1919a"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000c4c0fc05ddd1919a
Content-Transfer-Encoding: 8bit

There are certain bsg commands which need to be completed by the driver
without involving firmware. These requests are termed driver commands. Add
support for these.

Reported-by: kernel test robot <lkp@intel.com>
Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h |  10 -
 drivers/scsi/mpi3mr/mpi3mr.h        |  16 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c    | 390 ++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_debug.h  |  12 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c     |  21 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c     |   3 +
 include/uapi/scsi/scsi_bsg_mpi3mr.h | 457 ++++++++++++++++++++++++++++
 7 files changed, 887 insertions(+), 22 deletions(-)
 create mode 100644 include/uapi/scsi/scsi_bsg_mpi3mr.h

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index 633037dc7012..33fc05f218d6 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -38,16 +38,6 @@ struct mpi3_ioc_init_request {
 #define MPI3_WHOINIT_ROM_BIOS                            (0x02)
 #define MPI3_WHOINIT_HOST_DRIVER                         (0x03)
 #define MPI3_WHOINIT_MANUFACTURER                        (0x04)
-struct mpi3_driver_info_layout {
-	__le32             information_length;
-	u8                 driver_signature[12];
-	u8                 os_name[16];
-	u8                 os_version[12];
-	u8                 driver_name[20];
-	u8                 driver_version[32];
-	u8                 driver_release_date[20];
-	__le32             driver_capabilities;
-};
 
 struct mpi3_ioc_facts_request {
 	__le16                 host_tag;
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
index 948d4ff2ea06..0dcd64c8afea 100644
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
 static int mpi3mr_bsg_request(struct bsg_job *job)
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
index 000000000000..66697d963f64
--- /dev/null
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -0,0 +1,457 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
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
+#include <linux/types.h>
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
+ * struct mpi3_driver_info_layout - Information about driver
+ *
+ * @information_length: Length of this structure in bytes
+ * @driver_signature: Driver Vendor name
+ * @os_name: Operating System Name
+ * @driver_name: Driver name
+ * @driver_version: Driver version
+ * @driver_release_date: Driver release date
+ * @driver_capabilities: Driver capabilities
+ */
+struct mpi3_driver_info_layout {
+	__le32	information_length;
+	__u8	driver_signature[12];
+	__u8	os_name[16];
+	__u8	os_version[12];
+	__u8	driver_name[20];
+	__u8	driver_version[32];
+	__u8	driver_release_date[20];
+	__le32	driver_capabilities;
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
+	__u32	adp_type;
+	__u32	rsvd1;
+	__u32	pci_dev_id;
+	__u32	pci_dev_hw_rev;
+	__u32	pci_subsys_dev_id;
+	__u32	pci_subsys_ven_id;
+	__u32	pci_dev:5;
+	__u32	pci_func:3;
+	__u32	pci_bus:8;
+	__u16	rsvd2;
+	__u32	pci_seg_id;
+	__u32	app_intfc_ver;
+	__u8	adp_state;
+	__u8	rsvd3;
+	__u16	rsvd4;
+	__u32	rsvd5[2];
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
+	__u8	reset_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
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
+	__u16	change_count;
+	__u16	rsvd;
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
+	__u16	handle;
+	__u16	perst_id;
+	__u32	target_id;
+	__u8	bus_id;
+	__u8	rsvd1;
+	__u16	rsvd2;
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
+	__u16	num_devices;
+	__u16	rsvd1;
+	__u32	rsvd2;
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
+	__u16	max_entries;
+	__u16	rsvd;
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
+	__u16	pel_locale;
+	__u8	pel_class;
+	__u8	rsvd;
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
+	__u8	valid_entry;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u8	data[1]; /* Variable length Array */
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
+	__u8	buf_type;
+	__u8	status;
+	__u8	trigger_type;
+	__u8	rsvd1;
+	__u16	size;
+	__u16	rsvd2;
+	__u64	trigger_data;
+	__u32	rsvd3;
+	__u32	rsvd4;
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
+	__u8	num_hdb_types;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u32	rsvd3;
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
+	__u8	buf_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
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
+	__u8	buf_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u32	start_offset;
+	__u32	length;
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
+	__u8	page_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
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
+	__u8	mrioc_id;
+	__u8	opcode;
+	__u16	rsvd1;
+	__u32	rsvd2[4];
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
+	__u8	mpi_reply_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u8	reply_buf[1];
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
+	__u8	buf_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u32	buf_len;
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
+	__u8	num_of_entries;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u32	rsvd3;
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
+	__u8	mrioc_id;
+	__u8	rsvd1;
+	__u16	timeout;
+	__u32	rsvd2;
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
+	__u8	cmd_type;
+	__u8	rsvd1;
+	__u16	rsvd2;
+	__u32	rsvd3;
+	union {
+		struct mpi3mr_bsg_drv_cmd drvrcmd;
+		struct mpi3mr_bsg_mptcmd mptcmd;
+	} cmd;
+};
+#endif
-- 
2.27.0


--000000000000c4c0fc05ddd1919a
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHqorBFwip5dyc7FObc3z7YwOJ35tAPc
n67oiuf8r/mMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDQy
OTIxMTcyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQACVr/YqxgysGB6vPRPyESZxvUvhvJ76XgEHD/zS9C/DQZdnG9U
+xgYStVGGiIK3XNMRGcPSVG/3/EySrPUuF88oAdA7OfbkRazV6h7s3VvWlh0m/C5BkdAOHsG9Ea1
l27KJGMRb3GP2UPfCfZeLzjDyLd9JS/CXk/rK7RCL+vIZLs5NYQniPkX82W0Zd3opZGDUwh0Dr9n
30Z7SRd4I3xzQcTi49hMTdNQD+R3ZnJA0FMfsmHlUd6KAC5WjNhRgzKwAsTiUNU+v8z31CxKeCgW
/bng80Qk4NX+BBGoT2PnwOLWfCmMmnqge6tt5M5HRxCrhirEeg5jK8eKf08ukbg1
--000000000000c4c0fc05ddd1919a--
