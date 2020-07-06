Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E53215750
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2020 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGFMds (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Jul 2020 08:33:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37661 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgGFMds (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 Jul 2020 08:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594038827; x=1625574827;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NIQsmB1kblJujQxWmJSldWGOHufZEaU48EJh+lCs+ls=;
  b=kWlP8xsntUS1h3OsXOf7VnAIjJR/wZFftihnjrI1VeOr7WuC0ZW46SPi
   UtpW7OrPVx5mC9I2kZRxhJPiX33lKpTE19+dU72x1JVFSYlV6FgeXQO6D
   SlrKUQaM/4KFJoRya8v4FzR73KfTuzTxNLZM61lZY6EPVDGRaPaq0T4jd
   poKJza2qPC1SN3hb6MxAvuzAUBuDiqBAnKee2ZoBZGjMQyYRh1JUiBHfG
   nsxmoSeANIR6WnpWweMWepxY1B5Eexdm6K9RIZlFbjb6RgHuRsATPwSlB
   ijgF1guX10QO8k4ZwgvTxIiEN9sSu13KOo+BTnzExGO8f+PiJGQcGZjGm
   g==;
IronPort-SDR: 41kYxp/PcqcGnKaBBJX2kxTPgZoM1BbgAjvYIkWhMZfUxbK1Y0+7dErIaLlIRJq09nz2dbWdV1
 VEarThQ5vxILyT4v7BeOzOLekiKVu/KXctGMBLo45EroAdCvh4WoWMITh+VYCwYHJ8tr/YrNGz
 8CXyN1SRIw2bUyduzqxNgPVUzVFlyBn157EmXStSZEXgnhZGHSwkV5wPkL95tnh8CngNLkXyP0
 kfN/GNxiaJ2mXdM+bLrFKML3nyUkwq8vpiRzkCIH1Vbvt9jQugVwW3HAIWaqTtTgP2GMhEoL+g
 uY8=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="146052057"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 20:33:47 +0800
IronPort-SDR: wrnREQa6q8DWYLPs223mCD/TYr7vqsGRu7pWkS8vfeCxpBDIjZTneRrtG9pxrtEfF6pUfvwEXB
 MBpXrYIn7sfAYHn6VY/QmWvZMKxBmhegY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 05:21:55 -0700
IronPort-SDR: jSl5huCefDsYODd4Y37p1edkr53aT49QVNwR//kGnAsj2KMeuc1fQgX1xbMxBjj09nBmdGZCQL
 Ui7E3a0VeNUQ==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 05:33:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 01/10] scsi: megaraid: Fix kdoc comments format
Date:   Mon,  6 Jul 2020 21:33:45 +0900
Message-Id: <20200706123345.451783-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix kernel documentation comments to avoid various warnings when
compiling with W=1.

No functional changes.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/megaraid.c                     | 206 ++++++++++----------
 drivers/scsi/megaraid/megaraid_mbox.c       |   4 +-
 drivers/scsi/megaraid/megaraid_mm.c         |   1 -
 drivers/scsi/megaraid/megaraid_sas_base.c   | 171 +++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  78 +++++---
 5 files changed, 250 insertions(+), 210 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index f27ffd088c8a..07ce31c546ba 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -124,7 +124,7 @@ static int trace_level;
 
 /**
  * mega_setup_mailbox()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Allocates a 8 byte aligned memory for the handshake mailbox.
  */
@@ -347,7 +347,7 @@ mega_query_adapter(adapter_t *adapter)
 
 /**
  * mega_runpendq()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Runs through the list of pending requests.
  */
@@ -413,8 +413,8 @@ static DEF_SCSI_QCMD(megaraid_queue)
 
 /**
  * mega_allocate_scb()
- * @adapter - pointer to our soft state
- * @cmd - scsi command from the mid-layer
+ * @adapter: pointer to our soft state
+ * @cmd: scsi command from the mid-layer
  *
  * Allocate a SCB structure. This is the central structure for controller
  * commands.
@@ -444,9 +444,9 @@ mega_allocate_scb(adapter_t *adapter, struct scsi_cmnd *cmd)
 
 /**
  * mega_get_ldrv_num()
- * @adapter - pointer to our soft state
- * @cmd - scsi mid layer command
- * @channel - channel on the controller
+ * @adapter: pointer to our soft state
+ * @cmd: scsi mid layer command
+ * @channel: channel on the controller
  *
  * Calculate the logical drive number based on the information in scsi command
  * and the channel number.
@@ -503,9 +503,9 @@ mega_get_ldrv_num(adapter_t *adapter, struct scsi_cmnd *cmd, int channel)
 
 /**
  * mega_build_cmd()
- * @adapter - pointer to our soft state
- * @cmd - Prepare using this scsi command
- * @busy - busy flag if no resources
+ * @adapter: pointer to our soft state
+ * @cmd: Prepare using this scsi command
+ * @busy: busy flag if no resources
  *
  * Prepares a command and scatter gather list for the controller. This routine
  * also finds out if the commands is intended for a logical drive or a
@@ -937,11 +937,11 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
 
 /**
  * mega_prepare_passthru()
- * @adapter - pointer to our soft state
- * @scb - our scsi control block
- * @cmd - scsi command from the mid-layer
- * @channel - actual channel on the controller
- * @target - actual id on the controller.
+ * @adapter: pointer to our soft state
+ * @scb: our scsi control block
+ * @cmd: scsi command from the mid-layer
+ * @channel: actual channel on the controller
+ * @target: actual id on the controller.
  *
  * prepare a command for the scsi physical devices.
  */
@@ -1000,11 +1000,11 @@ mega_prepare_passthru(adapter_t *adapter, scb_t *scb, struct scsi_cmnd *cmd,
 
 /**
  * mega_prepare_extpassthru()
- * @adapter - pointer to our soft state
- * @scb - our scsi control block
- * @cmd - scsi command from the mid-layer
- * @channel - actual channel on the controller
- * @target - actual id on the controller.
+ * @adapter: pointer to our soft state
+ * @scb: our scsi control block
+ * @cmd: scsi command from the mid-layer
+ * @channel: actual channel on the controller
+ * @target: actual id on the controller.
  *
  * prepare a command for the scsi physical devices. This rountine prepares
  * commands for devices which can take extended CDBs (>10 bytes)
@@ -1085,8 +1085,8 @@ __mega_runpendq(adapter_t *adapter)
 
 /**
  * issue_scb()
- * @adapter - pointer to our soft state
- * @scb - scsi control block
+ * @adapter: pointer to our soft state
+ * @scb: scsi control block
  *
  * Post a command to the card if the mailbox is available, otherwise return
  * busy. We also take the scb from the pending list if the mailbox is
@@ -1166,8 +1166,8 @@ mega_busywait_mbox (adapter_t *adapter)
 
 /**
  * issue_scb_block()
- * @adapter - pointer to our soft state
- * @raw_mbox - the mailbox
+ * @adapter: pointer to our soft state
+ * @raw_mbox: the mailbox
  *
  * Issue a scb in synchronous and non-interrupt mode
  */
@@ -1247,8 +1247,8 @@ issue_scb_block(adapter_t *adapter, u_char *raw_mbox)
 
 /**
  * megaraid_isr_iomapped()
- * @irq - irq
- * @devp - pointer to our soft state
+ * @irq: irq
+ * @devp: pointer to our soft state
  *
  * Interrupt service routine for io-mapped controllers.
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
@@ -1323,8 +1323,8 @@ megaraid_isr_iomapped(int irq, void *devp)
 
 /**
  * megaraid_isr_memmapped()
- * @irq - irq
- * @devp - pointer to our soft state
+ * @irq: irq
+ * @devp: pointer to our soft state
  *
  * Interrupt service routine for memory-mapped controllers.
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
@@ -1401,10 +1401,10 @@ megaraid_isr_memmapped(int irq, void *devp)
 }
 /**
  * mega_cmd_done()
- * @adapter - pointer to our soft state
- * @completed - array of ids of completed commands
- * @nstatus - number of completed commands
- * @status - status of the last command completed
+ * @adapter: pointer to our soft state
+ * @completed: array of ids of completed commands
+ * @nstatus: number of completed commands
+ * @status: status of the last command completed
  *
  * Complete the commands and call the scsi mid-layer callback hooks.
  */
@@ -1921,9 +1921,9 @@ megaraid_reset(struct scsi_cmnd *cmd)
 
 /**
  * megaraid_abort_and_reset()
- * @adapter - megaraid soft state
- * @cmd - scsi command to be aborted or reset
- * @aor - abort or reset flag
+ * @adapter: megaraid soft state
+ * @cmd: scsi command to be aborted or reset
+ * @aor: abort or reset flag
  *
  * Try to locate the scsi command in the pending queue. If found and is not
  * issued to the controller, abort/reset it. Otherwise return failure
@@ -2021,8 +2021,8 @@ free_local_pdev(struct pci_dev *pdev)
 
 /**
  * mega_allocate_inquiry()
- * @dma_handle - handle returned for dma address
- * @pdev - handle to pci device
+ * @dma_handle: handle returned for dma address
+ * @pdev: handle to pci device
  *
  * allocates memory for inquiry structure
  */
@@ -2045,8 +2045,8 @@ mega_free_inquiry(void *inquiry, dma_addr_t dma_handle, struct pci_dev *pdev)
 
 /**
  * proc_show_config()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display configuration information about the controller.
  */
@@ -2109,8 +2109,8 @@ proc_show_config(struct seq_file *m, void *v)
 
 /**
  * proc_show_stat()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display statistical information about the I/O activity.
  */
@@ -2143,8 +2143,8 @@ proc_show_stat(struct seq_file *m, void *v)
 
 /**
  * proc_show_mbox()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display mailbox information for the last command issued. This information
  * is good for debugging.
@@ -2171,8 +2171,8 @@ proc_show_mbox(struct seq_file *m, void *v)
 
 /**
  * proc_show_rebuild_rate()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display current rebuild rate
  */
@@ -2214,8 +2214,8 @@ proc_show_rebuild_rate(struct seq_file *m, void *v)
 
 /**
  * proc_show_battery()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display information about the battery module on the controller.
  */
@@ -2317,9 +2317,9 @@ mega_print_inquiry(struct seq_file *m, char *scsi_inq)
 
 /**
  * proc_show_pdrv()
- * @m - Synthetic file construction data
- * @page - buffer to write the data in
- * @adapter - pointer to our soft state
+ * @m: Synthetic file construction data
+ * @adapter: pointer to our soft state
+ * @channel: channel
  *
  * Display information about the physical drives.
  */
@@ -2433,8 +2433,8 @@ proc_show_pdrv(struct seq_file *m, adapter_t *adapter, int channel)
 
 /**
  * proc_show_pdrv_ch0()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display information about the physical drives on physical channel 0.
  */
@@ -2447,8 +2447,8 @@ proc_show_pdrv_ch0(struct seq_file *m, void *v)
 
 /**
  * proc_show_pdrv_ch1()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display information about the physical drives on physical channel 1.
  */
@@ -2461,8 +2461,8 @@ proc_show_pdrv_ch1(struct seq_file *m, void *v)
 
 /**
  * proc_show_pdrv_ch2()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display information about the physical drives on physical channel 2.
  */
@@ -2475,8 +2475,8 @@ proc_show_pdrv_ch2(struct seq_file *m, void *v)
 
 /**
  * proc_show_pdrv_ch3()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display information about the physical drives on physical channel 3.
  */
@@ -2489,10 +2489,10 @@ proc_show_pdrv_ch3(struct seq_file *m, void *v)
 
 /**
  * proc_show_rdrv()
- * @m - Synthetic file construction data
- * @adapter - pointer to our soft state
- * @start - starting logical drive to display
- * @end - ending logical drive to display
+ * @m: Synthetic file construction data
+ * @adapter: pointer to our soft state
+ * @start: starting logical drive to display
+ * @end: ending logical drive to display
  *
  * We do not print the inquiry information since its already available through
  * /proc/scsi/scsi interface
@@ -2674,8 +2674,8 @@ proc_show_rdrv(struct seq_file *m, adapter_t *adapter, int start, int end )
 
 /**
  * proc_show_rdrv_10()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display real time information about the logical drives 0 through 9.
  */
@@ -2688,8 +2688,8 @@ proc_show_rdrv_10(struct seq_file *m, void *v)
 
 /**
  * proc_show_rdrv_20()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display real time information about the logical drives 0 through 9.
  */
@@ -2702,8 +2702,8 @@ proc_show_rdrv_20(struct seq_file *m, void *v)
 
 /**
  * proc_show_rdrv_30()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display real time information about the logical drives 0 through 9.
  */
@@ -2716,8 +2716,8 @@ proc_show_rdrv_30(struct seq_file *m, void *v)
 
 /**
  * proc_show_rdrv_40()
- * @m - Synthetic file construction data
- * @v - File iterator
+ * @m: Synthetic file construction data
+ * @v: File iterator
  *
  * Display real time information about the logical drives 0 through 9.
  */
@@ -2729,8 +2729,8 @@ proc_show_rdrv_40(struct seq_file *m, void *v)
 
 /**
  * mega_create_proc_entry()
- * @index - index in soft state array
- * @parent - parent node for this /proc entry
+ * @index: index in soft state array
+ * @parent: parent node for this /proc entry
  *
  * Creates /proc entries for our controllers.
  */
@@ -2785,7 +2785,7 @@ static inline void mega_create_proc_entry(int index, struct proc_dir_entry *pare
 #endif
 
 
-/**
+/*
  * megaraid_biosparam()
  *
  * Return the disk geometry for a particular disk
@@ -2854,7 +2854,7 @@ megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 
 /**
  * mega_init_scb()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Allocate memory for the various pointers in the scb structures:
  * scatter-gather list pointer, passthru and extended passthru structure
@@ -2934,8 +2934,8 @@ mega_init_scb(adapter_t *adapter)
 
 /**
  * megadev_open()
- * @inode - unused
- * @filep - unused
+ * @inode: unused
+ * @filep: unused
  *
  * Routines for the character/ioctl interface to the driver. Find out if this
  * is a valid open. 
@@ -2954,10 +2954,9 @@ megadev_open (struct inode *inode, struct file *filep)
 
 /**
  * megadev_ioctl()
- * @inode - Our device inode
- * @filep - unused
- * @cmd - ioctl command
- * @arg - user buffer
+ * @filep: Our device file
+ * @cmd: ioctl command
+ * @arg: user buffer
  *
  * ioctl entry point for our private ioctl interface. We move the data in from
  * the user space, prepare the command (if necessary, convert the old MIMD
@@ -3370,8 +3369,8 @@ megadev_unlocked_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 /**
  * mega_m_to_n()
- * @arg - user address
- * @uioc - new ioctl structure
+ * @arg: user address
+ * @uioc: new ioctl structure
  *
  * A thin layer to convert older mimd interface ioctl structure to NIT ioctl
  * structure
@@ -3498,8 +3497,8 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 
 /*
  * mega_n_to_m()
- * @arg - user address
- * @mc - mailbox command
+ * @arg: user address
+ * @mc: mailbox command
  *
  * Updates the status information to the application, depending on application
  * conforms to older mimd ioctl interface or newer NIT ioctl interface
@@ -3565,7 +3564,7 @@ mega_n_to_m(void __user *arg, megacmd_t *mc)
 
 /**
  * mega_is_bios_enabled()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * issue command to find out if the BIOS is enabled for this controller
  */
@@ -3596,7 +3595,7 @@ mega_is_bios_enabled(adapter_t *adapter)
 
 /**
  * mega_enum_raid_scsi()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out what channels are RAID/SCSI. This information is used to
  * differentiate the virtual channels and physical channels and to support
@@ -3651,7 +3650,7 @@ mega_enum_raid_scsi(adapter_t *adapter)
 
 /**
  * mega_get_boot_drv()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out which device is the boot device. Note, any logical drive or any
  * phyical device (e.g., a CDROM) can be designated as a boot device.
@@ -3718,7 +3717,7 @@ mega_get_boot_drv(adapter_t *adapter)
 
 /**
  * mega_support_random_del()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out if this controller supports random deletion and addition of
  * logical drives
@@ -3748,7 +3747,7 @@ mega_support_random_del(adapter_t *adapter)
 
 /**
  * mega_support_ext_cdb()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out if this firmware support cdblen > 10
  */
@@ -3776,8 +3775,8 @@ mega_support_ext_cdb(adapter_t *adapter)
 
 /**
  * mega_del_logdrv()
- * @adapter - pointer to our soft state
- * @logdrv - logical drive to be deleted
+ * @adapter: pointer to our soft state
+ * @logdrv: logical drive to be deleted
  *
  * Delete the specified logical drive. It is the responsibility of the user
  * app to let the OS know about this operation.
@@ -3862,7 +3861,7 @@ mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 
 /**
  * mega_get_max_sgl()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out the maximum number of scatter-gather elements supported by this
  * version of the firmware
@@ -3908,7 +3907,7 @@ mega_get_max_sgl(adapter_t *adapter)
 
 /**
  * mega_support_cluster()
- * @adapter - pointer to our soft state
+ * @adapter: pointer to our soft state
  *
  * Find out if this firmware support cluster calls.
  */
@@ -3950,8 +3949,8 @@ mega_support_cluster(adapter_t *adapter)
 #ifdef CONFIG_PROC_FS
 /**
  * mega_adapinq()
- * @adapter - pointer to our soft state
- * @dma_handle - DMA address of the buffer
+ * @adapter: pointer to our soft state
+ * @dma_handle: DMA address of the buffer
  *
  * Issue internal commands while interrupts are available.
  * We only issue direct mailbox commands from within the driver. ioctl()
@@ -3983,11 +3982,12 @@ mega_adapinq(adapter_t *adapter, dma_addr_t dma_handle)
 }
 
 
-/** mega_internal_dev_inquiry()
- * @adapter - pointer to our soft state
- * @ch - channel for this device
- * @tgt - ID of this device
- * @buf_dma_handle - DMA address of the buffer
+/**
+ * mega_internal_dev_inquiry()
+ * @adapter: pointer to our soft state
+ * @ch: channel for this device
+ * @tgt: ID of this device
+ * @buf_dma_handle: DMA address of the buffer
  *
  * Issue the scsi inquiry for the specified device.
  */
@@ -4056,9 +4056,9 @@ mega_internal_dev_inquiry(adapter_t *adapter, u8 ch, u8 tgt,
 
 /**
  * mega_internal_command()
- * @adapter - pointer to our soft state
- * @mc - the mailbox command
- * @pthru - Passthru structure for DCDB commands
+ * @adapter: pointer to our soft state
+ * @mc: the mailbox command
+ * @pthru: Passthru structure for DCDB commands
  *
  * Issue the internal commands in interrupt mode.
  * The last argument is the address of the passthru structure if the command
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 8f918df631bf..19469a2c0ea3 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3304,7 +3304,6 @@ megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
  * megaraid_mbox_display_scb - display SCB information, mostly debug purposes
  * @adapter		: controller's soft state
  * @scb			: SCB to be displayed
- * @level		: debug level for console print
  *
  * Diplay information about the given SCB iff the current debug level is
  * verbose.
@@ -3972,7 +3971,8 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
 
 /**
  * megaraid_sysfs_show_app_hndl - display application handle for this adapter
- * @cdev	: class device object representation for the host
+ * @dev		: class device object representation for the host
+ * @attr	: device attribute (unused)
  * @buf		: buffer to send data to
  *
  * Display the handle used by the applications while executing management
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index e83163c66884..8df53446641a 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -95,7 +95,6 @@ mraid_mm_open(struct inode *inode, struct file *filep)
 
 /**
  * mraid_mm_ioctl - module entry-point for ioctls
- * @inode	: inode (ignored)
  * @filep	: file operations pointer (ignored)
  * @cmd		: ioctl command
  * @arg		: user ioctl packet
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 00668335c2af..2fda0dca122a 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -427,14 +427,14 @@ megasas_decode_evt(struct megasas_instance *instance)
 			evt_detail->description);
 }
 
-/**
-*	The following functions are defined for xscale
-*	(deviceid : 1064R, PERC5) controllers
-*/
+/*
+ * The following functions are defined for xscale
+ * (deviceid : 1064R, PERC5) controllers
+ */
 
 /**
  * megasas_enable_intr_xscale -	Enables interrupts
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_enable_intr_xscale(struct megasas_instance *instance)
@@ -450,7 +450,7 @@ megasas_enable_intr_xscale(struct megasas_instance *instance)
 
 /**
  * megasas_disable_intr_xscale -Disables interrupt
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_disable_intr_xscale(struct megasas_instance *instance)
@@ -466,7 +466,7 @@ megasas_disable_intr_xscale(struct megasas_instance *instance)
 
 /**
  * megasas_read_fw_status_reg_xscale - returns the current FW status value
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static u32
 megasas_read_fw_status_reg_xscale(struct megasas_instance *instance)
@@ -475,7 +475,7 @@ megasas_read_fw_status_reg_xscale(struct megasas_instance *instance)
 }
 /**
  * megasas_clear_interrupt_xscale -	Check & clear interrupt
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
  */
 static int
 megasas_clear_intr_xscale(struct megasas_instance *instance)
@@ -509,9 +509,10 @@ megasas_clear_intr_xscale(struct megasas_instance *instance)
 
 /**
  * megasas_fire_cmd_xscale -	Sends command to the FW
- * @frame_phys_addr :		Physical address of cmd
- * @frame_count :		Number of frames for the command
- * @regs :			MFI register set
+ * @instance:		Adapter soft state
+ * @frame_phys_addr :	Physical address of cmd
+ * @frame_count :	Number of frames for the command
+ * @regs :		MFI register set
  */
 static inline void
 megasas_fire_cmd_xscale(struct megasas_instance *instance,
@@ -529,7 +530,8 @@ megasas_fire_cmd_xscale(struct megasas_instance *instance,
 
 /**
  * megasas_adp_reset_xscale -  For controller reset
- * @regs:                              MFI register set
+ * @instance:	Adapter soft state
+ * @regs:	MFI register set
  */
 static int
 megasas_adp_reset_xscale(struct megasas_instance *instance,
@@ -570,7 +572,8 @@ megasas_adp_reset_xscale(struct megasas_instance *instance,
 
 /**
  * megasas_check_reset_xscale -	For controller reset check
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
+ * @regs:	MFI register set
  */
 static int
 megasas_check_reset_xscale(struct megasas_instance *instance,
@@ -599,19 +602,19 @@ static struct megasas_instance_template megasas_instance_template_xscale = {
 	.issue_dcmd = megasas_issue_dcmd,
 };
 
-/**
-*	This is the end of set of functions & definitions specific
-*	to xscale (deviceid : 1064R, PERC5) controllers
-*/
+/*
+ * This is the end of set of functions & definitions specific
+ * to xscale (deviceid : 1064R, PERC5) controllers
+ */
 
-/**
-*	The following functions are defined for ppc (deviceid : 0x60)
-*	controllers
-*/
+/*
+ * The following functions are defined for ppc (deviceid : 0x60)
+ * controllers
+ */
 
 /**
  * megasas_enable_intr_ppc -	Enables interrupts
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_enable_intr_ppc(struct megasas_instance *instance)
@@ -629,7 +632,7 @@ megasas_enable_intr_ppc(struct megasas_instance *instance)
 
 /**
  * megasas_disable_intr_ppc -	Disable interrupt
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_disable_intr_ppc(struct megasas_instance *instance)
@@ -645,7 +648,7 @@ megasas_disable_intr_ppc(struct megasas_instance *instance)
 
 /**
  * megasas_read_fw_status_reg_ppc - returns the current FW status value
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static u32
 megasas_read_fw_status_reg_ppc(struct megasas_instance *instance)
@@ -655,7 +658,7 @@ megasas_read_fw_status_reg_ppc(struct megasas_instance *instance)
 
 /**
  * megasas_clear_interrupt_ppc -	Check & clear interrupt
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
  */
 static int
 megasas_clear_intr_ppc(struct megasas_instance *instance)
@@ -688,9 +691,10 @@ megasas_clear_intr_ppc(struct megasas_instance *instance)
 
 /**
  * megasas_fire_cmd_ppc -	Sends command to the FW
- * @frame_phys_addr :		Physical address of cmd
- * @frame_count :		Number of frames for the command
- * @regs :			MFI register set
+ * @instance:		Adapter soft state
+ * @frame_phys_addr:	Physical address of cmd
+ * @frame_count:	Number of frames for the command
+ * @regs:		MFI register set
  */
 static inline void
 megasas_fire_cmd_ppc(struct megasas_instance *instance,
@@ -708,7 +712,8 @@ megasas_fire_cmd_ppc(struct megasas_instance *instance,
 
 /**
  * megasas_check_reset_ppc -	For controller reset check
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
+ * @regs:	MFI register set
  */
 static int
 megasas_check_reset_ppc(struct megasas_instance *instance,
@@ -738,7 +743,7 @@ static struct megasas_instance_template megasas_instance_template_ppc = {
 
 /**
  * megasas_enable_intr_skinny -	Enables interrupts
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_enable_intr_skinny(struct megasas_instance *instance)
@@ -756,7 +761,7 @@ megasas_enable_intr_skinny(struct megasas_instance *instance)
 
 /**
  * megasas_disable_intr_skinny -	Disables interrupt
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_disable_intr_skinny(struct megasas_instance *instance)
@@ -772,7 +777,7 @@ megasas_disable_intr_skinny(struct megasas_instance *instance)
 
 /**
  * megasas_read_fw_status_reg_skinny - returns the current FW status value
- * @regs:			MFI register set
+ * @instance:	Adapter soft state
  */
 static u32
 megasas_read_fw_status_reg_skinny(struct megasas_instance *instance)
@@ -782,7 +787,7 @@ megasas_read_fw_status_reg_skinny(struct megasas_instance *instance)
 
 /**
  * megasas_clear_interrupt_skinny -	Check & clear interrupt
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
  */
 static int
 megasas_clear_intr_skinny(struct megasas_instance *instance)
@@ -825,9 +830,10 @@ megasas_clear_intr_skinny(struct megasas_instance *instance)
 
 /**
  * megasas_fire_cmd_skinny -	Sends command to the FW
- * @frame_phys_addr :		Physical address of cmd
- * @frame_count :		Number of frames for the command
- * @regs :			MFI register set
+ * @instance:		Adapter soft state
+ * @frame_phys_addr:	Physical address of cmd
+ * @frame_count:	Number of frames for the command
+ * @regs:		MFI register set
  */
 static inline void
 megasas_fire_cmd_skinny(struct megasas_instance *instance,
@@ -847,7 +853,8 @@ megasas_fire_cmd_skinny(struct megasas_instance *instance,
 
 /**
  * megasas_check_reset_skinny -	For controller reset check
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
+ * @regs:	MFI register set
  */
 static int
 megasas_check_reset_skinny(struct megasas_instance *instance,
@@ -876,14 +883,14 @@ static struct megasas_instance_template megasas_instance_template_skinny = {
 };
 
 
-/**
-*	The following functions are defined for gen2 (deviceid : 0x78 0x79)
-*	controllers
-*/
+/*
+ * The following functions are defined for gen2 (deviceid : 0x78 0x79)
+ * controllers
+ */
 
 /**
  * megasas_enable_intr_gen2 -  Enables interrupts
- * @regs:                      MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_enable_intr_gen2(struct megasas_instance *instance)
@@ -902,7 +909,7 @@ megasas_enable_intr_gen2(struct megasas_instance *instance)
 
 /**
  * megasas_disable_intr_gen2 - Disables interrupt
- * @regs:                      MFI register set
+ * @instance:	Adapter soft state
  */
 static inline void
 megasas_disable_intr_gen2(struct megasas_instance *instance)
@@ -918,7 +925,7 @@ megasas_disable_intr_gen2(struct megasas_instance *instance)
 
 /**
  * megasas_read_fw_status_reg_gen2 - returns the current FW status value
- * @regs:                      MFI register set
+ * @instance:	Adapter soft state
  */
 static u32
 megasas_read_fw_status_reg_gen2(struct megasas_instance *instance)
@@ -928,7 +935,7 @@ megasas_read_fw_status_reg_gen2(struct megasas_instance *instance)
 
 /**
  * megasas_clear_interrupt_gen2 -      Check & clear interrupt
- * @regs:                              MFI register set
+ * @instance:	Adapter soft state
  */
 static int
 megasas_clear_intr_gen2(struct megasas_instance *instance)
@@ -961,11 +968,13 @@ megasas_clear_intr_gen2(struct megasas_instance *instance)
 
 	return mfiStatus;
 }
+
 /**
  * megasas_fire_cmd_gen2 -     Sends command to the FW
- * @frame_phys_addr :          Physical address of cmd
- * @frame_count :              Number of frames for the command
- * @regs :                     MFI register set
+ * @instance:		Adapter soft state
+ * @frame_phys_addr:	Physical address of cmd
+ * @frame_count:	Number of frames for the command
+ * @regs:		MFI register set
  */
 static inline void
 megasas_fire_cmd_gen2(struct megasas_instance *instance,
@@ -983,7 +992,8 @@ megasas_fire_cmd_gen2(struct megasas_instance *instance,
 
 /**
  * megasas_adp_reset_gen2 -	For controller reset
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
+ * @reg_set:	MFI register set
  */
 static int
 megasas_adp_reset_gen2(struct megasas_instance *instance,
@@ -1043,7 +1053,8 @@ megasas_adp_reset_gen2(struct megasas_instance *instance,
 
 /**
  * megasas_check_reset_gen2 -	For controller reset check
- * @regs:				MFI register set
+ * @instance:	Adapter soft state
+ * @regs:	MFI register set
  */
 static int
 megasas_check_reset_gen2(struct megasas_instance *instance,
@@ -1071,10 +1082,10 @@ static struct megasas_instance_template megasas_instance_template_gen2 = {
 	.issue_dcmd = megasas_issue_dcmd,
 };
 
-/**
-*	This is the end of set of functions & definitions
-*       specific to gen2 (deviceid : 0x78, 0x79) controllers
-*/
+/*
+ * This is the end of set of functions & definitions
+ * specific to gen2 (deviceid : 0x78, 0x79) controllers
+ */
 
 /*
  * Template added for TB (Fusion)
@@ -1609,7 +1620,7 @@ megasas_build_ldio(struct megasas_instance *instance, struct scsi_cmnd *scp,
 /**
  * megasas_cmd_type -		Checks if the cmd is for logical drive/sysPD
  *				and whether it's RW or non RW
- * @scmd:			SCSI command
+ * @cmd:			SCSI command
  *
  */
 inline int megasas_cmd_type(struct scsi_cmnd *cmd)
@@ -1749,8 +1760,8 @@ megasas_build_and_issue_cmd(struct megasas_instance *instance,
 
 /**
  * megasas_queue_command -	Queue entry point
+ * @shost:			adapter SCSI host
  * @scmd:			SCSI command to be queued
- * @done:			Callback entry point
  */
 static int
 megasas_queue_command(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
@@ -2916,11 +2927,7 @@ megasas_dump(void *buf, int sz, int format)
 
 /**
  * megasas_dump_reg_set -	This function will print hexdump of register set
- * @buf:			Buffer to be dumped
- * @sz:				Size in bytes
- * @format:			Different formats of dumping e.g. format=n will
- *				cause only 'n' 32 bit words to be dumped in a
- *				single line.
+ * @reg_set:	Register set to be dumped
  */
 inline void
 megasas_dump_reg_set(void __iomem *reg_set)
@@ -2997,6 +3004,7 @@ megasas_dump_sys_regs(void __iomem *reg_set, char *buf)
 
 /**
  * megasas_reset_bus_host -	Bus & host reset handler entry point
+ * @scmd:			Mid-layer SCSI command
  */
 static int megasas_reset_bus_host(struct scsi_cmnd *scmd)
 {
@@ -3777,7 +3785,7 @@ megasas_issue_pending_cmds_again(struct megasas_instance *instance)
 	megasas_register_aen(instance, seq_num, class_locale.word);
 }
 
-/**
+/*
  * Move the internal reset pending commands to a deferred queue.
  *
  * We move the commands pending at internal reset time to a
@@ -3785,7 +3793,7 @@ megasas_issue_pending_cmds_again(struct megasas_instance *instance)
  * completion of the internal reset sequence. if the internal reset
  * did not complete in time, the kernel reset handler would flush
  * these commands.
- **/
+ */
 static void
 megasas_internal_reset_defer_cmds(struct megasas_instance *instance)
 {
@@ -3963,8 +3971,11 @@ megasas_deplete_reply_queue(struct megasas_instance *instance,
 	tasklet_schedule(&instance->isr_tasklet);
 	return IRQ_HANDLED;
 }
+
 /**
  * megasas_isr - isr entry point
+ * @irq:	IRQ number
+ * @devp:	IRQ context address
  */
 static irqreturn_t megasas_isr(int irq, void *devp)
 {
@@ -3986,6 +3997,7 @@ static irqreturn_t megasas_isr(int irq, void *devp)
 /**
  * megasas_transition_to_ready -	Move the FW to READY state
  * @instance:				Adapter soft state
+ * @ocr:				Adapter reset state
  *
  * During the initialization, FW passes can potentially be in any one of
  * several possible states. If the FW in operational, waiting-for-handshake
@@ -4743,7 +4755,7 @@ megasas_get_ld_list(struct megasas_instance *instance)
 /**
  * megasas_ld_list_query -	Returns FW's ld_list structure
  * @instance:				Adapter soft state
- * @ld_list:				ld_list structure
+ * @query_type:				ld_list structure type
  *
  * Issues an internal command (DCMD) to get the FW's controller PD
  * list structure.  This information is mainly used to find out SYSTEM
@@ -5653,7 +5665,6 @@ megasas_destroy_irqs(struct megasas_instance *instance) {
 /**
  * megasas_setup_jbod_map -	setup jbod map for FP seq_number.
  * @instance:				Adapter soft state
- * @is_probe:				Driver probe check
  *
  * Return 0 on success.
  */
@@ -6494,7 +6505,7 @@ megasas_get_seq_num(struct megasas_instance *instance,
  * megasas_register_aen -	Registers for asynchronous event notification
  * @instance:			Adapter soft state
  * @seq_num:			The starting sequence number
- * @class_locale:		Class of the event
+ * @class_locale_word:		Class of the event
  *
  * This function subscribes for AEN for events beyond the @seq_num. It requests
  * to be notified if and only if the event is of type @class_locale
@@ -7014,8 +7025,9 @@ static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
  * megasas_alloc_ctrl_dma_buffers -	Allocate consistent DMA buffers during
  *					driver load time
  *
- * @instance-				Adapter soft instance
- * @return-				O for SUCCESS
+ * @instance:				Adapter soft instance
+ *
+ * @return:				O for SUCCESS
  */
 static inline
 int megasas_alloc_ctrl_dma_buffers(struct megasas_instance *instance)
@@ -7931,7 +7943,7 @@ static void megasas_detach_one(struct pci_dev *pdev)
 
 /**
  * megasas_shutdown -	Shutdown entry point
- * @device:		Generic device structure
+ * @pdev:		Generic device structure
  */
 static void megasas_shutdown(struct pci_dev *pdev)
 {
@@ -7956,8 +7968,10 @@ static void megasas_shutdown(struct pci_dev *pdev)
 		pci_free_irq_vectors(instance->pdev);
 }
 
-/**
+/*
  * megasas_mgmt_open -	char node "open" entry point
+ * @inode:	char node inode
+ * @filep:	char node file
  */
 static int megasas_mgmt_open(struct inode *inode, struct file *filep)
 {
@@ -7970,8 +7984,11 @@ static int megasas_mgmt_open(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-/**
+/*
  * megasas_mgmt_fasync -	Async notifier registration from applications
+ * @fd:		char node file descriptor number
+ * @filep:	char node file
+ * @mode:	notifier on/off
  *
  * This function adds the calling process to a driver global queue. When an
  * event occurs, SIGIO will be sent to all processes in this queue.
@@ -7997,9 +8014,11 @@ static int megasas_mgmt_fasync(int fd, struct file *filep, int mode)
 	return rc;
 }
 
-/**
+/*
  * megasas_mgmt_poll -  char node "poll" entry point
- * */
+ * @filep:	char node file
+ * @wait:	Events to poll for
+ */
 static __poll_t megasas_mgmt_poll(struct file *file, poll_table *wait)
 {
 	__poll_t mask;
@@ -8057,7 +8076,8 @@ static int megasas_set_crash_dump_params_ioctl(struct megasas_cmd *cmd)
 /**
  * megasas_mgmt_fw_ioctl -	Issues management ioctls to FW
  * @instance:			Adapter soft state
- * @argp:			User's ioctl packet
+ * @user_ioc:			User's ioctl packet
+ * @ioc:			ioctl packet
  */
 static int
 megasas_mgmt_fw_ioctl(struct megasas_instance *instance,
@@ -8397,6 +8417,9 @@ static int megasas_mgmt_ioctl_aen(struct file *file, unsigned long arg)
 
 /**
  * megasas_mgmt_ioctl -	char node ioctl entry point
+ * @file:	char device file pointer
+ * @cmd:	ioctl command
+ * @arg:	ioctl command arguments address
  */
 static long
 megasas_mgmt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 319f241da4b6..c4f15a52f86b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -90,9 +90,9 @@ extern u32 megasas_readl(struct megasas_instance *instance,
 /**
  * megasas_adp_reset_wait_for_ready -	initiate chip reset and wait for
  *					controller to come to ready state
- * @instance -				adapter's soft state
- * @do_adp_reset -			If true, do a chip reset
- * @ocr_context -			If called from OCR context this will
+ * @instance:				adapter's soft state
+ * @do_adp_reset:			If true, do a chip reset
+ * @ocr_context:			If called from OCR context this will
  *					be set to 1, else 0
  *
  * This function initates a chip reset followed by a wait for controller to
@@ -146,10 +146,10 @@ megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
 /**
  * megasas_check_same_4gb_region -	check if allocation
  *					crosses same 4GB boundary or not
- * @instance -				adapter's soft instance
- * start_addr -			start address of DMA allocation
- * size -				size of allocation in bytes
- * return -				true : allocation does not cross same
+ * @instance:				adapter's soft instance
+ * @start_addr:				start address of DMA allocation
+ * @size:				size of allocation in bytes
+ * @return:				true : allocation does not cross same
  *					4GB boundary
  *					false: allocation crosses same
  *					4GB boundary
@@ -174,7 +174,7 @@ static inline bool megasas_check_same_4gb_region
 
 /**
  * megasas_enable_intr_fusion -	Enables interrupts
- * @regs:			MFI register set
+ * @instance:	adapter's soft instance
  */
 static void
 megasas_enable_intr_fusion(struct megasas_instance *instance)
@@ -196,7 +196,7 @@ megasas_enable_intr_fusion(struct megasas_instance *instance)
 
 /**
  * megasas_disable_intr_fusion - Disables interrupt
- * @regs:			 MFI register set
+ * @instance:	adapter's soft instance
  */
 static void
 megasas_disable_intr_fusion(struct megasas_instance *instance)
@@ -238,6 +238,7 @@ megasas_clear_intr_fusion(struct megasas_instance *instance)
 /**
  * megasas_get_cmd_fusion -	Get a command from the free pool
  * @instance:		Adapter soft state
+ * @blk_tag:		Command tag
  *
  * Returns a blk_tag indexed mpt frame
  */
@@ -309,8 +310,8 @@ megasas_fire_cmd_fusion(struct megasas_instance *instance,
 
 /**
  * megasas_fusion_update_can_queue -	Do all Adapter Queue depth related calculations here
- * @instance:							Adapter soft state
- * fw_boot_context:						Whether this function called during probe or after OCR
+ * @instance:		Adapter soft state
+ * @fw_boot_context:	Whether this function called during probe or after OCR
  *
  * This function is only for fusion controllers.
  * Update host can queue, if firmware downgrade max supported firmware commands.
@@ -1016,6 +1017,7 @@ megasas_alloc_cmds_fusion(struct megasas_instance *instance)
  * wait_and_poll -	Issues a polling command
  * @instance:			Adapter soft state
  * @cmd:			Command packet to be issued
+ * @seconds:			Maximum poll time
  *
  * For polling, MFI requires the cmd_status to be set to 0xFF before posting.
  */
@@ -1906,6 +1908,7 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
 /**
  * megasas_fault_detect_work	-	Worker function of
  *					FW fault handling workqueue.
+ * @work:	FW fault work struct
  */
 static void
 megasas_fault_detect_work(struct work_struct *work)
@@ -1989,11 +1992,13 @@ megasas_fusion_stop_watchdog(struct megasas_instance *instance)
 
 /**
  * map_cmd_status -	Maps FW cmd status to OS cmd status
- * @cmd :		Pointer to cmd
- * @status :		status of cmd returned by FW
- * @ext_status :	ext status of cmd returned by FW
+ * @fusion:		fusion context
+ * @scmd:		Pointer to cmd
+ * @status:		status of cmd returned by FW
+ * @ext_status:		ext status of cmd returned by FW
+ * @data_length:	command data length
+ * @sense:		command sense data
  */
-
 static void
 map_cmd_status(struct fusion_context *fusion,
 		struct scsi_cmnd *scmd, u8 status, u8 ext_status,
@@ -2234,7 +2239,7 @@ megasas_make_prp_nvme(struct megasas_instance *instance, struct scsi_cmnd *scmd,
  * @scp:		SCSI command from the mid-layer
  * @sgl_ptr:		SGL to be filled in
  * @cmd:		cmd we are working on
- * @sge_count		sge count
+ * @sge_count:		sge count
  *
  */
 static void
@@ -2343,9 +2348,12 @@ int megasas_make_sgl(struct megasas_instance *instance, struct scsi_cmnd *scp,
 
 /**
  * megasas_set_pd_lba -	Sets PD LBA
- * @cdb:		CDB
+ * @io_request:		IO request
  * @cdb_len:		cdb length
- * @start_blk:		Start block of IO
+ * @io_info:		IO information
+ * @scp:		SCSI command
+ * @local_map_ptr:	Raid map
+ * @ref_tag:		Primary reference tag
  *
  * Used to set the PD LBA in CDB for FP IOs
  */
@@ -2603,10 +2611,12 @@ static void megasas_stream_detect(struct megasas_instance *instance,
  * affinity (cpu of the controller) and raid_flags in the raid context
  * based on IO type.
  *
+ * @fusion:		Fusion context
  * @praid_context:	IO RAID context
  * @raid:		LD raid map
  * @fp_possible:	Is fast path possible?
  * @is_read:		Is read IO?
+ * @scsi_buff_len:	SCSI command buffer length
  *
  */
 static void
@@ -2940,7 +2950,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 /**
  * megasas_build_ld_nonrw_fusion - prepares non rw ios for virtual disk
  * @instance:		Adapter soft state
- * @scp:		SCSI command
+ * @scmd:		SCSI command
  * @cmd:		Command to be prepared
  *
  * Prepares the io_request frame for non-rw io cmds for vd.
@@ -3028,7 +3038,7 @@ static void megasas_build_ld_nonrw_fusion(struct megasas_instance *instance,
 /**
  * megasas_build_syspd_fusion - prepares rw/non-rw ios for syspd
  * @instance:		Adapter soft state
- * @scp:		SCSI command
+ * @scmd:		SCSI command
  * @cmd:		Command to be prepared
  * @fp_possible:	parameter to detect fast path or firmware path io.
  *
@@ -3405,7 +3415,7 @@ megasas_build_and_issue_cmd_fusion(struct megasas_instance *instance,
  * megasas_complete_r1_command -
  * completes R1 FP write commands which has valid peer smid
  * @instance:			Adapter soft state
- * @cmd_fusion:			MPT command frame
+ * @cmd:			MPT command frame
  *
  */
 static inline void
@@ -3459,6 +3469,9 @@ megasas_complete_r1_command(struct megasas_instance *instance,
 /**
  * complete_cmd_fusion -	Completes command
  * @instance:			Adapter soft state
+ * @MSIxIndex:			MSI number
+ * @irq_context:		IRQ context
+ *
  * Completes all commands that is in reply descriptor queue
  */
 static int
@@ -3634,6 +3647,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 
 /**
  * megasas_enable_irq_poll() - enable irqpoll
+ * @instance:			Adapter soft state
  */
 static void megasas_enable_irq_poll(struct megasas_instance *instance)
 {
@@ -3650,7 +3664,7 @@ static void megasas_enable_irq_poll(struct megasas_instance *instance)
 
 /**
  * megasas_sync_irqs -	Synchronizes all IRQs owned by adapter
- * @instance:			Adapter soft state
+ * @instance_addr:			Adapter soft state address
  */
 static void megasas_sync_irqs(unsigned long instance_addr)
 {
@@ -3706,7 +3720,7 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
 
 /**
  * megasas_complete_cmd_dpc_fusion -	Completes command
- * @instance:			Adapter soft state
+ * @instance_addr:			Adapter soft state address
  *
  * Tasklet to complete cmds
  */
@@ -3729,6 +3743,8 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 
 /**
  * megasas_isr_fusion - isr entry point
+ * @irq:	IRQ number
+ * @devp:	IRQ context
  */
 static irqreturn_t megasas_isr_fusion(int irq, void *devp)
 {
@@ -3763,7 +3779,7 @@ static irqreturn_t megasas_isr_fusion(int irq, void *devp)
 /**
  * build_mpt_mfi_pass_thru - builds a cmd fo MFI Pass thru
  * @instance:			Adapter soft state
- * mfi_cmd:			megasas_cmd pointer
+ * @mfi_cmd:			megasas_cmd pointer
  *
  */
 static void
@@ -3880,7 +3896,7 @@ megasas_release_fusion(struct megasas_instance *instance)
 
 /**
  * megasas_read_fw_status_reg_fusion - returns the current FW status value
- * @regs:			MFI register set
+ * @instance:			Adapter soft state
  */
 static u32
 megasas_read_fw_status_reg_fusion(struct megasas_instance *instance)
@@ -3891,7 +3907,7 @@ megasas_read_fw_status_reg_fusion(struct megasas_instance *instance)
 /**
  * megasas_alloc_host_crash_buffer -	Host buffers for Crash dump collection from Firmware
  * @instance:				Controller's soft instance
- * return:			        Number of allocated host crash buffers
+ * @return:			        Number of allocated host crash buffers
  */
 static void
 megasas_alloc_host_crash_buffer(struct megasas_instance *instance)
@@ -3929,6 +3945,7 @@ megasas_free_host_crash_buffer(struct megasas_instance *instance)
 
 /**
  * megasas_adp_reset_fusion -	For controller reset
+ * @instance:				Controller's soft instance
  * @regs:				MFI register set
  */
 static int
@@ -4006,6 +4023,7 @@ megasas_adp_reset_fusion(struct megasas_instance *instance,
 
 /**
  * megasas_check_reset_fusion -	For controller reset check
+ * @instance:				Controller's soft instance
  * @regs:				MFI register set
  */
 static int
@@ -4335,8 +4353,8 @@ static int megasas_track_scsiio(struct megasas_instance *instance,
 
 /**
  * megasas_tm_response_code - translation of device response code
- * @ioc: per adapter object
- * @mpi_reply: MPI reply returned by firmware
+ * @instance:	Controller's soft instance
+ * @mpi_reply:	MPI reply returned by firmware
  *
  * Return nothing.
  */
@@ -4391,9 +4409,9 @@ megasas_tm_response_code(struct megasas_instance *instance,
  * @device_handle: device handle
  * @channel: the channel assigned by the OS
  * @id: the id assigned by the OS
- * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in megaraid_sas_fusion.c)
  * @smid_task: smid assigned to the task
- * @m_type: TM_MUTEX_ON or TM_MUTEX_OFF
+ * @type: MPI2_SCSITASKMGMT_TASKTYPE__XXX (defined in megaraid_sas_fusion.c)
+ * @mr_device_priv_data: private data
  * Context: user
  *
  * MegaRaid use MPT interface for Task Magement request.
-- 
2.26.2

