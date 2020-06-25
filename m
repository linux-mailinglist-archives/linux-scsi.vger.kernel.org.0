Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3484F20A07D
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2020 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405323AbgFYOB5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 10:01:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:41454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405314AbgFYOBy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A9B6AFAE;
        Thu, 25 Jun 2020 14:01:46 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 20/22] aacraid: store target id in host_scribble
Date:   Thu, 25 Jun 2020 16:01:22 +0200
Message-Id: <20200625140124.17201-21-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200625140124.17201-1-hare@suse.de>
References: <20200625140124.17201-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The probe_container mechanism requires a target id to be present,
even if the device itself isn't present (yet).
As we're now allocating internal commands the target id of the
device is immutable, so store the requested target id in the
host_scribble field.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aacraid/aachba.c | 53 +++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 2b868f8db8ff..e1ba5e65a66f 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -608,9 +608,11 @@ static int aac_get_container_name(struct scsi_cmnd * scsicmd)
 
 static int aac_probe_container_callback2(struct scsi_cmnd * scsicmd)
 {
-	struct fsa_dev_info *fsa_dev_ptr = ((struct aac_dev *)(scsicmd->device->host->hostdata))->fsa_dev;
+	struct aac_dev *dev = (struct aac_dev *)(scsicmd->device->host->hostdata);
+	struct fsa_dev_info *fsa_dev_ptr = dev->fsa_dev;
 
-	if ((fsa_dev_ptr[scmd_id(scsicmd)].valid & 1))
+	if (scmd_id(scsicmd) < dev->maximum_num_containers &&
+	    (fsa_dev_ptr[scmd_id(scsicmd)].valid & 1))
 		return aac_scsi_cmd(scsicmd);
 
 	scsicmd->result = DID_NO_CONNECT << 16;
@@ -623,6 +625,7 @@ static void _aac_probe_container2(void * context, struct fib * fibptr)
 	struct fsa_dev_info *fsa_dev_ptr;
 	int (*callback)(struct scsi_cmnd *);
 	struct scsi_cmnd * scsicmd = (struct scsi_cmnd *)context;
+	int cid = scmd_id(scsicmd);
 	int i;
 
 
@@ -630,12 +633,15 @@ static void _aac_probe_container2(void * context, struct fib * fibptr)
 		return;
 
 	scsicmd->SCp.Status = 0;
+	if (scsicmd->host_scribble)
+		cid = *(int *)scsicmd->host_scribble;
+
 	fsa_dev_ptr = fibptr->dev->fsa_dev;
-	if (fsa_dev_ptr) {
+	if (fsa_dev_ptr && cid < fibptr->dev->maximum_num_containers) {
 		struct aac_mount * dresp = (struct aac_mount *) fib_data(fibptr);
 		__le32 sup_options2;
 
-		fsa_dev_ptr += scmd_id(scsicmd);
+		fsa_dev_ptr += cid;
 		sup_options2 =
 			fibptr->dev->supplement_adapter_info.supported_options2;
 
@@ -670,7 +676,6 @@ static void _aac_probe_container2(void * context, struct fib * fibptr)
 		scsicmd->SCp.Status = le32_to_cpu(dresp->count);
 	}
 	aac_fib_complete(fibptr);
-	aac_fib_free(fibptr);
 	callback = (int (*)(struct scsi_cmnd *))(scsicmd->SCp.ptr);
 	scsicmd->SCp.ptr = NULL;
 	(*callback)(scsicmd);
@@ -682,6 +687,7 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 	struct scsi_cmnd * scsicmd;
 	struct aac_mount * dresp;
 	struct aac_query_mount *dinfo;
+	int cid;
 	int status;
 
 	dresp = (struct aac_mount *) fib_data(fibptr);
@@ -694,10 +700,15 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 		}
 	}
 	scsicmd = (struct scsi_cmnd *) context;
-
 	if (!aac_valid_context(scsicmd, fibptr))
 		return;
-
+	cid = scmd_id(scsicmd);
+	if (scsicmd->host_scribble)
+		cid = *(int *)scsicmd->host_scribble;
+	if (cid >= fibptr->dev->maximum_num_containers) {
+		_aac_probe_container2(context, fibptr);
+		return;
+	}
 	aac_fib_init(fibptr);
 
 	dinfo = (struct aac_query_mount *)fib_data(fibptr);
@@ -708,7 +719,7 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 	else
 		dinfo->command = cpu_to_le32(VM_NameServe64);
 
-	dinfo->count = cpu_to_le32(scmd_id(scsicmd));
+	dinfo->count = cpu_to_le32(cid);
 	dinfo->type = cpu_to_le32(FT_FILESYS);
 	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
 
@@ -731,10 +742,20 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 
 static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(struct scsi_cmnd *))
 {
+	struct aac_dev * dev;
 	struct fib * fibptr;
 	int status = -ENOMEM;
+	int cid = scmd_id(scsicmd);
 
-	if ((fibptr = aac_fib_alloc((struct aac_dev *)scsicmd->device->host->hostdata))) {
+	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
+	if (scsicmd->host_scribble) {
+		cid = *(int *)scsicmd->host_scribble;
+		if (cid > dev->maximum_num_containers) {
+			status = -ENODEV;
+			goto out_status;
+		}
+	}
+	if ((fibptr = aac_fib_alloc(dev))) {
 		struct aac_query_mount *dinfo;
 
 		aac_fib_init(fibptr);
@@ -747,7 +768,7 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 		else
 			dinfo->command = cpu_to_le32(VM_NameServe);
 
-		dinfo->count = cpu_to_le32(scmd_id(scsicmd));
+		dinfo->count = cpu_to_le32(cid);
 		dinfo->type = cpu_to_le32(FT_FILESYS);
 		scsicmd->SCp.ptr = (char *)callback;
 		scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
@@ -771,10 +792,11 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 			aac_fib_free(fibptr);
 		}
 	}
+out_status:
 	if (status < 0) {
-		struct fsa_dev_info *fsa_dev_ptr = ((struct aac_dev *)(scsicmd->device->host->hostdata))->fsa_dev;
-		if (fsa_dev_ptr) {
-			fsa_dev_ptr += scmd_id(scsicmd);
+		struct fsa_dev_info *fsa_dev_ptr = dev->fsa_dev;
+		if (fsa_dev_ptr && cid < dev->maximum_num_containers) {
+			fsa_dev_ptr += cid;
 			if ((fsa_dev_ptr->valid & 1) == 0) {
 				fsa_dev_ptr->valid = 0;
 				return (*callback)(scsicmd);
@@ -794,7 +816,7 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
  */
 static int aac_probe_container_callback1(struct scsi_cmnd * scsicmd)
 {
-	scsicmd->device = NULL;
+	scsicmd->host_scribble = NULL;
 	return 0;
 }
 
@@ -815,6 +837,7 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 		return -ENOMEM;
 	}
 	scsicmd->scsi_done = aac_probe_container_scsi_done;
+	scsicmd->host_scribble = (unsigned char *)&cid;
 
 	scsicmd->device = scsidev;
 	scsidev->sdev_state = 0;
@@ -822,7 +845,7 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 	scsidev->host = dev->scsi_host_ptr;
 
 	if (_aac_probe_container(scsicmd, aac_probe_container_callback1) == 0)
-		while (scsicmd->device == scsidev)
+		while (scsicmd->host_scribble == (unsigned char *)&cid)
 			schedule();
 	kfree(scsidev);
 	status = scsicmd->SCp.Status;
-- 
2.16.4

