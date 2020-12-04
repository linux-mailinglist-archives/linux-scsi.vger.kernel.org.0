Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2EB2CEBBF
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgLDKDm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbgLDKDm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F548AF37;
        Fri,  4 Dec 2020 10:01:48 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 31/37] ips: use correct command completion on error
Date:   Fri,  4 Dec 2020 11:01:34 +0100
Message-Id: <20201204100140.140863-32-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A non-zero queuecommand() return code means 'busy', ie the command
hasn't been submitted. So any command which should be failed need
to be completed via the ->scsi_done() callback with the appropriate
result code set.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/ips.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 2e6077c502fc..1a3c534826ba 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1045,10 +1045,10 @@ static int ips_queue_lck(struct scsi_cmnd *SC, void (*done) (struct scsi_cmnd *)
 	ha = (ips_ha_t *) SC->device->host->hostdata;
 
 	if (!ha)
-		return (1);
+		goto out_error;
 
 	if (!ha->active)
-		return (DID_ERROR);
+		goto out_error;
 
 	if (ips_is_passthru(SC)) {
 		if (ha->copp_waitlist.count == IPS_MAX_IOCTL_QUEUE) {
@@ -1123,6 +1123,11 @@ static int ips_queue_lck(struct scsi_cmnd *SC, void (*done) (struct scsi_cmnd *)
 
 	ips_next(ha, IPS_INTR_IORL);
 
+	return (0);
+out_error:
+	SC->result = DID_ERROR << 16;
+	done(SC);
+
 	return (0);
 }
 
-- 
2.16.4

