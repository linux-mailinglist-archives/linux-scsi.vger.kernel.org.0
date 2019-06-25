Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896AB520AF
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 04:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfFYCfi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 22:35:38 -0400
Received: from m12-18.163.com ([220.181.12.18]:56756 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYCfi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 22:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=4kgE9
        B4EjtZMlVrCT4vohfg/MVLJcsT13oWB5X56xEw=; b=WXovHuQzxPcj74RP+XmgH
        q1Q+0FLEUxMjW38fkEOqwr72GvO8XtaIrpVtwgG8M/q6wMJ/B/Exnb4mlH1IEKWI
        hobC1jYxvTHFFWCvnwC7rHXrwub3pKixiSHFX69boM4sUfI6lB6Uhq8fKMr+rWeo
        XYTeKYEZSkJ+/SppSTq8TU=
Received: from tero-machine (unknown [116.117.135.205])
        by smtp14 (Coremail) with SMTP id EsCowAD3NeZxiBFd0LTzBQ--.19623S3;
        Tue, 25 Jun 2019 10:35:30 +0800 (CST)
Date:   Tue, 25 Jun 2019 10:35:29 +0800
From:   Lin Yi <teroincn@163.com>
To:     skashyap@marvell.com, QLogic-Storage-Upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH v2 2/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_srr
Message-ID: <ffe1e2d44c08a0132bbd6686b11020ca20e77689.1561429511.git.teroincn@163.com>
References: <cover.1561429511.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561429511.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: EsCowAD3NeZxiBFd0LTzBQ--.19623S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18GF1xCw1kXw17XrW7XFb_yoWkCFcE9w
        4UXr97X3y3GF9rCw1vvr1rA34SyrW7ZF4jvFn09F93tFs7Z3yUZrZ5Zr4DXw15Xw4xWrn8
        XFyUt34qkwn8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnhSdDUUUUU==
X-Originating-IP: [116.117.135.205]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiwBLeElXllz2hqAAAsN
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

if cb_arg alloc failed, we can't release the struct orig_io_req refcount
before we take it's refcount. As Saurav said, move the srr_err label
down to avoid unnecessary refcount release and nullptr free.

Signed-off-by: Lin Yi <teroincn@163.com>
---
Changes in v2:
 -move the srr_err label down instead of moving kref_get.
---
 drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index e33b94f..b807736 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -654,7 +654,6 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req, u32 offset, u8 r_ctl)
 	rc = bnx2fc_initiate_els(tgt, ELS_SRR, &srr, sizeof(srr),
 				 bnx2fc_srr_compl, cb_arg,
 				 r_a_tov);
-srr_err:
 	if (rc) {
 		BNX2FC_IO_DBG(orig_io_req, "SRR failed - release\n");
 		spin_lock_bh(&tgt->tgt_lock);
@@ -664,6 +663,7 @@ int bnx2fc_send_srr(struct bnx2fc_cmd *orig_io_req, u32 offset, u8 r_ctl)
 	} else
 		set_bit(BNX2FC_FLAG_SRR_SENT, &orig_io_req->req_flags);
 
+srr_err:
 	return rc;
 }
 
-- 
1.9.1


