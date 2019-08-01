Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54B07E1B7
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfHAR5d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfHAR5c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so34499925pfp.7
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/j8uQ3wNY8xsIbeKUIwgMhWQAU5eKGw9PlWIulpZ1yU=;
        b=GhWXxn6q3UZtEd2hRLnRGi/URLGw15VF5LNvbGEVb0SOSr9Os0n899M4/0uHZ0/x3O
         BGnH+mxMFbKsCoVcNGKoU9prJNz8eJF0PtI7qKt4fIOPXMRRhEThNHKhDS+1VAdRwdzB
         acj3MvrlyUsexgO3m8sWRhMHW4XfxIJ6GuTQHD6nERtec3F4rLZ/x4PTdGsP+xoK0dsd
         s5PVIZlSqZVDM+zUmacMxI1NkapKJRnJ4qS8by3CJ2hhA7jmYHwqx3WJQqStp8g0T1xx
         iEvRYXzYPSztxr7zW2skT42Ngww0PD8Hr2AifA+OAcL+fSmpG7pq3t1jHGFqMVbCkDIZ
         xs+w==
X-Gm-Message-State: APjAAAUeN+Xs6pA3p5LOStNtbi4GOj6hf6EVZO6/xYbKFbyqFej/T2bE
        bMA3+q4B0flSlgr4dSzrEVs=
X-Google-Smtp-Source: APXvYqxU1x92LdTRIq9GYjN8yMw64IT+/rPel1ZkMy3eIRKP79Glo0OzE3H5/YVg/huYCDoeRBZSEg==
X-Received: by 2002:a63:24a:: with SMTP id 71mr10926428pgc.273.1564682251178;
        Thu, 01 Aug 2019 10:57:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 51/59] qla2xxx: Complain if sp->done() is not called from the completion path
Date:   Thu,  1 Aug 2019 10:56:06 -0700
Message-Id: <20190801175614.73655-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Not calling sp->done() from the command completion path is a severe bug.
Hence complain loudly if that happens.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++++
 drivers/scsi/qla2xxx/qla_isr.c  | 4 ++++
 drivers/scsi/qla2xxx/qla_mr.c   | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 835ca1b147cf..f5045b55400b 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -243,6 +243,10 @@ qla2x00_async_iocb_timeout(void *data)
 			sp->done(sp, QLA_FUNCTION_TIMEOUT);
 		}
 		break;
+	default:
+		WARN_ON_ONCE(true);
+		sp->done(sp, QLA_FUNCTION_TIMEOUT);
+		break;
 	}
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 55eb51539cb0..7533e420e571 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2786,6 +2786,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
+	else
+		WARN_ON_ONCE(true);
 }
 
 /**
@@ -2843,6 +2845,8 @@ qla2x00_status_cont_entry(struct rsp_que *rsp, sts_cont_entry_t *pkt)
 	if (sense_len == 0) {
 		rsp->status_srb = NULL;
 		sp->done(sp, cp->result);
+	} else {
+		WARN_ON_ONCE(true);
 	}
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 06985b2d48eb..605b59c76c90 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -2539,6 +2539,8 @@ qlafx00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
+	else
+		WARN_ON_ONCE(true);
 }
 
 /**
@@ -2616,6 +2618,8 @@ qlafx00_status_cont_entry(struct rsp_que *rsp, sts_cont_entry_t *pkt)
 	if (sense_len == 0) {
 		rsp->status_srb = NULL;
 		sp->done(sp, cp->result);
+	} else {
+		WARN_ON_ONCE(true);
 	}
 }
 
-- 
2.22.0.770.g0f2c4a37fd-goog

