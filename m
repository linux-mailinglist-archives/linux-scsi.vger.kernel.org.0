Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD227364F20
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhDTAKX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:10:23 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39436 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhDTAKF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:10:05 -0400
Received: by mail-pg1-f174.google.com with SMTP id s22so4290752pgk.6
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPS7FcUzEV33pgRdkZ580VSFzJMEIgxkD2FPvbrLeTA=;
        b=cZGJNhTL7HrNXsJaP9s0BfR+QFiyLexrllDmJs/9mk8WHkjC4PD1EeNHLBWoqsRK9O
         9PDVONdwmgVwepLda+91b85GSSG+gyPuDIRYpv+iFh1oVrG/yftmnvg6sDxQO5SeRJgx
         FFQZDNXh4MgwOcRR52p8xgLffnptI29SscXG8CNkFeK+RO+e5I0Jvikpz06KzapEuUWw
         Cv9KSjRC79F4LH/A4ZKOGlE8jxK2JitlfGiyxghmXvHTNtmoUBNEhlhVeIbY4uN2T44y
         ekgZVbg0QhUtJ9RNlO00CY1DT9BTyzekUYNwpB1XWqp/M1m6xXOppcUqaZumbv8G56qK
         nkaQ==
X-Gm-Message-State: AOAM533wa0LS11pS4Q5o3ARQ21qIyypKKKQ+XrwpGOV8+ldXYuVBxgIE
        siGg4B7g0DRv1EzYPC2lq/I=
X-Google-Smtp-Source: ABdhPJyNtTFjs8nWgvjaOhX0RXC6weWABpRJYhARbDb8rIrrn+j3yW9T1xr0701rTJdLkOWbIlKbQA==
X-Received: by 2002:a65:45c3:: with SMTP id m3mr14083758pgr.179.1618877375145;
        Mon, 19 Apr 2021 17:09:35 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:09:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 037/117] cdrom: Convert to the scsi_status union
Date:   Mon, 19 Apr 2021 17:07:25 -0700
Message-Id: <20210420000845.25873-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210420000845.25873-1-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

An explanation of the purpose of this patch is available in the patch
"scsi: Introduce the scsi_status union".

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 90ad34c6ef8e..686b9d2bd94a 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2215,7 +2215,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 		bio = rq->bio;
 
 		blk_execute_rq(cdi->disk, rq, 0);
-		if (scsi_req(rq)->result) {
+		if (scsi_req(rq)->status.combined) {
 			struct scsi_sense_hdr sshdr;
 
 			ret = -EIO;
