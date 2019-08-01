Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253427E19C
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfHAR46 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34786 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR46 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so32566373plt.1
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/ZNxSVtQZp4IVGCtO+rUeNtPFFznKjHBwNPiIm8JbM=;
        b=uT9FRlgrUsBOLEoL2mkjeJSi8nmQcUoD2YxHkn0rKQWF5ZziydabTLLxG76LCCUIEq
         FHIHcaycki53UDHfQ3fz+9TTysIqNvYC9K5igNTITNDgu7vra3iZc7PYFH/qCz7AkUcI
         xhjrPKDtWWnTrZiUex7U5FBZNR8YEAteHKHUy/O1CZEQhMwpqBrW1p4Mb29TwqJ1it5p
         +7/bJuNaKJCamplcH7Wy7P72qHjuX0tnlRT0hfnBdxveRRiO5znITCcySqs2tKfnWVtF
         F1RJWi4cUrniN2QwXjtu3MvFRAGD8yY53mqKn9sRpZX+t33k+3tG9rmm14Vfl/DIqVBu
         tTWA==
X-Gm-Message-State: APjAAAW4IGsaZwfRrrf9wgANp0xcqp6qXa1Q4q/Ox/wvvhs2GHAeeMzy
        N/RjrVWhT261MkkhpQqXRe2yJdPZ
X-Google-Smtp-Source: APXvYqzW9+lRoLHObdlrZmU0hwyUrzu6FKXoMrz24NOE/iMRdH5JDjmTTmG7CLd2fq/Rq8gGQjHukw==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3mr124706524plt.92.1564682217824;
        Thu, 01 Aug 2019 10:56:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 27/59] qla2xxx: Fix qla24xx_process_bidir_cmd()
Date:   Thu,  1 Aug 2019 10:55:42 -0700
Message-Id: <20190801175614.73655-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set the r??_data_len variables before using these instead of after.

This patch fixes the following Coverity complaint:

const: At condition req_data_len != rsp_data_len, the value of req_data_len
must be equal to 0.
const: At condition req_data_len != rsp_data_len, the value of rsp_data_len
must be equal to 0.
dead_error_condition: The condition req_data_len != rsp_data_len cannot be
true.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: a9b6f722f62d ("[SCSI] qla2xxx: Implementation of bidirectional.") # v3.7.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 11e420f8c493..240b07b0098a 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1782,8 +1782,8 @@ qla24xx_process_bidir_cmd(struct bsg_job *bsg_job)
 	uint16_t nextlid = 0;
 	uint32_t tot_dsds;
 	srb_t *sp = NULL;
-	uint32_t req_data_len = 0;
-	uint32_t rsp_data_len = 0;
+	uint32_t req_data_len;
+	uint32_t rsp_data_len;
 
 	/* Check the type of the adapter */
 	if (!IS_BIDI_CAPABLE(ha)) {
@@ -1888,6 +1888,9 @@ qla24xx_process_bidir_cmd(struct bsg_job *bsg_job)
 		goto done_unmap_sg;
 	}
 
+	req_data_len = bsg_job->request_payload.payload_len;
+	rsp_data_len = bsg_job->reply_payload.payload_len;
+
 	if (req_data_len != rsp_data_len) {
 		rval = EXT_STATUS_BUSY;
 		ql_log(ql_log_warn, vha, 0x70aa,
@@ -1895,10 +1898,6 @@ qla24xx_process_bidir_cmd(struct bsg_job *bsg_job)
 		goto done_unmap_sg;
 	}
 
-	req_data_len = bsg_job->request_payload.payload_len;
-	rsp_data_len = bsg_job->reply_payload.payload_len;
-
-
 	/* Alloc SRB structure */
 	sp = qla2x00_get_sp(vha, &(vha->bidir_fcport), GFP_KERNEL);
 	if (!sp) {
-- 
2.22.0.770.g0f2c4a37fd-goog

