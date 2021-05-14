Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA4938130A
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhENVgW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 17:36:22 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:34751 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhENVgS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 May 2021 17:36:18 -0400
Received: by mail-pj1-f46.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1961324pjx.1
        for <linux-scsi@vger.kernel.org>; Fri, 14 May 2021 14:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7gxN0HJk866BhsDvBhRhV28HgCfD2GC970SJ4nhuds=;
        b=QQBSE8l8lW9M1ZZcVeDXe7ooJnK9OoXMh4hrCIXojTmac462aXJYW2eHDG4rvUtefb
         kgI1PW8cw/ips9ML6wcuwEwwVLqjRlz4RohK4RlzoOkcsWEjJq5BUPK03h8RQJsZaVBE
         vyhWWxc+NNwPoNXGFICNBKfRBPSlGuIGjKGSA3ClsKIrHhQrwMq+cibM4/2NIGa9XOre
         BzF+siuqptsFp+IvvXkVYBHGkhPzGul+/h4TRG16Igst7LWrq7ax/+eIxDbY47BZ8n7M
         I2OPdgsdBhBplRELd/kGTOxhVTGwNnFv7bryoXMrKr7hLXrxTum1D7eqkTlpB6TP0YPU
         h6Kw==
X-Gm-Message-State: AOAM532MAICqRKnQUU4dfyyiTthkc3Qcl1YVGlNEI8QCnZ3/KItjw4DU
        0JtEY7HAME0wE6UESUhHUEY=
X-Google-Smtp-Source: ABdhPJxpUODod9qFKex+KnUuDIyVBFp1sJvPg7DTLWd/E/AVb91G5TQJLm2S9Ef6zK7Yr3GcFEN/PA==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr11422331pjg.108.1621028105945;
        Fri, 14 May 2021 14:35:05 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e40c:c579:7cd8:c046])
        by smtp.gmail.com with ESMTPSA id js6sm9307262pjb.0.2021.05.14.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:35:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 35/50] qla1280: Use blk_req() instead of scsi_cmnd.request
Date:   Fri, 14 May 2021 14:32:50 -0700
Message-Id: <20210514213356.5264-36-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514213356.5264-1-bvanassche@acm.org>
References: <20210514213356.5264-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for removal of the request pointer by using blk_req() instead. This
patch does not change any functionality.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla1280.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 928da90b79be..a9a8e1e9c253 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -490,7 +490,7 @@ __setup("qla1280=", qla1280_setup);
 #define	CMD_SNSLEN(Cmnd)	SCSI_SENSE_BUFFERSIZE
 #define	CMD_RESULT(Cmnd)	Cmnd->result
 #define	CMD_HANDLE(Cmnd)	Cmnd->host_scribble
-#define CMD_REQUEST(Cmnd)	Cmnd->request->cmd
+#define CMD_REQUEST(Cmnd)	blk_req(Cmnd)->cmd
 
 #define CMD_HOST(Cmnd)		Cmnd->device->host
 #define SCSI_BUS_32(Cmnd)	Cmnd->device->channel
@@ -2827,7 +2827,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(cmd->request->timeout/HZ);
+	pkt->timeout = cpu_to_le16(blk_req(cmd)->timeout / HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
@@ -3082,7 +3082,7 @@ qla1280_32bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(cmd->request->timeout/HZ);
+	pkt->timeout = cpu_to_le16(blk_req(cmd)->timeout / HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
