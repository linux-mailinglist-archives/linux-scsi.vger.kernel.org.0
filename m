Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9605181463
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2020 10:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgCKJQl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Mar 2020 05:16:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:47860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgCKJQk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Mar 2020 05:16:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BBBDAD82;
        Wed, 11 Mar 2020 09:16:37 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        Achim Leubner <achim_leubner@adaptec.com>
Subject: [PATCH 4/8] scsi: gdth: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:16:26 +0100
Message-Id: <20200311091630.22565-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311091630.22565-1-tiwai@suse.de>
References: <20200311091630.22565-1-tiwai@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Achim Leubner <achim_leubner@adaptec.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/scsi/gdth_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/gdth_proc.c b/drivers/scsi/gdth_proc.c
index 381d849726ac..34149842cf1c 100644
--- a/drivers/scsi/gdth_proc.c
+++ b/drivers/scsi/gdth_proc.c
@@ -193,7 +193,7 @@ int gdth_show_info(struct seq_file *m, struct Scsi_Host *host)
         for (i = 1;  i < MAX_RES_ARGS; i++) {
             if (reserve_list[i] == 0xff) 
                 break;
-            hlen += snprintf(hrec + hlen , 161 - hlen, ",%d", reserve_list[i]);
+            hlen += scnprintf(hrec + hlen , 161 - hlen, ",%d", reserve_list[i]);
         }
     }
     seq_printf(m,
-- 
2.16.4

