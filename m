Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07932A38F3
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Nov 2020 02:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgKCBVU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 20:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgKCBVP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Nov 2020 20:21:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615172242F;
        Tue,  3 Nov 2020 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366474;
        bh=SCX2Bvt7RIbKtlNwma4O1ggwwDDo9Fw7byanKlpDy2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5RIcgeZT2yTAkzXN52lZ5uCyFLIz3uPDUcOx4xQRYWLKos0nZc4X06BdFS7+o0ci
         yF1xkKndLoKriW7yUwtUxm6blqtr2O4hx+rAk1VQyaV0t/zNP3HiKm4lVaybPuA2LW
         AmYH0kFb719pHbGFLCTWdi3lFXhwSZt4mKd2XlBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 4/7] scsi: core: Don't start concurrent async scan on same host
Date:   Mon,  2 Nov 2020 20:21:05 -0500
Message-Id: <20201103012108.183942-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103012108.183942-1-sashal@kernel.org>
References: <20201103012108.183942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 831e3405c2a344018a18fcc2665acc5a38c3a707 ]

The current scanning mechanism is supposed to fall back to a synchronous
host scan if an asynchronous scan is in progress. However, this rule isn't
strictly respected, scsi_prep_async_scan() doesn't hold scan_mutex when
checking shost->async_scan. When scsi_scan_host() is called concurrently,
two async scans on same host can be started and a hang in do_scan_async()
is observed.

Fixes this issue by checking & setting shost->async_scan atomically with
shost->scan_mutex.

Link: https://lore.kernel.org/r/20201010032539.426615-1-ming.lei@redhat.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 67f6f134abc44..397deb69c6595 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1734,15 +1734,16 @@ static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
  */
 static struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
 {
-	struct async_scan_data *data;
+	struct async_scan_data *data = NULL;
 	unsigned long flags;
 
 	if (strncmp(scsi_scan_type, "sync", 4) == 0)
 		return NULL;
 
+	mutex_lock(&shost->scan_mutex);
 	if (shost->async_scan) {
 		shost_printk(KERN_DEBUG, shost, "%s called twice\n", __func__);
-		return NULL;
+		goto err;
 	}
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
@@ -1753,7 +1754,6 @@ static struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
 		goto err;
 	init_completion(&data->prev_finished);
 
-	mutex_lock(&shost->scan_mutex);
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->async_scan = 1;
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -1768,6 +1768,7 @@ static struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
 	return data;
 
  err:
+	mutex_unlock(&shost->scan_mutex);
 	kfree(data);
 	return NULL;
 }
-- 
2.27.0

