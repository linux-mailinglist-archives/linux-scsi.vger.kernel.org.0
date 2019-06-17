Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8543A49180
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFQUi6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:38:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44964 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUi6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:38:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so4618592plr.11
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5nxhCsG5eBtX2g1+XctCX/DLLLVt2de/J2dzQq5Ok0=;
        b=DzN9k6eAZ+uftp8tyR4m7+tOomgIL5+rhyNBT18yIPvvJIF14QhMjl48gio6Eh+Pb2
         3oFOGpqu7TE5OT6hdAOgfz0/okRym9p1w/+UHW/i9rP8riJ3dMKc+Ft2on6NcG4TJaaD
         z5b4SUdZE/ITshiKp+RlLO93JQM/MbrpZo7mSks69Hn4xMAnRo2lxJ9jnbyKrfLr17HI
         KiAHs1nsxgt40KMrsH7JDk1XQNa/7IXmOQg59GSTPHYuYiWgSkhTY46osidnTv/ZJrU1
         S7R+M2zJ2BnmNHlogCUzGQlhhb6uskFaTwY/7LmL98RsGk1mhSQIEzW8bGePfTtkA6Oj
         GV4Q==
X-Gm-Message-State: APjAAAU472ThuyhHgC+FqW/dxA0XbXG3T+KWvbZKOeh+hh+gFJkwjIwa
        4PR5yQ3QxQRvajv0zhEHIGREhK6xgnI=
X-Google-Smtp-Source: APXvYqz5FkK81BapvVYgZGgtMjB6ngsIt+wJcrTQRtfEL7R4zukqmqiXsuQ/k5VaqWU/00o166q2dg==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr91471908plb.118.1560803937301;
        Mon, 17 Jun 2019 13:38:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.38.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:38:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 1/6] qla2xxx: Make qla2x00_abort_srb() again decrease the sp reference count
Date:   Mon, 17 Jun 2019 13:38:42 -0700
Message-Id: <20190617203847.184407-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since qla2x00_abort_srb() starts with increasing the reference count of
@sp, decrease that same reference count before returning.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 219d27d7147e ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands") # v5.2.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d056f5e7cf93..1bdf634e7117 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1746,6 +1746,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
 		sp->comp = NULL;
 	}
+
+	atomic_dec(&sp->ref_count);
 }
 
 static void
-- 
2.22.0.rc3

