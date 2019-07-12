Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303676674B
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGLGxu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 02:53:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfGLGxu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Jul 2019 02:53:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF066AFE4;
        Fri, 12 Jul 2019 06:53:48 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Zhang Guanghui <zhang.guanghui@h3c.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] scsi_dh_alua: always use a 2 seconds delay before retrying RTPG
Date:   Fri, 12 Jul 2019 08:53:47 +0200
Message-Id: <20190712065347.93517-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Retrying immediately after we've received a 'transitioning' sense
code is pretty much pointless, we should always use a delay before
retrying.
So ensure the default delay is applied before retrying.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index d7ac498ba35a..3e9a28ed417a 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -54,6 +54,7 @@
 #define ALUA_FAILOVER_TIMEOUT		60
 #define ALUA_FAILOVER_RETRIES		5
 #define ALUA_RTPG_DELAY_MSECS		5
+#define ALUA_RTPG_RETRY_DELAY		2
 
 /* device handler flags */
 #define ALUA_OPTIMIZE_STPG		0x01
@@ -696,7 +697,7 @@ static int alua_rtpg(struct scsi_device *sdev, struct alua_port_group *pg)
 	case SCSI_ACCESS_STATE_TRANSITIONING:
 		if (time_before(jiffies, pg->expiry)) {
 			/* State transition, retry */
-			pg->interval = 2;
+			pg->interval = ALUA_RTPG_RETRY_DELAY;
 			err = SCSI_DH_RETRY;
 		} else {
 			struct alua_dh_data *h;
@@ -821,6 +822,8 @@ static void alua_rtpg_work(struct work_struct *work)
 				spin_lock_irqsave(&pg->lock, flags);
 				pg->flags &= ~ALUA_PG_RUNNING;
 				pg->flags |= ALUA_PG_RUN_RTPG;
+				if (!pg->interval)
+					pg->interval = ALUA_RTPG_RETRY_DELAY;
 				spin_unlock_irqrestore(&pg->lock, flags);
 				queue_delayed_work(kaluad_wq, &pg->rtpg_work,
 						   pg->interval * HZ);
@@ -832,6 +835,8 @@ static void alua_rtpg_work(struct work_struct *work)
 		spin_lock_irqsave(&pg->lock, flags);
 		if (err == SCSI_DH_RETRY || pg->flags & ALUA_PG_RUN_RTPG) {
 			pg->flags &= ~ALUA_PG_RUNNING;
+			if (!pg->interval && !(pg->flags & ALUA_PG_RUN_RTPG))
+				pg->interval = ALUA_RTPG_RETRY_DELAY;
 			pg->flags |= ALUA_PG_RUN_RTPG;
 			spin_unlock_irqrestore(&pg->lock, flags);
 			queue_delayed_work(kaluad_wq, &pg->rtpg_work,
-- 
2.16.4

