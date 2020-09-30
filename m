Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E296027E336
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgI3IDD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Sep 2020 04:03:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:60960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgI3IDC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 30 Sep 2020 04:03:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73812AFB1;
        Wed, 30 Sep 2020 08:03:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] scsi: return BLK_STS_AGAIN for ALUA transitioning
Date:   Wed, 30 Sep 2020 10:02:56 +0200
Message-Id: <20200930080256.90964-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200930080256.90964-1-hare@suse.de>
References: <20200930080256.90964-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Whenever we encounter a sense code of ALUA transitioning in
scsi_io_completion() it means that the SCSI midlayer ran out
of retries trying to wait for ALUA transitioning.
In these cases we should be passing up the error, but signalling
that the I/O might be retried, preferably on another path.
So return BLK_STS_AGAIN in these cases.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b628aa0d824c..e6221d65fa8e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -764,6 +764,9 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				case 0x24: /* depopulation in progress */
 					action = ACTION_DELAYED_RETRY;
 					break;
+				case 0x0a: /* ALUA state transistion */
+					blk_stat = BLK_STS_AGAIN;
+					/* fall through */
 				default:
 					action = ACTION_FAIL;
 					break;
-- 
2.16.4

