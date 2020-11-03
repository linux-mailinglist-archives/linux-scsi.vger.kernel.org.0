Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799F02A386D
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Nov 2020 02:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgKCBTO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 20:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgKCBTO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Nov 2020 20:19:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42641222B9;
        Tue,  3 Nov 2020 01:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366353;
        bh=c6strdFNX862Wnk98EAR6chwxrm6G0VD8w8sw8l1sco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0Gs89KRtAc3dUGYjgXOtZMs5MY5p/ATkWoQVWZWFY8VsHtnk9ZdqoaAk6Ww7Q5D+
         jJbiMkDZP8gs+QWXvWECHF1Px3+B3vPQyh6Ahgx3bkunRyXg7rZAd+F5w6ESAzuGVX
         GPblKuRoWGrM1Sp31O9W69EjGux1XNhR+ytsT4lU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.9 24/35] scsi: ibmvscsi: Fix potential race after loss of transport
Date:   Mon,  2 Nov 2020 20:18:29 -0500
Message-Id: <20201103011840.182814-24-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011840.182814-1-sashal@kernel.org>
References: <20201103011840.182814-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 665e0224a3d76f36da40bd9012270fa629aa42ed ]

After a loss of transport due to an adapter migration or crash/disconnect
from the host partner there is a tiny window where we can race adjusting
the request_limit of the adapter. The request limit is atomically
increased/decreased to track the number of inflight requests against the
allowed limit of our VIOS partner.

After a transport loss we set the request_limit to zero to reflect this
state.  However, there is a window where the adapter may attempt to queue a
command because the transport loss event hasn't been fully processed yet
and request_limit is still greater than zero.  The hypercall to send the
event will fail and the error path will increment the request_limit as a
result.  If the adapter processes the transport event prior to this
increment the request_limit becomes out of sync with the adapter state and
can result in SCSI commands being submitted on the now reset connection
prior to an SRP Login resulting in a protocol violation.

Fix this race by protecting request_limit with the host lock when changing
the value via atomic_set() to indicate no transport.

Link: https://lore.kernel.org/r/20201025001355.4527-1-tyreld@linux.ibm.com
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 36 +++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index b1f3017b6547a..29fcc44be2d57 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -806,6 +806,22 @@ static void purge_requests(struct ibmvscsi_host_data *hostdata, int error_code)
 	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 }
 
+/**
+ * ibmvscsi_set_request_limit - Set the adapter request_limit in response to
+ * an adapter failure, reset, or SRP Login. Done under host lock to prevent
+ * race with SCSI command submission.
+ * @hostdata:	adapter to adjust
+ * @limit:	new request limit
+ */
+static void ibmvscsi_set_request_limit(struct ibmvscsi_host_data *hostdata, int limit)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
+	atomic_set(&hostdata->request_limit, limit);
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+}
+
 /**
  * ibmvscsi_reset_host - Reset the connection to the server
  * @hostdata:	struct ibmvscsi_host_data to reset
@@ -813,7 +829,7 @@ static void purge_requests(struct ibmvscsi_host_data *hostdata, int error_code)
 static void ibmvscsi_reset_host(struct ibmvscsi_host_data *hostdata)
 {
 	scsi_block_requests(hostdata->host);
-	atomic_set(&hostdata->request_limit, 0);
+	ibmvscsi_set_request_limit(hostdata, 0);
 
 	purge_requests(hostdata, DID_ERROR);
 	hostdata->action = IBMVSCSI_HOST_ACTION_RESET;
@@ -1146,13 +1162,13 @@ static void login_rsp(struct srp_event_struct *evt_struct)
 		dev_info(hostdata->dev, "SRP_LOGIN_REJ reason %u\n",
 			 evt_struct->xfer_iu->srp.login_rej.reason);
 		/* Login failed.  */
-		atomic_set(&hostdata->request_limit, -1);
+		ibmvscsi_set_request_limit(hostdata, -1);
 		return;
 	default:
 		dev_err(hostdata->dev, "Invalid login response typecode 0x%02x!\n",
 			evt_struct->xfer_iu->srp.login_rsp.opcode);
 		/* Login failed.  */
-		atomic_set(&hostdata->request_limit, -1);
+		ibmvscsi_set_request_limit(hostdata, -1);
 		return;
 	}
 
@@ -1163,7 +1179,7 @@ static void login_rsp(struct srp_event_struct *evt_struct)
 	 * This value is set rather than added to request_limit because
 	 * request_limit could have been set to -1 by this client.
 	 */
-	atomic_set(&hostdata->request_limit,
+	ibmvscsi_set_request_limit(hostdata,
 		   be32_to_cpu(evt_struct->xfer_iu->srp.login_rsp.req_lim_delta));
 
 	/* If we had any pending I/Os, kick them */
@@ -1195,13 +1211,13 @@ static int send_srp_login(struct ibmvscsi_host_data *hostdata)
 	login->req_buf_fmt = cpu_to_be16(SRP_BUF_FORMAT_DIRECT |
 					 SRP_BUF_FORMAT_INDIRECT);
 
-	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	/* Start out with a request limit of 0, since this is negotiated in
 	 * the login request we are just sending and login requests always
 	 * get sent by the driver regardless of request_limit.
 	 */
-	atomic_set(&hostdata->request_limit, 0);
+	ibmvscsi_set_request_limit(hostdata, 0);
 
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	rc = ibmvscsi_send_srp_event(evt_struct, hostdata, login_timeout * 2);
 	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 	dev_info(hostdata->dev, "sent SRP login\n");
@@ -1781,7 +1797,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 		return;
 	case VIOSRP_CRQ_XPORT_EVENT:	/* Hypervisor telling us the connection is closed */
 		scsi_block_requests(hostdata->host);
-		atomic_set(&hostdata->request_limit, 0);
+		ibmvscsi_set_request_limit(hostdata, 0);
 		if (crq->format == 0x06) {
 			/* We need to re-setup the interpartition connection */
 			dev_info(hostdata->dev, "Re-enabling adapter!\n");
@@ -2137,12 +2153,12 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 	}
 
 	hostdata->action = IBMVSCSI_HOST_ACTION_NONE;
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 
 	if (rc) {
-		atomic_set(&hostdata->request_limit, -1);
+		ibmvscsi_set_request_limit(hostdata, -1);
 		dev_err(hostdata->dev, "error after %s\n", action);
 	}
-	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 
 	scsi_unblock_requests(hostdata->host);
 }
@@ -2226,7 +2242,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	init_waitqueue_head(&hostdata->work_wait_q);
 	hostdata->host = host;
 	hostdata->dev = dev;
-	atomic_set(&hostdata->request_limit, -1);
+	ibmvscsi_set_request_limit(hostdata, -1);
 	hostdata->host->max_sectors = IBMVSCSI_MAX_SECTORS_DEFAULT;
 
 	if (map_persist_bufs(hostdata)) {
-- 
2.27.0

