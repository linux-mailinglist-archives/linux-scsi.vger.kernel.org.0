Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51A21CE51F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2020 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgEKUKF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 May 2020 16:10:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35101 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgEKUKF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 May 2020 16:10:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id u15so434774plm.2
        for <linux-scsi@vger.kernel.org>; Mon, 11 May 2020 13:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dITsv9JMmCOILvd6qs9FnxxdcpxfpNDUd3BI/+BJ7E=;
        b=RNJHvxJ/pmBThH1esPpKhhgiB7aw694YE6K1BUEurtbguj4ONQxooJa7VhLIhveog1
         p66qZ+URPejI8nEOBhtB7mMaZRvCsuWUtgu5wdpBD5AZd29nwScmOzLsQZU4N0hqmiCb
         yOCTFblYZeT/dCuNvwzQqYBsoALueXXf1a4SK95qVQwgic+PCGhJefDNbfFWlp7OyKpC
         jv4ll1HURnuisyJHt9zo/T8ZsIXs+DeLn5cq9Pxipnfeu4qbMdDBXvu3aH+62V1sQPOz
         mYz22ukOqUxRMO8Ev85B6fM1/48NUCqQOEKI/yb8IpOX2ImcEcF/uL/PzGOuj7sV7/bE
         FTLw==
X-Gm-Message-State: AGi0PuaKXKXwwr5KhTKDAHWdFIjNZgM9CaS+gl8MJvIkTcw9XgF6doOS
        7C8RTiIyK14+/aFlEWirsZ8=
X-Google-Smtp-Source: APiQypL8wo5j6A9/9ixrpYiSdrhgxq3etUQgICjC+P6JuCFoKKGkuMMKgiiy+tQBFa6GvUwOgVNrag==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr24862578pjb.56.1589227804140;
        Mon, 11 May 2020 13:10:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id 30sm8610265pgp.38.2020.05.11.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:10:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 07/15] qla2xxx: Increase the size of struct qla_fcp_prio_cfg to FCP_PRIO_CFG_SIZE
Date:   Mon, 11 May 2020 13:09:38 -0700
Message-Id: <20200511200946.7675-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511200946.7675-1-bvanassche@acm.org>
References: <20200511200946.7675-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes the following Coverity complaint without changing any
functionality:

CID 337793 (#1 of 1): Wrong size argument (SIZEOF_MISMATCH)
suspicious_sizeof: Passing argument ha->fcp_prio_cfg of type
struct qla_fcp_prio_cfg * and argument 32768UL to function memset is
suspicious because a multiple of sizeof (struct qla_fcp_prio_cfg) /*48*/
is expected.

memset(ha->fcp_prio_cfg, 0, FCP_PRIO_CFG_SIZE);

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_fw.h | 3 ++-
 drivers/scsi/qla2xxx/qla_os.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index b364a497e33d..4fa34374f34f 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -2217,8 +2217,9 @@ struct qla_fcp_prio_cfg {
 #define FCP_PRIO_ATTR_PERSIST   0x2
 	uint8_t  reserved;      /* Reserved for future use          */
 #define FCP_PRIO_CFG_HDR_SIZE   0x10
-	struct qla_fcp_prio_entry entry[1];     /* fcp priority entries  */
+	struct qla_fcp_prio_entry entry[1023]; /* fcp priority entries  */
 #define FCP_PRIO_CFG_ENTRY_SIZE 0x20
+	uint8_t  reserved2[16];
 };
 
 #define FCP_PRIO_CFG_SIZE       (32*1024) /* fcp prio data per port*/
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5199169c4ce0..743c0df18fa0 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7883,6 +7883,7 @@ qla2x00_module_init(void)
 	BUILD_BUG_ON(sizeof(struct qla82xx_uri_data_desc) != 28);
 	BUILD_BUG_ON(sizeof(struct qla82xx_uri_table_desc) != 32);
 	BUILD_BUG_ON(sizeof(struct qla83xx_fw_dump) != 51196);
+	BUILD_BUG_ON(sizeof(struct qla_fcp_prio_cfg) != FCP_PRIO_CFG_SIZE);
 	BUILD_BUG_ON(sizeof(struct qla_fdt_layout) != 128);
 	BUILD_BUG_ON(sizeof(struct qla_flt_header) != 8);
 	BUILD_BUG_ON(sizeof(struct qla_flt_region) != 16);
