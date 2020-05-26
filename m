Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B703D1A9814
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408356AbgDOJMO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Apr 2020 05:12:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408348AbgDOJML (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Apr 2020 05:12:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25C2ACC36F596187A371;
        Wed, 15 Apr 2020 17:12:06 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 17:12:00 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 2/3] scsi: fnic: make fnic_list and fnic_list_lock static
Date:   Wed, 15 Apr 2020 17:38:08 +0800
Message-ID: <20200415093809.9365-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200415093809.9365-1-yanaijie@huawei.com>
References: <20200415093809.9365-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/fnic/fnic_main.c:52:1: warning: symbol 'fnic_list' was not
declared. Should it be static?
drivers/scsi/fnic/fnic_main.c:53:1: warning: symbol 'fnic_list_lock' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/fnic/fnic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 18584ab27c32..7910b573bacb 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -49,8 +49,8 @@
 
 static struct kmem_cache *fnic_sgl_cache[FNIC_SGL_NUM_CACHES];
 static struct kmem_cache *fnic_io_req_cache;
-LIST_HEAD(fnic_list);
-DEFINE_SPINLOCK(fnic_list_lock);
+static LIST_HEAD(fnic_list);
+static DEFINE_SPINLOCK(fnic_list_lock);
 
 /* Supported devices by fnic module */
 static struct pci_device_id fnic_id_table[] = {
-- 
2.21.1

