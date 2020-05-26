Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7021A65A0
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Apr 2020 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgDMLeI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Apr 2020 07:34:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbgDMLeH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Apr 2020 07:34:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFCC094B43E8D0143BAE;
        Mon, 13 Apr 2020 19:34:04 +0800 (CST)
Received: from huawei.com (10.175.102.37) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 19:33:55 +0800
From:   Li Bin <huawei.libin@huawei.com>
To:     <dgilbert@interlog.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.com>, <jthumshirn@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH] scsi: sg: add sg_remove_request in sg_common_write
Date:   Mon, 13 Apr 2020 19:28:10 +0800
Message-ID: <1586777290-17271-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the dxfer_len is greater than 256M that the request is invalid,
it should call sg_remove_request in sg_common_write.

Fixes: f930c7043663 ("scsi: sg: only check for dxfer_len greater than 256M")
Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 drivers/scsi/sg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4e6af592..9c0ee19 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -793,8 +793,10 @@ static int get_sg_io_pack_id(int *pack_id, void __user *buf, size_t count)
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
-	if (hp->dxfer_len >= SZ_256M)
+	if (hp->dxfer_len >= SZ_256M) {
+		sg_remove_request(sfp, srp);
 		return -EINVAL;
+	}
 
 	k = sg_start_req(srp, cmnd);
 	if (k) {
-- 
1.7.12.4

