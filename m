Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D408A348954
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Mar 2021 07:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYGrZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Mar 2021 02:47:25 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:32476 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYGq4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Mar 2021 02:46:56 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id DBCCF980416;
        Thu, 25 Mar 2021 14:46:53 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: scsi: scsi_host_cmd_pool is declared twice
Date:   Thu, 25 Mar 2021 14:46:31 +0800
Message-Id: <20210325064632.855002-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh8YT0kZQkkYGEpNVkpNSk1NTk9DSk9LQkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6Vio*Nz8TMD4NLAIiET1J
        Tw1PCh5VSlVKTUpNTU5PQ0pOS0tMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0xINwY+
X-HM-Tid: 0a786822cb3fd992kuwsdbccf980416
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct scsi_host_cmd_pool has been declared. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/scsi/scsi_host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index e30fd963b97d..5fa8f6a78d05 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -19,7 +19,6 @@ struct scsi_device;
 struct scsi_host_cmd_pool;
 struct scsi_target;
 struct Scsi_Host;
-struct scsi_host_cmd_pool;
 struct scsi_transport_template;
 
 
-- 
2.25.1

