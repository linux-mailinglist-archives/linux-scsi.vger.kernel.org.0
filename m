Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90E576F54
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfGZQtF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:49:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41809 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfGZQtF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 12:49:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so14695345pgg.8
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 09:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jomV+CFuLfRYNuZZIqVWa7CNf/E3Suyb6SreaDBA0Ik=;
        b=GbAwJQwLIDJhk1Q/m765LOTP8wixgb9Yf6Ds9dJNxBzry678ls+u6nEYZtlLcFBDmb
         dAcmqP6++6NRW/5nfdpKWwzP5+/+FEnn+v2rk/9MlcdTRDKs4tDaemuk01ub2ifsuDSW
         iNlNEYoOXs2wLAonYa3XZA37SqPl5bZWXGSCCbJ2jlBaL3rxdUQRsEkymBD9OjQgUCqR
         WcS3tNU31370DhlITXTLkMgWQLtQ8c9uatcQfFgo4YhIxLuHhctAB/anMCCAFcjTQVur
         FpvLv3QZHV/dxjyFNnWOCKoUsxGcP96DlF6uh7AnZSmc4j/Te2atanqiZmADdllfipBD
         YLtg==
X-Gm-Message-State: APjAAAUcYaRl1VoJ39//L8yJYG3DWapHd6EhfO03Q4GpvvUVXgc2vjj/
        883xI1iUDGEZvIRbLpim4cQ=
X-Google-Smtp-Source: APXvYqwpJs0PtM4uuhyi6dlSvuWXuhv/1z4Qlu69eI35hKhAigjtYtdR5NzBXAZ/oXKvfxjdE0g2ZA==
X-Received: by 2002:a63:505a:: with SMTP id q26mr89827794pgl.18.1564159744625;
        Fri, 26 Jul 2019 09:49:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm80923246pjc.16.2019.07.26.09.49.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:49:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] Make scsi_internal_device_unblock_nowait() reject invalid new_state values
Date:   Fri, 26 Jul 2019 09:48:52 -0700
Message-Id: <20190726164855.130084-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726164855.130084-1-bvanassche@acm.org>
References: <20190726164855.130084-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The only 'new_state' values passed by upstream kernel code to
scsi_internal_device_unblock_nowait() are SDEV_RUNNING and
SDEV_TRANSPORT_OFFLINE. These are the only values that should be passed
to this function. Hence Check the value of the 'new_state' argument
to avoid that scsi_internal_device_unblock_nowait() would be used
to trigger an illegal SCSI device state transition. In this context
'illegal' means not allowed by scsi_device_set_state().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9381171c2fc0..497cd4799e0a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2676,6 +2676,14 @@ void scsi_start_queue(struct scsi_device *sdev)
 int scsi_internal_device_unblock_nowait(struct scsi_device *sdev,
 					enum scsi_device_state new_state)
 {
+	switch (new_state) {
+	case SDEV_RUNNING:
+	case SDEV_TRANSPORT_OFFLINE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/*
 	 * Try to transition the scsi device to SDEV_RUNNING or one of the
 	 * offlined states and goose the device queue if successful.
-- 
2.22.0.709.g102302147b-goog

