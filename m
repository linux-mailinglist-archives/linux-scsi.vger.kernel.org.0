Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A32B3C2F46
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Jul 2021 04:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGJCbD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 22:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234344AbhGJC3X (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 9 Jul 2021 22:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E9861441;
        Sat, 10 Jul 2021 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625883948;
        bh=YqEKOD+jbFI2SPkTCsG8hHcld8NPo8tsmJX1Z8hqID4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cECSv5uig8b0K58gWeMMhx24CFUx1kB9Jrbx0kiBocVNkJpFFSxkhQdFmJZ29e154
         XC8uvTCbnwkxqnwVM8lZ/h/tdmkyFA0Q5vyj1zW/x8Ry5Gpu6Jy5LIS1pb7+E4NnNO
         6m0C/MFGLI1n4g0b2P2Eaiv93w8YY48AV/qO89Vy6IvWND3ryuZtXpjFCnq//WdVaz
         hg7Qjt63a3DZ1ODF7oBdrULCT2vfIwIU2w1XW9IhYRrUyr+4b24Cu+HOrdYDfSkAJw
         6mye+jd4gYMCDiDP85qwMB3F/Tb7nswpg1oxuMytXjj3nJyUpH1xm4fkL5YNsZ8+pf
         PEHC6QUGv8IdA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 61/93] scsi: storvsc: Correctly handle multiple flags in srb_status
Date:   Fri,  9 Jul 2021 22:23:55 -0400
Message-Id: <20210710022428.3169839-61-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 52e1b3b3daa9d53f0204bf474ee1d4b1beb38234 ]

Hyper-V is observed to sometimes set multiple flags in the srb_status, such
as ABORTED and ERROR. Current code in storvsc_handle_error() handles only a
single flag being set, and does nothing when multiple flags are set.  Fix
this by changing the case statement into a series of "if" statements
testing individual flags. The functionality for handling each flag is
unchanged.

Link: https://lore.kernel.org/r/1622827263-12516-3-git-send-email-mikelley@microsoft.com
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ded00a89bfc4..0ee0b80006e0 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -994,17 +994,40 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	struct storvsc_scan_work *wrk;
 	void (*process_err_fn)(struct work_struct *work);
 	struct hv_host_device *host_dev = shost_priv(host);
-	bool do_work = false;
 
-	switch (SRB_STATUS(vm_srb->srb_status)) {
-	case SRB_STATUS_ERROR:
+	/*
+	 * In some situations, Hyper-V sets multiple bits in the
+	 * srb_status, such as ABORTED and ERROR. So process them
+	 * individually, with the most specific bits first.
+	 */
+
+	if (vm_srb->srb_status & SRB_STATUS_INVALID_LUN) {
+		set_host_byte(scmnd, DID_NO_CONNECT);
+		process_err_fn = storvsc_remove_lun;
+		goto do_work;
+	}
+
+	if (vm_srb->srb_status & SRB_STATUS_ABORTED) {
+		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
+		    /* Capacity data has changed */
+		    (asc == 0x2a) && (ascq == 0x9)) {
+			process_err_fn = storvsc_device_scan;
+			/*
+			 * Retry the I/O that triggered this.
+			 */
+			set_host_byte(scmnd, DID_REQUEUE);
+			goto do_work;
+		}
+	}
+
+	if (vm_srb->srb_status & SRB_STATUS_ERROR) {
 		/*
 		 * Let upper layer deal with error when
 		 * sense message is present.
 		 */
-
 		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID)
-			break;
+			return;
+
 		/*
 		 * If there is an error; offline the device since all
 		 * error recovery strategies would have already been
@@ -1017,37 +1040,19 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 			set_host_byte(scmnd, DID_PASSTHROUGH);
 			break;
 		/*
-		 * On Some Windows hosts TEST_UNIT_READY command can return
-		 * SRB_STATUS_ERROR, let the upper level code deal with it
-		 * based on the sense information.
+		 * On some Hyper-V hosts TEST_UNIT_READY command can
+		 * return SRB_STATUS_ERROR. Let the upper level code
+		 * deal with it based on the sense information.
 		 */
 		case TEST_UNIT_READY:
 			break;
 		default:
 			set_host_byte(scmnd, DID_ERROR);
 		}
-		break;
-	case SRB_STATUS_INVALID_LUN:
-		set_host_byte(scmnd, DID_NO_CONNECT);
-		do_work = true;
-		process_err_fn = storvsc_remove_lun;
-		break;
-	case SRB_STATUS_ABORTED:
-		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
-		    (asc == 0x2a) && (ascq == 0x9)) {
-			do_work = true;
-			process_err_fn = storvsc_device_scan;
-			/*
-			 * Retry the I/O that triggered this.
-			 */
-			set_host_byte(scmnd, DID_REQUEUE);
-		}
-		break;
 	}
+	return;
 
-	if (!do_work)
-		return;
-
+do_work:
 	/*
 	 * We need to schedule work to process this error; schedule it.
 	 */
-- 
2.30.2

