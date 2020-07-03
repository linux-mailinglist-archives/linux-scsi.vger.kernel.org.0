Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8EA213A82
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGCNBl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jul 2020 09:01:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgGCNBf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 3 Jul 2020 09:01:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFF40AF70;
        Fri,  3 Jul 2020 13:01:27 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 20/21] aacraid: use scsi_get_internal_cmd()
Date:   Fri,  3 Jul 2020 15:01:21 +0200
Message-Id: <20200703130122.111448-21-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200703130122.111448-1-hare@suse.de>
References: <20200703130122.111448-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use scsi_get_internal_cmd() to allocate internal commands.
And move scsi_add_host() such that it's allocated early enough
to provide tags for the initialisation commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/aachba.c   | 92 +++++++++++++++++++----------------------
 drivers/scsi/aacraid/aacraid.h  | 10 +++--
 drivers/scsi/aacraid/commctrl.c | 25 ++++++-----
 drivers/scsi/aacraid/comminit.c |  2 +-
 drivers/scsi/aacraid/commsup.c  | 60 ++++++++++++---------------
 drivers/scsi/aacraid/dpcsup.c   |  2 +-
 drivers/scsi/aacraid/linit.c    | 13 ++++--
 7 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index e1ba5e65a66f..a937a8b0d54b 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -359,7 +359,7 @@ int aac_get_config_status(struct aac_dev *dev, int commit_flag)
 	int status = 0;
 	struct fib * fibptr;
 
-	if (!(fibptr = aac_fib_alloc(dev)))
+	if (!(fibptr = aac_fib_alloc(dev, DMA_FROM_DEVICE)))
 		return -ENOMEM;
 
 	aac_fib_init(fibptr);
@@ -456,7 +456,7 @@ int aac_get_containers(struct aac_dev *dev)
 	struct aac_get_container_count_resp *dresp;
 	int maximum_num_containers = MAXIMUM_NUM_CONTAINERS;
 
-	if (!(fibptr = aac_fib_alloc(dev)))
+	if (!(fibptr = aac_fib_alloc(dev, DMA_FROM_DEVICE)))
 		return -ENOMEM;
 
 	aac_fib_init(fibptr);
@@ -740,61 +740,56 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 	}
 }
 
