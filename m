Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A353176F56
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfGZQtI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:49:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45084 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfGZQtI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 12:49:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so24779078pfq.12
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 09:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQvOmBVFQiJoCCbcs6wSSElOBK3p2UWnFV/tJGoIzng=;
        b=s97xreOdudjVPHSTwdFPV7wtaoi89S1d8Ui4IEdE2gAvPVEo31CagzQ+rV4eZM27Ip
         /ldoK1DG1FeZhRPkliqzlL8bwaUoyZNaigZgF07pMF0iXeZQhtc8UoU7fxgjPq0HsuGs
         O2h8Xm4tSThxu+k3sbL2fTaDIJqrw/C6aGyNVbyhrQIMjONnsHcab/MjCTJhH8anDe0M
         TqcsNrAUG+BYUFUzunv1lyVaLh5jLEUltiqO0zvwRS0BDrayv+nJ/OO+dkkYEilShx2c
         yNmPG9Zr2E9EYFCVCD9Nqh7kPfLFnkDJQrt+XLOz22qrPc6NqhWGfGznj9L9MVpGuihM
         lAFA==
X-Gm-Message-State: APjAAAVXFjrCxZYCxYbU5mDaUaQb5dkiul6fEN784QmHV+IBzunLbWvv
        b9iPfMnWgHD4RKpIzWgqBms=
X-Google-Smtp-Source: APXvYqzGRXdXXM7IRyfsanquUxr1CTW3ojsOKxMr0offbMFkPWxLYs5+d8D/iY2aLShxXgDeDacScg==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr60100398pgq.415.1564159747198;
        Fri, 26 Jul 2019 09:49:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm80923246pjc.16.2019.07.26.09.49.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:49:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] Complain if scsi_target_block() fails
Date:   Fri, 26 Jul 2019 09:48:54 -0700
Message-Id: <20190726164855.130084-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726164855.130084-1-bvanassche@acm.org>
References: <20190726164855.130084-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If scsi_target_block() fails that can break the code that calls this
function. Hence complain loudly if scsi_target_block() fails.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index bbed72eff9c9..c9630bd59b5a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2770,6 +2770,8 @@ int scsi_target_block(struct device *dev)
 	else
 		device_for_each_child(dev, &ret, target_block);
 
+	WARN_ONCE(ret, "ret = %d\n", ret);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(scsi_target_block);
-- 
2.22.0.709.g102302147b-goog

