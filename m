Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1101FB034
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2020 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFPMSw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jun 2020 08:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbgFPMSv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jun 2020 08:18:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37ED3AD74;
        Tue, 16 Jun 2020 12:18:33 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] gdth: reindent and whitespace cleanup
Date:   Tue, 16 Jun 2020 14:18:18 +0200
Message-Id: <20200616121821.99113-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200616121821.99113-1-hare@suse.de>
References: <20200616121821.99113-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Long overdue. No functional change.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/gdth.c       | 6522 +++++++++++++++++++++++----------------------
 drivers/scsi/gdth.h       | 1376 +++++-----
 drivers/scsi/gdth_ioctl.h |  378 +--
 drivers/scsi/gdth_proc.c  | 1109 ++++----
 drivers/scsi/gdth_proc.h  |    6 +-
 5 files changed, 4705 insertions(+), 4686 deletions(-)

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 7f150d52b4a6..b65edccb3147 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /************************************************************************
- * Linux driver for                                                     *  
+ * Linux driver for                                                     *
  * ICP vortex GmbH:    GDT PCI Disk Array Controllers                   *
  * Intel Corporation:  Storage RAID Controllers                         *
  *                                                                      *
@@ -23,25 +23,25 @@
  * This includes the PCI SCSI Disk Array Controllers and the
  * PCI Fibre Channel Disk Array Controllers. See gdth.h for a complete
  * list of all controller types.
- * 
- * After the optional list of IRQ values, other possible 
+ *
+ * After the optional list of IRQ values, other possible
  * command line options are:
  * disable:Y                    disable driver
  * disable:N                    enable driver
  * reserve_mode:0               reserve no drives for the raw service
  * reserve_mode:1               reserve all not init., removable drives
  * reserve_mode:2               reserve all not init. drives
- * reserve_list:h,b,t,l,h,b,t,l,...     reserve particular drive(s) with 
- *                              h- controller no., b- channel no., 
+ * reserve_list:h,b,t,l,h,b,t,l,...     reserve particular drive(s) with
+ *                              h- controller no., b- channel no.,
  *                              t- target ID, l- LUN
- * reverse_scan:Y               reverse scan order for PCI controllers         
+ * reverse_scan:Y               reverse scan order for PCI controllers
  * reverse_scan:N               scan PCI controllers like BIOS
  * max_ids:x                    x - target ID count per channel (1..MAXID)
- * rescan:Y                     rescan all channels/IDs 
+ * rescan:Y                     rescan all channels/IDs
  * rescan:N                     use all devices found until now
  * hdr_channel:x                x - number of virtual bus for host drives
- * shared_access:Y              disable driver reserve/release protocol to 
- *                              access a shared resource from several nodes, 
+ * shared_access:Y              disable driver reserve/release protocol to
+ *                              access a shared resource from several nodes,
  *                              appropriate controller firmware required
  * shared_access:N              enable driver reserve/release protocol
  * force_dma32:Y                use only 32 bit DMA mode
@@ -51,13 +51,13 @@
  *                          max_ids:127,rescan:N,hdr_channel:0,
  *                          shared_access:Y,force_dma32:N".
  * Here is another example: "gdth=reserve_list:0,1,2,0,0,1,3,0,rescan:Y".
- * 
- * When loading the gdth driver as a module, the same options are available. 
+ *
+ * When loading the gdth driver as a module, the same options are available.
  * You can set the IRQs with "IRQ=...". However, the syntax to specify the
- * options changes slightly. You must replace all ',' between options 
- * with ' ' and all ':' with '=' and you must use 
+ * options changes slightly. You must replace all ',' between options
+ * with ' ' and all ':' with '=' and you must use
  * '1' in place of 'Y' and '0' in place of 'N'.
- * 
+ *
  * Default: "modprobe gdth disable=0 reserve_mode=1 reverse_scan=0
  *           max_ids=127 rescan=0 hdr_channel=0 shared_access=0
  *           force_dma32=0"
@@ -117,9 +117,9 @@ static void gdth_delay(int milliseconds);
 static void gdth_eval_mapping(u32 size, u32 *cyls, int *heads, int *secs);
 static irqreturn_t gdth_interrupt(int irq, void *dev_id);
 static irqreturn_t __gdth_interrupt(gdth_ha_str *ha,
-                                    int gdth_from_wait, int* pIndex);
+				    int gdth_from_wait, int* pIndex);
 static int gdth_sync_event(gdth_ha_str *ha, int service, u8 index,
-                                                               struct scsi_cmnd *scp);
+			   struct scsi_cmnd *scp);
 static int gdth_async_event(gdth_ha_str *ha);
 static void gdth_log_event(gdth_evt_data *dvr, char *buffer);
 
@@ -128,14 +128,14 @@ static void gdth_next(gdth_ha_str *ha);
 static int gdth_fill_raw_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp, u8 b);
 static int gdth_special_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp);
 static gdth_evt_str *gdth_store_event(gdth_ha_str *ha, u16 source,
-                                      u16 idx, gdth_evt_data *evt);
+				      u16 idx, gdth_evt_data *evt);
 static int gdth_read_event(gdth_ha_str *ha, int handle, gdth_evt_str *estr);
-static void gdth_readapp_event(gdth_ha_str *ha, u8 application, 
-                               gdth_evt_str *estr);
+static void gdth_readapp_event(gdth_ha_str *ha, u8 application,
+			       gdth_evt_str *estr);
 static void gdth_clear_events(void);
 
 static void gdth_copy_internal_data(gdth_ha_str *ha, struct scsi_cmnd *scp,
-                                    char *buffer, u16 count);
+				    char *buffer, u16 count);
 static int gdth_internal_cache_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp);
 static int gdth_fill_cache_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp,
 			       u16 hdrive);
@@ -146,7 +146,7 @@ static int gdth_get_cmd_index(gdth_ha_str *ha);
 static void gdth_release_event(gdth_ha_str *ha);
 static int gdth_wait(gdth_ha_str *ha, int index,u32 time);
 static int gdth_internal_cmd(gdth_ha_str *ha, u8 service, u16 opcode,
-                                             u32 p1, u64 p2,u64 p3);
+			     u32 p1, u64 p2,u64 p3);
 static int gdth_search_drives(gdth_ha_str *ha);
 static int gdth_analyse_hdrive(gdth_ha_str *ha, u16 hdrive);
 
@@ -155,7 +155,7 @@ static const char *gdth_ctr_name(gdth_ha_str *ha);
 static int gdth_open(struct inode *inode, struct file *filep);
 static int gdth_close(struct inode *inode, struct file *filep);
 static long gdth_unlocked_ioctl(struct file *filep, unsigned int cmd,
-			        unsigned long arg);
+				unsigned long arg);
 
 static void gdth_flush(gdth_ha_str *ha);
 static int gdth_queuecommand(struct Scsi_Host *h, struct scsi_cmnd *cmd);
@@ -186,48 +186,51 @@ static struct timer_list gdth_timer;
 
 #define BUS_L2P(a,b)    ((b)>(a)->virt_bus ? (b-1):(b))
 
-static u8   gdth_polling;                           /* polling if TRUE */
-static int      gdth_ctr_count  = 0;                    /* controller count */
-static LIST_HEAD(gdth_instances);                       /* controller list */
-static u8   gdth_write_through = FALSE;             /* write through */
-static gdth_evt_str ebuffer[MAX_EVENTS];                /* event buffer */
+static u8   gdth_polling;			/* polling if TRUE */
+static int  gdth_ctr_count = 0;			/* controller count */
+static LIST_HEAD(gdth_instances);		/* controller list */
+static u8   gdth_write_through = FALSE;		/* write through */
+static gdth_evt_str ebuffer[MAX_EVENTS];	/* event buffer */
 static int elastidx;
 static int eoldidx;
 static int major;
 
-#define DIN     1                               /* IN data direction */
-#define DOU     2                               /* OUT data direction */
-#define DNO     DIN                             /* no data transfer */
-#define DUN     DIN                             /* unknown data direction */
+#define DIN     1				/* IN data direction */
+#define DOU     2				/* OUT data direction */
+#define DNO     DIN				/* no data transfer */
+#define DUN     DIN				/* unknown data direction */
 static u8 gdth_direction_tab[0x100] = {
-    DNO,DNO,DIN,DIN,DOU,DIN,DIN,DOU,DIN,DUN,DOU,DOU,DUN,DUN,DUN,DIN,
-    DNO,DIN,DIN,DOU,DIN,DOU,DNO,DNO,DOU,DNO,DIN,DNO,DIN,DOU,DNO,DUN,
-    DIN,DUN,DIN,DUN,DOU,DIN,DUN,DUN,DIN,DIN,DOU,DNO,DUN,DIN,DOU,DOU,
-    DOU,DOU,DOU,DNO,DIN,DNO,DNO,DIN,DOU,DOU,DOU,DOU,DIN,DOU,DIN,DOU,
-    DOU,DOU,DIN,DIN,DIN,DNO,DUN,DNO,DNO,DNO,DUN,DNO,DOU,DIN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DOU,DUN,DUN,DUN,DUN,DIN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DIN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DIN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DNO,DNO,DUN,DIN,DNO,DOU,DUN,DNO,DUN,DOU,DOU,
-    DOU,DOU,DOU,DNO,DUN,DIN,DOU,DIN,DIN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,
-    DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN
+	DNO,DNO,DIN,DIN,DOU,DIN,DIN,DOU,DIN,DUN,DOU,DOU,DUN,DUN,DUN,DIN,
+	DNO,DIN,DIN,DOU,DIN,DOU,DNO,DNO,DOU,DNO,DIN,DNO,DIN,DOU,DNO,DUN,
+	DIN,DUN,DIN,DUN,DOU,DIN,DUN,DUN,DIN,DIN,DOU,DNO,DUN,DIN,DOU,DOU,
+	DOU,DOU,DOU,DNO,DIN,DNO,DNO,DIN,DOU,DOU,DOU,DOU,DIN,DOU,DIN,DOU,
+	DOU,DOU,DIN,DIN,DIN,DNO,DUN,DNO,DNO,DNO,DUN,DNO,DOU,DIN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DOU,DUN,DUN,DUN,DUN,DIN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DIN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DIN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DNO,DNO,DUN,DIN,DNO,DOU,DUN,DNO,DUN,DOU,DOU,
+	DOU,DOU,DOU,DNO,DUN,DIN,DOU,DIN,DIN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DOU,DUN,DUN,DUN,DUN,DUN,
+	DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN,DUN
 };
 
 /* LILO and modprobe/insmod parameters */
 /* disable driver flag */
 static int disable __initdata = 0;
 /* reserve flag */
-static int reserve_mode = 1;                  
+static int reserve_mode = 1;
 /* reserve list */
-static int reserve_list[MAX_RES_ARGS] = 
-{0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
- 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
- 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
+static int reserve_list[MAX_RES_ARGS] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
 /* scan order for PCI controllers */
 static int reverse_scan = 0;
 /* virtual channel for the host drives */
@@ -256,10 +259,10 @@ MODULE_LICENSE("GPL");
 
 /* ioctl interface */
 static const struct file_operations gdth_fops = {
-    .unlocked_ioctl   = gdth_unlocked_ioctl,
-    .open    = gdth_open,
-    .release = gdth_close,
-    .llseek = noop_llseek,
+	.unlocked_ioctl   = gdth_unlocked_ioctl,
+	.open    = gdth_open,
+	.release = gdth_close,
+	.llseek = noop_llseek,
 };
 
 #include "gdth_proc.h"
@@ -306,11 +309,11 @@ static void gdth_put_cmndinfo(struct gdth_cmndinfo *priv)
 
 static void gdth_delay(int milliseconds)
 {
-    if (milliseconds == 0) {
-        udelay(1);
-    } else {
-        mdelay(milliseconds);
-    }
+	if (milliseconds == 0) {
+		udelay(1);
+	} else {
+		mdelay(milliseconds);
+	}
 }
 
 static void gdth_scsi_done(struct scsi_cmnd *scp)
@@ -332,73 +335,75 @@ static void gdth_scsi_done(struct scsi_cmnd *scp)
 static int __gdth_execute(struct scsi_device *sdev, gdth_cmd_str *gdtcmd,
 			  char *cmnd, int timeout, u32 *info)
 {
-    gdth_ha_str *ha = shost_priv(sdev->host);
-    struct scsi_cmnd *scp;
-    struct gdth_cmndinfo cmndinfo;
-    DECLARE_COMPLETION_ONSTACK(wait);
-    int rval;
-
-    scp = kzalloc(sizeof(*scp), GFP_KERNEL);
-    if (!scp)
-        return -ENOMEM;
-
-    scp->sense_buffer = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
-    if (!scp->sense_buffer) {
+	gdth_ha_str *ha = shost_priv(sdev->host);
+	struct scsi_cmnd *scp;
+	struct gdth_cmndinfo cmndinfo;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	int rval;
+
+	scp = kzalloc(sizeof(*scp), GFP_KERNEL);
+	if (!scp)
+		return -ENOMEM;
+
+	scp->sense_buffer = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
+	if (!scp->sense_buffer) {
+		kfree(scp);
+		return -ENOMEM;
+	}
+
+	scp->device = sdev;
+	memset(&cmndinfo, 0, sizeof(cmndinfo));
+
+	/* use request field to save the ptr. to completion struct. */
+	scp->request = (struct request *)&wait;
+	scp->cmd_len = 12;
+	scp->cmnd = cmnd;
+	cmndinfo.priority = IOCTL_PRI;
+	cmndinfo.internal_cmd_str = gdtcmd;
+	cmndinfo.internal_command = 1;
+
+	TRACE(("__gdth_execute() cmd 0x%x\n", scp->cmnd[0]));
+	__gdth_queuecommand(ha, scp, &cmndinfo);
+
+	wait_for_completion(&wait);
+
+	rval = cmndinfo.status;
+	if (info)
+		*info = cmndinfo.info;
+	kfree(scp->sense_buffer);
 	kfree(scp);
-	return -ENOMEM;
-    }
-
-    scp->device = sdev;
-    memset(&cmndinfo, 0, sizeof(cmndinfo));
-
-    /* use request field to save the ptr. to completion struct. */
-    scp->request = (struct request *)&wait;
-    scp->cmd_len = 12;
-    scp->cmnd = cmnd;
-    cmndinfo.priority = IOCTL_PRI;
-    cmndinfo.internal_cmd_str = gdtcmd;
-    cmndinfo.internal_command = 1;
-
-    TRACE(("__gdth_execute() cmd 0x%x\n", scp->cmnd[0]));
-    __gdth_queuecommand(ha, scp, &cmndinfo);
-
-    wait_for_completion(&wait);
-
-    rval = cmndinfo.status;
-    if (info)
-        *info = cmndinfo.info;
-    kfree(scp->sense_buffer);
-    kfree(scp);
-    return rval;
+	return rval;
 }
 
 int gdth_execute(struct Scsi_Host *shost, gdth_cmd_str *gdtcmd, char *cmnd,
-                 int timeout, u32 *info)
+		 int timeout, u32 *info)
 {
-    struct scsi_device *sdev = scsi_get_host_dev(shost);
-    int rval = __gdth_execute(sdev, gdtcmd, cmnd, timeout, info);
+	struct scsi_device *sdev = scsi_get_host_dev(shost);
+	int rval = __gdth_execute(sdev, gdtcmd, cmnd, timeout, info);
 
-    scsi_free_host_dev(sdev);
-    return rval;
+	scsi_free_host_dev(sdev);
+	return rval;
 }
 
 static void gdth_eval_mapping(u32 size, u32 *cyls, int *heads, int *secs)
 {
-    *cyls = size /HEADS/SECS;
-    if (*cyls <= MAXCYLS) {
-        *heads = HEADS;
-        *secs = SECS;
-    } else {                                        /* too high for 64*32 */
-        *cyls = size /MEDHEADS/MEDSECS;
-        if (*cyls <= MAXCYLS) {
-            *heads = MEDHEADS;
-            *secs = MEDSECS;
-        } else {                                    /* too high for 127*63 */
-            *cyls = size /BIGHEADS/BIGSECS;
-            *heads = BIGHEADS;
-            *secs = BIGSECS;
-        }
-    }
+	*cyls = size /HEADS/SECS;
+	if (*cyls <= MAXCYLS) {
+		*heads = HEADS;
+		*secs = SECS;
+	} else {
+		/* too high for 64*32 */
+		*cyls = size /MEDHEADS/MEDSECS;
+		if (*cyls <= MAXCYLS) {
+			*heads = MEDHEADS;
+			*secs = MEDSECS;
+		} else {
+			/* too high for 127*63 */
+			*cyls = size /BIGHEADS/BIGSECS;
+			*heads = BIGHEADS;
+			*secs = BIGSECS;
+		}
+	}
 }
 
 static bool gdth_search_vortex(u16 device)
@@ -457,7 +462,7 @@ static int gdth_pci_init_one(struct pci_dev *pdev,
 	int rc;
 	gdth_pci_str gdth_pcistr;
 	gdth_ha_str *ha = NULL;
-    
+
 	TRACE(("gdth_search_dev() cnt %d vendor %x device %x\n",
 	       gdth_ctr_count, vendor, device));
 
@@ -473,25 +478,25 @@ static int gdth_pci_init_one(struct pci_dev *pdev,
 	if (gdth_ctr_count >= MAXHA)
 		return -EBUSY;
 
-        /* GDT PCI controller found, resources are already in pdev */
+	/* GDT PCI controller found, resources are already in pdev */
 	gdth_pcistr.pdev = pdev;
-        base0 = pci_resource_flags(pdev, 0);
-        base1 = pci_resource_flags(pdev, 1);
-        base2 = pci_resource_flags(pdev, 2);
-        if (device <= PCI_DEVICE_ID_VORTEX_GDT6000B ||   /* GDT6000/B */
-            device >= PCI_DEVICE_ID_VORTEX_GDT6x17RP) {  /* MPR */
-            if (!(base0 & IORESOURCE_MEM)) 
-		return -ENODEV;
-	    gdth_pcistr.dpmem = pci_resource_start(pdev, 0);
-        } else {                                  /* GDT6110, GDT6120, .. */
-            if (!(base0 & IORESOURCE_MEM) ||
-                !(base2 & IORESOURCE_MEM) ||
-                !(base1 & IORESOURCE_IO)) 
-		return -ENODEV;
-	    gdth_pcistr.dpmem = pci_resource_start(pdev, 2);
-	    gdth_pcistr.io    = pci_resource_start(pdev, 1);
-        }
-        TRACE2(("Controller found at %d/%d, irq %d, dpmem 0x%lx\n",
+	base0 = pci_resource_flags(pdev, 0);
+	base1 = pci_resource_flags(pdev, 1);
+	base2 = pci_resource_flags(pdev, 2);
+	if (device <= PCI_DEVICE_ID_VORTEX_GDT6000B ||   /* GDT6000/B */
+	    device >= PCI_DEVICE_ID_VORTEX_GDT6x17RP) {  /* MPR */
+		if (!(base0 & IORESOURCE_MEM))
+			return -ENODEV;
+		gdth_pcistr.dpmem = pci_resource_start(pdev, 0);
+	} else {					/* GDT6110, GDT6120, .. */
+		if (!(base0 & IORESOURCE_MEM) ||
+		    !(base2 & IORESOURCE_MEM) ||
+		    !(base1 & IORESOURCE_IO))
+			return -ENODEV;
+		gdth_pcistr.dpmem = pci_resource_start(pdev, 2);
+		gdth_pcistr.io    = pci_resource_start(pdev, 1);
+	}
+	TRACE2(("Controller found at %d/%d, irq %d, dpmem 0x%lx\n",
 		gdth_pcistr.pdev->bus->number,
 		PCI_SLOT(gdth_pcistr.pdev->devfn),
 		gdth_pcistr.irq,
@@ -507,1027 +512,1027 @@ static int gdth_pci_init_one(struct pci_dev *pdev,
 static int gdth_init_pci(struct pci_dev *pdev, gdth_pci_str *pcistr,
 			 gdth_ha_str *ha)
 {
-    register gdt6_dpram_str __iomem *dp6_ptr;
-    register gdt6c_dpram_str __iomem *dp6c_ptr;
-    register gdt6m_dpram_str __iomem *dp6m_ptr;
-    u32 retries;
-    u8 prot_ver;
-    u16 command;
-    int i, found = FALSE;
-
-    TRACE(("gdth_init_pci()\n"));
-
-    if (pdev->vendor == PCI_VENDOR_ID_INTEL)
-        ha->oem_id = OEM_ID_INTEL;
-    else
-        ha->oem_id = OEM_ID_ICP;
-    ha->brd_phys = (pdev->bus->number << 8) | (pdev->devfn & 0xf8);
-    ha->stype = (u32)pdev->device;
-    ha->irq = pdev->irq;
-    ha->pdev = pdev;
-    
-    if (ha->pdev->device <= PCI_DEVICE_ID_VORTEX_GDT6000B) {  /* GDT6000/B */
-        TRACE2(("init_pci() dpmem %lx irq %d\n",pcistr->dpmem,ha->irq));
-        ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6_dpram_str));
-        if (ha->brd == NULL) {
-            printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-            return 0;
-        }
-        /* check and reset interface area */
-        dp6_ptr = ha->brd;
-        writel(DPMEM_MAGIC, &dp6_ptr->u);
-        if (readl(&dp6_ptr->u) != DPMEM_MAGIC) {
-            printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n", 
-                   pcistr->dpmem);
-            found = FALSE;
-            for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
-                iounmap(ha->brd);
-                ha->brd = ioremap(i, sizeof(u16)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                if (readw(ha->brd) != 0xffff) {
-                    TRACE2(("init_pci_old() address 0x%x busy\n", i));
-                    continue;
-                }
-                iounmap(ha->brd);
-		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, i);
-                ha->brd = ioremap(i, sizeof(gdt6_dpram_str)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                dp6_ptr = ha->brd;
-                writel(DPMEM_MAGIC, &dp6_ptr->u);
-                if (readl(&dp6_ptr->u) == DPMEM_MAGIC) {
-                    printk("GDT-PCI: Use free address at 0x%x\n", i);
-                    found = TRUE;
-                    break;
-                }
-            }   
-            if (!found) {
-                printk("GDT-PCI: No free address found!\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-        }
-        memset_io(&dp6_ptr->u, 0, sizeof(dp6_ptr->u));
-        if (readl(&dp6_ptr->u) != 0) {
-            printk("GDT-PCI: Initialization error (DPMEM write error)\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-        
-        /* disable board interrupts, deinit services */
-        writeb(0xff, &dp6_ptr->io.irqdel);
-        writeb(0x00, &dp6_ptr->io.irqen);
-        writeb(0x00, &dp6_ptr->u.ic.S_Status);
-        writeb(0x00, &dp6_ptr->u.ic.Cmd_Index);
-
-        writel(pcistr->dpmem, &dp6_ptr->u.ic.S_Info[0]);
-        writeb(0xff, &dp6_ptr->u.ic.S_Cmd_Indx);
-        writeb(0, &dp6_ptr->io.event);
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6_ptr->u.ic.S_Status) != 0xff) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error (DEINIT failed)\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        prot_ver = (u8)readl(&dp6_ptr->u.ic.S_Info[0]);
-        writeb(0, &dp6_ptr->u.ic.S_Status);
-        writeb(0xff, &dp6_ptr->io.irqdel);
-        if (prot_ver != PROTOCOL_VERSION) {
-            printk("GDT-PCI: Illegal protocol version\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-
-        ha->type = GDT_PCI;
-        ha->ic_all_size = sizeof(dp6_ptr->u);
-        
-        /* special command to controller BIOS */
-        writel(0x00, &dp6_ptr->u.ic.S_Info[0]);
-        writel(0x00, &dp6_ptr->u.ic.S_Info[1]);
-        writel(0x00, &dp6_ptr->u.ic.S_Info[2]);
-        writel(0x00, &dp6_ptr->u.ic.S_Info[3]);
-        writeb(0xfe, &dp6_ptr->u.ic.S_Cmd_Indx);
-        writeb(0, &dp6_ptr->io.event);
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6_ptr->u.ic.S_Status) != 0xfe) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        writeb(0, &dp6_ptr->u.ic.S_Status);
-        writeb(0xff, &dp6_ptr->io.irqdel);
-
-        ha->dma64_support = 0;
-
-    } else if (ha->pdev->device <= PCI_DEVICE_ID_VORTEX_GDT6555) { /* GDT6110, ... */
-        ha->plx = (gdt6c_plx_regs *)pcistr->io;
-        TRACE2(("init_pci_new() dpmem %lx irq %d\n",
-            pcistr->dpmem,ha->irq));
-        ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6c_dpram_str));
-        if (ha->brd == NULL) {
-            printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-        /* check and reset interface area */
-        dp6c_ptr = ha->brd;
-        writel(DPMEM_MAGIC, &dp6c_ptr->u);
-        if (readl(&dp6c_ptr->u) != DPMEM_MAGIC) {
-            printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n", 
-                   pcistr->dpmem);
-            found = FALSE;
-            for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
-                iounmap(ha->brd);
-                ha->brd = ioremap(i, sizeof(u16)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                if (readw(ha->brd) != 0xffff) {
-                    TRACE2(("init_pci_plx() address 0x%x busy\n", i));
-                    continue;
-                }
-                iounmap(ha->brd);
-		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_2, i);
-                ha->brd = ioremap(i, sizeof(gdt6c_dpram_str)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                dp6c_ptr = ha->brd;
-                writel(DPMEM_MAGIC, &dp6c_ptr->u);
-                if (readl(&dp6c_ptr->u) == DPMEM_MAGIC) {
-                    printk("GDT-PCI: Use free address at 0x%x\n", i);
-                    found = TRUE;
-                    break;
-                }
-            }   
-            if (!found) {
-                printk("GDT-PCI: No free address found!\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-        }
-        memset_io(&dp6c_ptr->u, 0, sizeof(dp6c_ptr->u));
-        if (readl(&dp6c_ptr->u) != 0) {
-            printk("GDT-PCI: Initialization error (DPMEM write error)\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-        
-        /* disable board interrupts, deinit services */
-        outb(0x00,PTR2USHORT(&ha->plx->control1));
-        outb(0xff,PTR2USHORT(&ha->plx->edoor_reg));
-        
-        writeb(0x00, &dp6c_ptr->u.ic.S_Status);
-        writeb(0x00, &dp6c_ptr->u.ic.Cmd_Index);
-
-        writel(pcistr->dpmem, &dp6c_ptr->u.ic.S_Info[0]);
-        writeb(0xff, &dp6c_ptr->u.ic.S_Cmd_Indx);
-
-        outb(1,PTR2USHORT(&ha->plx->ldoor_reg));
-
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6c_ptr->u.ic.S_Status) != 0xff) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error (DEINIT failed)\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        prot_ver = (u8)readl(&dp6c_ptr->u.ic.S_Info[0]);
-        writeb(0, &dp6c_ptr->u.ic.Status);
-        if (prot_ver != PROTOCOL_VERSION) {
-            printk("GDT-PCI: Illegal protocol version\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-
-        ha->type = GDT_PCINEW;
-        ha->ic_all_size = sizeof(dp6c_ptr->u);
-
-        /* special command to controller BIOS */
-        writel(0x00, &dp6c_ptr->u.ic.S_Info[0]);
-        writel(0x00, &dp6c_ptr->u.ic.S_Info[1]);
-        writel(0x00, &dp6c_ptr->u.ic.S_Info[2]);
-        writel(0x00, &dp6c_ptr->u.ic.S_Info[3]);
-        writeb(0xfe, &dp6c_ptr->u.ic.S_Cmd_Indx);
-        
-        outb(1,PTR2USHORT(&ha->plx->ldoor_reg));
-
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6c_ptr->u.ic.S_Status) != 0xfe) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        writeb(0, &dp6c_ptr->u.ic.S_Status);
-
-        ha->dma64_support = 0;
-
-    } else {                                            /* MPR */
-        TRACE2(("init_pci_mpr() dpmem %lx irq %d\n",pcistr->dpmem,ha->irq));
-        ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6m_dpram_str));
-        if (ha->brd == NULL) {
-            printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-            return 0;
-        }
-
-        /* manipulate config. space to enable DPMEM, start RP controller */
-	pci_read_config_word(pdev, PCI_COMMAND, &command);
-        command |= 6;
-	pci_write_config_word(pdev, PCI_COMMAND, command);
-	gdth_delay(1);
-
-        dp6m_ptr = ha->brd;
-
-        /* Ensure that it is safe to access the non HW portions of DPMEM.
-         * Aditional check needed for Xscale based RAID controllers */
-        while( ((int)readb(&dp6m_ptr->i960r.sema0_reg) ) & 3 )
-            gdth_delay(1);
-        
-        /* check and reset interface area */
-        writel(DPMEM_MAGIC, &dp6m_ptr->u);
-        if (readl(&dp6m_ptr->u) != DPMEM_MAGIC) {
-            printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n", 
-                   pcistr->dpmem);
-            found = FALSE;
-            for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
-                iounmap(ha->brd);
-                ha->brd = ioremap(i, sizeof(u16)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                if (readw(ha->brd) != 0xffff) {
-                    TRACE2(("init_pci_mpr() address 0x%x busy\n", i));
-                    continue;
-                }
-                iounmap(ha->brd);
-		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, i);
-                ha->brd = ioremap(i, sizeof(gdt6m_dpram_str)); 
-                if (ha->brd == NULL) {
-                    printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
-                    return 0;
-                }
-                dp6m_ptr = ha->brd;
-                writel(DPMEM_MAGIC, &dp6m_ptr->u);
-                if (readl(&dp6m_ptr->u) == DPMEM_MAGIC) {
-                    printk("GDT-PCI: Use free address at 0x%x\n", i);
-                    found = TRUE;
-                    break;
-                }
-            }   
-            if (!found) {
-                printk("GDT-PCI: No free address found!\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-        }
-        memset_io(&dp6m_ptr->u, 0, sizeof(dp6m_ptr->u));
-        
-        /* disable board interrupts, deinit services */
-        writeb(readb(&dp6m_ptr->i960r.edoor_en_reg) | 4,
-                    &dp6m_ptr->i960r.edoor_en_reg);
-        writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
-        writeb(0x00, &dp6m_ptr->u.ic.S_Status);
-        writeb(0x00, &dp6m_ptr->u.ic.Cmd_Index);
-
-        writel(pcistr->dpmem, &dp6m_ptr->u.ic.S_Info[0]);
-        writeb(0xff, &dp6m_ptr->u.ic.S_Cmd_Indx);
-        writeb(1, &dp6m_ptr->i960r.ldoor_reg);
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6m_ptr->u.ic.S_Status) != 0xff) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error (DEINIT failed)\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        prot_ver = (u8)readl(&dp6m_ptr->u.ic.S_Info[0]);
-        writeb(0, &dp6m_ptr->u.ic.S_Status);
-        if (prot_ver != PROTOCOL_VERSION) {
-            printk("GDT-PCI: Illegal protocol version\n");
-            iounmap(ha->brd);
-            return 0;
-        }
-
-        ha->type = GDT_PCIMPR;
-        ha->ic_all_size = sizeof(dp6m_ptr->u);
-        
-        /* special command to controller BIOS */
-        writel(0x00, &dp6m_ptr->u.ic.S_Info[0]);
-        writel(0x00, &dp6m_ptr->u.ic.S_Info[1]);
-        writel(0x00, &dp6m_ptr->u.ic.S_Info[2]);
-        writel(0x00, &dp6m_ptr->u.ic.S_Info[3]);
-        writeb(0xfe, &dp6m_ptr->u.ic.S_Cmd_Indx);
-        writeb(1, &dp6m_ptr->i960r.ldoor_reg);
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6m_ptr->u.ic.S_Status) != 0xfe) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        writeb(0, &dp6m_ptr->u.ic.S_Status);
-
-        /* read FW version to detect 64-bit DMA support */
-        writeb(0xfd, &dp6m_ptr->u.ic.S_Cmd_Indx);
-        writeb(1, &dp6m_ptr->i960r.ldoor_reg);
-        retries = INIT_RETRIES;
-        gdth_delay(20);
-        while (readb(&dp6m_ptr->u.ic.S_Status) != 0xfd) {
-            if (--retries == 0) {
-                printk("GDT-PCI: Initialization error (DEINIT failed)\n");
-                iounmap(ha->brd);
-                return 0;
-            }
-            gdth_delay(1);
-        }
-        prot_ver = (u8)(readl(&dp6m_ptr->u.ic.S_Info[0]) >> 16);
-        writeb(0, &dp6m_ptr->u.ic.S_Status);
-        if (prot_ver < 0x2b)      /* FW < x.43: no 64-bit DMA support */
-            ha->dma64_support = 0;
-        else 
-            ha->dma64_support = 1;
-    }
-
-    return 1;
+	register gdt6_dpram_str __iomem *dp6_ptr;
+	register gdt6c_dpram_str __iomem *dp6c_ptr;
+	register gdt6m_dpram_str __iomem *dp6m_ptr;
+	u32 retries;
+	u8 prot_ver;
+	u16 command;
+	int i, found = FALSE;
+
+	TRACE(("gdth_init_pci()\n"));
+
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
+		ha->oem_id = OEM_ID_INTEL;
+	else
+		ha->oem_id = OEM_ID_ICP;
+	ha->brd_phys = (pdev->bus->number << 8) | (pdev->devfn & 0xf8);
+	ha->stype = (u32)pdev->device;
+	ha->irq = pdev->irq;
+	ha->pdev = pdev;
+
+	if (ha->pdev->device <= PCI_DEVICE_ID_VORTEX_GDT6000B) {  /* GDT6000/B */
+		TRACE2(("init_pci() dpmem %lx irq %d\n",pcistr->dpmem,ha->irq));
+		ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6_dpram_str));
+		if (ha->brd == NULL) {
+			printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+			return 0;
+		}
+		/* check and reset interface area */
+		dp6_ptr = ha->brd;
+		writel(DPMEM_MAGIC, &dp6_ptr->u);
+		if (readl(&dp6_ptr->u) != DPMEM_MAGIC) {
+			printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n",
+			       pcistr->dpmem);
+			found = FALSE;
+			for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
+				iounmap(ha->brd);
+				ha->brd = ioremap(i, sizeof(u16));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				if (readw(ha->brd) != 0xffff) {
+					TRACE2(("init_pci_old() address 0x%x busy\n", i));
+					continue;
+				}
+				iounmap(ha->brd);
+				pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, i);
+				ha->brd = ioremap(i, sizeof(gdt6_dpram_str));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				dp6_ptr = ha->brd;
+				writel(DPMEM_MAGIC, &dp6_ptr->u);
+				if (readl(&dp6_ptr->u) == DPMEM_MAGIC) {
+					printk("GDT-PCI: Use free address at 0x%x\n", i);
+					found = TRUE;
+					break;
+				}
+			}
+			if (!found) {
+				printk("GDT-PCI: No free address found!\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+		}
+		memset_io(&dp6_ptr->u, 0, sizeof(dp6_ptr->u));
+		if (readl(&dp6_ptr->u) != 0) {
+			printk("GDT-PCI: Initialization error (DPMEM write error)\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+
+		/* disable board interrupts, deinit services */
+		writeb(0xff, &dp6_ptr->io.irqdel);
+		writeb(0x00, &dp6_ptr->io.irqen);
+		writeb(0x00, &dp6_ptr->u.ic.S_Status);
+		writeb(0x00, &dp6_ptr->u.ic.Cmd_Index);
+
+		writel(pcistr->dpmem, &dp6_ptr->u.ic.S_Info[0]);
+		writeb(0xff, &dp6_ptr->u.ic.S_Cmd_Indx);
+		writeb(0, &dp6_ptr->io.event);
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6_ptr->u.ic.S_Status) != 0xff) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error (DEINIT failed)\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		prot_ver = (u8)readl(&dp6_ptr->u.ic.S_Info[0]);
+		writeb(0, &dp6_ptr->u.ic.S_Status);
+		writeb(0xff, &dp6_ptr->io.irqdel);
+		if (prot_ver != PROTOCOL_VERSION) {
+			printk("GDT-PCI: Illegal protocol version\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+
+		ha->type = GDT_PCI;
+		ha->ic_all_size = sizeof(dp6_ptr->u);
+
+		/* special command to controller BIOS */
+		writel(0x00, &dp6_ptr->u.ic.S_Info[0]);
+		writel(0x00, &dp6_ptr->u.ic.S_Info[1]);
+		writel(0x00, &dp6_ptr->u.ic.S_Info[2]);
+		writel(0x00, &dp6_ptr->u.ic.S_Info[3]);
+		writeb(0xfe, &dp6_ptr->u.ic.S_Cmd_Indx);
+		writeb(0, &dp6_ptr->io.event);
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6_ptr->u.ic.S_Status) != 0xfe) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		writeb(0, &dp6_ptr->u.ic.S_Status);
+		writeb(0xff, &dp6_ptr->io.irqdel);
+
+		ha->dma64_support = 0;
+
+	} else if (ha->pdev->device <= PCI_DEVICE_ID_VORTEX_GDT6555) { /* GDT6110, ... */
+		ha->plx = (gdt6c_plx_regs *)pcistr->io;
+		TRACE2(("init_pci_new() dpmem %lx irq %d\n",
+			pcistr->dpmem,ha->irq));
+		ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6c_dpram_str));
+		if (ha->brd == NULL) {
+			printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+		/* check and reset interface area */
+		dp6c_ptr = ha->brd;
+		writel(DPMEM_MAGIC, &dp6c_ptr->u);
+		if (readl(&dp6c_ptr->u) != DPMEM_MAGIC) {
+			printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n",
+			       pcistr->dpmem);
+			found = FALSE;
+			for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
+				iounmap(ha->brd);
+				ha->brd = ioremap(i, sizeof(u16));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				if (readw(ha->brd) != 0xffff) {
+					TRACE2(("init_pci_plx() address 0x%x busy\n", i));
+					continue;
+				}
+				iounmap(ha->brd);
+				pci_write_config_dword(pdev, PCI_BASE_ADDRESS_2, i);
+				ha->brd = ioremap(i, sizeof(gdt6c_dpram_str));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				dp6c_ptr = ha->brd;
+				writel(DPMEM_MAGIC, &dp6c_ptr->u);
+				if (readl(&dp6c_ptr->u) == DPMEM_MAGIC) {
+					printk("GDT-PCI: Use free address at 0x%x\n", i);
+					found = TRUE;
+					break;
+				}
+			}
+			if (!found) {
+				printk("GDT-PCI: No free address found!\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+		}
+		memset_io(&dp6c_ptr->u, 0, sizeof(dp6c_ptr->u));
+		if (readl(&dp6c_ptr->u) != 0) {
+			printk("GDT-PCI: Initialization error (DPMEM write error)\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+
+		/* disable board interrupts, deinit services */
+		outb(0x00,PTR2USHORT(&ha->plx->control1));
+		outb(0xff,PTR2USHORT(&ha->plx->edoor_reg));
+
+		writeb(0x00, &dp6c_ptr->u.ic.S_Status);
+		writeb(0x00, &dp6c_ptr->u.ic.Cmd_Index);
+
+		writel(pcistr->dpmem, &dp6c_ptr->u.ic.S_Info[0]);
+		writeb(0xff, &dp6c_ptr->u.ic.S_Cmd_Indx);
+
+		outb(1,PTR2USHORT(&ha->plx->ldoor_reg));
+
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6c_ptr->u.ic.S_Status) != 0xff) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error (DEINIT failed)\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		prot_ver = (u8)readl(&dp6c_ptr->u.ic.S_Info[0]);
+		writeb(0, &dp6c_ptr->u.ic.Status);
+		if (prot_ver != PROTOCOL_VERSION) {
+			printk("GDT-PCI: Illegal protocol version\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+
+		ha->type = GDT_PCINEW;
+		ha->ic_all_size = sizeof(dp6c_ptr->u);
+
+		/* special command to controller BIOS */
+		writel(0x00, &dp6c_ptr->u.ic.S_Info[0]);
+		writel(0x00, &dp6c_ptr->u.ic.S_Info[1]);
+		writel(0x00, &dp6c_ptr->u.ic.S_Info[2]);
+		writel(0x00, &dp6c_ptr->u.ic.S_Info[3]);
+		writeb(0xfe, &dp6c_ptr->u.ic.S_Cmd_Indx);
+
+		outb(1,PTR2USHORT(&ha->plx->ldoor_reg));
+
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6c_ptr->u.ic.S_Status) != 0xfe) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		writeb(0, &dp6c_ptr->u.ic.S_Status);
+
+		ha->dma64_support = 0;
+
+	} else {							/* MPR */
+		TRACE2(("init_pci_mpr() dpmem %lx irq %d\n",pcistr->dpmem,ha->irq));
+		ha->brd = ioremap(pcistr->dpmem, sizeof(gdt6m_dpram_str));
+		if (ha->brd == NULL) {
+			printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+			return 0;
+		}
+
+		/* manipulate config. space to enable DPMEM, start RP controller */
+		pci_read_config_word(pdev, PCI_COMMAND, &command);
+		command |= 6;
+		pci_write_config_word(pdev, PCI_COMMAND, command);
+		gdth_delay(1);
+
+		dp6m_ptr = ha->brd;
+
+		/* Ensure that it is safe to access the non HW portions of DPMEM.
+		 * Aditional check needed for Xscale based RAID controllers */
+		while( ((int)readb(&dp6m_ptr->i960r.sema0_reg) ) & 3 )
+			gdth_delay(1);
+
+		/* check and reset interface area */
+		writel(DPMEM_MAGIC, &dp6m_ptr->u);
+		if (readl(&dp6m_ptr->u) != DPMEM_MAGIC) {
+			printk("GDT-PCI: Cannot access DPMEM at 0x%lx (shadowed?)\n",
+			       pcistr->dpmem);
+			found = FALSE;
+			for (i = 0xC8000; i < 0xE8000; i += 0x4000) {
+				iounmap(ha->brd);
+				ha->brd = ioremap(i, sizeof(u16));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				if (readw(ha->brd) != 0xffff) {
+					TRACE2(("init_pci_mpr() address 0x%x busy\n", i));
+					continue;
+				}
+				iounmap(ha->brd);
+				pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, i);
+				ha->brd = ioremap(i, sizeof(gdt6m_dpram_str));
+				if (ha->brd == NULL) {
+					printk("GDT-PCI: Initialization error (DPMEM remap error)\n");
+					return 0;
+				}
+				dp6m_ptr = ha->brd;
+				writel(DPMEM_MAGIC, &dp6m_ptr->u);
+				if (readl(&dp6m_ptr->u) == DPMEM_MAGIC) {
+					printk("GDT-PCI: Use free address at 0x%x\n", i);
+					found = TRUE;
+					break;
+				}
+			}
+			if (!found) {
+				printk("GDT-PCI: No free address found!\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+		}
+		memset_io(&dp6m_ptr->u, 0, sizeof(dp6m_ptr->u));
+
+		/* disable board interrupts, deinit services */
+		writeb(readb(&dp6m_ptr->i960r.edoor_en_reg) | 4,
+		       &dp6m_ptr->i960r.edoor_en_reg);
+		writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
+		writeb(0x00, &dp6m_ptr->u.ic.S_Status);
+		writeb(0x00, &dp6m_ptr->u.ic.Cmd_Index);
+
+		writel(pcistr->dpmem, &dp6m_ptr->u.ic.S_Info[0]);
+		writeb(0xff, &dp6m_ptr->u.ic.S_Cmd_Indx);
+		writeb(1, &dp6m_ptr->i960r.ldoor_reg);
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6m_ptr->u.ic.S_Status) != 0xff) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error (DEINIT failed)\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		prot_ver = (u8)readl(&dp6m_ptr->u.ic.S_Info[0]);
+		writeb(0, &dp6m_ptr->u.ic.S_Status);
+		if (prot_ver != PROTOCOL_VERSION) {
+			printk("GDT-PCI: Illegal protocol version\n");
+			iounmap(ha->brd);
+			return 0;
+		}
+
+		ha->type = GDT_PCIMPR;
+		ha->ic_all_size = sizeof(dp6m_ptr->u);
+
+		/* special command to controller BIOS */
+		writel(0x00, &dp6m_ptr->u.ic.S_Info[0]);
+		writel(0x00, &dp6m_ptr->u.ic.S_Info[1]);
+		writel(0x00, &dp6m_ptr->u.ic.S_Info[2]);
+		writel(0x00, &dp6m_ptr->u.ic.S_Info[3]);
+		writeb(0xfe, &dp6m_ptr->u.ic.S_Cmd_Indx);
+		writeb(1, &dp6m_ptr->i960r.ldoor_reg);
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6m_ptr->u.ic.S_Status) != 0xfe) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		writeb(0, &dp6m_ptr->u.ic.S_Status);
+
+		/* read FW version to detect 64-bit DMA support */
+		writeb(0xfd, &dp6m_ptr->u.ic.S_Cmd_Indx);
+		writeb(1, &dp6m_ptr->i960r.ldoor_reg);
+		retries = INIT_RETRIES;
+		gdth_delay(20);
+		while (readb(&dp6m_ptr->u.ic.S_Status) != 0xfd) {
+			if (--retries == 0) {
+				printk("GDT-PCI: Initialization error (DEINIT failed)\n");
+				iounmap(ha->brd);
+				return 0;
+			}
+			gdth_delay(1);
+		}
+		prot_ver = (u8)(readl(&dp6m_ptr->u.ic.S_Info[0]) >> 16);
+		writeb(0, &dp6m_ptr->u.ic.S_Status);
+		if (prot_ver < 0x2b)      /* FW < x.43: no 64-bit DMA support */
+			ha->dma64_support = 0;
+		else
+			ha->dma64_support = 1;
+	}
+
+	return 1;
 }
 
 /* controller protocol functions */
 
 static void gdth_enable_int(gdth_ha_str *ha)
 {
-    unsigned long flags;
-    gdt6_dpram_str __iomem *dp6_ptr;
-    gdt6m_dpram_str __iomem *dp6m_ptr;
-
-    TRACE(("gdth_enable_int() hanum %d\n",ha->hanum));
-    spin_lock_irqsave(&ha->smp_lock, flags);
-
-    if (ha->type == GDT_PCI) {
-        dp6_ptr = ha->brd;
-        writeb(1, &dp6_ptr->io.irqdel);
-        writeb(0, &dp6_ptr->u.ic.Cmd_Index);
-        writeb(1, &dp6_ptr->io.irqen);
-    } else if (ha->type == GDT_PCINEW) {
-        outb(0xff, PTR2USHORT(&ha->plx->edoor_reg));
-        outb(0x03, PTR2USHORT(&ha->plx->control1));
-    } else if (ha->type == GDT_PCIMPR) {
-        dp6m_ptr = ha->brd;
-        writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
-        writeb(readb(&dp6m_ptr->i960r.edoor_en_reg) & ~4,
-                    &dp6m_ptr->i960r.edoor_en_reg);
-    }
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
+	unsigned long flags;
+	gdt6_dpram_str __iomem *dp6_ptr;
+	gdt6m_dpram_str __iomem *dp6m_ptr;
+
+	TRACE(("gdth_enable_int() hanum %d\n",ha->hanum));
+	spin_lock_irqsave(&ha->smp_lock, flags);
+
+	if (ha->type == GDT_PCI) {
+		dp6_ptr = ha->brd;
+		writeb(1, &dp6_ptr->io.irqdel);
+		writeb(0, &dp6_ptr->u.ic.Cmd_Index);
+		writeb(1, &dp6_ptr->io.irqen);
+	} else if (ha->type == GDT_PCINEW) {
+		outb(0xff, PTR2USHORT(&ha->plx->edoor_reg));
+		outb(0x03, PTR2USHORT(&ha->plx->control1));
+	} else if (ha->type == GDT_PCIMPR) {
+		dp6m_ptr = ha->brd;
+		writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
+		writeb(readb(&dp6m_ptr->i960r.edoor_en_reg) & ~4,
+		       &dp6m_ptr->i960r.edoor_en_reg);
+	}
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
 }
 
 /* return IStatus if interrupt was from this card else 0 */
 static u8 gdth_get_status(gdth_ha_str *ha)
 {
-    u8 IStatus = 0;
+	u8 IStatus = 0;
 
-    TRACE(("gdth_get_status() irq %d ctr_count %d\n", ha->irq, gdth_ctr_count));
+	TRACE(("gdth_get_status() irq %d ctr_count %d\n", ha->irq, gdth_ctr_count));
 
-        if (ha->type == GDT_PCI)
-            IStatus =
-                readb(&((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Cmd_Index);
-        else if (ha->type == GDT_PCINEW) 
-            IStatus = inb(PTR2USHORT(&ha->plx->edoor_reg));
-        else if (ha->type == GDT_PCIMPR)
-            IStatus =
-                readb(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.edoor_reg);
+	if (ha->type == GDT_PCI)
+		IStatus =
+			readb(&((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Cmd_Index);
+	else if (ha->type == GDT_PCINEW)
+		IStatus = inb(PTR2USHORT(&ha->plx->edoor_reg));
+	else if (ha->type == GDT_PCIMPR)
+		IStatus =
+			readb(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.edoor_reg);
 
-        return IStatus;
+	return IStatus;
 }
 
 static int gdth_test_busy(gdth_ha_str *ha)
 {
-    register int gdtsema0 = 0;
+	register int gdtsema0 = 0;
 
-    TRACE(("gdth_test_busy() hanum %d\n", ha->hanum));
+	TRACE(("gdth_test_busy() hanum %d\n", ha->hanum));
 
-    if (ha->type == GDT_PCI)
-        gdtsema0 = (int)readb(&((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Sema0);
-    else if (ha->type == GDT_PCINEW) 
-        gdtsema0 = (int)inb(PTR2USHORT(&ha->plx->sema0_reg));
-    else if (ha->type == GDT_PCIMPR)
-        gdtsema0 = 
-            (int)readb(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.sema0_reg);
+	if (ha->type == GDT_PCI)
+		gdtsema0 = (int)readb(&((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Sema0);
+	else if (ha->type == GDT_PCINEW)
+		gdtsema0 = (int)inb(PTR2USHORT(&ha->plx->sema0_reg));
+	else if (ha->type == GDT_PCIMPR)
+		gdtsema0 =
+			(int)readb(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.sema0_reg);
 
-    return (gdtsema0 & 1);
+	return (gdtsema0 & 1);
 }
 
 
 static int gdth_get_cmd_index(gdth_ha_str *ha)
 {
-    int i;
-
-    TRACE(("gdth_get_cmd_index() hanum %d\n", ha->hanum));
-
-    for (i=0; i<GDTH_MAXCMDS; ++i) {
-        if (ha->cmd_tab[i].cmnd == UNUSED_CMND) {
-            ha->cmd_tab[i].cmnd = ha->pccb->RequestBuffer;
-            ha->cmd_tab[i].service = ha->pccb->Service;
-            ha->pccb->CommandIndex = (u32)i+2;
-            return (i+2);
-        }
-    }
-    return 0;
+	int i;
+
+	TRACE(("gdth_get_cmd_index() hanum %d\n", ha->hanum));
+
+	for (i=0; i<GDTH_MAXCMDS; ++i) {
+		if (ha->cmd_tab[i].cmnd == UNUSED_CMND) {
+			ha->cmd_tab[i].cmnd = ha->pccb->RequestBuffer;
+			ha->cmd_tab[i].service = ha->pccb->Service;
+			ha->pccb->CommandIndex = (u32)i+2;
+			return (i+2);
+		}
+	}
+	return 0;
 }
 
 
 static void gdth_set_sema0(gdth_ha_str *ha)
 {
-    TRACE(("gdth_set_sema0() hanum %d\n", ha->hanum));
-
-    if (ha->type == GDT_PCI) {
-        writeb(1, &((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Sema0);
-    } else if (ha->type == GDT_PCINEW) { 
-        outb(1, PTR2USHORT(&ha->plx->sema0_reg));
-    } else if (ha->type == GDT_PCIMPR) {
-        writeb(1, &((gdt6m_dpram_str __iomem *)ha->brd)->i960r.sema0_reg);
-    }
+	TRACE(("gdth_set_sema0() hanum %d\n", ha->hanum));
+
+	if (ha->type == GDT_PCI) {
+		writeb(1, &((gdt6_dpram_str __iomem *)ha->brd)->u.ic.Sema0);
+	} else if (ha->type == GDT_PCINEW) {
+		outb(1, PTR2USHORT(&ha->plx->sema0_reg));
+	} else if (ha->type == GDT_PCIMPR) {
+		writeb(1, &((gdt6m_dpram_str __iomem *)ha->brd)->i960r.sema0_reg);
+	}
 }
 
 
 static void gdth_copy_command(gdth_ha_str *ha)
 {
-    register gdth_cmd_str *cmd_ptr;
-    register gdt6m_dpram_str __iomem *dp6m_ptr;
-    register gdt6c_dpram_str __iomem *dp6c_ptr;
-    gdt6_dpram_str __iomem *dp6_ptr;
-    u16 cp_count,dp_offset,cmd_no;
-    
-    TRACE(("gdth_copy_command() hanum %d\n", ha->hanum));
-
-    cp_count = ha->cmd_len;
-    dp_offset= ha->cmd_offs_dpmem;
-    cmd_no   = ha->cmd_cnt;
-    cmd_ptr  = ha->pccb;
-
-    ++ha->cmd_cnt;                                                      
-
-    /* set cpcount dword aligned */
-    if (cp_count & 3)
-        cp_count += (4 - (cp_count & 3));
-
-    ha->cmd_offs_dpmem += cp_count;
-    
-    /* set offset and service, copy command to DPMEM */
-    if (ha->type == GDT_PCI) {
-        dp6_ptr = ha->brd;
-        writew(dp_offset + DPMEM_COMMAND_OFFSET,
-                    &dp6_ptr->u.ic.comm_queue[cmd_no].offset);
-        writew((u16)cmd_ptr->Service,
-                    &dp6_ptr->u.ic.comm_queue[cmd_no].serv_id);
-        memcpy_toio(&dp6_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
-    } else if (ha->type == GDT_PCINEW) {
-        dp6c_ptr = ha->brd;
-        writew(dp_offset + DPMEM_COMMAND_OFFSET,
-                    &dp6c_ptr->u.ic.comm_queue[cmd_no].offset);
-        writew((u16)cmd_ptr->Service,
-                    &dp6c_ptr->u.ic.comm_queue[cmd_no].serv_id);
-        memcpy_toio(&dp6c_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
-    } else if (ha->type == GDT_PCIMPR) {
-        dp6m_ptr = ha->brd;
-        writew(dp_offset + DPMEM_COMMAND_OFFSET,
-                    &dp6m_ptr->u.ic.comm_queue[cmd_no].offset);
-        writew((u16)cmd_ptr->Service,
-                    &dp6m_ptr->u.ic.comm_queue[cmd_no].serv_id);
-        memcpy_toio(&dp6m_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
-    }
+	register gdth_cmd_str *cmd_ptr;
+	register gdt6m_dpram_str __iomem *dp6m_ptr;
+	register gdt6c_dpram_str __iomem *dp6c_ptr;
+	gdt6_dpram_str __iomem *dp6_ptr;
+	u16 cp_count,dp_offset,cmd_no;
+
+	TRACE(("gdth_copy_command() hanum %d\n", ha->hanum));
+
+	cp_count = ha->cmd_len;
+	dp_offset= ha->cmd_offs_dpmem;
+	cmd_no   = ha->cmd_cnt;
+	cmd_ptr  = ha->pccb;
+
+	++ha->cmd_cnt;
+
+	/* set cpcount dword aligned */
+	if (cp_count & 3)
+		cp_count += (4 - (cp_count & 3));
+
+	ha->cmd_offs_dpmem += cp_count;
+
+	/* set offset and service, copy command to DPMEM */
+	if (ha->type == GDT_PCI) {
+		dp6_ptr = ha->brd;
+		writew(dp_offset + DPMEM_COMMAND_OFFSET,
+		       &dp6_ptr->u.ic.comm_queue[cmd_no].offset);
+		writew((u16)cmd_ptr->Service,
+		       &dp6_ptr->u.ic.comm_queue[cmd_no].serv_id);
+		memcpy_toio(&dp6_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
+	} else if (ha->type == GDT_PCINEW) {
+		dp6c_ptr = ha->brd;
+		writew(dp_offset + DPMEM_COMMAND_OFFSET,
+		       &dp6c_ptr->u.ic.comm_queue[cmd_no].offset);
+		writew((u16)cmd_ptr->Service,
+		       &dp6c_ptr->u.ic.comm_queue[cmd_no].serv_id);
+		memcpy_toio(&dp6c_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
+	} else if (ha->type == GDT_PCIMPR) {
+		dp6m_ptr = ha->brd;
+		writew(dp_offset + DPMEM_COMMAND_OFFSET,
+		       &dp6m_ptr->u.ic.comm_queue[cmd_no].offset);
+		writew((u16)cmd_ptr->Service,
+		       &dp6m_ptr->u.ic.comm_queue[cmd_no].serv_id);
+		memcpy_toio(&dp6m_ptr->u.ic.gdt_dpr_cmd[dp_offset],cmd_ptr,cp_count);
+	}
 }
 
 
 static void gdth_release_event(gdth_ha_str *ha)
 {
-    TRACE(("gdth_release_event() hanum %d\n", ha->hanum));
+	TRACE(("gdth_release_event() hanum %d\n", ha->hanum));
 
 #ifdef GDTH_STATISTICS
-    {
-        u32 i,j;
-        for (i=0,j=0; j<GDTH_MAXCMDS; ++j) {
-            if (ha->cmd_tab[j].cmnd != UNUSED_CMND)
-                ++i;
-        }
-        if (max_index < i) {
-            max_index = i;
-            TRACE3(("GDT: max_index = %d\n",(u16)i));
-        }
-    }
+	{
+		u32 i,j;
+		for (i=0,j=0; j<GDTH_MAXCMDS; ++j) {
+			if (ha->cmd_tab[j].cmnd != UNUSED_CMND)
+				++i;
+		}
+		if (max_index < i) {
+			max_index = i;
+			TRACE3(("GDT: max_index = %d\n",(u16)i));
+		}
+	}
 #endif
 
-    if (ha->pccb->OpCode == GDT_INIT)
-        ha->pccb->Service |= 0x80;
+	if (ha->pccb->OpCode == GDT_INIT)
+		ha->pccb->Service |= 0x80;
 
-    if (ha->type == GDT_PCI) {
-        writeb(0, &((gdt6_dpram_str __iomem *)ha->brd)->io.event);
-    } else if (ha->type == GDT_PCINEW) { 
-        outb(1, PTR2USHORT(&ha->plx->ldoor_reg));
-    } else if (ha->type == GDT_PCIMPR) {
-        writeb(1, &((gdt6m_dpram_str __iomem *)ha->brd)->i960r.ldoor_reg);
-    }
+	if (ha->type == GDT_PCI) {
+		writeb(0, &((gdt6_dpram_str __iomem *)ha->brd)->io.event);
+	} else if (ha->type == GDT_PCINEW) {
+		outb(1, PTR2USHORT(&ha->plx->ldoor_reg));
+	} else if (ha->type == GDT_PCIMPR) {
+		writeb(1, &((gdt6m_dpram_str __iomem *)ha->brd)->i960r.ldoor_reg);
+	}
 }
 
 static int gdth_wait(gdth_ha_str *ha, int index, u32 time)
 {
-    int answer_found = FALSE;
-    int wait_index = 0;
+	int answer_found = FALSE;
+	int wait_index = 0;
 
-    TRACE(("gdth_wait() hanum %d index %d time %d\n", ha->hanum, index, time));
+	TRACE(("gdth_wait() hanum %d index %d time %d\n", ha->hanum, index, time));
 
-    if (index == 0)
-        return 1;                               /* no wait required */
+	if (index == 0)
+		return 1;			/* no wait required */
 
-    do {
-	__gdth_interrupt(ha, true, &wait_index);
-        if (wait_index == index) {
-            answer_found = TRUE;
-            break;
-        }
-        gdth_delay(1);
-    } while (--time);
+	do {
+		__gdth_interrupt(ha, true, &wait_index);
+		if (wait_index == index) {
+			answer_found = TRUE;
+			break;
+		}
+		gdth_delay(1);
+	} while (--time);
 
-    while (gdth_test_busy(ha))
-        gdth_delay(0);
+	while (gdth_test_busy(ha))
+		gdth_delay(0);
 
-    return (answer_found);
+	return (answer_found);
 }
 
 
 static int gdth_internal_cmd(gdth_ha_str *ha, u8 service, u16 opcode,
-                                            u32 p1, u64 p2, u64 p3)
+			     u32 p1, u64 p2, u64 p3)
 {
-    register gdth_cmd_str *cmd_ptr;
-    int retries,index;
-
-    TRACE2(("gdth_internal_cmd() service %d opcode %d\n",service,opcode));
-
-    cmd_ptr = ha->pccb;
-    memset((char*)cmd_ptr,0,sizeof(gdth_cmd_str));
-
-    /* make command  */
-    for (retries = INIT_RETRIES;;) {
-        cmd_ptr->Service          = service;
-        cmd_ptr->RequestBuffer    = INTERNAL_CMND;
-        if (!(index=gdth_get_cmd_index(ha))) {
-            TRACE(("GDT: No free command index found\n"));
-            return 0;
-        }
-        gdth_set_sema0(ha);
-        cmd_ptr->OpCode           = opcode;
-        cmd_ptr->BoardNode        = LOCALBOARD;
-        if (service == CACHESERVICE) {
-            if (opcode == GDT_IOCTL) {
-                cmd_ptr->u.ioctl.subfunc = p1;
-                cmd_ptr->u.ioctl.channel = (u32)p2;
-                cmd_ptr->u.ioctl.param_size = (u16)p3;
-                cmd_ptr->u.ioctl.p_param = ha->scratch_phys;
-            } else {
-                if (ha->cache_feat & GDT_64BIT) {
-                    cmd_ptr->u.cache64.DeviceNo = (u16)p1;
-                    cmd_ptr->u.cache64.BlockNo  = p2;
-                } else {
-                    cmd_ptr->u.cache.DeviceNo = (u16)p1;
-                    cmd_ptr->u.cache.BlockNo  = (u32)p2;
-                }
-            }
-        } else if (service == SCSIRAWSERVICE) {
-            if (ha->raw_feat & GDT_64BIT) {
-                cmd_ptr->u.raw64.direction  = p1;
-                cmd_ptr->u.raw64.bus        = (u8)p2;
-                cmd_ptr->u.raw64.target     = (u8)p3;
-                cmd_ptr->u.raw64.lun        = (u8)(p3 >> 8);
-            } else {
-                cmd_ptr->u.raw.direction  = p1;
-                cmd_ptr->u.raw.bus        = (u8)p2;
-                cmd_ptr->u.raw.target     = (u8)p3;
-                cmd_ptr->u.raw.lun        = (u8)(p3 >> 8);
-            }
-        } else if (service == SCREENSERVICE) {
-            if (opcode == GDT_REALTIME) {
-                *(u32 *)&cmd_ptr->u.screen.su.data[0] = p1;
-                *(u32 *)&cmd_ptr->u.screen.su.data[4] = (u32)p2;
-                *(u32 *)&cmd_ptr->u.screen.su.data[8] = (u32)p3;
-            }
-        }
-        ha->cmd_len          = sizeof(gdth_cmd_str);
-        ha->cmd_offs_dpmem   = 0;
-        ha->cmd_cnt          = 0;
-        gdth_copy_command(ha);
-        gdth_release_event(ha);
-        gdth_delay(20);
-        if (!gdth_wait(ha, index, INIT_TIMEOUT)) {
-            printk("GDT: Initialization error (timeout service %d)\n",service);
-            return 0;
-        }
-        if (ha->status != S_BSY || --retries == 0)
-            break;
-        gdth_delay(1);   
-    }   
-    
-    return (ha->status != S_OK ? 0:1);
+	register gdth_cmd_str *cmd_ptr;
+	int retries,index;
+
+	TRACE2(("gdth_internal_cmd() service %d opcode %d\n",service,opcode));
+
+	cmd_ptr = ha->pccb;
+	memset((char*)cmd_ptr,0,sizeof(gdth_cmd_str));
+
+	/* make command  */
+	for (retries = INIT_RETRIES;;) {
+		cmd_ptr->Service = service;
+		cmd_ptr->RequestBuffer = INTERNAL_CMND;
+		if (!(index=gdth_get_cmd_index(ha))) {
+			TRACE(("GDT: No free command index found\n"));
+			return 0;
+		}
+		gdth_set_sema0(ha);
+		cmd_ptr->OpCode = opcode;
+		cmd_ptr->BoardNode = LOCALBOARD;
+		if (service == CACHESERVICE) {
+			if (opcode == GDT_IOCTL) {
+				cmd_ptr->u.ioctl.subfunc = p1;
+				cmd_ptr->u.ioctl.channel = (u32)p2;
+				cmd_ptr->u.ioctl.param_size = (u16)p3;
+				cmd_ptr->u.ioctl.p_param = ha->scratch_phys;
+			} else {
+				if (ha->cache_feat & GDT_64BIT) {
+					cmd_ptr->u.cache64.DeviceNo = (u16)p1;
+					cmd_ptr->u.cache64.BlockNo = p2;
+				} else {
+					cmd_ptr->u.cache.DeviceNo = (u16)p1;
+					cmd_ptr->u.cache.BlockNo = (u32)p2;
+				}
+			}
+		} else if (service == SCSIRAWSERVICE) {
+			if (ha->raw_feat & GDT_64BIT) {
+				cmd_ptr->u.raw64.direction = p1;
+				cmd_ptr->u.raw64.bus = (u8)p2;
+				cmd_ptr->u.raw64.target = (u8)p3;
+				cmd_ptr->u.raw64.lun = (u8)(p3 >> 8);
+			} else {
+				cmd_ptr->u.raw.direction = p1;
+				cmd_ptr->u.raw.bus = (u8)p2;
+				cmd_ptr->u.raw.target = (u8)p3;
+				cmd_ptr->u.raw.lun = (u8)(p3 >> 8);
+			}
+		} else if (service == SCREENSERVICE) {
+			if (opcode == GDT_REALTIME) {
+				*(u32 *)&cmd_ptr->u.screen.su.data[0] = p1;
+				*(u32 *)&cmd_ptr->u.screen.su.data[4] = (u32)p2;
+				*(u32 *)&cmd_ptr->u.screen.su.data[8] = (u32)p3;
+			}
+		}
+		ha->cmd_len = sizeof(gdth_cmd_str);
+		ha->cmd_offs_dpmem = 0;
+		ha->cmd_cnt = 0;
+		gdth_copy_command(ha);
+		gdth_release_event(ha);
+		gdth_delay(20);
+		if (!gdth_wait(ha, index, INIT_TIMEOUT)) {
+			printk("GDT: Initialization error (timeout service %d)\n",service);
+			return 0;
+		}
+		if (ha->status != S_BSY || --retries == 0)
+			break;
+		gdth_delay(1);
+	}
+
+	return (ha->status != S_OK ? 0:1);
 }
-    
+
 
 /* search for devices */
 
 static int gdth_search_drives(gdth_ha_str *ha)
 {
-    u16 cdev_cnt, i;
-    int ok;
-    u32 bus_no, drv_cnt, drv_no, j;
-    gdth_getch_str *chn;
-    gdth_drlist_str *drl;
-    gdth_iochan_str *ioc;
-    gdth_raw_iochan_str *iocr;
-    gdth_arcdl_str *alst;
-    gdth_alist_str *alst2;
-    gdth_oem_str_ioctl *oemstr;
-
-    TRACE(("gdth_search_drives() hanum %d\n", ha->hanum));
-    ok = 0;
-
-    /* initialize controller services, at first: screen service */
-    ha->screen_feat = 0;
-    if (!force_dma32) {
-        ok = gdth_internal_cmd(ha, SCREENSERVICE, GDT_X_INIT_SCR, 0, 0, 0);
-        if (ok)
-            ha->screen_feat = GDT_64BIT;
-    }
-    if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
-        ok = gdth_internal_cmd(ha, SCREENSERVICE, GDT_INIT, 0, 0, 0);
-    if (!ok) {
-        printk("GDT-HA %d: Initialization error screen service (code %d)\n",
-               ha->hanum, ha->status);
-        return 0;
-    }
-    TRACE2(("gdth_search_drives(): SCREENSERVICE initialized\n"));
-
-    /* unfreeze all IOs */
-    gdth_internal_cmd(ha, CACHESERVICE, GDT_UNFREEZE_IO, 0, 0, 0);
- 
-    /* initialize cache service */
-    ha->cache_feat = 0;
-    if (!force_dma32) {
-        ok = gdth_internal_cmd(ha, CACHESERVICE, GDT_X_INIT_HOST, LINUX_OS,
-                                                                         0, 0);
-        if (ok)
-            ha->cache_feat = GDT_64BIT;
-    }
-    if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
-        ok = gdth_internal_cmd(ha, CACHESERVICE, GDT_INIT, LINUX_OS, 0, 0);
-    if (!ok) {
-        printk("GDT-HA %d: Initialization error cache service (code %d)\n",
-               ha->hanum, ha->status);
-        return 0;
-    }
-    TRACE2(("gdth_search_drives(): CACHESERVICE initialized\n"));
-    cdev_cnt = (u16)ha->info;
-    ha->fw_vers = ha->service;
-
-    /* detect number of buses - try new IOCTL */
-    iocr = (gdth_raw_iochan_str *)ha->pscratch;
-    iocr->hdr.version        = 0xffffffff;
-    iocr->hdr.list_entries   = MAXBUS;
-    iocr->hdr.first_chan     = 0;
-    iocr->hdr.last_chan      = MAXBUS-1;
-    iocr->hdr.list_offset    = GDTOFFSOF(gdth_raw_iochan_str, list[0]);
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, IOCHAN_RAW_DESC,
-                          INVALID_CHANNEL,sizeof(gdth_raw_iochan_str))) {
-        TRACE2(("IOCHAN_RAW_DESC supported!\n"));
-        ha->bus_cnt = iocr->hdr.chan_count;
-        for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
-            if (iocr->list[bus_no].proc_id < MAXID)
-                ha->bus_id[bus_no] = iocr->list[bus_no].proc_id;
-            else
-                ha->bus_id[bus_no] = 0xff;
-        }
-    } else {
-        /* old method */
-        chn = (gdth_getch_str *)ha->pscratch;
-        for (bus_no = 0; bus_no < MAXBUS; ++bus_no) {
-            chn->channel_no = bus_no;
-            if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                                   SCSI_CHAN_CNT | L_CTRL_PATTERN,
-                                   IO_CHANNEL | INVALID_CHANNEL,
-                                   sizeof(gdth_getch_str))) {
-                if (bus_no == 0) {
-                    printk("GDT-HA %d: Error detecting channel count (0x%x)\n",
-                           ha->hanum, ha->status);
-                    return 0;
-                }
-                break;
-            }
-            if (chn->siop_id < MAXID)
-                ha->bus_id[bus_no] = chn->siop_id;
-            else
-                ha->bus_id[bus_no] = 0xff;
-        }       
-        ha->bus_cnt = (u8)bus_no;
-    }
-    TRACE2(("gdth_search_drives() %d channels\n",ha->bus_cnt));
-
-    /* read cache configuration */
-    if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_INFO,
-                           INVALID_CHANNEL,sizeof(gdth_cinfo_str))) {
-        printk("GDT-HA %d: Initialization error cache service (code %d)\n",
-               ha->hanum, ha->status);
-        return 0;
-    }
-    ha->cpar = ((gdth_cinfo_str *)ha->pscratch)->cpar;
-    TRACE2(("gdth_search_drives() cinfo: vs %x sta %d str %d dw %d b %d\n",
-            ha->cpar.version,ha->cpar.state,ha->cpar.strategy,
-            ha->cpar.write_back,ha->cpar.block_size));
-
-    /* read board info and features */
-    ha->more_proc = FALSE;
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, BOARD_INFO,
-                          INVALID_CHANNEL,sizeof(gdth_binfo_str))) {
-        memcpy(&ha->binfo, (gdth_binfo_str *)ha->pscratch,
-               sizeof(gdth_binfo_str));
-        if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, BOARD_FEATURES,
-                              INVALID_CHANNEL,sizeof(gdth_bfeat_str))) {
-            TRACE2(("BOARD_INFO/BOARD_FEATURES supported\n"));
-            ha->bfeat = *(gdth_bfeat_str *)ha->pscratch;
-            ha->more_proc = TRUE;
-        }
-    } else {
-        TRACE2(("BOARD_INFO requires firmware >= 1.10/2.08\n"));
-        strcpy(ha->binfo.type_string, gdth_ctr_name(ha));
-    }
-    TRACE2(("Controller name: %s\n",ha->binfo.type_string));
-
-    /* read more informations */
-    if (ha->more_proc) {
-        /* physical drives, channel addresses */
-        ioc = (gdth_iochan_str *)ha->pscratch;
-        ioc->hdr.version        = 0xffffffff;
-        ioc->hdr.list_entries   = MAXBUS;
-        ioc->hdr.first_chan     = 0;
-        ioc->hdr.last_chan      = MAXBUS-1;
-        ioc->hdr.list_offset    = GDTOFFSOF(gdth_iochan_str, list[0]);
-        if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, IOCHAN_DESC,
-                              INVALID_CHANNEL,sizeof(gdth_iochan_str))) {
-            for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
-                ha->raw[bus_no].address = ioc->list[bus_no].address;
-                ha->raw[bus_no].local_no = ioc->list[bus_no].local_no;
-            }
-        } else {
-            for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
-                ha->raw[bus_no].address = IO_CHANNEL;
-                ha->raw[bus_no].local_no = bus_no;
-            }
-        }
-        for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
-            chn = (gdth_getch_str *)ha->pscratch;
-            chn->channel_no = ha->raw[bus_no].local_no;
-            if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                                  SCSI_CHAN_CNT | L_CTRL_PATTERN,
-                                  ha->raw[bus_no].address | INVALID_CHANNEL,
-                                  sizeof(gdth_getch_str))) {
-                ha->raw[bus_no].pdev_cnt = chn->drive_cnt;
-                TRACE2(("Channel %d: %d phys. drives\n",
-                        bus_no,chn->drive_cnt));
-            }
-            if (ha->raw[bus_no].pdev_cnt > 0) {
-                drl = (gdth_drlist_str *)ha->pscratch;
-                drl->sc_no = ha->raw[bus_no].local_no;
-                drl->sc_cnt = ha->raw[bus_no].pdev_cnt;
-                if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                                      SCSI_DR_LIST | L_CTRL_PATTERN,
-                                      ha->raw[bus_no].address | INVALID_CHANNEL,
-                                      sizeof(gdth_drlist_str))) {
-                    for (j = 0; j < ha->raw[bus_no].pdev_cnt; ++j) 
-                        ha->raw[bus_no].id_list[j] = drl->sc_list[j];
-                } else {
-                    ha->raw[bus_no].pdev_cnt = 0;
-                }
-            }
-        }
-
-        /* logical drives */
-        if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_DRV_CNT,
-                              INVALID_CHANNEL,sizeof(u32))) {
-            drv_cnt = *(u32 *)ha->pscratch;
-            if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_DRV_LIST,
-                                  INVALID_CHANNEL,drv_cnt * sizeof(u32))) {
-                for (j = 0; j < drv_cnt; ++j) {
-                    drv_no = ((u32 *)ha->pscratch)[j];
-                    if (drv_no < MAX_LDRIVES) {
-                        ha->hdr[drv_no].is_logdrv = TRUE;
-                        TRACE2(("Drive %d is log. drive\n",drv_no));
-                    }
-                }
-            }
-            alst = (gdth_arcdl_str *)ha->pscratch;
-            alst->entries_avail = MAX_LDRIVES;
-            alst->first_entry = 0;
-            alst->list_offset = GDTOFFSOF(gdth_arcdl_str, list[0]);
-            if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                                  ARRAY_DRV_LIST2 | LA_CTRL_PATTERN, 
-                                  INVALID_CHANNEL, sizeof(gdth_arcdl_str) +
-                                  (alst->entries_avail-1) * sizeof(gdth_alist_str))) { 
-                for (j = 0; j < alst->entries_init; ++j) {
-                    ha->hdr[j].is_arraydrv = alst->list[j].is_arrayd;
-                    ha->hdr[j].is_master = alst->list[j].is_master;
-                    ha->hdr[j].is_parity = alst->list[j].is_parity;
-                    ha->hdr[j].is_hotfix = alst->list[j].is_hotfix;
-                    ha->hdr[j].master_no = alst->list[j].cd_handle;
-                }
-            } else if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                                         ARRAY_DRV_LIST | LA_CTRL_PATTERN,
-                                         0, 35 * sizeof(gdth_alist_str))) {
-                for (j = 0; j < 35; ++j) {
-                    alst2 = &((gdth_alist_str *)ha->pscratch)[j];
-                    ha->hdr[j].is_arraydrv = alst2->is_arrayd;
-                    ha->hdr[j].is_master = alst2->is_master;
-                    ha->hdr[j].is_parity = alst2->is_parity;
-                    ha->hdr[j].is_hotfix = alst2->is_hotfix;
-                    ha->hdr[j].master_no = alst2->cd_handle;
-                }
-            }
-        }
-    }       
-                                  
-    /* initialize raw service */
-    ha->raw_feat = 0;
-    if (!force_dma32) {
-        ok = gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_X_INIT_RAW, 0, 0, 0);
-        if (ok)
-            ha->raw_feat = GDT_64BIT;
-    }
-    if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
-        ok = gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_INIT, 0, 0, 0);
-    if (!ok) {
-        printk("GDT-HA %d: Initialization error raw service (code %d)\n",
-               ha->hanum, ha->status);
-        return 0;
-    }
-    TRACE2(("gdth_search_drives(): RAWSERVICE initialized\n"));
-
-    /* set/get features raw service (scatter/gather) */
-    if (gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_SET_FEAT, SCATTER_GATHER,
-                          0, 0)) {
-        TRACE2(("gdth_search_drives(): set features RAWSERVICE OK\n"));
-        if (gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_GET_FEAT, 0, 0, 0)) {
-            TRACE2(("gdth_search_dr(): get feat RAWSERVICE %d\n",
-                    ha->info));
-            ha->raw_feat |= (u16)ha->info;
-        }
-    } 
-
-    /* set/get features cache service (equal to raw service) */
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_SET_FEAT, 0,
-                          SCATTER_GATHER,0)) {
-        TRACE2(("gdth_search_drives(): set features CACHESERVICE OK\n"));
-        if (gdth_internal_cmd(ha, CACHESERVICE, GDT_GET_FEAT, 0, 0, 0)) {
-            TRACE2(("gdth_search_dr(): get feat CACHESERV. %d\n",
-                    ha->info));
-            ha->cache_feat |= (u16)ha->info;
-        }
-    }
-
-    /* reserve drives for raw service */
-    if (reserve_mode != 0) {
-        gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESERVE_ALL,
-                          reserve_mode == 1 ? 1 : 3, 0, 0);
-        TRACE2(("gdth_search_drives(): RESERVE_ALL code %d\n", 
-                ha->status));
-    }
-    for (i = 0; i < MAX_RES_ARGS; i += 4) {
-        if (reserve_list[i] == ha->hanum && reserve_list[i+1] < ha->bus_cnt &&
-            reserve_list[i+2] < ha->tid_cnt && reserve_list[i+3] < MAXLUN) {
-            TRACE2(("gdth_search_drives(): reserve ha %d bus %d id %d lun %d\n",
-                    reserve_list[i], reserve_list[i+1],
-                    reserve_list[i+2], reserve_list[i+3]));
-            if (!gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESERVE, 0,
-                                   reserve_list[i+1], reserve_list[i+2] | 
-                                   (reserve_list[i+3] << 8))) {
-                printk("GDT-HA %d: Error raw service (RESERVE, code %d)\n",
-                       ha->hanum, ha->status);
-             }
-        }
-    }
-
-    /* Determine OEM string using IOCTL */
-    oemstr = (gdth_oem_str_ioctl *)ha->pscratch;
-    oemstr->params.ctl_version = 0x01;
-    oemstr->params.buffer_size = sizeof(oemstr->text);
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
-                          CACHE_READ_OEM_STRING_RECORD,INVALID_CHANNEL,
-                          sizeof(gdth_oem_str_ioctl))) {
-        TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD OK\n"));
-        printk("GDT-HA %d: Vendor: %s Name: %s\n",
-               ha->hanum, oemstr->text.oem_company_name, ha->binfo.type_string);
-        /* Save the Host Drive inquiry data */
-        strlcpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,
-                sizeof(ha->oem_name));
-    } else {
-        /* Old method, based on PCI ID */
-        TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD failed\n"));
-        printk("GDT-HA %d: Name: %s\n",
-               ha->hanum, ha->binfo.type_string);
-        if (ha->oem_id == OEM_ID_INTEL)
-            strlcpy(ha->oem_name,"Intel  ", sizeof(ha->oem_name));
-        else
-            strlcpy(ha->oem_name,"ICP    ", sizeof(ha->oem_name));
-    }
-
-    /* scanning for host drives */
-    for (i = 0; i < cdev_cnt; ++i) 
-        gdth_analyse_hdrive(ha, i);
-    
-    TRACE(("gdth_search_drives() OK\n"));
-    return 1;
+	u16 cdev_cnt, i;
+	int ok;
+	u32 bus_no, drv_cnt, drv_no, j;
+	gdth_getch_str *chn;
+	gdth_drlist_str *drl;
+	gdth_iochan_str *ioc;
+	gdth_raw_iochan_str *iocr;
+	gdth_arcdl_str *alst;
+	gdth_alist_str *alst2;
+	gdth_oem_str_ioctl *oemstr;
+
+	TRACE(("gdth_search_drives() hanum %d\n", ha->hanum));
+	ok = 0;
+
+	/* initialize controller services, at first: screen service */
+	ha->screen_feat = 0;
+	if (!force_dma32) {
+		ok = gdth_internal_cmd(ha, SCREENSERVICE, GDT_X_INIT_SCR, 0, 0, 0);
+		if (ok)
+			ha->screen_feat = GDT_64BIT;
+	}
+	if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
+		ok = gdth_internal_cmd(ha, SCREENSERVICE, GDT_INIT, 0, 0, 0);
+	if (!ok) {
+		printk("GDT-HA %d: Initialization error screen service (code %d)\n",
+		       ha->hanum, ha->status);
+		return 0;
+	}
+	TRACE2(("gdth_search_drives(): SCREENSERVICE initialized\n"));
+
+	/* unfreeze all IOs */
+	gdth_internal_cmd(ha, CACHESERVICE, GDT_UNFREEZE_IO, 0, 0, 0);
+
+	/* initialize cache service */
+	ha->cache_feat = 0;
+	if (!force_dma32) {
+		ok = gdth_internal_cmd(ha, CACHESERVICE, GDT_X_INIT_HOST, LINUX_OS,
+				       0, 0);
+		if (ok)
+			ha->cache_feat = GDT_64BIT;
+	}
+	if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
+		ok = gdth_internal_cmd(ha, CACHESERVICE, GDT_INIT, LINUX_OS, 0, 0);
+	if (!ok) {
+		printk("GDT-HA %d: Initialization error cache service (code %d)\n",
+		       ha->hanum, ha->status);
+		return 0;
+	}
+	TRACE2(("gdth_search_drives(): CACHESERVICE initialized\n"));
+	cdev_cnt = (u16)ha->info;
+	ha->fw_vers = ha->service;
+
+	/* detect number of buses - try new IOCTL */
+	iocr = (gdth_raw_iochan_str *)ha->pscratch;
+	iocr->hdr.version = 0xffffffff;
+	iocr->hdr.list_entries = MAXBUS;
+	iocr->hdr.first_chan = 0;
+	iocr->hdr.last_chan = MAXBUS-1;
+	iocr->hdr.list_offset = GDTOFFSOF(gdth_raw_iochan_str, list[0]);
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, IOCHAN_RAW_DESC,
+			      INVALID_CHANNEL,sizeof(gdth_raw_iochan_str))) {
+		TRACE2(("IOCHAN_RAW_DESC supported!\n"));
+		ha->bus_cnt = iocr->hdr.chan_count;
+		for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
+			if (iocr->list[bus_no].proc_id < MAXID)
+				ha->bus_id[bus_no] = iocr->list[bus_no].proc_id;
+			else
+				ha->bus_id[bus_no] = 0xff;
+		}
+	} else {
+		/* old method */
+		chn = (gdth_getch_str *)ha->pscratch;
+		for (bus_no = 0; bus_no < MAXBUS; ++bus_no) {
+			chn->channel_no = bus_no;
+			if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+					       SCSI_CHAN_CNT | L_CTRL_PATTERN,
+					       IO_CHANNEL | INVALID_CHANNEL,
+					       sizeof(gdth_getch_str))) {
+				if (bus_no == 0) {
+					printk("GDT-HA %d: Error detecting channel count (0x%x)\n",
+					       ha->hanum, ha->status);
+					return 0;
+				}
+				break;
+			}
+			if (chn->siop_id < MAXID)
+				ha->bus_id[bus_no] = chn->siop_id;
+			else
+				ha->bus_id[bus_no] = 0xff;
+		}
+		ha->bus_cnt = (u8)bus_no;
+	}
+	TRACE2(("gdth_search_drives() %d channels\n",ha->bus_cnt));
+
+	/* read cache configuration */
+	if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_INFO,
+			       INVALID_CHANNEL,sizeof(gdth_cinfo_str))) {
+		printk("GDT-HA %d: Initialization error cache service (code %d)\n",
+		       ha->hanum, ha->status);
+		return 0;
+	}
+	ha->cpar = ((gdth_cinfo_str *)ha->pscratch)->cpar;
+	TRACE2(("gdth_search_drives() cinfo: vs %x sta %d str %d dw %d b %d\n",
+		ha->cpar.version,ha->cpar.state,ha->cpar.strategy,
+		ha->cpar.write_back,ha->cpar.block_size));
+
+	/* read board info and features */
+	ha->more_proc = FALSE;
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, BOARD_INFO,
+			      INVALID_CHANNEL,sizeof(gdth_binfo_str))) {
+		memcpy(&ha->binfo, (gdth_binfo_str *)ha->pscratch,
+		       sizeof(gdth_binfo_str));
+		if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, BOARD_FEATURES,
+				      INVALID_CHANNEL,sizeof(gdth_bfeat_str))) {
+			TRACE2(("BOARD_INFO/BOARD_FEATURES supported\n"));
+			ha->bfeat = *(gdth_bfeat_str *)ha->pscratch;
+			ha->more_proc = TRUE;
+		}
+	} else {
+		TRACE2(("BOARD_INFO requires firmware >= 1.10/2.08\n"));
+		strcpy(ha->binfo.type_string, gdth_ctr_name(ha));
+	}
+	TRACE2(("Controller name: %s\n",ha->binfo.type_string));
+
+	/* read more informations */
+	if (ha->more_proc) {
+		/* physical drives, channel addresses */
+		ioc = (gdth_iochan_str *)ha->pscratch;
+		ioc->hdr.version = 0xffffffff;
+		ioc->hdr.list_entries = MAXBUS;
+		ioc->hdr.first_chan = 0;
+		ioc->hdr.last_chan = MAXBUS-1;
+		ioc->hdr.list_offset = GDTOFFSOF(gdth_iochan_str, list[0]);
+		if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, IOCHAN_DESC,
+				      INVALID_CHANNEL,sizeof(gdth_iochan_str))) {
+			for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
+				ha->raw[bus_no].address = ioc->list[bus_no].address;
+				ha->raw[bus_no].local_no = ioc->list[bus_no].local_no;
+			}
+		} else {
+			for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
+				ha->raw[bus_no].address = IO_CHANNEL;
+				ha->raw[bus_no].local_no = bus_no;
+			}
+		}
+		for (bus_no = 0; bus_no < ha->bus_cnt; ++bus_no) {
+			chn = (gdth_getch_str *)ha->pscratch;
+			chn->channel_no = ha->raw[bus_no].local_no;
+			if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+					      SCSI_CHAN_CNT | L_CTRL_PATTERN,
+					      ha->raw[bus_no].address | INVALID_CHANNEL,
+					      sizeof(gdth_getch_str))) {
+				ha->raw[bus_no].pdev_cnt = chn->drive_cnt;
+				TRACE2(("Channel %d: %d phys. drives\n",
+					bus_no,chn->drive_cnt));
+			}
+			if (ha->raw[bus_no].pdev_cnt > 0) {
+				drl = (gdth_drlist_str *)ha->pscratch;
+				drl->sc_no = ha->raw[bus_no].local_no;
+				drl->sc_cnt = ha->raw[bus_no].pdev_cnt;
+				if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+						      SCSI_DR_LIST | L_CTRL_PATTERN,
+						      ha->raw[bus_no].address | INVALID_CHANNEL,
+						      sizeof(gdth_drlist_str))) {
+					for (j = 0; j < ha->raw[bus_no].pdev_cnt; ++j)
+						ha->raw[bus_no].id_list[j] = drl->sc_list[j];
+				} else {
+					ha->raw[bus_no].pdev_cnt = 0;
+				}
+			}
+		}
+
+		/* logical drives */
+		if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_DRV_CNT,
+				      INVALID_CHANNEL,sizeof(u32))) {
+			drv_cnt = *(u32 *)ha->pscratch;
+			if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL, CACHE_DRV_LIST,
+					      INVALID_CHANNEL,drv_cnt * sizeof(u32))) {
+				for (j = 0; j < drv_cnt; ++j) {
+					drv_no = ((u32 *)ha->pscratch)[j];
+					if (drv_no < MAX_LDRIVES) {
+						ha->hdr[drv_no].is_logdrv = TRUE;
+						TRACE2(("Drive %d is log. drive\n",drv_no));
+					}
+				}
+			}
+			alst = (gdth_arcdl_str *)ha->pscratch;
+			alst->entries_avail = MAX_LDRIVES;
+			alst->first_entry = 0;
+			alst->list_offset = GDTOFFSOF(gdth_arcdl_str, list[0]);
+			if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+					      ARRAY_DRV_LIST2 | LA_CTRL_PATTERN,
+					      INVALID_CHANNEL, sizeof(gdth_arcdl_str) +
+					      (alst->entries_avail-1) * sizeof(gdth_alist_str))) {
+				for (j = 0; j < alst->entries_init; ++j) {
+					ha->hdr[j].is_arraydrv = alst->list[j].is_arrayd;
+					ha->hdr[j].is_master = alst->list[j].is_master;
+					ha->hdr[j].is_parity = alst->list[j].is_parity;
+					ha->hdr[j].is_hotfix = alst->list[j].is_hotfix;
+					ha->hdr[j].master_no = alst->list[j].cd_handle;
+				}
+			} else if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+						     ARRAY_DRV_LIST | LA_CTRL_PATTERN,
+						     0, 35 * sizeof(gdth_alist_str))) {
+				for (j = 0; j < 35; ++j) {
+					alst2 = &((gdth_alist_str *)ha->pscratch)[j];
+					ha->hdr[j].is_arraydrv = alst2->is_arrayd;
+					ha->hdr[j].is_master = alst2->is_master;
+					ha->hdr[j].is_parity = alst2->is_parity;
+					ha->hdr[j].is_hotfix = alst2->is_hotfix;
+					ha->hdr[j].master_no = alst2->cd_handle;
+				}
+			}
+		}
+	}
+
+	/* initialize raw service */
+	ha->raw_feat = 0;
+	if (!force_dma32) {
+		ok = gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_X_INIT_RAW, 0, 0, 0);
+		if (ok)
+			ha->raw_feat = GDT_64BIT;
+	}
+	if (force_dma32 || (!ok && ha->status == (u16)S_NOFUNC))
+		ok = gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_INIT, 0, 0, 0);
+	if (!ok) {
+		printk("GDT-HA %d: Initialization error raw service (code %d)\n",
+		       ha->hanum, ha->status);
+		return 0;
+	}
+	TRACE2(("gdth_search_drives(): RAWSERVICE initialized\n"));
+
+	/* set/get features raw service (scatter/gather) */
+	if (gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_SET_FEAT, SCATTER_GATHER,
+			      0, 0)) {
+		TRACE2(("gdth_search_drives(): set features RAWSERVICE OK\n"));
+		if (gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_GET_FEAT, 0, 0, 0)) {
+			TRACE2(("gdth_search_dr(): get feat RAWSERVICE %d\n",
+				ha->info));
+			ha->raw_feat |= (u16)ha->info;
+		}
+	}
+
+	/* set/get features cache service (equal to raw service) */
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_SET_FEAT, 0,
+			      SCATTER_GATHER,0)) {
+		TRACE2(("gdth_search_drives(): set features CACHESERVICE OK\n"));
+		if (gdth_internal_cmd(ha, CACHESERVICE, GDT_GET_FEAT, 0, 0, 0)) {
+			TRACE2(("gdth_search_dr(): get feat CACHESERV. %d\n",
+				ha->info));
+			ha->cache_feat |= (u16)ha->info;
+		}
+	}
+
+	/* reserve drives for raw service */
+	if (reserve_mode != 0) {
+		gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESERVE_ALL,
+				  reserve_mode == 1 ? 1 : 3, 0, 0);
+		TRACE2(("gdth_search_drives(): RESERVE_ALL code %d\n",
+			ha->status));
+	}
+	for (i = 0; i < MAX_RES_ARGS; i += 4) {
+		if (reserve_list[i] == ha->hanum && reserve_list[i+1] < ha->bus_cnt &&
+		    reserve_list[i+2] < ha->tid_cnt && reserve_list[i+3] < MAXLUN) {
+			TRACE2(("gdth_search_drives(): reserve ha %d bus %d id %d lun %d\n",
+				reserve_list[i], reserve_list[i+1],
+				reserve_list[i+2], reserve_list[i+3]));
+			if (!gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESERVE, 0,
+					       reserve_list[i+1], reserve_list[i+2] |
+					       (reserve_list[i+3] << 8))) {
+				printk("GDT-HA %d: Error raw service (RESERVE, code %d)\n",
+				       ha->hanum, ha->status);
+			}
+		}
+	}
+
+	/* Determine OEM string using IOCTL */
+	oemstr = (gdth_oem_str_ioctl *)ha->pscratch;
+	oemstr->params.ctl_version = 0x01;
+	oemstr->params.buffer_size = sizeof(oemstr->text);
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_IOCTL,
+			      CACHE_READ_OEM_STRING_RECORD,INVALID_CHANNEL,
+			      sizeof(gdth_oem_str_ioctl))) {
+		TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD OK\n"));
+		printk("GDT-HA %d: Vendor: %s Name: %s\n",
+		       ha->hanum, oemstr->text.oem_company_name, ha->binfo.type_string);
+		/* Save the Host Drive inquiry data */
+		strlcpy(ha->oem_name,oemstr->text.scsi_host_drive_inquiry_vendor_id,
+			sizeof(ha->oem_name));
+	} else {
+		/* Old method, based on PCI ID */
+		TRACE2(("gdth_search_drives(): CACHE_READ_OEM_STRING_RECORD failed\n"));
+		printk("GDT-HA %d: Name: %s\n",
+		       ha->hanum, ha->binfo.type_string);
+		if (ha->oem_id == OEM_ID_INTEL)
+			strlcpy(ha->oem_name,"Intel  ", sizeof(ha->oem_name));
+		else
+			strlcpy(ha->oem_name,"ICP    ", sizeof(ha->oem_name));
+	}
+
+	/* scanning for host drives */
+	for (i = 0; i < cdev_cnt; ++i)
+		gdth_analyse_hdrive(ha, i);
+
+	TRACE(("gdth_search_drives() OK\n"));
+	return 1;
 }
 
 static int gdth_analyse_hdrive(gdth_ha_str *ha, u16 hdrive)
 {
-    u32 drv_cyls;
-    int drv_hds, drv_secs;
-
-    TRACE(("gdth_analyse_hdrive() hanum %d drive %d\n", ha->hanum, hdrive));
-    if (hdrive >= MAX_HDRIVES)
-        return 0;
-
-    if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_INFO, hdrive, 0, 0))
-        return 0;
-    ha->hdr[hdrive].present = TRUE;
-    ha->hdr[hdrive].size = ha->info;
-   
-    /* evaluate mapping (sectors per head, heads per cylinder) */
-    ha->hdr[hdrive].size &= ~SECS32;
-    if (ha->info2 == 0) {
-        gdth_eval_mapping(ha->hdr[hdrive].size,&drv_cyls,&drv_hds,&drv_secs);
-    } else {
-        drv_hds = ha->info2 & 0xff;
-        drv_secs = (ha->info2 >> 8) & 0xff;
-        drv_cyls = (u32)ha->hdr[hdrive].size / drv_hds / drv_secs;
-    }
-    ha->hdr[hdrive].heads = (u8)drv_hds;
-    ha->hdr[hdrive].secs  = (u8)drv_secs;
-    /* round size */
-    ha->hdr[hdrive].size  = drv_cyls * drv_hds * drv_secs;
-    
-    if (ha->cache_feat & GDT_64BIT) {
-        if (gdth_internal_cmd(ha, CACHESERVICE, GDT_X_INFO, hdrive, 0, 0)
-            && ha->info2 != 0) {
-            ha->hdr[hdrive].size = ((u64)ha->info2 << 32) | ha->info;
-        }
-    }
-    TRACE2(("gdth_search_dr() cdr. %d size %d hds %d scs %d\n",
-            hdrive,ha->hdr[hdrive].size,drv_hds,drv_secs));
-
-    /* get informations about device */
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_DEVTYPE, hdrive, 0, 0)) {
-        TRACE2(("gdth_search_dr() cache drive %d devtype %d\n",
-                hdrive,ha->info));
-        ha->hdr[hdrive].devtype = (u16)ha->info;
-    }
-
-    /* cluster info */
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_CLUST_INFO, hdrive, 0, 0)) {
-        TRACE2(("gdth_search_dr() cache drive %d cluster info %d\n",
-                hdrive,ha->info));
-        if (!shared_access)
-            ha->hdr[hdrive].cluster_type = (u8)ha->info;
-    }
-
-    /* R/W attributes */
-    if (gdth_internal_cmd(ha, CACHESERVICE, GDT_RW_ATTRIBS, hdrive, 0, 0)) {
-        TRACE2(("gdth_search_dr() cache drive %d r/w attrib. %d\n",
-                hdrive,ha->info));
-        ha->hdr[hdrive].rw_attribs = (u8)ha->info;
-    }
-
-    return 1;
+	u32 drv_cyls;
+	int drv_hds, drv_secs;
+
+	TRACE(("gdth_analyse_hdrive() hanum %d drive %d\n", ha->hanum, hdrive));
+	if (hdrive >= MAX_HDRIVES)
+		return 0;
+
+	if (!gdth_internal_cmd(ha, CACHESERVICE, GDT_INFO, hdrive, 0, 0))
+		return 0;
+	ha->hdr[hdrive].present = TRUE;
+	ha->hdr[hdrive].size = ha->info;
+
+	/* evaluate mapping (sectors per head, heads per cylinder) */
+	ha->hdr[hdrive].size &= ~SECS32;
+	if (ha->info2 == 0) {
+		gdth_eval_mapping(ha->hdr[hdrive].size,&drv_cyls,&drv_hds,&drv_secs);
+	} else {
+		drv_hds = ha->info2 & 0xff;
+		drv_secs = (ha->info2 >> 8) & 0xff;
+		drv_cyls = (u32)ha->hdr[hdrive].size / drv_hds / drv_secs;
+	}
+	ha->hdr[hdrive].heads = (u8)drv_hds;
+	ha->hdr[hdrive].secs  = (u8)drv_secs;
+	/* round size */
+	ha->hdr[hdrive].size  = drv_cyls * drv_hds * drv_secs;
+
+	if (ha->cache_feat & GDT_64BIT) {
+		if (gdth_internal_cmd(ha, CACHESERVICE, GDT_X_INFO, hdrive, 0, 0)
+		    && ha->info2 != 0) {
+			ha->hdr[hdrive].size = ((u64)ha->info2 << 32) | ha->info;
+		}
+	}
+	TRACE2(("gdth_search_dr() cdr. %d size %d hds %d scs %d\n",
+		hdrive,ha->hdr[hdrive].size,drv_hds,drv_secs));
+
+	/* get informations about device */
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_DEVTYPE, hdrive, 0, 0)) {
+		TRACE2(("gdth_search_dr() cache drive %d devtype %d\n",
+			hdrive,ha->info));
+		ha->hdr[hdrive].devtype = (u16)ha->info;
+	}
+
+	/* cluster info */
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_CLUST_INFO, hdrive, 0, 0)) {
+		TRACE2(("gdth_search_dr() cache drive %d cluster info %d\n",
+			hdrive,ha->info));
+		if (!shared_access)
+			ha->hdr[hdrive].cluster_type = (u8)ha->info;
+	}
+
+	/* R/W attributes */
+	if (gdth_internal_cmd(ha, CACHESERVICE, GDT_RW_ATTRIBS, hdrive, 0, 0)) {
+		TRACE2(("gdth_search_dr() cache drive %d r/w attrib. %d\n",
+			hdrive,ha->info));
+		ha->hdr[hdrive].rw_attribs = (u8)ha->info;
+	}
+
+	return 1;
 }
 
 
@@ -1535,291 +1540,300 @@ static int gdth_analyse_hdrive(gdth_ha_str *ha, u16 hdrive)
 
 static void gdth_putq(gdth_ha_str *ha, struct scsi_cmnd *scp, u8 priority)
 {
-    struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
-    register struct scsi_cmnd *pscp;
-    register struct scsi_cmnd *nscp;
-    unsigned long flags;
-
-    TRACE(("gdth_putq() priority %d\n",priority));
-    spin_lock_irqsave(&ha->smp_lock, flags);
-
-    if (!cmndinfo->internal_command)
-        cmndinfo->priority = priority;
-
-    if (ha->req_first==NULL) {
-        ha->req_first = scp;                    /* queue was empty */
-        scp->SCp.ptr = NULL;
-    } else {                                    /* queue not empty */
-        pscp = ha->req_first;
-        nscp = (struct scsi_cmnd *)pscp->SCp.ptr;
-        /* priority: 0-highest,..,0xff-lowest */
-        while (nscp && gdth_cmnd_priv(nscp)->priority <= priority) {
-            pscp = nscp;
-            nscp = (struct scsi_cmnd *)pscp->SCp.ptr;
-        }
-        pscp->SCp.ptr = (char *)scp;
-        scp->SCp.ptr  = (char *)nscp;
-    }
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
+	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
+	register struct scsi_cmnd *pscp;
+	register struct scsi_cmnd *nscp;
+	unsigned long flags;
+
+	TRACE(("gdth_putq() priority %d\n",priority));
+	spin_lock_irqsave(&ha->smp_lock, flags);
+
+	if (!cmndinfo->internal_command)
+		cmndinfo->priority = priority;
+
+	if (ha->req_first==NULL) {
+		/* queue was empty */
+		ha->req_first = scp;
+		scp->SCp.ptr = NULL;
+	} else {
+		/* queue not empty */
+		pscp = ha->req_first;
+		nscp = (struct scsi_cmnd *)pscp->SCp.ptr;
+		/* priority: 0-highest,..,0xff-lowest */
+		while (nscp && gdth_cmnd_priv(nscp)->priority <= priority) {
+			pscp = nscp;
+			nscp = (struct scsi_cmnd *)pscp->SCp.ptr;
+		}
+		pscp->SCp.ptr = (char *)scp;
+		scp->SCp.ptr  = (char *)nscp;
+	}
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
 
 #ifdef GDTH_STATISTICS
-    flags = 0;
-    for (nscp=ha->req_first; nscp; nscp=(struct scsi_cmnd*)nscp->SCp.ptr)
-        ++flags;
-    if (max_rq < flags) {
-        max_rq = flags;
-        TRACE3(("GDT: max_rq = %d\n",(u16)max_rq));
-    }
+	flags = 0;
+	for (nscp=ha->req_first; nscp; nscp=(struct scsi_cmnd*)nscp->SCp.ptr)
+		++flags;
+	if (max_rq < flags) {
+		max_rq = flags;
+		TRACE3(("GDT: max_rq = %d\n",(u16)max_rq));
+	}
 #endif
 }
 
 static void gdth_next(gdth_ha_str *ha)
 {
-    register struct scsi_cmnd *pscp;
-    register struct scsi_cmnd *nscp;
-    u8 b, t, l, firsttime;
-    u8 this_cmd, next_cmd;
-    unsigned long flags = 0;
-    int cmd_index;
-
-    TRACE(("gdth_next() hanum %d\n", ha->hanum));
-    if (!gdth_polling) 
-        spin_lock_irqsave(&ha->smp_lock, flags);
-
-    ha->cmd_cnt = ha->cmd_offs_dpmem = 0;
-    this_cmd = firsttime = TRUE;
-    next_cmd = gdth_polling ? FALSE:TRUE;
-    cmd_index = 0;
-
-    for (nscp = pscp = ha->req_first; nscp; nscp = (struct scsi_cmnd *)nscp->SCp.ptr) {
-        struct gdth_cmndinfo *nscp_cmndinfo = gdth_cmnd_priv(nscp);
-        if (nscp != pscp && nscp != (struct scsi_cmnd *)pscp->SCp.ptr)
-            pscp = (struct scsi_cmnd *)pscp->SCp.ptr;
-        if (!nscp_cmndinfo->internal_command) {
-            b = nscp->device->channel;
-            t = nscp->device->id;
-            l = nscp->device->lun;
-            if (nscp_cmndinfo->priority >= DEFAULT_PRI) {
-                if ((b != ha->virt_bus && ha->raw[BUS_L2P(ha,b)].lock) ||
-                    (b == ha->virt_bus && t < MAX_HDRIVES && ha->hdr[t].lock))
-                    continue;
-            }
-        } else
-            b = t = l = 0;
-
-        if (firsttime) {
-            if (gdth_test_busy(ha)) {        /* controller busy ? */
-                TRACE(("gdth_next() controller %d busy !\n", ha->hanum));
-                if (!gdth_polling) {
-                    spin_unlock_irqrestore(&ha->smp_lock, flags);
-                    return;
-                }
-                while (gdth_test_busy(ha))
-                    gdth_delay(1);
-            }   
-            firsttime = FALSE;
-        }
-
-        if (!nscp_cmndinfo->internal_command) {
-        if (nscp_cmndinfo->phase == -1) {
-            nscp_cmndinfo->phase = CACHESERVICE;           /* default: cache svc. */
-            if (nscp->cmnd[0] == TEST_UNIT_READY) {
-                TRACE2(("TEST_UNIT_READY Bus %d Id %d LUN %d\n", 
-                        b, t, l));
-                /* TEST_UNIT_READY -> set scan mode */
-                if ((ha->scan_mode & 0x0f) == 0) {
-                    if (b == 0 && t == 0 && l == 0) {
-                        ha->scan_mode |= 1;
-                        TRACE2(("Scan mode: 0x%x\n", ha->scan_mode));
-                    }
-                } else if ((ha->scan_mode & 0x0f) == 1) {
-                    if (b == 0 && ((t == 0 && l == 1) ||
-                         (t == 1 && l == 0))) {
-                        nscp_cmndinfo->OpCode = GDT_SCAN_START;
-                        nscp_cmndinfo->phase = ((ha->scan_mode & 0x10 ? 1:0) << 8)
-                            | SCSIRAWSERVICE;
-                        ha->scan_mode = 0x12;
-                        TRACE2(("Scan mode: 0x%x (SCAN_START)\n", 
-                                ha->scan_mode));
-                    } else {
-                        ha->scan_mode &= 0x10;
-                        TRACE2(("Scan mode: 0x%x\n", ha->scan_mode));
-                    }                   
-                } else if (ha->scan_mode == 0x12) {
-                    if (b == ha->bus_cnt && t == ha->tid_cnt-1) {
-                        nscp_cmndinfo->phase = SCSIRAWSERVICE;
-                        nscp_cmndinfo->OpCode = GDT_SCAN_END;
-                        ha->scan_mode &= 0x10;
-                        TRACE2(("Scan mode: 0x%x (SCAN_END)\n", 
-                                ha->scan_mode));
-                    }
-                }
-            }
-            if (b == ha->virt_bus && nscp->cmnd[0] != INQUIRY &&
-                nscp->cmnd[0] != READ_CAPACITY && nscp->cmnd[0] != MODE_SENSE &&
-                (ha->hdr[t].cluster_type & CLUSTER_DRIVE)) {
-                /* always GDT_CLUST_INFO! */
-                nscp_cmndinfo->OpCode = GDT_CLUST_INFO;
-            }
-        }
-        }
-
-        if (nscp_cmndinfo->OpCode != -1) {
-            if ((nscp_cmndinfo->phase & 0xff) == CACHESERVICE) {
-                if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
-                    this_cmd = FALSE;
-                next_cmd = FALSE;
-            } else if ((nscp_cmndinfo->phase & 0xff) == SCSIRAWSERVICE) {
-                if (!(cmd_index=gdth_fill_raw_cmd(ha, nscp, BUS_L2P(ha, b))))
-                    this_cmd = FALSE;
-                next_cmd = FALSE;
-            } else {
-                memset((char*)nscp->sense_buffer,0,16);
-                nscp->sense_buffer[0] = 0x70;
-                nscp->sense_buffer[2] = NOT_READY;
-                nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-                if (!nscp_cmndinfo->wait_for_completion)
-                    nscp_cmndinfo->wait_for_completion++;
-                else
-                    gdth_scsi_done(nscp);
-            }
-        } else if (gdth_cmnd_priv(nscp)->internal_command) {
-            if (!(cmd_index=gdth_special_cmd(ha, nscp)))
-                this_cmd = FALSE;
-            next_cmd = FALSE;
-        } else if (b != ha->virt_bus) {
-            if (ha->raw[BUS_L2P(ha,b)].io_cnt[t] >= GDTH_MAX_RAW ||
-                !(cmd_index=gdth_fill_raw_cmd(ha, nscp, BUS_L2P(ha, b))))
-                this_cmd = FALSE;
-            else 
-                ha->raw[BUS_L2P(ha,b)].io_cnt[t]++;
-        } else if (t >= MAX_HDRIVES || !ha->hdr[t].present || l != 0) {
-            TRACE2(("Command 0x%x to bus %d id %d lun %d -> IGNORE\n",
-                    nscp->cmnd[0], b, t, l));
-            nscp->result = DID_BAD_TARGET << 16;
-            if (!nscp_cmndinfo->wait_for_completion)
-                nscp_cmndinfo->wait_for_completion++;
-            else
-                gdth_scsi_done(nscp);
-        } else {
-            switch (nscp->cmnd[0]) {
-              case TEST_UNIT_READY:
-              case INQUIRY:
-              case REQUEST_SENSE:
-              case READ_CAPACITY:
-              case VERIFY:
-              case START_STOP:
-              case MODE_SENSE:
-              case SERVICE_ACTION_IN_16:
-                TRACE(("cache cmd %x/%x/%x/%x/%x/%x\n",nscp->cmnd[0],
-                       nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
-                       nscp->cmnd[4],nscp->cmnd[5]));
-                if (ha->hdr[t].media_changed && nscp->cmnd[0] != INQUIRY) {
-                    /* return UNIT_ATTENTION */
-                    TRACE2(("cmd 0x%x target %d: UNIT_ATTENTION\n",
-                             nscp->cmnd[0], t));
-                    ha->hdr[t].media_changed = FALSE;
-                    memset((char*)nscp->sense_buffer,0,16);
-                    nscp->sense_buffer[0] = 0x70;
-                    nscp->sense_buffer[2] = UNIT_ATTENTION;
-                    nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-                    if (!nscp_cmndinfo->wait_for_completion)
-                        nscp_cmndinfo->wait_for_completion++;
-                    else
-                        gdth_scsi_done(nscp);
-                } else if (gdth_internal_cache_cmd(ha, nscp))
-                    gdth_scsi_done(nscp);
-                break;
-
-              case ALLOW_MEDIUM_REMOVAL:
-                TRACE(("cache cmd %x/%x/%x/%x/%x/%x\n",nscp->cmnd[0],
-                       nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
-                       nscp->cmnd[4],nscp->cmnd[5]));
-                if ( (nscp->cmnd[4]&1) && !(ha->hdr[t].devtype&1) ) {
-                    TRACE(("Prevent r. nonremov. drive->do nothing\n"));
-                    nscp->result = DID_OK << 16;
-                    nscp->sense_buffer[0] = 0;
-                    if (!nscp_cmndinfo->wait_for_completion)
-                        nscp_cmndinfo->wait_for_completion++;
-                    else
-                        gdth_scsi_done(nscp);
-                } else {
-                    nscp->cmnd[3] = (ha->hdr[t].devtype&1) ? 1:0;
-                    TRACE(("Prevent/allow r. %d rem. drive %d\n",
-                           nscp->cmnd[4],nscp->cmnd[3]));
-                    if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
-                        this_cmd = FALSE;
-                }
-                break;
-                
-              case RESERVE:
-              case RELEASE:
-                TRACE2(("cache cmd %s\n",nscp->cmnd[0] == RESERVE ?
-                        "RESERVE" : "RELEASE"));
-                if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
-                    this_cmd = FALSE;
-                break;
-                
-              case READ_6:
-              case WRITE_6:
-              case READ_10:
-              case WRITE_10:
-              case READ_16:
-              case WRITE_16:
-                if (ha->hdr[t].media_changed) {
-                    /* return UNIT_ATTENTION */
-                    TRACE2(("cmd 0x%x target %d: UNIT_ATTENTION\n",
-                             nscp->cmnd[0], t));
-                    ha->hdr[t].media_changed = FALSE;
-                    memset((char*)nscp->sense_buffer,0,16);
-                    nscp->sense_buffer[0] = 0x70;
-                    nscp->sense_buffer[2] = UNIT_ATTENTION;
-                    nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-                    if (!nscp_cmndinfo->wait_for_completion)
-                        nscp_cmndinfo->wait_for_completion++;
-                    else
-                        gdth_scsi_done(nscp);
-                } else if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
-                    this_cmd = FALSE;
-                break;
-
-              default:
-                TRACE2(("cache cmd %x/%x/%x/%x/%x/%x unknown\n",nscp->cmnd[0],
-                        nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
-                        nscp->cmnd[4],nscp->cmnd[5]));
-                printk("GDT-HA %d: Unknown SCSI command 0x%x to cache service !\n",
-                       ha->hanum, nscp->cmnd[0]);
-                nscp->result = DID_ABORT << 16;
-                if (!nscp_cmndinfo->wait_for_completion)
-                    nscp_cmndinfo->wait_for_completion++;
-                else
-                    gdth_scsi_done(nscp);
-                break;
-            }
-        }
-
-        if (!this_cmd)
-            break;
-        if (nscp == ha->req_first)
-            ha->req_first = pscp = (struct scsi_cmnd *)nscp->SCp.ptr;
-        else
-            pscp->SCp.ptr = nscp->SCp.ptr;
-        if (!next_cmd)
-            break;
-    }
-
-    if (ha->cmd_cnt > 0) {
-        gdth_release_event(ha);
-    }
-
-    if (!gdth_polling) 
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-
-    if (gdth_polling && ha->cmd_cnt > 0) {
-        if (!gdth_wait(ha, cmd_index, POLL_TIMEOUT))
-            printk("GDT-HA %d: Command %d timed out !\n",
-                   ha->hanum, cmd_index);
-    }
+	register struct scsi_cmnd *pscp;
+	register struct scsi_cmnd *nscp;
+	u8 b, t, l, firsttime;
+	u8 this_cmd, next_cmd;
+	unsigned long flags = 0;
+	int cmd_index;
+
+	TRACE(("gdth_next() hanum %d\n", ha->hanum));
+	if (!gdth_polling)
+		spin_lock_irqsave(&ha->smp_lock, flags);
+
+	ha->cmd_cnt = ha->cmd_offs_dpmem = 0;
+	this_cmd = firsttime = TRUE;
+	next_cmd = gdth_polling ? FALSE:TRUE;
+	cmd_index = 0;
+
+	for (nscp = pscp = ha->req_first; nscp;
+	     nscp = (struct scsi_cmnd *)nscp->SCp.ptr) {
+		struct gdth_cmndinfo *nscp_cmndinfo = gdth_cmnd_priv(nscp);
+		if (nscp != pscp && nscp != (struct scsi_cmnd *)pscp->SCp.ptr)
+			pscp = (struct scsi_cmnd *)pscp->SCp.ptr;
+		if (!nscp_cmndinfo->internal_command) {
+			b = nscp->device->channel;
+			t = nscp->device->id;
+			l = nscp->device->lun;
+			if (nscp_cmndinfo->priority >= DEFAULT_PRI) {
+				if ((b != ha->virt_bus &&
+				     ha->raw[BUS_L2P(ha,b)].lock) ||
+				    (b == ha->virt_bus && t < MAX_HDRIVES &&
+				     ha->hdr[t].lock))
+					continue;
+			}
+		} else
+			b = t = l = 0;
+
+		if (firsttime) {
+			/* controller busy ? */
+			if (gdth_test_busy(ha)) {
+				TRACE(("gdth_next() controller %d busy !\n",
+				       ha->hanum));
+				if (!gdth_polling) {
+					spin_unlock_irqrestore(&ha->smp_lock,
+							       flags);
+					return;
+				}
+				while (gdth_test_busy(ha))
+					gdth_delay(1);
+			}
+			firsttime = FALSE;
+		}
+
+		if (!nscp_cmndinfo->internal_command) {
+			if (nscp_cmndinfo->phase == -1) {
+				/* default: cache svc. */
+				nscp_cmndinfo->phase = CACHESERVICE;
+				if (nscp->cmnd[0] == TEST_UNIT_READY) {
+					TRACE2(("TEST_UNIT_READY Bus %d Id %d LUN %d\n",
+						b, t, l));
+					/* TEST_UNIT_READY -> set scan mode */
+					if ((ha->scan_mode & 0x0f) == 0) {
+						if (b == 0 && t == 0 && l == 0) {
+							ha->scan_mode |= 1;
+							TRACE2(("Scan mode: 0x%x\n", ha->scan_mode));
+						}
+					} else if ((ha->scan_mode & 0x0f) == 1) {
+						if (b == 0 && ((t == 0 && l == 1) ||
+							       (t == 1 && l == 0))) {
+							nscp_cmndinfo->OpCode = GDT_SCAN_START;
+							nscp_cmndinfo->phase = ((ha->scan_mode & 0x10 ? 1:0) << 8)
+								| SCSIRAWSERVICE;
+							ha->scan_mode = 0x12;
+							TRACE2(("Scan mode: 0x%x (SCAN_START)\n",
+								ha->scan_mode));
+						} else {
+							ha->scan_mode &= 0x10;
+							TRACE2(("Scan mode: 0x%x\n", ha->scan_mode));
+						}
+					} else if (ha->scan_mode == 0x12) {
+						if (b == ha->bus_cnt && t == ha->tid_cnt-1) {
+							nscp_cmndinfo->phase = SCSIRAWSERVICE;
+							nscp_cmndinfo->OpCode = GDT_SCAN_END;
+							ha->scan_mode &= 0x10;
+							TRACE2(("Scan mode: 0x%x (SCAN_END)\n",
+								ha->scan_mode));
+						}
+					}
+				}
+				if (b == ha->virt_bus && nscp->cmnd[0] != INQUIRY &&
+				    nscp->cmnd[0] != READ_CAPACITY && nscp->cmnd[0] != MODE_SENSE &&
+				    (ha->hdr[t].cluster_type & CLUSTER_DRIVE)) {
+					/* always GDT_CLUST_INFO! */
+					nscp_cmndinfo->OpCode = GDT_CLUST_INFO;
+				}
+			}
+		}
+
+		if (nscp_cmndinfo->OpCode != -1) {
+			if ((nscp_cmndinfo->phase & 0xff) == CACHESERVICE) {
+				if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
+					this_cmd = FALSE;
+				next_cmd = FALSE;
+			} else if ((nscp_cmndinfo->phase & 0xff) == SCSIRAWSERVICE) {
+				if (!(cmd_index=gdth_fill_raw_cmd(ha, nscp, BUS_L2P(ha, b))))
+					this_cmd = FALSE;
+				next_cmd = FALSE;
+			} else {
+				memset((char*)nscp->sense_buffer,0,16);
+				nscp->sense_buffer[0] = 0x70;
+				nscp->sense_buffer[2] = NOT_READY;
+				nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+				if (!nscp_cmndinfo->wait_for_completion)
+					nscp_cmndinfo->wait_for_completion++;
+				else
+					gdth_scsi_done(nscp);
+			}
+		} else if (gdth_cmnd_priv(nscp)->internal_command) {
+			if (!(cmd_index=gdth_special_cmd(ha, nscp)))
+				this_cmd = FALSE;
+			next_cmd = FALSE;
+		} else if (b != ha->virt_bus) {
+			if (ha->raw[BUS_L2P(ha,b)].io_cnt[t] >= GDTH_MAX_RAW ||
+			    !(cmd_index=gdth_fill_raw_cmd(ha, nscp, BUS_L2P(ha, b))))
+				this_cmd = FALSE;
+			else
+				ha->raw[BUS_L2P(ha,b)].io_cnt[t]++;
+		} else if (t >= MAX_HDRIVES || !ha->hdr[t].present || l != 0) {
+			TRACE2(("Command 0x%x to bus %d id %d lun %d -> IGNORE\n",
+				nscp->cmnd[0], b, t, l));
+			nscp->result = DID_BAD_TARGET << 16;
+			if (!nscp_cmndinfo->wait_for_completion)
+				nscp_cmndinfo->wait_for_completion++;
+			else
+				gdth_scsi_done(nscp);
+		} else {
+			switch (nscp->cmnd[0]) {
+			case TEST_UNIT_READY:
+			case INQUIRY:
+			case REQUEST_SENSE:
+			case READ_CAPACITY:
+			case VERIFY:
+			case START_STOP:
+			case MODE_SENSE:
+			case SERVICE_ACTION_IN_16:
+				TRACE(("cache cmd %x/%x/%x/%x/%x/%x\n",nscp->cmnd[0],
+				       nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
+				       nscp->cmnd[4],nscp->cmnd[5]));
+				if (ha->hdr[t].media_changed && nscp->cmnd[0] != INQUIRY) {
+					/* return UNIT_ATTENTION */
+					TRACE2(("cmd 0x%x target %d: UNIT_ATTENTION\n",
+						nscp->cmnd[0], t));
+					ha->hdr[t].media_changed = FALSE;
+					memset((char*)nscp->sense_buffer,0,16);
+					nscp->sense_buffer[0] = 0x70;
+					nscp->sense_buffer[2] = UNIT_ATTENTION;
+					nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+					if (!nscp_cmndinfo->wait_for_completion)
+						nscp_cmndinfo->wait_for_completion++;
+					else
+						gdth_scsi_done(nscp);
+				} else if (gdth_internal_cache_cmd(ha, nscp))
+					gdth_scsi_done(nscp);
+				break;
+
+			case ALLOW_MEDIUM_REMOVAL:
+				TRACE(("cache cmd %x/%x/%x/%x/%x/%x\n",nscp->cmnd[0],
+				       nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
+				       nscp->cmnd[4],nscp->cmnd[5]));
+				if ( (nscp->cmnd[4]&1) && !(ha->hdr[t].devtype&1) ) {
+					TRACE(("Prevent r. nonremov. drive->do nothing\n"));
+					nscp->result = DID_OK << 16;
+					nscp->sense_buffer[0] = 0;
+					if (!nscp_cmndinfo->wait_for_completion)
+						nscp_cmndinfo->wait_for_completion++;
+					else
+						gdth_scsi_done(nscp);
+				} else {
+					nscp->cmnd[3] = (ha->hdr[t].devtype&1) ? 1:0;
+					TRACE(("Prevent/allow r. %d rem. drive %d\n",
+					       nscp->cmnd[4],nscp->cmnd[3]));
+					if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
+						this_cmd = FALSE;
+				}
+				break;
+
+			case RESERVE:
+			case RELEASE:
+				TRACE2(("cache cmd %s\n",nscp->cmnd[0] == RESERVE ?
+					"RESERVE" : "RELEASE"));
+				if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
+					this_cmd = FALSE;
+				break;
+
+			case READ_6:
+			case WRITE_6:
+			case READ_10:
+			case WRITE_10:
+			case READ_16:
+			case WRITE_16:
+				if (ha->hdr[t].media_changed) {
+					/* return UNIT_ATTENTION */
+					TRACE2(("cmd 0x%x target %d: UNIT_ATTENTION\n",
+						nscp->cmnd[0], t));
+					ha->hdr[t].media_changed = FALSE;
+					memset((char*)nscp->sense_buffer,0,16);
+					nscp->sense_buffer[0] = 0x70;
+					nscp->sense_buffer[2] = UNIT_ATTENTION;
+					nscp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+					if (!nscp_cmndinfo->wait_for_completion)
+						nscp_cmndinfo->wait_for_completion++;
+					else
+						gdth_scsi_done(nscp);
+				} else if (!(cmd_index=gdth_fill_cache_cmd(ha, nscp, t)))
+					this_cmd = FALSE;
+				break;
+
+			default:
+				TRACE2(("cache cmd %x/%x/%x/%x/%x/%x unknown\n",nscp->cmnd[0],
+					nscp->cmnd[1],nscp->cmnd[2],nscp->cmnd[3],
+					nscp->cmnd[4],nscp->cmnd[5]));
+				printk("GDT-HA %d: Unknown SCSI command 0x%x to cache service !\n",
+				       ha->hanum, nscp->cmnd[0]);
+				nscp->result = DID_ABORT << 16;
+				if (!nscp_cmndinfo->wait_for_completion)
+					nscp_cmndinfo->wait_for_completion++;
+				else
+					gdth_scsi_done(nscp);
+				break;
+			}
+		}
+
+		if (!this_cmd)
+			break;
+		if (nscp == ha->req_first)
+			ha->req_first = pscp = (struct scsi_cmnd *)nscp->SCp.ptr;
+		else
+			pscp->SCp.ptr = nscp->SCp.ptr;
+		if (!next_cmd)
+			break;
+	}
+
+	if (ha->cmd_cnt > 0) {
+		gdth_release_event(ha);
+	}
+
+	if (!gdth_polling)
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+
+	if (gdth_polling && ha->cmd_cnt > 0) {
+		if (!gdth_wait(ha, cmd_index, POLL_TIMEOUT))
+			printk("GDT-HA %d: Command %d timed out !\n",
+			       ha->hanum, cmd_index);
+	}
 }
 
 /*
@@ -1827,809 +1841,811 @@ static void gdth_next(gdth_ha_str *ha)
  * buffers, kmap_atomic() as needed.
  */
 static void gdth_copy_internal_data(gdth_ha_str *ha, struct scsi_cmnd *scp,
-                                    char *buffer, u16 count)
+				    char *buffer, u16 count)
 {
-    u16 cpcount,i, max_sg = scsi_sg_count(scp);
-    u16 cpsum,cpnow;
-    struct scatterlist *sl;
-    char *address;
-
-    cpcount = min_t(u16, count, scsi_bufflen(scp));
-
-    if (cpcount) {
-        cpsum=0;
-        scsi_for_each_sg(scp, sl, max_sg, i) {
-            unsigned long flags;
-            cpnow = (u16)sl->length;
-            TRACE(("copy_internal() now %d sum %d count %d %d\n",
-                          cpnow, cpsum, cpcount, scsi_bufflen(scp)));
-            if (cpsum+cpnow > cpcount) 
-                cpnow = cpcount - cpsum;
-            cpsum += cpnow;
-            if (!sg_page(sl)) {
-                printk("GDT-HA %d: invalid sc/gt element in gdth_copy_internal_data()\n",
-                       ha->hanum);
-                return;
-            }
-            local_irq_save(flags);
-            address = kmap_atomic(sg_page(sl)) + sl->offset;
-            memcpy(address, buffer, cpnow);
-            flush_dcache_page(sg_page(sl));
-            kunmap_atomic(address);
-            local_irq_restore(flags);
-            if (cpsum == cpcount)
-                break;
-            buffer += cpnow;
-        }
-    } else if (count) {
-        printk("GDT-HA %d: SCSI command with no buffers but data transfer expected!\n",
-               ha->hanum);
-        WARN_ON(1);
-    }
+	u16 cpcount,i, max_sg = scsi_sg_count(scp);
+	u16 cpsum,cpnow;
+	struct scatterlist *sl;
+	char *address;
+
+	cpcount = min_t(u16, count, scsi_bufflen(scp));
+
+	if (cpcount) {
+		cpsum=0;
+		scsi_for_each_sg(scp, sl, max_sg, i) {
+			unsigned long flags;
+			cpnow = (u16)sl->length;
+			TRACE(("copy_internal() now %d sum %d count %d %d\n",
+			       cpnow, cpsum, cpcount, scsi_bufflen(scp)));
+			if (cpsum+cpnow > cpcount)
+				cpnow = cpcount - cpsum;
+			cpsum += cpnow;
+			if (!sg_page(sl)) {
+				printk("GDT-HA %d: invalid sc/gt element in gdth_copy_internal_data()\n",
+				       ha->hanum);
+				return;
+			}
+			local_irq_save(flags);
+			address = kmap_atomic(sg_page(sl)) + sl->offset;
+			memcpy(address, buffer, cpnow);
+			flush_dcache_page(sg_page(sl));
+			kunmap_atomic(address);
+			local_irq_restore(flags);
+			if (cpsum == cpcount)
+				break;
+			buffer += cpnow;
+		}
+	} else if (count) {
+		printk("GDT-HA %d: SCSI command with no buffers but data transfer expected!\n",
+		       ha->hanum);
+		WARN_ON(1);
+	}
 }
 
 static int gdth_internal_cache_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp)
 {
-    u8 t;
-    gdth_inq_data inq;
-    gdth_rdcap_data rdc;
-    gdth_sense_data sd;
-    gdth_modep_data mpd;
-    struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
-
-    t  = scp->device->id;
-    TRACE(("gdth_internal_cache_cmd() cmd 0x%x hdrive %d\n",
-           scp->cmnd[0],t));
-
-    scp->result = DID_OK << 16;
-    scp->sense_buffer[0] = 0;
-
-    switch (scp->cmnd[0]) {
-      case TEST_UNIT_READY:
-      case VERIFY:
-      case START_STOP:
-        TRACE2(("Test/Verify/Start hdrive %d\n",t));
-        break;
-
-      case INQUIRY:
-        TRACE2(("Inquiry hdrive %d devtype %d\n",
-                t,ha->hdr[t].devtype));
-        inq.type_qual = (ha->hdr[t].devtype&4) ? TYPE_ROM:TYPE_DISK;
-        /* you can here set all disks to removable, if you want to do
-           a flush using the ALLOW_MEDIUM_REMOVAL command */
-        inq.modif_rmb = 0x00;
-        if ((ha->hdr[t].devtype & 1) ||
-            (ha->hdr[t].cluster_type & CLUSTER_DRIVE))
-            inq.modif_rmb = 0x80;
-        inq.version   = 2;
-        inq.resp_aenc = 2;
-        inq.add_length= 32;
-        strcpy(inq.vendor,ha->oem_name);
-        snprintf(inq.product, sizeof(inq.product), "Host Drive  #%02d",t);
-        strcpy(inq.revision,"   ");
-        gdth_copy_internal_data(ha, scp, (char*)&inq, sizeof(gdth_inq_data));
-        break;
-
-      case REQUEST_SENSE:
-        TRACE2(("Request sense hdrive %d\n",t));
-        sd.errorcode = 0x70;
-        sd.segno     = 0x00;
-        sd.key       = NO_SENSE;
-        sd.info      = 0;
-        sd.add_length= 0;
-        gdth_copy_internal_data(ha, scp, (char*)&sd, sizeof(gdth_sense_data));
-        break;
-
-      case MODE_SENSE:
-        TRACE2(("Mode sense hdrive %d\n",t));
-        memset((char*)&mpd,0,sizeof(gdth_modep_data));
-        mpd.hd.data_length = sizeof(gdth_modep_data);
-        mpd.hd.dev_par     = (ha->hdr[t].devtype&2) ? 0x80:0;
-        mpd.hd.bd_length   = sizeof(mpd.bd);
-        mpd.bd.block_length[0] = (SECTOR_SIZE & 0x00ff0000) >> 16;
-        mpd.bd.block_length[1] = (SECTOR_SIZE & 0x0000ff00) >> 8;
-        mpd.bd.block_length[2] = (SECTOR_SIZE & 0x000000ff);
-        gdth_copy_internal_data(ha, scp, (char*)&mpd, sizeof(gdth_modep_data));
-        break;
-
-      case READ_CAPACITY:
-        TRACE2(("Read capacity hdrive %d\n",t));
-        if (ha->hdr[t].size > (u64)0xffffffff)
-            rdc.last_block_no = 0xffffffff;
-        else
-            rdc.last_block_no = cpu_to_be32(ha->hdr[t].size-1);
-        rdc.block_length  = cpu_to_be32(SECTOR_SIZE);
-        gdth_copy_internal_data(ha, scp, (char*)&rdc, sizeof(gdth_rdcap_data));
-        break;
-
-      case SERVICE_ACTION_IN_16:
-        if ((scp->cmnd[1] & 0x1f) == SAI_READ_CAPACITY_16 &&
-            (ha->cache_feat & GDT_64BIT)) {
-            gdth_rdcap16_data rdc16;
-
-            TRACE2(("Read capacity (16) hdrive %d\n",t));
-            rdc16.last_block_no = cpu_to_be64(ha->hdr[t].size-1);
-            rdc16.block_length  = cpu_to_be32(SECTOR_SIZE);
-            gdth_copy_internal_data(ha, scp, (char*)&rdc16,
-                                                 sizeof(gdth_rdcap16_data));
-        } else { 
-            scp->result = DID_ABORT << 16;
-        }
-        break;
-
-      default:
-        TRACE2(("Internal cache cmd 0x%x unknown\n",scp->cmnd[0]));
-        break;
-    }
-
-    if (!cmndinfo->wait_for_completion)
-        cmndinfo->wait_for_completion++;
-    else 
-        return 1;
-
-    return 0;
+	u8 t;
+	gdth_inq_data inq;
+	gdth_rdcap_data rdc;
+	gdth_sense_data sd;
+	gdth_modep_data mpd;
+	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
+
+	t  = scp->device->id;
+	TRACE(("gdth_internal_cache_cmd() cmd 0x%x hdrive %d\n",
+	       scp->cmnd[0],t));
+
+	scp->result = DID_OK << 16;
+	scp->sense_buffer[0] = 0;
+
+	switch (scp->cmnd[0]) {
+	case TEST_UNIT_READY:
+	case VERIFY:
+	case START_STOP:
+		TRACE2(("Test/Verify/Start hdrive %d\n",t));
+		break;
+
+	case INQUIRY:
+		TRACE2(("Inquiry hdrive %d devtype %d\n",
+			t,ha->hdr[t].devtype));
+		inq.type_qual = (ha->hdr[t].devtype&4) ? TYPE_ROM:TYPE_DISK;
+		/* you can here set all disks to removable, if you want to do
+		   a flush using the ALLOW_MEDIUM_REMOVAL command */
+		inq.modif_rmb = 0x00;
+		if ((ha->hdr[t].devtype & 1) ||
+		    (ha->hdr[t].cluster_type & CLUSTER_DRIVE))
+			inq.modif_rmb = 0x80;
+		inq.version   = 2;
+		inq.resp_aenc = 2;
+		inq.add_length= 32;
+		strcpy(inq.vendor,ha->oem_name);
+		snprintf(inq.product, sizeof(inq.product), "Host Drive  #%02d",t);
+		strcpy(inq.revision,"   ");
+		gdth_copy_internal_data(ha, scp, (char*)&inq, sizeof(gdth_inq_data));
+		break;
+
+	case REQUEST_SENSE:
+		TRACE2(("Request sense hdrive %d\n",t));
+		sd.errorcode = 0x70;
+		sd.segno     = 0x00;
+		sd.key       = NO_SENSE;
+		sd.info      = 0;
+		sd.add_length= 0;
+		gdth_copy_internal_data(ha, scp, (char*)&sd, sizeof(gdth_sense_data));
+		break;
+
+	case MODE_SENSE:
+		TRACE2(("Mode sense hdrive %d\n",t));
+		memset((char*)&mpd,0,sizeof(gdth_modep_data));
+		mpd.hd.data_length = sizeof(gdth_modep_data);
+		mpd.hd.dev_par     = (ha->hdr[t].devtype&2) ? 0x80:0;
+		mpd.hd.bd_length   = sizeof(mpd.bd);
+		mpd.bd.block_length[0] = (SECTOR_SIZE & 0x00ff0000) >> 16;
+		mpd.bd.block_length[1] = (SECTOR_SIZE & 0x0000ff00) >> 8;
+		mpd.bd.block_length[2] = (SECTOR_SIZE & 0x000000ff);
+		gdth_copy_internal_data(ha, scp, (char*)&mpd, sizeof(gdth_modep_data));
+		break;
+
+	case READ_CAPACITY:
+		TRACE2(("Read capacity hdrive %d\n",t));
+		if (ha->hdr[t].size > (u64)0xffffffff)
+			rdc.last_block_no = 0xffffffff;
+		else
+			rdc.last_block_no = cpu_to_be32(ha->hdr[t].size-1);
+		rdc.block_length  = cpu_to_be32(SECTOR_SIZE);
+		gdth_copy_internal_data(ha, scp, (char*)&rdc, sizeof(gdth_rdcap_data));
+		break;
+
+	case SERVICE_ACTION_IN_16:
+		if ((scp->cmnd[1] & 0x1f) == SAI_READ_CAPACITY_16 &&
+		    (ha->cache_feat & GDT_64BIT)) {
+			gdth_rdcap16_data rdc16;
+
+			TRACE2(("Read capacity (16) hdrive %d\n",t));
+			rdc16.last_block_no = cpu_to_be64(ha->hdr[t].size-1);
+			rdc16.block_length  = cpu_to_be32(SECTOR_SIZE);
+			gdth_copy_internal_data(ha, scp, (char*)&rdc16,
+						sizeof(gdth_rdcap16_data));
+		} else {
+			scp->result = DID_ABORT << 16;
+		}
+		break;
+
+	default:
+		TRACE2(("Internal cache cmd 0x%x unknown\n",scp->cmnd[0]));
+		break;
+	}
+
+	if (!cmndinfo->wait_for_completion)
+		cmndinfo->wait_for_completion++;
+	else
+		return 1;
+
+	return 0;
 }
 
 static int gdth_fill_cache_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp,
-                               u16 hdrive)
+			       u16 hdrive)
 {
-    register gdth_cmd_str *cmdp;
-    struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
-    u32 cnt, blockcnt;
-    u64 no, blockno;
-    int i, cmd_index, read_write, sgcnt, mode64;
-
-    cmdp = ha->pccb;
-    TRACE(("gdth_fill_cache_cmd() cmd 0x%x cmdsize %d hdrive %d\n",
-                 scp->cmnd[0],scp->cmd_len,hdrive));
-
-    mode64 = (ha->cache_feat & GDT_64BIT) ? TRUE : FALSE;
-    /* test for READ_16, WRITE_16 if !mode64 ? ---
-       not required, should not occur due to error return on 
-       READ_CAPACITY_16 */
-
-    cmdp->Service = CACHESERVICE;
-    cmdp->RequestBuffer = scp;
-    /* search free command index */
-    if (!(cmd_index=gdth_get_cmd_index(ha))) {
-        TRACE(("GDT: No free command index found\n"));
-        return 0;
-    }
-    /* if it's the first command, set command semaphore */
-    if (ha->cmd_cnt == 0)
-        gdth_set_sema0(ha);
-
-    /* fill command */
-    read_write = 0;
-    if (cmndinfo->OpCode != -1)
-        cmdp->OpCode = cmndinfo->OpCode;   /* special cache cmd. */
-    else if (scp->cmnd[0] == RESERVE) 
-        cmdp->OpCode = GDT_RESERVE_DRV;
-    else if (scp->cmnd[0] == RELEASE)
-        cmdp->OpCode = GDT_RELEASE_DRV;
-    else if (scp->cmnd[0] == ALLOW_MEDIUM_REMOVAL) {
-        if (scp->cmnd[4] & 1)                   /* prevent ? */
-            cmdp->OpCode = GDT_MOUNT;
-        else if (scp->cmnd[3] & 1)              /* removable drive ? */
-            cmdp->OpCode = GDT_UNMOUNT;
-        else
-            cmdp->OpCode = GDT_FLUSH;
-    } else if (scp->cmnd[0] == WRITE_6 || scp->cmnd[0] == WRITE_10 ||
-               scp->cmnd[0] == WRITE_12 || scp->cmnd[0] == WRITE_16
-    ) {
-        read_write = 1;
-        if (gdth_write_through || ((ha->hdr[hdrive].rw_attribs & 1) && 
-                                   (ha->cache_feat & GDT_WR_THROUGH)))
-            cmdp->OpCode = GDT_WRITE_THR;
-        else
-            cmdp->OpCode = GDT_WRITE;
-    } else {
-        read_write = 2;
-        cmdp->OpCode = GDT_READ;
-    }
-
-    cmdp->BoardNode = LOCALBOARD;
-    if (mode64) {
-        cmdp->u.cache64.DeviceNo = hdrive;
-        cmdp->u.cache64.BlockNo  = 1;
-        cmdp->u.cache64.sg_canz  = 0;
-    } else {
-        cmdp->u.cache.DeviceNo = hdrive;
-        cmdp->u.cache.BlockNo  = 1;
-        cmdp->u.cache.sg_canz  = 0;
-    }
-
-    if (read_write) {
-        if (scp->cmd_len == 16) {
-            memcpy(&no, &scp->cmnd[2], sizeof(u64));
-            blockno = be64_to_cpu(no);
-            memcpy(&cnt, &scp->cmnd[10], sizeof(u32));
-            blockcnt = be32_to_cpu(cnt);
-        } else if (scp->cmd_len == 10) {
-            memcpy(&no, &scp->cmnd[2], sizeof(u32));
-            blockno = be32_to_cpu(no);
-            memcpy(&cnt, &scp->cmnd[7], sizeof(u16));
-            blockcnt = be16_to_cpu(cnt);
-        } else {
-            memcpy(&no, &scp->cmnd[0], sizeof(u32));
-            blockno = be32_to_cpu(no) & 0x001fffffUL;
-            blockcnt= scp->cmnd[4]==0 ? 0x100 : scp->cmnd[4];
-        }
-        if (mode64) {
-            cmdp->u.cache64.BlockNo = blockno;
-            cmdp->u.cache64.BlockCnt = blockcnt;
-        } else {
-            cmdp->u.cache.BlockNo = (u32)blockno;
-            cmdp->u.cache.BlockCnt = blockcnt;
-        }
-
-        if (scsi_bufflen(scp)) {
-            cmndinfo->dma_dir = (read_write == 1 ?
-                DMA_TO_DEVICE : DMA_FROM_DEVICE);
-            sgcnt = dma_map_sg(&ha->pdev->dev, scsi_sglist(scp),
-			       scsi_sg_count(scp), cmndinfo->dma_dir);
-            if (mode64) {
-                struct scatterlist *sl;
-
-                cmdp->u.cache64.DestAddr= (u64)-1;
-                cmdp->u.cache64.sg_canz = sgcnt;
-                scsi_for_each_sg(scp, sl, sgcnt, i) {
-                    cmdp->u.cache64.sg_lst[i].sg_ptr = sg_dma_address(sl);
-                    cmdp->u.cache64.sg_lst[i].sg_len = sg_dma_len(sl);
-                }
-            } else {
-                struct scatterlist *sl;
-
-                cmdp->u.cache.DestAddr= 0xffffffff;
-                cmdp->u.cache.sg_canz = sgcnt;
-                scsi_for_each_sg(scp, sl, sgcnt, i) {
-                    cmdp->u.cache.sg_lst[i].sg_ptr = sg_dma_address(sl);
-                    cmdp->u.cache.sg_lst[i].sg_len = sg_dma_len(sl);
-                }
-            }
+	register gdth_cmd_str *cmdp;
+	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
+	u32 cnt, blockcnt;
+	u64 no, blockno;
+	int i, cmd_index, read_write, sgcnt, mode64;
+
+	cmdp = ha->pccb;
+	TRACE(("gdth_fill_cache_cmd() cmd 0x%x cmdsize %d hdrive %d\n",
+	       scp->cmnd[0],scp->cmd_len,hdrive));
+
+	mode64 = (ha->cache_feat & GDT_64BIT) ? TRUE : FALSE;
+	/* test for READ_16, WRITE_16 if !mode64 ? ---
+	   not required, should not occur due to error return on
+	   READ_CAPACITY_16 */
+
+	cmdp->Service = CACHESERVICE;
+	cmdp->RequestBuffer = scp;
+	/* search free command index */
+	if (!(cmd_index=gdth_get_cmd_index(ha))) {
+		TRACE(("GDT: No free command index found\n"));
+		return 0;
+	}
+	/* if it's the first command, set command semaphore */
+	if (ha->cmd_cnt == 0)
+		gdth_set_sema0(ha);
+
+	/* fill command */
+	read_write = 0;
+	if (cmndinfo->OpCode != -1)
+		cmdp->OpCode = cmndinfo->OpCode;   /* special cache cmd. */
+	else if (scp->cmnd[0] == RESERVE)
+		cmdp->OpCode = GDT_RESERVE_DRV;
+	else if (scp->cmnd[0] == RELEASE)
+		cmdp->OpCode = GDT_RELEASE_DRV;
+	else if (scp->cmnd[0] == ALLOW_MEDIUM_REMOVAL) {
+		if (scp->cmnd[4] & 1)			/* prevent ? */
+			cmdp->OpCode = GDT_MOUNT;
+		else if (scp->cmnd[3] & 1)		/* removable drive ? */
+			cmdp->OpCode = GDT_UNMOUNT;
+		else
+			cmdp->OpCode = GDT_FLUSH;
+	} else if (scp->cmnd[0] == WRITE_6 || scp->cmnd[0] == WRITE_10 ||
+		   scp->cmnd[0] == WRITE_12 || scp->cmnd[0] == WRITE_16
+		) {
+		read_write = 1;
+		if (gdth_write_through || ((ha->hdr[hdrive].rw_attribs & 1) &&
+					   (ha->cache_feat & GDT_WR_THROUGH)))
+			cmdp->OpCode = GDT_WRITE_THR;
+		else
+			cmdp->OpCode = GDT_WRITE;
+	} else {
+		read_write = 2;
+		cmdp->OpCode = GDT_READ;
+	}
+
+	cmdp->BoardNode = LOCALBOARD;
+	if (mode64) {
+		cmdp->u.cache64.DeviceNo = hdrive;
+		cmdp->u.cache64.BlockNo  = 1;
+		cmdp->u.cache64.sg_canz  = 0;
+	} else {
+		cmdp->u.cache.DeviceNo = hdrive;
+		cmdp->u.cache.BlockNo  = 1;
+		cmdp->u.cache.sg_canz  = 0;
+	}
+
+	if (read_write) {
+		if (scp->cmd_len == 16) {
+			memcpy(&no, &scp->cmnd[2], sizeof(u64));
+			blockno = be64_to_cpu(no);
+			memcpy(&cnt, &scp->cmnd[10], sizeof(u32));
+			blockcnt = be32_to_cpu(cnt);
+		} else if (scp->cmd_len == 10) {
+			memcpy(&no, &scp->cmnd[2], sizeof(u32));
+			blockno = be32_to_cpu(no);
+			memcpy(&cnt, &scp->cmnd[7], sizeof(u16));
+			blockcnt = be16_to_cpu(cnt);
+		} else {
+			memcpy(&no, &scp->cmnd[0], sizeof(u32));
+			blockno = be32_to_cpu(no) & 0x001fffffUL;
+			blockcnt= scp->cmnd[4]==0 ? 0x100 : scp->cmnd[4];
+		}
+		if (mode64) {
+			cmdp->u.cache64.BlockNo = blockno;
+			cmdp->u.cache64.BlockCnt = blockcnt;
+		} else {
+			cmdp->u.cache.BlockNo = (u32)blockno;
+			cmdp->u.cache.BlockCnt = blockcnt;
+		}
+
+		if (scsi_bufflen(scp)) {
+			cmndinfo->dma_dir = (read_write == 1 ?
+					     DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			sgcnt = dma_map_sg(&ha->pdev->dev, scsi_sglist(scp),
+					   scsi_sg_count(scp), cmndinfo->dma_dir);
+			if (mode64) {
+				struct scatterlist *sl;
+
+				cmdp->u.cache64.DestAddr= (u64)-1;
+				cmdp->u.cache64.sg_canz = sgcnt;
+				scsi_for_each_sg(scp, sl, sgcnt, i) {
+					cmdp->u.cache64.sg_lst[i].sg_ptr = sg_dma_address(sl);
+					cmdp->u.cache64.sg_lst[i].sg_len = sg_dma_len(sl);
+				}
+			} else {
+				struct scatterlist *sl;
+
+				cmdp->u.cache.DestAddr= 0xffffffff;
+				cmdp->u.cache.sg_canz = sgcnt;
+				scsi_for_each_sg(scp, sl, sgcnt, i) {
+					cmdp->u.cache.sg_lst[i].sg_ptr = sg_dma_address(sl);
+					cmdp->u.cache.sg_lst[i].sg_len = sg_dma_len(sl);
+				}
+			}
 
 #ifdef GDTH_STATISTICS
-            if (max_sg < (u32)sgcnt) {
-                max_sg = (u32)sgcnt;
-                TRACE3(("GDT: max_sg = %d\n",max_sg));
-            }
+			if (max_sg < (u32)sgcnt) {
+				max_sg = (u32)sgcnt;
+				TRACE3(("GDT: max_sg = %d\n",max_sg));
+			}
 #endif
 
-        }
-    }
-    /* evaluate command size, check space */
-    if (mode64) {
-        TRACE(("cache cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
-               cmdp->u.cache64.DestAddr,cmdp->u.cache64.sg_canz,
-               cmdp->u.cache64.sg_lst[0].sg_ptr,
-               cmdp->u.cache64.sg_lst[0].sg_len));
-        TRACE(("cache cmd: cmd %d blockno. %d, blockcnt %d\n",
-               cmdp->OpCode,cmdp->u.cache64.BlockNo,cmdp->u.cache64.BlockCnt));
-        ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.cache64.sg_lst) +
-            (u16)cmdp->u.cache64.sg_canz * sizeof(gdth_sg64_str);
-    } else {
-        TRACE(("cache cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
-               cmdp->u.cache.DestAddr,cmdp->u.cache.sg_canz,
-               cmdp->u.cache.sg_lst[0].sg_ptr,
-               cmdp->u.cache.sg_lst[0].sg_len));
-        TRACE(("cache cmd: cmd %d blockno. %d, blockcnt %d\n",
-               cmdp->OpCode,cmdp->u.cache.BlockNo,cmdp->u.cache.BlockCnt));
-        ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.cache.sg_lst) +
-            (u16)cmdp->u.cache.sg_canz * sizeof(gdth_sg_str);
-    }
-    if (ha->cmd_len & 3)
-        ha->cmd_len += (4 - (ha->cmd_len & 3));
-
-    if (ha->cmd_cnt > 0) {
-        if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
-            ha->ic_all_size) {
-            TRACE2(("gdth_fill_cache() DPMEM overflow\n"));
-            ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
-            return 0;
-        }
-    }
-
-    /* copy command */
-    gdth_copy_command(ha);
-    return cmd_index;
+		}
+	}
+	/* evaluate command size, check space */
+	if (mode64) {
+		TRACE(("cache cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
+		       cmdp->u.cache64.DestAddr,cmdp->u.cache64.sg_canz,
+		       cmdp->u.cache64.sg_lst[0].sg_ptr,
+		       cmdp->u.cache64.sg_lst[0].sg_len));
+		TRACE(("cache cmd: cmd %d blockno. %d, blockcnt %d\n",
+		       cmdp->OpCode,cmdp->u.cache64.BlockNo,cmdp->u.cache64.BlockCnt));
+		ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.cache64.sg_lst) +
+			(u16)cmdp->u.cache64.sg_canz * sizeof(gdth_sg64_str);
+	} else {
+		TRACE(("cache cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
+		       cmdp->u.cache.DestAddr,cmdp->u.cache.sg_canz,
+		       cmdp->u.cache.sg_lst[0].sg_ptr,
+		       cmdp->u.cache.sg_lst[0].sg_len));
+		TRACE(("cache cmd: cmd %d blockno. %d, blockcnt %d\n",
+		       cmdp->OpCode,cmdp->u.cache.BlockNo,cmdp->u.cache.BlockCnt));
+		ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.cache.sg_lst) +
+			(u16)cmdp->u.cache.sg_canz * sizeof(gdth_sg_str);
+	}
+	if (ha->cmd_len & 3)
+		ha->cmd_len += (4 - (ha->cmd_len & 3));
+
+	if (ha->cmd_cnt > 0) {
+		if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
+		    ha->ic_all_size) {
+			TRACE2(("gdth_fill_cache() DPMEM overflow\n"));
+			ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
+			return 0;
+		}
+	}
+
+	/* copy command */
+	gdth_copy_command(ha);
+	return cmd_index;
 }
 
 static int gdth_fill_raw_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp, u8 b)
 {
-    register gdth_cmd_str *cmdp;
-    u16 i;
-    dma_addr_t sense_paddr;
-    int cmd_index, sgcnt, mode64;
-    u8 t,l;
-    struct gdth_cmndinfo *cmndinfo;
-
-    t = scp->device->id;
-    l = scp->device->lun;
-    cmdp = ha->pccb;
-    TRACE(("gdth_fill_raw_cmd() cmd 0x%x bus %d ID %d LUN %d\n",
-           scp->cmnd[0],b,t,l));
-
-    mode64 = (ha->raw_feat & GDT_64BIT) ? TRUE : FALSE;
-
-    cmdp->Service = SCSIRAWSERVICE;
-    cmdp->RequestBuffer = scp;
-    /* search free command index */
-    if (!(cmd_index=gdth_get_cmd_index(ha))) {
-        TRACE(("GDT: No free command index found\n"));
-        return 0;
-    }
-    /* if it's the first command, set command semaphore */
-    if (ha->cmd_cnt == 0)
-        gdth_set_sema0(ha);
-
-    cmndinfo = gdth_cmnd_priv(scp);
-    /* fill command */  
-    if (cmndinfo->OpCode != -1) {
-        cmdp->OpCode           = cmndinfo->OpCode; /* special raw cmd. */
-        cmdp->BoardNode        = LOCALBOARD;
-        if (mode64) {
-            cmdp->u.raw64.direction = (cmndinfo->phase >> 8);
-            TRACE2(("special raw cmd 0x%x param 0x%x\n", 
-                    cmdp->OpCode, cmdp->u.raw64.direction));
-            /* evaluate command size */
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst);
-        } else {
-            cmdp->u.raw.direction  = (cmndinfo->phase >> 8);
-            TRACE2(("special raw cmd 0x%x param 0x%x\n", 
-                    cmdp->OpCode, cmdp->u.raw.direction));
-            /* evaluate command size */
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst);
-        }
-
-    } else {
-        sense_paddr = dma_map_single(&ha->pdev->dev, scp->sense_buffer, 16,
-				     DMA_FROM_DEVICE);
-
-	cmndinfo->sense_paddr  = sense_paddr;
-        cmdp->OpCode           = GDT_WRITE;             /* always */
-        cmdp->BoardNode        = LOCALBOARD;
-        if (mode64) { 
-            cmdp->u.raw64.reserved   = 0;
-            cmdp->u.raw64.mdisc_time = 0;
-            cmdp->u.raw64.mcon_time  = 0;
-            cmdp->u.raw64.clen       = scp->cmd_len;
-            cmdp->u.raw64.target     = t;
-            cmdp->u.raw64.lun        = l;
-            cmdp->u.raw64.bus        = b;
-            cmdp->u.raw64.priority   = 0;
-            cmdp->u.raw64.sdlen      = scsi_bufflen(scp);
-            cmdp->u.raw64.sense_len  = 16;
-            cmdp->u.raw64.sense_data = sense_paddr;
-            cmdp->u.raw64.direction  = 
-                gdth_direction_tab[scp->cmnd[0]]==DOU ? GDTH_DATA_OUT:GDTH_DATA_IN;
-            memcpy(cmdp->u.raw64.cmd,scp->cmnd,16);
-            cmdp->u.raw64.sg_ranz    = 0;
-        } else {
-            cmdp->u.raw.reserved   = 0;
-            cmdp->u.raw.mdisc_time = 0;
-            cmdp->u.raw.mcon_time  = 0;
-            cmdp->u.raw.clen       = scp->cmd_len;
-            cmdp->u.raw.target     = t;
-            cmdp->u.raw.lun        = l;
-            cmdp->u.raw.bus        = b;
-            cmdp->u.raw.priority   = 0;
-            cmdp->u.raw.link_p     = 0;
-            cmdp->u.raw.sdlen      = scsi_bufflen(scp);
-            cmdp->u.raw.sense_len  = 16;
-            cmdp->u.raw.sense_data = sense_paddr;
-            cmdp->u.raw.direction  = 
-                gdth_direction_tab[scp->cmnd[0]]==DOU ? GDTH_DATA_OUT:GDTH_DATA_IN;
-            memcpy(cmdp->u.raw.cmd,scp->cmnd,12);
-            cmdp->u.raw.sg_ranz    = 0;
-        }
-
-        if (scsi_bufflen(scp)) {
-            cmndinfo->dma_dir = DMA_BIDIRECTIONAL;
-            sgcnt = dma_map_sg(&ha->pdev->dev, scsi_sglist(scp),
-			       scsi_sg_count(scp), cmndinfo->dma_dir);
-            if (mode64) {
-                struct scatterlist *sl;
-
-                cmdp->u.raw64.sdata = (u64)-1;
-                cmdp->u.raw64.sg_ranz = sgcnt;
-                scsi_for_each_sg(scp, sl, sgcnt, i) {
-                    cmdp->u.raw64.sg_lst[i].sg_ptr = sg_dma_address(sl);
-                    cmdp->u.raw64.sg_lst[i].sg_len = sg_dma_len(sl);
-                }
-            } else {
-                struct scatterlist *sl;
-
-                cmdp->u.raw.sdata = 0xffffffff;
-                cmdp->u.raw.sg_ranz = sgcnt;
-                scsi_for_each_sg(scp, sl, sgcnt, i) {
-                    cmdp->u.raw.sg_lst[i].sg_ptr = sg_dma_address(sl);
-                    cmdp->u.raw.sg_lst[i].sg_len = sg_dma_len(sl);
-                }
-            }
+	register gdth_cmd_str *cmdp;
+	u16 i;
+	dma_addr_t sense_paddr;
+	int cmd_index, sgcnt, mode64;
+	u8 t,l;
+	struct gdth_cmndinfo *cmndinfo;
+
+	t = scp->device->id;
+	l = scp->device->lun;
+	cmdp = ha->pccb;
+	TRACE(("gdth_fill_raw_cmd() cmd 0x%x bus %d ID %d LUN %d\n",
+	       scp->cmnd[0],b,t,l));
+
+	mode64 = (ha->raw_feat & GDT_64BIT) ? TRUE : FALSE;
+
+	cmdp->Service = SCSIRAWSERVICE;
+	cmdp->RequestBuffer = scp;
+	/* search free command index */
+	if (!(cmd_index=gdth_get_cmd_index(ha))) {
+		TRACE(("GDT: No free command index found\n"));
+		return 0;
+	}
+	/* if it's the first command, set command semaphore */
+	if (ha->cmd_cnt == 0)
+		gdth_set_sema0(ha);
+
+	cmndinfo = gdth_cmnd_priv(scp);
+	/* fill command */
+	if (cmndinfo->OpCode != -1) {
+		cmdp->OpCode = cmndinfo->OpCode; /* special raw cmd. */
+		cmdp->BoardNode = LOCALBOARD;
+		if (mode64) {
+			cmdp->u.raw64.direction = (cmndinfo->phase >> 8);
+			TRACE2(("special raw cmd 0x%x param 0x%x\n",
+				cmdp->OpCode, cmdp->u.raw64.direction));
+			/* evaluate command size */
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst);
+		} else {
+			cmdp->u.raw.direction  = (cmndinfo->phase >> 8);
+			TRACE2(("special raw cmd 0x%x param 0x%x\n",
+				cmdp->OpCode, cmdp->u.raw.direction));
+			/* evaluate command size */
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst);
+		}
+
+	} else {
+		sense_paddr = dma_map_single(&ha->pdev->dev, scp->sense_buffer, 16,
+					     DMA_FROM_DEVICE);
+
+		cmndinfo->sense_paddr = sense_paddr;
+		cmdp->OpCode = GDT_WRITE;
+		cmdp->BoardNode = LOCALBOARD;
+		if (mode64) {
+			cmdp->u.raw64.reserved = 0;
+			cmdp->u.raw64.mdisc_time = 0;
+			cmdp->u.raw64.mcon_time = 0;
+			cmdp->u.raw64.clen = scp->cmd_len;
+			cmdp->u.raw64.target = t;
+			cmdp->u.raw64.lun = l;
+			cmdp->u.raw64.bus = b;
+			cmdp->u.raw64.priority = 0;
+			cmdp->u.raw64.sdlen = scsi_bufflen(scp);
+			cmdp->u.raw64.sense_len = 16;
+			cmdp->u.raw64.sense_data = sense_paddr;
+			cmdp->u.raw64.direction =
+				gdth_direction_tab[scp->cmnd[0]]==DOU ?
+				GDTH_DATA_OUT : GDTH_DATA_IN;
+			memcpy(cmdp->u.raw64.cmd,scp->cmnd,16);
+			cmdp->u.raw64.sg_ranz = 0;
+		} else {
+			cmdp->u.raw.reserved = 0;
+			cmdp->u.raw.mdisc_time = 0;
+			cmdp->u.raw.mcon_time = 0;
+			cmdp->u.raw.clen = scp->cmd_len;
+			cmdp->u.raw.target = t;
+			cmdp->u.raw.lun = l;
+			cmdp->u.raw.bus = b;
+			cmdp->u.raw.priority = 0;
+			cmdp->u.raw.link_p = 0;
+			cmdp->u.raw.sdlen = scsi_bufflen(scp);
+			cmdp->u.raw.sense_len = 16;
+			cmdp->u.raw.sense_data = sense_paddr;
+			cmdp->u.raw.direction =
+				gdth_direction_tab[scp->cmnd[0]] == DOU ?
+				GDTH_DATA_OUT : GDTH_DATA_IN;
+			memcpy(cmdp->u.raw.cmd,scp->cmnd,12);
+			cmdp->u.raw.sg_ranz    = 0;
+		}
+
+		if (scsi_bufflen(scp)) {
+			cmndinfo->dma_dir = DMA_BIDIRECTIONAL;
+			sgcnt = dma_map_sg(&ha->pdev->dev, scsi_sglist(scp),
+					   scsi_sg_count(scp), cmndinfo->dma_dir);
+			if (mode64) {
+				struct scatterlist *sl;
+
+				cmdp->u.raw64.sdata = (u64)-1;
+				cmdp->u.raw64.sg_ranz = sgcnt;
+				scsi_for_each_sg(scp, sl, sgcnt, i) {
+					cmdp->u.raw64.sg_lst[i].sg_ptr = sg_dma_address(sl);
+					cmdp->u.raw64.sg_lst[i].sg_len = sg_dma_len(sl);
+				}
+			} else {
+				struct scatterlist *sl;
+
+				cmdp->u.raw.sdata = 0xffffffff;
+				cmdp->u.raw.sg_ranz = sgcnt;
+				scsi_for_each_sg(scp, sl, sgcnt, i) {
+					cmdp->u.raw.sg_lst[i].sg_ptr = sg_dma_address(sl);
+					cmdp->u.raw.sg_lst[i].sg_len = sg_dma_len(sl);
+				}
+			}
 
 #ifdef GDTH_STATISTICS
-            if (max_sg < sgcnt) {
-                max_sg = sgcnt;
-                TRACE3(("GDT: max_sg = %d\n",sgcnt));
-            }
+			if (max_sg < sgcnt) {
+				max_sg = sgcnt;
+				TRACE3(("GDT: max_sg = %d\n",sgcnt));
+			}
 #endif
 
-        }
-        if (mode64) {
-            TRACE(("raw cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
-                   cmdp->u.raw64.sdata,cmdp->u.raw64.sg_ranz,
-                   cmdp->u.raw64.sg_lst[0].sg_ptr,
-                   cmdp->u.raw64.sg_lst[0].sg_len));
-            /* evaluate command size */
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst) +
-                (u16)cmdp->u.raw64.sg_ranz * sizeof(gdth_sg64_str);
-        } else {
-            TRACE(("raw cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
-                   cmdp->u.raw.sdata,cmdp->u.raw.sg_ranz,
-                   cmdp->u.raw.sg_lst[0].sg_ptr,
-                   cmdp->u.raw.sg_lst[0].sg_len));
-            /* evaluate command size */
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst) +
-                (u16)cmdp->u.raw.sg_ranz * sizeof(gdth_sg_str);
-        }
-    }
-    /* check space */
-    if (ha->cmd_len & 3)
-        ha->cmd_len += (4 - (ha->cmd_len & 3));
-
-    if (ha->cmd_cnt > 0) {
-        if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
-            ha->ic_all_size) {
-            TRACE2(("gdth_fill_raw() DPMEM overflow\n"));
-            ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
-            return 0;
-        }
-    }
-
-    /* copy command */
-    gdth_copy_command(ha);
-    return cmd_index;
+		}
+		if (mode64) {
+			TRACE(("raw cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
+			       cmdp->u.raw64.sdata,cmdp->u.raw64.sg_ranz,
+			       cmdp->u.raw64.sg_lst[0].sg_ptr,
+			       cmdp->u.raw64.sg_lst[0].sg_len));
+			/* evaluate command size */
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst) +
+				(u16)cmdp->u.raw64.sg_ranz * sizeof(gdth_sg64_str);
+		} else {
+			TRACE(("raw cmd: addr. %x sganz %x sgptr0 %x sglen0 %x\n",
+			       cmdp->u.raw.sdata,cmdp->u.raw.sg_ranz,
+			       cmdp->u.raw.sg_lst[0].sg_ptr,
+			       cmdp->u.raw.sg_lst[0].sg_len));
+			/* evaluate command size */
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst) +
+				(u16)cmdp->u.raw.sg_ranz * sizeof(gdth_sg_str);
+		}
+	}
+	/* check space */
+	if (ha->cmd_len & 3)
+		ha->cmd_len += (4 - (ha->cmd_len & 3));
+
+	if (ha->cmd_cnt > 0) {
+		if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
+		    ha->ic_all_size) {
+			TRACE2(("gdth_fill_raw() DPMEM overflow\n"));
+			ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
+			return 0;
+		}
+	}
+
+	/* copy command */
+	gdth_copy_command(ha);
+	return cmd_index;
 }
 
 static int gdth_special_cmd(gdth_ha_str *ha, struct scsi_cmnd *scp)
 {
-    register gdth_cmd_str *cmdp;
-    struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
-    int cmd_index;
-
-    cmdp= ha->pccb;
-    TRACE2(("gdth_special_cmd(): "));
-
-    *cmdp = *cmndinfo->internal_cmd_str;
-    cmdp->RequestBuffer = scp;
-
-    /* search free command index */
-    if (!(cmd_index=gdth_get_cmd_index(ha))) {
-        TRACE(("GDT: No free command index found\n"));
-        return 0;
-    }
-
-    /* if it's the first command, set command semaphore */
-    if (ha->cmd_cnt == 0)
-       gdth_set_sema0(ha);
-
-    /* evaluate command size, check space */
-    if (cmdp->OpCode == GDT_IOCTL) {
-        TRACE2(("IOCTL\n"));
-        ha->cmd_len = 
-            GDTOFFSOF(gdth_cmd_str,u.ioctl.p_param) + sizeof(u64);
-    } else if (cmdp->Service == CACHESERVICE) {
-        TRACE2(("cache command %d\n",cmdp->OpCode));
-        if (ha->cache_feat & GDT_64BIT)
-            ha->cmd_len = 
-                GDTOFFSOF(gdth_cmd_str,u.cache64.sg_lst) + sizeof(gdth_sg64_str);
-        else
-            ha->cmd_len = 
-                GDTOFFSOF(gdth_cmd_str,u.cache.sg_lst) + sizeof(gdth_sg_str);
-    } else if (cmdp->Service == SCSIRAWSERVICE) {
-        TRACE2(("raw command %d\n",cmdp->OpCode));
-        if (ha->raw_feat & GDT_64BIT)
-            ha->cmd_len = 
-                GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst) + sizeof(gdth_sg64_str);
-        else
-            ha->cmd_len = 
-                GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst) + sizeof(gdth_sg_str);
-    }
-
-    if (ha->cmd_len & 3)
-        ha->cmd_len += (4 - (ha->cmd_len & 3));
-
-    if (ha->cmd_cnt > 0) {
-        if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
-            ha->ic_all_size) {
-            TRACE2(("gdth_special_cmd() DPMEM overflow\n"));
-            ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
-            return 0;
-        }
-    }
-
-    /* copy command */
-    gdth_copy_command(ha);
-    return cmd_index;
-}    
+	register gdth_cmd_str *cmdp;
+	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
+	int cmd_index;
+
+	cmdp= ha->pccb;
+	TRACE2(("gdth_special_cmd(): "));
+
+	*cmdp = *cmndinfo->internal_cmd_str;
+	cmdp->RequestBuffer = scp;
+
+	/* search free command index */
+	if (!(cmd_index=gdth_get_cmd_index(ha))) {
+		TRACE(("GDT: No free command index found\n"));
+		return 0;
+	}
+
+	/* if it's the first command, set command semaphore */
+	if (ha->cmd_cnt == 0)
+		gdth_set_sema0(ha);
+
+	/* evaluate command size, check space */
+	if (cmdp->OpCode == GDT_IOCTL) {
+		TRACE2(("IOCTL\n"));
+		ha->cmd_len =
+			GDTOFFSOF(gdth_cmd_str,u.ioctl.p_param) + sizeof(u64);
+	} else if (cmdp->Service == CACHESERVICE) {
+		TRACE2(("cache command %d\n",cmdp->OpCode));
+		if (ha->cache_feat & GDT_64BIT)
+			ha->cmd_len =
+				GDTOFFSOF(gdth_cmd_str,u.cache64.sg_lst) + sizeof(gdth_sg64_str);
+		else
+			ha->cmd_len =
+				GDTOFFSOF(gdth_cmd_str,u.cache.sg_lst) + sizeof(gdth_sg_str);
+	} else if (cmdp->Service == SCSIRAWSERVICE) {
+		TRACE2(("raw command %d\n",cmdp->OpCode));
+		if (ha->raw_feat & GDT_64BIT)
+			ha->cmd_len =
+				GDTOFFSOF(gdth_cmd_str,u.raw64.sg_lst) + sizeof(gdth_sg64_str);
+		else
+			ha->cmd_len =
+				GDTOFFSOF(gdth_cmd_str,u.raw.sg_lst) + sizeof(gdth_sg_str);
+	}
+
+	if (ha->cmd_len & 3)
+		ha->cmd_len += (4 - (ha->cmd_len & 3));
+
+	if (ha->cmd_cnt > 0) {
+		if ((ha->cmd_offs_dpmem + ha->cmd_len + DPMEM_COMMAND_OFFSET) >
+		    ha->ic_all_size) {
+			TRACE2(("gdth_special_cmd() DPMEM overflow\n"));
+			ha->cmd_tab[cmd_index-2].cmnd = UNUSED_CMND;
+			return 0;
+		}
+	}
+
+	/* copy command */
+	gdth_copy_command(ha);
+	return cmd_index;
+}
 
 
 /* Controller event handling functions */
-static gdth_evt_str *gdth_store_event(gdth_ha_str *ha, u16 source, 
-                                      u16 idx, gdth_evt_data *evt)
+static gdth_evt_str *gdth_store_event(gdth_ha_str *ha, u16 source,
+				      u16 idx, gdth_evt_data *evt)
 {
-    gdth_evt_str *e;
-
-    /* no GDTH_LOCK_HA() ! */
-    TRACE2(("gdth_store_event() source %d idx %d\n", source, idx));
-    if (source == 0)                        /* no source -> no event */
-        return NULL;
-
-    if (ebuffer[elastidx].event_source == source &&
-        ebuffer[elastidx].event_idx == idx &&
-        ((evt->size != 0 && ebuffer[elastidx].event_data.size != 0 &&
-            !memcmp((char *)&ebuffer[elastidx].event_data.eu,
-            (char *)&evt->eu, evt->size)) ||
-        (evt->size == 0 && ebuffer[elastidx].event_data.size == 0 &&
-            !strcmp((char *)&ebuffer[elastidx].event_data.event_string,
-            (char *)&evt->event_string)))) { 
-        e = &ebuffer[elastidx];
-	e->last_stamp = (u32)ktime_get_real_seconds();
-        ++e->same_count;
-    } else {
-        if (ebuffer[elastidx].event_source != 0) {  /* entry not free ? */
-            ++elastidx;
-            if (elastidx == MAX_EVENTS)
-                elastidx = 0;
-            if (elastidx == eoldidx) {              /* reached mark ? */
-                ++eoldidx;
-                if (eoldidx == MAX_EVENTS)
-                    eoldidx = 0;
-            }
-        }
-        e = &ebuffer[elastidx];
-        e->event_source = source;
-        e->event_idx = idx;
-	e->first_stamp = e->last_stamp = (u32)ktime_get_real_seconds();
-        e->same_count = 1;
-        e->event_data = *evt;
-        e->application = 0;
-    }
-    return e;
+	gdth_evt_str *e;
+
+	/* no GDTH_LOCK_HA() ! */
+	TRACE2(("gdth_store_event() source %d idx %d\n", source, idx));
+	if (source == 0)			/* no source -> no event */
+		return NULL;
+
+	if (ebuffer[elastidx].event_source == source &&
+	    ebuffer[elastidx].event_idx == idx &&
+	    ((evt->size != 0 && ebuffer[elastidx].event_data.size != 0 &&
+	      !memcmp((char *)&ebuffer[elastidx].event_data.eu,
+		      (char *)&evt->eu, evt->size)) ||
+	     (evt->size == 0 && ebuffer[elastidx].event_data.size == 0 &&
+	      !strcmp((char *)&ebuffer[elastidx].event_data.event_string,
+		      (char *)&evt->event_string)))) {
+		e = &ebuffer[elastidx];
+		e->last_stamp = (u32)ktime_get_real_seconds();
+		++e->same_count;
+	} else {
+		if (ebuffer[elastidx].event_source != 0) {  /* entry not free ? */
+			++elastidx;
+			if (elastidx == MAX_EVENTS)
+				elastidx = 0;
+			if (elastidx == eoldidx) {	/* reached mark ? */
+				++eoldidx;
+				if (eoldidx == MAX_EVENTS)
+					eoldidx = 0;
+			}
+		}
+		e = &ebuffer[elastidx];
+		e->event_source = source;
+		e->event_idx = idx;
+		e->first_stamp = e->last_stamp = (u32)ktime_get_real_seconds();
+		e->same_count = 1;
+		e->event_data = *evt;
+		e->application = 0;
+	}
+	return e;
 }
 
 static int gdth_read_event(gdth_ha_str *ha, int handle, gdth_evt_str *estr)
 {
-    gdth_evt_str *e;
-    int eindex;
-    unsigned long flags;
-
-    TRACE2(("gdth_read_event() handle %d\n", handle));
-    spin_lock_irqsave(&ha->smp_lock, flags);
-    if (handle == -1)
-        eindex = eoldidx;
-    else
-        eindex = handle;
-    estr->event_source = 0;
-
-    if (eindex < 0 || eindex >= MAX_EVENTS) {
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-        return eindex;
-    }
-    e = &ebuffer[eindex];
-    if (e->event_source != 0) {
-        if (eindex != elastidx) {
-            if (++eindex == MAX_EVENTS)
-                eindex = 0;
-        } else {
-            eindex = -1;
-        }
-        memcpy(estr, e, sizeof(gdth_evt_str));
-    }
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
-    return eindex;
+	gdth_evt_str *e;
+	int eindex;
+	unsigned long flags;
+
+	TRACE2(("gdth_read_event() handle %d\n", handle));
+	spin_lock_irqsave(&ha->smp_lock, flags);
+	if (handle == -1)
+		eindex = eoldidx;
+	else
+		eindex = handle;
+	estr->event_source = 0;
+
+	if (eindex < 0 || eindex >= MAX_EVENTS) {
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return eindex;
+	}
+	e = &ebuffer[eindex];
+	if (e->event_source != 0) {
+		if (eindex != elastidx) {
+			if (++eindex == MAX_EVENTS)
+				eindex = 0;
+		} else {
+			eindex = -1;
+		}
+		memcpy(estr, e, sizeof(gdth_evt_str));
+	}
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
+	return eindex;
 }
 
 static void gdth_readapp_event(gdth_ha_str *ha,
-                               u8 application, gdth_evt_str *estr)
+			       u8 application, gdth_evt_str *estr)
 {
-    gdth_evt_str *e;
-    int eindex;
-    unsigned long flags;
-    u8 found = FALSE;
-
-    TRACE2(("gdth_readapp_event() app. %d\n", application));
-    spin_lock_irqsave(&ha->smp_lock, flags);
-    eindex = eoldidx;
-    for (;;) {
-        e = &ebuffer[eindex];
-        if (e->event_source == 0)
-            break;
-        if ((e->application & application) == 0) {
-            e->application |= application;
-            found = TRUE;
-            break;
-        }
-        if (eindex == elastidx)
-            break;
-        if (++eindex == MAX_EVENTS)
-            eindex = 0;
-    }
-    if (found)
-        memcpy(estr, e, sizeof(gdth_evt_str));
-    else
-        estr->event_source = 0;
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
+	gdth_evt_str *e;
+	int eindex;
+	unsigned long flags;
+	u8 found = FALSE;
+
+	TRACE2(("gdth_readapp_event() app. %d\n", application));
+	spin_lock_irqsave(&ha->smp_lock, flags);
+	eindex = eoldidx;
+	for (;;) {
+		e = &ebuffer[eindex];
+		if (e->event_source == 0)
+			break;
+		if ((e->application & application) == 0) {
+			e->application |= application;
+			found = TRUE;
+			break;
+		}
+		if (eindex == elastidx)
+			break;
+		if (++eindex == MAX_EVENTS)
+			eindex = 0;
+	}
+	if (found)
+		memcpy(estr, e, sizeof(gdth_evt_str));
+	else
+		estr->event_source = 0;
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
 }
 
 static void gdth_clear_events(void)
 {
-    TRACE(("gdth_clear_events()"));
+	TRACE(("gdth_clear_events()"));
 
-    eoldidx = elastidx = 0;
-    ebuffer[0].event_source = 0;
+	eoldidx = elastidx = 0;
+	ebuffer[0].event_source = 0;
 }
 
 
 /* SCSI interface functions */
 
 static irqreturn_t __gdth_interrupt(gdth_ha_str *ha,
-                                    int gdth_from_wait, int* pIndex)
+				    int gdth_from_wait, int* pIndex)
 {
-    gdt6m_dpram_str __iomem *dp6m_ptr = NULL;
-    gdt6_dpram_str __iomem *dp6_ptr;
-    struct scsi_cmnd *scp;
-    int rval, i;
-    u8 IStatus;
-    u16 Service;
-    unsigned long flags = 0;
-
-    TRACE(("gdth_interrupt() IRQ %d\n", ha->irq));
-
-    /* if polling and not from gdth_wait() -> return */
-    if (gdth_polling) {
-        if (!gdth_from_wait) {
-            return IRQ_HANDLED;
-        }
-    }
-
-    if (!gdth_polling)
-        spin_lock_irqsave(&ha->smp_lock, flags);
-
-    /* search controller */
-    IStatus = gdth_get_status(ha);
-    if (IStatus == 0) {
-        /* spurious interrupt */
-        if (!gdth_polling)
-            spin_unlock_irqrestore(&ha->smp_lock, flags);
-        return IRQ_HANDLED;
-    }
+	gdt6m_dpram_str __iomem *dp6m_ptr = NULL;
+	gdt6_dpram_str __iomem *dp6_ptr;
+	struct scsi_cmnd *scp;
+	int rval, i;
+	u8 IStatus;
+	u16 Service;
+	unsigned long flags = 0;
+
+	TRACE(("gdth_interrupt() IRQ %d\n", ha->irq));
+
+	/* if polling and not from gdth_wait() -> return */
+	if (gdth_polling) {
+		if (!gdth_from_wait) {
+			return IRQ_HANDLED;
+		}
+	}
+
+	if (!gdth_polling)
+		spin_lock_irqsave(&ha->smp_lock, flags);
+
+	/* search controller */
+	IStatus = gdth_get_status(ha);
+	if (IStatus == 0) {
+		/* spurious interrupt */
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return IRQ_HANDLED;
+	}
 
 #ifdef GDTH_STATISTICS
-    ++act_ints;
+	++act_ints;
 #endif
 
-        if (ha->type == GDT_PCI) {
-            dp6_ptr = ha->brd;
-            if (IStatus & 0x80) {                       /* error flag */
-                IStatus &= ~0x80;
-                ha->status = readw(&dp6_ptr->u.ic.Status);
-                TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
-            } else                                      /* no error */
-                ha->status = S_OK;
-            ha->info = readl(&dp6_ptr->u.ic.Info[0]);
-            ha->service = readw(&dp6_ptr->u.ic.Service);
-            ha->info2 = readl(&dp6_ptr->u.ic.Info[1]);
-
-            writeb(0xff, &dp6_ptr->io.irqdel); /* acknowledge interrupt */
-            writeb(0, &dp6_ptr->u.ic.Cmd_Index);/* reset command index */
-            writeb(0, &dp6_ptr->io.Sema1);     /* reset status semaphore */
-        } else if (ha->type == GDT_PCINEW) {
-            if (IStatus & 0x80) {                       /* error flag */
-                IStatus &= ~0x80;
-                ha->status = inw(PTR2USHORT(&ha->plx->status));
-                TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
-            } else
-                ha->status = S_OK;
-            ha->info = inl(PTR2USHORT(&ha->plx->info[0]));
-            ha->service = inw(PTR2USHORT(&ha->plx->service));
-            ha->info2 = inl(PTR2USHORT(&ha->plx->info[1]));
-
-            outb(0xff, PTR2USHORT(&ha->plx->edoor_reg)); 
-            outb(0x00, PTR2USHORT(&ha->plx->sema1_reg)); 
-        } else if (ha->type == GDT_PCIMPR) {
-            dp6m_ptr = ha->brd;
-            if (IStatus & 0x80) {                       /* error flag */
-                IStatus &= ~0x80;
-                ha->status = readw(&dp6m_ptr->i960r.status);
-                TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
-            } else                                      /* no error */
-                ha->status = S_OK;
-
-            ha->info = readl(&dp6m_ptr->i960r.info[0]);
-            ha->service = readw(&dp6m_ptr->i960r.service);
-            ha->info2 = readl(&dp6m_ptr->i960r.info[1]);
-
-            /* event string */
-            if (IStatus == ASYNCINDEX) {
-                if (ha->service != SCREENSERVICE &&
-                    (ha->fw_vers & 0xff) >= 0x1a) {
-                    ha->dvr.severity = readb
-                        (&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.severity);
-                    for (i = 0; i < 256; ++i) {
-                        ha->dvr.event_string[i] = readb
-                            (&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.evt_str[i]);
-                        if (ha->dvr.event_string[i] == 0)
-                            break;
-                    }
-                }
-            }
-            writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
-            writeb(0, &dp6m_ptr->i960r.sema1_reg);
-        } else {
-            TRACE2(("gdth_interrupt() unknown controller type\n"));
-            if (!gdth_polling)
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            return IRQ_HANDLED;
-        }
-
-        TRACE(("gdth_interrupt() index %d stat %d info %d\n",
-               IStatus,ha->status,ha->info));
-
-        if (gdth_from_wait) {
-            *pIndex = (int)IStatus;
-        }
-
-        if (IStatus == ASYNCINDEX) {
-            TRACE2(("gdth_interrupt() async. event\n"));
-            gdth_async_event(ha);
-            if (!gdth_polling)
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            gdth_next(ha);
-            return IRQ_HANDLED;
-        } 
-
-        if (IStatus == SPEZINDEX) {
-            TRACE2(("Service unknown or not initialized !\n"));
-            ha->dvr.size = sizeof(ha->dvr.eu.driver);
-            ha->dvr.eu.driver.ionode = ha->hanum;
-            gdth_store_event(ha, ES_DRIVER, 4, &ha->dvr);
-            if (!gdth_polling)
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            return IRQ_HANDLED;
-        }
-        scp     = ha->cmd_tab[IStatus-2].cmnd;
-        Service = ha->cmd_tab[IStatus-2].service;
-        ha->cmd_tab[IStatus-2].cmnd = UNUSED_CMND;
-        if (scp == UNUSED_CMND) {
-            TRACE2(("gdth_interrupt() index to unused command (%d)\n",IStatus));
-            ha->dvr.size = sizeof(ha->dvr.eu.driver);
-            ha->dvr.eu.driver.ionode = ha->hanum;
-            ha->dvr.eu.driver.index = IStatus;
-            gdth_store_event(ha, ES_DRIVER, 1, &ha->dvr);
-            if (!gdth_polling)
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            return IRQ_HANDLED;
-        }
-        if (scp == INTERNAL_CMND) {
-            TRACE(("gdth_interrupt() answer to internal command\n"));
-            if (!gdth_polling)
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            return IRQ_HANDLED;
-        }
-
-        TRACE(("gdth_interrupt() sync. status\n"));
-        rval = gdth_sync_event(ha,Service,IStatus,scp);
-        if (!gdth_polling)
-            spin_unlock_irqrestore(&ha->smp_lock, flags);
-        if (rval == 2) {
-            gdth_putq(ha, scp, gdth_cmnd_priv(scp)->priority);
-        } else if (rval == 1) {
-            gdth_scsi_done(scp);
-        }
-
-    gdth_next(ha);
-    return IRQ_HANDLED;
+	if (ha->type == GDT_PCI) {
+		dp6_ptr = ha->brd;
+		if (IStatus & 0x80) {			/* error flag */
+			IStatus &= ~0x80;
+			ha->status = readw(&dp6_ptr->u.ic.Status);
+			TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
+		} else					/* no error */
+			ha->status = S_OK;
+		ha->info = readl(&dp6_ptr->u.ic.Info[0]);
+		ha->service = readw(&dp6_ptr->u.ic.Service);
+		ha->info2 = readl(&dp6_ptr->u.ic.Info[1]);
+
+		writeb(0xff, &dp6_ptr->io.irqdel); /* acknowledge interrupt */
+		writeb(0, &dp6_ptr->u.ic.Cmd_Index);/* reset command index */
+		writeb(0, &dp6_ptr->io.Sema1);     /* reset status semaphore */
+	} else if (ha->type == GDT_PCINEW) {
+		if (IStatus & 0x80) {			/* error flag */
+			IStatus &= ~0x80;
+			ha->status = inw(PTR2USHORT(&ha->plx->status));
+			TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
+		} else
+			ha->status = S_OK;
+		ha->info = inl(PTR2USHORT(&ha->plx->info[0]));
+		ha->service = inw(PTR2USHORT(&ha->plx->service));
+		ha->info2 = inl(PTR2USHORT(&ha->plx->info[1]));
+
+		outb(0xff, PTR2USHORT(&ha->plx->edoor_reg));
+		outb(0x00, PTR2USHORT(&ha->plx->sema1_reg));
+	} else if (ha->type == GDT_PCIMPR) {
+		dp6m_ptr = ha->brd;
+		if (IStatus & 0x80) {			/* error flag */
+			IStatus &= ~0x80;
+			ha->status = readw(&dp6m_ptr->i960r.status);
+			TRACE2(("gdth_interrupt() error %d/%d\n",IStatus,ha->status));
+		} else					/* no error */
+			ha->status = S_OK;
+
+		ha->info = readl(&dp6m_ptr->i960r.info[0]);
+		ha->service = readw(&dp6m_ptr->i960r.service);
+		ha->info2 = readl(&dp6m_ptr->i960r.info[1]);
+
+		/* event string */
+		if (IStatus == ASYNCINDEX) {
+			if (ha->service != SCREENSERVICE &&
+			    (ha->fw_vers & 0xff) >= 0x1a) {
+				ha->dvr.severity = readb
+					(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.severity);
+				for (i = 0; i < 256; ++i) {
+					ha->dvr.event_string[i] = readb
+						(&((gdt6m_dpram_str __iomem *)ha->brd)->i960r.evt_str[i]);
+					if (ha->dvr.event_string[i] == 0)
+						break;
+				}
+			}
+		}
+		writeb(0xff, &dp6m_ptr->i960r.edoor_reg);
+		writeb(0, &dp6m_ptr->i960r.sema1_reg);
+	} else {
+		TRACE2(("gdth_interrupt() unknown controller type\n"));
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return IRQ_HANDLED;
+	}
+
+	TRACE(("gdth_interrupt() index %d stat %d info %d\n",
+	       IStatus,ha->status,ha->info));
+
+	if (gdth_from_wait) {
+		*pIndex = (int)IStatus;
+	}
+
+	if (IStatus == ASYNCINDEX) {
+		TRACE2(("gdth_interrupt() async. event\n"));
+		gdth_async_event(ha);
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		gdth_next(ha);
+		return IRQ_HANDLED;
+	}
+
+	if (IStatus == SPEZINDEX) {
+		TRACE2(("Service unknown or not initialized !\n"));
+		ha->dvr.size = sizeof(ha->dvr.eu.driver);
+		ha->dvr.eu.driver.ionode = ha->hanum;
+		gdth_store_event(ha, ES_DRIVER, 4, &ha->dvr);
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return IRQ_HANDLED;
+	}
+	scp     = ha->cmd_tab[IStatus-2].cmnd;
+	Service = ha->cmd_tab[IStatus-2].service;
+	ha->cmd_tab[IStatus-2].cmnd = UNUSED_CMND;
+	if (scp == UNUSED_CMND) {
+		TRACE2(("gdth_interrupt() index to unused command (%d)\n",IStatus));
+		ha->dvr.size = sizeof(ha->dvr.eu.driver);
+		ha->dvr.eu.driver.ionode = ha->hanum;
+		ha->dvr.eu.driver.index = IStatus;
+		gdth_store_event(ha, ES_DRIVER, 1, &ha->dvr);
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return IRQ_HANDLED;
+	}
+	if (scp == INTERNAL_CMND) {
+		TRACE(("gdth_interrupt() answer to internal command\n"));
+		if (!gdth_polling)
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+		return IRQ_HANDLED;
+	}
+
+	TRACE(("gdth_interrupt() sync. status\n"));
+	rval = gdth_sync_event(ha,Service,IStatus,scp);
+	if (!gdth_polling)
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+	if (rval == 2) {
+		gdth_putq(ha, scp, gdth_cmnd_priv(scp)->priority);
+	} else if (rval == 1) {
+		gdth_scsi_done(scp);
+	}
+
+	gdth_next(ha);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t gdth_interrupt(int irq, void *dev_id)
@@ -2640,484 +2656,487 @@ static irqreturn_t gdth_interrupt(int irq, void *dev_id)
 }
 
 static int gdth_sync_event(gdth_ha_str *ha, int service, u8 index,
-                                                              struct scsi_cmnd *scp)
+			   struct scsi_cmnd *scp)
 {
-    gdth_msg_str *msg;
-    gdth_cmd_str *cmdp;
-    u8 b, t;
-    struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
-
-    cmdp = ha->pccb;
-    TRACE(("gdth_sync_event() serv %d status %d\n",
-           service,ha->status));
-
-    if (service == SCREENSERVICE) {
-        msg  = ha->pmsg;
-        TRACE(("len: %d, answer: %d, ext: %d, alen: %d\n",
-               msg->msg_len,msg->msg_answer,msg->msg_ext,msg->msg_alen));
-        if (msg->msg_len > MSGLEN+1)
-            msg->msg_len = MSGLEN+1;
-        if (msg->msg_len)
-            if (!(msg->msg_answer && msg->msg_ext)) {
-                msg->msg_text[msg->msg_len] = '\0';
-                printk("%s",msg->msg_text);
-            }
-
-        if (msg->msg_ext && !msg->msg_answer) {
-            while (gdth_test_busy(ha))
-                gdth_delay(0);
-            cmdp->Service       = SCREENSERVICE;
-            cmdp->RequestBuffer = SCREEN_CMND;
-            gdth_get_cmd_index(ha);
-            gdth_set_sema0(ha);
-            cmdp->OpCode        = GDT_READ;
-            cmdp->BoardNode     = LOCALBOARD;
-            cmdp->u.screen.reserved  = 0;
-            cmdp->u.screen.su.msg.msg_handle= msg->msg_handle;
-            cmdp->u.screen.su.msg.msg_addr  = ha->msg_phys;
-            ha->cmd_offs_dpmem = 0;
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr) 
-                + sizeof(u64);
-            ha->cmd_cnt = 0;
-            gdth_copy_command(ha);
-            gdth_release_event(ha);
-            return 0;
-        }
-
-        if (msg->msg_answer && msg->msg_alen) {
-            /* default answers (getchar() not possible) */
-            if (msg->msg_alen == 1) {
-                msg->msg_alen = 0;
-                msg->msg_len = 1;
-                msg->msg_text[0] = 0;
-            } else {
-                msg->msg_alen -= 2;
-                msg->msg_len = 2;
-                msg->msg_text[0] = 1;
-                msg->msg_text[1] = 0;
-            }
-            msg->msg_ext    = 0;
-            msg->msg_answer = 0;
-            while (gdth_test_busy(ha))
-                gdth_delay(0);
-            cmdp->Service       = SCREENSERVICE;
-            cmdp->RequestBuffer = SCREEN_CMND;
-            gdth_get_cmd_index(ha);
-            gdth_set_sema0(ha);
-            cmdp->OpCode        = GDT_WRITE;
-            cmdp->BoardNode     = LOCALBOARD;
-            cmdp->u.screen.reserved  = 0;
-            cmdp->u.screen.su.msg.msg_handle= msg->msg_handle;
-            cmdp->u.screen.su.msg.msg_addr  = ha->msg_phys;
-            ha->cmd_offs_dpmem = 0;
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr) 
-                + sizeof(u64);
-            ha->cmd_cnt = 0;
-            gdth_copy_command(ha);
-            gdth_release_event(ha);
-            return 0;
-        }
-        printk("\n");
-
-    } else {
-        b = scp->device->channel;
-        t = scp->device->id;
-        if (cmndinfo->OpCode == -1 && b != ha->virt_bus) {
-            ha->raw[BUS_L2P(ha,b)].io_cnt[t]--;
-        }
-        /* cache or raw service */
-        if (ha->status == S_BSY) {
-            TRACE2(("Controller busy -> retry !\n"));
-            if (cmndinfo->OpCode == GDT_MOUNT)
-                cmndinfo->OpCode = GDT_CLUST_INFO;
-            /* retry */
-            return 2;
-        }
-        if (scsi_bufflen(scp))
-            dma_unmap_sg(&ha->pdev->dev, scsi_sglist(scp), scsi_sg_count(scp),
-                         cmndinfo->dma_dir);
-
-        if (cmndinfo->sense_paddr)
-            dma_unmap_page(&ha->pdev->dev, cmndinfo->sense_paddr, 16,
-			   DMA_FROM_DEVICE);
-
-        if (ha->status == S_OK) {
-            cmndinfo->status = S_OK;
-            cmndinfo->info = ha->info;
-            if (cmndinfo->OpCode != -1) {
-                TRACE2(("gdth_sync_event(): special cmd 0x%x OK\n",
-                        cmndinfo->OpCode));
-                /* special commands GDT_CLUST_INFO/GDT_MOUNT ? */
-                if (cmndinfo->OpCode == GDT_CLUST_INFO) {
-                    ha->hdr[t].cluster_type = (u8)ha->info;
-                    if (!(ha->hdr[t].cluster_type & 
-                        CLUSTER_MOUNTED)) {
-                        /* NOT MOUNTED -> MOUNT */
-                        cmndinfo->OpCode = GDT_MOUNT;
-                        if (ha->hdr[t].cluster_type & 
-                            CLUSTER_RESERVED) {
-                            /* cluster drive RESERVED (on the other node) */
-                            cmndinfo->phase = -2;      /* reservation conflict */
-                        }
-                    } else {
-                        cmndinfo->OpCode = -1;
-                    }
-                } else {
-                    if (cmndinfo->OpCode == GDT_MOUNT) {
-                        ha->hdr[t].cluster_type |= CLUSTER_MOUNTED;
-                        ha->hdr[t].media_changed = TRUE;
-                    } else if (cmndinfo->OpCode == GDT_UNMOUNT) {
-                        ha->hdr[t].cluster_type &= ~CLUSTER_MOUNTED;
-                        ha->hdr[t].media_changed = TRUE;
-                    } 
-                    cmndinfo->OpCode = -1;
-                }
-                /* retry */
-                cmndinfo->priority = HIGH_PRI;
-                return 2;
-            } else {
-                /* RESERVE/RELEASE ? */
-                if (scp->cmnd[0] == RESERVE) {
-                    ha->hdr[t].cluster_type |= CLUSTER_RESERVED;
-                } else if (scp->cmnd[0] == RELEASE) {
-                    ha->hdr[t].cluster_type &= ~CLUSTER_RESERVED;
-                }           
-                scp->result = DID_OK << 16;
-                scp->sense_buffer[0] = 0;
-            }
-        } else {
-            cmndinfo->status = ha->status;
-            cmndinfo->info = ha->info;
-
-            if (cmndinfo->OpCode != -1) {
-                TRACE2(("gdth_sync_event(): special cmd 0x%x error 0x%x\n",
-                        cmndinfo->OpCode, ha->status));
-                if (cmndinfo->OpCode == GDT_SCAN_START ||
-                    cmndinfo->OpCode == GDT_SCAN_END) {
-                    cmndinfo->OpCode = -1;
-                    /* retry */
-                    cmndinfo->priority = HIGH_PRI;
-                    return 2;
-                }
-                memset((char*)scp->sense_buffer,0,16);
-                scp->sense_buffer[0] = 0x70;
-                scp->sense_buffer[2] = NOT_READY;
-                scp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-            } else if (service == CACHESERVICE) {
-                if (ha->status == S_CACHE_UNKNOWN &&
-                    (ha->hdr[t].cluster_type & 
-                     CLUSTER_RESERVE_STATE) == CLUSTER_RESERVE_STATE) {
-                    /* bus reset -> force GDT_CLUST_INFO */
-                    ha->hdr[t].cluster_type &= ~CLUSTER_RESERVED;
-                }
-                memset((char*)scp->sense_buffer,0,16);
-                if (ha->status == (u16)S_CACHE_RESERV) {
-                    scp->result = (DID_OK << 16) | (RESERVATION_CONFLICT << 1);
-                } else {
-                    scp->sense_buffer[0] = 0x70;
-                    scp->sense_buffer[2] = NOT_READY;
-                    scp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-                }
-                if (!cmndinfo->internal_command) {
-                    ha->dvr.size = sizeof(ha->dvr.eu.sync);
-                    ha->dvr.eu.sync.ionode  = ha->hanum;
-                    ha->dvr.eu.sync.service = service;
-                    ha->dvr.eu.sync.status  = ha->status;
-                    ha->dvr.eu.sync.info    = ha->info;
-                    ha->dvr.eu.sync.hostdrive = t;
-                    if (ha->status >= 0x8000)
-                        gdth_store_event(ha, ES_SYNC, 0, &ha->dvr);
-                    else
-                        gdth_store_event(ha, ES_SYNC, service, &ha->dvr);
-                }
-            } else {
-                /* sense buffer filled from controller firmware (DMA) */
-                if (ha->status != S_RAW_SCSI || ha->info >= 0x100) {
-                    scp->result = DID_BAD_TARGET << 16;
-                } else {
-                    scp->result = (DID_OK << 16) | ha->info;
-                }
-            }
-        }
-        if (!cmndinfo->wait_for_completion)
-            cmndinfo->wait_for_completion++;
-        else 
-            return 1;
-    }
-
-    return 0;
+	gdth_msg_str *msg;
+	gdth_cmd_str *cmdp;
+	u8 b, t;
+	struct gdth_cmndinfo *cmndinfo = gdth_cmnd_priv(scp);
+
+	cmdp = ha->pccb;
+	TRACE(("gdth_sync_event() serv %d status %d\n",
+	       service,ha->status));
+
+	if (service == SCREENSERVICE) {
+		msg  = ha->pmsg;
+		TRACE(("len: %d, answer: %d, ext: %d, alen: %d\n",
+		       msg->msg_len,msg->msg_answer,msg->msg_ext,msg->msg_alen));
+		if (msg->msg_len > MSGLEN+1)
+			msg->msg_len = MSGLEN+1;
+		if (msg->msg_len)
+			if (!(msg->msg_answer && msg->msg_ext)) {
+				msg->msg_text[msg->msg_len] = '\0';
+				printk("%s",msg->msg_text);
+			}
+
+		if (msg->msg_ext && !msg->msg_answer) {
+			while (gdth_test_busy(ha))
+				gdth_delay(0);
+			cmdp->Service = SCREENSERVICE;
+			cmdp->RequestBuffer = SCREEN_CMND;
+			gdth_get_cmd_index(ha);
+			gdth_set_sema0(ha);
+			cmdp->OpCode = GDT_READ;
+			cmdp->BoardNode = LOCALBOARD;
+			cmdp->u.screen.reserved  = 0;
+			cmdp->u.screen.su.msg.msg_handle = msg->msg_handle;
+			cmdp->u.screen.su.msg.msg_addr = ha->msg_phys;
+			ha->cmd_offs_dpmem = 0;
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr)
+				+ sizeof(u64);
+			ha->cmd_cnt = 0;
+			gdth_copy_command(ha);
+			gdth_release_event(ha);
+			return 0;
+		}
+
+		if (msg->msg_answer && msg->msg_alen) {
+			/* default answers (getchar() not possible) */
+			if (msg->msg_alen == 1) {
+				msg->msg_alen = 0;
+				msg->msg_len = 1;
+				msg->msg_text[0] = 0;
+			} else {
+				msg->msg_alen -= 2;
+				msg->msg_len = 2;
+				msg->msg_text[0] = 1;
+				msg->msg_text[1] = 0;
+			}
+			msg->msg_ext = 0;
+			msg->msg_answer = 0;
+			while (gdth_test_busy(ha))
+				gdth_delay(0);
+			cmdp->Service = SCREENSERVICE;
+			cmdp->RequestBuffer = SCREEN_CMND;
+			gdth_get_cmd_index(ha);
+			gdth_set_sema0(ha);
+			cmdp->OpCode = GDT_WRITE;
+			cmdp->BoardNode = LOCALBOARD;
+			cmdp->u.screen.reserved = 0;
+			cmdp->u.screen.su.msg.msg_handle = msg->msg_handle;
+			cmdp->u.screen.su.msg.msg_addr = ha->msg_phys;
+			ha->cmd_offs_dpmem = 0;
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr)
+				+ sizeof(u64);
+			ha->cmd_cnt = 0;
+			gdth_copy_command(ha);
+			gdth_release_event(ha);
+			return 0;
+		}
+		printk("\n");
+
+	} else {
+		b = scp->device->channel;
+		t = scp->device->id;
+		if (cmndinfo->OpCode == -1 && b != ha->virt_bus) {
+			ha->raw[BUS_L2P(ha,b)].io_cnt[t]--;
+		}
+		/* cache or raw service */
+		if (ha->status == S_BSY) {
+			TRACE2(("Controller busy -> retry !\n"));
+			if (cmndinfo->OpCode == GDT_MOUNT)
+				cmndinfo->OpCode = GDT_CLUST_INFO;
+			/* retry */
+			return 2;
+		}
+		if (scsi_bufflen(scp))
+			dma_unmap_sg(&ha->pdev->dev, scsi_sglist(scp), scsi_sg_count(scp),
+				     cmndinfo->dma_dir);
+
+		if (cmndinfo->sense_paddr)
+			dma_unmap_page(&ha->pdev->dev, cmndinfo->sense_paddr, 16,
+				       DMA_FROM_DEVICE);
+
+		if (ha->status == S_OK) {
+			cmndinfo->status = S_OK;
+			cmndinfo->info = ha->info;
+			if (cmndinfo->OpCode != -1) {
+				TRACE2(("gdth_sync_event(): special cmd 0x%x OK\n",
+					cmndinfo->OpCode));
+				/* special commands GDT_CLUST_INFO/GDT_MOUNT ? */
+				if (cmndinfo->OpCode == GDT_CLUST_INFO) {
+					ha->hdr[t].cluster_type = (u8)ha->info;
+					if (!(ha->hdr[t].cluster_type &
+					      CLUSTER_MOUNTED)) {
+						/* NOT MOUNTED -> MOUNT */
+						cmndinfo->OpCode = GDT_MOUNT;
+						if (ha->hdr[t].cluster_type &
+						    CLUSTER_RESERVED) {
+							/* cluster drive RESERVED (on the other node) */
+							cmndinfo->phase = -2;      /* reservation conflict */
+						}
+					} else {
+						cmndinfo->OpCode = -1;
+					}
+				} else {
+					if (cmndinfo->OpCode == GDT_MOUNT) {
+						ha->hdr[t].cluster_type |= CLUSTER_MOUNTED;
+						ha->hdr[t].media_changed = TRUE;
+					} else if (cmndinfo->OpCode == GDT_UNMOUNT) {
+						ha->hdr[t].cluster_type &= ~CLUSTER_MOUNTED;
+						ha->hdr[t].media_changed = TRUE;
+					}
+					cmndinfo->OpCode = -1;
+				}
+				/* retry */
+				cmndinfo->priority = HIGH_PRI;
+				return 2;
+			} else {
+				/* RESERVE/RELEASE ? */
+				if (scp->cmnd[0] == RESERVE) {
+					ha->hdr[t].cluster_type |= CLUSTER_RESERVED;
+				} else if (scp->cmnd[0] == RELEASE) {
+					ha->hdr[t].cluster_type &= ~CLUSTER_RESERVED;
+				}
+				scp->result = DID_OK << 16;
+				scp->sense_buffer[0] = 0;
+			}
+		} else {
+			cmndinfo->status = ha->status;
+			cmndinfo->info = ha->info;
+
+			if (cmndinfo->OpCode != -1) {
+				TRACE2(("gdth_sync_event(): special cmd 0x%x error 0x%x\n",
+					cmndinfo->OpCode, ha->status));
+				if (cmndinfo->OpCode == GDT_SCAN_START ||
+				    cmndinfo->OpCode == GDT_SCAN_END) {
+					cmndinfo->OpCode = -1;
+					/* retry */
+					cmndinfo->priority = HIGH_PRI;
+					return 2;
+				}
+				memset((char*)scp->sense_buffer,0,16);
+				scp->sense_buffer[0] = 0x70;
+				scp->sense_buffer[2] = NOT_READY;
+				scp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+			} else if (service == CACHESERVICE) {
+				if (ha->status == S_CACHE_UNKNOWN &&
+				    (ha->hdr[t].cluster_type &
+				     CLUSTER_RESERVE_STATE) == CLUSTER_RESERVE_STATE) {
+					/* bus reset -> force GDT_CLUST_INFO */
+					ha->hdr[t].cluster_type &= ~CLUSTER_RESERVED;
+				}
+				memset((char*)scp->sense_buffer,0,16);
+				if (ha->status == (u16)S_CACHE_RESERV) {
+					scp->result = (DID_OK << 16) | (RESERVATION_CONFLICT << 1);
+				} else {
+					scp->sense_buffer[0] = 0x70;
+					scp->sense_buffer[2] = NOT_READY;
+					scp->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+				}
+				if (!cmndinfo->internal_command) {
+					ha->dvr.size = sizeof(ha->dvr.eu.sync);
+					ha->dvr.eu.sync.ionode  = ha->hanum;
+					ha->dvr.eu.sync.service = service;
+					ha->dvr.eu.sync.status  = ha->status;
+					ha->dvr.eu.sync.info    = ha->info;
+					ha->dvr.eu.sync.hostdrive = t;
+					if (ha->status >= 0x8000)
+						gdth_store_event(ha, ES_SYNC, 0, &ha->dvr);
+					else
+						gdth_store_event(ha, ES_SYNC, service, &ha->dvr);
+				}
+			} else {
+				/* sense buffer filled from controller firmware (DMA) */
+				if (ha->status != S_RAW_SCSI || ha->info >= 0x100) {
+					scp->result = DID_BAD_TARGET << 16;
+				} else {
+					scp->result = (DID_OK << 16) | ha->info;
+				}
+			}
+		}
+		if (!cmndinfo->wait_for_completion)
+			cmndinfo->wait_for_completion++;
+		else
+			return 1;
+	}
+
+	return 0;
 }
 
 static char *async_cache_tab[] = {
-/* 0*/  "\011\000\002\002\002\004\002\006\004"
-        "GDT HA %u, service %u, async. status %u/%lu unknown",
-/* 1*/  "\011\000\002\002\002\004\002\006\004"
-        "GDT HA %u, service %u, async. status %u/%lu unknown",
-/* 2*/  "\005\000\002\006\004"
-        "GDT HA %u, Host Drive %lu not ready",
-/* 3*/  "\005\000\002\006\004"
-        "GDT HA %u, Host Drive %lu: REASSIGN not successful and/or data error on reassigned blocks. Drive may crash in the future and should be replaced",
-/* 4*/  "\005\000\002\006\004"
-        "GDT HA %u, mirror update on Host Drive %lu failed",
-/* 5*/  "\005\000\002\006\004"
-        "GDT HA %u, Mirror Drive %lu failed",
-/* 6*/  "\005\000\002\006\004"
-        "GDT HA %u, Mirror Drive %lu: REASSIGN not successful and/or data error on reassigned blocks. Drive may crash in the future and should be replaced",
-/* 7*/  "\005\000\002\006\004"
-        "GDT HA %u, Host Drive %lu write protected",
-/* 8*/  "\005\000\002\006\004"
-        "GDT HA %u, media changed in Host Drive %lu",
-/* 9*/  "\005\000\002\006\004"
-        "GDT HA %u, Host Drive %lu is offline",
-/*10*/  "\005\000\002\006\004"
-        "GDT HA %u, media change of Mirror Drive %lu",
-/*11*/  "\005\000\002\006\004"
-        "GDT HA %u, Mirror Drive %lu is write protected",
-/*12*/  "\005\000\002\006\004"
-        "GDT HA %u, general error on Host Drive %lu. Please check the devices of this drive!",
-/*13*/  "\007\000\002\006\002\010\002"
-        "GDT HA %u, Array Drive %u: Cache Drive %u failed",
-/*14*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: FAIL state entered",
-/*15*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: error",
-/*16*/  "\007\000\002\006\002\010\002"
-        "GDT HA %u, Array Drive %u: failed drive replaced by Cache Drive %u",
-/*17*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity build failed",
-/*18*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive rebuild failed",
-/*19*/  "\005\000\002\010\002"
-        "GDT HA %u, Test of Hot Fix %u failed",
-/*20*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive build finished successfully",
-/*21*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive rebuild finished successfully",
-/*22*/  "\007\000\002\006\002\010\002"
-        "GDT HA %u, Array Drive %u: Hot Fix %u activated",
-/*23*/  "\005\000\002\006\002"
-        "GDT HA %u, Host Drive %u: processing of i/o aborted due to serious drive error",
-/*24*/  "\005\000\002\010\002"
-        "GDT HA %u, mirror update on Cache Drive %u completed",
-/*25*/  "\005\000\002\010\002"
-        "GDT HA %u, mirror update on Cache Drive %lu failed",
-/*26*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive rebuild started",
-/*27*/  "\005\000\002\012\001"
-        "GDT HA %u, Fault bus %u: SHELF OK detected",
-/*28*/  "\005\000\002\012\001"
-        "GDT HA %u, Fault bus %u: SHELF not OK detected",
-/*29*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug started",
-/*30*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: new disk detected",
-/*31*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: old disk detected",
-/*32*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: plugging an active disk is invalid",
-/*33*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: invalid device detected",
-/*34*/  "\011\000\002\012\001\013\001\006\004"
-        "GDT HA %u, Fault bus %u, ID %u: insufficient disk capacity (%lu MB required)",
-/*35*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: disk write protected",
-/*36*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: disk not available",
-/*37*/  "\007\000\002\012\001\006\004"
-        "GDT HA %u, Fault bus %u: swap detected (%lu)",
-/*38*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug finished successfully",
-/*39*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug aborted due to user Hot Plug",
-/*40*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug aborted",
-/*41*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug for Hot Fix started",
-/*42*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive build started",
-/*43*/  "\003\000\002"
-        "GDT HA %u, DRAM parity error detected",
-/*44*/  "\005\000\002\006\002"
-        "GDT HA %u, Mirror Drive %u: update started",
-/*45*/  "\007\000\002\006\002\010\002"
-        "GDT HA %u, Mirror Drive %u: Hot Fix %u activated",
-/*46*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: no matching Pool Hot Fix Drive available",
-/*47*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: Pool Hot Fix Drive available",
-/*48*/  "\005\000\002\006\002"
-        "GDT HA %u, Mirror Drive %u: no matching Pool Hot Fix Drive available",
-/*49*/  "\005\000\002\006\002"
-        "GDT HA %u, Mirror Drive %u: Pool Hot Fix Drive available",
-/*50*/  "\007\000\002\012\001\013\001"
-        "GDT HA %u, SCSI bus %u, ID %u: IGNORE_WIDE_RESIDUE message received",
-/*51*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: expand started",
-/*52*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: expand finished successfully",
-/*53*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: expand failed",
-/*54*/  "\003\000\002"
-        "GDT HA %u, CPU temperature critical",
-/*55*/  "\003\000\002"
-        "GDT HA %u, CPU temperature OK",
-/*56*/  "\005\000\002\006\004"
-        "GDT HA %u, Host drive %lu created",
-/*57*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: expand restarted",
-/*58*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: expand stopped",
-/*59*/  "\005\000\002\010\002"
-        "GDT HA %u, Mirror Drive %u: drive build quited",
-/*60*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity build quited",
-/*61*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: drive rebuild quited",
-/*62*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity verify started",
-/*63*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity verify done",
-/*64*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity verify failed",
-/*65*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity error detected",
-/*66*/  "\005\000\002\006\002"
-        "GDT HA %u, Array Drive %u: parity verify quited",
-/*67*/  "\005\000\002\006\002"
-        "GDT HA %u, Host Drive %u reserved",
-/*68*/  "\005\000\002\006\002"
-        "GDT HA %u, Host Drive %u mounted and released",
-/*69*/  "\005\000\002\006\002"
-        "GDT HA %u, Host Drive %u released",
-/*70*/  "\003\000\002"
-        "GDT HA %u, DRAM error detected and corrected with ECC",
-/*71*/  "\003\000\002"
-        "GDT HA %u, Uncorrectable DRAM error detected with ECC",
-/*72*/  "\011\000\002\012\001\013\001\014\001"
-        "GDT HA %u, SCSI bus %u, ID %u, LUN %u: reassigning block",
-/*73*/  "\005\000\002\006\002"
-        "GDT HA %u, Host drive %u resetted locally",
-/*74*/  "\005\000\002\006\002"
-        "GDT HA %u, Host drive %u resetted remotely",
-/*75*/  "\003\000\002"
-        "GDT HA %u, async. status 75 unknown",
+	/* 0*/  "\011\000\002\002\002\004\002\006\004"
+	"GDT HA %u, service %u, async. status %u/%lu unknown",
+	/* 1*/  "\011\000\002\002\002\004\002\006\004"
+	"GDT HA %u, service %u, async. status %u/%lu unknown",
+	/* 2*/  "\005\000\002\006\004"
+	"GDT HA %u, Host Drive %lu not ready",
+	/* 3*/  "\005\000\002\006\004"
+	"GDT HA %u, Host Drive %lu: REASSIGN not successful and/or data error on reassigned blocks. Drive may crash in the future and should be replaced",
+	/* 4*/  "\005\000\002\006\004"
+	"GDT HA %u, mirror update on Host Drive %lu failed",
+	/* 5*/  "\005\000\002\006\004"
+	"GDT HA %u, Mirror Drive %lu failed",
+	/* 6*/  "\005\000\002\006\004"
+	"GDT HA %u, Mirror Drive %lu: REASSIGN not successful and/or data error on reassigned blocks. Drive may crash in the future and should be replaced",
+	/* 7*/  "\005\000\002\006\004"
+	"GDT HA %u, Host Drive %lu write protected",
+	/* 8*/  "\005\000\002\006\004"
+	"GDT HA %u, media changed in Host Drive %lu",
+	/* 9*/  "\005\000\002\006\004"
+	"GDT HA %u, Host Drive %lu is offline",
+	/*10*/  "\005\000\002\006\004"
+	"GDT HA %u, media change of Mirror Drive %lu",
+	/*11*/  "\005\000\002\006\004"
+	"GDT HA %u, Mirror Drive %lu is write protected",
+	/*12*/  "\005\000\002\006\004"
+	"GDT HA %u, general error on Host Drive %lu. Please check the devices of this drive!",
+	/*13*/  "\007\000\002\006\002\010\002"
+	"GDT HA %u, Array Drive %u: Cache Drive %u failed",
+	/*14*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: FAIL state entered",
+	/*15*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: error",
+	/*16*/  "\007\000\002\006\002\010\002"
+	"GDT HA %u, Array Drive %u: failed drive replaced by Cache Drive %u",
+	/*17*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity build failed",
+	/*18*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive rebuild failed",
+	/*19*/  "\005\000\002\010\002"
+	"GDT HA %u, Test of Hot Fix %u failed",
+	/*20*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive build finished successfully",
+	/*21*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive rebuild finished successfully",
+	/*22*/  "\007\000\002\006\002\010\002"
+	"GDT HA %u, Array Drive %u: Hot Fix %u activated",
+	/*23*/  "\005\000\002\006\002"
+	"GDT HA %u, Host Drive %u: processing of i/o aborted due to serious drive error",
+	/*24*/  "\005\000\002\010\002"
+	"GDT HA %u, mirror update on Cache Drive %u completed",
+	/*25*/  "\005\000\002\010\002"
+	"GDT HA %u, mirror update on Cache Drive %lu failed",
+	/*26*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive rebuild started",
+	/*27*/  "\005\000\002\012\001"
+	"GDT HA %u, Fault bus %u: SHELF OK detected",
+	/*28*/  "\005\000\002\012\001"
+	"GDT HA %u, Fault bus %u: SHELF not OK detected",
+	/*29*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug started",
+	/*30*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: new disk detected",
+	/*31*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: old disk detected",
+	/*32*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: plugging an active disk is invalid",
+	/*33*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: invalid device detected",
+	/*34*/  "\011\000\002\012\001\013\001\006\004"
+	"GDT HA %u, Fault bus %u, ID %u: insufficient disk capacity (%lu MB required)",
+	/*35*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: disk write protected",
+	/*36*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: disk not available",
+	/*37*/  "\007\000\002\012\001\006\004"
+	"GDT HA %u, Fault bus %u: swap detected (%lu)",
+	/*38*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug finished successfully",
+	/*39*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug aborted due to user Hot Plug",
+	/*40*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug aborted",
+	/*41*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, Fault bus %u, ID %u: Auto Hot Plug for Hot Fix started",
+	/*42*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive build started",
+	/*43*/  "\003\000\002"
+	"GDT HA %u, DRAM parity error detected",
+	/*44*/  "\005\000\002\006\002"
+	"GDT HA %u, Mirror Drive %u: update started",
+	/*45*/  "\007\000\002\006\002\010\002"
+	"GDT HA %u, Mirror Drive %u: Hot Fix %u activated",
+	/*46*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: no matching Pool Hot Fix Drive available",
+	/*47*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: Pool Hot Fix Drive available",
+	/*48*/  "\005\000\002\006\002"
+	"GDT HA %u, Mirror Drive %u: no matching Pool Hot Fix Drive available",
+	/*49*/  "\005\000\002\006\002"
+	"GDT HA %u, Mirror Drive %u: Pool Hot Fix Drive available",
+	/*50*/  "\007\000\002\012\001\013\001"
+	"GDT HA %u, SCSI bus %u, ID %u: IGNORE_WIDE_RESIDUE message received",
+	/*51*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: expand started",
+	/*52*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: expand finished successfully",
+	/*53*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: expand failed",
+	/*54*/  "\003\000\002"
+	"GDT HA %u, CPU temperature critical",
+	/*55*/  "\003\000\002"
+	"GDT HA %u, CPU temperature OK",
+	/*56*/  "\005\000\002\006\004"
+	"GDT HA %u, Host drive %lu created",
+	/*57*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: expand restarted",
+	/*58*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: expand stopped",
+	/*59*/  "\005\000\002\010\002"
+	"GDT HA %u, Mirror Drive %u: drive build quited",
+	/*60*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity build quited",
+	/*61*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: drive rebuild quited",
+	/*62*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity verify started",
+	/*63*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity verify done",
+	/*64*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity verify failed",
+	/*65*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity error detected",
+	/*66*/  "\005\000\002\006\002"
+	"GDT HA %u, Array Drive %u: parity verify quited",
+	/*67*/  "\005\000\002\006\002"
+	"GDT HA %u, Host Drive %u reserved",
+	/*68*/  "\005\000\002\006\002"
+	"GDT HA %u, Host Drive %u mounted and released",
+	/*69*/  "\005\000\002\006\002"
+	"GDT HA %u, Host Drive %u released",
+	/*70*/  "\003\000\002"
+	"GDT HA %u, DRAM error detected and corrected with ECC",
+	/*71*/  "\003\000\002"
+	"GDT HA %u, Uncorrectable DRAM error detected with ECC",
+	/*72*/  "\011\000\002\012\001\013\001\014\001"
+	"GDT HA %u, SCSI bus %u, ID %u, LUN %u: reassigning block",
+	/*73*/  "\005\000\002\006\002"
+	"GDT HA %u, Host drive %u resetted locally",
+	/*74*/  "\005\000\002\006\002"
+	"GDT HA %u, Host drive %u resetted remotely",
+	/*75*/  "\003\000\002"
+	"GDT HA %u, async. status 75 unknown",
 };
 
 
 static int gdth_async_event(gdth_ha_str *ha)
 {
-    gdth_cmd_str *cmdp;
-    int cmd_index;
-
-    cmdp= ha->pccb;
-    TRACE2(("gdth_async_event() ha %d serv %d\n",
-            ha->hanum, ha->service));
-
-    if (ha->service == SCREENSERVICE) {
-        if (ha->status == MSG_REQUEST) {
-            while (gdth_test_busy(ha))
-                gdth_delay(0);
-            cmdp->Service       = SCREENSERVICE;
-            cmdp->RequestBuffer = SCREEN_CMND;
-            cmd_index = gdth_get_cmd_index(ha);
-            gdth_set_sema0(ha);
-            cmdp->OpCode        = GDT_READ;
-            cmdp->BoardNode     = LOCALBOARD;
-            cmdp->u.screen.reserved  = 0;
-            cmdp->u.screen.su.msg.msg_handle= MSG_INV_HANDLE;
-            cmdp->u.screen.su.msg.msg_addr  = ha->msg_phys;
-            ha->cmd_offs_dpmem = 0;
-            ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr) 
-                + sizeof(u64);
-            ha->cmd_cnt = 0;
-            gdth_copy_command(ha);
-            printk("[PCI %d/%d] ",(u16)(ha->brd_phys>>8),
-                       (u16)((ha->brd_phys>>3)&0x1f));
-            gdth_release_event(ha);
-        }
-
-    } else {
-        if (ha->type == GDT_PCIMPR && 
-            (ha->fw_vers & 0xff) >= 0x1a) {
-            ha->dvr.size = 0;
-            ha->dvr.eu.async.ionode = ha->hanum;
-            ha->dvr.eu.async.status  = ha->status;
-            /* severity and event_string already set! */
-        } else {        
-            ha->dvr.size = sizeof(ha->dvr.eu.async);
-            ha->dvr.eu.async.ionode   = ha->hanum;
-            ha->dvr.eu.async.service = ha->service;
-            ha->dvr.eu.async.status  = ha->status;
-            ha->dvr.eu.async.info    = ha->info;
-            *(u32 *)ha->dvr.eu.async.scsi_coord  = ha->info2;
-        }
-        gdth_store_event( ha, ES_ASYNC, ha->service, &ha->dvr );
-        gdth_log_event( &ha->dvr, NULL );
-    
-        /* new host drive from expand? */
-        if (ha->service == CACHESERVICE && ha->status == 56) {
-            TRACE2(("gdth_async_event(): new host drive %d created\n",
-                    (u16)ha->info));
-            /* gdth_analyse_hdrive(hanum, (u16)ha->info); */
-        }   
-    }
-    return 1;
+	gdth_cmd_str *cmdp;
+	int cmd_index;
+
+	cmdp= ha->pccb;
+	TRACE2(("gdth_async_event() ha %d serv %d\n",
+		ha->hanum, ha->service));
+
+	if (ha->service == SCREENSERVICE) {
+		if (ha->status == MSG_REQUEST) {
+			while (gdth_test_busy(ha))
+				gdth_delay(0);
+			cmdp->Service = SCREENSERVICE;
+			cmdp->RequestBuffer = SCREEN_CMND;
+			cmd_index = gdth_get_cmd_index(ha);
+			gdth_set_sema0(ha);
+			cmdp->OpCode = GDT_READ;
+			cmdp->BoardNode = LOCALBOARD;
+			cmdp->u.screen.reserved = 0;
+			cmdp->u.screen.su.msg.msg_handle = MSG_INV_HANDLE;
+			cmdp->u.screen.su.msg.msg_addr = ha->msg_phys;
+			ha->cmd_offs_dpmem = 0;
+			ha->cmd_len = GDTOFFSOF(gdth_cmd_str,u.screen.su.msg.msg_addr)
+				+ sizeof(u64);
+			ha->cmd_cnt = 0;
+			gdth_copy_command(ha);
+			printk("[PCI %d/%d] ",(u16)(ha->brd_phys>>8),
+			       (u16)((ha->brd_phys>>3)&0x1f));
+			gdth_release_event(ha);
+		}
+
+	} else {
+		if (ha->type == GDT_PCIMPR &&
+		    (ha->fw_vers & 0xff) >= 0x1a) {
+			ha->dvr.size = 0;
+			ha->dvr.eu.async.ionode = ha->hanum;
+			ha->dvr.eu.async.status = ha->status;
+			/* severity and event_string already set! */
+		} else {
+			ha->dvr.size = sizeof(ha->dvr.eu.async);
+			ha->dvr.eu.async.ionode = ha->hanum;
+			ha->dvr.eu.async.service = ha->service;
+			ha->dvr.eu.async.status = ha->status;
+			ha->dvr.eu.async.info = ha->info;
+			*(u32 *)ha->dvr.eu.async.scsi_coord  = ha->info2;
+		}
+		gdth_store_event( ha, ES_ASYNC, ha->service, &ha->dvr );
+		gdth_log_event( &ha->dvr, NULL );
+
+		/* new host drive from expand? */
+		if (ha->service == CACHESERVICE && ha->status == 56) {
+			TRACE2(("gdth_async_event(): new host drive %d created\n",
+				(u16)ha->info));
+			/* gdth_analyse_hdrive(hanum, (u16)ha->info); */
+		}
+	}
+	return 1;
 }
 
 static void gdth_log_event(gdth_evt_data *dvr, char *buffer)
 {
-    gdth_stackframe stack;
-    char *f = NULL;
-    int i,j;
-
-    TRACE2(("gdth_log_event()\n"));
-    if (dvr->size == 0) {
-        if (buffer == NULL) {
-            printk("Adapter %d: %s\n",dvr->eu.async.ionode,dvr->event_string); 
-        } else {
-            sprintf(buffer,"Adapter %d: %s\n",
-                dvr->eu.async.ionode,dvr->event_string); 
-        }
-    } else if (dvr->eu.async.service == CACHESERVICE && 
-        INDEX_OK(dvr->eu.async.status, async_cache_tab)) {
-        TRACE2(("GDT: Async. event cache service, event no.: %d\n",
-                dvr->eu.async.status));
-        
-        f = async_cache_tab[dvr->eu.async.status];
-        
-        /* i: parameter to push, j: stack element to fill */
-        for (j=0,i=1; i < f[0]; i+=2) {
-            switch (f[i+1]) {
-              case 4:
-                stack.b[j++] = *(u32*)&dvr->eu.stream[(int)f[i]];
-                break;
-              case 2:
-                stack.b[j++] = *(u16*)&dvr->eu.stream[(int)f[i]];
-                break;
-              case 1:
-                stack.b[j++] = *(u8*)&dvr->eu.stream[(int)f[i]];
-                break;
-              default:
-                break;
-            }
-        }
-        
-        if (buffer == NULL) {
-            printk(&f[(int)f[0]],stack); 
-            printk("\n");
-        } else {
-            sprintf(buffer,&f[(int)f[0]],stack); 
-        }
-
-    } else {
-        if (buffer == NULL) {
-            printk("GDT HA %u, Unknown async. event service %d event no. %d\n",
-                   dvr->eu.async.ionode,dvr->eu.async.service,dvr->eu.async.status);
-        } else {
-            sprintf(buffer,"GDT HA %u, Unknown async. event service %d event no. %d",
-                    dvr->eu.async.ionode,dvr->eu.async.service,dvr->eu.async.status);
-        }
-    }
+	gdth_stackframe stack;
+	char *f = NULL;
+	int i,j;
+
+	TRACE2(("gdth_log_event()\n"));
+	if (dvr->size == 0) {
+		if (buffer == NULL) {
+			printk("Adapter %d: %s\n",
+			       dvr->eu.async.ionode, dvr->event_string);
+		} else {
+			sprintf(buffer,"Adapter %d: %s\n",
+				dvr->eu.async.ionode,dvr->event_string);
+		}
+	} else if (dvr->eu.async.service == CACHESERVICE &&
+		   INDEX_OK(dvr->eu.async.status, async_cache_tab)) {
+		TRACE2(("GDT: Async. event cache service, event no.: %d\n",
+			dvr->eu.async.status));
+
+		f = async_cache_tab[dvr->eu.async.status];
+
+		/* i: parameter to push, j: stack element to fill */
+		for (j=0,i=1; i < f[0]; i+=2) {
+			switch (f[i+1]) {
+			case 4:
+				stack.b[j++] = *(u32*)&dvr->eu.stream[(int)f[i]];
+				break;
+			case 2:
+				stack.b[j++] = *(u16*)&dvr->eu.stream[(int)f[i]];
+				break;
+			case 1:
+				stack.b[j++] = *(u8*)&dvr->eu.stream[(int)f[i]];
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (buffer == NULL) {
+			printk(&f[(int)f[0]],stack);
+			printk("\n");
+		} else {
+			sprintf(buffer,&f[(int)f[0]],stack);
+		}
+
+	} else {
+		if (buffer == NULL) {
+			printk("GDT HA %u, Unknown async. event service %d event no. %d\n",
+			       dvr->eu.async.ionode, dvr->eu.async.service,
+			       dvr->eu.async.status);
+		} else {
+			sprintf(buffer,"GDT HA %u, Unknown async. event service %d event no. %d",
+				dvr->eu.async.ionode, dvr->eu.async.service,
+				dvr->eu.async.status);
+		}
+	}
 }
 
 #ifdef GDTH_STATISTICS
@@ -3125,34 +3144,34 @@ static u8	gdth_timer_running;
 
 static void gdth_timeout(struct timer_list *unused)
 {
-    u32 i;
-    struct scsi_cmnd *nscp;
-    gdth_ha_str *ha;
-    unsigned long flags;
-
-    if(unlikely(list_empty(&gdth_instances))) {
-	    gdth_timer_running = 0;
-	    return;
-    }
-
-    ha = list_first_entry(&gdth_instances, gdth_ha_str, list);
-    spin_lock_irqsave(&ha->smp_lock, flags);
-
-    for (act_stats=0,i=0; i<GDTH_MAXCMDS; ++i) 
-        if (ha->cmd_tab[i].cmnd != UNUSED_CMND)
-            ++act_stats;
-
-    for (act_rq=0,
-         nscp=ha->req_first; nscp; nscp=(struct scsi_cmnd*)nscp->SCp.ptr)
-        ++act_rq;
-
-    TRACE2(("gdth_to(): ints %d, ios %d, act_stats %d, act_rq %d\n",
-            act_ints, act_ios, act_stats, act_rq));
-    act_ints = act_ios = 0;
-
-    gdth_timer.expires = jiffies + 30 * HZ;
-    add_timer(&gdth_timer);
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
+	u32 i;
+	struct scsi_cmnd *nscp;
+	gdth_ha_str *ha;
+	unsigned long flags;
+
+	if(unlikely(list_empty(&gdth_instances))) {
+		gdth_timer_running = 0;
+		return;
+	}
+
+	ha = list_first_entry(&gdth_instances, gdth_ha_str, list);
+	spin_lock_irqsave(&ha->smp_lock, flags);
+
+	for (act_stats=0,i=0; i<GDTH_MAXCMDS; ++i)
+		if (ha->cmd_tab[i].cmnd != UNUSED_CMND)
+			++act_stats;
+
+	for (act_rq=0, nscp=ha->req_first; nscp;
+	     nscp=(struct scsi_cmnd*)nscp->SCp.ptr)
+		++act_rq;
+
+	TRACE2(("gdth_to(): ints %d, ios %d, act_stats %d, act_rq %d\n",
+		act_ints, act_ios, act_stats, act_rq));
+	act_ints = act_ios = 0;
+
+	gdth_timer.expires = jiffies + 30 * HZ;
+	add_timer(&gdth_timer);
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
 }
 
 static void gdth_timer_init(void)
@@ -3172,103 +3191,103 @@ static inline void gdth_timer_init(void)
 
 static void __init internal_setup(char *str,int *ints)
 {
-    int i;
-    char *cur_str, *argv;
-
-    TRACE2(("internal_setup() str %s ints[0] %d\n", 
-            str ? str:"NULL", ints ? ints[0]:0));
-
-    /* analyse string */
-    argv = str;
-    while (argv && (cur_str = strchr(argv, ':'))) {
-        int val = 0, c = *++cur_str;
-        
-        if (c == 'n' || c == 'N')
-            val = 0;
-        else if (c == 'y' || c == 'Y')
-            val = 1;
-        else
-            val = (int)simple_strtoul(cur_str, NULL, 0);
-
-        if (!strncmp(argv, "disable:", 8))
-            disable = val;
-        else if (!strncmp(argv, "reserve_mode:", 13))
-            reserve_mode = val;
-        else if (!strncmp(argv, "reverse_scan:", 13))
-            reverse_scan = val;
-        else if (!strncmp(argv, "hdr_channel:", 12))
-            hdr_channel = val;
-        else if (!strncmp(argv, "max_ids:", 8))
-            max_ids = val;
-        else if (!strncmp(argv, "rescan:", 7))
-            rescan = val;
-        else if (!strncmp(argv, "shared_access:", 14))
-            shared_access = val;
-        else if (!strncmp(argv, "reserve_list:", 13)) {
-            reserve_list[0] = val;
-            for (i = 1; i < MAX_RES_ARGS; i++) {
-                cur_str = strchr(cur_str, ',');
-                if (!cur_str)
-                    break;
-                if (!isdigit((int)*++cur_str)) {
-                    --cur_str;          
-                    break;
-                }
-                reserve_list[i] = 
-                    (int)simple_strtoul(cur_str, NULL, 0);
-            }
-            if (!cur_str)
-                break;
-            argv = ++cur_str;
-            continue;
-        }
-
-        if ((argv = strchr(argv, ',')))
-            ++argv;
-    }
+	int i;
+	char *cur_str, *argv;
+
+	TRACE2(("internal_setup() str %s ints[0] %d\n",
+		str ? str:"NULL", ints ? ints[0]:0));
+
+	/* analyse string */
+	argv = str;
+	while (argv && (cur_str = strchr(argv, ':'))) {
+		int val = 0, c = *++cur_str;
+
+		if (c == 'n' || c == 'N')
+			val = 0;
+		else if (c == 'y' || c == 'Y')
+			val = 1;
+		else
+			val = (int)simple_strtoul(cur_str, NULL, 0);
+
+		if (!strncmp(argv, "disable:", 8))
+			disable = val;
+		else if (!strncmp(argv, "reserve_mode:", 13))
+			reserve_mode = val;
+		else if (!strncmp(argv, "reverse_scan:", 13))
+			reverse_scan = val;
+		else if (!strncmp(argv, "hdr_channel:", 12))
+			hdr_channel = val;
+		else if (!strncmp(argv, "max_ids:", 8))
+			max_ids = val;
+		else if (!strncmp(argv, "rescan:", 7))
+			rescan = val;
+		else if (!strncmp(argv, "shared_access:", 14))
+			shared_access = val;
+		else if (!strncmp(argv, "reserve_list:", 13)) {
+			reserve_list[0] = val;
+			for (i = 1; i < MAX_RES_ARGS; i++) {
+				cur_str = strchr(cur_str, ',');
+				if (!cur_str)
+					break;
+				if (!isdigit((int)*++cur_str)) {
+					--cur_str;
+					break;
+				}
+				reserve_list[i] =
+					(int)simple_strtoul(cur_str, NULL, 0);
+			}
+			if (!cur_str)
+				break;
+			argv = ++cur_str;
+			continue;
+		}
+
+		if ((argv = strchr(argv, ',')))
+			++argv;
+	}
 }
 
 int __init option_setup(char *str)
 {
-    int ints[MAXHA];
-    char *cur = str;
-    int i = 1;
+	int ints[MAXHA];
+	char *cur = str;
+	int i = 1;
 
-    TRACE2(("option_setup() str %s\n", str ? str:"NULL")); 
+	TRACE2(("option_setup() str %s\n", str ? str:"NULL"));
 
-    while (cur && isdigit(*cur) && i < MAXHA) {
-        ints[i++] = simple_strtoul(cur, NULL, 0);
-        if ((cur = strchr(cur, ',')) != NULL) cur++;
-    }
+	while (cur && isdigit(*cur) && i < MAXHA) {
+		ints[i++] = simple_strtoul(cur, NULL, 0);
+		if ((cur = strchr(cur, ',')) != NULL) cur++;
+	}
 
-    ints[0] = i - 1;
-    internal_setup(cur, ints);
-    return 1;
+	ints[0] = i - 1;
+	internal_setup(cur, ints);
+	return 1;
 }
 
 static const char *gdth_ctr_name(gdth_ha_str *ha)
 {
-    TRACE2(("gdth_ctr_name()\n"));
-
-    if (ha->type == GDT_PCI) {
-        switch (ha->pdev->device) {
-          case PCI_DEVICE_ID_VORTEX_GDT60x0:
-            return("GDT6000/6020/6050");
-          case PCI_DEVICE_ID_VORTEX_GDT6000B:
-            return("GDT6000B/6010");
-        }
-    } 
-    /* new controllers (GDT_PCINEW, GDT_PCIMPR, ..) use board_info IOCTL! */
-
-    return("");
+	TRACE2(("gdth_ctr_name()\n"));
+
+	if (ha->type == GDT_PCI) {
+		switch (ha->pdev->device) {
+		case PCI_DEVICE_ID_VORTEX_GDT60x0:
+			return("GDT6000/6020/6050");
+		case PCI_DEVICE_ID_VORTEX_GDT6000B:
+			return("GDT6000B/6010");
+		}
+	}
+	/* new controllers (GDT_PCINEW, GDT_PCIMPR, ..) use board_info IOCTL! */
+
+	return("");
 }
 
 static const char *gdth_info(struct Scsi_Host *shp)
 {
-    gdth_ha_str *ha = shost_priv(shp);
+	gdth_ha_str *ha = shost_priv(shp);
 
-    TRACE2(("gdth_info()\n"));
-    return ((const char *)ha->binfo.type_string);
+	TRACE2(("gdth_info()\n"));
+	return ((const char *)ha->binfo.type_string);
 }
 
 static enum blk_eh_timer_return gdth_timed_out(struct scsi_cmnd *scp)
@@ -3306,249 +3325,250 @@ static enum blk_eh_timer_return gdth_timed_out(struct scsi_cmnd *scp)
 
 static int gdth_eh_bus_reset(struct scsi_cmnd *scp)
 {
-    gdth_ha_str *ha = shost_priv(scp->device->host);
-    int i;
-    unsigned long flags;
-    struct scsi_cmnd *cmnd;
-    u8 b;
-
-    TRACE2(("gdth_eh_bus_reset()\n"));
-
-    b = scp->device->channel;
-
-    /* clear command tab */
-    spin_lock_irqsave(&ha->smp_lock, flags);
-    for (i = 0; i < GDTH_MAXCMDS; ++i) {
-        cmnd = ha->cmd_tab[i].cmnd;
-        if (!SPECIAL_SCP(cmnd) && cmnd->device->channel == b)
-            ha->cmd_tab[i].cmnd = UNUSED_CMND;
-    }
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
-
-    if (b == ha->virt_bus) {
-        /* host drives */
-        for (i = 0; i < MAX_HDRIVES; ++i) {
-            if (ha->hdr[i].present) {
-                spin_lock_irqsave(&ha->smp_lock, flags);
-                gdth_polling = TRUE;
-                while (gdth_test_busy(ha))
-                    gdth_delay(0);
-                if (gdth_internal_cmd(ha, CACHESERVICE,
-                                      GDT_CLUST_RESET, i, 0, 0))
-                    ha->hdr[i].cluster_type &= ~CLUSTER_RESERVED;
-                gdth_polling = FALSE;
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-            }
-        }
-    } else {
-        /* raw devices */
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        for (i = 0; i < MAXID; ++i)
-            ha->raw[BUS_L2P(ha,b)].io_cnt[i] = 0;
-        gdth_polling = TRUE;
-        while (gdth_test_busy(ha))
-            gdth_delay(0);
-        gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESET_BUS,
-                          BUS_L2P(ha,b), 0, 0);
-        gdth_polling = FALSE;
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-    }
-    return SUCCESS;
+	gdth_ha_str *ha = shost_priv(scp->device->host);
+	int i;
+	unsigned long flags;
+	struct scsi_cmnd *cmnd;
+	u8 b;
+
+	TRACE2(("gdth_eh_bus_reset()\n"));
+
+	b = scp->device->channel;
+
+	/* clear command tab */
+	spin_lock_irqsave(&ha->smp_lock, flags);
+	for (i = 0; i < GDTH_MAXCMDS; ++i) {
+		cmnd = ha->cmd_tab[i].cmnd;
+		if (!SPECIAL_SCP(cmnd) && cmnd->device->channel == b)
+			ha->cmd_tab[i].cmnd = UNUSED_CMND;
+	}
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
+
+	if (b == ha->virt_bus) {
+		/* host drives */
+		for (i = 0; i < MAX_HDRIVES; ++i) {
+			if (ha->hdr[i].present) {
+				spin_lock_irqsave(&ha->smp_lock, flags);
+				gdth_polling = TRUE;
+				while (gdth_test_busy(ha))
+					gdth_delay(0);
+				if (gdth_internal_cmd(ha, CACHESERVICE,
+						      GDT_CLUST_RESET, i, 0, 0))
+					ha->hdr[i].cluster_type &= ~CLUSTER_RESERVED;
+				gdth_polling = FALSE;
+				spin_unlock_irqrestore(&ha->smp_lock, flags);
+			}
+		}
+	} else {
+		/* raw devices */
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		for (i = 0; i < MAXID; ++i)
+			ha->raw[BUS_L2P(ha,b)].io_cnt[i] = 0;
+		gdth_polling = TRUE;
+		while (gdth_test_busy(ha))
+			gdth_delay(0);
+		gdth_internal_cmd(ha, SCSIRAWSERVICE, GDT_RESET_BUS,
+				  BUS_L2P(ha,b), 0, 0);
+		gdth_polling = FALSE;
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+	}
+	return SUCCESS;
 }
 
-static int gdth_bios_param(struct scsi_device *sdev,struct block_device *bdev,sector_t cap,int *ip)
+static int gdth_bios_param(struct scsi_device *sdev,struct block_device *bdev,
+			   sector_t cap,int *ip)
 {
-    u8 b, t;
-    gdth_ha_str *ha = shost_priv(sdev->host);
-    struct scsi_device *sd;
-    unsigned capacity;
-
-    sd = sdev;
-    capacity = cap;
-    b = sd->channel;
-    t = sd->id;
-    TRACE2(("gdth_bios_param() ha %d bus %d target %d\n", ha->hanum, b, t));
-
-    if (b != ha->virt_bus || ha->hdr[t].heads == 0) {
-        /* raw device or host drive without mapping information */
-        TRACE2(("Evaluate mapping\n"));
-        gdth_eval_mapping(capacity,&ip[2],&ip[0],&ip[1]);
-    } else {
-        ip[0] = ha->hdr[t].heads;
-        ip[1] = ha->hdr[t].secs;
-        ip[2] = capacity / ip[0] / ip[1];
-    }
-
-    TRACE2(("gdth_bios_param(): %d heads, %d secs, %d cyls\n",
-            ip[0],ip[1],ip[2]));
-    return 0;
+	u8 b, t;
+	gdth_ha_str *ha = shost_priv(sdev->host);
+	struct scsi_device *sd;
+	unsigned capacity;
+
+	sd = sdev;
+	capacity = cap;
+	b = sd->channel;
+	t = sd->id;
+	TRACE2(("gdth_bios_param() ha %d bus %d target %d\n", ha->hanum, b, t));
+
+	if (b != ha->virt_bus || ha->hdr[t].heads == 0) {
+		/* raw device or host drive without mapping information */
+		TRACE2(("Evaluate mapping\n"));
+		gdth_eval_mapping(capacity,&ip[2],&ip[0],&ip[1]);
+	} else {
+		ip[0] = ha->hdr[t].heads;
+		ip[1] = ha->hdr[t].secs;
+		ip[2] = capacity / ip[0] / ip[1];
+	}
+
+	TRACE2(("gdth_bios_param(): %d heads, %d secs, %d cyls\n",
+		ip[0],ip[1],ip[2]));
+	return 0;
 }
 
 
 static int gdth_queuecommand_lck(struct scsi_cmnd *scp,
-				void (*done)(struct scsi_cmnd *))
+				 void (*done)(struct scsi_cmnd *))
 {
-    gdth_ha_str *ha = shost_priv(scp->device->host);
-    struct gdth_cmndinfo *cmndinfo;
+	gdth_ha_str *ha = shost_priv(scp->device->host);
+	struct gdth_cmndinfo *cmndinfo;
 
-    TRACE(("gdth_queuecommand() cmd 0x%x\n", scp->cmnd[0]));
+	TRACE(("gdth_queuecommand() cmd 0x%x\n", scp->cmnd[0]));
 
-    cmndinfo = gdth_get_cmndinfo(ha);
-    BUG_ON(!cmndinfo);
+	cmndinfo = gdth_get_cmndinfo(ha);
+	BUG_ON(!cmndinfo);
 
-    scp->scsi_done = done;
-    cmndinfo->timeout_count = 0;
-    cmndinfo->priority = DEFAULT_PRI;
+	scp->scsi_done = done;
+	cmndinfo->timeout_count = 0;
+	cmndinfo->priority = DEFAULT_PRI;
 
-    return __gdth_queuecommand(ha, scp, cmndinfo);
+	return __gdth_queuecommand(ha, scp, cmndinfo);
 }
 
 static DEF_SCSI_QCMD(gdth_queuecommand)
 
 static int __gdth_queuecommand(gdth_ha_str *ha, struct scsi_cmnd *scp,
-				struct gdth_cmndinfo *cmndinfo)
+			       struct gdth_cmndinfo *cmndinfo)
 {
-    scp->host_scribble = (unsigned char *)cmndinfo;
-    cmndinfo->wait_for_completion = 1;
-    cmndinfo->phase = -1;
-    cmndinfo->OpCode = -1;
+	scp->host_scribble = (unsigned char *)cmndinfo;
+	cmndinfo->wait_for_completion = 1;
+	cmndinfo->phase = -1;
+	cmndinfo->OpCode = -1;
 
 #ifdef GDTH_STATISTICS
-    ++act_ios;
+	++act_ios;
 #endif
 
-    gdth_putq(ha, scp, cmndinfo->priority);
-    gdth_next(ha);
-    return 0;
+	gdth_putq(ha, scp, cmndinfo->priority);
+	gdth_next(ha);
+	return 0;
 }
 
 
 static int gdth_open(struct inode *inode, struct file *filep)
 {
-    gdth_ha_str *ha;
+	gdth_ha_str *ha;
 
-    mutex_lock(&gdth_mutex);
-    list_for_each_entry(ha, &gdth_instances, list) {
-        if (!ha->sdev)
-            ha->sdev = scsi_get_host_dev(ha->shost);
-    }
-    mutex_unlock(&gdth_mutex);
+	mutex_lock(&gdth_mutex);
+	list_for_each_entry(ha, &gdth_instances, list) {
+		if (!ha->sdev)
+			ha->sdev = scsi_get_host_dev(ha->shost);
+	}
+	mutex_unlock(&gdth_mutex);
 
-    TRACE(("gdth_open()\n"));
-    return 0;
+	TRACE(("gdth_open()\n"));
+	return 0;
 }
 
 static int gdth_close(struct inode *inode, struct file *filep)
 {
-    TRACE(("gdth_close()\n"));
-    return 0;
+	TRACE(("gdth_close()\n"));
+	return 0;
 }
 
 static int ioc_event(void __user *arg)
 {
-    gdth_ioctl_event evt;
-    gdth_ha_str *ha;
-    unsigned long flags;
-
-    if (copy_from_user(&evt, arg, sizeof(gdth_ioctl_event)))
-        return -EFAULT;
-    ha = gdth_find_ha(evt.ionode);
-    if (!ha)
-        return -EFAULT;
-
-    if (evt.erase == 0xff) {
-        if (evt.event.event_source == ES_TEST)
-            evt.event.event_data.size=sizeof(evt.event.event_data.eu.test); 
-        else if (evt.event.event_source == ES_DRIVER)
-            evt.event.event_data.size=sizeof(evt.event.event_data.eu.driver); 
-        else if (evt.event.event_source == ES_SYNC)
-            evt.event.event_data.size=sizeof(evt.event.event_data.eu.sync); 
-        else
-            evt.event.event_data.size=sizeof(evt.event.event_data.eu.async);
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        gdth_store_event(ha, evt.event.event_source, evt.event.event_idx,
-                         &evt.event.event_data);
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-    } else if (evt.erase == 0xfe) {
-        gdth_clear_events();
-    } else if (evt.erase == 0) {
-        evt.handle = gdth_read_event(ha, evt.handle, &evt.event);
-    } else {
-        gdth_readapp_event(ha, evt.erase, &evt.event);
-    }     
-    if (copy_to_user(arg, &evt, sizeof(gdth_ioctl_event)))
-        return -EFAULT;
-    return 0;
+	gdth_ioctl_event evt;
+	gdth_ha_str *ha;
+	unsigned long flags;
+
+	if (copy_from_user(&evt, arg, sizeof(gdth_ioctl_event)))
+		return -EFAULT;
+	ha = gdth_find_ha(evt.ionode);
+	if (!ha)
+		return -EFAULT;
+
+	if (evt.erase == 0xff) {
+		if (evt.event.event_source == ES_TEST)
+			evt.event.event_data.size=sizeof(evt.event.event_data.eu.test);
+		else if (evt.event.event_source == ES_DRIVER)
+			evt.event.event_data.size=sizeof(evt.event.event_data.eu.driver);
+		else if (evt.event.event_source == ES_SYNC)
+			evt.event.event_data.size=sizeof(evt.event.event_data.eu.sync);
+		else
+			evt.event.event_data.size=sizeof(evt.event.event_data.eu.async);
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		gdth_store_event(ha, evt.event.event_source, evt.event.event_idx,
+				 &evt.event.event_data);
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+	} else if (evt.erase == 0xfe) {
+		gdth_clear_events();
+	} else if (evt.erase == 0) {
+		evt.handle = gdth_read_event(ha, evt.handle, &evt.event);
+	} else {
+		gdth_readapp_event(ha, evt.erase, &evt.event);
+	}
+	if (copy_to_user(arg, &evt, sizeof(gdth_ioctl_event)))
+		return -EFAULT;
+	return 0;
 }
 
 static int ioc_lockdrv(void __user *arg)
 {
-    gdth_ioctl_lockdrv ldrv;
-    u8 i, j;
-    unsigned long flags;
-    gdth_ha_str *ha;
-
-    if (copy_from_user(&ldrv, arg, sizeof(gdth_ioctl_lockdrv)))
-        return -EFAULT;
-    ha = gdth_find_ha(ldrv.ionode);
-    if (!ha)
-        return -EFAULT;
-
-    for (i = 0; i < ldrv.drive_cnt && i < MAX_HDRIVES; ++i) {
-        j = ldrv.drives[i];
-        if (j >= MAX_HDRIVES || !ha->hdr[j].present)
-            continue;
-        if (ldrv.lock) {
-            spin_lock_irqsave(&ha->smp_lock, flags);
-            ha->hdr[j].lock = 1;
-            spin_unlock_irqrestore(&ha->smp_lock, flags);
-            gdth_wait_completion(ha, ha->bus_cnt, j);
-        } else {
-            spin_lock_irqsave(&ha->smp_lock, flags);
-            ha->hdr[j].lock = 0;
-            spin_unlock_irqrestore(&ha->smp_lock, flags);
-            gdth_next(ha);
-        }
-    } 
-    return 0;
+	gdth_ioctl_lockdrv ldrv;
+	u8 i, j;
+	unsigned long flags;
+	gdth_ha_str *ha;
+
+	if (copy_from_user(&ldrv, arg, sizeof(gdth_ioctl_lockdrv)))
+		return -EFAULT;
+	ha = gdth_find_ha(ldrv.ionode);
+	if (!ha)
+		return -EFAULT;
+
+	for (i = 0; i < ldrv.drive_cnt && i < MAX_HDRIVES; ++i) {
+		j = ldrv.drives[i];
+		if (j >= MAX_HDRIVES || !ha->hdr[j].present)
+			continue;
+		if (ldrv.lock) {
+			spin_lock_irqsave(&ha->smp_lock, flags);
+			ha->hdr[j].lock = 1;
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+			gdth_wait_completion(ha, ha->bus_cnt, j);
+		} else {
+			spin_lock_irqsave(&ha->smp_lock, flags);
+			ha->hdr[j].lock = 0;
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+			gdth_next(ha);
+		}
+	}
+	return 0;
 }
 
 static int ioc_resetdrv(void __user *arg, char *cmnd)
 {
-    gdth_ioctl_reset res;
-    gdth_cmd_str cmd;
-    gdth_ha_str *ha;
-    int rval;
-
-    if (copy_from_user(&res, arg, sizeof(gdth_ioctl_reset)) ||
-        res.number >= MAX_HDRIVES)
-        return -EFAULT;
-    ha = gdth_find_ha(res.ionode);
-    if (!ha)
-        return -EFAULT;
-
-    if (!ha->hdr[res.number].present)
-        return 0;
-    memset(&cmd, 0, sizeof(gdth_cmd_str));
-    cmd.Service = CACHESERVICE;
-    cmd.OpCode = GDT_CLUST_RESET;
-    if (ha->cache_feat & GDT_64BIT)
-        cmd.u.cache64.DeviceNo = res.number;
-    else
-        cmd.u.cache.DeviceNo = res.number;
-
-    rval = __gdth_execute(ha->sdev, &cmd, cmnd, 30, NULL);
-    if (rval < 0)
-        return rval;
-    res.status = rval;
-
-    if (copy_to_user(arg, &res, sizeof(gdth_ioctl_reset)))
-        return -EFAULT;
-    return 0;
+	gdth_ioctl_reset res;
+	gdth_cmd_str cmd;
+	gdth_ha_str *ha;
+	int rval;
+
+	if (copy_from_user(&res, arg, sizeof(gdth_ioctl_reset)) ||
+	    res.number >= MAX_HDRIVES)
+		return -EFAULT;
+	ha = gdth_find_ha(res.ionode);
+	if (!ha)
+		return -EFAULT;
+
+	if (!ha->hdr[res.number].present)
+		return 0;
+	memset(&cmd, 0, sizeof(gdth_cmd_str));
+	cmd.Service = CACHESERVICE;
+	cmd.OpCode = GDT_CLUST_RESET;
+	if (ha->cache_feat & GDT_64BIT)
+		cmd.u.cache64.DeviceNo = res.number;
+	else
+		cmd.u.cache.DeviceNo = res.number;
+
+	rval = __gdth_execute(ha->sdev, &cmd, cmnd, 30, NULL);
+	if (rval < 0)
+		return rval;
+	res.status = rval;
+
+	if (copy_to_user(arg, &res, sizeof(gdth_ioctl_reset)))
+		return -EFAULT;
+	return 0;
 }
 
 static void gdth_ioc_cacheservice(gdth_ha_str *ha, gdth_ioctl_general *gen,
-		u64 paddr)
+				  u64 paddr)
 {
 	if (ha->cache_feat & GDT_64BIT) {
 		/* copy elements from 32-bit IOCTL structure */
@@ -3569,7 +3589,7 @@ static void gdth_ioc_cacheservice(gdth_ha_str *ha, gdth_ioctl_general *gen,
 	} else {
 		if (ha->cache_feat & SCATTER_GATHER) {
 			gen->command.u.cache.DestAddr = 0xffffffff;
-				gen->command.u.cache.sg_canz = 1;
+			gen->command.u.cache.sg_canz = 1;
 			gen->command.u.cache.sg_lst[0].sg_ptr = (u32)paddr;
 			gen->command.u.cache.sg_lst[0].sg_len = gen->data_len;
 			gen->command.u.cache.sg_lst[1].sg_len = 0;
@@ -3581,7 +3601,7 @@ static void gdth_ioc_cacheservice(gdth_ha_str *ha, gdth_ioctl_general *gen,
 }
 
 static void gdth_ioc_scsiraw(gdth_ha_str *ha, gdth_ioctl_general *gen,
-		u64 paddr)
+			     u64 paddr)
 {
 	if (ha->raw_feat & GDT_64BIT) {
 		/* copy elements from 32-bit IOCTL structure */
@@ -3607,7 +3627,7 @@ static void gdth_ioc_scsiraw(gdth_ha_str *ha, gdth_ioctl_general *gen,
 		} else {
 			gen->command.u.raw64.sdata = paddr;
 			gen->command.u.raw64.sg_ranz = 0;
-                }
+		}
 
 		gen->command.u.raw64.sense_data = paddr + gen->data_len;
 	} else {
@@ -3620,7 +3640,7 @@ static void gdth_ioc_scsiraw(gdth_ha_str *ha, gdth_ioctl_general *gen,
 		} else {
 			gen->command.u.raw.sdata = paddr;
 			gen->command.u.raw.sg_ranz = 0;
-                }
+		}
 
 		gen->command.u.raw.sense_data = (u32)paddr + gen->data_len;
 	}
@@ -3649,8 +3669,8 @@ static int ioc_general(void __user *arg, char *cmnd)
 
 	if (gen.data_len + gen.sense_len > 0) {
 		buf = dma_alloc_coherent(&ha->pdev->dev,
-				gen.data_len + gen.sense_len, &paddr,
-				GFP_KERNEL);
+					 gen.data_len + gen.sense_len, &paddr,
+					 GFP_KERNEL);
 		if (!buf)
 			return -EFAULT;
 
@@ -3670,7 +3690,7 @@ static int ioc_general(void __user *arg, char *cmnd)
 	}
 
 	rval = __gdth_execute(ha->sdev, &gen.command, cmnd, gen.timeout,
-			&gen.info);
+			      &gen.info);
 	if (rval < 0)
 		goto out_free_buf;
 	gen.status = rval;
@@ -3680,7 +3700,7 @@ static int ioc_general(void __user *arg, char *cmnd)
 			 gen.data_len + gen.sense_len))
 		goto out_free_buf;
 	if (copy_to_user(arg, &gen,
-			sizeof(gdth_ioctl_general) - sizeof(gdth_cmd_str)))
+			 sizeof(gdth_ioctl_general) - sizeof(gdth_cmd_str)))
 		goto out_free_buf;
 
 	rval = 0;
@@ -3690,335 +3710,335 @@ static int ioc_general(void __user *arg, char *cmnd)
 				  buf, paddr);
 	return rval;
 }
- 
+
 static int ioc_hdrlist(void __user *arg, char *cmnd)
 {
-    gdth_ioctl_rescan *rsc;
-    gdth_cmd_str *cmd;
-    gdth_ha_str *ha;
-    u8 i;
-    int rc = -ENOMEM;
-    u32 cluster_type = 0;
-
-    rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
-    cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
-    if (!rsc || !cmd)
-        goto free_fail;
-
-    if (copy_from_user(rsc, arg, sizeof(gdth_ioctl_rescan)) ||
-        (NULL == (ha = gdth_find_ha(rsc->ionode)))) {
-        rc = -EFAULT;
-        goto free_fail;
-    }
-    memset(cmd, 0, sizeof(gdth_cmd_str));
-   
-    for (i = 0; i < MAX_HDRIVES; ++i) { 
-        if (!ha->hdr[i].present) {
-            rsc->hdr_list[i].bus = 0xff; 
-            continue;
-        } 
-        rsc->hdr_list[i].bus = ha->virt_bus;
-        rsc->hdr_list[i].target = i;
-        rsc->hdr_list[i].lun = 0;
-        rsc->hdr_list[i].cluster_type = ha->hdr[i].cluster_type;
-        if (ha->hdr[i].cluster_type & CLUSTER_DRIVE) { 
-            cmd->Service = CACHESERVICE;
-            cmd->OpCode = GDT_CLUST_INFO;
-            if (ha->cache_feat & GDT_64BIT)
-                cmd->u.cache64.DeviceNo = i;
-            else
-                cmd->u.cache.DeviceNo = i;
-            if (__gdth_execute(ha->sdev, cmd, cmnd, 30, &cluster_type) == S_OK)
-                rsc->hdr_list[i].cluster_type = cluster_type;
-        }
-    } 
-
-    if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
-        rc = -EFAULT;
-    else
-        rc = 0;
+	gdth_ioctl_rescan *rsc;
+	gdth_cmd_str *cmd;
+	gdth_ha_str *ha;
+	u8 i;
+	int rc = -ENOMEM;
+	u32 cluster_type = 0;
+
+	rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
+	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!rsc || !cmd)
+		goto free_fail;
+
+	if (copy_from_user(rsc, arg, sizeof(gdth_ioctl_rescan)) ||
+	    (NULL == (ha = gdth_find_ha(rsc->ionode)))) {
+		rc = -EFAULT;
+		goto free_fail;
+	}
+	memset(cmd, 0, sizeof(gdth_cmd_str));
+
+	for (i = 0; i < MAX_HDRIVES; ++i) {
+		if (!ha->hdr[i].present) {
+			rsc->hdr_list[i].bus = 0xff;
+			continue;
+		}
+		rsc->hdr_list[i].bus = ha->virt_bus;
+		rsc->hdr_list[i].target = i;
+		rsc->hdr_list[i].lun = 0;
+		rsc->hdr_list[i].cluster_type = ha->hdr[i].cluster_type;
+		if (ha->hdr[i].cluster_type & CLUSTER_DRIVE) {
+			cmd->Service = CACHESERVICE;
+			cmd->OpCode = GDT_CLUST_INFO;
+			if (ha->cache_feat & GDT_64BIT)
+				cmd->u.cache64.DeviceNo = i;
+			else
+				cmd->u.cache.DeviceNo = i;
+			if (__gdth_execute(ha->sdev, cmd, cmnd, 30, &cluster_type) == S_OK)
+				rsc->hdr_list[i].cluster_type = cluster_type;
+		}
+	}
+
+	if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
+		rc = -EFAULT;
+	else
+		rc = 0;
 
 free_fail:
-    kfree(rsc);
-    kfree(cmd);
-    return rc;
+	kfree(rsc);
+	kfree(cmd);
+	return rc;
 }
 
 static int ioc_rescan(void __user *arg, char *cmnd)
 {
-    gdth_ioctl_rescan *rsc;
-    gdth_cmd_str *cmd;
-    u16 i, status, hdr_cnt;
-    u32 info;
-    int cyls, hds, secs;
-    int rc = -ENOMEM;
-    unsigned long flags;
-    gdth_ha_str *ha; 
-
-    rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
-    cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
-    if (!cmd || !rsc)
-        goto free_fail;
-
-    if (copy_from_user(rsc, arg, sizeof(gdth_ioctl_rescan)) ||
-        (NULL == (ha = gdth_find_ha(rsc->ionode)))) {
-        rc = -EFAULT;
-        goto free_fail;
-    }
-    memset(cmd, 0, sizeof(gdth_cmd_str));
-
-    if (rsc->flag == 0) {
-        /* old method: re-init. cache service */
-        cmd->Service = CACHESERVICE;
-        if (ha->cache_feat & GDT_64BIT) {
-            cmd->OpCode = GDT_X_INIT_HOST;
-            cmd->u.cache64.DeviceNo = LINUX_OS;
-        } else {
-            cmd->OpCode = GDT_INIT;
-            cmd->u.cache.DeviceNo = LINUX_OS;
-        }
-
-        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
-        i = 0;
-        hdr_cnt = (status == S_OK ? (u16)info : 0);
-    } else {
-        i = rsc->hdr_no;
-        hdr_cnt = i + 1;
-    }
-
-    for (; i < hdr_cnt && i < MAX_HDRIVES; ++i) {
-        cmd->Service = CACHESERVICE;
-        cmd->OpCode = GDT_INFO;
-        if (ha->cache_feat & GDT_64BIT) 
-            cmd->u.cache64.DeviceNo = i;
-        else 
-            cmd->u.cache.DeviceNo = i;
-
-        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
-
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        rsc->hdr_list[i].bus = ha->virt_bus;
-        rsc->hdr_list[i].target = i;
-        rsc->hdr_list[i].lun = 0;
-        if (status != S_OK) {
-            ha->hdr[i].present = FALSE;
-        } else {
-            ha->hdr[i].present = TRUE;
-            ha->hdr[i].size = info;
-            /* evaluate mapping */
-            ha->hdr[i].size &= ~SECS32;
-            gdth_eval_mapping(ha->hdr[i].size,&cyls,&hds,&secs); 
-            ha->hdr[i].heads = hds;
-            ha->hdr[i].secs = secs;
-            /* round size */
-            ha->hdr[i].size = cyls * hds * secs;
-        }
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-        if (status != S_OK)
-            continue; 
-        
-        /* extended info, if GDT_64BIT, for drives > 2 TB */
-        /* but we need ha->info2, not yet stored in scp->SCp */
-
-        /* devtype, cluster info, R/W attribs */
-        cmd->Service = CACHESERVICE;
-        cmd->OpCode = GDT_DEVTYPE;
-        if (ha->cache_feat & GDT_64BIT) 
-            cmd->u.cache64.DeviceNo = i;
-        else
-            cmd->u.cache.DeviceNo = i;
-
-        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
-
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        ha->hdr[i].devtype = (status == S_OK ? (u16)info : 0);
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-
-        cmd->Service = CACHESERVICE;
-        cmd->OpCode = GDT_CLUST_INFO;
-        if (ha->cache_feat & GDT_64BIT) 
-            cmd->u.cache64.DeviceNo = i;
-        else
-            cmd->u.cache.DeviceNo = i;
-
-        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
-
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        ha->hdr[i].cluster_type = 
-            ((status == S_OK && !shared_access) ? (u16)info : 0);
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-        rsc->hdr_list[i].cluster_type = ha->hdr[i].cluster_type;
-
-        cmd->Service = CACHESERVICE;
-        cmd->OpCode = GDT_RW_ATTRIBS;
-        if (ha->cache_feat & GDT_64BIT) 
-            cmd->u.cache64.DeviceNo = i;
-        else
-            cmd->u.cache.DeviceNo = i;
-
-        status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
-
-        spin_lock_irqsave(&ha->smp_lock, flags);
-        ha->hdr[i].rw_attribs = (status == S_OK ? (u16)info : 0);
-        spin_unlock_irqrestore(&ha->smp_lock, flags);
-    }
- 
-    if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
-        rc = -EFAULT;
-    else
-        rc = 0;
+	gdth_ioctl_rescan *rsc;
+	gdth_cmd_str *cmd;
+	u16 i, status, hdr_cnt;
+	u32 info;
+	int cyls, hds, secs;
+	int rc = -ENOMEM;
+	unsigned long flags;
+	gdth_ha_str *ha;
+
+	rsc = kmalloc(sizeof(*rsc), GFP_KERNEL);
+	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd || !rsc)
+		goto free_fail;
+
+	if (copy_from_user(rsc, arg, sizeof(gdth_ioctl_rescan)) ||
+	    (NULL == (ha = gdth_find_ha(rsc->ionode)))) {
+		rc = -EFAULT;
+		goto free_fail;
+	}
+	memset(cmd, 0, sizeof(gdth_cmd_str));
+
+	if (rsc->flag == 0) {
+		/* old method: re-init. cache service */
+		cmd->Service = CACHESERVICE;
+		if (ha->cache_feat & GDT_64BIT) {
+			cmd->OpCode = GDT_X_INIT_HOST;
+			cmd->u.cache64.DeviceNo = LINUX_OS;
+		} else {
+			cmd->OpCode = GDT_INIT;
+			cmd->u.cache.DeviceNo = LINUX_OS;
+		}
+
+		status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+		i = 0;
+		hdr_cnt = (status == S_OK ? (u16)info : 0);
+	} else {
+		i = rsc->hdr_no;
+		hdr_cnt = i + 1;
+	}
+
+	for (; i < hdr_cnt && i < MAX_HDRIVES; ++i) {
+		cmd->Service = CACHESERVICE;
+		cmd->OpCode = GDT_INFO;
+		if (ha->cache_feat & GDT_64BIT)
+			cmd->u.cache64.DeviceNo = i;
+		else
+			cmd->u.cache.DeviceNo = i;
+
+		status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		rsc->hdr_list[i].bus = ha->virt_bus;
+		rsc->hdr_list[i].target = i;
+		rsc->hdr_list[i].lun = 0;
+		if (status != S_OK) {
+			ha->hdr[i].present = FALSE;
+		} else {
+			ha->hdr[i].present = TRUE;
+			ha->hdr[i].size = info;
+			/* evaluate mapping */
+			ha->hdr[i].size &= ~SECS32;
+			gdth_eval_mapping(ha->hdr[i].size,&cyls,&hds,&secs);
+			ha->hdr[i].heads = hds;
+			ha->hdr[i].secs = secs;
+			/* round size */
+			ha->hdr[i].size = cyls * hds * secs;
+		}
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+		if (status != S_OK)
+			continue;
+
+		/* extended info, if GDT_64BIT, for drives > 2 TB */
+		/* but we need ha->info2, not yet stored in scp->SCp */
+
+		/* devtype, cluster info, R/W attribs */
+		cmd->Service = CACHESERVICE;
+		cmd->OpCode = GDT_DEVTYPE;
+		if (ha->cache_feat & GDT_64BIT)
+			cmd->u.cache64.DeviceNo = i;
+		else
+			cmd->u.cache.DeviceNo = i;
+
+		status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		ha->hdr[i].devtype = (status == S_OK ? (u16)info : 0);
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+
+		cmd->Service = CACHESERVICE;
+		cmd->OpCode = GDT_CLUST_INFO;
+		if (ha->cache_feat & GDT_64BIT)
+			cmd->u.cache64.DeviceNo = i;
+		else
+			cmd->u.cache.DeviceNo = i;
+
+		status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		ha->hdr[i].cluster_type =
+			((status == S_OK && !shared_access) ? (u16)info : 0);
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+		rsc->hdr_list[i].cluster_type = ha->hdr[i].cluster_type;
+
+		cmd->Service = CACHESERVICE;
+		cmd->OpCode = GDT_RW_ATTRIBS;
+		if (ha->cache_feat & GDT_64BIT)
+			cmd->u.cache64.DeviceNo = i;
+		else
+			cmd->u.cache.DeviceNo = i;
+
+		status = __gdth_execute(ha->sdev, cmd, cmnd, 30, &info);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		ha->hdr[i].rw_attribs = (status == S_OK ? (u16)info : 0);
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+	}
+
+	if (copy_to_user(arg, rsc, sizeof(gdth_ioctl_rescan)))
+		rc = -EFAULT;
+	else
+		rc = 0;
 
 free_fail:
-    kfree(rsc);
-    kfree(cmd);
-    return rc;
+	kfree(rsc);
+	kfree(cmd);
+	return rc;
 }
-  
+
 static int gdth_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
-    gdth_ha_str *ha; 
-    struct scsi_cmnd *scp;
-    unsigned long flags;
-    char cmnd[MAX_COMMAND_SIZE];   
-    void __user *argp = (void __user *)arg;
-
-    memset(cmnd, 0xff, 12);
-    
-    TRACE(("gdth_ioctl() cmd 0x%x\n", cmd));
- 
-    switch (cmd) {
-      case GDTIOCTL_CTRCNT:
-      { 
-        int cnt = gdth_ctr_count;
-        if (put_user(cnt, (int __user *)argp))
-                return -EFAULT;
-        break;
-      }
-
-      case GDTIOCTL_DRVERS:
-      { 
-        int ver = (GDTH_VERSION<<8) | GDTH_SUBVERSION;
-        if (put_user(ver, (int __user *)argp))
-                return -EFAULT;
-        break;
-      }
-      
-      case GDTIOCTL_OSVERS:
-      { 
-        gdth_ioctl_osvers osv; 
-
-        osv.version = (u8)(LINUX_VERSION_CODE >> 16);
-        osv.subversion = (u8)(LINUX_VERSION_CODE >> 8);
-        osv.revision = (u16)(LINUX_VERSION_CODE & 0xff);
-        if (copy_to_user(argp, &osv, sizeof(gdth_ioctl_osvers)))
-                return -EFAULT;
-        break;
-      }
-
-      case GDTIOCTL_CTRTYPE:
-      { 
-        gdth_ioctl_ctrtype ctrt;
-        
-        if (copy_from_user(&ctrt, argp, sizeof(gdth_ioctl_ctrtype)) ||
-            (NULL == (ha = gdth_find_ha(ctrt.ionode))))
-            return -EFAULT;
-
-        if (ha->type != GDT_PCIMPR) {
-	    ctrt.type = (u8)((ha->stype<<4) + 6);
-        } else {
-            ctrt.type =  (ha->oem_id == OEM_ID_INTEL ? 0xfd : 0xfe);
-            if (ha->stype >= 0x300)
-                ctrt.ext_type = 0x6000 | ha->pdev->subsystem_device;
-            else
-                ctrt.ext_type = 0x6000 | ha->stype;
-        }
-        ctrt.device_id = ha->pdev->device;
-        ctrt.sub_device_id = ha->pdev->subsystem_device;
-        ctrt.info = ha->brd_phys;
-        ctrt.oem_id = ha->oem_id;
-        if (copy_to_user(argp, &ctrt, sizeof(gdth_ioctl_ctrtype)))
-            return -EFAULT;
-        break;
-      }
-        
-      case GDTIOCTL_GENERAL:
-        return ioc_general(argp, cmnd);
-
-      case GDTIOCTL_EVENT:
-        return ioc_event(argp);
-
-      case GDTIOCTL_LOCKDRV:
-        return ioc_lockdrv(argp);
-
-      case GDTIOCTL_LOCKCHN:
-      {
-        gdth_ioctl_lockchn lchn;
-        u8 i, j;
-
-        if (copy_from_user(&lchn, argp, sizeof(gdth_ioctl_lockchn)) ||
-            (NULL == (ha = gdth_find_ha(lchn.ionode))))
-            return -EFAULT;
-
-        i = lchn.channel;
-        if (i < ha->bus_cnt) {
-            if (lchn.lock) {
-                spin_lock_irqsave(&ha->smp_lock, flags);
-                ha->raw[i].lock = 1;
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-		for (j = 0; j < ha->tid_cnt; ++j)
-                    gdth_wait_completion(ha, i, j);
-            } else {
-                spin_lock_irqsave(&ha->smp_lock, flags);
-                ha->raw[i].lock = 0;
-                spin_unlock_irqrestore(&ha->smp_lock, flags);
-		for (j = 0; j < ha->tid_cnt; ++j)
-                    gdth_next(ha);
-            }
-        } 
-        break;
-      }
-
-      case GDTIOCTL_RESCAN:
-        return ioc_rescan(argp, cmnd);
-
-      case GDTIOCTL_HDRLIST:
-        return ioc_hdrlist(argp, cmnd);
-
-      case GDTIOCTL_RESET_BUS:
-      {
-        gdth_ioctl_reset res;
-        int rval;
-
-        if (copy_from_user(&res, argp, sizeof(gdth_ioctl_reset)) ||
-            (NULL == (ha = gdth_find_ha(res.ionode))))
-            return -EFAULT;
-
-        scp  = kzalloc(sizeof(*scp), GFP_KERNEL);
-        if (!scp)
-            return -ENOMEM;
-        scp->device = ha->sdev;
-        scp->cmd_len = 12;
-        scp->device->channel = res.number;
-        rval = gdth_eh_bus_reset(scp);
-        res.status = (rval == SUCCESS ? S_OK : S_GENERR);
-        kfree(scp);
-
-        if (copy_to_user(argp, &res, sizeof(gdth_ioctl_reset)))
-            return -EFAULT;
-        break;
-      }
-
-      case GDTIOCTL_RESET_DRV:
-        return ioc_resetdrv(argp, cmnd);
-
-      default:
-        break; 
-    }
-    return 0;
+	gdth_ha_str *ha;
+	struct scsi_cmnd *scp;
+	unsigned long flags;
+	char cmnd[MAX_COMMAND_SIZE];
+	void __user *argp = (void __user *)arg;
+
+	memset(cmnd, 0xff, 12);
+
+	TRACE(("gdth_ioctl() cmd 0x%x\n", cmd));
+
+	switch (cmd) {
+	case GDTIOCTL_CTRCNT:
+	{
+		int cnt = gdth_ctr_count;
+		if (put_user(cnt, (int __user *)argp))
+			return -EFAULT;
+		break;
+	}
+
+	case GDTIOCTL_DRVERS:
+	{
+		int ver = (GDTH_VERSION<<8) | GDTH_SUBVERSION;
+		if (put_user(ver, (int __user *)argp))
+			return -EFAULT;
+		break;
+	}
+
+	case GDTIOCTL_OSVERS:
+	{
+		gdth_ioctl_osvers osv;
+
+		osv.version = (u8)(LINUX_VERSION_CODE >> 16);
+		osv.subversion = (u8)(LINUX_VERSION_CODE >> 8);
+		osv.revision = (u16)(LINUX_VERSION_CODE & 0xff);
+		if (copy_to_user(argp, &osv, sizeof(gdth_ioctl_osvers)))
+			return -EFAULT;
+		break;
+	}
+
+	case GDTIOCTL_CTRTYPE:
+	{
+		gdth_ioctl_ctrtype ctrt;
+
+		if (copy_from_user(&ctrt, argp, sizeof(gdth_ioctl_ctrtype)) ||
+		    (NULL == (ha = gdth_find_ha(ctrt.ionode))))
+			return -EFAULT;
+
+		if (ha->type != GDT_PCIMPR) {
+			ctrt.type = (u8)((ha->stype<<4) + 6);
+		} else {
+			ctrt.type =  (ha->oem_id == OEM_ID_INTEL ? 0xfd : 0xfe);
+			if (ha->stype >= 0x300)
+				ctrt.ext_type = 0x6000 | ha->pdev->subsystem_device;
+			else
+				ctrt.ext_type = 0x6000 | ha->stype;
+		}
+		ctrt.device_id = ha->pdev->device;
+		ctrt.sub_device_id = ha->pdev->subsystem_device;
+		ctrt.info = ha->brd_phys;
+		ctrt.oem_id = ha->oem_id;
+		if (copy_to_user(argp, &ctrt, sizeof(gdth_ioctl_ctrtype)))
+			return -EFAULT;
+		break;
+	}
+
+	case GDTIOCTL_GENERAL:
+		return ioc_general(argp, cmnd);
+
+	case GDTIOCTL_EVENT:
+		return ioc_event(argp);
+
+	case GDTIOCTL_LOCKDRV:
+		return ioc_lockdrv(argp);
+
+	case GDTIOCTL_LOCKCHN:
+	{
+		gdth_ioctl_lockchn lchn;
+		u8 i, j;
+
+		if (copy_from_user(&lchn, argp, sizeof(gdth_ioctl_lockchn)) ||
+		    (NULL == (ha = gdth_find_ha(lchn.ionode))))
+			return -EFAULT;
+
+		i = lchn.channel;
+		if (i < ha->bus_cnt) {
+			if (lchn.lock) {
+				spin_lock_irqsave(&ha->smp_lock, flags);
+				ha->raw[i].lock = 1;
+				spin_unlock_irqrestore(&ha->smp_lock, flags);
+				for (j = 0; j < ha->tid_cnt; ++j)
+					gdth_wait_completion(ha, i, j);
+			} else {
+				spin_lock_irqsave(&ha->smp_lock, flags);
+				ha->raw[i].lock = 0;
+				spin_unlock_irqrestore(&ha->smp_lock, flags);
+				for (j = 0; j < ha->tid_cnt; ++j)
+					gdth_next(ha);
+			}
+		}
+		break;
+	}
+
+	case GDTIOCTL_RESCAN:
+		return ioc_rescan(argp, cmnd);
+
+	case GDTIOCTL_HDRLIST:
+		return ioc_hdrlist(argp, cmnd);
+
+	case GDTIOCTL_RESET_BUS:
+	{
+		gdth_ioctl_reset res;
+		int rval;
+
+		if (copy_from_user(&res, argp, sizeof(gdth_ioctl_reset)) ||
+		    (NULL == (ha = gdth_find_ha(res.ionode))))
+			return -EFAULT;
+
+		scp  = kzalloc(sizeof(*scp), GFP_KERNEL);
+		if (!scp)
+			return -ENOMEM;
+		scp->device = ha->sdev;
+		scp->cmd_len = 12;
+		scp->device->channel = res.number;
+		rval = gdth_eh_bus_reset(scp);
+		res.status = (rval == SUCCESS ? S_OK : S_GENERR);
+		kfree(scp);
+
+		if (copy_to_user(argp, &res, sizeof(gdth_ioctl_reset)))
+			return -EFAULT;
+		break;
+	}
+
+	case GDTIOCTL_RESET_DRV:
+		return ioc_resetdrv(argp, cmnd);
+
+	default:
+		break;
+	}
+	return 0;
 }
 
 static long gdth_unlocked_ioctl(struct file *file, unsigned int cmd,
-			        unsigned long arg)
+				unsigned long arg)
 {
 	int ret;
 
@@ -4032,58 +4052,60 @@ static long gdth_unlocked_ioctl(struct file *file, unsigned int cmd,
 /* flush routine */
 static void gdth_flush(gdth_ha_str *ha)
 {
-    int             i;
-    gdth_cmd_str    gdtcmd;
-    char            cmnd[MAX_COMMAND_SIZE];   
-    memset(cmnd, 0xff, MAX_COMMAND_SIZE);
-
-    TRACE2(("gdth_flush() hanum %d\n", ha->hanum));
-
-    for (i = 0; i < MAX_HDRIVES; ++i) {
-        if (ha->hdr[i].present) {
-            gdtcmd.BoardNode = LOCALBOARD;
-            gdtcmd.Service = CACHESERVICE;
-            gdtcmd.OpCode = GDT_FLUSH;
-            if (ha->cache_feat & GDT_64BIT) { 
-                gdtcmd.u.cache64.DeviceNo = i;
-                gdtcmd.u.cache64.BlockNo = 1;
-                gdtcmd.u.cache64.sg_canz = 0;
-            } else {
-                gdtcmd.u.cache.DeviceNo = i;
-                gdtcmd.u.cache.BlockNo = 1;
-                gdtcmd.u.cache.sg_canz = 0;
-            }
-            TRACE2(("gdth_flush(): flush ha %d drive %d\n", ha->hanum, i));
-
-            gdth_execute(ha->shost, &gdtcmd, cmnd, 30, NULL);
-        }
-    }
+	int i;
+	gdth_cmd_str gdtcmd;
+	char cmnd[MAX_COMMAND_SIZE];
+
+	memset(cmnd, 0xff, MAX_COMMAND_SIZE);
+
+	TRACE2(("gdth_flush() hanum %d\n", ha->hanum));
+
+	for (i = 0; i < MAX_HDRIVES; ++i) {
+		if (ha->hdr[i].present) {
+			gdtcmd.BoardNode = LOCALBOARD;
+			gdtcmd.Service = CACHESERVICE;
+			gdtcmd.OpCode = GDT_FLUSH;
+			if (ha->cache_feat & GDT_64BIT) {
+				gdtcmd.u.cache64.DeviceNo = i;
+				gdtcmd.u.cache64.BlockNo = 1;
+				gdtcmd.u.cache64.sg_canz = 0;
+			} else {
+				gdtcmd.u.cache.DeviceNo = i;
+				gdtcmd.u.cache.BlockNo = 1;
+				gdtcmd.u.cache.sg_canz = 0;
+			}
+			TRACE2(("gdth_flush(): flush ha %d drive %d\n",
+				ha->hanum, i));
+
+			gdth_execute(ha->shost, &gdtcmd, cmnd, 30, NULL);
+		}
+	}
 }
 
 /* configure lun */
 static int gdth_slave_configure(struct scsi_device *sdev)
 {
-    sdev->skip_ms_page_3f = 1;
-    sdev->skip_ms_page_8 = 1;
-    return 0;
+	sdev->skip_ms_page_3f = 1;
+	sdev->skip_ms_page_8 = 1;
+	return 0;
 }
 
 static struct scsi_host_template gdth_template = {
-        .name                   = "GDT SCSI Disk Array Controller",
-        .info                   = gdth_info, 
-        .queuecommand           = gdth_queuecommand,
-        .eh_bus_reset_handler   = gdth_eh_bus_reset,
-        .slave_configure        = gdth_slave_configure,
-        .bios_param             = gdth_bios_param,
-        .show_info              = gdth_show_info,
-        .write_info             = gdth_set_info,
+	.name			= "GDT SCSI Disk Array Controller",
+	.info			= gdth_info,
+	.queuecommand		= gdth_queuecommand,
+	.eh_bus_reset_handler	= gdth_eh_bus_reset,
+	.slave_configure	= gdth_slave_configure,
+	.bios_param		= gdth_bios_param,
+	.show_info		= gdth_show_info,
+	.write_info		= gdth_set_info,
 	.eh_timed_out		= gdth_timed_out,
-        .proc_name              = "gdth",
-        .can_queue              = GDTH_MAXCMDS,
-        .this_id                = -1,
-        .sg_tablesize           = GDTH_MAXSG,
-        .cmd_per_lun            = GDTH_MAXC_P_L,
-        .unchecked_isa_dma      = 1,
+	.proc_name		= "gdth",
+	.can_queue		= GDTH_MAXCMDS,
+	.this_id		= -1,
+	.sg_tablesize		= GDTH_MAXSG,
+	.cmd_per_lun		= GDTH_MAXC_P_L,
+	.unchecked_isa_dma	= 1,
 	.no_write_same		= 1,
 };
 
@@ -4269,7 +4291,7 @@ static int __init gdth_init(void)
 {
 	if (disable) {
 		printk("GDT-HA: Controller driver disabled from"
-                       " command line !\n");
+		       " command line !\n");
 		return 0;
 	}
 
diff --git a/drivers/scsi/gdth.h b/drivers/scsi/gdth.h
index 5a13d406d40e..01ddfd0cfda6 100644
--- a/drivers/scsi/gdth.h
+++ b/drivers/scsi/gdth.h
@@ -4,9 +4,9 @@
 
 /*
  * Header file for the GDT Disk Array/Storage RAID controllers driver for Linux
- * 
+ *
  * gdth.h Copyright (C) 1995-06 ICP vortex, Achim Leubner
- * See gdth.c for further informations and 
+ * See gdth.c for further informations and
  * below for supported controller types
  *
  * <achim_leubner@adaptec.com>
@@ -26,278 +26,278 @@
 /* defines, macros */
 
 /* driver version */
-#define GDTH_VERSION_STR        "3.05"
-#define GDTH_VERSION            3
-#define GDTH_SUBVERSION         5
+#define GDTH_VERSION_STR	"3.05"
+#define GDTH_VERSION		3
+#define GDTH_SUBVERSION		5
 
 /* protocol version */
-#define PROTOCOL_VERSION        1
+#define PROTOCOL_VERSION	1
 
 /* OEM IDs */
-#define OEM_ID_ICP      0x941c
-#define OEM_ID_INTEL    0x8000
+#define OEM_ID_ICP	  0x941c
+#define OEM_ID_INTEL	0x8000
 
 /* controller classes */
-#define GDT_PCI         0x03                    /* PCI controller */
-#define GDT_PCINEW      0x04                    /* new PCI controller */
-#define GDT_PCIMPR      0x05                    /* PCI MPR controller */
+#define GDT_PCI		0x03			/* PCI controller */
+#define GDT_PCINEW	0x04			/* new PCI controller */
+#define GDT_PCIMPR	0x05			/* PCI MPR controller */
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDT60x0
 /* GDT_PCI */
-#define PCI_DEVICE_ID_VORTEX_GDT60x0    0       /* GDT6000/6020/6050 */
-#define PCI_DEVICE_ID_VORTEX_GDT6000B   1       /* GDT6000B/6010 */
+#define PCI_DEVICE_ID_VORTEX_GDT60x0	0	/* GDT6000/6020/6050 */
+#define PCI_DEVICE_ID_VORTEX_GDT6000B	1	/* GDT6000B/6010 */
 /* GDT_PCINEW */
-#define PCI_DEVICE_ID_VORTEX_GDT6x10    2       /* GDT6110/6510 */
-#define PCI_DEVICE_ID_VORTEX_GDT6x20    3       /* GDT6120/6520 */
-#define PCI_DEVICE_ID_VORTEX_GDT6530    4       /* GDT6530 */
-#define PCI_DEVICE_ID_VORTEX_GDT6550    5       /* GDT6550 */
+#define PCI_DEVICE_ID_VORTEX_GDT6x10	2	/* GDT6110/6510 */
+#define PCI_DEVICE_ID_VORTEX_GDT6x20	3	/* GDT6120/6520 */
+#define PCI_DEVICE_ID_VORTEX_GDT6530	4	/* GDT6530 */
+#define PCI_DEVICE_ID_VORTEX_GDT6550	5	/* GDT6550 */
 /* GDT_PCINEW, wide/ultra SCSI controllers */
-#define PCI_DEVICE_ID_VORTEX_GDT6x17    6       /* GDT6117/6517 */
-#define PCI_DEVICE_ID_VORTEX_GDT6x27    7       /* GDT6127/6527 */
-#define PCI_DEVICE_ID_VORTEX_GDT6537    8       /* GDT6537 */
-#define PCI_DEVICE_ID_VORTEX_GDT6557    9       /* GDT6557/6557-ECC */
+#define PCI_DEVICE_ID_VORTEX_GDT6x17	6	/* GDT6117/6517 */
+#define PCI_DEVICE_ID_VORTEX_GDT6x27	7	/* GDT6127/6527 */
+#define PCI_DEVICE_ID_VORTEX_GDT6537	8	/* GDT6537 */
+#define PCI_DEVICE_ID_VORTEX_GDT6557	9	/* GDT6557/6557-ECC */
 /* GDT_PCINEW, wide SCSI controllers */
-#define PCI_DEVICE_ID_VORTEX_GDT6x15    10      /* GDT6115/6515 */
-#define PCI_DEVICE_ID_VORTEX_GDT6x25    11      /* GDT6125/6525 */
-#define PCI_DEVICE_ID_VORTEX_GDT6535    12      /* GDT6535 */
-#define PCI_DEVICE_ID_VORTEX_GDT6555    13      /* GDT6555/6555-ECC */
+#define PCI_DEVICE_ID_VORTEX_GDT6x15	10	/* GDT6115/6515 */
+#define PCI_DEVICE_ID_VORTEX_GDT6x25	11	/* GDT6125/6525 */
+#define PCI_DEVICE_ID_VORTEX_GDT6535	12	/* GDT6535 */
+#define PCI_DEVICE_ID_VORTEX_GDT6555	13	/* GDT6555/6555-ECC */
 #endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDT6x17RP
 /* GDT_MPR, RP series, wide/ultra SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT6x17RP  0x100   /* GDT6117RP/GDT6517RP */
-#define PCI_DEVICE_ID_VORTEX_GDT6x27RP  0x101   /* GDT6127RP/GDT6527RP */
-#define PCI_DEVICE_ID_VORTEX_GDT6537RP  0x102   /* GDT6537RP */
-#define PCI_DEVICE_ID_VORTEX_GDT6557RP  0x103   /* GDT6557RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6x17RP	0x100	/* GDT6117RP/GDT6517RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6x27RP	0x101	/* GDT6127RP/GDT6527RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6537RP	0x102	/* GDT6537RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6557RP	0x103	/* GDT6557RP */
 /* GDT_MPR, RP series, narrow/ultra SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT6x11RP  0x104   /* GDT6111RP/GDT6511RP */
-#define PCI_DEVICE_ID_VORTEX_GDT6x21RP  0x105   /* GDT6121RP/GDT6521RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6x11RP	0x104	/* GDT6111RP/GDT6511RP */
+#define PCI_DEVICE_ID_VORTEX_GDT6x21RP	0x105	/* GDT6121RP/GDT6521RP */
 #endif
 #ifndef PCI_DEVICE_ID_VORTEX_GDT6x17RD
 /* GDT_MPR, RD series, wide/ultra SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT6x17RD  0x110   /* GDT6117RD/GDT6517RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x27RD  0x111   /* GDT6127RD/GDT6527RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6537RD  0x112   /* GDT6537RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6557RD  0x113   /* GDT6557RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x17RD	0x110	/* GDT6117RD/GDT6517RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x27RD	0x111	/* GDT6127RD/GDT6527RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6537RD	0x112	/* GDT6537RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6557RD	0x113	/* GDT6557RD */
 /* GDT_MPR, RD series, narrow/ultra SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT6x11RD  0x114   /* GDT6111RD/GDT6511RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x21RD  0x115   /* GDT6121RD/GDT6521RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x11RD	0x114	/* GDT6111RD/GDT6511RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x21RD	0x115	/* GDT6121RD/GDT6521RD */
 /* GDT_MPR, RD series, wide/ultra2 SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT6x18RD  0x118   /* GDT6118RD/GDT6518RD/
-                                                   GDT6618RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x28RD  0x119   /* GDT6128RD/GDT6528RD/
-                                                   GDT6628RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x38RD  0x11A   /* GDT6538RD/GDT6638RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x58RD  0x11B   /* GDT6558RD/GDT6658RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x18RD	0x118	/* GDT6118RD/GDT6518RD/
+						   GDT6618RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x28RD	0x119	/* GDT6128RD/GDT6528RD/
+						   GDT6628RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x38RD	0x11A	/* GDT6538RD/GDT6638RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x58RD	0x11B	/* GDT6558RD/GDT6658RD */
 /* GDT_MPR, RN series (64-bit PCI), wide/ultra2 SCSI */
-#define PCI_DEVICE_ID_VORTEX_GDT7x18RN  0x168   /* GDT7118RN/GDT7518RN/
-                                                   GDT7618RN */
-#define PCI_DEVICE_ID_VORTEX_GDT7x28RN  0x169   /* GDT7128RN/GDT7528RN/
-                                                   GDT7628RN */
-#define PCI_DEVICE_ID_VORTEX_GDT7x38RN  0x16A   /* GDT7538RN/GDT7638RN */
-#define PCI_DEVICE_ID_VORTEX_GDT7x58RN  0x16B   /* GDT7558RN/GDT7658RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x18RN	0x168	/* GDT7118RN/GDT7518RN/
+						   GDT7618RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x28RN	0x169	/* GDT7128RN/GDT7528RN/
+						   GDT7628RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x38RN	0x16A	/* GDT7538RN/GDT7638RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x58RN	0x16B	/* GDT7558RN/GDT7658RN */
 #endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDT6x19RD
 /* GDT_MPR, RD series, Fibre Channel */
-#define PCI_DEVICE_ID_VORTEX_GDT6x19RD  0x210   /* GDT6519RD/GDT6619RD */
-#define PCI_DEVICE_ID_VORTEX_GDT6x29RD  0x211   /* GDT6529RD/GDT6629RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x19RD	0x210	/* GDT6519RD/GDT6619RD */
+#define PCI_DEVICE_ID_VORTEX_GDT6x29RD	0x211	/* GDT6529RD/GDT6629RD */
 /* GDT_MPR, RN series (64-bit PCI), Fibre Channel */
-#define PCI_DEVICE_ID_VORTEX_GDT7x19RN  0x260   /* GDT7519RN/GDT7619RN */
-#define PCI_DEVICE_ID_VORTEX_GDT7x29RN  0x261   /* GDT7529RN/GDT7629RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x19RN	0x260	/* GDT7519RN/GDT7619RN */
+#define PCI_DEVICE_ID_VORTEX_GDT7x29RN	0x261	/* GDT7529RN/GDT7629RN */
 #endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDTMAXRP
 /* GDT_MPR, last device ID */
-#define PCI_DEVICE_ID_VORTEX_GDTMAXRP   0x2ff   
+#define PCI_DEVICE_ID_VORTEX_GDTMAXRP	0x2ff
 #endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDTNEWRX
 /* new GDT Rx Controller */
-#define PCI_DEVICE_ID_VORTEX_GDTNEWRX   0x300
+#define PCI_DEVICE_ID_VORTEX_GDTNEWRX	0x300
 #endif
 
 #ifndef PCI_DEVICE_ID_VORTEX_GDTNEWRX2
 /* new(2) GDT Rx Controller */
-#define PCI_DEVICE_ID_VORTEX_GDTNEWRX2  0x301
-#endif        
+#define PCI_DEVICE_ID_VORTEX_GDTNEWRX2	0x301
+#endif
 
 #ifndef PCI_DEVICE_ID_INTEL_SRC
 /* Intel Storage RAID Controller */
-#define PCI_DEVICE_ID_INTEL_SRC         0x600
+#define PCI_DEVICE_ID_INTEL_SRC		0x600
 #endif
 
 #ifndef PCI_DEVICE_ID_INTEL_SRC_XSCALE
 /* Intel Storage RAID Controller */
-#define PCI_DEVICE_ID_INTEL_SRC_XSCALE  0x601
+#define PCI_DEVICE_ID_INTEL_SRC_XSCALE	0x601
 #endif
 
 /* limits */
-#define GDTH_SCRATCH    PAGE_SIZE               /* 4KB scratch buffer */
-#define GDTH_MAXCMDS    120
-#define GDTH_MAXC_P_L   16                      /* max. cmds per lun */
-#define GDTH_MAX_RAW    2                       /* max. cmds per raw device */
-#define MAXOFFSETS      128
-#define MAXHA           16
-#define MAXID           127
-#define MAXLUN          8
-#define MAXBUS          6
-#define MAX_EVENTS      100                     /* event buffer count */
-#define MAX_RES_ARGS    40                      /* device reservation, 
-                                                   must be a multiple of 4 */
-#define MAXCYLS         1024
-#define HEADS           64
-#define SECS            32                      /* mapping 64*32 */
-#define MEDHEADS        127
-#define MEDSECS         63                      /* mapping 127*63 */
-#define BIGHEADS        255
-#define BIGSECS         63                      /* mapping 255*63 */
+#define GDTH_SCRATCH	PAGE_SIZE		/* 4KB scratch buffer */
+#define GDTH_MAXCMDS	120
+#define GDTH_MAXC_P_L	16			/* max. cmds per lun */
+#define GDTH_MAX_RAW	2			/* max. cmds per raw device */
+#define MAXOFFSETS	128
+#define MAXHA		16
+#define MAXID		127
+#define MAXLUN		8
+#define MAXBUS		6
+#define MAX_EVENTS	100			/* event buffer count */
+#define MAX_RES_ARGS	40			/* device reservation,
+						   must be a multiple of 4 */
+#define MAXCYLS		1024
+#define HEADS		64
+#define SECS		32			/* mapping 64*32 */
+#define MEDHEADS	127
+#define MEDSECS		63			/* mapping 127*63 */
+#define BIGHEADS	255
+#define BIGSECS		63			/* mapping 255*63 */
 
 /* special command ptr. */
-#define UNUSED_CMND     ((struct scsi_cmnd *)-1)
-#define INTERNAL_CMND   ((struct scsi_cmnd *)-2)
-#define SCREEN_CMND     ((struct scsi_cmnd *)-3)
-#define SPECIAL_SCP(p)  (p==UNUSED_CMND || p==INTERNAL_CMND || p==SCREEN_CMND)
+#define UNUSED_CMND	((struct scsi_cmnd *)-1)
+#define INTERNAL_CMND	((struct scsi_cmnd *)-2)
+#define SCREEN_CMND	((struct scsi_cmnd *)-3)
+#define SPECIAL_SCP(p)	(p==UNUSED_CMND || p==INTERNAL_CMND || p==SCREEN_CMND)
 
 /* controller services */
-#define SCSIRAWSERVICE  3
-#define CACHESERVICE    9
-#define SCREENSERVICE   11
+#define SCSIRAWSERVICE	3
+#define CACHESERVICE	9
+#define SCREENSERVICE	11
 
 /* screenservice defines */
-#define MSG_INV_HANDLE  -1                      /* special message handle */
-#define MSGLEN          16                      /* size of message text */
-#define MSG_SIZE        34                      /* size of message structure */
-#define MSG_REQUEST     0                       /* async. event: message */
+#define MSG_INV_HANDLE	-1			/* special message handle */
+#define MSGLEN		16			/* size of message text */
+#define MSG_SIZE	34			/* size of message structure */
+#define MSG_REQUEST	0			/* async. event: message */
 
 /* DPMEM constants */
-#define DPMEM_MAGIC     0xC0FFEE11
+#define DPMEM_MAGIC	0xC0FFEE11
 #define IC_HEADER_BYTES 48
-#define IC_QUEUE_BYTES  4
-#define DPMEM_COMMAND_OFFSET    IC_HEADER_BYTES+IC_QUEUE_BYTES*MAXOFFSETS
+#define IC_QUEUE_BYTES	4
+#define DPMEM_COMMAND_OFFSET	IC_HEADER_BYTES+IC_QUEUE_BYTES*MAXOFFSETS
 
 /* cluster_type constants */
-#define CLUSTER_DRIVE         1
-#define CLUSTER_MOUNTED       2
-#define CLUSTER_RESERVED      4
-#define CLUSTER_RESERVE_STATE (CLUSTER_DRIVE|CLUSTER_MOUNTED|CLUSTER_RESERVED)
+#define CLUSTER_DRIVE		1
+#define CLUSTER_MOUNTED		2
+#define CLUSTER_RESERVED	4
+#define CLUSTER_RESERVE_STATE	(CLUSTER_DRIVE|CLUSTER_MOUNTED|CLUSTER_RESERVED)
 
 /* commands for all services, cache service */
-#define GDT_INIT        0                       /* service initialization */
-#define GDT_READ        1                       /* read command */
-#define GDT_WRITE       2                       /* write command */
-#define GDT_INFO        3                       /* information about devices */
-#define GDT_FLUSH       4                       /* flush dirty cache buffers */
-#define GDT_IOCTL       5                       /* ioctl command */
-#define GDT_DEVTYPE     9                       /* additional information */
-#define GDT_MOUNT       10                      /* mount cache device */
-#define GDT_UNMOUNT     11                      /* unmount cache device */
-#define GDT_SET_FEAT    12                      /* set feat. (scatter/gather) */
-#define GDT_GET_FEAT    13                      /* get features */
-#define GDT_WRITE_THR   16                      /* write through */
-#define GDT_READ_THR    17                      /* read through */
-#define GDT_EXT_INFO    18                      /* extended info */
-#define GDT_RESET       19                      /* controller reset */
-#define GDT_RESERVE_DRV 20                      /* reserve host drive */
-#define GDT_RELEASE_DRV 21                      /* release host drive */
-#define GDT_CLUST_INFO  22                      /* cluster info */
-#define GDT_RW_ATTRIBS  23                      /* R/W attribs (write thru,..)*/
-#define GDT_CLUST_RESET 24                      /* releases the cluster drives*/
-#define GDT_FREEZE_IO   25                      /* freezes all IOs */
-#define GDT_UNFREEZE_IO 26                      /* unfreezes all IOs */
-#define GDT_X_INIT_HOST 29                      /* ext. init: 64 bit support */
-#define GDT_X_INFO      30                      /* ext. info for drives>2TB */
+#define GDT_INIT	0			/* service initialization */
+#define GDT_READ	1			/* read command */
+#define GDT_WRITE	2			/* write command */
+#define GDT_INFO	3			/* information about devices */
+#define GDT_FLUSH	4			/* flush dirty cache buffers */
+#define GDT_IOCTL	5			/* ioctl command */
+#define GDT_DEVTYPE	9			/* additional information */
+#define GDT_MOUNT	10			/* mount cache device */
+#define GDT_UNMOUNT	11			/* unmount cache device */
+#define GDT_SET_FEAT	12			/* set feat. (scatter/gather) */
+#define GDT_GET_FEAT	13			/* get features */
+#define GDT_WRITE_THR	16			/* write through */
+#define GDT_READ_THR	17			/* read through */
+#define GDT_EXT_INFO	18			/* extended info */
+#define GDT_RESET	19			/* controller reset */
+#define GDT_RESERVE_DRV	20			/* reserve host drive */
+#define GDT_RELEASE_DRV	21			/* release host drive */
+#define GDT_CLUST_INFO	22			/* cluster info */
+#define GDT_RW_ATTRIBS	23			/* R/W attribs (write thru,..)*/
+#define GDT_CLUST_RESET	24			/* releases the cluster drives*/
+#define GDT_FREEZE_IO	25			/* freezes all IOs */
+#define GDT_UNFREEZE_IO	26			/* unfreezes all IOs */
+#define GDT_X_INIT_HOST	29			/* ext. init: 64 bit support */
+#define GDT_X_INFO	30			/* ext. info for drives>2TB */
 
 /* raw service commands */
-#define GDT_RESERVE     14                      /* reserve dev. to raw serv. */
-#define GDT_RELEASE     15                      /* release device */
-#define GDT_RESERVE_ALL 16                      /* reserve all devices */
-#define GDT_RELEASE_ALL 17                      /* release all devices */
-#define GDT_RESET_BUS   18                      /* reset bus */
-#define GDT_SCAN_START  19                      /* start device scan */
-#define GDT_SCAN_END    20                      /* stop device scan */  
-#define GDT_X_INIT_RAW  21                      /* ext. init: 64 bit support */
+#define GDT_RESERVE	14			/* reserve dev. to raw serv. */
+#define GDT_RELEASE	15			/* release device */
+#define GDT_RESERVE_ALL	16			/* reserve all devices */
+#define GDT_RELEASE_ALL	17			/* release all devices */
+#define GDT_RESET_BUS	18			/* reset bus */
+#define GDT_SCAN_START	19			/* start device scan */
+#define GDT_SCAN_END	20			/* stop device scan */
+#define GDT_X_INIT_RAW	21			/* ext. init: 64 bit support */
 
 /* screen service commands */
-#define GDT_REALTIME    3                       /* realtime clock to screens. */
-#define GDT_X_INIT_SCR  4                       /* ext. init: 64 bit support */
+#define GDT_REALTIME	3			/* realtime clock to screens. */
+#define GDT_X_INIT_SCR	4			/* ext. init: 64 bit support */
 
 /* IOCTL command defines */
-#define SCSI_DR_INFO    0x00                    /* SCSI drive info */                   
-#define SCSI_CHAN_CNT   0x05                    /* SCSI channel count */   
-#define SCSI_DR_LIST    0x06                    /* SCSI drive list */
-#define SCSI_DEF_CNT    0x15                    /* grown/primary defects */
-#define DSK_STATISTICS  0x4b                    /* SCSI disk statistics */
-#define IOCHAN_DESC     0x5d                    /* description of IO channel */
-#define IOCHAN_RAW_DESC 0x5e                    /* description of raw IO chn. */
-#define L_CTRL_PATTERN  0x20000000L             /* SCSI IOCTL mask */
-#define ARRAY_INFO      0x12                    /* array drive info */
-#define ARRAY_DRV_LIST  0x0f                    /* array drive list */
-#define ARRAY_DRV_LIST2 0x34                    /* array drive list (new) */
-#define LA_CTRL_PATTERN 0x10000000L             /* array IOCTL mask */
-#define CACHE_DRV_CNT   0x01                    /* cache drive count */
-#define CACHE_DRV_LIST  0x02                    /* cache drive list */
-#define CACHE_INFO      0x04                    /* cache info */
-#define CACHE_CONFIG    0x05                    /* cache configuration */
-#define CACHE_DRV_INFO  0x07                    /* cache drive info */
-#define BOARD_FEATURES  0x15                    /* controller features */
-#define BOARD_INFO      0x28                    /* controller info */
-#define SET_PERF_MODES  0x82                    /* set mode (coalescing,..) */
-#define GET_PERF_MODES  0x83                    /* get mode */
-#define CACHE_READ_OEM_STRING_RECORD 0x84       /* read OEM string record */ 
-#define HOST_GET        0x10001L                /* get host drive list */
-#define IO_CHANNEL      0x00020000L             /* default IO channel */
-#define INVALID_CHANNEL 0x0000ffffL             /* invalid channel */
+#define SCSI_DR_INFO	0x00			/* SCSI drive info */
+#define SCSI_CHAN_CNT	0x05			/* SCSI channel count */
+#define SCSI_DR_LIST	0x06			/* SCSI drive list */
+#define SCSI_DEF_CNT	0x15			/* grown/primary defects */
+#define DSK_STATISTICS	0x4b			/* SCSI disk statistics */
+#define IOCHAN_DESC	0x5d			/* description of IO channel */
+#define IOCHAN_RAW_DESC	0x5e			/* description of raw IO chn. */
+#define L_CTRL_PATTERN	0x20000000L		/* SCSI IOCTL mask */
+#define ARRAY_INFO	0x12			/* array drive info */
+#define ARRAY_DRV_LIST	0x0f			/* array drive list */
+#define ARRAY_DRV_LIST2 0x34			/* array drive list (new) */
+#define LA_CTRL_PATTERN 0x10000000L		/* array IOCTL mask */
+#define CACHE_DRV_CNT	0x01			/* cache drive count */
+#define CACHE_DRV_LIST	0x02			/* cache drive list */
+#define CACHE_INFO	0x04			/* cache info */
+#define CACHE_CONFIG	0x05			/* cache configuration */
+#define CACHE_DRV_INFO	0x07			/* cache drive info */
+#define BOARD_FEATURES	0x15			/* controller features */
+#define BOARD_INFO	0x28			/* controller info */
+#define SET_PERF_MODES	0x82			/* set mode (coalescing,..) */
+#define GET_PERF_MODES	0x83			/* get mode */
+#define CACHE_READ_OEM_STRING_RECORD 0x84	/* read OEM string record */
+#define HOST_GET	0x10001L		/* get host drive list */
+#define IO_CHANNEL	0x00020000L		/* default IO channel */
+#define INVALID_CHANNEL	0x0000ffffL		/* invalid channel */
 
 /* service errors */
-#define S_OK            1                       /* no error */
-#define S_GENERR        6                       /* general error */
-#define S_BSY           7                       /* controller busy */
-#define S_CACHE_UNKNOWN 12                      /* cache serv.: drive unknown */
-#define S_RAW_SCSI      12                      /* raw serv.: target error */
-#define S_RAW_ILL       0xff                    /* raw serv.: illegal */
-#define S_NOFUNC        -2                      /* unknown function */
-#define S_CACHE_RESERV  -24                     /* cache: reserv. conflict */   
+#define S_OK		1			/* no error */
+#define S_GENERR	6			/* general error */
+#define S_BSY		7			/* controller busy */
+#define S_CACHE_UNKNOWN 12			/* cache serv.: drive unknown */
+#define S_RAW_SCSI	12			/* raw serv.: target error */
+#define S_RAW_ILL	0xff			/* raw serv.: illegal */
+#define S_NOFUNC	-2			/* unknown function */
+#define S_CACHE_RESERV  -24			/* cache: reserv. conflict */
 
 /* timeout values */
-#define INIT_RETRIES    100000                  /* 100000 * 1ms = 100s */
-#define INIT_TIMEOUT    100000                  /* 100000 * 1ms = 100s */
-#define POLL_TIMEOUT    10000                   /* 10000 * 1ms = 10s */
+#define INIT_RETRIES	100000		/* 100000 * 1ms = 100s */
+#define INIT_TIMEOUT	100000		/* 100000 * 1ms = 100s */
+#define POLL_TIMEOUT	10000		/* 10000 * 1ms = 10s */
 
 /* priorities */
-#define DEFAULT_PRI     0x20
-#define IOCTL_PRI       0x10
-#define HIGH_PRI        0x08
+#define DEFAULT_PRI	0x20
+#define IOCTL_PRI	0x10
+#define HIGH_PRI	0x08
 
 /* data directions */
-#define GDTH_DATA_IN    0x01000000L             /* data from target */
-#define GDTH_DATA_OUT   0x00000000L             /* data to target */
+#define GDTH_DATA_IN	0x01000000L		/* data from target */
+#define GDTH_DATA_OUT	0x00000000L		/* data to target */
 
 /* other defines */
-#define LINUX_OS        8                       /* used for cache optim. */
-#define SECS32          0x1f                    /* round capacity */
-#define BIOS_ID_OFFS    0x10                    /* offset contr-ID in ISABIOS */
-#define LOCALBOARD      0                       /* board node always 0 */
-#define ASYNCINDEX      0                       /* cmd index async. event */
-#define SPEZINDEX       1                       /* cmd index unknown service */
-#define COALINDEX       (GDTH_MAXCMDS + 2)
+#define LINUX_OS	8			/* used for cache optim. */
+#define SECS32		0x1f			/* round capacity */
+#define BIOS_ID_OFFS	0x10			/* offset contr-ID in ISABIOS */
+#define LOCALBOARD	0			/* board node always 0 */
+#define ASYNCINDEX	0			/* cmd index async. event */
+#define SPEZINDEX	1			/* cmd index unknown service */
+#define COALINDEX	(GDTH_MAXCMDS + 2)
 
 /* features */
-#define SCATTER_GATHER  1                       /* s/g feature */
-#define GDT_WR_THROUGH  0x100                   /* WRITE_THROUGH supported */
-#define GDT_64BIT       0x200                   /* 64bit / drv>2TB support */
+#define SCATTER_GATHER	1			/* s/g feature */
+#define GDT_WR_THROUGH	0x100		   /* WRITE_THROUGH supported */
+#define GDT_64BIT	0x200		   /* 64bit / drv>2TB support */
 
 #include "gdth_ioctl.h"
 
 /* screenservice message */
-typedef struct {                               
-    u32     msg_handle;                     /* message handle */
-    u32     msg_len;                        /* size of message */
-    u32     msg_alen;                       /* answer length */
-    u8      msg_answer;                     /* answer flag */
-    u8      msg_ext;                        /* more messages */
-    u8      msg_reserved[2];
-    char        msg_text[MSGLEN+2];             /* the message text */
+typedef struct {
+	u32	msg_handle;			/* message handle */
+	u32	msg_len;			/* size of message */
+	u32	msg_alen;			/* answer length */
+	u8	msg_answer;			/* answer flag */
+	u8	msg_ext;			/* more messages */
+	u8	msg_reserved[2];
+	char	msg_text[MSGLEN+2];		/* the message text */
 } __attribute__((packed)) gdth_msg_str;
 
 
@@ -305,604 +305,604 @@ typedef struct {
 
 /* Status coalescing buffer for returning multiple requests per interrupt */
 typedef struct {
-    u32     status;
-    u32     ext_status;
-    u32     info0;
-    u32     info1;
+	u32	status;
+	u32	ext_status;
+	u32	info0;
+	u32	info1;
 } __attribute__((packed)) gdth_coal_status;
 
 /* performance mode data structure */
 typedef struct {
-    u32     version;            /* The version of this IOCTL structure. */
-    u32     st_mode;            /* 0=dis., 1=st_buf_addr1 valid, 2=both  */
-    u32     st_buff_addr1;      /* physical address of status buffer 1 */
-    u32     st_buff_u_addr1;    /* reserved for 64 bit addressing */
-    u32     st_buff_indx1;      /* reserved command idx. for this buffer */
-    u32     st_buff_addr2;      /* physical address of status buffer 1 */
-    u32     st_buff_u_addr2;    /* reserved for 64 bit addressing */
-    u32     st_buff_indx2;      /* reserved command idx. for this buffer */
-    u32     st_buff_size;       /* size of each buffer in bytes */
-    u32     cmd_mode;           /* 0 = mode disabled, 1 = cmd_buff_addr1 */ 
-    u32     cmd_buff_addr1;     /* physical address of cmd buffer 1 */   
-    u32     cmd_buff_u_addr1;   /* reserved for 64 bit addressing */
-    u32     cmd_buff_indx1;     /* cmd buf addr1 unique identifier */
-    u32     cmd_buff_addr2;     /* physical address of cmd buffer 1 */   
-    u32     cmd_buff_u_addr2;   /* reserved for 64 bit addressing */
-    u32     cmd_buff_indx2;     /* cmd buf addr1 unique identifier */
-    u32     cmd_buff_size;      /* size of each cmd buffer in bytes */
-    u32     reserved1;
-    u32     reserved2;
+	u32	version;	/* The version of this IOCTL structure. */
+	u32	st_mode;	/* 0=dis., 1=st_buf_addr1 valid, 2=both  */
+	u32	st_buff_addr1;	/* physical address of status buffer 1 */
+	u32	st_buff_u_addr1; /* reserved for 64 bit addressing */
+	u32	st_buff_indx1;	/* reserved command idx. for this buffer */
+	u32	st_buff_addr2;	/* physical address of status buffer 1 */
+	u32	st_buff_u_addr2; /* reserved for 64 bit addressing */
+	u32	st_buff_indx2;	/* reserved command idx. for this buffer */
+	u32	st_buff_size;	/* size of each buffer in bytes */
+	u32	cmd_mode;	/* 0 = mode disabled, 1 = cmd_buff_addr1 */
+	u32	cmd_buff_addr1;	/* physical address of cmd buffer 1 */
+	u32	cmd_buff_u_addr1; /* reserved for 64 bit addressing */
+	u32	cmd_buff_indx1;	/* cmd buf addr1 unique identifier */
+	u32	cmd_buff_addr2;	/* physical address of cmd buffer 1 */
+	u32	cmd_buff_u_addr2; /* reserved for 64 bit addressing */
+	u32	cmd_buff_indx2;	/* cmd buf addr1 unique identifier */
+	u32	cmd_buff_size;	/* size of each cmd buffer in bytes */
+	u32	reserved1;
+	u32	reserved2;
 } __attribute__((packed)) gdth_perf_modes;
 
 /* SCSI drive info */
 typedef struct {
-    u8      vendor[8];                      /* vendor string */
-    u8      product[16];                    /* product string */
-    u8      revision[4];                    /* revision */
-    u32     sy_rate;                        /* current rate for sync. tr. */
-    u32     sy_max_rate;                    /* max. rate for sync. tr. */
-    u32     no_ldrive;                      /* belongs to this log. drv.*/
-    u32     blkcnt;                         /* number of blocks */
-    u16      blksize;                        /* size of block in bytes */
-    u8      available;                      /* flag: access is available */
-    u8      init;                           /* medium is initialized */
-    u8      devtype;                        /* SCSI devicetype */
-    u8      rm_medium;                      /* medium is removable */
-    u8      wp_medium;                      /* medium is write protected */
-    u8      ansi;                           /* SCSI I/II or III? */
-    u8      protocol;                       /* same as ansi */
-    u8      sync;                           /* flag: sync. transfer enab. */
-    u8      disc;                           /* flag: disconnect enabled */
-    u8      queueing;                       /* flag: command queing enab. */
-    u8      cached;                         /* flag: caching enabled */
-    u8      target_id;                      /* target ID of device */
-    u8      lun;                            /* LUN id of device */
-    u8      orphan;                         /* flag: drive fragment */
-    u32     last_error;                     /* sense key or drive state */
-    u32     last_result;                    /* result of last command */
-    u32     check_errors;                   /* err. in last surface check */
-    u8      percent;                        /* progress for surface check */
-    u8      last_check;                     /* IOCTRL operation */
-    u8      res[2];
-    u32     flags;                          /* from 1.19/2.19: raw reserv.*/
-    u8      multi_bus;                      /* multi bus dev? (fibre ch.) */
-    u8      mb_status;                      /* status: available? */
-    u8      res2[2];
-    u8      mb_alt_status;                  /* status on second bus */
-    u8      mb_alt_bid;                     /* number of second bus */
-    u8      mb_alt_tid;                     /* target id on second bus */
-    u8      res3;
-    u8      fc_flag;                        /* from 1.22/2.22: info valid?*/
-    u8      res4;
-    u16      fc_frame_size;                  /* frame size (bytes) */
-    char        wwn[8];                         /* world wide name */
+	u8	vendor[8];		/* vendor string */
+	u8	product[16];		/* product string */
+	u8	revision[4];		/* revision */
+	u32	sy_rate;		/* current rate for sync. tr. */
+	u32	sy_max_rate;		/* max. rate for sync. tr. */
+	u32	no_ldrive;		/* belongs to this log. drv.*/
+	u32	blkcnt;			/* number of blocks */
+	u16	blksize;		/* size of block in bytes */
+	u8	available;		/* flag: access is available */
+	u8	init;			/* medium is initialized */
+	u8	devtype;		/* SCSI devicetype */
+	u8	rm_medium;		/* medium is removable */
+	u8	wp_medium;		/* medium is write protected */
+	u8	ansi;			/* SCSI I/II or III? */
+	u8	protocol;		/* same as ansi */
+	u8	sync;			/* flag: sync. transfer enab. */
+	u8	disc;			/* flag: disconnect enabled */
+	u8	queueing;		/* flag: command queing enab. */
+	u8	cached;			/* flag: caching enabled */
+	u8	target_id;		/* target ID of device */
+	u8	lun;			/* LUN id of device */
+	u8	orphan;			/* flag: drive fragment */
+	u32	last_error;		/* sense key or drive state */
+	u32	last_result;		/* result of last command */
+	u32	check_errors;		/* err. in last surface check */
+	u8	percent;		/* progress for surface check */
+	u8	last_check;		/* IOCTRL operation */
+	u8	res[2];
+	u32	flags;			/* from 1.19/2.19: raw reserv.*/
+	u8	multi_bus;		/* multi bus dev? (fibre ch.) */
+	u8	mb_status;		/* status: available? */
+	u8	res2[2];
+	u8	mb_alt_status;		/* status on second bus */
+	u8	mb_alt_bid;		/* number of second bus */
+	u8	mb_alt_tid;		/* target id on second bus */
+	u8	res3;
+	u8	fc_flag;		/* from 1.22/2.22: info valid?*/
+	u8	res4;
+	u16	fc_frame_size;		/* frame size (bytes) */
+	char	wwn[8];			/* world wide name */
 } __attribute__((packed)) gdth_diskinfo_str;
 
 /* get SCSI channel count  */
 typedef struct {
-    u32     channel_no;                     /* number of channel */
-    u32     drive_cnt;                      /* drive count */
-    u8      siop_id;                        /* SCSI processor ID */
-    u8      siop_state;                     /* SCSI processor state */ 
+	u32	channel_no;		/* number of channel */
+	u32	drive_cnt;		/* drive count */
+	u8	siop_id;		/* SCSI processor ID */
+	u8	siop_state;		/* SCSI processor state */
 } __attribute__((packed)) gdth_getch_str;
 
 /* get SCSI drive numbers */
 typedef struct {
-    u32     sc_no;                          /* SCSI channel */
-    u32     sc_cnt;                         /* sc_list[] elements */
-    u32     sc_list[MAXID];                 /* minor device numbers */
+	u32	sc_no;			/* SCSI channel */
+	u32	sc_cnt;			/* sc_list[] elements */
+	u32	sc_list[MAXID];		/* minor device numbers */
 } __attribute__((packed)) gdth_drlist_str;
 
 /* get grown/primary defect count */
 typedef struct {
-    u8      sddc_type;                      /* 0x08: grown, 0x10: prim. */
-    u8      sddc_format;                    /* list entry format */
-    u8      sddc_len;                       /* list entry length */
-    u8      sddc_res;
-    u32     sddc_cnt;                       /* entry count */
+	u8	sddc_type;		/* 0x08: grown, 0x10: prim. */
+	u8	sddc_format;		/* list entry format */
+	u8	sddc_len;		/* list entry length */
+	u8	sddc_res;
+	u32	sddc_cnt;		/* entry count */
 } __attribute__((packed)) gdth_defcnt_str;
 
 /* disk statistics */
 typedef struct {
-    u32     bid;                            /* SCSI channel */
-    u32     first;                          /* first SCSI disk */
-    u32     entries;                        /* number of elements */
-    u32     count;                          /* (R) number of init. el. */
-    u32     mon_time;                       /* time stamp */
-    struct {
-        u8  tid;                            /* target ID */
-        u8  lun;                            /* LUN */
-        u8  res[2];
-        u32 blk_size;                       /* block size in bytes */
-        u32 rd_count;                       /* bytes read */
-        u32 wr_count;                       /* bytes written */
-        u32 rd_blk_count;                   /* blocks read */
-        u32 wr_blk_count;                   /* blocks written */
-        u32 retries;                        /* retries */
-        u32 reassigns;                      /* reassigns */
-    } __attribute__((packed)) list[1];
+	u32	bid;			/* SCSI channel */
+	u32	first;			/* first SCSI disk */
+	u32	entries;		/* number of elements */
+	u32	count;			/* (R) number of init. el. */
+	u32	mon_time;		/* time stamp */
+	struct {
+		u8  tid;		/* target ID */
+		u8  lun;		/* LUN */
+		u8  res[2];
+		u32 blk_size;		/* block size in bytes */
+		u32 rd_count;		/* bytes read */
+		u32 wr_count;		/* bytes written */
+		u32 rd_blk_count;	/* blocks read */
+		u32 wr_blk_count;	/* blocks written */
+		u32 retries;		/* retries */
+		u32 reassigns;		/* reassigns */
+	} __attribute__((packed)) list[1];
 } __attribute__((packed)) gdth_dskstat_str;
 
 /* IO channel header */
 typedef struct {
-    u32     version;                        /* version (-1UL: newest) */
-    u8      list_entries;                   /* list entry count */
-    u8      first_chan;                     /* first channel number */
-    u8      last_chan;                      /* last channel number */
-    u8      chan_count;                     /* (R) channel count */
-    u32     list_offset;                    /* offset of list[0] */
+	u32	version;		/* version (-1UL: newest) */
+	u8	list_entries;		/* list entry count */
+	u8	first_chan;		/* first channel number */
+	u8	last_chan;		/* last channel number */
+	u8	chan_count;		/* (R) channel count */
+	u32	list_offset;		/* offset of list[0] */
 } __attribute__((packed)) gdth_iochan_header;
 
 /* get IO channel description */
 typedef struct {
-    gdth_iochan_header  hdr;
-    struct {
-        u32         address;                /* channel address */
-        u8          type;                   /* type (SCSI, FCAL) */
-        u8          local_no;               /* local number */
-        u16          features;               /* channel features */
-    } __attribute__((packed)) list[MAXBUS];
+	gdth_iochan_header  hdr;
+	struct {
+		u32	 address;	/* channel address */
+		u8	  type;		/* type (SCSI, FCAL) */
+		u8	  local_no;	/* local number */
+		u16	  features;	/* channel features */
+	} __attribute__((packed)) list[MAXBUS];
 } __attribute__((packed)) gdth_iochan_str;
 
 /* get raw IO channel description */
 typedef struct {
-    gdth_iochan_header  hdr;
-    struct {
-        u8      proc_id;                    /* processor id */
-        u8      proc_defect;                /* defect ? */
-        u8      reserved[2];
-    } __attribute__((packed)) list[MAXBUS];
+	gdth_iochan_header  hdr;
+	struct {
+		u8	proc_id;	/* processor id */
+		u8	proc_defect;	/* defect ? */
+		u8	reserved[2];
+	} __attribute__((packed)) list[MAXBUS];
 } __attribute__((packed)) gdth_raw_iochan_str;
 
 /* array drive component */
 typedef struct {
-    u32     al_controller;                  /* controller ID */
-    u8      al_cache_drive;                 /* cache drive number */
-    u8      al_status;                      /* cache drive state */
-    u8      al_res[2];     
+	u32	al_controller;		/* controller ID */
+	u8	al_cache_drive;		/* cache drive number */
+	u8	al_status;		/* cache drive state */
+	u8	al_res[2];
 } __attribute__((packed)) gdth_arraycomp_str;
 
 /* array drive information */
 typedef struct {
-    u8      ai_type;                        /* array type (RAID0,4,5) */
-    u8      ai_cache_drive_cnt;             /* active cachedrives */
-    u8      ai_state;                       /* array drive state */
-    u8      ai_master_cd;                   /* master cachedrive */
-    u32     ai_master_controller;           /* ID of master controller */
-    u32     ai_size;                        /* user capacity [sectors] */
-    u32     ai_striping_size;               /* striping size [sectors] */
-    u32     ai_secsize;                     /* sector size [bytes] */
-    u32     ai_err_info;                    /* failed cache drive */
-    u8      ai_name[8];                     /* name of the array drive */
-    u8      ai_controller_cnt;              /* number of controllers */
-    u8      ai_removable;                   /* flag: removable */
-    u8      ai_write_protected;             /* flag: write protected */
-    u8      ai_devtype;                     /* type: always direct access */
-    gdth_arraycomp_str  ai_drives[35];          /* drive components: */
-    u8      ai_drive_entries;               /* number of drive components */
-    u8      ai_protected;                   /* protection flag */
-    u8      ai_verify_state;                /* state of a parity verify */
-    u8      ai_ext_state;                   /* extended array drive state */
-    u8      ai_expand_state;                /* array expand state (>=2.18)*/
-    u8      ai_reserved[3];
+	u8	ai_type;		/* array type (RAID0,4,5) */
+	u8	ai_cache_drive_cnt;	/* active cachedrives */
+	u8	ai_state;		/* array drive state */
+	u8	ai_master_cd;		/* master cachedrive */
+	u32	ai_master_controller;	/* ID of master controller */
+	u32	ai_size;		/* user capacity [sectors] */
+	u32	ai_striping_size;	/* striping size [sectors] */
+	u32	ai_secsize;		/* sector size [bytes] */
+	u32	ai_err_info;		/* failed cache drive */
+	u8	ai_name[8];		/* name of the array drive */
+	u8	ai_controller_cnt;	/* number of controllers */
+	u8	ai_removable;		/* flag: removable */
+	u8	ai_write_protected;	/* flag: write protected */
+	u8	ai_devtype;		/* type: always direct access */
+	gdth_arraycomp_str  ai_drives[35];  /* drive components: */
+	u8	ai_drive_entries;	/* number of drive components */
+	u8	ai_protected;		/* protection flag */
+	u8	ai_verify_state;	/* state of a parity verify */
+	u8	ai_ext_state;		/* extended array drive state */
+	u8	ai_expand_state;	/* array expand state (>=2.18)*/
+	u8	ai_reserved[3];
 } __attribute__((packed)) gdth_arrayinf_str;
 
 /* get array drive list */
 typedef struct {
-    u32     controller_no;                  /* controller no. */
-    u8      cd_handle;                      /* master cachedrive */
-    u8      is_arrayd;                      /* Flag: is array drive? */
-    u8      is_master;                      /* Flag: is array master? */
-    u8      is_parity;                      /* Flag: is parity drive? */
-    u8      is_hotfix;                      /* Flag: is hotfix drive? */
-    u8      res[3];
+	u32	controller_no;		/* controller no. */
+	u8	cd_handle;		/* master cachedrive */
+	u8	is_arrayd;		/* Flag: is array drive? */
+	u8	is_master;		/* Flag: is array master? */
+	u8	is_parity;		/* Flag: is parity drive? */
+	u8	is_hotfix;		/* Flag: is hotfix drive? */
+	u8	res[3];
 } __attribute__((packed)) gdth_alist_str;
 
 typedef struct {
-    u32     entries_avail;                  /* allocated entries */
-    u32     entries_init;                   /* returned entries */
-    u32     first_entry;                    /* first entry number */
-    u32     list_offset;                    /* offset of following list */
-    gdth_alist_str list[1];                     /* list */
+	u32	entries_avail;		/* allocated entries */
+	u32	entries_init;		/* returned entries */
+	u32	first_entry;		/* first entry number */
+	u32	list_offset;		/* offset of following list */
+	gdth_alist_str list[1];		/* list */
 } __attribute__((packed)) gdth_arcdl_str;
 
 /* cache info/config IOCTL */
 typedef struct {
-    u32     version;                        /* firmware version */
-    u16      state;                          /* cache state (on/off) */
-    u16      strategy;                       /* cache strategy */
-    u16      write_back;                     /* write back state (on/off) */
-    u16      block_size;                     /* cache block size */
+	u32	version;		/* firmware version */
+	u16	state;			/* cache state (on/off) */
+	u16	strategy;		/* cache strategy */
+	u16	write_back;		/* write back state (on/off) */
+	u16	block_size;		/* cache block size */
 } __attribute__((packed)) gdth_cpar_str;
 
 typedef struct {
-    u32     csize;                          /* cache size */
-    u32     read_cnt;                       /* read/write counter */
-    u32     write_cnt;
-    u32     tr_hits;                        /* hits */
-    u32     sec_hits;
-    u32     sec_miss;                       /* misses */
+	u32	csize;			/* cache size */
+	u32	read_cnt;		/* read/write counter */
+	u32	write_cnt;
+	u32	tr_hits;		/* hits */
+	u32	sec_hits;
+	u32	sec_miss;		/* misses */
 } __attribute__((packed)) gdth_cstat_str;
 
 typedef struct {
-    gdth_cpar_str   cpar;
-    gdth_cstat_str  cstat;
+	gdth_cpar_str   cpar;
+	gdth_cstat_str  cstat;
 } __attribute__((packed)) gdth_cinfo_str;
 
 /* cache drive info */
 typedef struct {
-    u8      cd_name[8];                     /* cache drive name */
-    u32     cd_devtype;                     /* SCSI devicetype */
-    u32     cd_ldcnt;                       /* number of log. drives */
-    u32     cd_last_error;                  /* last error */
-    u8      cd_initialized;                 /* drive is initialized */
-    u8      cd_removable;                   /* media is removable */
-    u8      cd_write_protected;             /* write protected */
-    u8      cd_flags;                       /* Pool Hot Fix? */
-    u32     ld_blkcnt;                      /* number of blocks */
-    u32     ld_blksize;                     /* blocksize */
-    u32     ld_dcnt;                        /* number of disks */
-    u32     ld_slave;                       /* log. drive index */
-    u32     ld_dtype;                       /* type of logical drive */
-    u32     ld_last_error;                  /* last error */
-    u8      ld_name[8];                     /* log. drive name */
-    u8      ld_error;                       /* error */
+	u8	cd_name[8];		/* cache drive name */
+	u32	cd_devtype;		/* SCSI devicetype */
+	u32	cd_ldcnt;		/* number of log. drives */
+	u32	cd_last_error;		/* last error */
+	u8	cd_initialized;		/* drive is initialized */
+	u8	cd_removable;		/* media is removable */
+	u8	cd_write_protected;	/* write protected */
+	u8	cd_flags;		/* Pool Hot Fix? */
+	u32	ld_blkcnt;		/* number of blocks */
+	u32	ld_blksize;		/* blocksize */
+	u32	ld_dcnt;		/* number of disks */
+	u32	ld_slave;		/* log. drive index */
+	u32	ld_dtype;		/* type of logical drive */
+	u32	ld_last_error;		/* last error */
+	u8	ld_name[8];		/* log. drive name */
+	u8	ld_error;		/* error */
 } __attribute__((packed)) gdth_cdrinfo_str;
 
 /* OEM string */
 typedef struct {
-    u32     ctl_version;
-    u32     file_major_version;
-    u32     file_minor_version;
-    u32     buffer_size;
-    u32     cpy_count;
-    u32     ext_error;
-    u32     oem_id;
-    u32     board_id;
+	u32	ctl_version;
+	u32	file_major_version;
+	u32	file_minor_version;
+	u32	buffer_size;
+	u32	cpy_count;
+	u32	ext_error;
+	u32	oem_id;
+	u32	board_id;
 } __attribute__((packed)) gdth_oem_str_params;
 
 typedef struct {
-    u8      product_0_1_name[16];
-    u8      product_4_5_name[16];
-    u8      product_cluster_name[16];
-    u8      product_reserved[16];
-    u8      scsi_cluster_target_vendor_id[16];
-    u8      cluster_raid_fw_name[16];
-    u8      oem_brand_name[16];
-    u8      oem_raid_type[16];
-    u8      bios_type[13];
-    u8      bios_title[50];
-    u8      oem_company_name[37];
-    u32     pci_id_1;
-    u32     pci_id_2;
-    u8      validation_status[80];
-    u8      reserved_1[4];
-    u8      scsi_host_drive_inquiry_vendor_id[16];
-    u8      library_file_template[16];
-    u8      reserved_2[16];
-    u8      tool_name_1[32];
-    u8      tool_name_2[32];
-    u8      tool_name_3[32];
-    u8      oem_contact_1[84];
-    u8      oem_contact_2[84];
-    u8      oem_contact_3[84];
+	u8	product_0_1_name[16];
+	u8	product_4_5_name[16];
+	u8	product_cluster_name[16];
+	u8	product_reserved[16];
+	u8	scsi_cluster_target_vendor_id[16];
+	u8	cluster_raid_fw_name[16];
+	u8	oem_brand_name[16];
+	u8	oem_raid_type[16];
+	u8	bios_type[13];
+	u8	bios_title[50];
+	u8	oem_company_name[37];
+	u32	pci_id_1;
+	u32	pci_id_2;
+	u8	validation_status[80];
+	u8	reserved_1[4];
+	u8	scsi_host_drive_inquiry_vendor_id[16];
+	u8	library_file_template[16];
+	u8	reserved_2[16];
+	u8	tool_name_1[32];
+	u8	tool_name_2[32];
+	u8	tool_name_3[32];
+	u8	oem_contact_1[84];
+	u8	oem_contact_2[84];
+	u8	oem_contact_3[84];
 } __attribute__((packed)) gdth_oem_str;
 
 typedef struct {
-    gdth_oem_str_params params;
-    gdth_oem_str        text;
+	gdth_oem_str_params params;
+	gdth_oem_str	text;
 } __attribute__((packed)) gdth_oem_str_ioctl;
 
 /* board features */
 typedef struct {
-    u8      chaining;                       /* Chaining supported */
-    u8      striping;                       /* Striping (RAID-0) supp. */
-    u8      mirroring;                      /* Mirroring (RAID-1) supp. */
-    u8      raid;                           /* RAID-4/5/10 supported */
+	u8	chaining;		/* Chaining supported */
+	u8	striping;		/* Striping (RAID-0) supp. */
+	u8	mirroring;		/* Mirroring (RAID-1) supp. */
+	u8	raid;			/* RAID-4/5/10 supported */
 } __attribute__((packed)) gdth_bfeat_str;
 
 /* board info IOCTL */
 typedef struct {
-    u32     ser_no;                         /* serial no. */
-    u8      oem_id[2];                      /* OEM ID */
-    u16      ep_flags;                       /* eprom flags */
-    u32     proc_id;                        /* processor ID */
-    u32     memsize;                        /* memory size (bytes) */
-    u8      mem_banks;                      /* memory banks */
-    u8      chan_type;                      /* channel type */
-    u8      chan_count;                     /* channel count */
-    u8      rdongle_pres;                   /* dongle present? */
-    u32     epr_fw_ver;                     /* (eprom) firmware version */
-    u32     upd_fw_ver;                     /* (update) firmware version */
-    u32     upd_revision;                   /* update revision */
-    char        type_string[16];                /* controller name */
-    char        raid_string[16];                /* RAID firmware name */
-    u8      update_pres;                    /* update present? */
-    u8      xor_pres;                       /* XOR engine present? */
-    u8      prom_type;                      /* ROM type (eprom/flash) */
-    u8      prom_count;                     /* number of ROM devices */
-    u32     dup_pres;                       /* duplexing module present? */
-    u32     chan_pres;                      /* number of expansion chn. */
-    u32     mem_pres;                       /* memory expansion inst. ? */
-    u8      ft_bus_system;                  /* fault bus supported? */
-    u8      subtype_valid;                  /* board_subtype valid? */
-    u8      board_subtype;                  /* subtype/hardware level */
-    u8      ramparity_pres;                 /* RAM parity check hardware? */
-} __attribute__((packed)) gdth_binfo_str; 
+	u32	ser_no;			/* serial no. */
+	u8	oem_id[2];		/* OEM ID */
+	u16	ep_flags;		/* eprom flags */
+	u32	proc_id;		/* processor ID */
+	u32	memsize;		/* memory size (bytes) */
+	u8	mem_banks;		/* memory banks */
+	u8	chan_type;		/* channel type */
+	u8	chan_count;		/* channel count */
+	u8	rdongle_pres;		/* dongle present? */
+	u32	epr_fw_ver;		/* (eprom) firmware version */
+	u32	upd_fw_ver;		/* (update) firmware version */
+	u32	upd_revision;		/* update revision */
+	char	type_string[16];	/* controller name */
+	char	raid_string[16];	/* RAID firmware name */
+	u8	update_pres;		/* update present? */
+	u8	xor_pres;		/* XOR engine present? */
+	u8	prom_type;		/* ROM type (eprom/flash) */
+	u8	prom_count;		/* number of ROM devices */
+	u32	dup_pres;		/* duplexing module present? */
+	u32	chan_pres;		/* number of expansion chn. */
+	u32	mem_pres;		/* memory expansion inst. ? */
+	u8	ft_bus_system;		/* fault bus supported? */
+	u8	subtype_valid;		/* board_subtype valid? */
+	u8	board_subtype;		/* subtype/hardware level */
+	u8	ramparity_pres;		/* RAM parity check hardware? */
+} __attribute__((packed)) gdth_binfo_str;
 
 /* get host drive info */
 typedef struct {
-    char        name[8];                        /* host drive name */
-    u32     size;                           /* size (sectors) */
-    u8      host_drive;                     /* host drive number */
-    u8      log_drive;                      /* log. drive (master) */
-    u8      reserved;
-    u8      rw_attribs;                     /* r/w attribs */
-    u32     start_sec;                      /* start sector */
+	char	name[8];		/* host drive name */
+	u32	size;			/* size (sectors) */
+	u8	host_drive;		/* host drive number */
+	u8	log_drive;		/* log. drive (master) */
+	u8	reserved;
+	u8	rw_attribs;		/* r/w attribs */
+	u32	start_sec;		/* start sector */
 } __attribute__((packed)) gdth_hentry_str;
 
 typedef struct {
-    u32     entries;                        /* entry count */
-    u32     offset;                         /* offset of entries */
-    u8      secs_p_head;                    /* sectors/head */
-    u8      heads_p_cyl;                    /* heads/cylinder */
-    u8      reserved;
-    u8      clust_drvtype;                  /* cluster drive type */
-    u32     location;                       /* controller number */
-    gdth_hentry_str entry[MAX_HDRIVES];         /* entries */
-} __attribute__((packed)) gdth_hget_str;    
+	u32	entries;		/* entry count */
+	u32	offset;			/* offset of entries */
+	u8	secs_p_head;		/* sectors/head */
+	u8	heads_p_cyl;		/* heads/cylinder */
+	u8	reserved;
+	u8	clust_drvtype;		/* cluster drive type */
+	u32	location;		/* controller number */
+	gdth_hentry_str entry[MAX_HDRIVES];	 /* entries */
+} __attribute__((packed)) gdth_hget_str;
 
 
 /* DPRAM structures */
 
 /* interface area ISA/PCI */
 typedef struct {
-    u8              S_Cmd_Indx;             /* special command */
-    u8 volatile     S_Status;               /* status special command */
-    u16              reserved1;
-    u32             S_Info[4];              /* add. info special command */
-    u8 volatile     Sema0;                  /* command semaphore */
-    u8              reserved2[3];
-    u8              Cmd_Index;              /* command number */
-    u8              reserved3[3];
-    u16 volatile     Status;                 /* command status */
-    u16              Service;                /* service(for async.events) */
-    u32             Info[2];                /* additional info */
-    struct {
-        u16          offset;                 /* command offs. in the DPRAM*/
-        u16          serv_id;                /* service */
-    } __attribute__((packed)) comm_queue[MAXOFFSETS];            /* command queue */
-    u32             bios_reserved[2];
-    u8              gdt_dpr_cmd[1];         /* commands */
+	u8		S_Cmd_Indx;	/* special command */
+	u8 volatile	S_Status;	/* status special command */
+	u16		reserved1;
+	u32		S_Info[4];	/* add. info special command */
+	u8 volatile	Sema0;		/* command semaphore */
+	u8		reserved2[3];
+	u8		Cmd_Index;	/* command number */
+	u8		reserved3[3];
+	u16 volatile	Status;		/* command status */
+	u16		Service;	/* service(for async.events) */
+	u32		Info[2];	/* additional info */
+	struct {
+		u16	  offset;	/* command offs. in the DPRAM*/
+		u16	  serv_id;	/* service */
+	} __attribute__((packed)) comm_queue[MAXOFFSETS]; /* command queue */
+	u32		bios_reserved[2];
+	u8		gdt_dpr_cmd[1];	 /* commands */
 } __attribute__((packed)) gdt_dpr_if;
 
 /* SRAM structure PCI controllers */
 typedef struct {
-    u32     magic;                          /* controller ID from BIOS */
-    u16      need_deinit;                    /* switch betw. BIOS/driver */
-    u8      switch_support;                 /* see need_deinit */
-    u8      padding[9];
-    u8      os_used[16];                    /* OS code per service */
-    u8      unused[28];
-    u8      fw_magic;                       /* contr. ID from firmware */
+	u32	magic;			/* controller ID from BIOS */
+	u16	need_deinit;		/* switch betw. BIOS/driver */
+	u8	switch_support;		/* see need_deinit */
+	u8	padding[9];
+	u8	os_used[16];		/* OS code per service */
+	u8	unused[28];
+	u8	fw_magic;		/* contr. ID from firmware */
 } __attribute__((packed)) gdt_pci_sram;
 
 /* DPRAM ISA controllers */
 typedef struct {
-    union {
-        struct {
-            u8      bios_used[0x3c00-32];   /* 15KB - 32Bytes BIOS */
-            u16      need_deinit;            /* switch betw. BIOS/driver */
-            u8      switch_support;         /* see need_deinit */
-            u8      padding[9];
-            u8      os_used[16];            /* OS code per service */
-        } __attribute__((packed)) dp_sram;
-        u8          bios_area[0x4000];      /* 16KB reserved for BIOS */
-    } bu;
-    union {
-        gdt_dpr_if      ic;                     /* interface area */
-        u8          if_area[0x3000];        /* 12KB for interface */
-    } u;
-    struct {
-        u8          memlock;                /* write protection DPRAM */
-        u8          event;                  /* release event */
-        u8          irqen;                  /* board interrupts enable */
-        u8          irqdel;                 /* acknowledge board int. */
-        u8 volatile Sema1;                  /* status semaphore */
-        u8          rq;                     /* IRQ/DRQ configuration */
-    } __attribute__((packed)) io;
+	union {
+		struct {
+			u8	bios_used[0x3c00-32];   /* 15KB - 32Bytes BIOS */
+			u16	need_deinit;		/* switch betw. BIOS/driver */
+			u8	switch_support;		/* see need_deinit */
+			u8	padding[9];
+			u8	os_used[16];		/* OS code per service */
+		} __attribute__((packed)) dp_sram;
+		u8	  bios_area[0x4000];	/* 16KB reserved for BIOS */
+	} bu;
+	union {
+		gdt_dpr_if	ic;		/* interface area */
+		u8	  if_area[0x3000];	/* 12KB for interface */
+	} u;
+	struct {
+		u8	  memlock;		/* write protection DPRAM */
+		u8	  event;		/* release event */
+		u8	  irqen;		/* board interrupts enable */
+		u8	  irqdel;		/* acknowledge board int. */
+		u8 volatile Sema1;		/* status semaphore */
+		u8	  rq;			/* IRQ/DRQ configuration */
+	} __attribute__((packed)) io;
 } __attribute__((packed)) gdt2_dpram_str;
 
 /* DPRAM PCI controllers */
 typedef struct {
-    union {
-        gdt_dpr_if      ic;                     /* interface area */
-        u8          if_area[0xff0-sizeof(gdt_pci_sram)];
-    } u;
-    gdt_pci_sram        gdt6sr;                 /* SRAM structure */
-    struct {
-        u8          unused0[1];
-        u8 volatile Sema1;                  /* command semaphore */
-        u8          unused1[3];
-        u8          irqen;                  /* board interrupts enable */
-        u8          unused2[2];
-        u8          event;                  /* release event */
-        u8          unused3[3];
-        u8          irqdel;                 /* acknowledge board int. */
-        u8          unused4[3];
-    } __attribute__((packed)) io;
+	union {
+		gdt_dpr_if	ic;		/* interface area */
+		u8	  if_area[0xff0-sizeof(gdt_pci_sram)];
+	} u;
+	gdt_pci_sram	gdt6sr;		 /* SRAM structure */
+	struct {
+		u8	  unused0[1];
+		u8 volatile Sema1;		/* command semaphore */
+		u8	  unused1[3];
+		u8	  irqen;		/* board interrupts enable */
+		u8	  unused2[2];
+		u8	  event;		/* release event */
+		u8	  unused3[3];
+		u8	  irqdel;		/* acknowledge board int. */
+		u8	  unused4[3];
+	} __attribute__((packed)) io;
 } __attribute__((packed)) gdt6_dpram_str;
 
 /* PLX register structure (new PCI controllers) */
 typedef struct {
-    u8              cfg_reg;        /* DPRAM cfg.(2:below 1MB,0:anywhere)*/
-    u8              unused1[0x3f];
-    u8 volatile     sema0_reg;              /* command semaphore */
-    u8 volatile     sema1_reg;              /* status semaphore */
-    u8              unused2[2];
-    u16 volatile     status;                 /* command status */
-    u16              service;                /* service */
-    u32             info[2];                /* additional info */
-    u8              unused3[0x10];
-    u8              ldoor_reg;              /* PCI to local doorbell */
-    u8              unused4[3];
-    u8 volatile     edoor_reg;              /* local to PCI doorbell */
-    u8              unused5[3];
-    u8              control0;               /* control0 register(unused) */
-    u8              control1;               /* board interrupts enable */
-    u8              unused6[0x16];
+	u8		cfg_reg;		/* DPRAM cfg.(2:below 1MB,0:anywhere)*/
+	u8		unused1[0x3f];
+	u8 volatile	sema0_reg;		/* command semaphore */
+	u8 volatile	sema1_reg;		/* status semaphore */
+	u8		unused2[2];
+	u16 volatile	status;			/* command status */
+	u16		service;		/* service */
+	u32		info[2];		/* additional info */
+	u8		unused3[0x10];
+	u8		ldoor_reg;		/* PCI to local doorbell */
+	u8		unused4[3];
+	u8 volatile	edoor_reg;		/* local to PCI doorbell */
+	u8		unused5[3];
+	u8		control0;		/* control0 register(unused) */
+	u8		control1;		/* board interrupts enable */
+	u8		unused6[0x16];
 } __attribute__((packed)) gdt6c_plx_regs;
 
 /* DPRAM new PCI controllers */
 typedef struct {
-    union {
-        gdt_dpr_if      ic;                     /* interface area */
-        u8          if_area[0x4000-sizeof(gdt_pci_sram)];
-    } u;
-    gdt_pci_sram        gdt6sr;                 /* SRAM structure */
+	union {
+		gdt_dpr_if	ic;		/* interface area */
+		u8	  if_area[0x4000-sizeof(gdt_pci_sram)];
+	} u;
+	gdt_pci_sram	gdt6sr;			/* SRAM structure */
 } __attribute__((packed)) gdt6c_dpram_str;
 
 /* i960 register structure (PCI MPR controllers) */
 typedef struct {
-    u8              unused1[16];
-    u8 volatile     sema0_reg;              /* command semaphore */
-    u8              unused2;
-    u8 volatile     sema1_reg;              /* status semaphore */
-    u8              unused3;
-    u16 volatile     status;                 /* command status */
-    u16              service;                /* service */
-    u32             info[2];                /* additional info */
-    u8              ldoor_reg;              /* PCI to local doorbell */
-    u8              unused4[11];
-    u8 volatile     edoor_reg;              /* local to PCI doorbell */
-    u8              unused5[7];
-    u8              edoor_en_reg;           /* board interrupts enable */
-    u8              unused6[27];
-    u32             unused7[939];         
-    u32             severity;       
-    char                evt_str[256];           /* event string */
+	u8		unused1[16];
+	u8 volatile	sema0_reg;		/* command semaphore */
+	u8		unused2;
+	u8 volatile	sema1_reg;		/* status semaphore */
+	u8		unused3;
+	u16 volatile	status;			/* command status */
+	u16		service;		/* service */
+	u32		info[2];		/* additional info */
+	u8		ldoor_reg;		/* PCI to local doorbell */
+	u8		unused4[11];
+	u8 volatile	edoor_reg;		/* local to PCI doorbell */
+	u8		unused5[7];
+	u8		edoor_en_reg;		/* board interrupts enable */
+	u8		unused6[27];
+	u32		unused7[939];
+	u32		severity;
+	char		evt_str[256];		/* event string */
 } __attribute__((packed)) gdt6m_i960_regs;
 
 /* DPRAM PCI MPR controllers */
 typedef struct {
-    gdt6m_i960_regs     i960r;                  /* 4KB i960 registers */
-    union {
-        gdt_dpr_if      ic;                     /* interface area */
-        u8          if_area[0x3000-sizeof(gdt_pci_sram)];
-    } u;
-    gdt_pci_sram        gdt6sr;                 /* SRAM structure */
+	gdt6m_i960_regs	i960r;			/* 4KB i960 registers */
+	union {
+		gdt_dpr_if	ic;		/* interface area */
+		u8	  if_area[0x3000-sizeof(gdt_pci_sram)];
+	} u;
+	gdt_pci_sram	gdt6sr;			/* SRAM structure */
 } __attribute__((packed)) gdt6m_dpram_str;
 
 
 /* PCI resources */
 typedef struct {
-    struct pci_dev      *pdev;
-    unsigned long               dpmem;                  /* DPRAM address */
-    unsigned long               io;                     /* IO address */
+	struct pci_dev	*pdev;
+	unsigned long		dpmem;		/* DPRAM address */
+	unsigned long		io;		/* IO address */
 } gdth_pci_str;
 
 
 /* controller information structure */
 typedef struct {
-    struct Scsi_Host    *shost;
-    struct list_head    list;
-    u16      	hanum;
-    u16              oem_id;                 /* OEM */
-    u16              type;                   /* controller class */
-    u32             stype;                  /* subtype (PCI: device ID) */
-    u16              fw_vers;                /* firmware version */
-    u16              cache_feat;             /* feat. cache serv. (s/g,..)*/
-    u16              raw_feat;               /* feat. raw service (s/g,..)*/
-    u16              screen_feat;            /* feat. raw service (s/g,..)*/
-    void __iomem        *brd;                   /* DPRAM address */
-    u32             brd_phys;               /* slot number/BIOS address */
-    gdt6c_plx_regs      *plx;                   /* PLX regs (new PCI contr.) */
-    gdth_cmd_str        cmdext;
-    gdth_cmd_str        *pccb;                  /* address command structure */
-    u32             ccb_phys;               /* phys. address */
+	struct Scsi_Host	*shost;
+	struct list_head	list;
+	u16		hanum;
+	u16		oem_id;			/* OEM */
+	u16		type;			/* controller class */
+	u32		stype;			/* subtype (PCI: device ID) */
+	u16		fw_vers;		/* firmware version */
+	u16		cache_feat;		/* feat. cache serv. (s/g,..)*/
+	u16		raw_feat;		/* feat. raw service (s/g,..)*/
+	u16		screen_feat;		/* feat. raw service (s/g,..)*/
+	void __iomem	*brd;			/* DPRAM address */
+	u32		brd_phys;		/* slot number/BIOS address */
+	gdt6c_plx_regs	*plx;			/* PLX regs (new PCI contr.) */
+	gdth_cmd_str	cmdext;
+	gdth_cmd_str	*pccb;			/* address command structure */
+	u32		ccb_phys;		/* phys. address */
 #ifdef INT_COAL
-    gdth_coal_status    *coal_stat;             /* buffer for coalescing int.*/
-    u64             coal_stat_phys;         /* phys. address */
+	gdth_coal_status	*coal_stat;	/* buffer for coalescing int.*/
+	u64		coal_stat_phys;		/* phys. address */
 #endif
-    char                *pscratch;              /* scratch (DMA) buffer */
-    u64             scratch_phys;           /* phys. address */
-    u8              scratch_busy;           /* in use? */
-    u8              dma64_support;          /* 64-bit DMA supported? */
-    gdth_msg_str        *pmsg;                  /* message buffer */
-    u64             msg_phys;               /* phys. address */
-    u8              scan_mode;              /* current scan mode */
-    u8              irq;                    /* IRQ */
-    u8              drq;                    /* DRQ (ISA controllers) */
-    u16              status;                 /* command status */
-    u16              service;                /* service/firmware ver./.. */
-    u32             info;
-    u32             info2;                  /* additional info */
-    struct scsi_cmnd           *req_first;             /* top of request queue */
-    struct {
-        u8          present;                /* Flag: host drive present? */
-        u8          is_logdrv;              /* Flag: log. drive (master)? */
-        u8          is_arraydrv;            /* Flag: array drive? */
-        u8          is_master;              /* Flag: array drive master? */
-        u8          is_parity;              /* Flag: parity drive? */
-        u8          is_hotfix;              /* Flag: hotfix drive? */
-        u8          master_no;              /* number of master drive */
-        u8          lock;                   /* drive locked? (hot plug) */
-        u8          heads;                  /* mapping */
-        u8          secs;
-        u16          devtype;                /* further information */
-        u64         size;                   /* capacity */
-        u8          ldr_no;                 /* log. drive no. */
-        u8          rw_attribs;             /* r/w attributes */
-        u8          cluster_type;           /* cluster properties */
-        u8          media_changed;          /* Flag:MOUNT/UNMOUNT occurred */
-        u32         start_sec;              /* start sector */
-    } hdr[MAX_LDRIVES];                         /* host drives */
-    struct {
-        u8          lock;                   /* channel locked? (hot plug) */
-        u8          pdev_cnt;               /* physical device count */
-        u8          local_no;               /* local channel number */
-        u8          io_cnt[MAXID];          /* current IO count */
-        u32         address;                /* channel address */
-        u32         id_list[MAXID];         /* IDs of the phys. devices */
-    } raw[MAXBUS];                              /* SCSI channels */
-    struct {
-        struct scsi_cmnd       *cmnd;                  /* pending request */
-        u16          service;                /* service */
-    } cmd_tab[GDTH_MAXCMDS];                    /* table of pend. requests */
-    struct gdth_cmndinfo {                      /* per-command private info */
-        int index;
-        int internal_command;                   /* don't call scsi_done */
-        gdth_cmd_str *internal_cmd_str;         /* crier for internal messages*/
-        dma_addr_t sense_paddr;                 /* sense dma-addr */
-        u8 priority;
-	int timeout_count;			/* # of timeout calls */
-        volatile int wait_for_completion;
-        u16 status;
-        u32 info;
-        enum dma_data_direction dma_dir;
-        int phase;                              /* ???? */
-        int OpCode;
-    } cmndinfo[GDTH_MAXCMDS];                   /* index==0 is free */
-    u8              bus_cnt;                /* SCSI bus count */
-    u8              tid_cnt;                /* Target ID count */
-    u8              bus_id[MAXBUS];         /* IOP IDs */
-    u8              virt_bus;               /* number of virtual bus */
-    u8              more_proc;              /* more /proc info supported */
-    u16              cmd_cnt;                /* command count in DPRAM */
-    u16              cmd_len;                /* length of actual command */
-    u16              cmd_offs_dpmem;         /* actual offset in DPRAM */
-    u16              ic_all_size;            /* sizeof DPRAM interf. area */
-    gdth_cpar_str       cpar;                   /* controller cache par. */
-    gdth_bfeat_str      bfeat;                  /* controller features */
-    gdth_binfo_str      binfo;                  /* controller info */
-    gdth_evt_data       dvr;                    /* event structure */
-    spinlock_t          smp_lock;
-    struct pci_dev      *pdev;
-    char                oem_name[8];
+	char		*pscratch;		/* scratch (DMA) buffer */
+	u64		scratch_phys;		/* phys. address */
+	u8		scratch_busy;		/* in use? */
+	u8		dma64_support;		/* 64-bit DMA supported? */
+	gdth_msg_str	*pmsg;			/* message buffer */
+	u64		msg_phys;		/* phys. address */
+	u8		scan_mode;		/* current scan mode */
+	u8		irq;			/* IRQ */
+	u8		drq;			/* DRQ (ISA controllers) */
+	u16		status;			/* command status */
+	u16		service;		/* service/firmware ver./.. */
+	u32		info;
+	u32		info2;			/* additional info */
+	struct scsi_cmnd	   *req_first;	/* top of request queue */
+	struct {
+		u8	present;		/* Flag: host drive present? */
+		u8	is_logdrv;		/* Flag: log. drive (master)? */
+		u8	is_arraydrv;		/* Flag: array drive? */
+		u8	is_master;		/* Flag: array drive master? */
+		u8	is_parity;		/* Flag: parity drive? */
+		u8	is_hotfix;		/* Flag: hotfix drive? */
+		u8	master_no;		/* number of master drive */
+		u8	lock;			/* drive locked? (hot plug) */
+		u8	heads;			/* mapping */
+		u8	secs;
+		u16	devtype;		/* further information */
+		u64	size;			/* capacity */
+		u8	ldr_no;			/* log. drive no. */
+		u8	rw_attribs;		/* r/w attributes */
+		u8	cluster_type;		/* cluster properties */
+		u8	media_changed;		/* Flag:MOUNT/UNMOUNT occurred */
+		u32	start_sec;		/* start sector */
+	} hdr[MAX_LDRIVES];			/* host drives */
+	struct {
+		u8	lock;			/* channel locked? (hot plug) */
+		u8	pdev_cnt;		/* physical device count */
+		u8	local_no;		/* local channel number */
+		u8	io_cnt[MAXID];		/* current IO count */
+		u32	address;		/* channel address */
+		u32	id_list[MAXID];		/* IDs of the phys. devices */
+	} raw[MAXBUS];				/* SCSI channels */
+	struct {
+		struct scsi_cmnd *cmnd;		/* pending request */
+		u16	  service;		/* service */
+	} cmd_tab[GDTH_MAXCMDS];		/* table of pend. requests */
+	struct gdth_cmndinfo {			/* per-command private info */
+		int index;
+		int internal_command;		/* don't call scsi_done */
+		gdth_cmd_str *internal_cmd_str;	/* crier for internal messages*/
+		dma_addr_t sense_paddr;		/* sense dma-addr */
+		u8 priority;
+		int timeout_count;		/* # of timeout calls */
+		volatile int wait_for_completion;
+		u16 status;
+		u32 info;
+		enum dma_data_direction dma_dir;
+		int phase;			/* ???? */
+		int OpCode;
+	} cmndinfo[GDTH_MAXCMDS];		/* index==0 is free */
+	u8		bus_cnt;		/* SCSI bus count */
+	u8		tid_cnt;		/* Target ID count */
+	u8		bus_id[MAXBUS];		/* IOP IDs */
+	u8		virt_bus;		/* number of virtual bus */
+	u8		more_proc;		/* more /proc info supported */
+	u16		cmd_cnt;		/* command count in DPRAM */
+	u16		cmd_len;		/* length of actual command */
+	u16		cmd_offs_dpmem;		/* actual offset in DPRAM */
+	u16		ic_all_size;		/* sizeof DPRAM interf. area */
+	gdth_cpar_str	cpar;			/* controller cache par. */
+	gdth_bfeat_str	bfeat;			/* controller features */
+	gdth_binfo_str	binfo;			/* controller info */
+	gdth_evt_data	dvr;			/* event structure */
+	spinlock_t	smp_lock;
+	struct pci_dev	*pdev;
+	char		oem_name[8];
 #ifdef GDTH_DMA_STATISTICS
-    unsigned long               dma32_cnt, dma64_cnt;   /* statistics: DMA buffer */
+	unsigned long	dma32_cnt, dma64_cnt;	/* statistics: DMA buffer */
 #endif
-    struct scsi_device         *sdev;
+	struct scsi_device *sdev;
 } gdth_ha_str;
 
 static inline struct gdth_cmndinfo *gdth_cmnd_priv(struct scsi_cmnd* cmd)
@@ -912,64 +912,64 @@ static inline struct gdth_cmndinfo *gdth_cmnd_priv(struct scsi_cmnd* cmd)
 
 /* INQUIRY data format */
 typedef struct {
-    u8      type_qual;
-    u8      modif_rmb;
-    u8      version;
-    u8      resp_aenc;
-    u8      add_length;
-    u8      reserved1;
-    u8      reserved2;
-    u8      misc;
-    u8      vendor[8];
-    u8      product[16];
-    u8      revision[4];
+	u8	type_qual;
+	u8	modif_rmb;
+	u8	version;
+	u8	resp_aenc;
+	u8	add_length;
+	u8	reserved1;
+	u8	reserved2;
+	u8	misc;
+	u8	vendor[8];
+	u8	product[16];
+	u8	revision[4];
 } __attribute__((packed)) gdth_inq_data;
 
 /* READ_CAPACITY data format */
 typedef struct {
-    u32     last_block_no;
-    u32     block_length;
+	u32	last_block_no;
+	u32	block_length;
 } __attribute__((packed)) gdth_rdcap_data;
 
 /* READ_CAPACITY (16) data format */
 typedef struct {
-    u64     last_block_no;
-    u32     block_length;
+	u64	last_block_no;
+	u32	block_length;
 } __attribute__((packed)) gdth_rdcap16_data;
 
 /* REQUEST_SENSE data format */
 typedef struct {
-    u8      errorcode;
-    u8      segno;
-    u8      key;
-    u32     info;
-    u8      add_length;
-    u32     cmd_info;
-    u8      adsc;
-    u8      adsq;
-    u8      fruc;
-    u8      key_spec[3];
+	u8	errorcode;
+	u8	segno;
+	u8	key;
+	u32	info;
+	u8	add_length;
+	u32	cmd_info;
+	u8	adsc;
+	u8	adsq;
+	u8	fruc;
+	u8	key_spec[3];
 } __attribute__((packed)) gdth_sense_data;
 
 /* MODE_SENSE data format */
 typedef struct {
-    struct {
-        u8  data_length;
-        u8  med_type;
-        u8  dev_par;
-        u8  bd_length;
-    } __attribute__((packed)) hd;
-    struct {
-        u8  dens_code;
-        u8  block_count[3];
-        u8  reserved;
-        u8  block_length[3];
-    } __attribute__((packed)) bd;
+	struct {
+		u8  data_length;
+		u8  med_type;
+		u8  dev_par;
+		u8  bd_length;
+	} __attribute__((packed)) hd;
+	struct {
+		u8  dens_code;
+		u8  block_count[3];
+		u8  reserved;
+		u8  block_length[3];
+	} __attribute__((packed)) bd;
 } __attribute__((packed)) gdth_modep_data;
 
 /* stack frame */
 typedef struct {
-    unsigned long       b[10];                          /* 32/64 bit compiler ! */
+	unsigned long	b[10];			/* 32/64 bit compiler ! */
 } __attribute__((packed)) gdth_stackframe;
 
 
diff --git a/drivers/scsi/gdth_ioctl.h b/drivers/scsi/gdth_ioctl.h
index ee4c9bf1022a..2b64b6c1cb8a 100644
--- a/drivers/scsi/gdth_ioctl.h
+++ b/drivers/scsi/gdth_ioctl.h
@@ -7,245 +7,245 @@
  */
 
 /* IOCTLs */
-#define GDTIOCTL_MASK       ('J'<<8)
-#define GDTIOCTL_GENERAL    (GDTIOCTL_MASK | 0) /* general IOCTL */
-#define GDTIOCTL_DRVERS     (GDTIOCTL_MASK | 1) /* get driver version */
-#define GDTIOCTL_CTRTYPE    (GDTIOCTL_MASK | 2) /* get controller type */
-#define GDTIOCTL_OSVERS     (GDTIOCTL_MASK | 3) /* get OS version */
-#define GDTIOCTL_HDRLIST    (GDTIOCTL_MASK | 4) /* get host drive list */
-#define GDTIOCTL_CTRCNT     (GDTIOCTL_MASK | 5) /* get controller count */
-#define GDTIOCTL_LOCKDRV    (GDTIOCTL_MASK | 6) /* lock host drive */
-#define GDTIOCTL_LOCKCHN    (GDTIOCTL_MASK | 7) /* lock channel */
-#define GDTIOCTL_EVENT      (GDTIOCTL_MASK | 8) /* read controller events */
-#define GDTIOCTL_SCSI       (GDTIOCTL_MASK | 9) /* SCSI command */
-#define GDTIOCTL_RESET_BUS  (GDTIOCTL_MASK |10) /* reset SCSI bus */
-#define GDTIOCTL_RESCAN     (GDTIOCTL_MASK |11) /* rescan host drives */
-#define GDTIOCTL_RESET_DRV  (GDTIOCTL_MASK |12) /* reset (remote) drv. res. */
-
-#define GDTIOCTL_MAGIC  0xaffe0004
-#define EVENT_SIZE      294 
-#define GDTH_MAXSG      32                      /* max. s/g elements */
-
-#define MAX_LDRIVES     255                     /* max. log. drive count */
-#define MAX_HDRIVES     MAX_LDRIVES             /* max. host drive count */
+#define GDTIOCTL_MASK		('J'<<8)
+#define GDTIOCTL_GENERAL	(GDTIOCTL_MASK | 0) /* general IOCTL */
+#define GDTIOCTL_DRVERS		(GDTIOCTL_MASK | 1) /* get driver version */
+#define GDTIOCTL_CTRTYPE	(GDTIOCTL_MASK | 2) /* get controller type */
+#define GDTIOCTL_OSVERS		(GDTIOCTL_MASK | 3) /* get OS version */
+#define GDTIOCTL_HDRLIST	(GDTIOCTL_MASK | 4) /* get host drive list */
+#define GDTIOCTL_CTRCNT		(GDTIOCTL_MASK | 5) /* get controller count */
+#define GDTIOCTL_LOCKDRV	(GDTIOCTL_MASK | 6) /* lock host drive */
+#define GDTIOCTL_LOCKCHN	(GDTIOCTL_MASK | 7) /* lock channel */
+#define GDTIOCTL_EVENT		(GDTIOCTL_MASK | 8) /* read controller events */
+#define GDTIOCTL_SCSI		(GDTIOCTL_MASK | 9) /* SCSI command */
+#define GDTIOCTL_RESET_BUS	(GDTIOCTL_MASK |10) /* reset SCSI bus */
+#define GDTIOCTL_RESCAN		(GDTIOCTL_MASK |11) /* rescan host drives */
+#define GDTIOCTL_RESET_DRV	(GDTIOCTL_MASK |12) /* reset (remote) drv. res. */
+
+#define GDTIOCTL_MAGIC	0xaffe0004
+#define EVENT_SIZE	294
+#define GDTH_MAXSG	32			/* max. s/g elements */
+
+#define MAX_LDRIVES	255			/* max. log. drive count */
+#define MAX_HDRIVES	MAX_LDRIVES		/* max. host drive count */
 
 /* scatter/gather element */
 typedef struct {
-    u32     sg_ptr;                         /* address */
-    u32     sg_len;                         /* length */
+	u32	sg_ptr;			/* address */
+	u32	sg_len;			/* length */
 } __attribute__((packed)) gdth_sg_str;
 
 /* scatter/gather element - 64bit addresses */
 typedef struct {
-    u64     sg_ptr;                         /* address */
-    u32     sg_len;                         /* length */
+	u64	sg_ptr;			/* address */
+	u32	sg_len;			/* length */
 } __attribute__((packed)) gdth_sg64_str;
 
 /* command structure */
 typedef struct {
-    u32     BoardNode;                      /* board node (always 0) */
-    u32     CommandIndex;                   /* command number */
-    u16      OpCode;                         /* the command (READ,..) */
-    union {
-        struct {
-            u16      DeviceNo;               /* number of cache drive */
-            u32     BlockNo;                /* block number */
-            u32     BlockCnt;               /* block count */
-            u32     DestAddr;               /* dest. addr. (if s/g: -1) */
-            u32     sg_canz;                /* s/g element count */
-            gdth_sg_str sg_lst[GDTH_MAXSG];     /* s/g list */
-        } __attribute__((packed)) cache;                         /* cache service cmd. str. */
-        struct {
-            u16      DeviceNo;               /* number of cache drive */
-            u64     BlockNo;                /* block number */
-            u32     BlockCnt;               /* block count */
-            u64     DestAddr;               /* dest. addr. (if s/g: -1) */
-            u32     sg_canz;                /* s/g element count */
-            gdth_sg64_str sg_lst[GDTH_MAXSG];   /* s/g list */
-        } __attribute__((packed)) cache64;                       /* cache service cmd. str. */
-        struct {
-            u16      param_size;             /* size of p_param buffer */
-            u32     subfunc;                /* IOCTL function */
-            u32     channel;                /* device */
-            u64     p_param;                /* buffer */
-        } __attribute__((packed)) ioctl;                         /* IOCTL command structure */
-        struct {
-            u16      reserved;
-            union {
-                struct {
-                    u32  msg_handle;        /* message handle */
-                    u64  msg_addr;          /* message buffer address */
-                } __attribute__((packed)) msg;
-                u8       data[12];          /* buffer for rtc data, ... */
-            } su;
-        } __attribute__((packed)) screen;                        /* screen service cmd. str. */
-        struct {
-            u16      reserved;
-            u32     direction;              /* data direction */
-            u32     mdisc_time;             /* disc. time (0: no timeout)*/
-            u32     mcon_time;              /* connect time(0: no to.) */
-            u32     sdata;                  /* dest. addr. (if s/g: -1) */
-            u32     sdlen;                  /* data length (bytes) */
-            u32     clen;                   /* SCSI cmd. length(6,10,12) */
-            u8      cmd[12];                /* SCSI command */
-            u8      target;                 /* target ID */
-            u8      lun;                    /* LUN */
-            u8      bus;                    /* SCSI bus number */
-            u8      priority;               /* only 0 used */
-            u32     sense_len;              /* sense data length */
-            u32     sense_data;             /* sense data addr. */
-            u32     link_p;                 /* linked cmds (not supp.) */
-            u32     sg_ranz;                /* s/g element count */
-            gdth_sg_str sg_lst[GDTH_MAXSG];     /* s/g list */
-        } __attribute__((packed)) raw;                           /* raw service cmd. struct. */
-        struct {
-            u16      reserved;
-            u32     direction;              /* data direction */
-            u32     mdisc_time;             /* disc. time (0: no timeout)*/
-            u32     mcon_time;              /* connect time(0: no to.) */
-            u64     sdata;                  /* dest. addr. (if s/g: -1) */
-            u32     sdlen;                  /* data length (bytes) */
-            u32     clen;                   /* SCSI cmd. length(6,..,16) */
-            u8      cmd[16];                /* SCSI command */
-            u8      target;                 /* target ID */
-            u8      lun;                    /* LUN */
-            u8      bus;                    /* SCSI bus number */
-            u8      priority;               /* only 0 used */
-            u32     sense_len;              /* sense data length */
-            u64     sense_data;             /* sense data addr. */
-            u32     sg_ranz;                /* s/g element count */
-            gdth_sg64_str sg_lst[GDTH_MAXSG];   /* s/g list */
-        } __attribute__((packed)) raw64;                         /* raw service cmd. struct. */
-    } u;
-    /* additional variables */
-    u8      Service;                        /* controller service */
-    u8      reserved;
-    u16      Status;                         /* command result */
-    u32     Info;                           /* additional information */
-    void        *RequestBuffer;                 /* request buffer */
+	u32	BoardNode;		/* board node (always 0) */
+	u32	CommandIndex;		/* command number */
+	u16	OpCode;			/* the command (READ,..) */
+	union {
+		struct {
+			u16	DeviceNo;	/* number of cache drive */
+			u32	BlockNo;	/* block number */
+			u32	BlockCnt;	/* block count */
+			u32	DestAddr;	/* dest. addr. (if s/g: -1) */
+			u32	sg_canz;	/* s/g element count */
+			gdth_sg_str sg_lst[GDTH_MAXSG];	/* s/g list */
+		} __attribute__((packed)) cache; /* cache service cmd. str. */
+		struct {
+			u16	DeviceNo;	/* number of cache drive */
+			u64	BlockNo;	/* block number */
+			u32	BlockCnt;	/* block count */
+			u64	DestAddr;	/* dest. addr. (if s/g: -1) */
+			u32	sg_canz;	/* s/g element count */
+			gdth_sg64_str sg_lst[GDTH_MAXSG]; /* s/g list */
+		} __attribute__((packed)) cache64; /* cache service cmd. str. */
+		struct {
+			u16	param_size;	/* size of p_param buffer */
+			u32	subfunc;	/* IOCTL function */
+			u32	channel;	/* device */
+			u64	p_param;	/* buffer */
+		} __attribute__((packed)) ioctl; /* IOCTL command structure */
+		struct {
+			u16	reserved;
+			union {
+				struct {
+					u32  msg_handle;	/* message handle */
+					u64  msg_addr;		/* message buffer address */
+				} __attribute__((packed)) msg;
+				u8	data[12];	  /* buffer for rtc data, ... */
+			} su;
+		} __attribute__((packed)) screen; /* screen service cmd. str. */
+		struct {
+			u16	reserved;
+			u32	direction;	/* data direction */
+			u32	mdisc_time;	/* disc. time (0: no timeout)*/
+			u32	mcon_time;	/* connect time(0: no to.) */
+			u32	sdata;		/* dest. addr. (if s/g: -1) */
+			u32	sdlen;		/* data length (bytes) */
+			u32	clen;		/* SCSI cmd. length(6,10,12) */
+			u8	cmd[12];	/* SCSI command */
+			u8	target;		/* target ID */
+			u8	lun;		/* LUN */
+			u8	bus;		/* SCSI bus number */
+			u8	priority;	/* only 0 used */
+			u32	sense_len;	/* sense data length */
+			u32	sense_data;	/* sense data addr. */
+			u32	link_p;		/* linked cmds (not supp.) */
+			u32	sg_ranz;	/* s/g element count */
+			gdth_sg_str sg_lst[GDTH_MAXSG];	/* s/g list */
+		} __attribute__((packed)) raw; /* raw service cmd. struct. */
+		struct {
+			u16	reserved;
+			u32	direction;	/* data direction */
+			u32	mdisc_time;	/* disc. time (0: no timeout)*/
+			u32	mcon_time;	/* connect time(0: no to.) */
+			u64	sdata;		/* dest. addr. (if s/g: -1) */
+			u32	sdlen;		/* data length (bytes) */
+			u32	clen;		/* SCSI cmd. length(6,..,16) */
+			u8	cmd[16];	/* SCSI command */
+			u8	target;		/* target ID */
+			u8	lun;		/* LUN */
+			u8	bus;		/* SCSI bus number */
+			u8	priority;	/* only 0 used */
+			u32	sense_len;	/* sense data length */
+			u64	sense_data;	/* sense data addr. */
+			u32	sg_ranz;	/* s/g element count */
+			gdth_sg64_str sg_lst[GDTH_MAXSG]; /* s/g list */
+		} __attribute__((packed)) raw64; /* raw service cmd. struct. */
+	} u;
+	/* additional variables */
+	u8	Service;		/* controller service */
+	u8	reserved;
+	u16	Status;			/* command result */
+	u32	Info;			/* additional information */
+	void	*RequestBuffer;		/* request buffer */
 } __attribute__((packed)) gdth_cmd_str;
 
 /* controller event structure */
-#define ES_ASYNC    1
-#define ES_DRIVER   2
-#define ES_TEST     3
-#define ES_SYNC     4
+#define ES_ASYNC	1
+#define ES_DRIVER	2
+#define ES_TEST		3
+#define ES_SYNC		4
 typedef struct {
-    u16                  size;               /* size of structure */
-    union {
-        char                stream[16];
-        struct {
-            u16          ionode;
-            u16          service;
-            u32         index;
-        } __attribute__((packed)) driver;
-        struct {
-            u16          ionode;
-            u16          service;
-            u16          status;
-            u32         info;
-            u8          scsi_coord[3];
-        } __attribute__((packed)) async;
-        struct {
-            u16          ionode;
-            u16          service;
-            u16          status;
-            u32         info;
-            u16          hostdrive;
-            u8          scsi_coord[3];
-            u8          sense_key;
-        } __attribute__((packed)) sync;
-        struct {
-            u32         l1, l2, l3, l4;
-        } __attribute__((packed)) test;
-    } eu;
-    u32                 severity;
-    u8                  event_string[256];          
+	u16	size;		/* size of structure */
+	union {
+		char		stream[16];
+		struct {
+			u16	ionode;
+			u16	service;
+			u32	index;
+		} __attribute__((packed)) driver;
+		struct {
+			u16	ionode;
+			u16	service;
+			u16	status;
+			u32	info;
+			u8	scsi_coord[3];
+		} __attribute__((packed)) async;
+		struct {
+			u16	ionode;
+			u16	service;
+			u16	status;
+			u32	info;
+			u16	hostdrive;
+			u8	scsi_coord[3];
+			u8	sense_key;
+		} __attribute__((packed)) sync;
+		struct {
+			u32	l1, l2, l3, l4;
+		} __attribute__((packed)) test;
+	} eu;
+	u32		severity;
+	u8		event_string[256];
 } __attribute__((packed)) gdth_evt_data;
 
 typedef struct {
-    u32         first_stamp;
-    u32         last_stamp;
-    u16          same_count;
-    u16          event_source;
-    u16          event_idx;
-    u8          application;
-    u8          reserved;
-    gdth_evt_data   event_data;
+	u32	first_stamp;
+	u32	last_stamp;
+	u16	same_count;
+	u16	event_source;
+	u16	event_idx;
+	u8	application;
+	u8	reserved;
+	gdth_evt_data event_data;
 } __attribute__((packed)) gdth_evt_str;
 
 /* GDTIOCTL_GENERAL */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u16 timeout;                             /* timeout */
-    u32 info;                               /* error info */ 
-    u16 status;                              /* status */
-    unsigned long data_len;                             /* data buffer size */
-    unsigned long sense_len;                            /* sense buffer size */
-    gdth_cmd_str command;                       /* command */                   
+	u16 ionode;				/* controller number */
+	u16 timeout;				/* timeout */
+	u32 info;				/* error info */
+	u16 status;				/* status */
+	unsigned long data_len;			/* data buffer size */
+	unsigned long sense_len;		/* sense buffer size */
+	gdth_cmd_str command;			/* command */
 } gdth_ioctl_general;
 
 /* GDTIOCTL_LOCKDRV */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u8 lock;                                /* lock/unlock */
-    u8 drive_cnt;                           /* drive count */
-    u16 drives[MAX_HDRIVES];                 /* drives */
+	u16 ionode;				/* controller number */
+	u8 lock;				/* lock/unlock */
+	u8 drive_cnt;				/* drive count */
+	u16 drives[MAX_HDRIVES];		/* drives */
 } gdth_ioctl_lockdrv;
 
 /* GDTIOCTL_LOCKCHN */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u8 lock;                                /* lock/unlock */
-    u8 channel;                             /* channel */
+	u16 ionode;				/* controller number */
+	u8 lock;				/* lock/unlock */
+	u8 channel;				/* channel */
 } gdth_ioctl_lockchn;
 
 /* GDTIOCTL_OSVERS */
 typedef struct {
-    u8 version;                             /* OS version */
-    u8 subversion;                          /* OS subversion */
-    u16 revision;                            /* revision */
+	u8 version;				/* OS version */
+	u8 subversion;				/* OS subversion */
+	u16 revision;				/* revision */
 } gdth_ioctl_osvers;
 
 /* GDTIOCTL_CTRTYPE */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u8 type;                                /* controller type */
-    u16 info;                                /* slot etc. */
-    u16 oem_id;                              /* OEM ID */
-    u16 bios_ver;                            /* not used */
-    u16 access;                              /* not used */
-    u16 ext_type;                            /* extended type */
-    u16 device_id;                           /* device ID */
-    u16 sub_device_id;                       /* sub device ID */
+	u16 ionode;				/* controller number */
+	u8 type;				/* controller type */
+	u16 info;				/* slot etc. */
+	u16 oem_id;				/* OEM ID */
+	u16 bios_ver;				/* not used */
+	u16 access;				/* not used */
+	u16 ext_type;				/* extended type */
+	u16 device_id;				/* device ID */
+	u16 sub_device_id;			/* sub device ID */
 } gdth_ioctl_ctrtype;
 
 /* GDTIOCTL_EVENT */
 typedef struct {
-    u16 ionode;
-    int erase;                                  /* erase event? */
-    int handle;                                 /* event handle */
-    gdth_evt_str event;
+	u16 ionode;
+	int erase;				/* erase event? */
+	int handle;				/* event handle */
+	gdth_evt_str event;
 } gdth_ioctl_event;
 
 /* GDTIOCTL_RESCAN/GDTIOCTL_HDRLIST */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u8 flag;                                /* add/remove */
-    u16 hdr_no;                              /* drive no. */
-    struct {
-        u8 bus;                             /* SCSI bus */
-        u8 target;                          /* target ID */
-        u8 lun;                             /* LUN */
-        u8 cluster_type;                    /* cluster properties */
-    } hdr_list[MAX_HDRIVES];                    /* index is host drive number */
+	u16 ionode;				/* controller number */
+	u8 flag;				/* add/remove */
+	u16 hdr_no;				/* drive no. */
+	struct {
+		u8 bus;				/* SCSI bus */
+		u8 target;			/* target ID */
+		u8 lun;				/* LUN */
+		u8 cluster_type;		/* cluster properties */
+	} hdr_list[MAX_HDRIVES];		/* index is host drive number */
 } gdth_ioctl_rescan;
 
 /* GDTIOCTL_RESET_BUS/GDTIOCTL_RESET_DRV */
 typedef struct {
-    u16 ionode;                              /* controller number */
-    u16 number;                              /* bus/host drive number */
-    u16 status;                              /* status */
+	u16 ionode;				/* controller number */
+	u16 number;				/* bus/host drive number */
+	u16 status;				/* status */
 } gdth_ioctl_reset;
 
 #endif
diff --git a/drivers/scsi/gdth_proc.c b/drivers/scsi/gdth_proc.c
index c764312f9ba0..1a695364fd2e 100644
--- a/drivers/scsi/gdth_proc.c
+++ b/drivers/scsi/gdth_proc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* gdth_proc.c 
+/* gdth_proc.c
  * $Id: gdth_proc.c,v 1.43 2006/01/11 16:15:00 achim Exp $
  */
 
@@ -8,579 +8,576 @@
 
 int gdth_set_info(struct Scsi_Host *host, char *buffer, int length)
 {
-    gdth_ha_str *ha = shost_priv(host);
-    int ret_val = -EINVAL;
+	gdth_ha_str *ha = shost_priv(host);
+	int ret_val = -EINVAL;
 
-    TRACE2(("gdth_set_info() ha %d\n",ha->hanum,));
+	TRACE2(("gdth_set_info() ha %d\n",ha->hanum,));
 
-    if (length >= 4) {
-        if (strncmp(buffer,"gdth",4) == 0) {
-            buffer += 5;
-            length -= 5;
-            ret_val = gdth_set_asc_info(host, buffer, length, ha);
-        }
-    }
+	if (length >= 4) {
+		if (strncmp(buffer,"gdth",4) == 0) {
+			buffer += 5;
+			length -= 5;
+			ret_val = gdth_set_asc_info(host, buffer, length, ha);
+		}
+	}
 
-    return ret_val;
+	return ret_val;
 }
-         
+
 static int gdth_set_asc_info(struct Scsi_Host *host, char *buffer,
-                        int length, gdth_ha_str *ha)
+			     int length, gdth_ha_str *ha)
 {
-    int orig_length, drive, wb_mode;
-    int i, found;
-    gdth_cmd_str    gdtcmd;
-    gdth_cpar_str   *pcpar;
-
-    char            cmnd[MAX_COMMAND_SIZE];
-    memset(cmnd, 0xff, 12);
-    memset(&gdtcmd, 0, sizeof(gdth_cmd_str));
-
-    TRACE2(("gdth_set_asc_info() ha %d\n",ha->hanum));
-    orig_length = length + 5;
-    drive = -1;
-    wb_mode = 0;
-    found = FALSE;
-
-    if (length >= 5 && strncmp(buffer,"flush",5)==0) {
-        buffer += 6;
-        length -= 6;
-        if (length && *buffer>='0' && *buffer<='9') {
-            drive = (int)(*buffer-'0');
-            ++buffer; --length;
-            if (length && *buffer>='0' && *buffer<='9') {
-                drive = drive*10 + (int)(*buffer-'0');
-                ++buffer; --length;
-            }
-            printk("GDT: Flushing host drive %d .. ",drive);
-        } else {
-            printk("GDT: Flushing all host drives .. ");
-        }
-        for (i = 0; i < MAX_HDRIVES; ++i) {
-            if (ha->hdr[i].present) {
-                if (drive != -1 && i != drive)
-                    continue;
-                found = TRUE;
-                gdtcmd.Service = CACHESERVICE;
-                gdtcmd.OpCode = GDT_FLUSH;
-                if (ha->cache_feat & GDT_64BIT) {
-                    gdtcmd.u.cache64.DeviceNo = i;
-                    gdtcmd.u.cache64.BlockNo = 1;
-                } else {
-                    gdtcmd.u.cache.DeviceNo = i;
-                    gdtcmd.u.cache.BlockNo = 1;
-                }
-
-                gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
-            }
-        }
-        if (!found)
-            printk("\nNo host drive found !\n");
-        else
-            printk("Done.\n");
-        return(orig_length);
-    }
-
-    if (length >= 7 && strncmp(buffer,"wbp_off",7)==0) {
-        buffer += 8;
-        length -= 8;
-        printk("GDT: Disabling write back permanently .. ");
-        wb_mode = 1;
-    } else if (length >= 6 && strncmp(buffer,"wbp_on",6)==0) {
-        buffer += 7;
-        length -= 7;
-        printk("GDT: Enabling write back permanently .. ");
-        wb_mode = 2;
-    } else if (length >= 6 && strncmp(buffer,"wb_off",6)==0) {
-        buffer += 7;
-        length -= 7;
-        printk("GDT: Disabling write back commands .. ");
-        if (ha->cache_feat & GDT_WR_THROUGH) {
-            gdth_write_through = TRUE;
-            printk("Done.\n");
-        } else {
-            printk("Not supported !\n");
-        }
-        return(orig_length);
-    } else if (length >= 5 && strncmp(buffer,"wb_on",5)==0) {
-        buffer += 6;
-        length -= 6;
-        printk("GDT: Enabling write back commands .. ");
-        gdth_write_through = FALSE;
-        printk("Done.\n");
-        return(orig_length);
-    }
-
-    if (wb_mode) {
-	unsigned long flags;
-
-	BUILD_BUG_ON(sizeof(gdth_cpar_str) > GDTH_SCRATCH);
-
-	spin_lock_irqsave(&ha->smp_lock, flags);
-	if (ha->scratch_busy) {
-	    spin_unlock_irqrestore(&ha->smp_lock, flags);
-            return -EBUSY;
+	int orig_length, drive, wb_mode;
+	int i, found;
+	gdth_cmd_str gdtcmd;
+	gdth_cpar_str *pcpar;
+	char cmnd[MAX_COMMAND_SIZE];
+
+	memset(cmnd, 0xff, 12);
+	memset(&gdtcmd, 0, sizeof(gdth_cmd_str));
+
+	TRACE2(("gdth_set_asc_info() ha %d\n",ha->hanum));
+	orig_length = length + 5;
+	drive = -1;
+	wb_mode = 0;
+	found = FALSE;
+
+	if (length >= 5 && strncmp(buffer,"flush",5)==0) {
+		buffer += 6;
+		length -= 6;
+		if (length && *buffer>='0' && *buffer<='9') {
+			drive = (int)(*buffer-'0');
+			++buffer; --length;
+			if (length && *buffer>='0' && *buffer<='9') {
+				drive = drive*10 + (int)(*buffer-'0');
+				++buffer; --length;
+			}
+			printk("GDT: Flushing host drive %d .. ",drive);
+		} else {
+			printk("GDT: Flushing all host drives .. ");
+		}
+		for (i = 0; i < MAX_HDRIVES; ++i) {
+			if (ha->hdr[i].present) {
+				if (drive != -1 && i != drive)
+					continue;
+				found = TRUE;
+				gdtcmd.Service = CACHESERVICE;
+				gdtcmd.OpCode = GDT_FLUSH;
+				if (ha->cache_feat & GDT_64BIT) {
+					gdtcmd.u.cache64.DeviceNo = i;
+					gdtcmd.u.cache64.BlockNo = 1;
+				} else {
+					gdtcmd.u.cache.DeviceNo = i;
+					gdtcmd.u.cache.BlockNo = 1;
+				}
+
+				gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
+			}
+		}
+		if (!found)
+			printk("\nNo host drive found !\n");
+		else
+			printk("Done.\n");
+		return(orig_length);
 	}
-	ha->scratch_busy = TRUE;
-	spin_unlock_irqrestore(&ha->smp_lock, flags);
-
-        pcpar = (gdth_cpar_str *)ha->pscratch;
-        memcpy( pcpar, &ha->cpar, sizeof(gdth_cpar_str) );
-        gdtcmd.Service = CACHESERVICE;
-        gdtcmd.OpCode = GDT_IOCTL;
-        gdtcmd.u.ioctl.p_param = ha->scratch_phys;
-        gdtcmd.u.ioctl.param_size = sizeof(gdth_cpar_str);
-        gdtcmd.u.ioctl.subfunc = CACHE_CONFIG;
-        gdtcmd.u.ioctl.channel = INVALID_CHANNEL;
-        pcpar->write_back = wb_mode==1 ? 0:1;
-
-        gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
 
-	spin_lock_irqsave(&ha->smp_lock, flags);
-	ha->scratch_busy = FALSE;
-	spin_unlock_irqrestore(&ha->smp_lock, flags);
+	if (length >= 7 && strncmp(buffer,"wbp_off",7)==0) {
+		buffer += 8;
+		length -= 8;
+		printk("GDT: Disabling write back permanently .. ");
+		wb_mode = 1;
+	} else if (length >= 6 && strncmp(buffer,"wbp_on",6)==0) {
+		buffer += 7;
+		length -= 7;
+		printk("GDT: Enabling write back permanently .. ");
+		wb_mode = 2;
+	} else if (length >= 6 && strncmp(buffer,"wb_off",6)==0) {
+		buffer += 7;
+		length -= 7;
+		printk("GDT: Disabling write back commands .. ");
+		if (ha->cache_feat & GDT_WR_THROUGH) {
+			gdth_write_through = TRUE;
+			printk("Done.\n");
+		} else {
+			printk("Not supported !\n");
+		}
+		return(orig_length);
+	} else if (length >= 5 && strncmp(buffer,"wb_on",5)==0) {
+		buffer += 6;
+		length -= 6;
+		printk("GDT: Enabling write back commands .. ");
+		gdth_write_through = FALSE;
+		printk("Done.\n");
+		return(orig_length);
+	}
 
-        printk("Done.\n");
-        return(orig_length);
-    }
+	if (wb_mode) {
+		unsigned long flags;
+
+		BUILD_BUG_ON(sizeof(gdth_cpar_str) > GDTH_SCRATCH);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		if (ha->scratch_busy) {
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+			return -EBUSY;
+		}
+		ha->scratch_busy = TRUE;
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+
+		pcpar = (gdth_cpar_str *)ha->pscratch;
+		memcpy( pcpar, &ha->cpar, sizeof(gdth_cpar_str) );
+		gdtcmd.Service = CACHESERVICE;
+		gdtcmd.OpCode = GDT_IOCTL;
+		gdtcmd.u.ioctl.p_param = ha->scratch_phys;
+		gdtcmd.u.ioctl.param_size = sizeof(gdth_cpar_str);
+		gdtcmd.u.ioctl.subfunc = CACHE_CONFIG;
+		gdtcmd.u.ioctl.channel = INVALID_CHANNEL;
+		pcpar->write_back = wb_mode==1 ? 0:1;
+
+		gdth_execute(host, &gdtcmd, cmnd, 30, NULL);
+
+		spin_lock_irqsave(&ha->smp_lock, flags);
+		ha->scratch_busy = FALSE;
+		spin_unlock_irqrestore(&ha->smp_lock, flags);
+
+		printk("Done.\n");
+		return(orig_length);
+	}
 
-    printk("GDT: Unknown command: %s  Length: %d\n",buffer,length);
-    return(-EINVAL);
+	printk("GDT: Unknown command: %s  Length: %d\n",buffer,length);
+	return(-EINVAL);
 }
 
 int gdth_show_info(struct seq_file *m, struct Scsi_Host *host)
 {
-    gdth_ha_str *ha = shost_priv(host);
-    int hlen;
-    int id, i, j, k, sec, flag;
-    int no_mdrv = 0, drv_no, is_mirr;
-    u32 cnt;
-    dma_addr_t paddr;
-    int rc = -ENOMEM;
-
-    gdth_cmd_str *gdtcmd;
-    gdth_evt_str *estr;
-    char hrec[277];
-
-    char *buf;
-    gdth_dskstat_str *pds;
-    gdth_diskinfo_str *pdi;
-    gdth_arrayinf_str *pai;
-    gdth_defcnt_str *pdef;
-    gdth_cdrinfo_str *pcdi;
-    gdth_hget_str *phg;
-    char cmnd[MAX_COMMAND_SIZE];
-
-    gdtcmd = kmalloc(sizeof(*gdtcmd), GFP_KERNEL);
-    estr = kmalloc(sizeof(*estr), GFP_KERNEL);
-    if (!gdtcmd || !estr)
-        goto free_fail;
-
-    memset(cmnd, 0xff, 12);
-    memset(gdtcmd, 0, sizeof(gdth_cmd_str));
-
-    TRACE2(("gdth_get_info() ha %d\n",ha->hanum));
-
-    
-    /* request is i.e. "cat /proc/scsi/gdth/0" */ 
-    /* format: %-15s\t%-10s\t%-15s\t%s */
-    /* driver parameters */
-    seq_puts(m, "Driver Parameters:\n");
-    if (reserve_list[0] == 0xff)
-        strcpy(hrec, "--");
-    else {
-        hlen = sprintf(hrec, "%d", reserve_list[0]);
-        for (i = 1;  i < MAX_RES_ARGS; i++) {
-            if (reserve_list[i] == 0xff) 
-                break;
-	    hlen += scnprintf(hrec + hlen, 161 - hlen, ",%d", reserve_list[i]);
-        }
-    }
-    seq_printf(m,
-                   " reserve_mode: \t%d         \treserve_list:  \t%s\n",
-                   reserve_mode, hrec);
-    seq_printf(m,
-                   " max_ids:      \t%-3d       \thdr_channel:   \t%d\n",
-                   max_ids, hdr_channel);
-
-    /* controller information */
-    seq_puts(m, "\nDisk Array Controller Information:\n");
-    seq_printf(m,
-                   " Number:       \t%d         \tName:          \t%s\n",
-                   ha->hanum, ha->binfo.type_string);
-
-    seq_printf(m,
-                   " Driver Ver.:  \t%-10s\tFirmware Ver.: \t",
-                   GDTH_VERSION_STR);
-    if (ha->more_proc)
-        seq_printf(m, "%d.%02d.%02d-%c%03X\n", 
-                (u8)(ha->binfo.upd_fw_ver>>24),
-                (u8)(ha->binfo.upd_fw_ver>>16),
-                (u8)(ha->binfo.upd_fw_ver),
-                ha->bfeat.raid ? 'R':'N',
-                ha->binfo.upd_revision);
-    else
-        seq_printf(m, "%d.%02d\n", (u8)(ha->cpar.version>>8),
-                (u8)(ha->cpar.version));
- 
-    if (ha->more_proc)
-        /* more information: 1. about controller */
-        seq_printf(m,
-                       " Serial No.:   \t0x%8X\tCache RAM size:\t%d KB\n",
-                       ha->binfo.ser_no, ha->binfo.memsize / 1024);
-
-    if (ha->more_proc) {
-        size_t size = max_t(size_t, GDTH_SCRATCH, sizeof(gdth_hget_str));
-
-        /* more information: 2. about physical devices */
-        seq_puts(m, "\nPhysical Devices:");
-        flag = FALSE;
-            
-        buf = dma_alloc_coherent(&ha->pdev->dev, size, &paddr, GFP_KERNEL);
-        if (!buf) 
-            goto stop_output;
-        for (i = 0; i < ha->bus_cnt; ++i) {
-            /* 2.a statistics (and retries/reassigns) */
-            TRACE2(("pdr_statistics() chn %d\n",i));                
-            pds = (gdth_dskstat_str *)(buf + GDTH_SCRATCH/4);
-            gdtcmd->Service = CACHESERVICE;
-            gdtcmd->OpCode = GDT_IOCTL;
-            gdtcmd->u.ioctl.p_param = paddr + GDTH_SCRATCH/4;
-            gdtcmd->u.ioctl.param_size = 3*GDTH_SCRATCH/4;
-            gdtcmd->u.ioctl.subfunc = DSK_STATISTICS | L_CTRL_PATTERN;
-            gdtcmd->u.ioctl.channel = ha->raw[i].address | INVALID_CHANNEL;
-            pds->bid = ha->raw[i].local_no;
-            pds->first = 0;
-            pds->entries = ha->raw[i].pdev_cnt;
-            cnt = (3*GDTH_SCRATCH/4 - 5 * sizeof(u32)) /
-                sizeof(pds->list[0]);
-            if (pds->entries > cnt)
-                pds->entries = cnt;
-
-            if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
-                pds->count = 0;
-
-            /* other IOCTLs must fit into area GDTH_SCRATCH/4 */
-            for (j = 0; j < ha->raw[i].pdev_cnt; ++j) {
-                /* 2.b drive info */
-                TRACE2(("scsi_drv_info() chn %d dev %d\n",
-                    i, ha->raw[i].id_list[j]));             
-                pdi = (gdth_diskinfo_str *)buf;
-                gdtcmd->Service = CACHESERVICE;
-                gdtcmd->OpCode = GDT_IOCTL;
-                gdtcmd->u.ioctl.p_param = paddr;
-                gdtcmd->u.ioctl.param_size = sizeof(gdth_diskinfo_str);
-                gdtcmd->u.ioctl.subfunc = SCSI_DR_INFO | L_CTRL_PATTERN;
-                gdtcmd->u.ioctl.channel = 
-                    ha->raw[i].address | ha->raw[i].id_list[j];
-
-                if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
-                    strncpy(hrec,pdi->vendor,8);
-                    strncpy(hrec+8,pdi->product,16);
-                    strncpy(hrec+24,pdi->revision,4);
-                    hrec[28] = 0;
-                    seq_printf(m,
-                                   "\n Chn/ID/LUN:   \t%c/%02d/%d    \tName:          \t%s\n",
-                                   'A'+i,pdi->target_id,pdi->lun,hrec);
-                    flag = TRUE;
-                    pdi->no_ldrive &= 0xffff;
-                    if (pdi->no_ldrive == 0xffff)
-                        strcpy(hrec,"--");
-                    else
-                        sprintf(hrec,"%d",pdi->no_ldrive);
-                    seq_printf(m,
-                                   " Capacity [MB]:\t%-6d    \tTo Log. Drive: \t%s\n",
-                                   pdi->blkcnt/(1024*1024/pdi->blksize),
-                                   hrec);
-                } else {
-                    pdi->devtype = 0xff;
-                }
-                    
-                if (pdi->devtype == 0) {
-                    /* search retries/reassigns */
-                    for (k = 0; k < pds->count; ++k) {
-                        if (pds->list[k].tid == pdi->target_id &&
-                            pds->list[k].lun == pdi->lun) {
-                            seq_printf(m,
-                                           " Retries:      \t%-6d    \tReassigns:     \t%d\n",
-                                           pds->list[k].retries,
-                                           pds->list[k].reassigns);
-                            break;
-                        }
-                    }
-                    /* 2.c grown defects */
-                    TRACE2(("scsi_drv_defcnt() chn %d dev %d\n",
-                            i, ha->raw[i].id_list[j]));             
-                    pdef = (gdth_defcnt_str *)buf;
-                    gdtcmd->Service = CACHESERVICE;
-                    gdtcmd->OpCode = GDT_IOCTL;
-                    gdtcmd->u.ioctl.p_param = paddr;
-                    gdtcmd->u.ioctl.param_size = sizeof(gdth_defcnt_str);
-                    gdtcmd->u.ioctl.subfunc = SCSI_DEF_CNT | L_CTRL_PATTERN;
-                    gdtcmd->u.ioctl.channel = 
-                        ha->raw[i].address | ha->raw[i].id_list[j];
-                    pdef->sddc_type = 0x08;
-
-                    if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
-                        seq_printf(m,
-                                       " Grown Defects:\t%d\n",
-                                       pdef->sddc_cnt);
-                    }
-                }
-            }
-        }
-
-        if (!flag)
-            seq_puts(m, "\n --\n");
-
-        /* 3. about logical drives */
-        seq_puts(m, "\nLogical Drives:");
-        flag = FALSE;
-
-        for (i = 0; i < MAX_LDRIVES; ++i) {
-            if (!ha->hdr[i].is_logdrv)
-                continue;
-            drv_no = i;
-            j = k = 0;
-            is_mirr = FALSE;
-            do {
-                /* 3.a log. drive info */
-                TRACE2(("cache_drv_info() drive no %d\n",drv_no));
-                pcdi = (gdth_cdrinfo_str *)buf;
-                gdtcmd->Service = CACHESERVICE;
-                gdtcmd->OpCode = GDT_IOCTL;
-                gdtcmd->u.ioctl.p_param = paddr;
-                gdtcmd->u.ioctl.param_size = sizeof(gdth_cdrinfo_str);
-                gdtcmd->u.ioctl.subfunc = CACHE_DRV_INFO;
-                gdtcmd->u.ioctl.channel = drv_no;
-                if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
-                    break;
-                pcdi->ld_dtype >>= 16;
-                j++;
-                if (pcdi->ld_dtype > 2) {
-                    strcpy(hrec, "missing");
-                } else if (pcdi->ld_error & 1) {
-                    strcpy(hrec, "fault");
-                } else if (pcdi->ld_error & 2) {
-                    strcpy(hrec, "invalid");
-                    k++; j--;
-                } else {
-                    strcpy(hrec, "ok");
-                }
-                    
-                if (drv_no == i) {
-                    seq_printf(m,
-                                   "\n Number:       \t%-2d        \tStatus:        \t%s\n",
-                                   drv_no, hrec);
-                    flag = TRUE;
-                    no_mdrv = pcdi->cd_ldcnt;
-                    if (no_mdrv > 1 || pcdi->ld_slave != -1) {
-                        is_mirr = TRUE;
-                        strcpy(hrec, "RAID-1");
-                    } else if (pcdi->ld_dtype == 0) {
-                        strcpy(hrec, "Disk");
-                    } else if (pcdi->ld_dtype == 1) {
-                        strcpy(hrec, "RAID-0");
-                    } else if (pcdi->ld_dtype == 2) {
-                        strcpy(hrec, "Chain");
-                    } else {
-                        strcpy(hrec, "???");
-                    }
-                    seq_printf(m,
-                                   " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
-                                   pcdi->ld_blkcnt/(1024*1024/pcdi->ld_blksize),
-                                   hrec);
-                } else {
-                    seq_printf(m,
-                                   " Slave Number: \t%-2d        \tStatus:        \t%s\n",
-                                   drv_no & 0x7fff, hrec);
-                }
-                drv_no = pcdi->ld_slave;
-            } while (drv_no != -1);
-             
-            if (is_mirr)
-                seq_printf(m,
-                               " Missing Drv.: \t%-2d        \tInvalid Drv.:  \t%d\n",
-                               no_mdrv - j - k, k);
-
-            if (!ha->hdr[i].is_arraydrv)
-                strcpy(hrec, "--");
-            else
-                sprintf(hrec, "%d", ha->hdr[i].master_no);
-            seq_printf(m,
-                           " To Array Drv.:\t%s\n", hrec);
-        }       
-
-        if (!flag)
-            seq_puts(m, "\n --\n");
-
-        /* 4. about array drives */
-        seq_puts(m, "\nArray Drives:");
-        flag = FALSE;
-
-        for (i = 0; i < MAX_LDRIVES; ++i) {
-            if (!(ha->hdr[i].is_arraydrv && ha->hdr[i].is_master))
-                continue;
-            /* 4.a array drive info */
-            TRACE2(("array_info() drive no %d\n",i));
-            pai = (gdth_arrayinf_str *)buf;
-            gdtcmd->Service = CACHESERVICE;
-            gdtcmd->OpCode = GDT_IOCTL;
-            gdtcmd->u.ioctl.p_param = paddr;
-            gdtcmd->u.ioctl.param_size = sizeof(gdth_arrayinf_str);
-            gdtcmd->u.ioctl.subfunc = ARRAY_INFO | LA_CTRL_PATTERN;
-            gdtcmd->u.ioctl.channel = i;
-            if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
-                if (pai->ai_state == 0)
-                    strcpy(hrec, "idle");
-                else if (pai->ai_state == 2)
-                    strcpy(hrec, "build");
-                else if (pai->ai_state == 4)
-                    strcpy(hrec, "ready");
-                else if (pai->ai_state == 6)
-                    strcpy(hrec, "fail");
-                else if (pai->ai_state == 8 || pai->ai_state == 10)
-                    strcpy(hrec, "rebuild");
-                else
-                    strcpy(hrec, "error");
-                if (pai->ai_ext_state & 0x10)
-                    strcat(hrec, "/expand");
-                else if (pai->ai_ext_state & 0x1)
-                    strcat(hrec, "/patch");
-                seq_printf(m,
-                               "\n Number:       \t%-2d        \tStatus:        \t%s\n",
-                               i,hrec);
-                flag = TRUE;
-
-                if (pai->ai_type == 0)
-                    strcpy(hrec, "RAID-0");
-                else if (pai->ai_type == 4)
-                    strcpy(hrec, "RAID-4");
-                else if (pai->ai_type == 5)
-                    strcpy(hrec, "RAID-5");
-                else 
-                    strcpy(hrec, "RAID-10");
-                seq_printf(m,
-                               " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
-                               pai->ai_size/(1024*1024/pai->ai_secsize),
-                               hrec);
-            }
-        }
-
-        if (!flag)
-            seq_puts(m, "\n --\n");
-
-        /* 5. about host drives */
-        seq_puts(m, "\nHost Drives:");
-        flag = FALSE;
-
-        for (i = 0; i < MAX_LDRIVES; ++i) {
-            if (!ha->hdr[i].is_logdrv || 
-                (ha->hdr[i].is_arraydrv && !ha->hdr[i].is_master))
-                continue;
-            /* 5.a get host drive list */
-            TRACE2(("host_get() drv_no %d\n",i));           
-            phg = (gdth_hget_str *)buf;
-            gdtcmd->Service = CACHESERVICE;
-            gdtcmd->OpCode = GDT_IOCTL;
-            gdtcmd->u.ioctl.p_param = paddr;
-            gdtcmd->u.ioctl.param_size = sizeof(gdth_hget_str);
-            gdtcmd->u.ioctl.subfunc = HOST_GET | LA_CTRL_PATTERN;
-            gdtcmd->u.ioctl.channel = i;
-            phg->entries = MAX_HDRIVES;
-            phg->offset = GDTOFFSOF(gdth_hget_str, entry[0]); 
-            if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
-                ha->hdr[i].ldr_no = i;
-                ha->hdr[i].rw_attribs = 0;
-                ha->hdr[i].start_sec = 0;
-            } else {
-                for (j = 0; j < phg->entries; ++j) {
-                    k = phg->entry[j].host_drive;
-                    if (k >= MAX_LDRIVES)
-                        continue;
-                    ha->hdr[k].ldr_no = phg->entry[j].log_drive;
-                    ha->hdr[k].rw_attribs = phg->entry[j].rw_attribs;
-                    ha->hdr[k].start_sec = phg->entry[j].start_sec;
-                }
-            }
-        }
-	dma_free_coherent(&ha->pdev->dev, size, buf, paddr);
-
-        for (i = 0; i < MAX_HDRIVES; ++i) {
-            if (!(ha->hdr[i].present))
-                continue;
-              
-            seq_printf(m,
-                           "\n Number:       \t%-2d        \tArr/Log. Drive:\t%d\n",
-                           i, ha->hdr[i].ldr_no);
-            flag = TRUE;
-
-            seq_printf(m,
-                           " Capacity [MB]:\t%-6d    \tStart Sector:  \t%d\n",
-                           (u32)(ha->hdr[i].size/2048), ha->hdr[i].start_sec);
-        }
-        
-        if (!flag)
-            seq_puts(m, "\n --\n");
-    }
-
-    /* controller events */
-    seq_puts(m, "\nController Events:\n");
-
-    for (id = -1;;) {
-        id = gdth_read_event(ha, id, estr);
-        if (estr->event_source == 0)
-            break;
-        if (estr->event_data.eu.driver.ionode == ha->hanum &&
-            estr->event_source == ES_ASYNC) { 
-            gdth_log_event(&estr->event_data, hrec);
-
-	    /*
-	     * Elapsed seconds subtraction with unsigned operands is
-	     * safe from wrap around in year 2106.  Executes as:
-	     * operand a + (2's complement operand b) + 1
-	     */
-
-	    sec = (int)((u32)ktime_get_real_seconds() - estr->first_stamp);
-            if (sec < 0) sec = 0;
-            seq_printf(m," date- %02d:%02d:%02d\t%s\n",
-                           sec/3600, sec%3600/60, sec%60, hrec);
-        }
-        if (id == -1)
-            break;
-    }
+	gdth_ha_str *ha = shost_priv(host);
+	int hlen;
+	int id, i, j, k, sec, flag;
+	int no_mdrv = 0, drv_no, is_mirr;
+	u32 cnt;
+	dma_addr_t paddr;
+	int rc = -ENOMEM;
+	gdth_cmd_str *gdtcmd;
+	gdth_evt_str *estr;
+	char hrec[277];
+	char *buf;
+	gdth_dskstat_str *pds;
+	gdth_diskinfo_str *pdi;
+	gdth_arrayinf_str *pai;
+	gdth_defcnt_str *pdef;
+	gdth_cdrinfo_str *pcdi;
+	gdth_hget_str *phg;
+	char cmnd[MAX_COMMAND_SIZE];
+
+	gdtcmd = kmalloc(sizeof(*gdtcmd), GFP_KERNEL);
+	estr = kmalloc(sizeof(*estr), GFP_KERNEL);
+	if (!gdtcmd || !estr)
+		goto free_fail;
+
+	memset(cmnd, 0xff, 12);
+	memset(gdtcmd, 0, sizeof(gdth_cmd_str));
+
+	TRACE2(("gdth_get_info() ha %d\n",ha->hanum));
+
+	/* request is i.e. "cat /proc/scsi/gdth/0" */
+	/* format: %-15s\t%-10s\t%-15s\t%s */
+	/* driver parameters */
+	seq_puts(m, "Driver Parameters:\n");
+	if (reserve_list[0] == 0xff)
+		strcpy(hrec, "--");
+	else {
+		hlen = sprintf(hrec, "%d", reserve_list[0]);
+		for (i = 1;  i < MAX_RES_ARGS; i++) {
+			if (reserve_list[i] == 0xff)
+				break;
+			hlen += scnprintf(hrec + hlen, 161 - hlen, ",%d", reserve_list[i]);
+		}
+	}
+	seq_printf(m,
+		   " reserve_mode: \t%d         \treserve_list:  \t%s\n",
+		   reserve_mode, hrec);
+	seq_printf(m,
+		   " max_ids:      \t%-3d       \thdr_channel:   \t%d\n",
+		   max_ids, hdr_channel);
+
+	/* controller information */
+	seq_puts(m, "\nDisk Array Controller Information:\n");
+	seq_printf(m,
+		   " Number:       \t%d         \tName:          \t%s\n",
+		   ha->hanum, ha->binfo.type_string);
+
+	seq_printf(m,
+		   " Driver Ver.:  \t%-10s\tFirmware Ver.: \t",
+		   GDTH_VERSION_STR);
+	if (ha->more_proc)
+		seq_printf(m, "%d.%02d.%02d-%c%03X\n",
+			   (u8)(ha->binfo.upd_fw_ver>>24),
+			   (u8)(ha->binfo.upd_fw_ver>>16),
+			   (u8)(ha->binfo.upd_fw_ver),
+			   ha->bfeat.raid ? 'R':'N',
+			   ha->binfo.upd_revision);
+	else
+		seq_printf(m, "%d.%02d\n", (u8)(ha->cpar.version>>8),
+			   (u8)(ha->cpar.version));
+
+	if (ha->more_proc)
+		/* more information: 1. about controller */
+		seq_printf(m,
+			   " Serial No.:   \t0x%8X\tCache RAM size:\t%d KB\n",
+			   ha->binfo.ser_no, ha->binfo.memsize / 1024);
+
+	if (ha->more_proc) {
+		size_t size = max_t(size_t, GDTH_SCRATCH, sizeof(gdth_hget_str));
+
+		/* more information: 2. about physical devices */
+		seq_puts(m, "\nPhysical Devices:");
+		flag = FALSE;
+
+		buf = dma_alloc_coherent(&ha->pdev->dev, size, &paddr, GFP_KERNEL);
+		if (!buf)
+			goto stop_output;
+		for (i = 0; i < ha->bus_cnt; ++i) {
+			/* 2.a statistics (and retries/reassigns) */
+			TRACE2(("pdr_statistics() chn %d\n",i));
+			pds = (gdth_dskstat_str *)(buf + GDTH_SCRATCH/4);
+			gdtcmd->Service = CACHESERVICE;
+			gdtcmd->OpCode = GDT_IOCTL;
+			gdtcmd->u.ioctl.p_param = paddr + GDTH_SCRATCH/4;
+			gdtcmd->u.ioctl.param_size = 3*GDTH_SCRATCH/4;
+			gdtcmd->u.ioctl.subfunc = DSK_STATISTICS | L_CTRL_PATTERN;
+			gdtcmd->u.ioctl.channel = ha->raw[i].address | INVALID_CHANNEL;
+			pds->bid = ha->raw[i].local_no;
+			pds->first = 0;
+			pds->entries = ha->raw[i].pdev_cnt;
+			cnt = (3*GDTH_SCRATCH/4 - 5 * sizeof(u32)) /
+				sizeof(pds->list[0]);
+			if (pds->entries > cnt)
+				pds->entries = cnt;
+
+			if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
+				pds->count = 0;
+
+			/* other IOCTLs must fit into area GDTH_SCRATCH/4 */
+			for (j = 0; j < ha->raw[i].pdev_cnt; ++j) {
+				/* 2.b drive info */
+				TRACE2(("scsi_drv_info() chn %d dev %d\n",
+					i, ha->raw[i].id_list[j]));
+				pdi = (gdth_diskinfo_str *)buf;
+				gdtcmd->Service = CACHESERVICE;
+				gdtcmd->OpCode = GDT_IOCTL;
+				gdtcmd->u.ioctl.p_param = paddr;
+				gdtcmd->u.ioctl.param_size = sizeof(gdth_diskinfo_str);
+				gdtcmd->u.ioctl.subfunc = SCSI_DR_INFO | L_CTRL_PATTERN;
+				gdtcmd->u.ioctl.channel =
+					ha->raw[i].address | ha->raw[i].id_list[j];
+
+				if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
+					strncpy(hrec,pdi->vendor,8);
+					strncpy(hrec+8,pdi->product,16);
+					strncpy(hrec+24,pdi->revision,4);
+					hrec[28] = 0;
+					seq_printf(m,
+						   "\n Chn/ID/LUN:   \t%c/%02d/%d    \tName:          \t%s\n",
+						   'A'+i,pdi->target_id,pdi->lun,hrec);
+					flag = TRUE;
+					pdi->no_ldrive &= 0xffff;
+					if (pdi->no_ldrive == 0xffff)
+						strcpy(hrec,"--");
+					else
+						sprintf(hrec,"%d",pdi->no_ldrive);
+					seq_printf(m,
+						   " Capacity [MB]:\t%-6d    \tTo Log. Drive: \t%s\n",
+						   pdi->blkcnt/(1024*1024/pdi->blksize),
+						   hrec);
+				} else {
+					pdi->devtype = 0xff;
+				}
+
+				if (pdi->devtype == 0) {
+					/* search retries/reassigns */
+					for (k = 0; k < pds->count; ++k) {
+						if (pds->list[k].tid == pdi->target_id &&
+						    pds->list[k].lun == pdi->lun) {
+							seq_printf(m,
+								   " Retries:      \t%-6d    \tReassigns:     \t%d\n",
+								   pds->list[k].retries,
+								   pds->list[k].reassigns);
+							break;
+						}
+					}
+					/* 2.c grown defects */
+					TRACE2(("scsi_drv_defcnt() chn %d dev %d\n",
+						i, ha->raw[i].id_list[j]));
+					pdef = (gdth_defcnt_str *)buf;
+					gdtcmd->Service = CACHESERVICE;
+					gdtcmd->OpCode = GDT_IOCTL;
+					gdtcmd->u.ioctl.p_param = paddr;
+					gdtcmd->u.ioctl.param_size = sizeof(gdth_defcnt_str);
+					gdtcmd->u.ioctl.subfunc = SCSI_DEF_CNT | L_CTRL_PATTERN;
+					gdtcmd->u.ioctl.channel =
+						ha->raw[i].address | ha->raw[i].id_list[j];
+					pdef->sddc_type = 0x08;
+
+					if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
+						seq_printf(m,
+							   " Grown Defects:\t%d\n",
+							   pdef->sddc_cnt);
+					}
+				}
+			}
+		}
+
+		if (!flag)
+			seq_puts(m, "\n --\n");
+
+		/* 3. about logical drives */
+		seq_puts(m, "\nLogical Drives:");
+		flag = FALSE;
+
+		for (i = 0; i < MAX_LDRIVES; ++i) {
+			if (!ha->hdr[i].is_logdrv)
+				continue;
+			drv_no = i;
+			j = k = 0;
+			is_mirr = FALSE;
+			do {
+				/* 3.a log. drive info */
+				TRACE2(("cache_drv_info() drive no %d\n",drv_no));
+				pcdi = (gdth_cdrinfo_str *)buf;
+				gdtcmd->Service = CACHESERVICE;
+				gdtcmd->OpCode = GDT_IOCTL;
+				gdtcmd->u.ioctl.p_param = paddr;
+				gdtcmd->u.ioctl.param_size = sizeof(gdth_cdrinfo_str);
+				gdtcmd->u.ioctl.subfunc = CACHE_DRV_INFO;
+				gdtcmd->u.ioctl.channel = drv_no;
+				if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) != S_OK)
+					break;
+				pcdi->ld_dtype >>= 16;
+				j++;
+				if (pcdi->ld_dtype > 2) {
+					strcpy(hrec, "missing");
+				} else if (pcdi->ld_error & 1) {
+					strcpy(hrec, "fault");
+				} else if (pcdi->ld_error & 2) {
+					strcpy(hrec, "invalid");
+					k++; j--;
+				} else {
+					strcpy(hrec, "ok");
+				}
+
+				if (drv_no == i) {
+					seq_printf(m,
+						   "\n Number:       \t%-2d        \tStatus:        \t%s\n",
+						   drv_no, hrec);
+					flag = TRUE;
+					no_mdrv = pcdi->cd_ldcnt;
+					if (no_mdrv > 1 || pcdi->ld_slave != -1) {
+						is_mirr = TRUE;
+						strcpy(hrec, "RAID-1");
+					} else if (pcdi->ld_dtype == 0) {
+						strcpy(hrec, "Disk");
+					} else if (pcdi->ld_dtype == 1) {
+						strcpy(hrec, "RAID-0");
+					} else if (pcdi->ld_dtype == 2) {
+						strcpy(hrec, "Chain");
+					} else {
+						strcpy(hrec, "???");
+					}
+					seq_printf(m,
+						   " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
+						   pcdi->ld_blkcnt/(1024*1024/pcdi->ld_blksize),
+						   hrec);
+				} else {
+					seq_printf(m,
+						   " Slave Number: \t%-2d        \tStatus:        \t%s\n",
+						   drv_no & 0x7fff, hrec);
+				}
+				drv_no = pcdi->ld_slave;
+			} while (drv_no != -1);
+
+			if (is_mirr)
+				seq_printf(m,
+					   " Missing Drv.: \t%-2d        \tInvalid Drv.:  \t%d\n",
+					   no_mdrv - j - k, k);
+
+			if (!ha->hdr[i].is_arraydrv)
+				strcpy(hrec, "--");
+			else
+				sprintf(hrec, "%d", ha->hdr[i].master_no);
+			seq_printf(m,
+				   " To Array Drv.:\t%s\n", hrec);
+		}
+
+		if (!flag)
+			seq_puts(m, "\n --\n");
+
+		/* 4. about array drives */
+		seq_puts(m, "\nArray Drives:");
+		flag = FALSE;
+
+		for (i = 0; i < MAX_LDRIVES; ++i) {
+			if (!(ha->hdr[i].is_arraydrv && ha->hdr[i].is_master))
+				continue;
+			/* 4.a array drive info */
+			TRACE2(("array_info() drive no %d\n",i));
+			pai = (gdth_arrayinf_str *)buf;
+			gdtcmd->Service = CACHESERVICE;
+			gdtcmd->OpCode = GDT_IOCTL;
+			gdtcmd->u.ioctl.p_param = paddr;
+			gdtcmd->u.ioctl.param_size = sizeof(gdth_arrayinf_str);
+			gdtcmd->u.ioctl.subfunc = ARRAY_INFO | LA_CTRL_PATTERN;
+			gdtcmd->u.ioctl.channel = i;
+			if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
+				if (pai->ai_state == 0)
+					strcpy(hrec, "idle");
+				else if (pai->ai_state == 2)
+					strcpy(hrec, "build");
+				else if (pai->ai_state == 4)
+					strcpy(hrec, "ready");
+				else if (pai->ai_state == 6)
+					strcpy(hrec, "fail");
+				else if (pai->ai_state == 8 || pai->ai_state == 10)
+					strcpy(hrec, "rebuild");
+				else
+					strcpy(hrec, "error");
+				if (pai->ai_ext_state & 0x10)
+					strcat(hrec, "/expand");
+				else if (pai->ai_ext_state & 0x1)
+					strcat(hrec, "/patch");
+				seq_printf(m,
+					   "\n Number:       \t%-2d        \tStatus:        \t%s\n",
+					   i,hrec);
+				flag = TRUE;
+
+				if (pai->ai_type == 0)
+					strcpy(hrec, "RAID-0");
+				else if (pai->ai_type == 4)
+					strcpy(hrec, "RAID-4");
+				else if (pai->ai_type == 5)
+					strcpy(hrec, "RAID-5");
+				else
+					strcpy(hrec, "RAID-10");
+				seq_printf(m,
+					   " Capacity [MB]:\t%-6d    \tType:          \t%s\n",
+					   pai->ai_size/(1024*1024/pai->ai_secsize),
+					   hrec);
+			}
+		}
+
+		if (!flag)
+			seq_puts(m, "\n --\n");
+
+		/* 5. about host drives */
+		seq_puts(m, "\nHost Drives:");
+		flag = FALSE;
+
+		for (i = 0; i < MAX_LDRIVES; ++i) {
+			if (!ha->hdr[i].is_logdrv ||
+			    (ha->hdr[i].is_arraydrv && !ha->hdr[i].is_master))
+				continue;
+			/* 5.a get host drive list */
+			TRACE2(("host_get() drv_no %d\n",i));
+			phg = (gdth_hget_str *)buf;
+			gdtcmd->Service = CACHESERVICE;
+			gdtcmd->OpCode = GDT_IOCTL;
+			gdtcmd->u.ioctl.p_param = paddr;
+			gdtcmd->u.ioctl.param_size = sizeof(gdth_hget_str);
+			gdtcmd->u.ioctl.subfunc = HOST_GET | LA_CTRL_PATTERN;
+			gdtcmd->u.ioctl.channel = i;
+			phg->entries = MAX_HDRIVES;
+			phg->offset = GDTOFFSOF(gdth_hget_str, entry[0]);
+			if (gdth_execute(host, gdtcmd, cmnd, 30, NULL) == S_OK) {
+				ha->hdr[i].ldr_no = i;
+				ha->hdr[i].rw_attribs = 0;
+				ha->hdr[i].start_sec = 0;
+			} else {
+				for (j = 0; j < phg->entries; ++j) {
+					k = phg->entry[j].host_drive;
+					if (k >= MAX_LDRIVES)
+						continue;
+					ha->hdr[k].ldr_no = phg->entry[j].log_drive;
+					ha->hdr[k].rw_attribs = phg->entry[j].rw_attribs;
+					ha->hdr[k].start_sec = phg->entry[j].start_sec;
+				}
+			}
+		}
+		dma_free_coherent(&ha->pdev->dev, size, buf, paddr);
+
+		for (i = 0; i < MAX_HDRIVES; ++i) {
+			if (!(ha->hdr[i].present))
+				continue;
+
+			seq_printf(m,
+				   "\n Number:       \t%-2d        \tArr/Log. Drive:\t%d\n",
+				   i, ha->hdr[i].ldr_no);
+			flag = TRUE;
+
+			seq_printf(m,
+				   " Capacity [MB]:\t%-6d    \tStart Sector:  \t%d\n",
+				   (u32)(ha->hdr[i].size/2048), ha->hdr[i].start_sec);
+		}
+
+		if (!flag)
+			seq_puts(m, "\n --\n");
+	}
+
+	/* controller events */
+	seq_puts(m, "\nController Events:\n");
+
+	for (id = -1;;) {
+		id = gdth_read_event(ha, id, estr);
+		if (estr->event_source == 0)
+			break;
+		if (estr->event_data.eu.driver.ionode == ha->hanum &&
+		    estr->event_source == ES_ASYNC) {
+			gdth_log_event(&estr->event_data, hrec);
+
+			/*
+			 * Elapsed seconds subtraction with unsigned operands is
+			 * safe from wrap around in year 2106.  Executes as:
+			 * operand a + (2's complement operand b) + 1
+			 */
+
+			sec = (int)((u32)ktime_get_real_seconds() - estr->first_stamp);
+			if (sec < 0) sec = 0;
+			seq_printf(m," date- %02d:%02d:%02d\t%s\n",
+				   sec/3600, sec%3600/60, sec%60, hrec);
+		}
+		if (id == -1)
+			break;
+	}
 stop_output:
-    rc = 0;
+	rc = 0;
 free_fail:
-    kfree(gdtcmd);
-    kfree(estr);
-    return rc;
+	kfree(gdtcmd);
+	kfree(estr);
+	return rc;
 }
 
 static void gdth_wait_completion(gdth_ha_str *ha, int busnum, int id)
 {
-    unsigned long flags;
-    int i;
-    struct scsi_cmnd *scp;
-    struct gdth_cmndinfo *cmndinfo;
-    u8 b, t;
-
-    spin_lock_irqsave(&ha->smp_lock, flags);
-
-    for (i = 0; i < GDTH_MAXCMDS; ++i) {
-        scp = ha->cmd_tab[i].cmnd;
-        cmndinfo = gdth_cmnd_priv(scp);
-
-        b = scp->device->channel;
-        t = scp->device->id;
-        if (!SPECIAL_SCP(scp) && t == (u8)id && 
-            b == (u8)busnum) {
-            cmndinfo->wait_for_completion = 0;
-            spin_unlock_irqrestore(&ha->smp_lock, flags);
-            while (!cmndinfo->wait_for_completion)
-                barrier();
-            spin_lock_irqsave(&ha->smp_lock, flags);
-        }
-    }
-    spin_unlock_irqrestore(&ha->smp_lock, flags);
+	unsigned long flags;
+	int i;
+	struct scsi_cmnd *scp;
+	struct gdth_cmndinfo *cmndinfo;
+	u8 b, t;
+
+	spin_lock_irqsave(&ha->smp_lock, flags);
+
+	for (i = 0; i < GDTH_MAXCMDS; ++i) {
+		scp = ha->cmd_tab[i].cmnd;
+		cmndinfo = gdth_cmnd_priv(scp);
+
+		b = scp->device->channel;
+		t = scp->device->id;
+		if (!SPECIAL_SCP(scp) && t == (u8)id &&
+		    b == (u8)busnum) {
+			cmndinfo->wait_for_completion = 0;
+			spin_unlock_irqrestore(&ha->smp_lock, flags);
+			while (!cmndinfo->wait_for_completion)
+				barrier();
+			spin_lock_irqsave(&ha->smp_lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&ha->smp_lock, flags);
 }
diff --git a/drivers/scsi/gdth_proc.h b/drivers/scsi/gdth_proc.h
index 4cc5377cb92e..6ba5ddf93c8c 100644
--- a/drivers/scsi/gdth_proc.h
+++ b/drivers/scsi/gdth_proc.h
@@ -2,15 +2,15 @@
 #ifndef _GDTH_PROC_H
 #define _GDTH_PROC_H
 
-/* gdth_proc.h 
+/* gdth_proc.h
  * $Id: gdth_proc.h,v 1.16 2004/01/14 13:09:01 achim Exp $
  */
 
 int gdth_execute(struct Scsi_Host *shost, gdth_cmd_str *gdtcmd, char *cmnd,
-                 int timeout, u32 *info);
+		 int timeout, u32 *info);
 
 static int gdth_set_asc_info(struct Scsi_Host *host, char *buffer,
-                             int length, gdth_ha_str *ha);
+			     int length, gdth_ha_str *ha);
 
 static void gdth_wait_completion(gdth_ha_str *ha, int busnum, int id);
 
-- 
2.16.4

