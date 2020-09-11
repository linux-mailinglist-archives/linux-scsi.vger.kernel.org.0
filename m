Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C658D265C36
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgIKJLc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Sep 2020 05:11:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgIKJLY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Sep 2020 05:11:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 037B816F9CD3FF1DE19B;
        Fri, 11 Sep 2020 17:11:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 17:11:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <willy@infradead.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <yanaijie@huawei.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: sym53c8xx_2: remove unneeded semicolon
Date:   Fri, 11 Sep 2020 17:10:31 +0800
Message-ID: <20200911091031.2937834-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following coccinelle warning:

drivers/scsi/sym53c8xx_2/sym_fw.c:372:3-4: Unneeded semicolon
drivers/scsi/sym53c8xx_2/sym_fw.c:480:3-4: Unneeded semicolon
drivers/scsi/sym53c8xx_2/sym_fw.c:536:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/sym53c8xx_2/sym_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_fw.c b/drivers/scsi/sym53c8xx_2/sym_fw.c
index c6db61b61de3..c536d2a9a657 100644
--- a/drivers/scsi/sym53c8xx_2/sym_fw.c
+++ b/drivers/scsi/sym53c8xx_2/sym_fw.c
@@ -369,7 +369,7 @@ void sym_fw_bind_script(struct sym_hcb *np, u32 *start, int len)
 				sym_name(np), (int) (cur-start));
 			++cur;
 			continue;
-		};
+		}
 
 		/*
 		 *  We use the bogus value 0xf00ff00f ;-)
@@ -477,7 +477,7 @@ void sym_fw_bind_script(struct sym_hcb *np, u32 *start, int len)
 		default:
 			relocs = 0;
 			break;
-		};
+		}
 
 		/*
 		 *  Scriptify:) the opcode.
@@ -533,5 +533,5 @@ void sym_fw_bind_script(struct sym_hcb *np, u32 *start, int len)
 
 			*cur++ = cpu_to_scr(new);
 		}
-	};
+	}
 }
-- 
2.25.4

