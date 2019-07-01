Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19BB58910
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF0RpG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 13:45:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfF0RpG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 13:45:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so1590227pfe.6;
        Thu, 27 Jun 2019 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E5PSrIdH38k8HkYvx/lRZBmcEXNwInSCli6rz8zupUE=;
        b=HbEbfsVy0dhIgQtumWKMqbE4ZugwZflXn90XqBlldJgqsvF2KVfAernoa0tkvrKL96
         ijj4XcJQ52DVmnp/dVJ9eCA+lpNxmoKpvHf393j0bZamonbt3nEl5vXbRTkRj9PjWslu
         ua2S6MvqpmZNsiEG6oCkT3mpN+6lfsc/rkeFFFXbAD1SI67/ExA7DH/xkufio7p0E1N/
         7AAIYX4B6qkfa+u0jJ2/HnXqy5Rhy92o7qRdw5bF6aNZGPQTgmkAvTwmLDuyK+rlal20
         kLI+TalyoZppV+dXA4t7K8NgN+dQe+NJ2nfMQYTxZIXBUBlHKowJzTylvREPtDUCJqLM
         EddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E5PSrIdH38k8HkYvx/lRZBmcEXNwInSCli6rz8zupUE=;
        b=qZmPqGHD3btlSzIvco4fXpYxw90BfLigBLpUrIeD8nwuu2aasOOZGlJx4UlVc19a4k
         +Bd8aCTiHMpyuSecGX/nPROeRgob84qmdix7P4AWiJ01o/4ArRr9YfvHqn/lFI3nLiDJ
         aVEDyFovlxa9TbtG5kqiRJxVEf0dCzCcCP9TBz2kqADN8WhYWA5gCpL3QR0AlbHtgJ3j
         ikScnMLxUUaFXESeu0nzzCXlGxGdL5RiKqTsnb+vTur7OsJVGjWsFdJn3tN7MsccDV5n
         4+19Fi9Klv9hMXVf6gGQkR6BRFd5BUksAQ5Wa3hUNhU/wjWnbf8r56xa/dsmG3tTKRKF
         ZUHg==
X-Gm-Message-State: APjAAAXZgUFnY9Gkzl7QJ2M0tAX4+56ISwfffa7p5AmFnF5C1StqhvFM
        /8S1/IB4kNLik7ixVAkKf88=
X-Google-Smtp-Source: APXvYqzN2H+1WkLNaaA/8AhAzVTwkUlYuHGOSlbQmer3dOb4yxYQnynt/Vx6eU5ezCfzwfZyRdVoXQ==
X-Received: by 2002:a65:498f:: with SMTP id r15mr5023618pgs.37.1561657505388;
        Thu, 27 Jun 2019 10:45:05 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h6sm6879656pjs.2.2019.06.27.10.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:05 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 63/87] scsi: ips.c: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:44:57 +0800
Message-Id: <20190627174458.5730-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/ips.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index e8bc8d328bab..ad941bb28060 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -4322,8 +4322,6 @@ ips_allocatescbs(ips_ha_t * ha)
 		return 0;
 	}
 
-	memset(ha->scbs, 0, ha->max_cmds * sizeof (ips_scb_t));
-
 	for (i = 0; i < ha->max_cmds; i++) {
 		scb_p = &ha->scbs[i];
 		scb_p->scb_busaddr = command_dma + sizeof (ips_scb_t) * i;
-- 
2.11.0

