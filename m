Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E32726EE
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgIUO00 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 10:26:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbgIUO0Z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 10:26:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE0F9E5D82397CE79280;
        Mon, 21 Sep 2020 22:26:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 22:26:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: isci: make isci_remote_device_wait_for_resume_from_abort() static
Date:   Mon, 21 Sep 2020 22:27:24 +0800
Message-ID: <20200921142724.875048-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following sparse warning:

drivers/scsi/isci/remote_device.c:1387:6: warning: symbol
'isci_remote_device_wait_for_resume_from_abort' was not declared. Should
it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/isci/remote_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.c b/drivers/scsi/isci/remote_device.c
index c3f540b55689..b1276f7e49c8 100644
--- a/drivers/scsi/isci/remote_device.c
+++ b/drivers/scsi/isci/remote_device.c
@@ -1384,7 +1384,7 @@ static bool isci_remote_device_test_resume_done(
 	return done;
 }
 
-void isci_remote_device_wait_for_resume_from_abort(
+static void isci_remote_device_wait_for_resume_from_abort(
 	struct isci_host *ihost,
 	struct isci_remote_device *idev)
 {
-- 
2.25.4

