Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBE36EC3
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfFFIee (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 04:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFIed (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 04:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E162A5F79B;
        Thu,  6 Jun 2019 08:34:27 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13A98619ED;
        Thu,  6 Jun 2019 08:34:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH V3 1/3] scsi: lib/sg_pool.c: clear 'first_chunk' in case of no pre-allocation
Date:   Thu,  6 Jun 2019 16:34:08 +0800
Message-Id: <20190606083410.32243-2-ming.lei@redhat.com>
In-Reply-To: <20190606083410.32243-1-ming.lei@redhat.com>
References: <20190606083410.32243-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 06 Jun 2019 08:34:33 +0000 (UTC)
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

Without this patch, the 2nd one can't work.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/sg_pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/sg_pool.c b/lib/sg_pool.c
index 47eecbe094d8..db29e5c1f790 100644
--- a/lib/sg_pool.c
+++ b/lib/sg_pool.c
@@ -103,7 +103,9 @@ EXPORT_SYMBOL_GPL(sg_free_table_chained);
  *
  *  Description:
  *    Allocate and chain SGLs in an sg table. If @nents@ is larger than
- *    @nents_first_chunk a chained sg table will be setup.
+ *    @nents_first_chunk a chained sg table will be setup. @first_chunk is
+ *    ignored if nents_first_chunk <= 1 because user expects the SGL points
+ *    non-chain SGL.
  *
  **/
 int sg_alloc_table_chained(struct sg_table *table, int nents,
@@ -122,7 +124,7 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
 	}
 
 	/* User supposes that the 1st SGL includes real entry */
-	if (nents_first_chunk == 1) {
+	if (nents_first_chunk <= 1) {
 		first_chunk = NULL;
 		nents_first_chunk = 0;
 	}
-- 
2.20.1

