Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBA7B180
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfG3SRe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 14:17:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45379 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbfG3SQq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 14:16:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so30254077pfq.12
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jul 2019 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ejbky3Ait/2fuVRBv/Aea0ZW9E8YvQRjIE68KrxG858=;
        b=g7NxQfqoHmAHu6FjiviV+l42gg60rayxYXW9umctHkawL0+ZOaMmX4rSGjSIgYitw/
         JwYphBkhREl0mc9HGhGRpP4mJRGKBlCHFsIf4zXpF7AwUnneoonMz0J6Fi+rLAp6N6PY
         M/6I/sE+dEfMD36MCDCUmiNTGgs+7tt2vwqqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ejbky3Ait/2fuVRBv/Aea0ZW9E8YvQRjIE68KrxG858=;
        b=J6q7Dg2MVYGtTw8tzZQKkhthGvHlhxdOF1ow7IfLSwlc3JzTEK93Q0k2WF8YG6STv8
         3E0RhXzfzGB1EZYNahAsewBJFwNX4FWkvChdzHGjK0/I685PnjXf/fMW3gAKPishelDT
         X7RMXrOCnRax3UmuQIVRVDMj90ZAJnoo8OUKOAlWtd2oMNI78O4yJ5RkKNHLMgd4xeaC
         XKx2zi+p+/P5q55IXPymbdq2lTKWogmenvws1Rrzl2kZKjtiEoClKBVtyJ23qHSZ1qEd
         v687gUwB/N5hg7kY9lcgwGjrMZH7aXe3E9BQYXn221Xv4UfXuMfgPyZBY1GQSHiznDB+
         EFBA==
X-Gm-Message-State: APjAAAVwCRuGxm/jJrNQdV1wtpfP1u170S4haTnQG1vPP6K/HJwieEy9
        7sVgKqBJUEODMyNyW9Vy21uJ0VYdQscrqQ==
X-Google-Smtp-Source: APXvYqzaS9Quj+uj+10jY75vRg+7pd4gpdEfZ85MzPRqS6VPRENa+I85aezt52LGvJ1whXawhY8vFg==
X-Received: by 2002:a65:680b:: with SMTP id l11mr15407071pgt.35.1564510605774;
        Tue, 30 Jul 2019 11:16:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 56/57] scsi: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:56 -0700
Message-Id: <20190730181557.90391-57-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/scsi/ufs/ufshcd-pltfrm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index d7d521b394c3..f84943553454 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -404,7 +404,6 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "IRQ resource not available\n");
 		err = -ENODEV;
 		goto out;
 	}
-- 
Sent by a computer through tubes

