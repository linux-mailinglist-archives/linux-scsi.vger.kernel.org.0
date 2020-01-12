Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78A1388F7
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jan 2020 00:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgALX6m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jan 2020 18:58:42 -0500
Received: from smtp.infotech.no ([82.134.31.41]:52118 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387485AbgALX6m (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 Jan 2020 18:58:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 34BE5204255;
        Mon, 13 Jan 2020 00:58:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ckiNdJh7LHxr; Mon, 13 Jan 2020 00:58:39 +0100 (CET)
Received: from xtwo70.bingwo.ca (unknown [213.52.86.138])
        by smtp.infotech.no (Postfix) with ESMTPA id 25C8B2042B2;
        Mon, 13 Jan 2020 00:58:02 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v6 36/37] sg: warn v3 write system call users
Date:   Mon, 13 Jan 2020 00:57:54 +0100
Message-Id: <20200112235755.14197-37-dgilbert@interlog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112235755.14197-1-dgilbert@interlog.com>
References: <20200112235755.14197-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Should generate one log message per kernel run when the write()
system call is used with the sg interface version 3. Due to
security concerns suggest that they use ioctl(SG_SUBMIT_v3)
instead.

Sg interface version 1 or 2 based code may also be calling
write() in this context. There is no easy solution for them
(short of upgrading their interface to version 3 or 4), so
don't produce a warning suggesting the conversion will be
simple.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e26efcbb1a41..5b0de8dab05d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -684,6 +684,10 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 				     __func__);
 			return -EPERM;
 		}
+		WARN_ONCE(true, "Please use %s instead of write(),\n%s\n",
+			  "ioctl(SG_SUBMIT_V3)",
+			  "  See: http://sg.danny.cz/sg/sg_v40.html");
+
 		res = sg_v3_submit(filp, sfp, h3p, false, NULL);
 		return res < 0 ? res : (int)count;
 	}
-- 
2.24.1

