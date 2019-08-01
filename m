Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF947E195
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbfHAR4t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45892 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4t (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so34494954pfq.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKQacSRFGiN2heV5if416D38Fx30/YZvL78fYK/9YLQ=;
        b=m6zgJSaePmKMwQSdrT2sHI5bpHn/ZxKNv8tFVrAWDKvCyfwfgr3YxqKc+l+lTqDXDB
         bucl+DOwi/jy0hhaQwoFBK7+c9JIq1EWfnJwtlgsX8m4wWepO73IzDuS1sFhFMpddp+G
         LYQ+TJvnQMeiUT6cGjJMUgl6drqpJPiCcqb9Xs0VUvBVmeQnXglauAl6h3pD/h8H4/4H
         5VPthG98mDAzuK1o3+7ldYXcb2jMfX6FvzLN2+NCRz4TEQnKXKJQCXjOH/RY1T1X5n4m
         MDvIpbRuVXfQAxX2r5Uzsz3aQNbTj1NNQ/RNBgK+Tp34EIgBe/vHnlhjcNbjaJaT4eHY
         OK3g==
X-Gm-Message-State: APjAAAXCTFfqzFqL1mHXumHNCsv7No9hBhjsp9GHpwL3yHNFueO9IRT/
        11H6r2JBgloggP0foG4ry6E=
X-Google-Smtp-Source: APXvYqz+nzd9thFk4dtRRtzyoQNiuL6gmQyVb0ZC00fUzlveOHuF/OIXP1k3fsqrPRN6GGPQl/O/7A==
X-Received: by 2002:a62:b411:: with SMTP id h17mr52547396pfn.99.1564682208685;
        Thu, 01 Aug 2019 10:56:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 20/59] qla2xxx: Report the firmware status code if a mailbox command fails
Date:   Thu,  1 Aug 2019 10:55:35 -0700
Message-Id: <20190801175614.73655-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It is helpful when debugging this driver to have the firmware status
code available if a mailbox command fails. Hence report that firmware
status code.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 133f5f6270ff..783a84606047 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -394,8 +394,12 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			goto premature_exit;
 		}
 
-		if (ha->mailbox_out[0] != MBS_COMMAND_COMPLETE)
+		if (ha->mailbox_out[0] != MBS_COMMAND_COMPLETE) {
+			ql_dbg(ql_dbg_mbx, vha, 0x11ff,
+			       "mb_out[0] = %#x <> %#x\n", ha->mailbox_out[0],
+			       MBS_COMMAND_COMPLETE);
 			rval = QLA_FUNCTION_FAILED;
+		}
 
 		/* Load return mailbox registers. */
 		iptr2 = mcp->mb;
-- 
2.22.0.770.g0f2c4a37fd-goog

