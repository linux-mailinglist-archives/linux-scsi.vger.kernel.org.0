Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1867E189
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfHAR4e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36091 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so34616690pgm.3
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ9pWExBM5wNCojvBz8B7tbglunQZ3GCEA+BBoT6WRk=;
        b=C5RZl6lL54Bma8WAbo3weS/vm2aZFHPwFh5GvrhMSDW9QgBEgXfDZ4rLA4M8ZbhWyx
         7kGnmrmwGjlnUumkdyck6fHExWuDW2cpXRhRFCFsSIGm9HdGN5uTOwkQUbS098Dp+owf
         RFGzu6TdiGuwBkdbE+ipxhH5dvjxNfSwYA+iZn4TH/2gk68got1ROXQFVa1ss4OjmaX7
         h7iXy+6Lq4bgZVAf1snKWzrxxA1k9psd9B0dMWoHswjdtDL3NUulluyeNBYRDqLbzb3+
         MkrXmDvsYUifmSpxRMKlLQhw6ueAOl9COdjmuQg67LXRG/8rx2DGZN+/ierqd4Ll4iQk
         5wkQ==
X-Gm-Message-State: APjAAAU5IyhLk1/7wsOsmnaNz9+gA5PhoryYlxci8IYtD6zJ++EGdUk5
        D0C4mBi+s+6ivjYeX/L0Ek6GmkPd
X-Google-Smtp-Source: APXvYqxukSezu2VXJv6qwLynqWv+3HKphQ/O3nSALoKygz//UwDzeWxh2YdZwGZXndQoxieC/rygyQ==
X-Received: by 2002:a62:6c1:: with SMTP id 184mr53449170pfg.230.1564682193173;
        Thu, 01 Aug 2019 10:56:33 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 08/59] qla2xxx: Declare the fourth ql_dump_buffer() argument const
Date:   Thu,  1 Aug 2019 10:55:23 -0700
Message-Id: <20190801175614.73655-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes it clear to humans and also to the compiler that
ql_dump_buffer() does not modify the memory the @buf argument points at.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dbg.c | 3 ++-
 drivers/scsi/qla2xxx/qla_gbl.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 9e80646722e2..30afc59c1870 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -2743,7 +2743,8 @@ ql_dump_regs(uint level, scsi_qla_host_t *vha, uint id)
 
 
 void
-ql_dump_buffer(uint level, scsi_qla_host_t *vha, uint id, void *buf, uint size)
+ql_dump_buffer(uint level, scsi_qla_host_t *vha, uint id, const void *buf,
+	       uint size)
 {
 	uint cnt;
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index f9669fdf7798..6f6801722a09 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -630,7 +630,7 @@ extern ulong qla27xx_fwdt_template_size(void *);
 
 extern void qla2xxx_dump_post_process(scsi_qla_host_t *, int);
 extern void ql_dump_regs(uint, scsi_qla_host_t *, uint);
-extern void ql_dump_buffer(uint, scsi_qla_host_t *, uint, void *, uint);
+extern void ql_dump_buffer(uint, scsi_qla_host_t *, uint, const void *, uint);
 /*
  * Global Function Prototypes in qla_gs.c source file.
  */
-- 
2.22.0.770.g0f2c4a37fd-goog

