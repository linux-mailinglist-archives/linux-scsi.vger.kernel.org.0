Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694136D37D
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfGRSLL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jul 2019 14:11:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42217 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSLL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Jul 2019 14:11:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so28264133lje.9;
        Thu, 18 Jul 2019 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ACngBykYqB0o3NihblCBOiLR+sDnmChE/17QqNQkmcw=;
        b=jItEiZ4smIzaJkxpqnRTFanp5FpRVV/67ycDHQXpzrPJUx6p2owcwNeJImKQR310CW
         kzWda1OmdsgvC/hwoMkcUThzcnaAyihMpvlEJTatPYHAQTsAbsi+ad84rmJC+2s9uVcc
         VLGK5ET37aeorCMQ7iDU/hMxd+X6MggGYi1tyrIcYeNdG7LgNFwzfoQInw8Uz1vDLgmd
         oO9sMR2R9B80MnJbpZoW5NZw4QjXXfanxvFzbDby4tzMMPBcWq18ciQldrvPzEXj8gLa
         dvCMWmL2VmoSpQVYgVflj+/rXLXkk0Q0Mkw6Oe89uDp+Ip8lZLsyVXnovBkT30NPEqkO
         N2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ACngBykYqB0o3NihblCBOiLR+sDnmChE/17QqNQkmcw=;
        b=lDyyO6q2EN7BjeVemhoZ6jjK5an0Z8yQ821HBvOiinWmgU+inoqzjAiYOk9v/bAP/V
         rM40gTfo5wmprWVpF4qj8moTs9LiRXj4mg9tdHbDrkWhiG9DGHFl8RcJmnJ68T/R7zLp
         VZPJQEeuNLNoOk+ANZT9a7PNCHsAWom28sx84AXf+ts3Rr4wwCMAGc/mQ4plZ+nyM/J2
         ScrJJtVbrxY2EpwmdYU1+/q3sWcb3k793qt0Ktugw/PfpUB8zKU4kiPgQkEhXi9Zqd8G
         NbmxEc44an+hczPyvySMElFYIZ1GZIYGv1TQ7Lg8e5mziMncjuAtiBmYum3Wevqu1yjE
         AUvA==
X-Gm-Message-State: APjAAAWBj8YoSBP/hZTaPsL/cQ6gkN6wiMkO1H+G0MmXSXD82uRp/X0o
        KGQ9OZojkXz+rxrFOwTAPuQ=
X-Google-Smtp-Source: APXvYqz/XTtQof1rtC+XVjV+AQYDnfiRRkma3v5LvU9uzKZHguKDa20vmBNi3JFOkSc7d9PhykRxWg==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr5868906ljg.37.1563473469447;
        Thu, 18 Jul 2019 11:11:09 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.90.160.140])
        by smtp.gmail.com with ESMTPSA id k82sm5196001lje.30.2019.07.18.11.11.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:11:08 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     gomonovych@gmail.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: Use dma_pool_zalloc rather than dma_pool_alloc
Date:   Thu, 18 Jul 2019 20:10:51 +0200
Message-Id: <20190718181051.22882-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0
The semantic patch that makes this change is available
in scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/scsi/pmcraid.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 71ff3936da4f945f3d8a798a8b2129ca3c07ec22..f79d7750934e629c6d6edc1a075205247889531d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4653,9 +4653,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 		return -ENOMEM;
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
-		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
-				pinstance->control_pool,
+		pinstance->cmd_list[i]->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
 				GFP_KERNEL,
 				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
 
@@ -4663,8 +4661,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
-- 
2.17.1

