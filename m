Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66599302037
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 03:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAYCQZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Jan 2021 21:16:25 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45910 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbhAYCDJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 24 Jan 2021 21:03:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1FEB920429C;
        Mon, 25 Jan 2021 02:27:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bABLGizCRbXy; Mon, 25 Jan 2021 02:27:48 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 1218A2042BF;
        Mon, 25 Jan 2021 02:27:37 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH v14 38/45] sg: warn v3 write system call users
Date:   Sun, 24 Jan 2021 20:26:43 -0500
Message-Id: <20210125012650.269411-39-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125012650.269411-1-dgilbert@interlog.com>
References: <20210125012650.269411-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 5ea10eb08361..9b1686c093bf 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -645,6 +645,9 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 				     __func__);
 			return -EPERM;
 		}
+		pr_warn_once("Please use %s instead of write(),\n%s\n",
+			     "ioctl(SG_SUBMIT_V3)",
+			     "  See: http://sg.danny.cz/sg/sg_v40.html");
 		res = sg_v3_submit(filp, sfp, h3p, false, NULL);
 		return res < 0 ? res : (int)count;
 	}
-- 
2.25.1

