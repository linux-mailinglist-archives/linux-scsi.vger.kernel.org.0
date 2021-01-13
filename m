Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8292F472F
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhAMJHO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbhAMJGz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 805CBB8F7;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 33/35] qla2xxx: fc_remote_port_chkready() returns a SCSI result value
Date:   Wed, 13 Jan 2021 10:04:58 +0100
Message-Id: <20210113090500.129644-34-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fc_remote_port_chkready() returns a SCSI result value, not the
port status. So fixup the value when the remote port isn't set.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index f80abe28f35a..a19833725341 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -957,7 +957,7 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 	srb_t *sp;
 	int rval;
 
-	rval = rport ? fc_remote_port_chkready(rport) : FC_PORTSTATE_OFFLINE;
+	rval = rport ? fc_remote_port_chkready(rport) : (DID_NO_CONNECT << 16);
 	if (rval) {
 		cmd->result = rval;
 		ql_dbg(ql_dbg_io + ql_dbg_verbose, vha, 0x3076,
-- 
2.29.2

