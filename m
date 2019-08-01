Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C27E1AB
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfHAR5U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36580 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfHAR5T (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34506724pfl.3
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XO8bmlIbAhIPMOgTUsMMODeQpg/Ouf48ygfxUtPT7Kc=;
        b=R9vregIO5RSDJflc9+6Z2XfGNRotv9SVcQ8FmnOZ2KVOH63+QNJ6rU/Hfeqd15/XLX
         ZeXYtFSGoxG1jIWeIgdW4H9P05KJwFl7N+/taflZYHpLsIy22CEWXQg2gLfvGtcOo1vt
         vaQ06bGJmbqYzfMYOzGAr9V6v8ZRJ/kHv+f3pR88QtoRipY6WglsND1JsWhC5FbSIFqG
         xzbddWqSeBQcQXpzMeKG8kGiPeg5e8+fuZfCkKbDQA50YMtvjWdkjFzCue3+4ASFUZqq
         ycfA1svIuGqH02NmLf0cgabIxJblXTiS+L9CQugkPBfgpJ7GUxVhjqoPb52vwm4TTPRd
         /ZKg==
X-Gm-Message-State: APjAAAU94oGHI3NqhI38Fm7SmCtwkYsYjge4CdnoijRWFx4vO3wx/m/o
        3vuW1ju8nEbgAD9lhH3odg0=
X-Google-Smtp-Source: APXvYqyPT/ofSsyjszfNqUYwda+ncAiolwIMJDPHfl45GfZrq+yku3FMqXQ0o0S1VZ8N+S4Z3XNGHQ==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr121822233pgc.425.1564682238931;
        Thu, 01 Aug 2019 10:57:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 42/59] qla2xxx: Rework key encoding in qlt_find_host_by_d_id()
Date:   Thu,  1 Aug 2019 10:55:57 -0700
Message-Id: <20190801175614.73655-43-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the same approach for encoding the destination ID as the approach
used by qlt_update_vp_map().

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 3dd897d3e400..f7b72d1d4862 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -191,16 +191,14 @@ struct scsi_qla_host *qlt_find_host_by_d_id(struct scsi_qla_host *vha,
 					    be_id_t d_id)
 {
 	struct scsi_qla_host *host;
-	uint32_t key = 0;
+	uint32_t key;
 
 	if (vha->d_id.b.area == d_id.area &&
 	    vha->d_id.b.domain == d_id.domain &&
 	    vha->d_id.b.al_pa == d_id.al_pa)
 		return vha;
 
-	key  = d_id.domain << 16;
-	key |= d_id.area << 8;
-	key |= d_id.al_pa;
+	key = be_to_port_id(d_id).b24;
 
 	host = btree_lookup32(&vha->hw->tgt.host_map, key);
 	if (!host)
-- 
2.22.0.770.g0f2c4a37fd-goog

