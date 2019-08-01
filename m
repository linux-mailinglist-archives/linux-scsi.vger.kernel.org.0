Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4597E1A5
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfHAR5L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5K (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so34517323pff.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJfsDm6wytewMBPR8DNMyfIx43QPB7JvnJuwZRVs3QM=;
        b=N7EwMhfAqQVJOZ0L9ZeRnVWNQNk9YZXMRc9Ynfxo1f0wKhCcDChmu1W/krS/6szuFp
         BSOnBwJtd+kAE4SVmHotrd8lO73l/n422eNBucTYqIJphcl4FNhHecm2puwDlgB3HHGc
         XxEp0arup4nr8iE6bSdAXQGwMxhJ+dx/5jykxzITshyxisKQNyc6QTFOarW2wqVXoW1d
         dH9Yk5MXTSCma6W2Pvem9yJUZBhU5Sw8tp0u6KForvFzODjC6GiWzCFJMM1gK+FcDNJN
         63pQBtxnpi7B6QctssWdJ+04nrErtWX0EGwDqugKwnDskmWMwQYjVC+iXmH0oiAIy+km
         4PqQ==
X-Gm-Message-State: APjAAAX8twwaS/+U5N4Zvrwj2krsOlIvtleFxjZxlx4wJwZE68G8eIBx
        CGH1fH/mqwRiXLUnMIMJVTg=
X-Google-Smtp-Source: APXvYqzKOEFOX5QBC/dUN2u1EuJ+ba8uRGESQpconExgoBxvM1XWg8DTvmG9IevcHjIgiKyz4hkKOQ==
X-Received: by 2002:a63:d301:: with SMTP id b1mr112275113pgg.379.1564682230059;
        Thu, 01 Aug 2019 10:57:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 36/59] qla2xxx: Complain if a soft reset fails
Date:   Thu,  1 Aug 2019 10:55:51 -0700
Message-Id: <20190801175614.73655-37-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Failure of a soft reset is a severe failure. Hence report such failures.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_tmpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index 7ed481dd8ee6..294d77c02cdf 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -429,7 +429,7 @@ qla27xx_fwdt_entry_t266(struct scsi_qla_host *vha,
 	ql_dbg(ql_dbg_misc, vha, 0xd20a,
 	    "%s: reset risc [%lx]\n", __func__, *len);
 	if (buf)
-		qla24xx_soft_reset(vha->hw);
+		WARN_ON_ONCE(qla24xx_soft_reset(vha->hw) != QLA_SUCCESS);
 
 	return qla27xx_next_entry(ent);
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

