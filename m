Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE3B3B7F6
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389770AbfFJPEA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 11:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389345AbfFJPEA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 11:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A4A73079B8F;
        Mon, 10 Jun 2019 15:03:51 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94E1C60BF1;
        Mon, 10 Jun 2019 15:03:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
Date:   Mon, 10 Jun 2019 23:03:14 +0800
Message-Id: <20190610150317.29546-3-ming.lei@redhat.com>
In-Reply-To: <20190610150317.29546-1-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Jun 2019 15:03:54 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sgl helper to
operate sgl.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/advansys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 926311c792d5..a242a62caaa1 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -7710,7 +7710,7 @@ adv_get_sglist(struct asc_board *boardp, adv_req_t *reqp,
 				sg_block->sg_ptr = 0L; /* Last ADV_SG_BLOCK in list. */
 				return ADV_SUCCESS;
 			}
-			slp++;
+			slp = sg_next(slp);
 		}
 		sg_block->sg_cnt = NO_OF_SG_PER_BLOCK;
 		prev_sg_block = sg_block;
-- 
2.20.1

