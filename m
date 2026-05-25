Return-Path: <linux-scsi+bounces-24076-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBnDDn/xE2puHwcAu9opvQ
	(envelope-from <linux-scsi+bounces-24076-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 08:51:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBDF5C6C2D
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 08:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A43463004596
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA873AB5C3;
	Mon, 25 May 2026 06:51:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351B3AA4F9;
	Mon, 25 May 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691897; cv=none; b=BCvGQML46s5lag3w6+04BXTJ86so0phn98dY22Mv73ju/9qjTiIW86NbKpABThtPGeUivQQsw4CuquKfBREv5kUObbtAOzMUOd9Pa3k+nzR3pIPwfoDf3sUpQXvIwtdWxHl/U1S1E80TBEPMWmz6LJry1SBwSEftHV4w0YhRmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691897; c=relaxed/simple;
	bh=EroAbV2+K6nD+tWzKn4I/ywlaw5hpXOwNC8HfcJF1xE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYooZc6uVGb2xEQlRKK611Z5SR8zmod2ihsoatbUaCO4rfA7AYd2k0aAxsEOHL2CpKcxwHLIq/p5lhgSBTsOJKHNArU8WL6IODKCKdIfZpxvelLuF4L171YZliYmzkZpKOXSH0rNzBnmQ+4kTNoGZP6tIJKthaERHF974UbfSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch02.asrmicro.com (exch02.asrmicro.com [10.1.24.122])
	by spam.asrmicro.com with ESMTPS id 64P6jrPq037373
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Mon, 25 May 2026 14:45:53 +0800 (GMT-8)
	(envelope-from hongjiefang@asrmicro.com)
Received: from localhost (10.1.170.248) by exch02.asrmicro.com (10.1.24.122)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 25 May 2026 14:45:56
 +0800
From: Hongjie Fang <hongjiefang@asrmicro.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
        <jgarzik@redhat.com>, <stern@rowland.harvard.edu>,
        <ming.m.lin@intel.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] scsi: core: pair EH runtime PM get/put
Date: Mon, 25 May 2026 14:45:56 +0800
Message-ID: <20260525064556.1277177-1-hongjiefang@asrmicro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch03.asrmicro.com (10.1.24.118) To exch02.asrmicro.com
 (10.1.24.122)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 64P6jrPq037373
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24076-lists,linux-scsi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[asrmicro.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongjiefang@asrmicro.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.713];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ACBDF5C6C2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

shost->eh_noresume is currently consulted twice in one error handling
iteration: once before scsi_autopm_get_host() and once again before
scsi_autopm_put_host().

That is racy when a PM-triggered error path flips shost->eh_noresume while
the SCSI EH thread is still running.

The problem flow looks like this:
PM path
  ufshcd_set_dev_pwr_mode()
    shost->eh_noresume = 1
    ufshcd_execute_start_stop  <-- trigger EH
    ...
    shost->eh_noresume = 0

EH path
  scsi_error_handler()
    if (!shost->eh_noresume)
      scsi_autopm_get_host()  <-- skipped
    ...
    if (!shost->eh_noresume)
       scsi_autopm_put_host()  <-- executed later

In that case one EH iteration can skip autoresume on entry and still drop
a runtime PM reference on exit. That leaves an unmatched runtime PM put
and can trigger a runtime PM usage count underflow.

Fix this by calling scsi_autopm_put_host() only if the same iteration
successfully acquired a runtime PM reference through the
scsi_autopm_get_host().

Fixes: ae0751ffc77e ("[SCSI] add flag to skip the runtime PM calls on the host")
Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/scsi/scsi_error.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 147127fb4db9..faa5cc818e5b 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2342,6 +2342,7 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = data;
+	bool autopm_get;
 
 	/*
 	 * We use TASK_INTERRUPTIBLE so that the thread is not
@@ -2383,12 +2384,16 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (!shost->eh_noresume && scsi_autopm_get_host(shost) != 0) {
-			SCSI_LOG_ERROR_RECOVERY(1,
-				shost_printk(KERN_ERR, shost,
-					     "scsi_eh_%d: unable to autoresume\n",
-					     shost->host_no));
-			continue;
+		autopm_get = false;
+		if (!shost->eh_noresume) {
+			if (scsi_autopm_get_host(shost) != 0) {
+				SCSI_LOG_ERROR_RECOVERY(1,
+					shost_printk(KERN_ERR, shost,
+						     "scsi_eh_%d: unable to autoresume\n",
+						     shost->host_no));
+				continue;
+			}
+			autopm_get = true;
 		}
 
 		if (shost->transportt->eh_strategy_handler)
@@ -2407,7 +2412,7 @@ int scsi_error_handler(void *data)
 		 * which are still online.
 		 */
 		scsi_restart_operations(shost);
-		if (!shost->eh_noresume)
+		if (autopm_get)
 			scsi_autopm_put_host(shost);
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.25.1


