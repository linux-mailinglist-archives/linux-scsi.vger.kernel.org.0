Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED652DC6DE
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Oct 2019 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408719AbfJROFC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Oct 2019 10:05:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408654AbfJROFC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Oct 2019 10:05:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6169AD29;
        Fri, 18 Oct 2019 14:05:00 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Himanshu Madhani <hmadhani@marvell.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] qla2xxx: fixup incorrect usage of host_byte
Date:   Fri, 18 Oct 2019 16:04:58 +0200
Message-Id: <20191018140458.108278-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DRIVER_ERROR is a a driver byte setting, not a host byte.
The qla2xxx driver should rather return DID_ERROR here to be
in line with the other drivers.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 28d587a89ba6..99f0a1a08143 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -253,7 +253,7 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 	srb_t *sp;
 	const char *type;
 	int req_sg_cnt, rsp_sg_cnt;
-	int rval =  (DRIVER_ERROR << 16);
+	int rval =  (DID_ERROR << 16);
 	uint16_t nextlid = 0;
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
@@ -432,7 +432,7 @@ qla2x00_process_ct(struct bsg_job *bsg_job)
 	struct Scsi_Host *host = fc_bsg_to_shost(bsg_job);
 	scsi_qla_host_t *vha = shost_priv(host);
 	struct qla_hw_data *ha = vha->hw;
-	int rval = (DRIVER_ERROR << 16);
+	int rval = (DID_ERROR << 16);
 	int req_sg_cnt, rsp_sg_cnt;
 	uint16_t loop_id;
 	struct fc_port *fcport;
@@ -1950,7 +1950,7 @@ qlafx00_mgmt_cmd(struct bsg_job *bsg_job)
 	struct Scsi_Host *host = fc_bsg_to_shost(bsg_job);
 	scsi_qla_host_t *vha = shost_priv(host);
 	struct qla_hw_data *ha = vha->hw;
-	int rval = (DRIVER_ERROR << 16);
+	int rval = (DID_ERROR << 16);
 	struct qla_mt_iocb_rqst_fx00 *piocb_rqst;
 	srb_t *sp;
 	int req_sg_cnt = 0, rsp_sg_cnt = 0;
-- 
2.16.4

