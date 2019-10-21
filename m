Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA4DE89C
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfJUJxl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727908AbfJUJxd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B9C0BAC1;
        Mon, 21 Oct 2019 09:53:29 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/24] scsi: introduce set_status_byte()
Date:   Mon, 21 Oct 2019 11:53:08 +0200
Message-Id: <20191021095322.137969-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021095322.137969-1-hare@suse.de>
References: <20191021095322.137969-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

To be in-line with the other set_XX_byte() functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/scsi/scsi_cmnd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 91bd749a02f7..6932d91472d5 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -307,6 +307,11 @@ static inline struct scsi_data_buffer *scsi_prot(struct scsi_cmnd *cmd)
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
2.16.4

