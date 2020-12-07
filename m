Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24BF2D10DB
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLGMtP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 07:49:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:42006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgLGMtP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 07:49:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71D63ACF9;
        Mon,  7 Dec 2020 12:48:31 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/35] 3w-xxxx: Whitespace cleanup
Date:   Mon,  7 Dec 2020 13:47:46 +0100
Message-Id: <20201207124819.95822-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201207124819.95822-1-hare@suse.de>
References: <20201207124819.95822-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/3w-xxxx.c | 251 ++++++++++++++++++++++++-------------------------
 drivers/scsi/3w-xxxx.h | 199 ++++++++++++++++++++-------------------
 2 files changed, 229 insertions(+), 221 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index fb6444d0409c..d90b9fca4aea 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1,52 +1,52 @@
-/* 
+/*
    3w-xxxx.c -- 3ware Storage Controller device driver for Linux.
 
    Written By: Adam Radford <aradford@gmail.com>
    Modifications By: Joel Jacobson <linux@3ware.com>
-   		     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+                     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
                      Brad Strand <linux@3ware.com>
 
    Copyright (C) 1999-2010 3ware Inc.
 
-   Kernel compatibility By: 	Andre Hedrick <andre@suse.com>
+   Kernel compatibility By:	Andre Hedrick <andre@suse.com>
    Non-Copyright (C) 2000	Andre Hedrick <andre@suse.com>
-   
+
    Further tiny build fixes and trivial hoovering    Alan Cox
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2 of the License.
 
-   This program is distributed in the hope that it will be useful,           
-   but WITHOUT ANY WARRANTY; without even the implied warranty of            
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             
-   GNU General Public License for more details.                              
-
-   NO WARRANTY                                                               
-   THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR        
-   CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT      
-   LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT,      
-   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each Recipient is    
-   solely responsible for determining the appropriateness of using and       
-   distributing the Program and assumes all risks associated with its        
-   exercise of rights under this Agreement, including but not limited to     
-   the risks and costs of program errors, damage to or loss of data,         
-   programs or equipment, and unavailability or interruption of operations.  
-
-   DISCLAIMER OF LIABILITY                                                   
-   NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY FOR ANY   
-   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL        
-   DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER CAUSED AND   
-   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR     
-   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE    
-   USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS GRANTED  
-   HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES             
-
-   You should have received a copy of the GNU General Public License         
-   along with this program; if not, write to the Free Software               
-   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-
-   Bugs/Comments/Suggestions should be mailed to:                            
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   NO WARRANTY
+   THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR
+   CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT
+   LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT,
+   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each Recipient is
+   solely responsible for determining the appropriateness of using and
+   distributing the Program and assumes all risks associated with its
+   exercise of rights under this Agreement, including but not limited to
+   the risks and costs of program errors, damage to or loss of data,
+   programs or equipment, and unavailability or interruption of operations.
+
+   DISCLAIMER OF LIABILITY
+   NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY FOR ANY
+   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+   DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER CAUSED AND
+   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+   USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS GRANTED
+   HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+   Bugs/Comments/Suggestions should be mailed to:
 
    aradford@gmail.com
 
@@ -70,7 +70,7 @@
    1.02.00.003 - Fix tw_interrupt() to report error to scsi layer when
                  controller status is non-zero.
                  Added handling of request_sense opcode.
-                 Fix possible null pointer dereference in 
+		 Fix possible null pointer dereference in
                  tw_reset_device_extension()
    1.02.00.004 - Add support for device id of 3ware 7000 series controllers.
                  Make tw_setfeature() call with interrupts disabled.
@@ -239,7 +239,7 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev);
 /* This function will check the status register for unexpected bits */
 static int tw_check_bits(u32 status_reg_value)
 {
-	if ((status_reg_value & TW_STATUS_EXPECTED_BITS) != TW_STATUS_EXPECTED_BITS) {  
+	if ((status_reg_value & TW_STATUS_EXPECTED_BITS) != TW_STATUS_EXPECTED_BITS) {
 		dprintk(KERN_WARNING "3w-xxxx: tw_check_bits(): No expected bits (0x%x).\n", status_reg_value);
 		return 1;
 	}
@@ -291,7 +291,7 @@ static int tw_decode_bits(TW_Device_Extension *tw_dev, u32 status_reg_value, int
 		}
 		return 1;
 	}
-	
+
 	return 0;
 } /* End tw_decode_bits() */
 
@@ -390,7 +390,7 @@ static int tw_post_command_packet(TW_Device_Extension *tw_dev, int request_id)
 			} else {
 				tw_dev->pending_tail = tw_dev->pending_tail + 1;
 			}
-		} 
+		}
 		TW_UNMASK_COMMAND_INTERRUPT(tw_dev);
 		return 1;
 	}
