Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5D36914C
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242373AbhDWLk6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:40:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242258AbhDWLkj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D361B1B9;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/39] scsi: add get_{status,host}_byte() accessor function
Date:   Fri, 23 Apr 2021 13:39:20 +0200
Message-Id: <20210423113944.42672-16-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add accessor functions for the host and status byte.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/scsi/scsi_cmnd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index a1eb7732aa1b..0ac18a7d8ac6 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -316,6 +316,11 @@ static inline void set_status_byte(struct scsi_cmnd *cmd, char status)
 	cmd->result = (cmd->result & 0xffffff00) | status;
 }
 
+static inline unsigned char get_status_byte(struct scsi_cmnd *cmd)
+{
+	return cmd->result & 0xff;
+}
+
 static inline void set_msg_byte(struct scsi_cmnd *cmd, char status)
 {
 	cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
@@ -326,6 +331,11 @@ static inline void set_host_byte(struct scsi_cmnd *cmd, char status)
 	cmd->result = (cmd->result & 0xff00ffff) | (status << 16);
 }
 
+static inline unsigned char get_host_byte(struct scsi_cmnd *cmd)
+{
+	return (cmd->result >> 16) & 0xff;
+}
+
 
 static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 {
-- 
2.29.2

