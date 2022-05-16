Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E9528DEA
	for <lists+linux-scsi@lfdr.de>; Mon, 16 May 2022 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiEPTah (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 May 2022 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiEPTag (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 May 2022 15:30:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1FA72B19C;
        Mon, 16 May 2022 12:30:35 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50DDE2059B8C;
        Mon, 16 May 2022 12:30:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50DDE2059B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652729435;
        bh=UQoBJ+fH+NTekp9sLy4jS7GcT1MEHynj3FjrVDNijA0=;
        h=From:To:Subject:Date:From;
        b=NTBe1Wl9bKyVr+4sHlUBvllX+pdqQr0JayAWfBKQojZ1WyK3GXczsFgyfvB/sVzJK
         yMdPf2Ql8+Ihx0o3LRhKrjotO2+hqc7jR5M46/RAe0/eofCWHGnIUD3t0y6sq8rGT+
         Cy1DLllbk3+J/jp1+Ru4av5r1FTgwa5Rl+0cOjEU=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Removing Pre Win8 related logic
Date:   Mon, 16 May 2022 12:30:30 -0700
Message-Id: <1652729430-12632-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The latest storvsc code has already removed the support for windows 7 and
earlier. There is still some code logic reamining which is there to support
pre Windows 8 OS. This patch removes these stale logic.
This patch majorly does three things :

1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct is
same for all the OS post windows 8 there is no need of delta.
2. Simplify sense_buffer_size logic, as there is single buffer size for
all the post windows 8 OS.
3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
as there is no separate handling required for different OS.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 135 +++++++++----------------------------
 1 file changed, 33 insertions(+), 102 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5585e9d30bbf..1b7808e91f0b 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -137,18 +137,16 @@ struct hv_fc_wwn_packet {
 #define STORVSC_MAX_CMD_LEN			0x10
 
 #define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
-#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
 
 #define STORVSC_SENSE_BUFFER_SIZE		0x14
 #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
 
 /*
- * Sense buffer size changed in win8; have a run-time
- * variable to track the size we should use.  This value will
- * likely change during protocol negotiation but it is valid
- * to start by assuming pre-Win8.
+ * Sense buffer size was differnt pre win8 but those OS are not supported any
+ * more starting 5.19 kernel. This results in to supporting a single value from
+ * win8 onwards.
  */
-static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
+static int sense_buffer_size = POST_WIN7_STORVSC_SENSE_BUFFER_SIZE;
 
 /*
  * The storage protocol version is determined during the
@@ -177,18 +175,6 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
-struct vmscsi_win8_extension {
-	/*
-	 * The following were added in Windows 8
-	 */
-	u16 reserve;
-	u8  queue_tag;
-	u8  queue_action;
-	u32 srb_flags;
-	u32 time_out_value;
-	u32 queue_sort_ey;
-} __packed;
-
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -214,46 +200,23 @@ struct vmscsi_request {
 	/*
 	 * The following was added in win8.
 	 */
-	struct vmscsi_win8_extension win8_extension;
+	u16 reserve;
+	u8  queue_tag;
+	u8  queue_action;
+	u32 srb_flags;
+	u32 time_out_value;
+	u32 queue_sort_ey;
 
 } __attribute((packed));
 
 /*
- * The list of storage protocols in order of preference.
+ * The list of windows version in order of preference.
  */
-struct vmstor_protocol {
-	int protocol_version;
-	int sense_buffer_size;
-	int vmscsi_size_delta;
-};
 
-
-static const struct vmstor_protocol vmstor_protocols[] = {
-	{
+static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
 		VMSTOR_PROTO_VERSION_WIN8,
-		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
-		0
-	},
-	{
-		VMSTOR_PROTO_VERSION_WIN7,
-		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
-		sizeof(struct vmscsi_win8_extension),
-	},
-	{
-		VMSTOR_PROTO_VERSION_WIN6,
-		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
-		sizeof(struct vmscsi_win8_extension),
-	}
 };
 
 
@@ -409,9 +372,7 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_IDE_MAX_CHANNELS			1
 
 /*
- * Upper bound on the size of a storvsc packet. vmscsi_size_delta is not
- * included in the calculation because it is set after STORVSC_MAX_PKT_SIZE
- * is used in storvsc_connect_to_vsp
+ * Upper bound on the size of a storvsc packet.
  */
 #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
 			      sizeof(struct vstor_packet))
@@ -452,17 +413,6 @@ struct storvsc_device {
 	unsigned char path_id;
 	unsigned char target_id;
 
-	/*
-	 * The size of the vmscsi_request has changed in win8. The
-	 * additional size is because of new elements added to the
-	 * structure. These elements are valid only when we are talking
-	 * to a win8 host.
-	 * Track the correction to size we need to apply. This value
-	 * will likely change during protocol negotiation but it is
-	 * valid to start by assuming pre-Win8.
-	 */
-	int vmscsi_size_delta;
-
 	/*
 	 * Max I/O, the device can support.
 	 */
@@ -795,8 +745,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 	vstor_packet->sub_channel_count = num_sc;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-			       stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_INIT,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -864,8 +813,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-			       stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_INIT,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -915,14 +863,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	 * Query host supported protocol version.
 	 */
 
-	for (i = 0; i < ARRAY_SIZE(vmstor_protocols); i++) {
+	for (i = 0; i < ARRAY_SIZE(protocol_version); i++) {
 		/* reuse the packet for version range supported */
 		memset(vstor_packet, 0, sizeof(struct vstor_packet));
 		vstor_packet->operation =
 			VSTOR_OPERATION_QUERY_PROTOCOL_VERSION;
 
-		vstor_packet->version.major_minor =
-			vmstor_protocols[i].protocol_version;
+		vstor_packet->version.major_minor = protocol_version[i];
 
 		/*
 		 * The revision number is only used in Windows; set it to 0.
@@ -936,14 +883,7 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 			return -EINVAL;
 
 		if (vstor_packet->status == 0) {
-			vmstor_proto_version =
-				vmstor_protocols[i].protocol_version;
-
-			sense_buffer_size =
-				vmstor_protocols[i].sense_buffer_size;
-
-			stor_device->vmscsi_size_delta =
-				vmstor_protocols[i].vmscsi_size_delta;
+			vmstor_proto_version = protocol_version[i];
 
 			break;
 		}
@@ -1289,8 +1229,8 @@ static void storvsc_on_channel_callback(void *context)
 		struct storvsc_cmd_request *request = NULL;
 		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
-		u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
-			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
+		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
+			sizeof(enum vstor_packet_operation);
 
 		if (pktlen < minlen) {
 			dev_err(&device->device,
@@ -1346,7 +1286,7 @@ static void storvsc_on_channel_callback(void *context)
 		}
 
 		memcpy(&request->vstor_packet, packet,
-		       (sizeof(struct vstor_packet) - stor_device->vmscsi_size_delta));
+		       sizeof(struct vstor_packet));
 		complete(&request->wait_event);
 	}
 }
@@ -1557,8 +1497,7 @@ static int storvsc_do_io(struct hv_device *device,
 found_channel:
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
-	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
-					stor_device->vmscsi_size_delta);
+	vstor_packet->vm_srb.length = sizeof(struct vmscsi_request);
 
 
 	vstor_packet->vm_srb.sense_info_length = sense_buffer_size;
@@ -1574,13 +1513,11 @@ static int storvsc_do_io(struct hv_device *device,
 		ret = vmbus_sendpacket_mpb_desc(outgoing_channel,
 				request->payload, request->payload_sz,
 				vstor_packet,
-				(sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+				sizeof(struct vstor_packet),
 				(unsigned long)request);
 	} else {
 		ret = vmbus_sendpacket(outgoing_channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       (unsigned long)request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1684,8 +1621,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	vstor_packet->vm_srb.path_id = stor_device->path_id;
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       (sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta),
+			       sizeof(struct vstor_packet),
 			       VMBUS_RQST_RESET,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1778,31 +1714,31 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
 	vm_srb = &cmd_request->vstor_packet.vm_srb;
-	vm_srb->win8_extension.time_out_value = 60;
+	vm_srb->time_out_value = 60;
 
-	vm_srb->win8_extension.srb_flags |=
+	vm_srb->srb_flags |=
 		SRB_FLAGS_DISABLE_SYNCH_TRANSFER;
 
 	if (scmnd->device->tagged_supported) {
-		vm_srb->win8_extension.srb_flags |=
+		vm_srb->srb_flags |=
 		(SRB_FLAGS_QUEUE_ACTION_ENABLE | SRB_FLAGS_NO_QUEUE_FREEZE);
-		vm_srb->win8_extension.queue_tag = SP_UNTAGGED;
-		vm_srb->win8_extension.queue_action = SRB_SIMPLE_TAG_REQUEST;
+		vm_srb->queue_tag = SP_UNTAGGED;
+		vm_srb->queue_action = SRB_SIMPLE_TAG_REQUEST;
 	}
 
 	/* Build the SRB */
 	switch (scmnd->sc_data_direction) {
 	case DMA_TO_DEVICE:
 		vm_srb->data_in = WRITE_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_OUT;
+		vm_srb->srb_flags |= SRB_FLAGS_DATA_OUT;
 		break;
 	case DMA_FROM_DEVICE:
 		vm_srb->data_in = READ_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_DATA_IN;
+		vm_srb->srb_flags |= SRB_FLAGS_DATA_IN;
 		break;
 	case DMA_NONE:
 		vm_srb->data_in = UNKNOWN_TYPE;
-		vm_srb->win8_extension.srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
+		vm_srb->srb_flags |= SRB_FLAGS_NO_DATA_TRANSFER;
 		break;
 	default:
 		/*
@@ -2004,7 +1940,6 @@ static int storvsc_probe(struct hv_device *device,
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	stor_device->host = host;
-	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
 	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
 	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
@@ -2217,10 +2152,6 @@ static int __init storvsc_drv_init(void)
 	 * than the ring buffer size since that page is reserved for
 	 * the ring buffer indices) by the max request size (which is
 	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
-	 *
-	 * The computation underestimates max_outstanding_req_per_channel
-	 * for Win7 and older hosts because it does not take into account
-	 * the vmscsi_size_delta correction to the max request size.
 	 */
 	max_outstanding_req_per_channel =
 		((storvsc_ringbuffer_size - PAGE_SIZE) /
-- 
2.25.1

