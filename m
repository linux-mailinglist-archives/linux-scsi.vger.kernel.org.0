Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44BB7E1A2
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfHAR5H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:07 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33778 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5H (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:07 -0400
Received: by mail-pf1-f179.google.com with SMTP id g2so34511179pfq.0
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+H0SKLQS0diUAEuqxyBKD4IaclMuJBW3YcBzbloWyE=;
        b=HGfi9MbliJO7tXJbdwpQtu1UUvkIm4re5OeG7Z5n7rrRpEGNp3o6UjUsoXTHxt5572
         +sFN++TNA4vz1vMqnXmuOYI2wX0F0qbwjJpuDGdYZPVGC8QFS5ttpO5VJgQ7P2gWIWYL
         CUCZEr2HzGEoD552oZk3rTZ3dcTHHjNZyfv6MKZsO47dWOHRY0+wa6Ee7bN25++nFeLl
         fZuWKaq8oXu0rRf6Z5Cm1GemWd9U9YGsK/7SxwbxADjW1RZpXk+SvGDZTeNVNsWe+bsV
         Ee9ulqoVd/NmYaA3MN8ZqmbqsMPqSpkBAD2LTFCD/OSA5fjJBRpAYVSAAFOI1I3H3bNP
         q1tA==
X-Gm-Message-State: APjAAAUAqIvW1BN41pCh3LsVc0b20R1TRnVrS+iAzN5KLKoif4BaZSf6
        VoMiut3TO4ZP1OfcTQZWAztZGRny
X-Google-Smtp-Source: APXvYqyqzbleqHvU8tmGWFupVE+xvzWobuijXEdzACnuaFh66YS+BqQbReRyCPZG+UA80iLaROP1AQ==
X-Received: by 2002:a63:510e:: with SMTP id f14mr40483406pgb.422.1564682225908;
        Thu, 01 Aug 2019 10:57:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 33/59] qla2xxx: Complain if waiting for pending commands times out
Date:   Thu,  1 Aug 2019 10:55:48 -0700
Message-Id: <20190801175614.73655-34-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Such a timeout is a severe issue. Hence complain if waiting for pending
commands times out. This patch fixes a small bug: it modifies
qla82xx_chip_reset_cleanup() such that the "Done waiting" message is
reported if qla82xx_chip_reset_cleanup() succeeded instead of if that
function failed.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 3 ++-
 drivers/scsi/qla2xxx/qla_nx.c   | 4 +++-
 drivers/scsi/qla2xxx/qla_os.c   | 7 +++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1fd9a086748e..2d9a379fd8fb 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6634,7 +6634,8 @@ qla2x00_quiesce_io(scsi_qla_host_t *vha)
 					LOOP_DOWN_TIME);
 	}
 	/* Wait for pending cmds to complete */
-	qla2x00_eh_wait_for_pending_commands(vha, 0, 0, WAIT_HOST);
+	WARN_ON_ONCE(qla2x00_eh_wait_for_pending_commands(vha, 0, 0, WAIT_HOST)
+		     != QLA_SUCCESS);
 }
 
 void
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index c1c832271ccb..a91d426add75 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -3710,10 +3710,12 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
 
 		/* Wait for pending cmds (physical and virtual) to complete */
 		if (qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
-		    WAIT_HOST)) {
+		    WAIT_HOST) == QLA_SUCCESS) {
 			ql_dbg(ql_dbg_init, vha, 0x00b3,
 			    "Done wait for "
 			    "pending commands.\n");
+		} else {
+			WARN_ON_ONCE(true);
 		}
 	}
 }
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5faf2d5d5060..cc24af941f7d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1059,8 +1059,8 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
  *    cmd = Scsi Command to wait on.
  *
  * Return:
- *    Not Found : 0
- *    Found : 1
+ *    Completed in time : QLA_SUCCESS
+ *    Did not complete in time : QLA_FUNCTION_FAILED
  */
 static int
 qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
@@ -1364,6 +1364,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+/*
+ * Returns: QLA_SUCCESS or QLA_FUNCTION_FAILED.
+ */
 int
 qla2x00_eh_wait_for_pending_commands(scsi_qla_host_t *vha, unsigned int t,
 	uint64_t l, enum nexus_wait_type type)
-- 
2.22.0.770.g0f2c4a37fd-goog

