Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A442CEBA9
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbgLDKDP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387782AbgLDKDO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFA45AD5A;
        Fri,  4 Dec 2020 10:01:47 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/37] zfcp: do not set COMMAND_COMPLETE
Date:   Fri,  4 Dec 2020 11:01:17 +0100
Message-Id: <20201204100140.140863-15-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

COMMAND_COMPLETE is defined as '0', and it is a SCSI parallel message
to boot. So drop the call to set_msg_byte().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/s390/scsi/zfcp_fc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fc.h b/drivers/s390/scsi/zfcp_fc.h
index 6902ae1f8e4f..8aaf409ce9cb 100644
--- a/drivers/s390/scsi/zfcp_fc.h
+++ b/drivers/s390/scsi/zfcp_fc.h
@@ -275,7 +275,6 @@ void zfcp_fc_eval_fcp_rsp(struct fcp_resp_with_ext *fcp_rsp,
 	u32 sense_len, resid;
 	u8 rsp_flags;
 
-	set_msg_byte(scsi, COMMAND_COMPLETE);
 	scsi->result |= fcp_rsp->resp.fr_status;
 
 	rsp_flags = fcp_rsp->resp.fr_flags;
-- 
2.16.4

