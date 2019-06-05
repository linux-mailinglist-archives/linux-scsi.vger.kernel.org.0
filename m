Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB1354D8
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 03:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFEBHC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 21:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFEBHC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 21:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEB85C05FBCB;
        Wed,  5 Jun 2019 01:06:42 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDFDD6014C;
        Wed,  5 Jun 2019 01:06:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH V2 1/3] scsi: lib/sg_pool.c: clear 'first_chunk' in case of no pre-allocation
Date:   Wed,  5 Jun 2019 09:06:21 +0800
Message-Id: <20190605010623.12325-2-ming.lei@redhat.com>
In-Reply-To: <20190605010623.12325-1-ming.lei@redhat.com>
References: <20190605010623.12325-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 05 Jun 2019 01:07:02 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If user doesn't ask to pre-allocate by passing zero 'nents_first_chunk' to
sg_alloc_table_chained, we need to make sure that 'first_chunk' is cleared.
Otherwise, __sg_alloc_table() still may think that the 1st SGL should
be from the pre-allocation.

Fixes the issue by clearing 'first_chunk' in sg_alloc_table_chained() if
'nents_first_chunk' is zero.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/sg_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index 47eecbe094d8..e042a1722615 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -122,7 +122,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
 	}
 
 	/* User supposes that the 1st SGL includes real entry */
-	if (nents_first_chunk == 1) {
+	if (nents_first_chunk <= 1) {
 		first_chunk = NULL;
 		nents_first_chunk = 0;
 	}
-- 
2.20.1

