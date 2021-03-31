Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F07348965
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Mar 2021 07:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCYGwP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Mar 2021 02:52:15 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:54342 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYGwJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Mar 2021 02:52:09 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 4F00E9803C7;
        Thu, 25 Mar 2021 14:52:07 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: struct device is declared twice
Date:   Thu, 25 Mar 2021 14:51:53 +0800
Message-Id: <20210325065153.855812-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS08fTR9LHh1KSx9KVkpNSk1NTk5KSUxNSk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6Pyo4Sz8LKD4hSwwxFEoX
        QhoKCkNVSlVKTUpNTU5OSklMQ09CVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQklCNwY+
X-HM-Tid: 0a78682793edd992kuws4f00e9803c7
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct device has been declared at 133rd line. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/libnvdimm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 01f251b6e36c..89b69e645ac7 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
 
 struct nvdimm_bus;
 struct module;
-struct device;
 struct nd_blk_region;
 struct nd_blk_region_desc {
 	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
-- 
2.25.1

