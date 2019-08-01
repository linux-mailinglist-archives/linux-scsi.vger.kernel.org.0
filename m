Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9260C7E19B
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfHAR45 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41980 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR45 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so32422285pls.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2y12p+X14yF7IobJsyevBQ571MP8lNaAAdOTwa+zjs=;
        b=IhHuWe60Y48OuZd3UtHm2i45o7hGzAUSj5JrmwucuNjroLMtaN6hyEqrFfQtarPD6D
         Q6qsVefkMbQsyZNe8g5LLyBkdEskL688tkU7ey3HMdsSocQwH86Hh9mOIiWm8c3OhQnO
         mZUjqKFzZ93G/bdg7S1wIP3Sb2M8fySneDxkhFPf5vpZXuMXG/cqk7nrHVfLu0UEV9+r
         uDKM3GFkL5EyMrWEfiK5l5BJaC0TE/n8ImY9G+QKKQv+ARbeyt0+5p89NKr0v4213wQT
         TQlNEb/fk7Yn81f/SBgPrfnaQKNk5+yWr/fdT4qJbWrrPvAgogVWfcbvIWVTziHtyCeI
         dpGQ==
X-Gm-Message-State: APjAAAXj+waqG0aMVStqSCY43jq+hnHhlH/Oy7NG+1k46/Pe5yr1o61f
        Ax2yRK48QJ5dph7lBA8Kt/s=
X-Google-Smtp-Source: APXvYqxYAi8fjyQd3Dddihq3Q3S9kS8QkkpwKXBWIXrGIcGDCBTDDIBv+QAl/dkCAKyKUy6rk2Seag==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr68054574pla.172.1564682216615;
        Thu, 01 Aug 2019 10:56:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 26/59] qla2xxx: Simplify a debug statement
Date:   Thu,  1 Aug 2019 10:55:41 -0700
Message-Id: <20190801175614.73655-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Read the FC port state once instead of twice. This patch fixes the
following Coverity complaint:

Unchecked return value (CHECKED_RETURN)
check_return: Calling atomic_read without checking return value (as is
done elsewhere 80 out of 92 times).

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index e8ce57cb897e..55eb51539cb0 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2726,7 +2726,7 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 				"Port to be marked lost on fcport=%02x%02x%02x, current "
 				"port state= %s comp_status %x.\n", fcport->d_id.b.domain,
 				fcport->d_id.b.area, fcport->d_id.b.al_pa,
-				port_state_str[atomic_read(&fcport->state)],
+				port_state_str[FCS_ONLINE],
 				comp_status);
 
 			qla2x00_mark_device_lost(fcport->vha, fcport, 1, 1);
-- 
2.22.0.770.g0f2c4a37fd-goog

