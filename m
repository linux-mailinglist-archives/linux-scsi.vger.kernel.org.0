Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF95A2573
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Aug 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiHZKHW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Aug 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiHZKGk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Aug 2022 06:06:40 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 03:05:23 PDT
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B55DA3D8
        for <linux-scsi@vger.kernel.org>; Fri, 26 Aug 2022 03:05:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id BB6B7323921
        for <linux-scsi@vger.kernel.org>; Fri, 26 Aug 2022 12:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508012;
        bh=LBWIlWK30yhfxAVXsimqMHYKnAf89TzPKnQAQf9HFMI=;
        h=From:To:Cc:Subject:Date;
        b=s4xOWiKaUMhWGbFoAfyQWefwZM6uODCTId5WCcjsOdHfsFWspOaH7uSOuPScHlWOS
         6LaQpgOUIAt9oZeZE2zWeb4/01DhtzfbC23NrheMXWmF0EoZcRmEuKomnTrEkyhMtm
         70k8i5c17/LwqRTNqx0lnyT8qA3GkVQk0v3fbWNc=
Received: from fx409 (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 316B0323887;
        Fri, 26 Aug 2022 12:00:12 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <112df.630899aa.900ff.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx409.security-mail.net (Postfix) with ESMTPS id B700632363E;
        Fri, 26 Aug 2022 12:00:10 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 71B8027E0396;
        Fri, 26 Aug 2022 12:00:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5BBE227E0392;
        Fri, 26 Aug 2022 12:00:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5BBE227E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508010;
        bh=bs23uoDmvmAdBgCs/WEfBsiYr/X3AOGXBIq7570idWs=;
        h=From:To:Date:Message-Id;
        b=gjm2qMx3TPR+ITEn1OEmCwmTdIzgZ0sIJHbtwcof8mDhcgNjIFbcNg9UGqR9a+Qh/
         Vgrysfeh2GYnGxC/KtyIDq7qn+5HVuWT/Ro8/CyFNdicHLQhnX2Zx4+jbO9tIIg83e
         WLznmWCuk6uSzY/276ou1GrI3VCyCH7n3z0K1lsY=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OzMcBCQRqUFW; Fri, 26 Aug 2022 12:00:10 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 40F1C27E02FA;
        Fri, 26 Aug 2022 12:00:10 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Fix typos in function documentation
Date:   Fri, 26 Aug 2022 11:53:01 +0200
Message-Id: <20220826095321.21548-4-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the redundant `the` in "pointer the the ..." that can be found
in function parameter documentation with "pointer to the ...".

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/scsi/lpfc/lpfc_attr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 09cf2cd0ae60..61857d9554ab 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2438,7 +2438,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
 
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2529,7 +2529,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * takes a default argument, a minimum and maximum argument.
  *
  * lpfc_##attr##_init: Initializes an attribute.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Validates the min and max values then sets the adapter config field
@@ -2562,7 +2562,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
  * into a function with the name lpfc_hba_queue_depth_set
  *
  * lpfc_##attr##_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2691,7 +2691,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * lpfc_##attr##_init: validates the min and max values then sets the
  * adapter config field accordingly, or uses the default if out of range
  * and prints an error message.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val: integer attribute value.
  *
  * Returns:
@@ -2723,7 +2723,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
  * lpfc_##attr##_set: validates the min and max values then sets the
  * adapter config field if in the valid range. prints error message
  * and does not set the parameter if invalid.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer to the adapter structure.
  * @val:	integer attribute value.
  *
  * Returns:
-- 
2.17.1

