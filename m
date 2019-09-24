Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5837FBCE66
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Sep 2019 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404789AbfIXQvj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Sep 2019 12:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410947AbfIXQv3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 24 Sep 2019 12:51:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF19F222BD;
        Tue, 24 Sep 2019 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343888;
        bh=lyaSHlybl3saQoS0Vm8qn2d3taxZeJAkBJEs05fm3uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQXLV6uyTh8k9HkcwwqRf1soenR+hoGu/rJYUogHOxW+CX70S/OpZqRWZ0nWs276K
         P4GF1lMOvpVmdJ7CX36ZI/NKbAWVlLwczCK+xWZ9PKy6RTOKwH+oxw8nQbx9flvf7g
         ddBb9ckjpE1/iYNi5vYdooPqrTYAGg8VFJNprOL8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jan Palus <jpalus@fastmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/28] scsi: core: Reduce memory required for SCSI logging
Date:   Tue, 24 Sep 2019 12:50:30 -0400
Message-Id: <20190924165031.28292-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit dccc96abfb21dc19d69e707c38c8ba439bba7160 ]

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
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_logging.c | 48 +++----------------------------------
 include/scsi/scsi_dbg.h     |  2 --
 2 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index bd70339c1242e..03d9855a6afd7 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -16,57 +16,15 @@
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
index 04e0679767f63..2b5dfae782722 100644
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
2.20.1

