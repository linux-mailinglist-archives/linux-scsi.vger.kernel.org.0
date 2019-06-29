Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3F5A7F3
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Jun 2019 03:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF2BCZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 21:02:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43909 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfF2BCZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 21:02:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3305679pgv.10
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=azV1r3kI2De1UK1aLNSrZEl+F3quwpOsTs6ORAV3f/U=;
        b=exOxzW0mQUJI5jG9KbqHRNoEtMgv2Rk6OTpa4sq5AmInZp7kIDz5wW8eCeUZvUZQQ6
         vAzkWqb4TUo8i75aF8JJ+6smTY97vkOp/nEJ9HRHdDU7cE7O2t1Uux8dl0W0U4vAqp4S
         Sb9mTvaQMK60+HGFklKkt2Ma8/x7cydN+Q4SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=azV1r3kI2De1UK1aLNSrZEl+F3quwpOsTs6ORAV3f/U=;
        b=hQm7OCFoLkqjzVIsPAB7rdWhm7NKSL4IJnOULPcaOtTfrO7Q0Hk5rkeE6+jVw/Gzp1
         tdDdSNrq2pPWVkyoGLHo/of6uFUcMuyskPvj70LBz7hjPPOYgt3SM2OpwY70ssyn5JMX
         4H0ARXpm8i4fBM4C5JvEO/QxnoaJ7Ksgbg1ZAGZpcgt8u5UgVwQjPNQPl4Zgl8og9/pf
         J0q6LAQDwucRlBZokuI8Da+F64WO8FpD+icgTj/iJH7U56imJ/nOSqEF6GBs47IrD1UB
         AtOXmomaMz3EeATZNOig36J5o1pZ6UF2dDdR7QaKSQcFJ3CSLqwJpTnj4hK49ld5byt8
         XSYA==
X-Gm-Message-State: APjAAAUIfOjf4Un1LdiVJHOlROVg1/Bj/lascOJQ//0FECO5HNn4VT5z
        Rx57StyN2sBA2JxNsbZvtQLIG0HpwzxQ79HHSRk5Ikg3g2yWTS8lQBuBLc0aecNurmknn0ucPGe
        NjQgCo1Y0ieGB4I+79JEG1V6Avoy4HrgZAhOqKw2pizr8GiebViKFDlF7E/OiX1dpjKppdDLnFo
        OrzBIrmO6faP566/H/da5udSQ=
X-Google-Smtp-Source: APXvYqzTmJqFv9iZ58G6kS5r6RDqAvDjBNIfFiKxg+4MA/CpalepPWTgL0XwhJu0nY0gTU8kXl8Hdw==
X-Received: by 2002:a63:2326:: with SMTP id j38mr12264025pgj.134.1561770144267;
        Fri, 28 Jun 2019 18:02:24 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y11sm5400868pfb.119.2019.06.28.18.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 18:02:22 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] megaraid_sas: Fix calculation of target ID
Date:   Fri, 28 Jun 2019 18:02:12 -0700
Message-Id: <1561770132-27408-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In megasas_get_target_prop(), driver is incorrectly calculating the
target ID for devices with channel 1 and 3.
Due to this, firmware will either fail the command (if there is no
device with the target id sent from driver) or could return the
properties for a target which was not intended.
Devices could end up with the wrong queue depth due to this.

Fix target id calculation for channel 1 and 3.

Fixes: 96188a89cc6d ("scsi: megaraid_sas: NVME interface target prop added")
Cc: stable@vger.kernel.org
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b4c0bbc..9321878 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6558,7 +6558,8 @@ megasas_get_target_prop(struct megasas_instance *instance,
 	int ret;
 	struct megasas_cmd *cmd;
 	struct megasas_dcmd_frame *dcmd;
-	u16 targetId = (sdev->channel % 2) + sdev->id;
+	u16 targetId = ((sdev->channel % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) +
+			sdev->id;
 
 	cmd = megasas_get_cmd(instance);
 
-- 
2.9.5

