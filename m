Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4ADB7B9
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404674AbfJQTkG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 15:40:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45058 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437669AbfJQTjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Oct 2019 15:39:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLBcd-0006fG-LQ; Thu, 17 Oct 2019 19:39:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-scsi@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 4/8] sg_read(): simplify reading ->pack_id of userland sg_io_hdr_t
Date:   Thu, 17 Oct 2019 20:39:21 +0100
Message-Id: <20191017193925.25539-4-viro@ZenIV.linux.org.uk>
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

We don't need to allocate a temporary buffer and read the entire
structure in it, only to fetch a single field and free what we'd
allocated.  Just use get_user() and be done with it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/sg.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4c62237cdf37..2d30e89075e9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -441,17 +441,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 		}
 		if (old_hdr->reply_len < 0) {
 			if (count >= SZ_SG_IO_HDR) {
-				sg_io_hdr_t *new_hdr;
-				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
-				if (!new_hdr) {
-					retval = -ENOMEM;
-					goto free_old_hdr;
-				}
-				retval =__copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
-				req_pack_id = new_hdr->pack_id;
-				kfree(new_hdr);
-				if (retval) {
+				sg_io_hdr_t __user *p = (void __user *)buf;
+				if (get_user(req_pack_id, &p->pack_id)) {
 					retval = -EFAULT;
 					goto free_old_hdr;
 				}
-- 
2.11.0

