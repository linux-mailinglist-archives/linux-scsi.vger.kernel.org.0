Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD20950493
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfFXIaM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:12 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:15226 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:12 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8UANC025690
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=m+213YJWywokmdo/Qam5Qoo4NlJw6oP2qvBYtDUpsjY=;
 b=Hkub1F4MnG+ScEVEiewinOfYDbJrRMjg0+xvKv5BNt/QJI/ipGNk4iz4tuHqK/TYMbvx
 wfJP8Ar1cJD2C7Ft+CR4BR1J27MnUuauDYE6T6rNen5+0U/aYlOTr1tv3aVbgBC2a9pk
 VZoCR9kww1+r1W/tz+vq0wlofmKXdfwpjFEfGugJYV9u3Gb0DQu0z8AdG2Nhl8CiWebY
 HCeUk6QcyjbXZOK2Hw9gmVGB2eMwJrUq+tVoGrl3WlTqAF74JOCnvpW4Di44pLGgSEHQ
 hw/UUv3x8FIIOHK1eAGvR8ZcnrwO1PXpVavTgh+V57vgUqBPF1772dTgX66RvLiwPAuK fQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujdw7n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:10 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:04 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:04 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 5922C3F7040;
        Mon, 24 Jun 2019 01:30:04 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8U4eb023215;
        Mon, 24 Jun 2019 01:30:04 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8U4Qa023112;
        Mon, 24 Jun 2019 01:30:04 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 1/6] bnx2fc: Redo setting source FCoE MAC.
Date:   Mon, 24 Jun 2019 01:29:55 -0700
Message-ID: <20190624083000.23074-2-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com>
References: <20190624083000.23074-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Chad Dupuis <cdupuis@marvell.com>

For bnx2fc, the source FCoE MAC is stored in the fcoe_port struct in the
data_src_mac field.  Currently this is set in fcoe_ctlr_recv_flogi which
ends up setting it by simply using fc_fcoe_set_mac() which only uses the
default FCF-MAC.  We still want to store the source FCoE MAC in
port->data_src_mac but we want to snoop the FLOGI response payload so
as to set it in the following method:

1. If a granted_mac is found, use that.
2. If not granted_mac is there but there is a FCF-MAP from the FCF then
   create the MAC from the FCF-MAP and the destination ID from the frame.
3. If there is no FCF-MAP the use the spec. default FCF-MAP and the
   destination ID from the frame.

Signed-off-by: Chad Dupuis <cdupuis@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc_els.c | 56 ++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index 76e65a3..f569411 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -854,33 +854,57 @@ void bnx2fc_process_els_compl(struct bnx2fc_cmd *els_req,
 	kref_put(&els_req->refcount, bnx2fc_cmd_release);
 }
 
+#define		BNX2FC_FCOE_MAC_METHOD_GRANGED_MAC	1
+#define		BNX2FC_FCOE_MAC_METHOD_FCF_MAP		2
+#define		BNX2FC_FCOE_MAC_METHOD_FCOE_SET_MAC	3
 static void bnx2fc_flogi_resp(struct fc_seq *seq, struct fc_frame *fp,
 			      void *arg)
 {
 	struct fcoe_ctlr *fip = arg;
 	struct fc_exch *exch = fc_seq_exch(seq);
 	struct fc_lport *lport = exch->lp;
-	u8 *mac;
-	u8 op;
+
+	struct fc_frame_header *fh;
+	u8 *granted_mac;
+	u8 fcoe_mac[6];
+	u8 fc_map[3];
+	int method;
 
 	if (IS_ERR(fp))
 		goto done;
 
-	mac = fr_cb(fp)->granted_mac;
-	if (is_zero_ether_addr(mac)) {
-		op = fc_frame_payload_op(fp);
-		if (lport->vport) {
-			if (op == ELS_LS_RJT) {
-				printk(KERN_ERR PFX "bnx2fc_flogi_resp is LS_RJT\n");
-				fc_vport_terminate(lport->vport);
-				fc_frame_free(fp);
-				return;
-			}
-		}
-		fcoe_ctlr_recv_flogi(fip, lport, fp);
+	fh = fc_frame_header_get(fp);
+	granted_mac = fr_cb(fp)->granted_mac;
+
+	/*
+	 * We set the source MAC for FCoE traffic based on the Granted MAC
+	 * address from the switch.
+	 *
+	 * If granted_mac is non-zero, we used that.
+	 * If the granted_mac is zeroed out, created the FCoE MAC based on
+	 * the sel_fcf->fc_map and the d_id fo the FLOGI frame.
+	 * If sel_fcf->fc_map is 0 then we use the default FCF-MAC plus the
+	 * d_id of the FLOGI frame.
+	 */
+	if (!is_zero_ether_addr(granted_mac)) {
+		ether_addr_copy(fcoe_mac, granted_mac);
+		method = BNX2FC_FCOE_MAC_METHOD_GRANGED_MAC;
+	} else if (fip->sel_fcf && fip->sel_fcf->fc_map != 0) {
+		hton24(fc_map, fip->sel_fcf->fc_map);
+		fcoe_mac[0] = fc_map[0];
+		fcoe_mac[1] = fc_map[1];
+		fcoe_mac[2] = fc_map[2];
+		fcoe_mac[3] = fh->fh_d_id[0];
+		fcoe_mac[4] = fh->fh_d_id[1];
+		fcoe_mac[5] = fh->fh_d_id[2];
+		method = BNX2FC_FCOE_MAC_METHOD_FCF_MAP;
+	} else {
+		fc_fcoe_set_mac(fcoe_mac, fh->fh_d_id);
+		method = BNX2FC_FCOE_MAC_METHOD_FCOE_SET_MAC;
 	}
-	if (!is_zero_ether_addr(mac))
-		fip->update_mac(lport, mac);
+
+	BNX2FC_HBA_DBG(lport, "fcoe_mac=%pM method=%d\n", fcoe_mac, method);
+	fip->update_mac(lport, fcoe_mac);
 done:
 	fc_lport_flogi_resp(seq, fp, lport);
 }
-- 
1.8.3.1

