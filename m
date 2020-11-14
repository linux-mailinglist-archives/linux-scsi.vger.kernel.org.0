Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC02E2B2BF1
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Nov 2020 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKNH0R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Nov 2020 02:26:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7897 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgKNH0R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 14 Nov 2020 02:26:17 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CY6MF3c42z75b3;
        Sat, 14 Nov 2020 15:26:01 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Nov 2020 15:26:05 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <subbu.seetharaman@broadcom.com>, <ketan.mukadam@broadcom.com>,
        <jitendra.bhivare@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] scsi: be2iscsi: Mark beiscsi_attrs with static keyword
Date:   Sat, 14 Nov 2020 15:37:54 +0800
Message-ID: <1605339474-22329-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

./be_main.c:167:25: warning: symbol 'beiscsi_attrs' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/scsi/be2iscsi/be_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 202ba92..50e4642 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -164,7 +164,7 @@ DEVICE_ATTR(beiscsi_active_session_count, S_IRUGO,
 	     beiscsi_active_session_disp, NULL);
 DEVICE_ATTR(beiscsi_free_session_count, S_IRUGO,
 	     beiscsi_free_session_disp, NULL);
-struct device_attribute *beiscsi_attrs[] = {
+static struct device_attribute *beiscsi_attrs[] = {
 	&dev_attr_beiscsi_log_enable,
 	&dev_attr_beiscsi_drvr_ver,
 	&dev_attr_beiscsi_adapter_family,
-- 
2.6.2

