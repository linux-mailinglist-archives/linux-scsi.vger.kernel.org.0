Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D33A22F3
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Jun 2021 05:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJDsE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Jun 2021 23:48:04 -0400
Received: from m12-13.163.com ([220.181.12.13]:52841 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJDsD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Jun 2021 23:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RFwL8
        GpeR/t6d2HZP3gGNeEF5b9FiHYtpFiI/kYqrWA=; b=LOmuAO1dGzN6sjlta7CyU
        WsN5DvCFvoZALGchxTMsa4DCtd8cdKxqCgkG6ellAAUykxcX90/L9HKsMNFdU6VX
        TIc2EIV5Tgusatu/7MWLyVQjNSzOB8H+3R+xuhILQy07nmYQ5AIsABcyjbkshvKk
        qTtdfjw7ywm6iJ5QuZ389o=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAA3O3vcisFgym0nFg--.19344S2;
        Thu, 10 Jun 2021 11:45:32 +0800 (CST)
From:   lijian_8010a29@163.com
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] scsi: lpfc: lpfc_attr: fix a typo
Date:   Thu, 10 Jun 2021 11:44:35 +0800
Message-Id: <20210610034435.36288-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA3O3vcisFgym0nFg--.19344S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF17tF1DKr1rWFyDXF1DWrg_yoW8tw1fpa
        93Way0yr4qgF97tr43ur4DZ3W5Kw4fKryjkanFy343uFWrK3y7XFyrCrWYy3s3GF1rJ3ZF
        yrs293sruFWjvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGpBfUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqxetUFUMZxOpxAABsA
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijian <lijian@yulong.com>

change 'pointer the' to 'pointer to'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 0975a8b252a0..551eab52c0b6 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2255,7 +2255,7 @@ static inline bool lpfc_rangecheck(uint val, uint min, uint max)
 
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2346,7 +2346,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * takes a default argument, a minimum and maximum argument.
  *
  * lpfc_##attr##_init: Initializes an attribute.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Validates the min and max values then sets the adapter config field
@@ -2379,7 +2379,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
  * into a function with the name lpfc_hba_queue_depth_set
  *
  * lpfc_##attr##_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2508,7 +2508,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * lpfc_##attr##_init: validates the min and max values then sets the
  * adapter config field accordingly, or uses the default if out of range
  * and prints an error message.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Returns:
@@ -2540,7 +2540,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
  * lpfc_##attr##_set: validates the min and max values then sets the
  * adapter config field if in the valid range. prints error message
  * and does not set the parameter if invalid.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val:	integer attribute value.
  *
  * Returns:
-- 
2.25.1


