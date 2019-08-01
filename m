Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9512F7E19F
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfHAR5C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:02 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:42234 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:02 -0400
Received: by mail-pl1-f177.google.com with SMTP id ay6so32590387plb.9
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5APb4wpWDF3UHasu2Yr53W5am37wETh1xdW0+DttGs=;
        b=S9hEpVHy9Z5JD9A6kzHo29uilMvfGg8gMzBeehbakrKkgDMdLUDbZXDohFC7Xyf0Oa
         /CPASip2lBS2HOgfnnXWlGU0cfQd/a8lSgkcNGrjWkUocLXS3p2/GRJNctokGEQraWZJ
         JWy+PcCFZL90TPRxsIvyrY8YmDBiFM5Uf5qjP+275RC4x9xhqdgfIC2wlDxmT6TYs4xz
         x+mgv2rjYxSUHsbApJHzEOaFKpH8G5Qk5pVuanyfhvhmhn3mzsoDkkYxGfRUEKHW2vi0
         8nsKDJjODGquFaGDu5oF5/Ik/8nMtFeebylTkSdT/ERHIPPPtkBYIcB8tL77q/xR3A5D
         fVIQ==
X-Gm-Message-State: APjAAAWYhw5oNPykL31TUjm5AVUqIJLnqO904ftiQLrC6Hb7mlgD6Wht
        1oKx2EX1BaK3dhMQqWTI0l0=
X-Google-Smtp-Source: APXvYqxKgmAspFJvp4VHeamAjcqHG50q10IswRE83EYsP8MoENHs8wyUAQWip1JsRnWa4IH4OHT7gA==
X-Received: by 2002:a17:902:383:: with SMTP id d3mr42551327pld.176.1564682221844;
        Thu, 01 Aug 2019 10:57:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 30/59] qla2xxx: Suppress multiple Coverity complaint about out-of-bounds accesses
Date:   Thu,  1 Aug 2019 10:55:45 -0700
Message-Id: <20190801175614.73655-31-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch does not change any functionality.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 5ec3c2b96f3f..33e0cf210332 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1555,7 +1555,7 @@ qla2x00_fdmi_rhba(scsi_qla_host_t *vha)
 	/* Attributes */
 	ct_req->req.rhba.attrs.count =
 	    cpu_to_be32(FDMI_HBA_ATTR_COUNT);
-	entries = ct_req->req.rhba.hba_identifier;
+	entries = &ct_req->req;
 
 	/* Nodename. */
 	eiter = entries + size;
@@ -1764,7 +1764,7 @@ qla2x00_fdmi_rpa(scsi_qla_host_t *vha)
 
 	/* Attributes */
 	ct_req->req.rpa.attrs.count = cpu_to_be32(FDMI_PORT_ATTR_COUNT);
-	entries = ct_req->req.rpa.port_name;
+	entries = &ct_req->req;
 
 	/* FC4 types. */
 	eiter = entries + size;
@@ -1977,7 +1977,7 @@ qla2x00_fdmiv2_rhba(scsi_qla_host_t *vha)
 
 	/* Attributes */
 	ct_req->req.rhba2.attrs.count = cpu_to_be32(FDMIV2_HBA_ATTR_COUNT);
-	entries = ct_req->req.rhba2.hba_identifier;
+	entries = &ct_req->req;
 
 	/* Nodename. */
 	eiter = entries + size;
@@ -2336,7 +2336,7 @@ qla2x00_fdmiv2_rpa(scsi_qla_host_t *vha)
 
 	/* Attributes */
 	ct_req->req.rpa2.attrs.count = cpu_to_be32(FDMIV2_PORT_ATTR_COUNT);
-	entries = ct_req->req.rpa2.port_name;
+	entries = &ct_req->req;
 
 	/* FC4 types. */
 	eiter = entries + size;
-- 
2.22.0.770.g0f2c4a37fd-goog

