Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3549936148B
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Apr 2021 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhDOWJF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Apr 2021 18:09:05 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:51914 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhDOWJE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Apr 2021 18:09:04 -0400
Received: by mail-pj1-f53.google.com with SMTP id lt13so4001746pjb.1
        for <linux-scsi@vger.kernel.org>; Thu, 15 Apr 2021 15:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpvIXFMO2/MgdDMwxCoeYsr1AYU+YR9iqCp/6zOQB3U=;
        b=QBd8HEOLmVyganJpy4P9/160ffOxt2uSaTjn048NfqsBo91UhrzM0lFfA/wDp/ByZb
         +UbtLM4ei6gTrWP5rfhLHk0kOOKtSjDjmGNwmk46GOOvxdE8WpBSGDKLM74QW0ruwv44
         wn7RRCWBd9vf7ID+64xP+Fb9bmV/txreaH/GpD1NCUGlOfK57PGj+l06EQK9RQ5+HQWC
         1O+3HRFSQrzzJQENS2Vcai8QNUgpCxzIT7dOQrExOh2oiXbgaTjaemZQCIJEv22NPh7c
         n5+iMdf9MWyUiAzeLsPLIUO5XQPD3aP8TyhlM6OzRAx36DpMSLHVinbjvoBcrv5QiK9u
         eqdA==
X-Gm-Message-State: AOAM530X1qt44bq85oR1l82kQByb5ehRpOns0CoaOERshriD2EKvjmWX
        PpsFGnAEXVpyu4TwzXzCJkw=
X-Google-Smtp-Source: ABdhPJxxw80wy4iVzHgl03VY3rDTINPdPayiMP/i46YVir/0WrNHgzhImRHDaUMN7q4dd55eMn1nKw==
X-Received: by 2002:a17:90b:715:: with SMTP id s21mr6151669pjz.183.1618524520506;
        Thu, 15 Apr 2021 15:08:40 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f031:1d3a:7e95:2876])
        by smtp.gmail.com with ESMTPSA id w4sm3311155pjk.55.2021.04.15.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 15:08:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 04/20] Modify the scsi_send_eh_cmnd() return value for the SDEV_BLOCK case
Date:   Thu, 15 Apr 2021 15:08:10 -0700
Message-Id: <20210415220826.29438-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415220826.29438-1-bvanassche@acm.org>
References: <20210415220826.29438-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The comment above scsi_send_eh_cmnd() says: "Returns SUCCESS or FAILED or
NEEDS_RETRY". This patch makes all values returned by scsi_send_eh_cmnd()
match the documentation of this function. This change does not affect the
behavior of scsi_eh_tur() nor of scsi_eh_try_stu() nor of the
scsi_request_sense() callers.

See also commit bbe9fb0d04b9 ("scsi: Avoid that .queuecommand() gets called
for a blocked SCSI device"; v5.3).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c0a3497fc474..28b287e9f50a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1112,7 +1112,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	if (sdev->sdev_state != SDEV_BLOCK)
 		rtn = shost->hostt->queuecommand(shost, scmd);
 	else
-		rtn = SCSI_MLQUEUE_DEVICE_BUSY;
+		rtn = FAILED;
 	mutex_unlock(&sdev->state_mutex);
 
 	if (rtn) {
