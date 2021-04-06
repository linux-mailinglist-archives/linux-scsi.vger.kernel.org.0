Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD92535516C
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Apr 2021 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbhDFK7c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Apr 2021 06:59:32 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:48898 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhDFK7c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Apr 2021 06:59:32 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A1B8F9803A3;
        Tue,  6 Apr 2021 18:59:21 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scsi: isci/phy.h: Remove unnecessary struct declaration
Date:   Tue,  6 Apr 2021 18:59:13 +0800
Message-Id: <20210406105913.676746-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh0eQh0fH0hLT0hOVkpNSkxMS01MTUpDTUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6Lyo4ED8ICi0ySQxRECMa
        ORYKCxBVSlVKTUpMTEtNTE1JS0JOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUxINwY+
X-HM-Tid: 0a78a6d63e33d992kuwsa1b8f9803a3
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct sci_phy_proto is defined at 142nd line.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/isci/phy.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/isci/phy.h b/drivers/scsi/isci/phy.h
index 45fecfa36a98..5aaf95b14b2e 100644
--- a/drivers/scsi/isci/phy.h
+++ b/drivers/scsi/isci/phy.h
@@ -447,7 +447,6 @@ void sci_phy_get_attached_sas_address(
 	struct isci_phy *iphy,
 	struct sci_sas_address *sas_address);
 
-struct sci_phy_proto;
 void sci_phy_get_protocols(
 	struct isci_phy *iphy,
 	struct sci_phy_proto *protocols);
-- 
2.25.1

