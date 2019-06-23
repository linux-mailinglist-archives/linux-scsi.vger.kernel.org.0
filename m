Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268A14F97B
	for <lists+linux-scsi@lfdr.de>; Sun, 23 Jun 2019 04:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFWCJt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 Jun 2019 22:09:49 -0400
Received: from m12-12.163.com ([220.181.12.12]:41649 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfFWCJt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 22 Jun 2019 22:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=bcUzH
        wcwNcHpTEgtv1gvD++aqrRjvtfx21rWjsTmoh8=; b=TJy1eMOEqxAZXe9w7ayAC
        5mVdf0vjAm/zrX86bDjOmtdNx1jAHHSpt8/iQMzyOqR1IXpgFE2FUr66FT6lvWBR
        JACtGKi2MdCq1S9/Q3fNlVWjAeZcP+PQzp9sgPFg/kwIuddqxSDJAusHtekHcrsG
        wi0Pwx6d4IK+yKrYiefvFQ=
Received: from tero-machine (unknown [124.16.84.178])
        by smtp8 (Coremail) with SMTP id DMCowAC3Xvtn3w5dc_FxAw--.37796S3;
        Sun, 23 Jun 2019 10:09:43 +0800 (CST)
Date:   Sun, 23 Jun 2019 10:09:43 +0800
From:   Lin Yi <teroincn@163.com>
To:     QLogic-Storage-Upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_srr
Message-ID: <a5e2a774fe72c62d9a28f101adb41a3600dc3951.1561254730.git.teroincn@163.com>
References: <cover.1561254730.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561254730.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: DMCowAC3Xvtn3w5dc_FxAw--.37796S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW3CrW3XFW8tw1fWFWxWFg_yoWDAwbE93
        yDXrZrWrZxGF9rGr1ktr1Yy3y2yrW7ZF4j9a4Y9FySvFW0v390yrsYvF4DXw13X3yxWFZ8
        JrW8tryqk3Z8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnpMKJUUUUU==
X-Originating-IP: [124.16.84.178]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiLwXcElUMNnnPwAAAs9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

if cb_arg alloc failed, we can't release orig_io_req refcount before
we take it's refcount. call kref_get before malloc, so as to pair with
the kref_put on the srr_err path.

Signed-off-by: Lin Yi <teroincn@163.com>
---
 drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index 709bb92..c201ddf 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -633,13 +633,13 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req, u32 offset, u8 r_ctl)
 	BNX2FC_IO_DBG(orig_io_req, "Sending SRR\n");
 	memset(&srr, 0, sizeof(srr));
 
+	kref_get(&orig_io_req->refcount);
 	cb_arg = kzalloc(sizeof(struct bnx2fc_els_cb_arg), GFP_ATOMIC);
 	if (!cb_arg) {
 		printk(KERN_ERR PFX "Unable to allocate cb_arg for SRR\n");
 		rc = -ENOMEM;
 		goto srr_err;
 	}
-	kref_get(&orig_io_req->refcount);
 
 	cb_arg->aborted_io_req = orig_io_req;
 
-- 
1.9.1


