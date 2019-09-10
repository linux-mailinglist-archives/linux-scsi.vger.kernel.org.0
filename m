Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BCAF372
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Sep 2019 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfIJXo2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Sep 2019 19:44:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfIJXo2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Sep 2019 19:44:28 -0400
Received: by mail-io1-f68.google.com with SMTP id d17so19749943ios.13;
        Tue, 10 Sep 2019 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZGP+PYUf116KpmFZWCQJ/+W1BpD8OneYbmbPw8KI1DY=;
        b=agIEQzR/UIcZsX92ydKv9iYSTD0wKkF0DCdfCvbuRl+mJRlsmk4xv6oXdAgiahYN66
         Y4Q1c3uqGfdg1IWTY8T5VS2bzEO4YTifAiDII2S1ZWE4qCq8jQdhAiMYFsy8Ny7SDa1i
         RXfYurzoCzrqs+1B+eQquaIosJ9qTs67bacbWDhEbp+bhuDtAJoSJ2fs0ADFREjunWBy
         UiNXq4j/j6LSfUZc7/Al3xGpHnxht5yshuaAEMNrtlbZPVklWY2XcluBTm1eBpVv4pNu
         6n0+q3EwwYu6YMWPprH1JbHi2Uu9ZaR2Jluku1++jFb128U92+e23LofkhY5gkwB7hwY
         Liug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZGP+PYUf116KpmFZWCQJ/+W1BpD8OneYbmbPw8KI1DY=;
        b=Vn2eF6QjqBqKG9rCWyHMzAcWxAyjzqoNnmTtmP1drV/AtPZojXG21vO6Yrnrd0w3PE
         D6Ej3hyD9banePwuxeoxD9PJaOZhH6vDSisM4T6cdycmHACIq7Q4y0wNLMJHmBpfx92C
         WnE4PkQBXz9XrBkbHT0/qI0csFhmBgKD4B+pbnRSAiIqSIt4WSSTwSpLo/TOL7Ub4fTj
         pzgVYex3XzJEdoPo2wADo0RBjCbf+JqPDME58Yub8LpfLVerY/I/+jo838cdS9dbfHcN
         cD1eu4BYssjD887++aPPqQnIKLOMNl4pra1065KqKPtIfrEB1T9nwAqxbcC8/weZWeAn
         MbFA==
X-Gm-Message-State: APjAAAVbAnon8+4rQ6lpU3M2lHtSY87bZtAXd06oMDim1otUrO2FXd8d
        LBElDhZf0bU+XXNO4CU1XdQ=
X-Google-Smtp-Source: APXvYqzpHFPcs8wqSh6UDjLhtAgV9r92A+H6PKQaASa8MTnRPf9hCZWEZ/wN9o/vH1jWAEJYkcaPtA==
X-Received: by 2002:a6b:b714:: with SMTP id h20mr37211941iof.302.1568159067609;
        Tue, 10 Sep 2019 16:44:27 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id z20sm19383990iof.38.2019.09.10.16.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 16:44:27 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bfa: release allocated memory in case of error
Date:   Tue, 10 Sep 2019 18:44:15 -0500
Message-Id: <20190910234417.22151-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In bfad_im_get_stats if bfa_port_get_stats fails, allocated memory
needs to be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/scsi/bfa/bfad_attr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index 29ab81df75c0..fbfce02e5b93 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -275,8 +275,10 @@ bfad_im_get_stats(struct Scsi_Host *shost)
 	rc = bfa_port_get_stats(BFA_FCPORT(&bfad->bfa),
 				fcstats, bfad_hcb_comp, &fcomp);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
-	if (rc != BFA_STATUS_OK)
+	if (rc != BFA_STATUS_OK) {
+		kfree(fcstats);
 		return NULL;
+	}
 
 	wait_for_completion(&fcomp.comp);
 
-- 
2.17.1