@@ -403,7 +403,7 @@ static int tw_decode_sense(TW_Device_Extension *tw_dev, int request_id, int fill
 	int i;
 	TW_Command *command;
 
-        dprintk(KERN_WARNING "3w-xxxx: tw_decode_sense()\n");
+	dprintk(KERN_WARNING "3w-xxxx: tw_decode_sense()\n");
 	command = (TW_Command *)tw_dev->command_packet_virtual_address[request_id];
 
 	printk(KERN_WARNING "3w-xxxx: scsi%d: Command failed: status = 0x%x, flags = 0x%x, unit #%d.\n", tw_dev->host->host_no, command->status, command->flags, TW_UNIT_OUT(command->unit__hostid));
@@ -443,10 +443,10 @@ static int tw_decode_sense(TW_Device_Extension *tw_dev, int request_id, int fill
 } /* End tw_decode_sense() */
 
 /* This function will report controller error status */
-static int tw_check_errors(TW_Device_Extension *tw_dev) 
+static int tw_check_errors(TW_Device_Extension *tw_dev)
 {
 	u32 status_reg_value;
-  
+
 	status_reg_value = inl(TW_STATUS_REG_ADDR(tw_dev));
 
 	if (TW_STATUS_ERRORS(status_reg_value) || tw_check_bits(status_reg_value)) {
@@ -458,7 +458,7 @@ static int tw_check_errors(TW_Device_Extension *tw_dev)
 } /* End tw_check_errors() */
 
 /* This function will empty the response que */
-static void tw_empty_response_que(TW_Device_Extension *tw_dev) 
+static void tw_empty_response_que(TW_Device_Extension *tw_dev)
 {
 	u32 status_reg_value, response_que_value;
 
@@ -525,7 +525,7 @@ static ssize_t tw_show_stats(struct device *dev, struct device_attribute *attr,
 /* Create sysfs 'stats' entry */
 static struct device_attribute tw_host_stats_attr = {
 	.attr = {
-		.name = 	"stats",
+		.name =		"stats",
 		.mode =		S_IRUGO,
 	},
 	.show = tw_show_stats
@@ -538,7 +538,7 @@ static struct device_attribute *tw_host_attrs[] = {
 };
 
 /* This function will read the aen queue from the isr */
-static int tw_aen_read_queue(TW_Device_Extension *tw_dev, int request_id) 
+static int tw_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
 {
 	TW_Command *command_packet;
 	TW_Param *param;
@@ -604,7 +604,7 @@ static int tw_aen_read_queue(TW_Device_Extension *tw_dev, int request_id)
 } /* End tw_aen_read_queue() */
 
 /* This function will complete an aen request from the isr */
-static int tw_aen_complete(TW_Device_Extension *tw_dev, int request_id) 
+static int tw_aen_complete(TW_Device_Extension *tw_dev, int request_id)
 {
 	TW_Param *param;
 	unsigned short aen;
@@ -628,7 +628,7 @@ static int tw_aen_complete(TW_Device_Extension *tw_dev, int request_id)
 			if ((tw_aen_string[aen & 0xff][strlen(tw_aen_string[aen & 0xff])-1]) == '#') {
 				printk(KERN_WARNING "3w-xxxx: scsi%d: AEN: %s%d.\n", tw_dev->host->host_no, tw_aen_string[aen & 0xff], aen >> 8);
 			} else {
-				if (aen != 0x0) 
+				if (aen != 0x0)
 					printk(KERN_WARNING "3w-xxxx: scsi%d: AEN: %s.\n", tw_dev->host->host_no, tw_aen_string[aen & 0xff]);
 			}
 		} else {
@@ -746,7 +746,7 @@ static int tw_aen_drain_queue(TW_Device_Extension *tw_dev)
 				printk(KERN_WARNING "3w-xxxx: tw_aen_drain_queue(): Unexpected request id.\n");
 				return 1;
 			}
-			
+
 			if (command_packet->status != 0) {
 				if (command_packet->flags != TW_AEN_TABLE_UNDEFINED) {
 					/* Bad response */
@@ -908,7 +908,7 @@ static long tw_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long a
 
 	/* Hardware can only do multiple of 512 byte transfers */
 	data_buffer_length_adjusted = (data_buffer_length + 511) & ~511;
-	
+
 	/* Now allocate ioctl buf memory */
 	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_New_Ioctl) - 1, &dma_handle, GFP_KERNEL);
 	if (cpu_addr == NULL) {
@@ -1075,7 +1075,7 @@ static void tw_free_device_extension(TW_Device_Extension *tw_dev)
 } /* End tw_free_device_extension() */
 
 /* This function will send an initconnection command to controller */
-static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits) 
+static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits)
 {
 	unsigned long command_que_value;
 	TW_Command  *command_packet;
@@ -1105,10 +1105,10 @@ static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits)
 		printk(KERN_WARNING "3w-xxxx: tw_initconnection(): Bad command packet physical address.\n");
 		return 1;
 	}
-  
+
 	/* Send command packet to the board */
 	outl(command_que_value, TW_COMMAND_QUEUE_REG_ADDR(tw_dev));
-    
+
 	/* Poll for completion */
 	if (tw_poll_status_gone(tw_dev, TW_STATUS_RESPONSE_QUEUE_EMPTY, 30) == 0) {
 		response_queue.value = inl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
@@ -1130,7 +1130,7 @@ static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits)
 
 /* Set a value in the features table */
 static int tw_setfeature(TW_Device_Extension *tw_dev, int parm, int param_size,
-                  unsigned char *val)
+			 unsigned char *val)
 {
 	TW_Param *param;
 	TW_Command  *command_packet;
@@ -1139,7 +1139,7 @@ static int tw_setfeature(TW_Device_Extension *tw_dev, int parm, int param_size,
 	unsigned long command_que_value;
 	unsigned long param_value;
 
-  	/* Initialize SetParam command packet */
+	/* Initialize SetParam command packet */
 	if (tw_dev->command_packet_virtual_address[request_id] == NULL) {
 		printk(KERN_WARNING "3w-xxxx: tw_setfeature(): Bad command packet virtual address.\n");
 		return 1;
@@ -1169,7 +1169,7 @@ static int tw_setfeature(TW_Device_Extension *tw_dev, int parm, int param_size,
 	command_packet->request_id = request_id;
 	command_packet->byte6.parameter_count = 1;
 
-  	command_que_value = tw_dev->command_packet_physical_address[request_id];
+	command_que_value = tw_dev->command_packet_physical_address[request_id];
 	if (command_que_value == 0) {
 		printk(KERN_WARNING "3w-xxxx: tw_setfeature(): Bad command packet physical address.\n");
 		return 1;
@@ -1199,7 +1199,7 @@ static int tw_setfeature(TW_Device_Extension *tw_dev, int parm, int param_size,
 } /* End tw_setfeature() */
 
 /* This function will reset a controller */
-static int tw_reset_sequence(TW_Device_Extension *tw_dev) 
+static int tw_reset_sequence(TW_Device_Extension *tw_dev)
 {
 	int error = 0;
 	int tries = 0;
@@ -1298,7 +1298,7 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev)
 
 	/* Abort all requests that are in progress */
 	for (i=0;i<TW_Q_LENGTH;i++) {
-		if ((tw_dev->state[i] != TW_S_FINISHED) && 
+		if ((tw_dev->state[i] != TW_S_FINISHED) &&
 		    (tw_dev->state[i] != TW_S_INITIAL) &&
 		    (tw_dev->state[i] != TW_S_COMPLETED)) {
 			srb = tw_dev->srb[i];
@@ -1339,11 +1339,11 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev)
 
 /* This funciton returns unit geometry in cylinders/heads/sectors */
 static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev,
-		sector_t capacity, int geom[]) 
+			     sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
 	TW_Device_Extension *tw_dev;
-	
+
 	dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_biosparam()\n");
 	tw_dev = (TW_Device_Extension *)sdev->host->hostdata;
 
@@ -1358,7 +1358,7 @@ static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev
 	}
 
 	dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_biosparam(): heads = %d, sectors = %d, cylinders = %d\n", heads, sectors, cylinders);
-	geom[0] = heads;			 
+	geom[0] = heads;
 	geom[1] = sectors;
 	geom[2] = cylinders;
 
@@ -1366,7 +1366,7 @@ static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev
 } /* End tw_scsi_biosparam() */
 
 /* This is the new scsi eh reset function */
-static int tw_scsi_eh_reset(struct scsi_cmnd *SCpnt) 
+static int tw_scsi_eh_reset(struct scsi_cmnd *SCpnt)
 {
 	TW_Device_Extension *tw_dev=NULL;
 	int retval = FAILED;
@@ -1554,7 +1554,7 @@ static int tw_scsiop_mode_sense(TW_Device_Extension *tw_dev, int request_id)
 
 	/* Now try to post the command packet */
 	tw_post_command_packet(tw_dev, request_id);
-	
+
 	return 0;
 } /* End tw_scsiop_mode_sense() */
 
@@ -1575,16 +1575,16 @@ static int tw_scsiop_mode_sense_complete(TW_Device_Extension *tw_dev, int reques
 	flags = (char *)&(param->data[0]);
 	memset(request_buffer, 0, sizeof(request_buffer));
 
-	request_buffer[0] = 0xf;        /* mode data length */
-	request_buffer[1] = 0;          /* default medium type */
-	request_buffer[2] = 0x10;       /* dpo/fua support on */
-	request_buffer[3] = 0;          /* no block descriptors */
-	request_buffer[4] = 0x8;        /* caching page */
-	request_buffer[5] = 0xa;        /* page length */
+	request_buffer[0] = 0xf;	/* mode data length */
+	request_buffer[1] = 0;		/* default medium type */
+	request_buffer[2] = 0x10;	/* dpo/fua support on */
+	request_buffer[3] = 0;		/* no block descriptors */
+	request_buffer[4] = 0x8;	/* caching page */
+	request_buffer[5] = 0xa;	/* page length */
 	if (*flags & 0x1)
-		request_buffer[6] = 0x5;        /* WCE on, RCD on */
+		request_buffer[6] = 0x5;	/* WCE on, RCD on */
 	else
-		request_buffer[6] = 0x1;        /* WCE off, RCD on */
+		request_buffer[6] = 0x1;	/* WCE off, RCD on */
 	tw_transfer_internal(tw_dev, request_id, request_buffer,
 			     sizeof(request_buffer));
 
@@ -1592,7 +1592,7 @@ static int tw_scsiop_mode_sense_complete(TW_Device_Extension *tw_dev, int reques
 } /* End tw_scsiop_mode_sense_complete() */
 
 /* This function handles scsi read_capacity commands */
-static int tw_scsiop_read_capacity(TW_Device_Extension *tw_dev, int request_id) 
+static int tw_scsiop_read_capacity(TW_Device_Extension *tw_dev, int request_id)
 {
 	TW_Param *param;
 	TW_Command *command_packet;
@@ -1624,8 +1624,8 @@ static int tw_scsiop_read_capacity(TW_Device_Extension *tw_dev, int request_id)
 	}
 	param = (TW_Param *)tw_dev->alignment_virtual_address[request_id];
 	memset(param, 0, sizeof(TW_Sector));
-	param->table_id = TW_UNIT_INFORMATION_TABLE_BASE + 
-	tw_dev->srb[request_id]->device->id;
+	param->table_id = TW_UNIT_INFORMATION_TABLE_BASE +
+		tw_dev->srb[request_id]->device->id;
 	param->parameter_id = 4;	/* unitcapacity parameter */
 	param->parameter_size_bytes = 4;
 	param_value = tw_dev->alignment_physical_address[request_id];
@@ -1633,7 +1633,7 @@ static int tw_scsiop_read_capacity(TW_Device_Extension *tw_dev, int request_id)
 		dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_read_capacity(): Bad alignment physical address.\n");
 		return 1;
 	}
-  
+
 	command_packet->byte8.param.sgl[0].address = param_value;
 	command_packet->byte8.param.sgl[0].length = sizeof(TW_Sector);
 	command_que_value = tw_dev->command_packet_physical_address[request_id];
@@ -1644,7 +1644,7 @@ static int tw_scsiop_read_capacity(TW_Device_Extension *tw_dev, int request_id)
 
 	/* Now try to post the command to the board */
 	tw_post_command_packet(tw_dev, request_id);
-  
+
 	return 0;
 } /* End tw_scsiop_read_capacity() */
 
@@ -1666,7 +1666,7 @@ static int tw_scsiop_read_capacity_complete(TW_Device_Extension *tw_dev, int req
 	}
 	param_data = &(param->data[0]);
 
-	capacity = (param_data[3] << 24) | (param_data[2] << 16) | 
+	capacity = (param_data[3] << 24) | (param_data[2] << 16) |
 		   (param_data[1] << 8) | param_data[0];
 
 	/* Subtract one sector to fix get last sector ioctl */
@@ -1692,7 +1692,7 @@ static int tw_scsiop_read_capacity_complete(TW_Device_Extension *tw_dev, int req
 } /* End tw_scsiop_read_capacity_complete() */
 
 /* This function handles scsi read or write commands */
-static int tw_scsiop_read_write(TW_Device_Extension *tw_dev, int request_id) 
+static int tw_scsiop_read_write(TW_Device_Extension *tw_dev, int request_id)
 {
 	TW_Command *command_packet;
 	unsigned long command_que_value;
@@ -1742,12 +1742,12 @@ static int tw_scsiop_read_write(TW_Device_Extension *tw_dev, int request_id)
 		lba = ((u32)srb->cmnd[2] << 24) | ((u32)srb->cmnd[3] << 16) | ((u32)srb->cmnd[4] << 8) | (u32)srb->cmnd[5];
 		num_sectors = (u32)srb->cmnd[8] | ((u32)srb->cmnd[7] << 8);
 	}
-  
+
 	/* Update sector statistic */
 	tw_dev->sector_count = num_sectors;
 	if (tw_dev->sector_count > tw_dev->max_sector_count)
 		tw_dev->max_sector_count = tw_dev->sector_count;
-  
+
 	dprintk(KERN_NOTICE "3w-xxxx: tw_scsiop_read_write(): lba = 0x%x num_sectors = 0x%x\n", lba, num_sectors);
 	command_packet->byte8.io.lba = lba;
 	command_packet->byte6.block_count = num_sectors;
@@ -1772,7 +1772,7 @@ static int tw_scsiop_read_write(TW_Device_Extension *tw_dev, int request_id)
 		dprintk(KERN_WARNING "3w-xxxx: tw_scsiop_read_write(): Bad command packet physical address.\n");
 		return 1;
 	}
-      
+
 	/* Now try to post the command to the board */
 	tw_post_command_packet(tw_dev, request_id);
 
@@ -1933,7 +1933,7 @@ static int tw_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_c
 
 	/* Save done function into struct scsi_cmnd */
 	SCpnt->scsi_done = done;
-		 
+
 	/* Queue the command and get a request id */
 	tw_state_request_start(tw_dev, &request_id);
 
@@ -1941,48 +1941,47 @@ static int tw_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_c
 	tw_dev->srb[request_id] = SCpnt;
 
 	switch (*command) {
-		case READ_10:
-		case READ_6:
-		case WRITE_10:
-		case WRITE_6:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught READ/WRITE.\n");
-			retval = tw_scsiop_read_write(tw_dev, request_id);
-			break;
-		case TEST_UNIT_READY:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught TEST_UNIT_READY.\n");
-			retval = tw_scsiop_test_unit_ready(tw_dev, request_id);
-			break;
-		case INQUIRY:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught INQUIRY.\n");
-			retval = tw_scsiop_inquiry(tw_dev, request_id);
-			break;
-		case READ_CAPACITY:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught READ_CAPACITY.\n");
-			retval = tw_scsiop_read_capacity(tw_dev, request_id);
-			break;
-	        case REQUEST_SENSE:
-		        dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught REQUEST_SENSE.\n");
-		        retval = tw_scsiop_request_sense(tw_dev, request_id);
-		        break;
-		case MODE_SENSE:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught MODE_SENSE.\n");
-			retval = tw_scsiop_mode_sense(tw_dev, request_id);
-			break;
-		case SYNCHRONIZE_CACHE:
-			dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught SYNCHRONIZE_CACHE.\n");
-			retval = tw_scsiop_synchronize_cache(tw_dev, request_id);
-			break;
-		case TW_IOCTL:
-			printk(KERN_WARNING "3w-xxxx: SCSI_IOCTL_SEND_COMMAND deprecated, please update your 3ware tools.\n");
-			break;
-		default:
-			printk(KERN_NOTICE "3w-xxxx: scsi%d: Unknown scsi opcode: 0x%x\n", tw_dev->host->host_no, *command);
-			tw_dev->state[request_id] = TW_S_COMPLETED;
-			tw_state_request_finish(tw_dev, request_id);
-			SCpnt->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
-			scsi_build_sense_buffer(1, SCpnt->sense_buffer, ILLEGAL_REQUEST, 0x20, 0);
-			done(SCpnt);
-			retval = 0;
+	case READ_10:
+	case READ_6:
+	case WRITE_10:
+	case WRITE_6:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught READ/WRITE.\n");
+		retval = tw_scsiop_read_write(tw_dev, request_id);
+		break;
+	case TEST_UNIT_READY:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught TEST_UNIT_READY.\n");
+		retval = tw_scsiop_test_unit_ready(tw_dev, request_id);
+		break;
+	case INQUIRY:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught INQUIRY.\n");
+		retval = tw_scsiop_inquiry(tw_dev, request_id);
+		break;
+	case READ_CAPACITY:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught READ_CAPACITY.\n");
+		retval = tw_scsiop_read_capacity(tw_dev, request_id);
+		break;
+	case REQUEST_SENSE:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught REQUEST_SENSE.\n");
+		retval = tw_scsiop_request_sense(tw_dev, request_id);
+		break;
+	case MODE_SENSE:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught MODE_SENSE.\n");
+		retval = tw_scsiop_mode_sense(tw_dev, request_id);
+		break;
+	case SYNCHRONIZE_CACHE:
+		dprintk(KERN_NOTICE "3w-xxxx: tw_scsi_queue(): caught SYNCHRONIZE_CACHE.\n");
+		retval = tw_scsiop_synchronize_cache(tw_dev, request_id);
+		break;
+	case TW_IOCTL:
+		printk(KERN_WARNING "3w-xxxx: SCSI_IOCTL_SEND_COMMAND deprecated, please update your 3ware tools.\n");
+		break;
+	default:
+		printk(KERN_NOTICE "3w-xxxx: scsi%d: Unknown scsi opcode: 0x%x\n", tw_dev->host->host_no, *command);
+		tw_dev->state[request_id] = TW_S_COMPLETED;
+		tw_state_request_finish(tw_dev, request_id);
+		scsi_build_sense_buffer(1, SCpnt->sense_buffer, ILLEGAL_REQUEST, 0x20, 0);
+		done(SCpnt);
+		retval = 0;
 	}
 	if (retval) {
 		tw_dev->state[request_id] = TW_S_COMPLETED;
@@ -1997,7 +1996,7 @@ static int tw_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_c
 static DEF_SCSI_QCMD(tw_scsi_queue)
 
 /* This function is the interrupt service routine */
-static irqreturn_t tw_interrupt(int irq, void *dev_instance) 
+static irqreturn_t tw_interrupt(int irq, void *dev_instance)
 {
 	int request_id;
 	u32 status_reg_value;
@@ -2073,7 +2072,7 @@ static irqreturn_t tw_interrupt(int irq, void *dev_instance)
 			}
 		}
 		/* If there are no more pending requests, we mask command interrupt */
-		if (tw_dev->pending_request_count == 0) 
+		if (tw_dev->pending_request_count == 0)
 			TW_MASK_COMMAND_INTERRUPT(tw_dev);
 	}
 
@@ -2174,7 +2173,7 @@ static irqreturn_t tw_interrupt(int irq, void *dev_instance)
 					tw_dev->posted_request_count--;
 				}
 			}
