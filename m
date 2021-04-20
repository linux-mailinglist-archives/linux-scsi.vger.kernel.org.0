Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7651E364F45
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhDTALK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:11:10 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42794 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhDTAKs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:10:48 -0400
Received: by mail-pg1-f178.google.com with SMTP id m12so4674243pgr.9
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QORMlNMRmxZXDVL9hEp4j3rJkvY4FFvn7mnywr/Juk=;
        b=qnuP3KpI/gxJ4n2jXaKPlEspjhwoFzn4o8wgal3aDsRvNe+AJpZwpmo9Mt+GiCpxYy
         qUXAYY3OixPVQOORSaUz7/qI6AKrMyNL1BeuBgpzX8SjQtFxZU7h6bt+S3brWk+mmnmO
         ZAkV54F/iNRNVgyypkW/DSnc7g/loBESZ07A9TV1ToOmeZzCFG0ffD5gIsK2MiFgJyLT
         eDC60VlJnUcSWP4Vydf/Uudy3ztRVu1ZqjWNjD2zITSpLj3Q3s6WKT7YSvKUfsQe9o+Y
         vO7mG57FCsqGkR3Ygdr75tfN9OhnuuzLi3xvCZgR/vG3x0dCZEVXN499geVPbLjwH2TG
         BKKQ==
X-Gm-Message-State: AOAM5336qIlu04ZBVirHN6iTlBecKf4zNjPhjpJEY9bjn7/tQL6rZpqR
        TS6LZmpQAfNK+pXMJdfr+uY=
X-Google-Smtp-Source: ABdhPJwjc6q9hj2uPfe7Dj5VkrgA6vownyfki0tqvn/ad317dR6C7mFA5jZbOKjnvm+k5s43oO2IhA==
X-Received: by 2002:a65:45c3:: with SMTP id m3mr14086000pgr.179.1618877417216;
        Mon, 19 Apr 2021 17:10:17 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:10:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 074/117] ncr53c8xx: Convert to the scsi_status union
Date:   Mon, 19 Apr 2021 17:08:02 -0700
Message-Id: <20210420000845.25873-75-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210420000845.25873-1-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

An explanation of the purpose of this patch is available in the patch
"scsi: Introduce the scsi_status union".

Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ncr53c8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index c76e9f05d042..352df5f9ca77 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -4909,7 +4909,7 @@ void ncr_complete (struct ncb *np, struct ccb *cp)
 	/*
 	**	Check the status.
 	*/
-	cmd->result = 0;
+	cmd->status.combined = 0;
 	if (   (cp->host_status == HS_COMPLETE)
 		&& (cp->scsi_status == SAM_STAT_GOOD ||
 		    cp->scsi_status == SAM_STAT_CONDITION_MET)) {
