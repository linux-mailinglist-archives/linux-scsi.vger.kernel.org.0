Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85799642F2
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGJHdv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 03:33:51 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:36690 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGJHdv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 10 Jul 2019 03:33:51 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 9744B65CB9B0520C0A0A;
        Wed, 10 Jul 2019 15:33:46 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6A7Vu2q076458;
        Wed, 10 Jul 2019 15:31:56 +0800 (GMT-8)
        (envelope-from yang.bin18@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071015321609-2237267 ;
          Wed, 10 Jul 2019 15:32:16 +0800 
From:   Yang Bin <yang.bin18@zte.com.cn>
To:     lduncan@suse.com
Cc:     cleech@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        " Yang Bin " <yang.bin18@zte.com.cn>
Subject: [PATCH] Check sk before sendpage
Date:   Wed, 10 Jul 2019 15:30:09 +0800
Message-Id: <1562743809-31133-1-git-send-email-yang.bin18@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-10 15:32:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-10 15:31:59,
        Serialize complete at 2019-07-10 15:31:59
X-MAIL: mse-fl2.zte.com.cn x6A7Vu2q076458
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: " Yang Bin "<yang.bin18@zte.com.cn>

Before xmit,iscsi may disconnect just now.
So must check connection sock NULL or not,or kernel will crash for
accessing NULL pointer.

Signed-off-by: Yang Bin <yang.bin18@zte.com.cn>
---
 drivers/scsi/iscsi_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 7bedbe8..a59c49f 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -264,6 +264,9 @@ static int iscsi_sw_tcp_xmit_segment(struct iscsi_tcp_conn *tcp_conn,
 	unsigned int copied = 0;
 	int r = 0;
 
+	if (!sk)
+		return -ENOTCONN;
+
 	while (!iscsi_tcp_segment_done(tcp_conn, segment, 0, r)) {
 		struct scatterlist *sg;
 		unsigned int offset, copy;
-- 
1.8.3.1

