Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764457E1A0
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfHAR5E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so25550015pld.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xB5MGrsr5TQFWVNh7ujxhUazr2BpJxBSP8kex525hA=;
        b=kbE6vDWFeeSD6Y6J3XH+JhPM6DjJ97ciunVJveo3PWj71OlygKHStM3vSC2tF9wDqp
         HFYVRb971hhN0AjT8B22QeBMxDdnvv057Inw2rlj5/keKtQxB+2Ct23p+05ln4WM4E2Y
         bvdirTPd0nkuL/dZaagTp6mecuplye+gyb/v7hnQudApUegnqEnFJp2BqYg88lqrPPoC
         DTvsAK9e7y+3TLpSA6IU7qW5du/fRiEWBWH1p8QuhHJ4Kuwb+alQDrPLWILgZR4PpRKM
         fQeWq5jyTug0S+ziZEGZtOBQuVrOk4OH9ExdwajUmE6kO2ANOnGNRlWiLc28I6E0cblz
         OUlQ==
X-Gm-Message-State: APjAAAUnn+xzpIARvbxZWbQPEH53BmbLpU0zMKOeAe5tTzs+jLFvS2F9
        ZUKZt8rjmffbR6rQyy9EjtM=
X-Google-Smtp-Source: APXvYqwdA8h7fdhJDFQpZ3iBaFxIEtuXJvtJG2pdiFBWSxQRSTGfURijOqlGYJY6YRJ7YgqX1wWIcg==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr123485211plp.95.1564682223152;
        Thu, 01 Aug 2019 10:57:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 31/59] qla2xxx: Always check the qla2x00_wait_for_hba_online() return value
Date:   Thu,  1 Aug 2019 10:55:46 -0700
Message-Id: <20190801175614.73655-32-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes several Coverity complaints about not always checking
the qla2x00_wait_for_hba_online() return value.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_attr.c   | 3 ++-
 drivers/scsi/qla2xxx/qla_target.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 2b92d4659934..e3de20918efb 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -724,7 +724,8 @@ qla2x00_sysfs_write_reset(struct file *filp, struct kobject *kobj,
 			break;
 		} else {
 			/* Make sure FC side is not in reset */
-			qla2x00_wait_for_hba_online(vha);
+			WARN_ON_ONCE(qla2x00_wait_for_hba_online(vha) !=
+				     QLA_SUCCESS);
 
 			/* Issue MPI reset */
 			scsi_block_requests(vha->host);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index ba53329e8bf9..d20e0c21710e 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6673,7 +6673,8 @@ qlt_enable_vha(struct scsi_qla_host *vha)
 	} else {
 		set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags);
 		qla2xxx_wake_dpc(base_vha);
-		qla2x00_wait_for_hba_online(base_vha);
+		WARN_ON_ONCE(qla2x00_wait_for_hba_online(base_vha) !=
+			     QLA_SUCCESS);
 	}
 	mutex_unlock(&ha->optrom_mutex);
 }
@@ -6704,7 +6705,9 @@ static void qlt_disable_vha(struct scsi_qla_host *vha)
 
 	set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 	qla2xxx_wake_dpc(vha);
-	qla2x00_wait_for_hba_online(vha);
+	if (qla2x00_wait_for_hba_online(vha) != QLA_SUCCESS)
+		ql_dbg(ql_dbg_tgt, vha, 0xe081,
+		       "qla2x00_wait_for_hba_online() failed\n");
 }
 
 /*
-- 
2.22.0.770.g0f2c4a37fd-goog

