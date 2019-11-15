Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F88FFD7A3
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2019 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKOIGC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Nov 2019 03:06:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:36168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbfKOIGC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 Nov 2019 03:06:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21F4DAD12;
        Fri, 15 Nov 2019 08:06:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] dpt_i2o: make adpt_i2o_to_scsi() a void function
Date:   Fri, 15 Nov 2019 09:05:53 +0100
Message-Id: <20191115080555.146710-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115080555.146710-1-hare@suse.de>
References: <20191115080555.146710-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The return value is never used anywhere, and returning it
risks a use-after-free crash.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/dpt_i2o.c | 3 +--
 drivers/scsi/dpti.h    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index cc3f1100c888..3e4b8c1362eb 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -2340,7 +2340,7 @@ static s32 adpt_scsi_host_alloc(adpt_hba* pHba, struct scsi_host_template *sht)
 }
 
 
-static s32 adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd)
+static void adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd)
 {
 	adpt_hba* pHba;
 	u32 hba_status;
@@ -2458,7 +2458,6 @@ static s32 adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd)
 	if(cmd->scsi_done != NULL){
 		cmd->scsi_done(cmd);
 	} 
-	return cmd->result;
 }
 
 
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 42b1e28b5884..1f344a2ac0f5 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -286,7 +286,7 @@ static s32 adpt_i2o_status_get(adpt_hba* pHba);
 static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba);
 static s32 adpt_i2o_hrt_get(adpt_hba* pHba);
 static s32 adpt_scsi_to_i2o(adpt_hba* pHba, struct scsi_cmnd* cmd, struct adpt_device* dptdevice);
-static s32 adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd);
+static void adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd);
 static s32 adpt_scsi_host_alloc(adpt_hba* pHba,struct scsi_host_template * sht);
 static s32 adpt_hba_reset(adpt_hba* pHba);
 static s32 adpt_i2o_reset_hba(adpt_hba* pHba);
-- 
2.16.4

