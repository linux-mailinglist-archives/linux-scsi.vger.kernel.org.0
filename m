Return-Path: <linux-scsi+bounces-17633-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D1BA99A7
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Sep 2025 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CB97A6320
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Sep 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1030ACF3;
	Mon, 29 Sep 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="gOMbSM8A"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071563093B5
	for <linux-scsi@vger.kernel.org>; Mon, 29 Sep 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156521; cv=none; b=cyE/G7kj+xfZ8nfOYLpvf/Xg8EyxjXbY4c+2OFK0m1x2gJynhJ5dgHoeSwzS/+taTblt9UDzq1bLW80DP+tTGC0T/TlwWAfw15B0tRdU0UfnxS8wGDrpP/m5hZPenMIfn32a5Xk5jCRcI5Rfq8Y2aWtRI9LrCxz/9FcrtD6NwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156521; c=relaxed/simple;
	bh=qsn/uVEmelb57+NS9R97B5sSGd+Lw08Is+bY8rj99gM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=na/0qcAJ+axXD0yiLlOGn6ti7tllNOFywpQTjnA00ITIs5K+MTJPlo0m2a24Ech3Twc7q61ZBrOXcfPWR9YsKuZZthII9hTbK0fc7RlYNZi4eIpNKj8r3P8SBuQwSOKc9aDvxhkGVEG0NEqqbHTD/9XsY397kLI1NjdyoKArycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=gOMbSM8A; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id MfOSxCxmcmqb1c3j; Mon, 29 Sep 2025 10:35:16 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=mS97szuR6vAQV7Sg8P25vmVcDpqU7Yzzrh7tBTzthXQ=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=gOMbSM8ASGz3fM80dkBe
	65upqkXufXWTdjSh9yhpxPat6Y2EDleo0kuFR4Grl7SPYLUH9F3wIZsiofX5/0sZzzk0JFImiQWTp
	6nTX9RXOKFW1F5wpJ8Q8vEBemo15scESTsx7wk/8i2nk07az0fpB7sLOjGtfzZE4QCCNvwjiDQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14216617; Mon, 29 Sep 2025 10:35:16 -0400
Message-ID: <089098df-a7a5-454e-bb84-ee443e77d585@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 29 Sep 2025 10:35:16 -0400
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 05/16] scsi: qla2xxx: remove code for unsupported hardware
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v2 05/16] scsi: qla2xxx: remove code for unsupported hardware
From: Tony Battersby <tonyb@cybernetics.com>
To: Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Xose Vazquez Perez <xose.vazquez@gmail.com>
References: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
In-Reply-To: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1759156516
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2719
X-ASG-Debug-ID: 1759156516-1cf43947df3c0230001-ziuLRu

(target mode)

As far as I can tell, CONTINUE_TGT_IO_TYPE and CTIO_A64_TYPE are message
types from non-FWI2 boards (older than ISP24xx), which are not supported
by qla_target.c.  Removing them makes it possible to turn a void * into
the real type and avoid some typecasts.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

v1 -> v2: no changes

 drivers/scsi/qla2xxx/qla_target.c | 32 +++++--------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 1e81582085e3..df5c9aac5617 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3913,7 +3913,8 @@ static void *qlt_ctio_to_cmd(struct scsi_qla_host *vha,
  * ha->hardware_lock supposed to be held on entry. Might drop it, then reaquire
  */
 static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
-    struct rsp_que *rsp, uint32_t handle, uint32_t status, void *ctio)
+	struct rsp_que *rsp, uint32_t handle, uint32_t status,
+	struct ctio7_from_24xx *ctio)
 {
 	struct qla_hw_data *ha = vha->hw;
 	struct se_cmd *se_cmd;
@@ -3934,11 +3935,8 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 	if (cmd == NULL)
 		return;
 
-	if ((le16_to_cpu(((struct ctio7_from_24xx *)ctio)->flags) & CTIO7_FLAGS_DATA_OUT) &&
-	    cmd->sess) {
-		qlt_chk_edif_rx_sa_delete_pending(vha, cmd->sess,
-		    (struct ctio7_from_24xx *)ctio);
-	}
+	if ((le16_to_cpu(ctio->flags) & CTIO7_FLAGS_DATA_OUT) && cmd->sess)
+		qlt_chk_edif_rx_sa_delete_pending(vha, cmd->sess, ctio);
 
 	se_cmd = &cmd->se_cmd;
 	cmd->cmd_sent_to_fw = 0;
@@ -4007,7 +4005,7 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 			    *((u64 *)&crc->actual_dif[0]),
 			    *((u64 *)&crc->expected_dif[0]));
 
-			qlt_handle_dif_error(qpair, cmd, ctio);
+			qlt_handle_dif_error(qpair, cmd, crc);
 			return;
 		}
 
@@ -5816,26 +5814,6 @@ static void qlt_response_pkt(struct scsi_qla_host *vha,
 	}
 	break;
 
-	case CONTINUE_TGT_IO_TYPE:
-	{
-		struct ctio_to_2xxx *entry = (struct ctio_to_2xxx *)pkt;
-
-		qlt_do_ctio_completion(vha, rsp, entry->handle,
-		    le16_to_cpu(entry->status)|(pkt->entry_status << 16),
-		    entry);
-		break;
-	}
-
-	case CTIO_A64_TYPE:
-	{
-		struct ctio_to_2xxx *entry = (struct ctio_to_2xxx *)pkt;
-
-		qlt_do_ctio_completion(vha, rsp, entry->handle,
-		    le16_to_cpu(entry->status)|(pkt->entry_status << 16),
-		    entry);
-		break;
-	}
-
 	case IMMED_NOTIFY_TYPE:
 		ql_dbg(ql_dbg_tgt, vha, 0xe035, "%s", "IMMED_NOTIFY\n");
 		qlt_handle_imm_notify(vha, (struct imm_ntfy_from_isp *)pkt);
-- 
2.43.0



