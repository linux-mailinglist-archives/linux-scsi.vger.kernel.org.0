Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28132682A2
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Sep 2020 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINCbl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Sep 2020 22:31:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgINCbk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 13 Sep 2020 22:31:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59480422421C14DEE23F;
        Mon, 14 Sep 2020 10:31:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 10:31:27 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <martin.petersen@oracle.com>, <bvanassche@acm.org>,
        <michael.christie@oracle.com>, <mlombard@redhat.com>,
        <sudhakar.panneerselvam@oracle.com>, <ddiss@suse.de>,
        <gustavoars@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: target: remove redundant assignment to variable 'ret'
Date:   Mon, 14 Sep 2020 10:32:07 +0800
Message-ID: <20200914023207.113792-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The variable ret has been initialized with a value '0'. The assignment
in switch-case is redundant. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/target/iscsi/iscsi_target.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index cd045dc75a58..f5272ac18b16 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4516,7 +4516,6 @@ int iscsit_logout_post_handler(
 			iscsit_logout_post_handler_closesession(conn);
 			break;
 		}
-		ret = 0;
 		break;
 	case ISCSI_LOGOUT_REASON_CLOSE_CONNECTION:
 		if (conn->cid == cmd->logout_cid) {
@@ -4527,7 +4526,6 @@ int iscsit_logout_post_handler(
 				iscsit_logout_post_handler_samecid(conn);
 				break;
 			}
-			ret = 0;
 		} else {
 			switch (cmd->logout_response) {
 			case ISCSI_LOGOUT_SUCCESS:
-- 
2.17.1

