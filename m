Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B885E76F57
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfGZQtJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:49:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33094 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfGZQtJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 12:49:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so15808458pgj.0
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 09:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWgAO/PUWkxDSsozkfpBkkLPdiQCYYk9g450H0msWuU=;
        b=IgkYAFUe12g5vPXxy3xynIFd3ZQ3Z+Js92ZAAiIVPTKd3ywryXrIZLUDaBVdWzeY0S
         TaIsZmQahrI+Sgbvtj/eLgOTbK+i70Laurwa6k4pliPRM0q/QRZztbVZQFCqM2wZAgrx
         WSchhJ364v9+jeGI06QOkC2r5KWYZixi0wku89KbOCrhcxzA4cEbv1F/7duFWJ8l2SVW
         ZT8cIwavJ09js9ZkXeJvmHyWnOj46sx2U+x5zZ8dOi98cBw4mvoHuxslS8qcVscn9gzg
         NoFH83IDn72unSCFq8C3gHkdMab4P+2t+cgnuuko57rP5LIer8VjLRxYx5/s6OzCVWN9
         IbHw==
X-Gm-Message-State: APjAAAWZtlfkVDEeNuPztdz7LRZcZSJec4ArkWTwEC/lsCiwkeedEpTx
        gUkKEZTrFUqPE7qEKSCQOLs=
X-Google-Smtp-Source: APXvYqyvrcfgJEjY26jsNQzfOeDJrylY7r6DjK6N5LytZh92kRua8ii9aLQq+0/IlpXfZp/G26KW7w==
X-Received: by 2002:a65:68c8:: with SMTP id k8mr7857037pgt.192.1564159748630;
        Fri, 26 Jul 2019 09:49:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm80923246pjc.16.2019.07.26.09.49.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:49:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Palus <jpalus@fastmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] Reduce memory required for SCSI logging
Date:   Fri, 26 Jul 2019 09:48:55 -0700
Message-Id: <20190726164855.130084-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726164855.130084-1-bvanassche@acm.org>
References: <20190726164855.130084-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The data structure used for log messages is so large that it can cause a
boot failure. Since allocations from that data structure can fail anyway,
use kmalloc() / kfree() instead of that data structure.

See also https://bugzilla.kernel.org/show_bug.cgi?id=204119.
See also commit ded85c193a39 ("scsi: Implement per-cpu logging buffer") # v4.0.

Reported-by: Jan Palus <jpalus@fastmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jan Palus <jpalus@fastmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_logging.c | 48 +++----------------------------------
 include/scsi/scsi_dbg.h     |  2 --
 2 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 39b8cc4574b4..c6ed0b12e807 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -15,57 +15,15 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_dbg.h>
 
-#define SCSI_LOG_SPOOLSIZE 4096
-
-#if (SCSI_LOG_SPOOLSIZE / SCSI_LOG_BUFSIZE) > BITS_PER_LONG
-#warning SCSI logging bitmask too large
-#endif
-
-struct scsi_log_buf {
-	char buffer[SCSI_LOG_SPOOLSIZE];
-	unsigned long map;
-};
-
-static DEFINE_PER_CPU(struct scsi_log_buf, scsi_format_log);
-
 static char *scsi_log_reserve_buffer(size_t *len)
 {
-	struct scsi_log_buf *buf;
-	unsigned long map_bits = sizeof(buf->buffer) / SCSI_LOG_BUFSIZE;
-	unsigned long idx = 0;
-
-	preempt_disable();
-	buf = this_cpu_ptr(&scsi_format_log);
-	idx = find_first_zero_bit(&buf->map, map_bits);
-	if (likely(idx < map_bits)) {
-		while (test_and_set_bit(idx, &buf->map)) {
-			idx = find_next_zero_bit(&buf->map, map_bits, idx);
-			if (idx >= map_bits)
-				break;
-		}
-	}
-	if (WARN_ON(idx >= map_bits)) {
-		preempt_enable();
-		return NULL;
-	}
-	*len = SCSI_LOG_BUFSIZE;
-	return buf->buffer + idx * SCSI_LOG_BUFSIZE;
+	*len = 128;
+	return kmalloc(*len, GFP_ATOMIC);
 }
 
 static void scsi_log_release_buffer(char *bufptr)
 {
-	struct scsi_log_buf *buf;
-	unsigned long idx;
-	int ret;
-
-	buf = this_cpu_ptr(&scsi_format_log);
-	if (bufptr >= buf->buffer &&
-	    bufptr < buf->buffer + SCSI_LOG_SPOOLSIZE) {
-		idx = (bufptr - buf->buffer) / SCSI_LOG_BUFSIZE;
-		ret = test_and_clear_bit(idx, &buf->map);
-		WARN_ON(!ret);
-	}
-	preempt_enable();
+	kfree(bufptr);
 }
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
diff --git a/include/scsi/scsi_dbg.h b/include/scsi/scsi_dbg.h
index e03bd9d41fa8..7b196d234626 100644
--- a/include/scsi/scsi_dbg.h
+++ b/include/scsi/scsi_dbg.h
@@ -6,8 +6,6 @@ struct scsi_cmnd;
 struct scsi_device;
 struct scsi_sense_hdr;
 
-#define SCSI_LOG_BUFSIZE 128
-
 extern void scsi_print_command(struct scsi_cmnd *);
 extern size_t __scsi_format_command(char *, size_t,
 				   const unsigned char *, size_t);
-- 
2.22.0.709.g102302147b-goog

