Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7F7E1BA
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfHAR5g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39906 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so34626227pgi.6
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIoAmkpmRlUrF9j0nLZzdR+znNu6Sok7xQ+y6zsuQ44=;
        b=PJopvpFAQqHhJdOnLtlnwRDJ1kjHMpY8iR3VYolO5BBw0pv6dH5wCp6rEkC89QbnGz
         LgLM44s8mwvl0fhgNGVp6wTLu/3+0xpUCSarGlnPS02RNsOiW0nh9K9fn2jigT33zitm
         spGglbh0rvCmiYITRzMW8XZhe/YpWusf+RtgACzZlqeGO0RudQMZuQtvvtQubxHf3etT
         HmVV3+z8UQj/V+dz6oHYQl4uzvaGmOftEbUybTk9dmvfXTJURkRWDlLyzlymj6rc5lmd
         nkIUBfm5laWIUvEQWQVC6WZxRWSFDQTQg+9Jw7ttz713LmugeXsTjaMNpZTXd5wEs2oe
         KARQ==
X-Gm-Message-State: APjAAAW/EwaPayms9+lpudz8cXG29tQLPSUSJEtgA3q4DoaRg1mvxfJK
        cpKLN+9hhSq+hee3nM+PIpk=
X-Google-Smtp-Source: APXvYqwvxSfFdQkIlwa/RkxroS3fmYwkt5pNRnpJ8ZTi8oUGCWhuDQreliQHC0RqePebHZ0+O91WzQ==
X-Received: by 2002:a63:3046:: with SMTP id w67mr83536864pgw.37.1564682255433;
        Thu, 01 Aug 2019 10:57:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 54/59] qla2xxx: Report invalid mailbox status codes
Date:   Thu,  1 Aug 2019 10:56:09 -0700
Message-Id: <20190801175614.73655-55-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It is easy to mix up the QLA_* and the MBS_* status codes. Complain loudly
if that happens.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  | 5 +++++
 drivers/scsi/qla2xxx/qla_init.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 527b2a2708a1..556376ce0259 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -990,6 +990,11 @@ struct mbx_cmd_32 {
 #define MBS_LINK_DOWN_ERROR		0x400B
 #define MBS_DIAG_ECHO_TEST_ERROR	0x400C
 
+static inline bool qla2xxx_is_valid_mbs(unsigned int mbs)
+{
+	return MBS_COMMAND_COMPLETE <= mbs && mbs <= MBS_DIAG_ECHO_TEST_ERROR;
+}
+
 /*
  * ISP mailbox asynchronous event status codes
  */
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f5045b55400b..1e1bc12d2337 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -477,6 +477,9 @@ void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	    fcport->fw_login_state, ea->rc, fcport->login_gen, ea->sp->gen2,
 	    fcport->rscn_gen, ea->sp->gen1, fcport->loop_id);
 
+	WARN_ONCE(!qla2xxx_is_valid_mbs(ea->data[0]), "mbs: %#x\n",
+		  ea->data[0]);
+
 	if (ea->data[0] != MBS_COMMAND_COMPLETE) {
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "%s %8phC: adisc fail: post delete\n",
@@ -1897,6 +1900,9 @@ qla24xx_sync_abort_command(srb_t *sp)
 static void
 qla24xx_handle_prli_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 {
+	WARN_ONCE(!qla2xxx_is_valid_mbs(ea->data[0]), "mbs: %#x\n",
+		  ea->data[0]);
+
 	switch (ea->data[0]) {
 	case MBS_COMMAND_COMPLETE:
 		ql_dbg(ql_dbg_disc, vha, 0x2118,
@@ -1982,6 +1988,9 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 		return;
 	}
 
+	WARN_ONCE(!qla2xxx_is_valid_mbs(ea->data[0]), "mbs: %#x\n",
+		  ea->data[0]);
+
 	switch (ea->data[0]) {
 	case MBS_COMMAND_COMPLETE:
 		/*
-- 
2.22.0.770.g0f2c4a37fd-goog

