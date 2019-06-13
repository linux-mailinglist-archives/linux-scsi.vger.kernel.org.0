Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4517A44475
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfFMQhX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbfFMHPJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F08B30C1327;
        Thu, 13 Jun 2019 07:15:09 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B912D1AB;
        Thu, 13 Jun 2019 07:15:07 +0000 (UTC)
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
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 14/15] scsi: wd33c93: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:34 +0800
Message-Id: <20190613071335.5679-15-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 07:15:09 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sg helper to
operate sgl.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/wd33c93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index 74be04f2357c..ae5935c0a149 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -744,7 +744,7 @@ transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
  * source or destination for THIS transfer.
  */
 	if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
-		++cmd->SCp.buffer;
+		cmd->SCp.buffer = sg_next(cmd->SCp.buffer);
 		--cmd->SCp.buffers_residual;
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
 		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-- 
2.20.1

