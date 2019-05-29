Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC42DE36
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfE2N3V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbfE2N3L (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DB40AF96;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 05/24] scsi: add scsi_cmd_from_priv()
Date:   Wed, 29 May 2019 15:28:42 +0200
Message-Id: <20190529132901.27645-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a command to retrieve the scsi_cmnd structure from the driver
private allocation data.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 include/scsi/scsi_cmnd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 76ed5e4acd38..318f1e729318 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -151,6 +151,16 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 	return cmd + 1;
 }
 
+/*
+ * Return the scsi_cmnd structure located before the driver
+ * private allocation. Only works if cmd_size is set in the
+ * host template.
+ */
+static inline struct scsi_cmnd *scsi_cmd_from_priv(void *priv)
+{
+	return priv - sizeof(struct scsi_cmnd);
+}
+
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-- 
2.16.4

