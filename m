Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF9364F35
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhDTAKq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:10:46 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:44795 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhDTAKa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:10:30 -0400
Received: by mail-pj1-f46.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso3977185pjn.3
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbsMbsq6nRqUrnSZtf9nCLvt+0BkRCYM/J5mmE+0snw=;
        b=D7fLXwDViV8ODRc33lMTc/E8NcDm/FgecCfAOeeB3lj/9Kj8CmKGSgkrO0OP6dY2X+
         zA9Vx+jZNJHcOF4AU3M1sD0ceyYYPVUnK3aUBmbLMe33ArNwl/+g9/RUCxWncVUnntwJ
         sYr8Ei4trCE0/RcKwONop+dzsPMqpIxoEcIbxLZpdLiiuS78Cy/2lBTTCAarN0P2HApK
         M8pWZGlAXxvwe9O9/RLIYXryMHinBFdOPybkxAwy/1htO3i+cfOpcsneyP+F5QwtFazp
         vQrAi3z6czKU4bKgcKm0U3RAOYoE44mL/4+JVrcRkKQIN3eVA0Q/YOCwAtNpU5xcllmn
         aM4w==
X-Gm-Message-State: AOAM5306Od/FVklJ47Ky2dYr75FbquGSP0nHw2ooEy+idlCeUCFG4VlC
        o5Db8ThkszhID1oo3z6yZso=
X-Google-Smtp-Source: ABdhPJzo9XPmeXmkx4hyR9gjo+yHjciCUJN2LD7V1mS2j91CvM7Qh1dzNA7wX1PGqGDQBWBRMkw+0w==
X-Received: by 2002:a17:90a:9409:: with SMTP id r9mr1758312pjo.157.1618877399925;
        Mon, 19 Apr 2021 17:09:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:09:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 059/117] initio: Convert to the scsi_status union
Date:   Mon, 19 Apr 2021 17:07:47 -0700
Message-Id: <20210420000845.25873-60-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/initio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 9b75e19a9bab..b8216da20b35 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2786,7 +2786,7 @@ static void i91uSCBPost(u8 * host_mem, u8 * cblk_mem)
 		break;
 	}
 
-	cmnd->result = cblk->tastat | (cblk->hastat << 16);
+	cmnd->status.combined = cblk->tastat | (cblk->hastat << 16);
 	i91u_unmap_scb(host->pci_dev, cmnd);
 	cmnd->scsi_done(cmnd);	/* Notify system DONE           */
 	initio_release_scb(host, cblk);	/* Release SCB for current channel */
