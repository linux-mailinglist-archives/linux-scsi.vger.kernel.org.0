Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5DEAE59
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2019 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfJaLFd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 07:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfJaLFc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 31 Oct 2019 07:05:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A334B379;
        Thu, 31 Oct 2019 11:05:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/24] scsi_error: use DID_TIME_OUT instead of DRIVER_TIMEOUT
Date:   Thu, 31 Oct 2019 12:04:43 +0100
Message-Id: <20191031110452.73463-16-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191031110452.73463-1-hare@suse.de>
References: <20191031110452.73463-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set DID_TIME_OUT instead of DRIVER_TIMEOUT when a command
is finally marked as failed after error recovery.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index bfaac355454b..22893050d574 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2100,10 +2100,10 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
 			/*
 			 * If just we got sense for the device (called
 			 * scsi_eh_get_sense), scmd->result is already
-			 * set, do not set DRIVER_TIMEOUT.
+			 * set, do not set DID_TIME_OUT.
 			 */
 			if (!scmd->result)
-				scmd->result |= (DRIVER_TIMEOUT << 24);
+				scmd->result |= (DID_TIME_OUT << 16);
 			SCSI_LOG_ERROR_RECOVERY(3,
 				scmd_printk(KERN_INFO, scmd,
 					     "%s: flush finish cmd\n",
-- 
2.16.4

