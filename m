Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F236C0F2
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhD0IcT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235191AbhD0IcC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:32:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4547B158;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 31/40] advansys: do not set message byte in SCSI status
Date:   Tue, 27 Apr 2021 10:30:37 +0200
Message-Id: <20210427083046.31620-32-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The host byte in the SCSI status takes precedence during error recovery,
so there is no point in setting the message byte in addition to a host byte
which is not DID_OK.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/advansys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 77c99fe11c81..28748df36c2f 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -6773,14 +6773,12 @@ static void asc_isr_callback(ASC_DVC_VAR *asc_dvc_varp, ASC_QDONE_INFO *qdonep)
 	case QD_ABORTED_BY_HOST:
 		ASC_DBG(1, "QD_ABORTED_BY_HOST\n");
 		set_status_byte(scp, qdonep->d3.scsi_stat);
-		set_msg_byte(scp, qdonep->d3.scsi_msg);
 		set_host_byte(scp, DID_ABORT);
 		break;
 
 	default:
 		ASC_DBG(1, "done_stat 0x%x\n", qdonep->d3.done_stat);
 		set_status_byte(scp, qdonep->d3.scsi_stat);
-		set_msg_byte(scp, qdonep->d3.scsi_msg);
 		set_host_byte(scp, DID_ERROR);
 		break;
 	}
-- 
2.29.2

