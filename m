Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4573320A073
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2020 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbgFYOBr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 10:01:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405285AbgFYOBr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C30F0AD2C;
        Thu, 25 Jun 2020 14:01:45 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/22] fnic: check for started requests in fnic_wq_copy_cleanup_handler()
Date:   Thu, 25 Jun 2020 16:01:08 +0200
Message-Id: <20200625140124.17201-7-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200625140124.17201-1-hare@suse.de>
References: <20200625140124.17201-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fnic_wq_copy_cleanup_handler() is using scsi_host_find_tag() to
map id to a scsi command. However, as per discussion on the mailinglist
scsi_host_find_tag() might return a non-started request, so we need
to check the returned command with blk_mq_request_started() to avoid
the function tripping over a non-initialized command.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fnic/fnic_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 04879ced2835..13db2181d3fd 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1464,7 +1464,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 		return;
 
 	sc = scsi_host_find_tag(fnic->lport->host, id);
-	if (!sc)
+	if (!sc || !blk_mq_request_started(sc->request))
 		return;
 
 	io_lock = fnic_io_lock_hash(fnic, sc);
-- 
2.16.4

