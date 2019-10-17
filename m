Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F8DB7B7
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 21:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439675AbfJQTjp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 15:39:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45050 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437635AbfJQTjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Oct 2019 15:39:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLBcd-0006f2-4o; Thu, 17 Oct 2019 19:39:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-scsi@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 2/8] sg_new_write(): replace access_ok() + __copy_from_user() with copy_from_user()
Date:   Thu, 17 Oct 2019 20:39:19 +0100
Message-Id: <20191017193925.25539-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017193925.25539-1-viro@ZenIV.linux.org.uk>
References: <20191017193659.GA18702@ZenIV.linux.org.uk>
 <20191017193925.25539-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/sg.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 634460421ce4..026628aa556d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -763,11 +763,7 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char __user *buf,
 		sg_remove_request(sfp, srp);
 		return -EMSGSIZE;
 	}
-	if (!access_ok(hp->cmdp, hp->cmd_len)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
-	}
-	if (__copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
+	if (copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
 		sg_remove_request(sfp, srp);
 		return -EFAULT;
 	}
-- 
2.11.0

