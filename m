Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 530F57E185
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfHAR43 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39787 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR42 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so34624642pgi.6
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuY7rbj0lXCvJaPp5P1GDW7AZfRIn8ZTHJPt/2hvb8o=;
        b=CGRdpvfOaHDstSd23DbGIwdPUbvcDK2dUpmvxljBAdYAEOJ8EC9uONaOcil+7ZLH+y
         92ghSe8s08r/cpySLiXhXFbIKzzKZj6JMHFRSw8eXHkRK8kcN3VXe/vxQCHfFpvsDoKI
         l/59fI4wBP/BX6FcsKYoeZYSmgCDLK9ugGPznfW7VudCNmeHexZav8x99brG2udBkPsM
         E3cKlwZO90aL/0Wj5iCTXc91UWpsWQFKg9zu92rrI9f4WTX6GwA+7b4MWgiHYn3tZkqB
         hXw5e0Zqm2WeWJ01KorM1lrygR3Vf5cL/3W4vwx7ZuwLOsBIFQXOE8LSFAYwz/hFVkkr
         ux3g==
X-Gm-Message-State: APjAAAUMG2Hv6GYHKi9RajKUlOBmP4zIAe3X1+SccGqhK9kBPosF7rlM
        dKVRsyQHR1SIxjqvfXB3LMaDMSWD
X-Google-Smtp-Source: APXvYqwNcQcGx46t/prEtu5IOMp526FRWFk1qYVSV2NOif/rcLtE++ZKmItpidOTqW4XNS9m3q2K6g==
X-Received: by 2002:a63:24a:: with SMTP id 71mr10922601pgc.273.1564682187800;
        Thu, 01 Aug 2019 10:56:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 04/59] qla2xxx: Use tabs instead of spaces for indentation
Date:   Thu,  1 Aug 2019 10:55:19 -0700
Message-Id: <20190801175614.73655-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch only modifies whitespace.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 78 +++++++++++++++++------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 749109c8f20b..7dc9eeb0c401 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3467,54 +3467,54 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 
 void qla24xx_handle_gffid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
-       fc_port_t *fcport = ea->fcport;
+	fc_port_t *fcport = ea->fcport;
 
-       qla24xx_post_gnl_work(vha, fcport);
+	qla24xx_post_gnl_work(vha, fcport);
 }
 
 void qla24xx_async_gffid_sp_done(void *s, int res)
 {
-       struct srb *sp = s;
-       struct scsi_qla_host *vha = sp->vha;
-       fc_port_t *fcport = sp->fcport;
-       struct ct_sns_rsp *ct_rsp;
-       struct event_arg ea;
-
-       ql_dbg(ql_dbg_disc, vha, 0x2133,
-	   "Async done-%s res %x ID %x. %8phC\n",
-	   sp->name, res, fcport->d_id.b24, fcport->port_name);
-
-       fcport->flags &= ~FCF_ASYNC_SENT;
-       ct_rsp = &fcport->ct_desc.ct_sns->p.rsp;
-       /*
-	* FC-GS-7, 5.2.3.12 FC-4 Features - format
-	* The format of the FC-4 Features object, as defined by the FC-4,
-	* Shall be an array of 4-bit values, one for each type code value
-	*/
-       if (!res) {
-	       if (ct_rsp->rsp.gff_id.fc4_features[GFF_FCP_SCSI_OFFSET] & 0xf) {
-		       /* w1 b00:03 */
-		       fcport->fc4_type =
-			   ct_rsp->rsp.gff_id.fc4_features[GFF_FCP_SCSI_OFFSET];
-		       fcport->fc4_type &= 0xf;
-	       }
+	struct srb *sp = s;
+	struct scsi_qla_host *vha = sp->vha;
+	fc_port_t *fcport = sp->fcport;
+	struct ct_sns_rsp *ct_rsp;
+	struct event_arg ea;
+
+	ql_dbg(ql_dbg_disc, vha, 0x2133,
+	       "Async done-%s res %x ID %x. %8phC\n",
+	       sp->name, res, fcport->d_id.b24, fcport->port_name);
 
-	       if (ct_rsp->rsp.gff_id.fc4_features[GFF_NVME_OFFSET] & 0xf) {
-		       /* w5 [00:03]/28h */
-		       fcport->fc4f_nvme =
-			   ct_rsp->rsp.gff_id.fc4_features[GFF_NVME_OFFSET];
-		       fcport->fc4f_nvme &= 0xf;
+	fcport->flags &= ~FCF_ASYNC_SENT;
+	ct_rsp = &fcport->ct_desc.ct_sns->p.rsp;
+	/*
+	 * FC-GS-7, 5.2.3.12 FC-4 Features - format
+	 * The format of the FC-4 Features object, as defined by the FC-4,
+	 * Shall be an array of 4-bit values, one for each type code value
+	 */
+	if (!res) {
+		if (ct_rsp->rsp.gff_id.fc4_features[GFF_FCP_SCSI_OFFSET] & 0xf) {
+			/* w1 b00:03 */
+			fcport->fc4_type =
+			    ct_rsp->rsp.gff_id.fc4_features[GFF_FCP_SCSI_OFFSET];
+			fcport->fc4_type &= 0xf;
 	       }
-       }
 
-       memset(&ea, 0, sizeof(ea));
-       ea.sp = sp;
-       ea.fcport = sp->fcport;
-       ea.rc = res;
-       ea.event = FCME_GFFID_DONE;
+		if (ct_rsp->rsp.gff_id.fc4_features[GFF_NVME_OFFSET] & 0xf) {
+			/* w5 [00:03]/28h */
+			fcport->fc4f_nvme =
+			    ct_rsp->rsp.gff_id.fc4_features[GFF_NVME_OFFSET];
+			fcport->fc4f_nvme &= 0xf;
+		}
+	}
 
-       qla2x00_fcport_event_handler(vha, &ea);
-       sp->free(sp);
+	memset(&ea, 0, sizeof(ea));
+	ea.sp = sp;
+	ea.fcport = sp->fcport;
+	ea.rc = res;
+	ea.event = FCME_GFFID_DONE;
+
+	qla2x00_fcport_event_handler(vha, &ea);
+	sp->free(sp);
 }
 
 /* Get FC4 Feature with Nport ID. */
-- 
2.22.0.770.g0f2c4a37fd-goog

