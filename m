Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6928F900
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Oct 2020 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbgJOS5o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Oct 2020 14:57:44 -0400
Received: from smtp.infotech.no ([82.134.31.41]:43262 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391266AbgJOS5o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 15 Oct 2020 14:57:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1F60A204238;
        Thu, 15 Oct 2020 20:57:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j+hTVM7Rc0O6; Thu, 15 Oct 2020 20:57:39 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 4EC58204193;
        Thu, 15 Oct 2020 20:57:38 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, axboe@kernel.dk, bvanassche@acm.org
Subject: [RESEND PATCH] sgl_alloc_order: fix memory leak
Date:   Thu, 15 Oct 2020 14:57:35 -0400
Message-Id: <20201015185735.5480-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sgl_alloc_order() can fail when 'length' is large on a memory
constrained system. When order > 0 it will potentially be
making several multi-page allocations with the later ones more
likely to fail than the earlier one. So it is important that
sgl_alloc_order() frees up any pages it has obtained before
returning NULL. In the case when order > 0 it calls the wrong
free page function and leaks. In testing the leak was
sufficient to bring down my 8 GiB laptop with OOM.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5d63a8857f36..c448642e0f78 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -514,7 +514,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 		elem_len = min_t(u64, length, PAGE_SIZE << order);
 		page = alloc_pages(gfp, order);
 		if (!page) {
-			sgl_free(sgl);
+			sgl_free_order(sgl, order);
 			return NULL;
 		}
 
-- 
2.25.1

