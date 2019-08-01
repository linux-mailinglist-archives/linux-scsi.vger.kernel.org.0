Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D707E5C2
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 00:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbfHAWiZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 18:38:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbfHAWiY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 18:38:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so34965458pgp.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 15:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX4mNRjOvIdjTi1K4xs6W2oAjtr8alpD7VviCCCABN8=;
        b=glKe5PKzKzCF/DzUOdLo2jeu2SnrBTFDuDl5xoKWxXaNlElthi3jdVdfwYytr8cXhL
         uchYfvJzy/jJwPD7TVxUZfn1TgAofjl43LD+IVMdPkcpx+eIB7QlwZmEzlWPT7xUs34m
         0D82JnHL2MVKy2N9V/pYKRxTFi4D0QyeSi9yaHGOKFltA/Ex2iqItSsakJpwMvZsPKQL
         2QLm01PS2xYtSfxsJK3Y7JbnN0sK7NuTgD0fa0kL9ZOJF8ecBgX81n8jYKuDmDTgqroj
         gtR+ogU8zChjz4b7nTNyRU6O+ZvoE0k44ehRe+AnCHxquwjpZzdkCSUOBEZq2RXD1R10
         tZmQ==
X-Gm-Message-State: APjAAAUxtb8e+8CnWt3+tL4YUrL00E36iqyIt0elrfOO4MPP/sVchtVt
        yxznhEjqurFSntZ5CFPrlGA=
X-Google-Smtp-Source: APXvYqxcsMibLaRpm9foLlqAnDPNfKCoooLXXY0KuD3dSQRtjjsDEhI+7C7+TkThqOGF1wC5TW3d/g==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr67957868pgc.90.1564699103970;
        Thu, 01 Aug 2019 15:38:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b26sm82344632pfo.129.2019.08.01.15.38.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:38:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 1/3] Make scsi_internal_device_unblock_nowait() reject invalid new_state values
Date:   Thu,  1 Aug 2019 15:38:12 -0700
Message-Id: <20190801223814.140729-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801223814.140729-1-bvanassche@acm.org>
References: <20190801223814.140729-1-bvanassche@acm.org>
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
index c72bce2f0cf1..7a4ac7a8e907 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2707,6 +2707,14 @@ void scsi_start_queue(struct scsi_device *sdev)
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
2.22.0.770.g0f2c4a37fd-goog

