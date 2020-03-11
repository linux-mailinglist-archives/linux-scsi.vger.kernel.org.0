Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC718145F
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2020 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCKJQk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Mar 2020 05:16:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgCKJQj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Mar 2020 05:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC4E8AC1E;
        Wed, 11 Mar 2020 09:16:37 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] scsi: core: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:16:29 +0100
Message-Id: <20200311091630.22565-8-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/scsi/scsi_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index c3a30ba4ae08..6b3644246d3a 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1045,14 +1045,14 @@ sdev_show_blacklist(struct device *dev, struct device_attribute *attr,
 			name = sdev_bflags_name[i];
 
 		if (name)
-			len += snprintf(buf + len, PAGE_SIZE - len,
+			len += scnprintf(buf + len, PAGE_SIZE - len,
 					"%s%s", len ? " " : "", name);
 		else
-			len += snprintf(buf + len, PAGE_SIZE - len,
+			len += scnprintf(buf + len, PAGE_SIZE - len,
 					"%sINVALID_BIT(%d)", len ? " " : "", i);
 	}
 	if (len)
-		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
 static DEVICE_ATTR(blacklist, S_IRUGO, sdev_show_blacklist, NULL);
-- 
2.16.4

