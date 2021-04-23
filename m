Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51443368E15
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbhDWHpo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 03:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhDWHpl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 03:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619163905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxE3g/673hvNobBi6amgMMILqwARppFiqLOrUj6cBpk=;
        b=cDAaThAVasOUIlCsVZnXaT1B7FgbIWpcKal1tsD+1yuTCxB5ZtuHZiCsENTJ4GyPoG4xFp
        6idJsjP49OVkserG9zyuH5eEwHzC9WTywq8JS6t7pBO5zLtWuiwqRWeH4OanW8RhX1/d4l
        GmW/6yzxUldvMZKXgqbTzf1kCOdTCgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-NFp0Z5x5Osy8oP4_wHGOlA-1; Fri, 23 Apr 2021 03:45:03 -0400
X-MC-Unique: NFp0Z5x5Osy8oP4_wHGOlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B9118189C6;
        Fri, 23 Apr 2021 07:44:49 +0000 (UTC)
Received: from localhost (ovpn-13-161.pek2.redhat.com [10.72.13.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCA0A5D9C6;
        Fri, 23 Apr 2021 07:44:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
        Ming Lei <ming.lei@redhat.com>,
        Satish Kharat <satishkh@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH V2 5/5] scsi: fnic: use scsi_host_busy_iter in fnic_is_abts_pending
Date:   Fri, 23 Apr 2021 15:43:48 +0800
Message-Id: <20210423074348.2255671-6-ming.lei@redhat.com>
In-Reply-To: <20210423074348.2255671-1-ming.lei@redhat.com>
References: <20210423074348.2255671-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

So far, scsi_host_find_tag() is supposed to use in fast path and the
passed tag should be active.

Convert the scsi command walking into scsi_host_busy_iter(), which has
been one common pattern for handling failure.

Cc: Satish Kharat <satishkh@cisco.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 93 ++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 7cb4f1a5e2d5..7d57d2eb6308 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2808,58 +2808,69 @@ void fnic_exch_mgr_reset(struct fc_lport *lp, u32 sid, u32 did)
 
 }
 
-/*
- * fnic_is_abts_pending() is a helper function that
- * walks through tag map to check if there is any IOs pending,if there is one,
- * then it returns 1 (true), otherwise 0 (false)
- * if @lr_sc is non NULL, then it checks IOs specific to particular LUN,
- * otherwise, it checks for all IOs.
- */
-int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
+struct fnic_is_abts_pending_data {
+	struct scsi_cmnd *lr_sc;
+	int ret;
+};
+
+static bool __fnic_is_abts_pending(struct scsi_cmnd *sc, void *data, bool rsvd)
 {
-	int tag;
+	struct fnic_is_abts_pending_data *pdata = data;
 	struct fnic_io_req *io_req;
 	spinlock_t *io_lock;
 	unsigned long flags;
-	int ret = 0;
-	struct scsi_cmnd *sc;
 	struct scsi_device *lun_dev = NULL;
+	struct fc_lport *lp = shost_priv(sc->device->host);
+	struct fnic *fnic = lport_priv(lp);
 
-	if (lr_sc)
-		lun_dev = lr_sc->device;
+	if (pdata->lr_sc)
+		lun_dev = pdata->lr_sc->device;
 
-	/* walk again to check, if IOs are still pending in fw */
-	for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
-		sc = scsi_host_find_tag(fnic->lport->host, tag);
-		/*
-		 * ignore this lun reset cmd or cmds that do not belong to
-		 * this lun
-		 */
-		if (!sc || (lr_sc && (sc->device != lun_dev || sc == lr_sc)))
-			continue;
+	/*
+	 * ignore this lun reset cmd or cmds that do not belong to
+	 * this lun
+	 */
+	if (!sc || (pdata->lr_sc && (sc->device != lun_dev ||
+					sc == pdata->lr_sc)))
+		return true;
 
-		io_lock = fnic_io_lock_hash(fnic, sc);
-		spin_lock_irqsave(io_lock, flags);
+	io_lock = fnic_io_lock_hash(fnic, sc);
+	spin_lock_irqsave(io_lock, flags);
 
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
 
-		if (!io_req || sc->device != lun_dev) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	if (!io_req || sc->device != lun_dev)
+		goto unlock;
 
-		/*
-		 * Found IO that is still pending with firmware and
-		 * belongs to the LUN that we are resetting
-		 */
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-			      "Found IO in %s on lun\n",
-			      fnic_ioreq_state_to_str(CMD_STATE(sc)));
+	/*
+	 * Found IO that is still pending with firmware and
+	 * belongs to the LUN that we are resetting
+	 */
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+		      "Found IO in %s on lun\n",
+		      fnic_ioreq_state_to_str(CMD_STATE(sc)));
 
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-			ret = 1;
-		spin_unlock_irqrestore(io_lock, flags);
-	}
+	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
+		pdata->ret = 1;
+ unlock:
+	spin_unlock_irqrestore(io_lock, flags);
+	return true;
+}
 
-	return ret;
+/*
+ * fnic_is_abts_pending() is a helper function that
+ * walks through tag map to check if there is any IOs pending,if there is one,
+ * then it returns 1 (true), otherwise 0 (false)
+ * if @lr_sc is non NULL, then it checks IOs specific to particular LUN,
+ * otherwise, it checks for all IOs.
+ */
+int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
+{
+	struct fnic_is_abts_pending_data data = {
+		.lr_sc	=	lr_sc,
+		.ret	=	0,
+	};
+
+	scsi_host_busy_iter(fnic->lport->host, __fnic_is_abts_pending, &data);
+	return data.ret;
 }
-- 
2.29.2

