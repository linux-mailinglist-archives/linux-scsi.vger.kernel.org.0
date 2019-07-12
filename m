Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67C466367
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfGLBmm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfGLBmm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Jul 2019 21:42:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A12D683F42;
        Fri, 12 Jul 2019 01:42:42 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A40655D772;
        Fri, 12 Jul 2019 01:42:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH] scsi: fix race on creating sense cache
Date:   Fri, 12 Jul 2019 09:42:31 +0800
Message-Id: <20190712014231.5084-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 12 Jul 2019 01:42:42 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When scsi_init_sense_cache(host) is called concurrently from different
hosts, each code path may see that the cache isn't created, then try
to create a new one, then the created sense cache may be overrided and
leaked.

Fixes the issue by moving 'mutex_lock(&scsi_sense_cache_mutex)' before
scsi_select_sense_cache().

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e07a376a8c38..7493680ec104 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -72,11 +72,11 @@ int scsi_init_sense_cache(struct Scsi_Host *shost)
 	struct kmem_cache *cache;
 	int ret = 0;
 
+	mutex_lock(&scsi_sense_cache_mutex);
 	cache = scsi_select_sense_cache(shost->unchecked_isa_dma);
 	if (cache)
-		return 0;
+		goto exit;
 
-	mutex_lock(&scsi_sense_cache_mutex);
 	if (shost->unchecked_isa_dma) {
 		scsi_sense_isadma_cache =
 			kmem_cache_create("scsi_sense_cache(DMA)",
@@ -92,7 +92,7 @@ int scsi_init_sense_cache(struct Scsi_Host *shost)
 		if (!scsi_sense_cache)
 			ret = -ENOMEM;
 	}
-
+ exit:
 	mutex_unlock(&scsi_sense_cache_mutex);
 	return ret;
 }
-- 
2.20.1

