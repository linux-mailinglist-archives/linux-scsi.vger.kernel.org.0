Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA7520AA
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 04:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfFYCe2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 22:34:28 -0400
Received: from m12-17.163.com ([220.181.12.17]:45349 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYCe2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 22:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=V/NHV
        lgeoEcsfWlF6ZsWh7EpLDGp+iF+yROt+7W2jHg=; b=D0DS0WQBVf1MzANWnpx/L
        5EOuB2cmK84CRQ7WHoev765pqbU+aolpNeboS+ViSyf/WJ/cDONjE748Yb6gdsZN
        SuBEvF6QnOQJT+eNtGVc+g+Ipo81RB97dHnoTWoIjdASb0dEqqYWPmQbmkaem+R6
        L4f8xTD/pKHd4fYN/pTDAs=
Received: from tero-machine (unknown [116.136.19.114])
        by smtp13 (Coremail) with SMTP id EcCowABnKf8oiBFdWtdjAw--.29077S3;
        Tue, 25 Jun 2019 10:34:18 +0800 (CST)
Date:   Tue, 25 Jun 2019 10:34:16 +0800
From:   Lin Yi <teroincn@163.com>
To:     skashyap@marvell.com, QLogic-Storage-Upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH v2 1/2] scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount
 imbalance in send_rec
Message-ID: <c0bd1183bc048eeb29f66e71bfac03fc3f6db222.1561429511.git.teroincn@163.com>
References: <cover.1561429511.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561429511.git.teroincn@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: EcCowABnKf8oiBFdWtdjAw--.29077S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18GF1xCw1kWF1xCrW3Jrb_yoWkJwcE93
        yDtr97X3yfJrZrCw1kAr4rJ34ayr1xXFWjqFyYkFySyF1xZ3yUZrs8Zrs7Xry5X3yIg3Z8
        JFW5J3sFkwn8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjsjUUUUUU==
X-Originating-IP: [116.136.19.114]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiShHeElPAF9meigAAse
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

if cb_arg alloc failed, we can't release the struct orig_io_req refcount
before we take it's refcount. As Saurav said, move the rec_err label down to avoid
unnecessary refcount release and nullptr free.

Signed-off-by: Lin Yi <teroincn@163.com>
---
Changes in v2:
  - move the rec_err label down instead of moving kref_get.
---
---
 drivers/scsi/bnx2fc/bnx2fc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index 76e65a3..e33b94f 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -610,7 +610,6 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
 	rc = bnx2fc_initiate_els(tgt, ELS_REC, &rec, sizeof(rec),
 				 bnx2fc_rec_compl, cb_arg,
 				 r_a_tov);
-rec_err:
 	if (rc) {
 		BNX2FC_IO_DBG(orig_io_req, "REC failed - release\n");
 		spin_lock_bh(&tgt->tgt_lock);
@@ -618,6 +617,7 @@ int bnx2fc_send_rec(struct bnx2fc_cmd *orig_io_req)
 		spin_unlock_bh(&tgt->tgt_lock);
 		kfree(cb_arg);
 	}
+rec_err:
 	return rc;
 }
 
-- 
1.9.1


