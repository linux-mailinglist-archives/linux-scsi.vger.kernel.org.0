Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6218C486D1
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfFQPSa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 11:18:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34487 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPS3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 11:18:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so5872341pfc.1
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56VzP6loyvCbiQA6Sh4850/nEbd1cCME9gjuek5ksrc=;
        b=NzR0ulDWQH+xNg07zA55xlxtvFPyrUMw+2PCcjCsn14SA3isVrnSxJUnWSSrgy+Zet
         UhmwG43DexdJ4tUwTX/tUScIdbAXqhHNtGMh3QURTq8zQlH/wI5jHNnadU0lyIvkEpXQ
         C1sd+mYEiN/okKucvcPJfipWr7aprTOmOG9GUvDBUoshFZp0V5e446TGXbOFY6fj3rxJ
         VijNvqPsaXEefIy+vYBaSjgrd7oGCVUOtPsamsVHXwuhhZl/QzIY/GVUycjXCB+k09Hd
         8j9ciyuqSrmixEJHtL6V9x7IYSbjbeagK18IUacdJ52qpRy1fqwDMyM8g7plqSQE/7gc
         AQaw==
X-Gm-Message-State: APjAAAXG/PK52G5YaeyGUWNxQFwu5pOMBA651k7fo4dxZIPk/oG4RKHt
        MS41kWFqV2SW+0sVYXQUP5Y=
X-Google-Smtp-Source: APXvYqwGuRuMYq/SRxvIpmUFJhHrUy9erW1Z+DAiFN44z8aTJhurnO5Qe+1WfPN/sWIGbSvHfLvH1w==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr30583816pfr.38.1560784709094;
        Mon, 17 Jun 2019 08:18:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n5sm12529949pgd.26.2019.06.17.08.18.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:18:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH v4 1/3] scsi: Restrict user space SCSI device state changes to "running" and "offfline"
Date:   Mon, 17 Jun 2019 08:18:18 -0700
Message-Id: <20190617151820.241583-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617151820.241583-1-bvanassche@acm.org>
References: <20190617151820.241583-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The ability to modify the SCSI device state was introduced by commit
638127e579a4 ("[PATCH] Fix error handler offline behaviour"; v2.6.12). That
same commit introduced the following device states:

       { SDEV_CREATED, "created" },
       { SDEV_RUNNING, "running" },
       { SDEV_CANCEL,  "cancel"  },
       { SDEV_DEL,     "deleted" },
       { SDEV_QUIESCE, "quiesce" },
       { SDEV_OFFLINE, "offline" },

The SDEV_BLOCK state was introduced later to avoid that an FC cable pull
would immediately result in an I/O error (commit 1094e682310e; "[PATCH]
suspending I/Os to a device"; v2.6.12). That same patch introduced the
ability to set the SDEV_BLOCK state from user space. I'm not sure whether
that ability was introduced on purpose or accidentally.

Since there is agreement that only writing "running" or "offline" into
the SCSI sysfs device state attribute makes sense, restrict sysfs writes
to these values.

This patch makes sure that SDEV_BLOCK is only used for its original
purpose, namely to allow transport drivers and LLDs to block further
.queuecommand() calls while transport layer or adapter recovery is in
progress.

Note: a web search for "/sys/class/scsi_device" AND "device/state"
revealed several storage configuration guides. The instructions I found
in these guides tell users to write the value "running" or "offline" in
the SCSI device state sysfs attribute and no other values.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 3b119ca0cc0c..850cdc731a1f 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -766,8 +766,13 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 			break;
 		}
 	}
-	if (!state)
+	switch (state) {
+	case SDEV_RUNNING:
+	case SDEV_OFFLINE:
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	mutex_lock(&sdev->state_mutex);
 	ret = scsi_device_set_state(sdev, state);
-- 
2.22.0.rc3

