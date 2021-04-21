Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841053671DB
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbhDURte (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245090AbhDURtO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EF1FB2FC;
        Wed, 21 Apr 2021 17:48:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/42] advansys: do not set message byte in SCSI status
Date:   Wed, 21 Apr 2021 19:47:42 +0200
Message-Id: <20210421174749.11221-36-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
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

