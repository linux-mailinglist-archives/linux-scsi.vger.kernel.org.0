Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC72185B9A
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Mar 2020 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgCOJmt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Mar 2020 05:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgCOJms (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 15 Mar 2020 05:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ADC1FACE8;
        Sun, 15 Mar 2020 09:42:47 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>
Subject: [PATCH v2 5/8] scsi: ipr: Use scnprintf() for avoiding potential buffer overflow
Date:   Sun, 15 Mar 2020 10:42:38 +0100
Message-Id: <20200315094241.9086-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200315094241.9086-1-tiwai@suse.de>
References: <20200315094241.9086-1-tiwai@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: no change

 drivers/scsi/ipr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index cd8db1349871..d48a8fa997b9 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -1299,9 +1299,9 @@ static char *__ipr_format_res_path(u8 *res_path, char *buffer, int len)
 	char *p = buffer;
 
 	*p = '\0';
-	p += snprintf(p, buffer + len - p, "%02X", res_path[0]);
+	p += scnprintf(p, buffer + len - p, "%02X", res_path[0]);
 	for (i = 1; res_path[i] != 0xff && ((i * 3) < len); i++)
-		p += snprintf(p, buffer + len - p, "-%02X", res_path[i]);
+		p += scnprintf(p, buffer + len - p, "-%02X", res_path[i]);
 
 	return buffer;
 }
@@ -1322,7 +1322,7 @@ static char *ipr_format_res_path(struct ipr_ioa_cfg *ioa_cfg,
 	char *p = buffer;
 
 	*p = '\0';
-	p += snprintf(p, buffer + len - p, "%d/", ioa_cfg->host->host_no);
+	p += scnprintf(p, buffer + len - p, "%d/", ioa_cfg->host->host_no);
 	__ipr_format_res_path(res_path, p, len - (buffer - p));
 	return buffer;
 }
-- 
2.16.4

