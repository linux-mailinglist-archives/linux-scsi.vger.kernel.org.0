Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B6369145
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbhDWLko (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:40:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhDWLkd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CD92B1AE;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/39] xen-scsifront: compability status handling
Date:   Fri, 23 Apr 2021 13:39:17 +0200
Message-Id: <20210423113944.42672-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The Xen guest might run against arbitrary backends, so the driver
might receive a status with driver_byte set. Map these errors
to DID_ERROR to be consistent with recent changes.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/xen-scsifront.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 259fc248d06c..0d813a2d9ad2 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -251,6 +251,7 @@ static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 	struct scsi_cmnd *sc;
 	uint32_t id;
 	uint8_t sense_len;
+	int result;
 
 	id = ring_rsp->rqid;
 	shadow = info->shadow[id];
@@ -261,7 +262,12 @@ static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 	scsifront_gnttab_done(info, shadow);
 	scsifront_put_rqid(info, id);
 
-	sc->result = ring_rsp->rslt;
+	result = ring_rsp->rslt;
+	if ((result >> 24) & 0xff)
+		set_host_byte(sc, DID_ERROR);
+	else
+		set_host_byte(sc, host_byte(result));
+	set_status_byte(sc, result & 0xff);
 	scsi_set_resid(sc, ring_rsp->residual_len);
 
 	sense_len = min_t(uint8_t, VSCSIIF_SENSE_BUFFERSIZE,
-- 
2.29.2

