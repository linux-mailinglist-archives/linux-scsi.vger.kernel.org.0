Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5B2E618
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE2U2q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46846 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfE2U2p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so534220pgr.13
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THmc9S4oPc7AqqA25hdDdotVU4mBb/CtHEqUmGWWi0w=;
        b=WOeVLQ46MNtvQK6h2Kr9gXcTvEzW22kNTmaYRxxhOAw4kKp00xYqoXXjz/Bp+rauGG
         dRP2mWp35dPxkCrmTUq13PqsoTMcqzhm83lRU4OU/yn5P/xElKAC0VUOKJRY/28Sz6jr
         +mCWgZFbQlH34A9+28xs95m6gjXADFJc9usP1AnzUt27z0tIcC22X7YrfbnXXIVGC1qx
         mTvxVV+wsgQkMJuhTSgVXVAtjRreqghXEg4Xxi+U0WOP/AOvZHKkC863c2ic5smQZgiy
         wqmHwEO+jVql4fhbx0/uxgXn8yroDQoISBJPx4+QjI1sijp6CghnGsCCjOBf9OR00db4
         iYag==
X-Gm-Message-State: APjAAAXaZwwMuobeIzv8ZCTGLMHGlnqxBYmjbPGCfI+59B5Ahr0Qyxq7
        xW5Wz9ke2YCNM5+ATRdI4pc=
X-Google-Smtp-Source: APXvYqz5ftGcEpyHepxmukhDGDw29MF/7Bi+8UFTdK9TnWaJHDsIVbLZtCku93bBculODeO77uw+oA==
X-Received: by 2002:a63:2c50:: with SMTP id s77mr53168461pgs.175.1559161725228;
        Wed, 29 May 2019 13:28:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 06/20] qla2xxx: Change the return type of qla2x00_update_ms_fdmi_iocb() into void
Date:   Wed, 29 May 2019 13:28:12 -0700
Message-Id: <20190529202826.204499-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make this change because the value returned by this function is not
used.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 9f58e591666d..f0dbd2169a4e 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1479,7 +1479,7 @@ qla24xx_prep_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size,
 	return ct_pkt;
 }
 
-static inline ms_iocb_entry_t *
+static void
 qla2x00_update_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size)
 {
 	struct qla_hw_data *ha = vha->hw;
@@ -1493,8 +1493,6 @@ qla2x00_update_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size)
 		ms_pkt->req_bytecount = cpu_to_le32(req_size);
 		ms_pkt->req_dsd.length = ms_pkt->req_bytecount;
 	}
-
-	return ms_pkt;
 }
 
 /**
-- 
2.22.0.rc1

