Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21F20329A
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2020 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFVI4o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jun 2020 04:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgFVI4o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Jun 2020 04:56:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8AC9DB16B;
        Mon, 22 Jun 2020 08:56:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi: Only return started requests from scsi_host_find_tag()
Date:   Mon, 22 Jun 2020 08:30:22 +0200
Message-Id: <20200622063022.67891-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

scsi_host_find_tag() is used by the drivers to return a scsi
command based on the command tag. Typically it's used from the
interrupt handler to fetch the command associated with a value
returned from hardware. Some drivers like fnic or qla4xxx, however,
also use it also to traverse outstanding comands.
With the current implementation scsi_host_find_tag() will return
command even if they are not started (ie passed to the driver).
This will result in random errors with those drivers.
With this patch scsi_host_find_tag() will only return 'started'
commands (ie commands which have been passed to the drivers)
thus avoiding the above issue.
The other usecases will be unaffected as the interrupt handler
naturally will only ever return 'started' requests.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/scsi/scsi_tcq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index 6053d46e794e..ea7848e74d25 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -34,7 +34,7 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
 					blk_mq_unique_tag_to_tag(tag));
 	}
 
-	if (!req)
+	if (!req || !blk_mq_request_started(req))
 		return NULL;
 	return blk_mq_rq_to_pdu(req);
 }
-- 
2.16.4

