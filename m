Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836736914B
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhDWLk5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:40:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242253AbhDWLkj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D471B1BA;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/39] scsi: add translate_msg_byte()
Date:   Fri, 23 Apr 2021 13:39:21 +0200
Message-Id: <20210423113944.42672-17-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add helper to convert message byte into a host byte code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/scsi/scsi_cmnd.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 0ac18a7d8ac6..348bfa568f72 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -337,6 +337,23 @@ static inline unsigned char get_host_byte(struct scsi_cmnd *cmd)
 }
 
 
+static inline void translate_msg_byte(struct scsi_cmnd *cmd, u8 msg)
+{
+	switch (msg) {
+	case COMMAND_COMPLETE:
+		break;
+	case ABORT_TASK_SET:
+		set_host_byte(cmd, DID_ABORT);
+		break;
+	case TARGET_RESET:
+		set_host_byte(cmd, DID_RESET);
+		break;
+	default:
+		set_host_byte(cmd, DID_ERROR);
+		break;
+	}
+}
+
 static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 {
 	unsigned int xfer_len = scmd->sdb.length;
-- 
2.29.2

