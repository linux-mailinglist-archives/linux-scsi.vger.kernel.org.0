Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA23E4FDD
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhHIXFZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Aug 2021 19:05:25 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:45990 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhHIXFW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Aug 2021 19:05:22 -0400
Received: by mail-pj1-f41.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so2388842pjl.4
        for <linux-scsi@vger.kernel.org>; Mon, 09 Aug 2021 16:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ4SL9MTjpzWQ6igFtpBF0COJSqM/EQbUXJ22LCsrfY=;
        b=cxtcnAhNVxLXNOCfeQgbI24aR+ce3lZaRpU3tr/I2SholS3bHBWurNprzeNtHX/Xca
         2aJWiieD/pdhZzrdh7UzLi0R+TSHNzYUE8gp+QZt7XjaiZgzvtA98Kx0WhrlS6oJ3blU
         C2rOeVz5QPs4LYA2HE1j7RUnVbXSyH+A9sf9Iv+S1N0KHONlRtw2E8xCh3WVLK8lKIN5
         aCwUxhgStgd5N7+4gyccC/w/v4uH517/qyIdLrSCFfmkM0Tn3psQKpHIsaLoIUHGHzDX
         HxkBqgKV6gtlMKZNQ09BM78ayqyCULTbh39RFSaLXH7jKZId1oX68FcYfxB2wigR+7DV
         8y+g==
X-Gm-Message-State: AOAM533LiethZjQVVa0kDGxANRq5mA1vRI3HZ1g5vx1WQmmt5bE6IN2k
        Wd74viNZ83RNDVEHl65bN0w=
X-Google-Smtp-Source: ABdhPJyPYL28yiX962FQZl+ZLuEYvz/RQgnYsP0AF8AjaoaYhPZNmj2mCU0j2pDxTNlJlrTZYvBDHQ==
X-Received: by 2002:a17:902:9897:b029:12d:17ac:3d40 with SMTP id s23-20020a1709029897b029012d17ac3d40mr8938012plp.67.1628550300781;
        Mon, 09 Aug 2021 16:05:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7dd4:e46e:368b:7454])
        by smtp.gmail.com with ESMTPSA id j6sm24102260pgq.0.2021.08.09.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 16:05:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 37/52] qla1280: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
Date:   Mon,  9 Aug 2021 16:03:40 -0700
Message-Id: <20210809230355.8186-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809230355.8186-1-bvanassche@acm.org>
References: <20210809230355.8186-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for removal of the request pointer by using scsi_cmd_to_rq()
instead. Remove the unused CMD_REQUEST() macro. This patch does not change
any functionality.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla1280.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 928da90b79be..9f9b4900c3ab 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -490,7 +490,6 @@ __setup("qla1280=", qla1280_setup);
 #define	CMD_SNSLEN(Cmnd)	SCSI_SENSE_BUFFERSIZE
 #define	CMD_RESULT(Cmnd)	Cmnd->result
 #define	CMD_HANDLE(Cmnd)	Cmnd->host_scribble
-#define CMD_REQUEST(Cmnd)	Cmnd->request->cmd
 
 #define CMD_HOST(Cmnd)		Cmnd->device->host
 #define SCSI_BUS_32(Cmnd)	Cmnd->device->channel
@@ -2827,7 +2826,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(cmd->request->timeout/HZ);
+	pkt->timeout = cpu_to_le16(scsi_cmd_to_rq(cmd)->timeout / HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
@@ -3082,7 +3081,7 @@ qla1280_32bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 	memset(((char *)pkt + 8), 0, (REQUEST_ENTRY_SIZE - 8));
 
 	/* Set ISP command timeout. */
-	pkt->timeout = cpu_to_le16(cmd->request->timeout/HZ);
+	pkt->timeout = cpu_to_le16(scsi_cmd_to_rq(cmd)->timeout / HZ);
 
 	/* Set device target ID and LUN */
 	pkt->lun = SCSI_LUN_32(cmd);
