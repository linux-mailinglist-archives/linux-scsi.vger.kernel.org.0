Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863A8122D4E
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Dec 2019 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfLQNq0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Dec 2019 08:46:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728556AbfLQNqZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Dec 2019 08:46:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFEDE552BDB1ED8734B6;
        Tue, 17 Dec 2019 21:46:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 17 Dec 2019 21:46:12 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] scsi: initio: make initio_state_7() static
Date:   Tue, 17 Dec 2019 21:43:09 +0800
Message-ID: <20191217134309.41649-1-chenzhou10@huawei.com>
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

Fix sparse warning:

drivers/scsi/initio.c:1643:5: warning: symbol 'initio_state_7' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/scsi/initio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 41fd64c..1d39628 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -1640,7 +1640,7 @@ static int initio_state_6(struct initio_host * host)
  *
  */
 
-int initio_state_7(struct initio_host * host)
+static int initio_state_7(struct initio_host * host)
 {
 	int cnt, i;
 
-- 
2.7.4

