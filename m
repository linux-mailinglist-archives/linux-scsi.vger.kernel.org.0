Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9763652E
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFEUOp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 16:14:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45814 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEUOp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 16:14:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id x7so9112934plr.12
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 13:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmf/KgJRX3ZfNGi1Ar+6cR+r6SXrnjSikFKADv1dHH4=;
        b=tYK2SRWatGR8wiYga1AjBzTi9cvgidVJAlwFTrlVkgMKfn/oJ3qzHOydqvH9MMGpSp
         pf0CU2DyiL0WpSHI7blrAVhPb+5GxP5CMcn+guw7n7LEoeGIgvzHdvyDAnJfQ1iNp1fG
         KVwA/sQ4+ZZQAxk85IxYHdVFHKNFaYWsVMBG8AlouxHKb7RjnoATtVpNyb1IDKI7K6pV
         OwinhTBFaDPpVS+tgN08lHJq/1O8PnwxsOBNHsupLzwxFz36K6WGhm0dOBbOtpXYVHja
         5KnFRWw65VZHzY7xxOYSVQ5L03G6KYKD1Pgi8kOdPkRY2zru/cer3lH98+QQLVW5oFAd
         rXOw==
X-Gm-Message-State: APjAAAUoa9tjk8oPO8UMV1xVqMUmgrBDL3PDYw/Qr0jUGfM/rXSZBZUf
        bxeAkcp9blg5ad+H+KpAqt0=
X-Google-Smtp-Source: APXvYqzk/NLhG+xgcSp7YS3liRGorJFLPwZDnzQFMyH6CR6xXiJ8FY0UWyYabzWjOj8UtMGSkrowrA==
X-Received: by 2002:a17:902:8a83:: with SMTP id p3mr46926275plo.88.1559765684380;
        Wed, 05 Jun 2019 13:14:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c129sm27135926pfa.106.2019.06.05.13.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:14:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH 1/3] scsi: Do not allow user space to change the SCSI device state into SDEV_BLOCK
Date:   Wed,  5 Jun 2019 13:14:33 -0700
Message-Id: <20190605201435.233701-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190605201435.233701-1-bvanassche@acm.org>
References: <20190605201435.233701-1-bvanassche@acm.org>
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

This patch makes sure that SDEV_BLOCK is only used for its original
purpose, namely to allow transport drivers and LLDs to block further
.queuecommand() calls while transport layer or adapter recovery is in
progress.

Notes:
- While SDEV_BLOCK blocks all SCSI commands, in the SDEV_QUIESCE
  state only those block layer requests are blocked for which RQF_PREEMPT
  has not been set. RQF_PREEMPT is not set for I/O requests submitted by
  e.g. a filesystem but is set for all requests pass-through requests.
  See also __scsi_execute().
- By doing a web search for ("blocked" OR "quiesce") AND
  "/sys/class/scsi_device" AND "device/state" I found several storage
  configuration guides. The instructions I found in these guides
  tell users to write the value "running" or "offline" in the SCSI
  device state sysfs attribute and no other values.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index ff0aea7ac87f..a49ee113b3c4 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -769,6 +769,13 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 	}
 	if (!state)
 		return -EINVAL;
+	/*
+	 * The state SDEV_BLOCK should not be set from userspace. Translate
+	 * SDEV_BLOCK into SDEV_QUIESCE in case the SDEV_BLOCK state transition
+	 * is requested from user space.
+	 */
+	if (state == SDEV_BLOCK)
+		state = SDEV_QUIESCE;
 
 	mutex_lock(&sdev->state_mutex);
 	ret = scsi_device_set_state(sdev, state);
-- 
2.22.0.rc3