-				
+
 			/* Check for valid status after each drain */
 			status_reg_value = inl(TW_STATUS_REG_ADDR(tw_dev));
 			if (tw_check_bits(status_reg_value)) {
@@ -2244,7 +2243,7 @@ static struct scsi_host_template driver_template = {
 	.this_id		= -1,
 	.sg_tablesize		= TW_MAX_SGL_LENGTH,
 	.max_sectors		= TW_MAX_SECTORS,
-	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,	
+	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,
 	.shost_attrs		= tw_host_attrs,
 	.emulated		= 1,
 	.no_write_same		= 1,
diff --git a/drivers/scsi/3w-xxxx.h b/drivers/scsi/3w-xxxx.h
index bd87fbacfbc7..e8f3f081b7d8 100644
--- a/drivers/scsi/3w-xxxx.h
+++ b/drivers/scsi/3w-xxxx.h
@@ -1,9 +1,9 @@
-/* 
+/*
    3w-xxxx.h -- 3ware Storage Controller device driver for Linux.
-   
+
    Written By: Adam Radford <aradford@gmail.com>
    Modifications By: Joel Jacobson <linux@3ware.com>
-   		     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+                     Arnaldo Carvalho de Melo <acme@conectiva.com.br>
                      Brad Strand <linux@3ware.com>
 
    Copyright (C) 1999-2010 3ware Inc.
@@ -15,39 +15,39 @@
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2 of the License.
 
-   This program is distributed in the hope that it will be useful,           
-   but WITHOUT ANY WARRANTY; without even the implied warranty of            
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             
-   GNU General Public License for more details.                              
-
-   NO WARRANTY                                                               
-   THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR        
-   CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT      
-   LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT,      
-   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each Recipient is    
-   solely responsible for determining the appropriateness of using and       
-   distributing the Program and assumes all risks associated with its        
-   exercise of rights under this Agreement, including but not limited to     
-   the risks and costs of program errors, damage to or loss of data,         
-   programs or equipment, and unavailability or interruption of operations.  
-
-   DISCLAIMER OF LIABILITY                                                   
-   NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY FOR ANY   
-   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL        
-   DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER CAUSED AND   
-   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR     
-   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE    
-   USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS GRANTED  
-   HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES             
-
-   You should have received a copy of the GNU General Public License         
-   along with this program; if not, write to the Free Software               
-   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-
-   Bugs/Comments/Suggestions should be mailed to:                            
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   NO WARRANTY
+   THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR
+   CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT
+   LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT,
+   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each Recipient is
+   solely responsible for determining the appropriateness of using and
+   distributing the Program and assumes all risks associated with its
+   exercise of rights under this Agreement, including but not limited to
+   the risks and costs of program errors, damage to or loss of data,
+   programs or equipment, and unavailability or interruption of operations.
+
+   DISCLAIMER OF LIABILITY
+   NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY FOR ANY
+   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+   DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER CAUSED AND
+   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+   TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+   USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS GRANTED
+   HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+   Bugs/Comments/Suggestions should be mailed to:
 
    aradford@gmail.com
-   
+
    For more information, goto:
    http://www.lsi.com
 */
@@ -99,21 +99,21 @@ static char *tw_aen_string[] = {
 static unsigned char tw_sense_table[][4] =
 {
   /* Codes for newer firmware */
-                            // ATA Error                    SCSI Error
-  {0x01, 0x03, 0x13, 0x00}, // Address mark not found       Address mark not found for data field
-  {0x04, 0x0b, 0x00, 0x00}, // Aborted command              Aborted command
-  {0x10, 0x0b, 0x14, 0x00}, // ID not found                 Recorded entity not found
-  {0x40, 0x03, 0x11, 0x00}, // Uncorrectable ECC error      Unrecovered read error
-  {0x61, 0x04, 0x00, 0x00}, // Device fault                 Hardware error
-  {0x84, 0x0b, 0x47, 0x00}, // Data CRC error               SCSI parity error
-  {0xd0, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
-  {0xd1, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
-  {0x37, 0x02, 0x04, 0x00}, // Unit offline                 Not ready
-  {0x09, 0x02, 0x04, 0x00}, // Unrecovered disk error       Not ready
-
-  /* Codes for older firmware */
-                            // 3ware Error                  SCSI Error
-  {0x51, 0x0b, 0x00, 0x00}  // Unspecified                  Aborted command
+	// ATA Error                    SCSI Error
+	{0x01, 0x03, 0x13, 0x00}, // Address mark not found       Address mark not found for data field
+	{0x04, 0x0b, 0x00, 0x00}, // Aborted command              Aborted command
+	{0x10, 0x0b, 0x14, 0x00}, // ID not found                 Recorded entity not found
+	{0x40, 0x03, 0x11, 0x00}, // Uncorrectable ECC error      Unrecovered read error
+	{0x61, 0x04, 0x00, 0x00}, // Device fault                 Hardware error
+	{0x84, 0x0b, 0x47, 0x00}, // Data CRC error               SCSI parity error
+	{0xd0, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
+	{0xd1, 0x0b, 0x00, 0x00}, // Device busy                  Aborted command
+	{0x37, 0x02, 0x04, 0x00}, // Unit offline                 Not ready
+	{0x09, 0x02, 0x04, 0x00}, // Unrecovered disk error       Not ready
+
+	/* Codes for older firmware */
+	// 3ware Error                  SCSI Error
+	{0x51, 0x0b, 0x00, 0x00}  // Unspecified                  Aborted command
 };
 
 /* Control register bit definitions */
@@ -128,9 +128,9 @@ static unsigned char tw_sense_table[][4] =
 #define TW_CONTROL_ENABLE_INTERRUPTS	       0x00000080
 #define TW_CONTROL_DISABLE_INTERRUPTS	       0x00000040
 #define TW_CONTROL_ISSUE_HOST_INTERRUPT	       0x00000020
-#define TW_CONTROL_CLEAR_PARITY_ERROR          0x00800000
-#define TW_CONTROL_CLEAR_QUEUE_ERROR           0x00400000
-#define TW_CONTROL_CLEAR_PCI_ABORT             0x00100000
+#define TW_CONTROL_CLEAR_PARITY_ERROR	       0x00800000
+#define TW_CONTROL_CLEAR_QUEUE_ERROR	       0x00400000
+#define TW_CONTROL_CLEAR_PCI_ABORT	       0x00100000
 #define TW_CONTROL_CLEAR_SBUF_WRITE_ERROR      0x00000008
 
 /* Status register bit definitions */
@@ -152,8 +152,8 @@ static unsigned char tw_sense_table[][4] =
 #define TW_STATUS_CLEARABLE_BITS	       0x00D00000
 #define TW_STATUS_EXPECTED_BITS		       0x00002000
 #define TW_STATUS_UNEXPECTED_BITS	       0x00F00008
-#define TW_STATUS_SBUF_WRITE_ERROR             0x00000008
-#define TW_STATUS_VALID_INTERRUPT              0x00DF0008
+#define TW_STATUS_SBUF_WRITE_ERROR	       0x00000008
+#define TW_STATUS_VALID_INTERRUPT	       0x00DF0008
 
 /* RESPONSE QUEUE BIT DEFINITIONS */
 #define TW_RESPONSE_ID_MASK		       0x00000FF0
@@ -179,33 +179,33 @@ static unsigned char tw_sense_table[][4] =
 #define TW_OP_SECTOR_INFO     0x1a
 #define TW_OP_AEN_LISTEN      0x1c
 #define TW_OP_FLUSH_CACHE     0x0e
-#define TW_CMD_PACKET         0x1d
+#define TW_CMD_PACKET	      0x1d
 #define TW_CMD_PACKET_WITH_DATA 0x1f
 
 /* Asynchronous Event Notification (AEN) Codes */
 #define TW_AEN_QUEUE_EMPTY       0x0000
-#define TW_AEN_SOFT_RESET        0x0001
+#define TW_AEN_SOFT_RESET	 0x0001
 #define TW_AEN_DEGRADED_MIRROR   0x0002
 #define TW_AEN_CONTROLLER_ERROR  0x0003
 #define TW_AEN_REBUILD_FAIL      0x0004
 #define TW_AEN_REBUILD_DONE      0x0005
-#define TW_AEN_QUEUE_FULL        0x00ff
+#define TW_AEN_QUEUE_FULL	 0x00ff
 #define TW_AEN_TABLE_UNDEFINED   0x15
 #define TW_AEN_APORT_TIMEOUT     0x0009
 #define TW_AEN_DRIVE_ERROR       0x000A
-#define TW_AEN_SMART_FAIL        0x000F
-#define TW_AEN_SBUF_FAIL         0x0024
+#define TW_AEN_SMART_FAIL	 0x000F
+#define TW_AEN_SBUF_FAIL	 0x0024
 
 /* Misc defines */
 #define TW_ALIGNMENT_6000		      64 /* 64 bytes */
-#define TW_ALIGNMENT_7000                     4  /* 4 bytes */
+#define TW_ALIGNMENT_7000		      4  /* 4 bytes */
 #define TW_MAX_UNITS			      16
 #define TW_COMMAND_ALIGNMENT_MASK	      0x1ff
 #define TW_INIT_MESSAGE_CREDITS		      0x100
 #define TW_INIT_COMMAND_PACKET_SIZE	      0x3
-#define TW_POLL_MAX_RETRIES        	      20000
+#define TW_POLL_MAX_RETRIES		      20000
 #define TW_MAX_SGL_LENGTH		      62
-#define TW_ATA_PASS_SGL_MAX                   60
+#define TW_ATA_PASS_SGL_MAX		      60
 #define TW_Q_LENGTH			      256
 #define TW_Q_START			      0
 #define TW_MAX_SLOT			      32
@@ -216,20 +216,20 @@ static unsigned char tw_sense_table[][4] =
                                                      chrdev ioctl, one for
                                                      internal aen post */
 #define TW_BLOCK_SIZE			      0x200 /* 512-byte blocks */
-#define TW_IOCTL                              0x80
-#define TW_UNIT_ONLINE                        1
-#define TW_IN_INTR                            1
-#define TW_IN_RESET                           2
-#define TW_IN_CHRDEV_IOCTL                    3
-#define TW_MAX_SECTORS                        256
+#define TW_IOCTL			      0x80
+#define TW_UNIT_ONLINE			      1
+#define TW_IN_INTR			      1
+#define TW_IN_RESET			      2
+#define TW_IN_CHRDEV_IOCTL		      3
+#define TW_MAX_SECTORS			      256
 #define TW_MAX_IOCTL_SECTORS		      512
-#define TW_AEN_WAIT_TIME                      1000
-#define TW_IOCTL_WAIT_TIME                    (1 * HZ) /* 1 second */
-#define TW_ISR_DONT_COMPLETE                  2
-#define TW_ISR_DONT_RESULT                    3
-#define TW_IOCTL_TIMEOUT                      25 /* 25 seconds */
-#define TW_IOCTL_CHRDEV_TIMEOUT               60 /* 60 seconds */
-#define TW_IOCTL_CHRDEV_FREE                  -1
+#define TW_AEN_WAIT_TIME		      1000
+#define TW_IOCTL_WAIT_TIME		      (1 * HZ) /* 1 second */
+#define TW_ISR_DONT_COMPLETE		      2
+#define TW_ISR_DONT_RESULT		      3
+#define TW_IOCTL_TIMEOUT		      25 /* 25 seconds */
+#define TW_IOCTL_CHRDEV_TIMEOUT		      60 /* 60 seconds */
+#define TW_IOCTL_CHRDEV_FREE		      -1
 #define TW_MAX_CDB_LEN			      16
 
 /* Bitmask macros to eliminate bitfields */
@@ -250,26 +250,35 @@ static unsigned char tw_sense_table[][4] =
 #define TW_STATUS_REG_ADDR(x) (x->base_addr + 0x4)
 #define TW_COMMAND_QUEUE_REG_ADDR(x) (x->base_addr + 0x8)
 #define TW_RESPONSE_QUEUE_REG_ADDR(x) (x->base_addr + 0xC)
-#define TW_CLEAR_ALL_INTERRUPTS(x) (outl(TW_STATUS_VALID_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
-#define TW_CLEAR_ATTENTION_INTERRUPT(x) (outl(TW_CONTROL_CLEAR_ATTENTION_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
-#define TW_CLEAR_HOST_INTERRUPT(x) (outl(TW_CONTROL_CLEAR_HOST_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
-#define TW_DISABLE_INTERRUPTS(x) (outl(TW_CONTROL_DISABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
-#define TW_ENABLE_AND_CLEAR_INTERRUPTS(x) (outl(TW_CONTROL_CLEAR_ATTENTION_INTERRUPT | TW_CONTROL_UNMASK_RESPONSE_INTERRUPT | TW_CONTROL_ENABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
-#define TW_MASK_COMMAND_INTERRUPT(x) (outl(TW_CONTROL_MASK_COMMAND_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
-#define TW_UNMASK_COMMAND_INTERRUPT(x) (outl(TW_CONTROL_UNMASK_COMMAND_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
-#define TW_SOFT_RESET(x) (outl(TW_CONTROL_ISSUE_SOFT_RESET | \
-			TW_CONTROL_CLEAR_HOST_INTERRUPT | \
-			TW_CONTROL_CLEAR_ATTENTION_INTERRUPT | \
-			TW_CONTROL_MASK_COMMAND_INTERRUPT | \
-			TW_CONTROL_MASK_RESPONSE_INTERRUPT | \
-			TW_CONTROL_CLEAR_ERROR_STATUS | \
-			TW_CONTROL_DISABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
-#define TW_STATUS_ERRORS(x) \
-	(((x & TW_STATUS_PCI_ABORT) || \
-	(x & TW_STATUS_PCI_PARITY_ERROR) || \
-	(x & TW_STATUS_QUEUE_ERROR) || \
-	(x & TW_STATUS_MICROCONTROLLER_ERROR)) && \
-	(x & TW_STATUS_MICROCONTROLLER_READY))
+#define TW_CLEAR_ALL_INTERRUPTS(x)					\
+	(outl(TW_STATUS_VALID_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
+#define TW_CLEAR_ATTENTION_INTERRUPT(x)					\
+	(outl(TW_CONTROL_CLEAR_ATTENTION_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
+#define TW_CLEAR_HOST_INTERRUPT(x)					\
+	(outl(TW_CONTROL_CLEAR_HOST_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
+#define TW_DISABLE_INTERRUPTS(x)					\
+	(outl(TW_CONTROL_DISABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
+#define TW_ENABLE_AND_CLEAR_INTERRUPTS(x)				\
+	(outl(TW_CONTROL_CLEAR_ATTENTION_INTERRUPT |			\
+	      TW_CONTROL_UNMASK_RESPONSE_INTERRUPT |			\
+	      TW_CONTROL_ENABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
+#define TW_MASK_COMMAND_INTERRUPT(x)					\
+	(outl(TW_CONTROL_MASK_COMMAND_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
+#define TW_UNMASK_COMMAND_INTERRUPT(x)					\
+	(outl(TW_CONTROL_UNMASK_COMMAND_INTERRUPT, TW_CONTROL_REG_ADDR(x)))
+#define TW_SOFT_RESET(x) (outl(TW_CONTROL_ISSUE_SOFT_RESET |		\
+			       TW_CONTROL_CLEAR_HOST_INTERRUPT |	\
+			       TW_CONTROL_CLEAR_ATTENTION_INTERRUPT |	\
+			       TW_CONTROL_MASK_COMMAND_INTERRUPT |	\
+			       TW_CONTROL_MASK_RESPONSE_INTERRUPT |	\
+			       TW_CONTROL_CLEAR_ERROR_STATUS |		\
+			       TW_CONTROL_DISABLE_INTERRUPTS, TW_CONTROL_REG_ADDR(x)))
+#define TW_STATUS_ERRORS(x)				\
+	(((x & TW_STATUS_PCI_ABORT) ||			\
+	  (x & TW_STATUS_PCI_PARITY_ERROR) ||		\
+	  (x & TW_STATUS_QUEUE_ERROR) ||		\
+	  (x & TW_STATUS_MICROCONTROLLER_ERROR)) &&	\
+	 (x & TW_STATUS_MICROCONTROLLER_READY))
 
 #ifdef TW_DEBUG
 #define dprintk(msg...) printk(msg)
-- 
2.16.4

