Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CC410214
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Sep 2021 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbhIRAIO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 20:08:14 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35542 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245742AbhIRAII (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Sep 2021 20:08:08 -0400
Received: by mail-pf1-f178.google.com with SMTP id w14so145970pfu.2
        for <linux-scsi@vger.kernel.org>; Fri, 17 Sep 2021 17:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6NUsYAaALq9TsTWyA1j2V3MIAW6p3hWUP9skEIvRvs=;
        b=2ixLYCxxkRCdPxSQ9nv9NTzsxUcf+Rx/ncuKVUWZWYFwxh2lpIxCp6oWQoV2MCBZbX
         uAfwUNC7b/b2dK4ap+93ho3Z4IzOlSBFEyfTsCNe5MhMLqCCiW/y8FaPCUpgS9IeOGX9
         +vt82fYsE792X7MsOG4Y4ZJyc7fzyrtICAxLC9T0suqLfd1xdJ4vh71weymgkxgbdetb
         HcbEW+p8isZtP94XFUC2sfbputdjT+qQftpkN723WHfwe2J7vFUfkr2q4eeyooLiNmGI
         mQQDvD+L0p21gxbK3o74/3VAyRv3vXTXNJO5Aq3suAh0tmIp6BENbcoRNihRc9erAVKJ
         UOiw==
X-Gm-Message-State: AOAM531cCYUFJGYKvVtRONnTSvVuH//CYJsSnasxqFY3wEuurzGzPzRe
        QOBjyhKJaUkQidIMkkGZq3rONjuZBq4=
X-Google-Smtp-Source: ABdhPJxo9SXnE8wBSdqoBN4tOIqaRLoQ7Inp+7E6YPeRyLum9M5A3bXTM2qzl+CYEbc6M00R+IcqWw==
X-Received: by 2002:a63:4cd:: with SMTP id 196mr12306547pge.239.1631923605399;
        Fri, 17 Sep 2021 17:06:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:4c45:d635:d2d2:93])
        by smtp.gmail.com with ESMTPSA id bv16sm6403129pjb.12.2021.09.17.17.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:06:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 22/84] aic7xxx: Call scsi_done() directly
Date:   Fri, 17 Sep 2021 17:05:05 -0700
Message-Id: <20210918000607.450448-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210918000607.450448-1-bvanassche@acm.org>
References: <20210918000607.450448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 3 +--
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 92ea24a075b8..af49c32cfaf7 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -581,7 +581,6 @@ ahd_linux_queue_lck(struct scsi_cmnd * cmd, void (*scsi_done) (struct scsi_cmnd
 
 	ahd = *(struct ahd_softc **)cmd->device->host->hostdata;
 
-	cmd->scsi_done = scsi_done;
 	cmd->result = CAM_REQ_INPROG << 16;
 	rtn = ahd_linux_run_command(ahd, dev, cmd);
 
@@ -2111,7 +2110,7 @@ ahd_linux_queue_cmd_complete(struct ahd_softc *ahd, struct scsi_cmnd *cmd)
 
 	ahd_cmd_set_transaction_status(cmd, new_status);
 
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 }
 
 static void
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 8b3d472aa3cc..f2daca41f3f2 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -530,7 +530,6 @@ ahc_linux_queue_lck(struct scsi_cmnd * cmd, void (*scsi_done) (struct scsi_cmnd
 
 	ahc_lock(ahc, &flags);
 	if (ahc->platform_data->qfrozen == 0) {
-		cmd->scsi_done = scsi_done;
 		cmd->result = CAM_REQ_INPROG << 16;
 		rtn = ahc_linux_run_command(ahc, dev, cmd);
 	}
@@ -1986,7 +1985,7 @@ ahc_linux_queue_cmd_complete(struct ahc_softc *ahc, struct scsi_cmnd *cmd)
 		ahc_cmd_set_transaction_status(cmd, new_status);
 	}
 
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 }
 
 static void
