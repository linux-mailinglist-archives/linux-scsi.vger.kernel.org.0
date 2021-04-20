Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F70364F2C
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhDTAK3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:10:29 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41581 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhDTAKT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:10:19 -0400
Received: by mail-pg1-f179.google.com with SMTP id f29so25377327pgm.8
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6h0Po38eQMSuTaV8NzuT2Rx3mCZkkRRL+9spYd1sg1Q=;
        b=ESa4cbd5Xopg1XcjT1/cytqlIdBC1zTz5ipKJ0788q1H6OdzMnjh/H0qD90DB2pKjB
         OJkMEG33BbYvCypOspioKAlDNxrg1SLKezEHmQyMcTPBg5gu2pndGufu+9oz0376GXjw
         Lz9qqQtIFZZ6XBsZeUJXnqoAByZsn6uDiP75NCLrYfrPeEvD6ACBO7Kqzci1SNgd7qqU
         eweng6KSMFSgkEQzmr6/NtqnyhJwYMkjZ26DNOZda8SB3v9q+X47UhbnigyN9wdvQls1
         GXdgOSXiCwiK3NgdSUvDcOgXtfRlr7WTYOTIXbycG/V/Z2o4wXS52mLQ6cAWJIwyiWnz
         CGWg==
X-Gm-Message-State: AOAM5336qMKK2lzhn2VbchV+bNzO/nbDr0t0MUYzNLWJ32+27BXiDXn4
        R7oi/sVYxpo5HBxKLyBwdwA=
X-Google-Smtp-Source: ABdhPJxgku8xuvSbqtjDiVD/hKDlqErI/I6WAGZqLoprVx65Gs7Xh0INg51kAhjIWnfhrjqS2miDQw==
X-Received: by 2002:a63:5517:: with SMTP id j23mr14050228pgb.209.1618877388517;
        Mon, 19 Apr 2021 17:09:48 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:09:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 049/117] firewire: sbp2: Convert to the scsi_status union
Date:   Mon, 19 Apr 2021 17:07:37 -0700
Message-Id: <20210420000845.25873-50-bvanassche@acm.org>
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

Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/firewire/sbp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 4d5054211550..667ceb8a76bc 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1374,7 +1374,7 @@ static void complete_command_orb(struct sbp2_orb *base_orb,
 			 sizeof(orb->request), DMA_TO_DEVICE);
 	sbp2_unmap_scatterlist(device->card->device, orb);
 
-	orb->cmd->result = result;
+	orb->cmd->status.combined = result;
 	orb->cmd->scsi_done(orb->cmd);
 }
 
