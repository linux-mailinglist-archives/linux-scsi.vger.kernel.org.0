Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B22F4733
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAMJHT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbhAMJHN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:07:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44289B8F1;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 27/35] scsi: add 'set_status_byte()' accessor
Date:   Wed, 13 Jan 2021 10:04:52 +0100
Message-Id: <20210113090500.129644-28-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add the missing 'set_status_byte()' accessor function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 include/scsi/scsi_cmnd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 69ade4fb71aa..ace15b5dc956 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -308,6 +308,11 @@ static inline struct scsi_data_buffer *scsi_prot(struct scsi_cmnd *cmd)
 #define scsi_for_each_prot_sg(cmd, sg, nseg, __i)		\
 	for_each_sg(scsi_prot_sglist(cmd), sg, nseg, __i)
 
+static inline void set_status_byte(struct scsi_cmnd *cmd, char status)
+{
+	cmd->result = (cmd->result & 0xffffff00) | status;
+}
+
 static inline void set_msg_byte(struct scsi_cmnd *cmd, char status)
 {
 	cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
-- 
2.29.2

