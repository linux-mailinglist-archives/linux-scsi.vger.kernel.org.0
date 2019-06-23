Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5153B4F976
	for <lists+linux-scsi@lfdr.de>; Sun, 23 Jun 2019 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFWB5d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 Jun 2019 21:57:33 -0400
Received: from m12-18.163.com ([220.181.12.18]:51143 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfFWB5d (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 22 Jun 2019 21:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=JMef+
        uRutfQOKdsdKQKO7/0EiyOC7+7bJzXDGoNgc9E=; b=k+3wmWsiEy+s9o9MNtGbG
        C0WgFGUlRds7h+KcbSDxX2q4AE3M6YeJmIopNvFM1iynHB0M20lfd4Ko1tMX0bv3
        Hmugtmtl1eC1PXV6fNGy0h9aFFsCuZ9Itjy8Y7O243bY+Ea/VsHEjL0u03R69J+S
        qsF9YJAaB+cV8Ho1lhXDyg=
Received: from tero-machine (unknown [124.16.84.178])
        by smtp14 (Coremail) with SMTP id EsCowAD3DNKD3A5dW28JBQ--.14573S3;
        Sun, 23 Jun 2019 09:57:23 +0800 (CST)
Date:   Sun, 23 Jun 2019 09:57:22 +0800
From:   Lin Yi <teroincn@163.com>
To:     QLogic-Storage-Upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org, liujian6@iie.ac.cn, csong@cs.ucr.edu,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_rec
Message-ID: <54a23cc9ea9ad2b7919ef5cec8a70ef18886d644.1561254730.git.teroincn@163.com>
References: <cover.1561254730.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561254730.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: EsCowAD3DNKD3A5dW28JBQ--.14573S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18GF1xCw1kWr1DArW8WFg_yoWDWrXE93
        yqqr97WrZ8CF9rGw1ktr1Yy3yIyw47ZF4j9a4Y9rySvFW0v390vrs5ZF4DWw1aq3yIqFZ8
        JFWayryqy3Z8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8sXo3UUUUU==
X-Originating-IP: [124.16.84.178]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiwAPcElXllxO57AAAss
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

if cb_arg alloc failed, we can't release the struct orig_io_req refcount
before we take it's refcount. call kref_get before malloc, so as to pair
with kref_put on rec_err path.

Signed-off-by: Lin Yi <teroincn@163.com>
---
 drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index 76e65a3..709bb92 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -592,13 +592,13 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
 	BNX2FC_IO_DBG(orig_io_req, "Sending REC\n");
 	memset(&rec, 0, sizeof(rec));
 
+	kref_get(&orig_io_req->refcount);
 	cb_arg = kzalloc(sizeof(struct bnx2fc_els_cb_arg), GFP_ATOMIC);
 	if (!cb_arg) {
 		printk(KERN_ERR PFX "Unable to allocate cb_arg for REC\n");
 		rc = -ENOMEM;
 		goto rec_err;
 	}
-	kref_get(&orig_io_req->refcount);
 
 	cb_arg->aborted_io_req = orig_io_req;
 
-- 
1.9.1


