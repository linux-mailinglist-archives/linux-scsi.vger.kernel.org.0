Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2943496F2
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFRBjX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 21:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfFRBjX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37EE830872F3;
        Tue, 18 Jun 2019 01:39:23 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F88C60922;
        Tue, 18 Jun 2019 01:39:19 +0000 (UTC)
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
Subject: [PATCH V5 12/16] scsi: imm: use sg helper to operate scatterlist
Date:   Tue, 18 Jun 2019 09:37:53 +0800
Message-Id: <20190618013757.22401-13-ming.lei@redhat.com>
In-Reply-To: <20190618013757.22401-1-ming.lei@redhat.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 18 Jun 2019 01:39:23 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/imm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 64ae418d29f3..56d29f157749 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -686,7 +686,7 @@ static int imm_completion(struct scsi_cmnd *cmd)
 		if (cmd->SCp.buffer && !cmd->SCp.this_residual) {
 			/* if scatter/gather, advance to the next segment */
 			if (cmd->SCp.buffers_residual--) {
-				cmd->SCp.buffer++;
+				cmd->SCp.buffer = sg_next(cmd->SCp.buffer);
 				cmd->SCp.this_residual =
 				    cmd->SCp.buffer->length;
 				cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-- 
2.20.1

