Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2327E191
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfHAR4o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42073 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so34611957pgb.9
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvBMchhM+45KeCMxEPAkz/aAu0TRVuzwMoBt1QL0KVQ=;
        b=PwXsqjJepmEcpRPH+Odm06EJhY9rGLXOE914WomqV/hPpmN35B3iGs6Sys4isF8wO+
         TUS57Dw9F+u1a7xpIoA/yhFybXTzSfdi3eS5wYDgpE+ZXZHQM8QwYH358EyZ6omTJfI0
         xR0oKU5k+vsYi4fDhKW2+FEFY06IAUyHUb8DVhCk2K7yAjN7JHiX0xGaJZo9uuPswUdB
         RanztJ1YlPT+cKalVkafGWP4QM4FRH7bWV7rJk5wTzXIapRFfoI5vI8BkRtsgJOgWjFz
         5H6McA3JMUQUsENJlQeKukJJpvZh8uj9b1E+5/X59XnucM5+Hzz6H/UoUrLPTJqqncuf
         x+hA==
X-Gm-Message-State: APjAAAVF+jlzPmv9owoQIHEjsOROlg9+CA9ZugedMRp8MmQAESUmvqlG
        g3ncd4Ik0ItyoaB5lkhH0ug=
X-Google-Smtp-Source: APXvYqzrgBzQYl0QEov804ZsQCemwv1dcwYu0OG0TG41x+LU41xHgjpxjqQmBPBMQ/05oKA28TQrxQ==
X-Received: by 2002:a62:5487:: with SMTP id i129mr56555184pfb.69.1564682203596;
        Thu, 01 Aug 2019 10:56:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 16/59] qla2xxx: Remove a superfluous pointer check
Date:   Thu,  1 Aug 2019 10:55:31 -0700
Message-Id: <20190801175614.73655-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Checking a pointer after it has been dereferenced is not useful. This was
detected by Coverity.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 16028ee8c7a7..bba25c38a118 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -222,7 +222,7 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	       "%s called for sp=%p, hndl=%x on fcport=%p deleted=%d\n",
 	       __func__, sp, sp->handle, fcport, fcport->deleted);
 
-	if (!ha->flags.fw_started && (fcport && fcport->deleted))
+	if (!ha->flags.fw_started && fcport->deleted)
 		goto out;
 
 	if (ha->flags.host_shutting_down) {
-- 
2.22.0.770.g0f2c4a37fd-goog

