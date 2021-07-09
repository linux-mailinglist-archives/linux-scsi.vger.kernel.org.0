Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF63C2A4D
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Jul 2021 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGIUaE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 16:30:04 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:53923 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhGIUaD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Jul 2021 16:30:03 -0400
Received: by mail-pj1-f41.google.com with SMTP id p9so6369274pjl.3
        for <linux-scsi@vger.kernel.org>; Fri, 09 Jul 2021 13:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zADYFtnLinSyEjm2Uc6wfMGy4VKxXm40TPQ+naIvA68=;
        b=kQ2Kfs5/WY9clnF8K2XrjF4TYG/mKLCiAJT+RNP2M92D4l5xqe1ceW/M35M1dh5y1q
         k1dMIeHnO2ZoyG7Wwy6sgP08iIE+UuK8iL6MWkGW6VKWA3w2bY6EmwZxoqV/A+TgH+BG
         UzWW5QItoYYbmx69Tx0cKg/Pr41YDnKwaebl1fX33QpL6ZyLb8MPjuwuorifuv8kXydI
         54+9qbWL+E5O2Qgetr2cX4n4O83SIlSgMmbbD747EgWriPZ1RuZwRdyAPuxbJDoyQ7Pt
         syIu6RNu5AuFCtfiGHjqJF6dUhrqGjliZWJKeP0lSO2PxIRvxAC5G9QHeqkNjBL8O1Q6
         ONJQ==
X-Gm-Message-State: AOAM531so2rvknvX1GcsxtOeTcU8qZ6mvPECEpBC/txFDNBcRNtJeSkR
        al98zGbWJ/NsMcS5htpA6WI=
X-Google-Smtp-Source: ABdhPJxPd1Mb4Dfxi9eqhHVq2ZbkFS7Du3BSkSSEoKeItP3ltO2xWwp9mnfZgHxJd0rf7/gfzM1ZxA==
X-Received: by 2002:a17:902:bd07:b029:121:9fa2:96a0 with SMTP id p7-20020a170902bd07b02901219fa296a0mr32786105pls.75.1625862439765;
        Fri, 09 Jul 2021 13:27:19 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:eeaf:c266:e6cc:b591])
        by smtp.gmail.com with ESMTPSA id e16sm8812927pgl.54.2021.07.09.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:27:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 07/19] scsi: ufs: Verify UIC locking requirements at runtime
Date:   Fri,  9 Jul 2021 13:26:26 -0700
Message-Id: <20210709202638.9480-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709202638.9480-1-bvanassche@acm.org>
References: <20210709202638.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of documenting the locking requirements of the UIC code as comments,
use lockdep_assert_held() such that lockdep verifies the lockdep
requirements at runtime if lockdep is enabled.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufshcd.c | 16 +++++++++-------
 drivers/scsi/ufs/ufshcd.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index fa52117fdb3e..bf47ef41326e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2242,15 +2242,15 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
 }
 
 /**
- * ufshcd_dispatch_uic_cmd - Dispatch UIC commands to unipro layers
+ * ufshcd_dispatch_uic_cmd - Dispatch an UIC command to the Unipro layer
  * @hba: per adapter instance
  * @uic_cmd: UIC command
- *
- * Mutex must be held.
  */
 static inline void
 ufshcd_dispatch_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
+	lockdep_assert_held(&hba->uic_cmd_mutex);
+
 	WARN_ON(hba->active_uic_cmd);
 
 	hba->active_uic_cmd = uic_cmd;
@@ -2268,11 +2268,10 @@ ufshcd_dispatch_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 }
 
 /**
- * ufshcd_wait_for_uic_cmd - Wait complectioin of UIC command
+ * ufshcd_wait_for_uic_cmd - Wait for completion of an UIC command
  * @hba: per adapter instance
  * @uic_cmd: UIC command
  *
- * Must be called with mutex held.
  * Returns 0 only if success.
  */
 static int
@@ -2281,6 +2280,8 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	int ret;
 	unsigned long flags;
 
+	lockdep_assert_held(&hba->uic_cmd_mutex);
+
 	if (wait_for_completion_timeout(&uic_cmd->done,
 					msecs_to_jiffies(UIC_CMD_TIMEOUT))) {
 		ret = uic_cmd->argument2 & MASK_UIC_COMMAND_RESULT;
@@ -2310,14 +2311,15 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  * @uic_cmd: UIC command
  * @completion: initialize the completion only if this is set to true
  *
- * Identical to ufshcd_send_uic_cmd() expect mutex. Must be called
- * with mutex held and host_lock locked.
  * Returns 0 only if success.
  */
 static int
 __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
+	lockdep_assert_held(&hba->uic_cmd_mutex);
+	lockdep_assert_held(hba->host->host_lock);
+
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
 			"Controller not ready to accept UIC commands\n");
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 79f6c261dfff..0dfb5e97ec0d 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -683,7 +683,7 @@ struct ufs_hba_monitor {
  * @priv: pointer to variant specific private data
  * @irq: Irq number of the controller
  * @active_uic_cmd: handle of active UIC command
- * @uic_cmd_mutex: mutex for uic command
+ * @uic_cmd_mutex: mutex for UIC command
  * @tmf_tag_set: TMF tag set.
  * @tmf_queue: Used to allocate TMF tags.
  * @pwr_done: completion for power mode change
