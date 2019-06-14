Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC20F45230
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 04:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfFNCym (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 22:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfFNCym (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 22:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8984483F3E;
        Fri, 14 Jun 2019 02:54:41 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0F396012E;
        Fri, 14 Jun 2019 02:54:40 +0000 (UTC)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 14/15] scsi: wd33c93: use sg helper to operate scatterlist
Date:   Fri, 14 Jun 2019 10:53:15 +0800
Message-Id: <20190614025316.7360-15-ming.lei@redhat.com>
In-Reply-To: <20190614025316.7360-1-ming.lei@redhat.com>
References: <20190614025316.7360-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 02:54:41 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

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

