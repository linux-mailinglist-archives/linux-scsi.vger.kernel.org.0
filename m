Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39653486D2
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFQPSb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 11:18:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32931 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPSb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 11:18:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so5876265pfq.0
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 08:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+MKUUj69ETXmnzh4N6h+VZvivosQHlAwM0q9HI0Gwo=;
        b=aKj4LgOHwbCw01kuGr0h5fdaQx8BKgNmhqXbHchEL5ToMD+NM6JllU751kjWechC69
         9ZbCrmdZJvVI9G8vQGhh8RmNqLwo/FShGm0/om/BI84nHktFTfp6IYt3JfMGXalcll0p
         pe55GPp3/mgtDZ860skK2MsS6YndIwdqWlzhHD26TweQKZm1TTS8fAqqxluYZDsWUdpj
         Gzzm+Hu4kkp13ZDNKXJ327IJzU/Kn1TYfsqqYLJKAV6TblDNjpuT266JLwYeGwhpvIev
         MCrGElk/UTpgdMh63gy7/ZNKml0FEER90/3SSJQE7AtGRAH/upOhNYsVzYZSTHv71aM1
         buJQ==
X-Gm-Message-State: APjAAAWeuw+iXrFkAJXfctczPmgVat0nGsqdf2irdEu2v3yPr4R4u5Ey
        eIRgLT6Dl+LBZRzdJ6W6jjo=
X-Google-Smtp-Source: APXvYqwsvjO/rAFItUBZKgMd/TIJPIpNJ9HiOLy30Jk94lc7JsxIMzv6EnKLE6Oj6ByL45d0R3G4jw==
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr88074948pfd.113.1560784710463;
        Mon, 17 Jun 2019 08:18:30 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n5sm12529949pgd.26.2019.06.17.08.18.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:18:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 2/3] scsi: Avoid that .queuecommand() gets called for a blocked SCSI device
Date:   Mon, 17 Jun 2019 08:18:19 -0700
Message-Id: <20190617151820.241583-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617151820.241583-1-bvanassche@acm.org>
References: <20190617151820.241583-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Several SCSI transport and LLD drivers surround code that does not
tolerate concurrent calls of .queuecommand() with scsi_target_block() /
scsi_target_unblock(). These last two functions use
blk_mq_quiesce_queue() / blk_mq_unquiesce_queue() for scsi-mq request
queues to prevent concurrent .queuecommand() calls. However, that is
not sufficient to prevent .queuecommand() calls from scsi_send_eh_cmnd().
Hence surround the .queuecommand() call from the SCSI error handler with
code that avoids that .queuecommand() gets called in the blocked state.

Note: converting the .queuecommand() call in scsi_send_eh_cmnd() into
code that calls blk_get_request() + blk_execute_rq() is not an option
since scsi_send_eh_cmnd() must be able to make forward progress even
if all requests have been allocated.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 26 ++++++++++++++++++++++++--
 drivers/scsi/scsi_lib.c   |  4 ----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8e9680572b9f..d516dd1b824d 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1054,7 +1054,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	DECLARE_COMPLETION_ONSTACK(done);
-	unsigned long timeleft = timeout;
+	unsigned long timeleft = timeout, delay;
 	struct scsi_eh_save ses;
 	const unsigned long stall_for = msecs_to_jiffies(100);
 	int rtn;
@@ -1065,7 +1065,29 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 
 	scsi_log_send(scmd);
 	scmd->scsi_done = scsi_eh_done;
-	rtn = shost->hostt->queuecommand(shost, scmd);
+
+	/*
+	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
+	 * change the SCSI device state after we have examined it and before
+	 * .queuecommand() is called.
+	 */
+	mutex_lock(&sdev->state_mutex);
+	while (sdev->sdev_state == SDEV_BLOCK && timeleft > 0) {
+		mutex_unlock(&sdev->state_mutex);
+		SCSI_LOG_ERROR_RECOVERY(5, sdev_printk(KERN_DEBUG, sdev,
+			"%s: state %d <> %d\n", __func__, sdev->sdev_state,
+			SDEV_BLOCK));
+		delay = min(timeleft, stall_for);
+		timeleft -= delay;
+		msleep(jiffies_to_msecs(delay));
+		mutex_lock(&sdev->state_mutex);
+	}
+	if (sdev->sdev_state != SDEV_BLOCK)
+		rtn = shost->hostt->queuecommand(shost, scmd);
+	else
+		rtn = SCSI_MLQUEUE_DEVICE_BUSY;
+	mutex_unlock(&sdev->state_mutex);
+
 	if (rtn) {
 		if (timeleft > stall_for) {
 			scsi_eh_restore_cmnd(scmd, &ses);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b4a63e4fcf73..ec5b4b5bc011 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2632,10 +2632,6 @@ EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
  * a legal transition). When the device is in this state, command processing
  * is paused until the device leaves the SDEV_BLOCK state. See also
  * scsi_internal_device_unblock().
- *
- * To do: avoid that scsi_send_eh_cmnd() calls queuecommand() after
- * scsi_internal_device_block() has blocked a SCSI device and also
- * remove the rport mutex lock and unlock calls from srp_queuecommand().
  */
 static int scsi_internal_device_block(struct scsi_device *sdev)
 {
-- 
2.22.0.rc3

