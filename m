Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCDB3652F
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFEUOq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 16:14:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32814 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEUOq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 16:14:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so10114011plq.0
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 13:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2xcP3+srpIJOPIE+RfP1Whw18wv/tP9VDiA3Wch55U=;
        b=LF+tBIokMlwXiHyI1ldFeBMrpiU+49lhcX/l3EIBMPq4lIsdlP7mk/Qdv87Evimenn
         Uksco26+Vf+WkXZ6bv3QGF52GvENhO+gJ19d0OeC1iHA3yZmqfR50q0rBXCiQ1uqjOV2
         TkljMH/xZ9lHo/pyvQ7MhRgDS6w1DJEn1gHih1UdRcEqfxgkYF4SBek8eWzpH0DV0gKp
         yEZsNpaolymQ+S7T2HKDWPWu8YKmgsFcOm9fhPOSK77v2+VzpTHUG7bkggmh1F+CLGm2
         4LUGptqo9H3CLrgu+zoVS+2h96tZfna8/Hr9EUKQA5CVygbQDg8lm8QmlaxTpqIZNy2G
         joMA==
X-Gm-Message-State: APjAAAWJIq6IvROvpJhWyPLXgp3Yq9lf2i4/mydjbAuHbHUwrgzaxSJp
        Ji7lCaOJ9yIq+YBqLsJ1w/U=
X-Google-Smtp-Source: APXvYqzZP4lI5mOrZykX6YlVTbKArsDdxBszYZVfzKva6X6ZH1JASgsSJDH3e0H9cbZQqfHna5Buuw==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr17644516plc.186.1559765685645;
        Wed, 05 Jun 2019 13:14:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c129sm27135926pfa.106.2019.06.05.13.14.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:14:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] scsi: Avoid that .queuecommand() gets called for a quiesced SCSI device
Date:   Wed,  5 Jun 2019 13:14:34 -0700
Message-Id: <20190605201435.233701-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190605201435.233701-1-bvanassche@acm.org>
References: <20190605201435.233701-1-bvanassche@acm.org>
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
code that avoids that .queuecommand() gets called in the quiesced state.

Note: converting the .queuecommand() call in scsi_send_eh_cmnd() into
code that calls blk_get_request() + blk_execute_rq() is not an option
since scsi_send_eh_cmnd() must be able to make forward progress even
if all requests have been allocated.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f490994374f6..9f16304150b1 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1055,7 +1055,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	DECLARE_COMPLETION_ONSTACK(done);
-	unsigned long timeleft = timeout;
+	unsigned long timeleft = timeout, delay;
 	struct scsi_eh_save ses;
 	const unsigned long stall_for = msecs_to_jiffies(100);
 	int rtn;
@@ -1066,7 +1066,29 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 
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
-- 
2.22.0.rc3

