Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19F105F73
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 06:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVFTH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Nov 2019 00:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKVFTH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Nov 2019 00:19:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BBA20708;
        Fri, 22 Nov 2019 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574399946;
        bh=4UX+CxSvf6A7dtQ3cbPv4or4ULQtD3+cNrsIJxvQDp8=;
        h=From:To:Cc:Subject:Date:From;
        b=lOTXYr2aHwUZ4WyYpdUjHVb7kDRWz9xhzjFHYGzB21gTtsbdMAX26YwAOSOF9LD7K
         SJlaefvbYk8ZSixifF80WhxwqXEjCUPlmi9+yr+H9KxYX2FBAZvhzm6FKtG6eLk2yF
         0JFeK0E5+bfy7oSuZ0wZL5aWsfw/i+i3+cAcIkAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 001/219] scsi: target/tcmu: Fix queue_cmd_ring() declaration
Date:   Fri, 22 Nov 2019 00:15:25 -0500
Message-Id: <20191122051903.31749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit e7f411049f5164ee6db6c3434c07302846f09990 ]

This patch does not change any functionality but avoids that sparse
complains about the queue_cmd_ring() function and its callers.

Fixes: 6fd0ce79724d ("tcmu: prep queue_cmd_ring to be used by unmap wq")
Reviewed-by: David Disseldorp <ddiss@suse.de>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7159e8363b83b..7ee0a75ce4526 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -962,7 +962,7 @@ static int add_to_qfull_queue(struct tcmu_cmd *tcmu_cmd)
  *  0 success
  *  1 internally queued to wait for ring memory to free.
  */
-static sense_reason_t queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, int *scsi_err)
+static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
 {
 	struct tcmu_dev *udev = tcmu_cmd->tcmu_dev;
 	struct se_cmd *se_cmd = tcmu_cmd->se_cmd;
-- 
2.20.1

