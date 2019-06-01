Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338343192E
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Jun 2019 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFADJ7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 23:09:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbfFADJ7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 23:09:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D78D7EB97B003E534BD;
        Sat,  1 Jun 2019 11:09:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 11:09:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] scsi: megaraid_sas: Remove unused including <linux/version.h>
Date:   Sat, 1 Jun 2019 03:18:06 +0000
Message-ID: <20190601031806.46753-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index e52837bb6807..c69760775efa 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -25,7 +25,6 @@
  *
  *  Send feedback to: megaraidlinux.pdl@broadcom.com
  */
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>





