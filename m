Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F01338189
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhCKXeS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 18:34:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhCKXeC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Mar 2021 18:34:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKUoZ-0006cl-M1; Thu, 11 Mar 2021 23:33:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: sg: return -ENOMEM on out of memory error
Date:   Thu, 11 Mar 2021 23:33:59 +0000
Message-Id: <20210311233359.81305-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The sg_proc_seq_show_debug should return -ENOMEM on an
out of memory error rather than -1. Fix this.

Fixes: 94cda6cf2e44 ("scsi: sg: Rework debug info")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 79f05afa4407..85e86cbc6891 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -4353,7 +4353,7 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	if (!bp) {
 		seq_printf(s, "%s: Unable to allocate %d on heap, finish\n",
 			   __func__, bp_len);
-		return -1;
+		return -ENOMEM;
 	}
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
-- 
2.30.2

