Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1231BF91C
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgD3NUH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgD3NUG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C59FAF24;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH RFC v3 05/41] scsi: add scsi_cmd_from_priv()
Date:   Thu, 30 Apr 2020 15:18:28 +0200
Message-Id: <20200430131904.5847-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Add a functon to retrieve the scsi_cmnd structure from the driver
private allocation data.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 include/scsi/scsi_cmnd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 2cd894fbdcfa..d7bc368e1b4e 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -153,6 +153,16 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
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

