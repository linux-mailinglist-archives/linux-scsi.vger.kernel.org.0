Return-Path: <linux-scsi+bounces-25978-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4qoCBAVGUWq+BgMAu9opvQ
	(envelope-from <linux-scsi+bounces-25978-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:20:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2473DAE6
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:20:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=bFMnNejA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25978-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25978-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DCA3032041
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F138757D;
	Fri, 10 Jul 2026 19:16:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F24383318;
	Fri, 10 Jul 2026 19:16:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711018; cv=none; b=OWtdW0EDK17h9SfLehyNmK3CwpgerDhVMMC0Hr71yvPTxctfmMj/QsCVMee19H0MGjGM5eEmMnqv4e11aRrratKKN0bZnzVT+MULnYhucafDWYyKIDa+GFjAgeYeR72Hk4gzv0rjZGMLpBSh/cy/h9NaUmTCaSg+0zpvlA/620g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711018; c=relaxed/simple;
	bh=TGyZgCVxY7zCWMJhLl/6htn+DkBY8VNoc8ZMkzpRyBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWTK0jeswQqRIwEB4A1fB32BNL4bAN9AZWbuVw8zW7A97uhY5rrh6LV/3h10moqZqAH1CiwllxXWt2dd/UQbiZ612ugyHoWg1OVNNK5h4B5X0Ct8ZWMemb/e1+prY5KhSyks11gHiCM34C2o4qnZjj2tjGX+exlVc5uOLO8XhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFMnNejA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE802C2BCFB;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783711017;
	bh=TGyZgCVxY7zCWMJhLl/6htn+DkBY8VNoc8ZMkzpRyBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bFMnNejAJht2t5eyztZygG41CckDK464ZrB2nlSbi5fHfMm+5xWbB0zve0F727KD0
	 05mSC7fkQXgfKnL4aNTkne0SHmAUEOmNNPhXk9GEMD3wLxEuMllLkOMhpC0R3NhD+r
	 sNf3Xec4P9ER4zaOY946hxWD56WeeJ6+w8MZVgl5yPpnclXqtFXYFWVQ4xn9KZ1xjh
	 cqh6d55SMtSNlMZPavSRVwp9UM/L76GkaaKWeqgNY1P/WFQ3RH1ewAJb4OnY+KOirV
	 5dS99LItP5YKbNqYqEauXqXlxMDtCcDN+PSB+zXpdEJMIDwfK1RP2HOpc6eFuY7/h4
	 sUQgg9hi3yS5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D23C43458;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Fri, 10 Jul 2026 14:16:45 -0500
Subject: [PATCH v4 5/8] ibmvfc: allocate asynchronous sub-queue
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-ibmvfc-fpin-support-v4-5-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783711016; l=3317;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=rBhgYJ2t1uiM0cxoYETJDBMpf2C9qi2TrIr+jFCPyOo=;
 b=PTTbtttGusvoi9hV+KxMJoAo6D2KQ9TbW26oq2WCfpA5E5An/pJCL9kAUuhRdQluT30am0Rsb
 l4dQwNx1snrDsgoIxD4z+TTsgC48OTfjxHv/o6XIRK6qA/EYcCT64R7
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tyreld@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@linux.ibm.com,m:gjoyce@linux.ibm.com,m:kmahlkuc@linux.ibm.com,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[HansenPartnership.com,oracle.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25978-lists,linux-scsi=lfdr.de,davemarq.linux.ibm.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[davemarq@linux.ibm.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34B2473DAE6

From: Dave Marquardt <davemarq@linux.ibm.com>

Allocate and initialize the asynchronous sub-queue required for receiving
full and extended FPIN events from VIOS.

Modify ibmvfc_alloc_channels() to allocate async_scrq using
ibmvfc_alloc_queue() with IBMVFC_SUB_CRQ_FMT format. Update error
handling to properly clean up async_scrq on allocation failures.

Update ibmvfc_channel_setup() to pass async_subq_handle to VIOS during
channel setup, and ibmvfc_channel_setup_done() to store the VIOS cookie
for the async sub-queue.

Modify ibmvfc_release_channels() to free async_scrq resources during
cleanup.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index c95e78d729ed..586847ff3336 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -5375,6 +5375,9 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
 			for (i = 0; i < active_queues; i++)
 				scrqs->scrqs[i].vios_cookie =
 					be64_to_cpu(setup->channel_handles[i]);
+			if (scrqs->async_scrq)
+				scrqs->async_scrq->vios_cookie =
+					be64_to_cpu(setup->async_subq_handle);
 
 			ibmvfc_dbg(vhost, "Using %u channels\n",
 				   vhost->scsi_scrqs.active_queues);
@@ -5425,6 +5428,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 		setup_buf->num_scsi_subq_channels = cpu_to_be32(num_channels);
 		for (i = 0; i < num_channels; i++)
 			setup_buf->channel_handles[i] = cpu_to_be64(scrqs->scrqs[i].cookie);
+		setup_buf->async_subq_handle = cpu_to_be64(scrqs->async_scrq->cookie);
 	}
 
 	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
@@ -6392,6 +6396,17 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 	if (!channels->scrqs)
 		return -ENOMEM;
 
+	channels->async_scrq = kzalloc_obj(*channels->async_scrq, GFP_KERNEL);
+	if (!channels->async_scrq) {
+		rc = -ENOMEM;
+		goto free_scrqs;
+	}
+
+	rc = ibmvfc_alloc_queue(vhost, channels->async_scrq,
+				IBMVFC_SUB_CRQ_FMT);
+	if (rc)
+		goto free_async;
+
 	for (i = 0; i < channels->max_queues; i++) {
 		scrq = &channels->scrqs[i];
 		rc = ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT);
@@ -6400,13 +6415,21 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
 				scrq = &channels->scrqs[j - 1];
 				ibmvfc_free_queue(vhost, scrq);
 			}
-			kfree(channels->scrqs);
-			channels->scrqs = NULL;
+			ibmvfc_free_queue(vhost, channels->async_scrq);
 			channels->active_queues = 0;
-			return rc;
+			goto free_async;
 		}
 	}
 
+	return rc;
+
+free_async:
+	kfree(channels->async_scrq);
+	channels->async_scrq = NULL;
+free_scrqs:
+	kfree(channels->scrqs);
+	channels->scrqs = NULL;
+
 	return rc;
 }
 
@@ -6441,8 +6464,15 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
 
 		kfree(channels->scrqs);
 		channels->scrqs = NULL;
+
 		channels->active_queues = 0;
 	}
+
+	if (channels->async_scrq) {
+		ibmvfc_free_queue(vhost, channels->async_scrq);
+		kfree(channels->async_scrq);
+		channels->async_scrq = NULL;
+	}
 }
 
 static void ibmvfc_release_sub_crqs(struct ibmvfc_host *vhost)

-- 
2.55.0



