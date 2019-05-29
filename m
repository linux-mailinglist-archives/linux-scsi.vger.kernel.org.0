Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2A2E622
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE2U2z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45456 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U2z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so2350220pfm.12
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udvow+ThaT6IgXSZNCj1EsAS5q8smiXFPGPQDNgwg28=;
        b=Uu/DwC9Vz/Dp4dwxnUzmH/7ssppnuyWNTvN6f2L5/gEftTVu7DafZ6F6OxLJo3Tk69
         inPN2gLjg1AWBrGo4UnaAqlvKLW+Cj1NcpFzh3ZvBvLu8me1DJNY3VYhyymEtiTseo9x
         /rD6vKokFgJjRsa5JBuD2smJjcLW1qxY1LpNIg0hy+T3CqpWhqwq04mbODZEUrFFTtxL
         kUCSE+YYUbuEL8usGXyxtPNUYnho8zfipPAG06q2WCTAYQ8ArMKt7FGVD72uy0b9Xd/p
         dWoG2OIs4NuynqIFPuBkWKb0CrxzHPrGx5cim6r97RO4bFtIuG1CXsGTcpbJlkvcJoHu
         OcWA==
X-Gm-Message-State: APjAAAWdbYa/5C491IYiDvZ44J9wgvQUHloJar4eFyJwCN5jbvea6GDv
        SZKrdkTyMpzxAg6XlP6fPUc=
X-Google-Smtp-Source: APXvYqzXbdV+1Cu/nhRyRbuq9qYyGa3HAFt/r76K/AcauYc0Ny2Jam9HXPenDrOY1Cvvz/kHhx2iNw==
X-Received: by 2002:a62:7d10:: with SMTP id y16mr151511422pfc.116.1559161734880;
        Wed, 29 May 2019 13:28:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 14/20] qla2xxx: Simplify qlt_lport_dump()
Date:   Wed, 29 May 2019 13:28:20 -0700
Message-Id: <20190529202826.204499-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the implementation of this function by using the phC format
specifier instead of using explicit for-loops.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 01c9bbbfa256..153f78aeb4b0 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6507,22 +6507,10 @@ void qlt_remove_target_resources(struct qla_hw_data *ha)
 static void qlt_lport_dump(struct scsi_qla_host *vha, u64 wwpn,
 	unsigned char *b)
 {
-	int i;
-
-	pr_debug("qla2xxx HW vha->node_name: ");
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", vha->node_name[i]);
-	pr_debug("\n");
-	pr_debug("qla2xxx HW vha->port_name: ");
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", vha->port_name[i]);
-	pr_debug("\n");
-
-	pr_debug("qla2xxx passed configfs WWPN: ");
+	pr_debug("qla2xxx HW vha->node_name: %8phC\n", vha->node_name);
+	pr_debug("qla2xxx HW vha->port_name: %8phC\n", vha->port_name);
 	put_unaligned_be64(wwpn, b);
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", b[i]);
-	pr_debug("\n");
+	pr_debug("qla2xxx passed configfs WWPN: %8phC\n", b);
 }
 
 /**
-- 
2.22.0.rc1

