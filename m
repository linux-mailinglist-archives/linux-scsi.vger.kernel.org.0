Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF121C8ED0
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgEGO3t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 10:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgEGO3t (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 10:29:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9AA208D6;
        Thu,  7 May 2020 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861788;
        bh=06ndIgCZI4ggrsVfN2LGTIb2q7MnraO4TFqut1b1ySg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdkgS+74VBvwOCfa5Ya4QTsI8rIdcLXhaWhSjzfoaiatCScGzu5uWxRMiyS60Tdb6
         wrw1W0nFhZJ6bl3jjX2QPyKMQDj7GguqYGhm82YO72YZ29wSn4b7owW78ARAVxZRNN
         gWlrmnlo6SSJgiIEGrJ3O2aU22d1a8tkrMtIOyoo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/16] scsi: target/iblock: fix WRITE SAME zeroing
Date:   Thu,  7 May 2020 10:29:31 -0400
Message-Id: <20200507142943.26848-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142943.26848-1-sashal@kernel.org>
References: <20200507142943.26848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit 1d2ff149b263c9325875726a7804a0c75ef7112e ]

SBC4 specifies that WRITE SAME requests with the UNMAP bit set to zero
"shall perform the specified write operation to each LBA specified by the
command".  Commit 2237498f0b5c ("target/iblock: Convert WRITE_SAME to
blkdev_issue_zeroout") modified the iblock backend to call
blkdev_issue_zeroout() when handling WRITE SAME requests with UNMAP=0 and a
zero data segment.

The iblock blkdev_issue_zeroout() call incorrectly provides a flags
parameter of 0 (bool false), instead of BLKDEV_ZERO_NOUNMAP.  The bool
false parameter reflects the blkdev_issue_zeroout() API prior to commit
ee472d835c26 ("block: add a flags argument to (__)blkdev_issue_zeroout")
which was merged shortly before 2237498f0b5c.

Link: https://lore.kernel.org/r/20200419163109.11689-1-ddiss@suse.de
Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_iblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 60429011292a2..2a9e023f54291 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -447,7 +447,7 @@ iblock_execute_zero_out(struct block_device *bdev, struct se_cmd *cmd)
 				target_to_linux_sector(dev, cmd->t_task_lba),
 				target_to_linux_sector(dev,
 					sbc_get_write_same_sectors(cmd)),
-				GFP_KERNEL, false);
+				GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 	if (ret)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-- 
2.20.1

