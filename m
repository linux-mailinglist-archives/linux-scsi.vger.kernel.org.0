Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706272E628
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfE2U3D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:29:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44316 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U3D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:29:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so1527248pll.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlivCYIKpDPKCtYeQKJ9a+QlfYyBxLIyomlEO4RbyIk=;
        b=bW2qcPyIR+yqIJQUscN9s9wH8avMSEzKL8Uhqoiu8zRBTeFL88IWmVcCYnI3gBDTMS
         KMJfktVKRBXSaFaS5emnj32oesjRBhXiovcRARIeMEczTdFsvFLlpWHl4xb+A0LaQH4w
         FQVkWbu+xha5ia1Eq80LMSCRmQ9ws+KVJkELxI9WjSixVnxDVkBDovnrBx35D6opNLU4
         i68f1dwSq2RNGLwqhf8AURJp2YJW7gKCAq5m8Oys4vT8kx5FTE3nfO0QU04iv8fqr+2Z
         DaMCV7k4FLboxYaGm9FtpPJoLLAamkhxUwx9CIbwT7t/ZIvh0Xq4B9+f6cY/vWajioCa
         ZuuQ==
X-Gm-Message-State: APjAAAVDdOya3oOr21PpH5kcVsfz8UDcRyLKhofsyTGpm6l278hVEF+L
        DzzyCz7HRO96BevtTEpidYk=
X-Google-Smtp-Source: APXvYqw/azVurmV4AR4OwJ0jYDmPzdptrhZEFeR1BMFKlLudEdXoCyfiN6EXw6H4zQD4UtljVVLsPw==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3mr4754474plm.305.1559161742134;
        Wed, 29 May 2019 13:29:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Shen Qiyu <shenqiyu@hotmail.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 20/20] qla2xxx: Fix qla24xx_abort_sp_done()
Date:   Wed, 29 May 2019 13:28:26 -0700
Message-Id: <20190529202826.204499-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Avoid that the complete() and sp->free() calls are ignored if aborting
a command times out.

Reported-by: Shen Qiyu <shenqiyu@hotmail.com>
Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index c1a32f4f2234..1970edef2f27 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -109,12 +109,11 @@ static void qla24xx_abort_sp_done(void *ptr, int res)
 	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
-	if (del_timer(&sp->u.iocb_cmd.timer)) {
-		if (sp->flags & SRB_WAKEUP_ON_COMP)
-			complete(&abt->u.abt.comp);
-		else
-			sp->free(sp);
-	}
+	del_timer(&sp->u.iocb_cmd.timer);
+	if (sp->flags & SRB_WAKEUP_ON_COMP)
+		complete(&abt->u.abt.comp);
+	else
+		sp->free(sp);
 }
 
 static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
@@ -127,7 +126,7 @@ static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	sp = qla2xxx_get_qpair_sp(cmd_sp->vha, cmd_sp->qpair, cmd_sp->fcport,
 				  GFP_ATOMIC);
 	if (!sp)
-		goto done;
+		return rval;
 
 	abt_iocb = &sp->u.iocb_cmd;
 	sp->type = SRB_ABT_CMD;
@@ -151,20 +150,17 @@ static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	       cmd_sp->type);
 
 	rval = qla2x00_start_sp(sp);
-	if (rval != QLA_SUCCESS)
-		goto done_free_sp;
+	if (rval != QLA_SUCCESS) {
+		sp->free(sp);
+		return rval;
+	}
 
 	if (wait) {
 		wait_for_completion(&abt_iocb->u.abt.comp);
 		rval = abt_iocb->u.abt.comp_status == CS_COMPLETE ?
 			QLA_SUCCESS : QLA_FUNCTION_FAILED;
-	} else {
-		goto done;
 	}
 
-done_free_sp:
-	sp->free(sp);
-done:
 	return rval;
 }
 
-- 
2.22.0.rc1