-static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(struct scsi_cmnd *))
+static int _aac_probe_container(struct fib * fibptr, int (*callback)(struct scsi_cmnd *))
 {
+	struct scsi_cmnd *scsicmd = fibptr->scmd;
 	struct aac_dev * dev;
-	struct fib * fibptr;
 	int status = -ENOMEM;
+	struct aac_query_mount *dinfo;
 	int cid = scmd_id(scsicmd);
 
 	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
 	if (scsicmd->host_scribble) {
-		cid = *(int *)scsicmd->host_scribble;
-		if (cid > dev->maximum_num_containers) {
+		cid = *(unsigned int *)scsicmd->host_scribble;
+		if (cid >= dev->maximum_num_containers) {
 			status = -ENODEV;
 			goto out_status;
 		}
 	}
-	if ((fibptr = aac_fib_alloc(dev))) {
-		struct aac_query_mount *dinfo;
 
-		aac_fib_init(fibptr);
+	aac_fib_init(fibptr);
 
-		dinfo = (struct aac_query_mount *)fib_data(fibptr);
+	dinfo = (struct aac_query_mount *)fib_data(fibptr);
 
-		if (fibptr->dev->supplement_adapter_info.supported_options2 &
-		    AAC_OPTION_VARIABLE_BLOCK_SIZE)
-			dinfo->command = cpu_to_le32(VM_NameServeAllBlk);
-		else
-			dinfo->command = cpu_to_le32(VM_NameServe);
+	if (fibptr->dev->supplement_adapter_info.supported_options2 &
+	    AAC_OPTION_VARIABLE_BLOCK_SIZE)
+		dinfo->command = cpu_to_le32(VM_NameServeAllBlk);
+	else
+		dinfo->command = cpu_to_le32(VM_NameServe);
 
-		dinfo->count = cpu_to_le32(cid);
-		dinfo->type = cpu_to_le32(FT_FILESYS);
-		scsicmd->SCp.ptr = (char *)callback;
-		scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	dinfo->count = cpu_to_le32(cid);
+	dinfo->type = cpu_to_le32(FT_FILESYS);
+	scsicmd->SCp.ptr = (char *)callback;
+	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
 
-		status = aac_fib_send(ContainerCommand,
+	status = aac_fib_send(ContainerCommand,
 			  fibptr,
 			  sizeof(struct aac_query_mount),
 			  FsaNormal,
 			  0, 1,
 			  _aac_probe_container1,
 			  (void *) scsicmd);
-		/*
-		 *	Check that the command queued to the controller
-		 */
-		if (status == -EINPROGRESS)
-			return 0;
-
-		if (status < 0) {
-			scsicmd->SCp.ptr = NULL;
-			aac_fib_complete(fibptr);
-			aac_fib_free(fibptr);
-		}
-	}
+	/*
+	 *	Check that the command queued to the controller
+	 */
+	if (status == -EINPROGRESS)
+		return 0;
 out_status:
 	if (status < 0) {
 		struct fsa_dev_info *fsa_dev_ptr = dev->fsa_dev;
+
+		scsicmd->SCp.ptr = NULL;
+		aac_fib_complete(fibptr);
 		if (fsa_dev_ptr && cid < dev->maximum_num_containers) {
 			fsa_dev_ptr += cid;
 			if ((fsa_dev_ptr->valid & 1) == 0) {
@@ -827,29 +822,23 @@ static void aac_probe_container_scsi_done(struct scsi_cmnd *scsi_cmnd)
 
 int aac_probe_container(struct aac_dev *dev, int cid)
 {
-	struct scsi_cmnd *scsicmd = kmalloc(sizeof(*scsicmd), GFP_KERNEL);
-	struct scsi_device *scsidev = kmalloc(sizeof(*scsidev), GFP_KERNEL);
+	struct fib *fibptr;
+	struct scsi_cmnd *scsicmd;
 	int status;
 
-	if (!scsicmd || !scsidev) {
-		kfree(scsicmd);
-		kfree(scsidev);
+	fibptr = aac_fib_alloc(dev, DMA_FROM_DEVICE);
+	if (!fibptr)
 		return -ENOMEM;
-	}
+
+	scsicmd = fibptr->scmd;
 	scsicmd->scsi_done = aac_probe_container_scsi_done;
 	scsicmd->host_scribble = (unsigned char *)&cid;
 
-	scsicmd->device = scsidev;
-	scsidev->sdev_state = 0;
-	scsidev->id = cid;
-	scsidev->host = dev->scsi_host_ptr;
-
-	if (_aac_probe_container(scsicmd, aac_probe_container_callback1) == 0)
+	if (_aac_probe_container(fibptr, aac_probe_container_callback1) == 0)
 		while (scsicmd->host_scribble == (unsigned char *)&cid)
 			schedule();
-	kfree(scsidev);
 	status = scsicmd->SCp.Status;
-	kfree(scsicmd);
+	aac_fib_free(fibptr);
 	return status;
 }
 
@@ -1695,7 +1684,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
 		return 0;
 
 	/* allocate FIB */
-	fibptr = aac_fib_alloc(dev);
+	fibptr = aac_fib_alloc(dev, DMA_BIDIRECTIONAL);
 	if (!fibptr)
 		return -ENOMEM;
 
@@ -2062,7 +2051,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 	struct aac_bus_info *command;
 	struct aac_bus_info_response *bus_info;
 
-	if (!(fibptr = aac_fib_alloc(dev)))
+	if (!(fibptr = aac_fib_alloc(dev, DMA_FROM_DEVICE)))
 		return -ENOMEM;
 
 	aac_fib_init(fibptr);
@@ -2109,7 +2098,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 		if (rcode >= 0)
 			memcpy(&dev->supplement_adapter_info, sinfo, sizeof(*sinfo));
 		if (rcode == -ERESTARTSYS) {
-			fibptr = aac_fib_alloc(dev);
+			fibptr = aac_fib_alloc(dev, DMA_FROM_DEVICE);
 			if (!fibptr)
 				return -ENOMEM;
 		}
@@ -2828,6 +2817,8 @@ int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 			if (((fsa_dev_ptr[cid].valid & 1) == 0) ||
 			  (fsa_dev_ptr[cid].sense_data.sense_key ==
 			   NOT_READY)) {
+				struct fib * fibptr;
+
 				switch (scsicmd->cmnd[0]) {
 				case SERVICE_ACTION_IN_16:
 					if (!(dev->raw_io_interface) ||
@@ -2840,7 +2831,8 @@ int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 				case TEST_UNIT_READY:
 					if (dev->in_reset)
 						return -1;
-					return _aac_probe_container(scsicmd,
+					fibptr = aac_fib_alloc_tag(dev, scsicmd);
+					return _aac_probe_container(fibptr,
 							aac_probe_container_callback2);
 				default:
 					break;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index e3e4ecbea726..3cd7f33497d8 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1291,13 +1291,16 @@ struct fsa_dev_info {
 };
 
 struct fib {
-	void			*next;	/* this is used by the allocator */
 	s16			type;
 	s16			size;
 	/*
 	 *	The Adapter that this I/O is destined for.
 	 */
 	struct aac_dev		*dev;
+	/*
+	 * The associated scsi command
+	 */
+	struct scsi_cmnd 	*scmd;
 	/*
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
@@ -1552,7 +1555,6 @@ struct aac_dev
 	 */
 	struct fib              *fibs;
 
-	struct fib		*free_fib;
 	spinlock_t		fib_lock;
 
 	struct mutex		ioctl_mutex;
@@ -1597,6 +1599,7 @@ struct aac_dev
 	size_t			comm_size;
 
 	struct Scsi_Host	*scsi_host_ptr;
+	struct scsi_device	*scsi_host_dev;
 	int			maximum_num_containers;
 	int			maximum_num_physicals;
 	int			maximum_num_channels;
@@ -1729,6 +1732,7 @@ struct aac_dev
 #define FIB_CONTEXT_FLAG_NATIVE_HBA_TMF	(0x00000020)
 #define FIB_CONTEXT_FLAG_SCSI_CMD	(0x00000040)
 #define FIB_CONTEXT_FLAG_EH_RESET	(0x00000080)
+#define FIB_CONTEXT_FLAG_INTERNAL_CMD	(0x00000100)
 
 /*
  *	Define the command values
@@ -2686,7 +2690,7 @@ void aac_free_irq(struct aac_dev *dev);
 int aac_setup_safw_adapter(struct aac_dev *dev);
 const char *aac_driverinfo(struct Scsi_Host *);
 void aac_fib_vector_assign(struct aac_dev *dev);
-struct fib *aac_fib_alloc(struct aac_dev *dev);
+struct fib *aac_fib_alloc(struct aac_dev *dev, int direction);
 struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd);
 int aac_fib_setup(struct aac_dev *dev);
 void aac_fib_map_free(struct aac_dev *dev);
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 34e65dea992e..f45b546310aa 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -55,7 +55,7 @@ static int ioctl_send_fib(struct aac_dev * dev, void __user *arg)
 	if (dev->in_reset) {
 		return -EBUSY;
 	}
-	fibptr = aac_fib_alloc(dev);
+	fibptr = aac_fib_alloc(dev, DMA_BIDIRECTIONAL);
 	if(fibptr == NULL) {
 		return -ENOMEM;
 	}
@@ -462,7 +462,7 @@ static int check_revision(struct aac_dev *dev, void __user *arg)
 
 static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 {
-	struct fib* srbfib;
+	struct fib* srbfib = NULL;
 	int status;
 	struct aac_srb *srbcmd = NULL;
 	struct aac_hba_cmd_req *hbacmd = NULL;
@@ -493,12 +493,6 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		dprintk((KERN_DEBUG"aacraid: No permission to send raw srb\n"));
 		return -EPERM;
 	}
-	/*
-	 *	Allocate and initialize a Fib then setup a SRB command
-	 */
-	if (!(srbfib = aac_fib_alloc(dev))) {
-		return -ENOMEM;
-	}
 
 	memset(sg_list, 0, sizeof(sg_list)); /* cleanup may take issue */
 	if(copy_from_user(&fibsize, &user_srb->count,sizeof(u32))){
@@ -545,6 +539,15 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		rcode = -EINVAL;
 		goto cleanup;
 	}
+
+	/*
+	 *	Allocate and initialize a Fib
+	 */
+	if (!(srbfib = aac_fib_alloc(dev, data_dir))) {
+		rcode = -ENOMEM;
+		goto cleanup;
+	}
+
 	actual_fibsize = sizeof(struct aac_srb) - sizeof(struct sgentry) +
 		((user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry));
 	actual_fibsize64 = actual_fibsize + (user_srbcmd->sg.count & 0xff) *
@@ -970,8 +973,10 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 	if (rcode != -ERESTARTSYS) {
 		for (i = 0; i <= sg_indx; i++)
 			kfree(sg_list[i]);
-		aac_fib_complete(srbfib);
-		aac_fib_free(srbfib);
+		if (srbfib) {
+			aac_fib_complete(srbfib);
+			aac_fib_free(srbfib);
+		}
 	}
 
 	return rcode;
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 355b16f0b145..0d5be76891b0 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -327,7 +327,7 @@ int aac_send_shutdown(struct aac_dev * dev)
 
 	aac_wait_for_io_completion(dev);
 
-	fibctx = aac_fib_alloc(dev);
+	fibctx = aac_fib_alloc(dev, DMA_NONE);
 	if (!fibctx)
 		return -ENOMEM;
 	aac_fib_init(fibctx);
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 8ee4e1abe568..7b632b74f4b4 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -173,7 +173,6 @@ int aac_fib_setup(struct aac_dev * dev)
 		fibptr->dev = dev;
 		fibptr->hw_fib_va = hw_fib;
 		fibptr->data = (void *) fibptr->hw_fib_va->data;
-		fibptr->next = fibptr+1;	/* Forward chain the fibs */
 		init_completion(&fibptr->event_wait);
 		spin_lock_init(&fibptr->event_lock);
 		hw_fib->header.XferState = cpu_to_le32(0xffffffff);
@@ -200,14 +199,6 @@ int aac_fib_setup(struct aac_dev * dev)
 	 */
 	aac_fib_vector_assign(dev);
 
-	/*
-	 *	Add the fib chain to the free list
-	 */
-	dev->fibs[dev->scsi_host_ptr->can_queue + AAC_NUM_MGT_FIB - 1].next = NULL;
-	/*
-	*	Set 8 fibs aside for management tools
-	*/
-	dev->free_fib = &dev->fibs[dev->scsi_host_ptr->can_queue];
 	return 0;
 }
 
@@ -232,7 +223,7 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 	fibptr->type = FSAFS_NTC_FIB_CONTEXT;
 	fibptr->callback_data = NULL;
 	fibptr->callback = NULL;
-	fibptr->flags = 0;
+	fibptr->scmd = scmd;
 
 	return fibptr;
 }
@@ -240,36 +231,30 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 /**
  *	aac_fib_alloc	-	allocate a fib
  *	@dev: Adapter to allocate the fib for
+ *	@direction: DMA data direction
  *
  *	Allocate a fib from the adapter fib pool. If the pool is empty we
  *	return NULL.
  */
 
-struct fib *aac_fib_alloc(struct aac_dev *dev)
+struct fib *aac_fib_alloc(struct aac_dev *dev, int direction)
 {
-	struct fib * fibptr;
+	struct scsi_cmnd *scmd;
+	struct fib * fibptr = NULL;
 	unsigned long flags;
+
 	spin_lock_irqsave(&dev->fib_lock, flags);
-	fibptr = dev->free_fib;
-	if(!fibptr){
-		spin_unlock_irqrestore(&dev->fib_lock, flags);
-		return fibptr;
+	scmd = scsi_get_internal_cmd(dev->scsi_host_dev, direction,
+				     REQ_NOWAIT);
+	if (scmd) {
+		fibptr = aac_fib_alloc_tag(dev, scmd);
+		fibptr->flags |= FIB_CONTEXT_FLAG_INTERNAL_CMD;
 	}
-	dev->free_fib = fibptr->next;
 	spin_unlock_irqrestore(&dev->fib_lock, flags);
-	/*
-	 *	Set the proper node type code and node byte size
-	 */
-	fibptr->type = FSAFS_NTC_FIB_CONTEXT;
+	if (!fibptr)
+		return NULL;
+
 	fibptr->size = sizeof(struct fib);
-	/*
-	 *	Null out fields that depend on being zero at the start of
-	 *	each I/O
-	 */
-	fibptr->hw_fib_va->header.XferState = 0;
-	fibptr->flags = 0;
-	fibptr->callback = NULL;
-	fibptr->callback_data = NULL;
 
 	return fibptr;
 }
@@ -297,8 +282,15 @@ void aac_fib_free(struct fib *fibptr)
 			 (void*)fibptr,
 			 le32_to_cpu(fibptr->hw_fib_va->header.XferState));
 	}
-	fibptr->next = fibptr->dev->free_fib;
-	fibptr->dev->free_fib = fibptr;
+	if (fibptr->scmd) {
+		struct scsi_cmnd *scmd = fibptr->scmd;
+
+		fibptr->scmd = NULL;
+		if (fibptr->flags & FIB_CONTEXT_FLAG_INTERNAL_CMD) {
+			scsi_put_internal_cmd(scmd);
+			fibptr->flags &= ~FIB_CONTEXT_FLAG_INTERNAL_CMD;
+		}
+	}
 	spin_unlock_irqrestore(&fibptr->dev->fib_lock, flags);
 }
 
@@ -1661,7 +1653,7 @@ int aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 		retval = unblock_retval;
 	if ((forced < 2) && (retval == -ENODEV)) {
 		/* Unwind aac_send_shutdown() IOP_RESET unsupported/disabled */
-		struct fib * fibctx = aac_fib_alloc(aac);
+		struct fib * fibctx = aac_fib_alloc(aac, DMA_NONE);
 		if (fibctx) {
 			struct aac_pause *cmd;
 			int status;
@@ -2288,7 +2280,7 @@ static int aac_send_wellness_command(struct aac_dev *dev, char *wellness_str,
 	int ret = -ENOMEM;
 	u32 vbus, vid;
 
-	fibptr = aac_fib_alloc(dev);
+	fibptr = aac_fib_alloc(dev, DMA_TO_DEVICE);
 	if (!fibptr)
 		goto out;
 
@@ -2386,7 +2378,7 @@ static int aac_send_hosttime(struct aac_dev *dev, struct timespec64 *now)
 	struct fib *fibptr;
 	__le32 *info;
 
-	fibptr = aac_fib_alloc(dev);
+	fibptr = aac_fib_alloc(dev, DMA_TO_DEVICE);
 	if (!fibptr)
 		goto out;
 
diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index a557aa629827..ae88e1d20c7b 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -315,7 +315,7 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 		struct fib *fibctx;
 		struct aac_aifcmd *cmd;
 
-		fibctx = aac_fib_alloc(dev);
+		fibctx = aac_fib_alloc(dev, DMA_FROM_DEVICE);
 		if (!fibctx)
 			return 1;
 		aac_fib_init(fibctx);
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 91cbe479cfa8..9b3d8016e8ef 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -713,7 +713,7 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 			return ret;
 
 		/* start a HBA_TMF_ABORT_TASK TMF request */
-		fib = aac_fib_alloc(aac);
+		fib = aac_fib_alloc(aac, DMA_NONE);
 		if (!fib)
 			return ret;
 
@@ -924,7 +924,7 @@ static int aac_eh_dev_reset(struct scsi_cmnd *cmd)
 	pr_err("%s: Host device reset request. SCSI hang ?\n",
 	       AAC_DRIVERNAME);
 
-	fib = aac_fib_alloc(aac);
+	fib = aac_fib_alloc(aac, DMA_NONE);
 	if (!fib)
 		return ret;
 
@@ -987,7 +987,7 @@ static int aac_eh_target_reset(struct scsi_cmnd *cmd)
 	pr_err("%s: Host target reset request. SCSI hang ?\n",
 	       AAC_DRIVERNAME);
 
-	fib = aac_fib_alloc(aac);
+	fib = aac_fib_alloc(aac, DMA_NONE);
 	if (!fib)
 		return ret;
 
@@ -1698,6 +1698,7 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_cmd_len = 16;
 	shost->max_id = MAXIMUM_NUM_CONTAINERS;
 	shost->max_lun = AAC_MAX_LUN;
+	shost->nr_reserved_cmds = AAC_NUM_MGT_FIB;
 	shost->sg_tablesize = HBA_MAX_SG_SEPARATE;
 
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
@@ -1772,6 +1773,10 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (error)
 		goto out_deinit;
 
+	aac->scsi_host_dev = scsi_get_host_dev(shost);
+	if (!aac->scsi_host_dev)
+		goto out_remove_host;
+
 	aac->maximum_num_channels = aac_drivers[index].channels;
 	error = aac_get_adapter_info(aac);
 	if (error < 0)
@@ -1847,6 +1852,8 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	kfree(aac->queues);
 	aac_adapter_ioremap(aac, 0);
 	kfree(aac->fsa_dev);
+ out_remove_host:
+	scsi_remove_host(shost);
  out_free_fibs:
 	kfree(aac->fibs);
  out_free_host:
-- 
2.16.4

