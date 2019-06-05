Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4A357FA
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEHjx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 03:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfFEHjw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Jun 2019 03:39:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB10AAF7D;
        Wed,  5 Jun 2019 07:39:50 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 4/4] fcoe: pass in fcoe_rport structure instead of fc_rport_priv
Date:   Wed,  5 Jun 2019 09:39:42 +0200
Message-Id: <20190605073942.125577-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190605073942.125577-1-hare@suse.de>
References: <20190605073942.125577-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of using the generic 'fc_rport_priv' structure as argument
and then having to painstakingly outcast this to fcoe_rport we should
be passing the fcoe_rport structure itself and reduce complexity.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 99 ++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 728ff37111ed..428bde1c8dd4 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -2401,16 +2401,14 @@ static void fcoe_ctlr_vn_send_claim(struct fcoe_ctlr *fip)
 /**
  * fcoe_ctlr_vn_probe_req() - handle incoming VN2VN probe request.
  * @fip: The FCoE controller
- * @rdata: parsed remote port with frport from the probe request
+ * @frport: parsed FCoE rport from the probe request
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vn_probe_req(struct fcoe_ctlr *fip,
-				   struct fc_rport_priv *rdata)
+				   struct fcoe_rport *frport)
 {
-	struct fcoe_rport *frport = fcoe_ctlr_rport(rdata);
-
-	if (rdata->ids.port_id != fip->port_id)
+	if (frport->rdata.ids.port_id != fip->port_id)
 		return;
 
 	switch (fip->state) {
@@ -2430,7 +2428,7 @@ static void fcoe_ctlr_vn_probe_req(struct fcoe_ctlr *fip,
 		 * Probe's REC bit is not set.
 		 * If we don't reply, we will change our address.
 		 */
-		if (fip->lp->wwpn > rdata->ids.port_name &&
+		if (fip->lp->wwpn > frport->rdata.ids.port_name &&
 		    !(frport->flags & FIP_FL_REC_OR_P2P)) {
 			LIBFCOE_FIP_DBG(fip, "vn_probe_req: "
 					"port_id collision\n");
@@ -2454,14 +2452,14 @@ static void fcoe_ctlr_vn_probe_req(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_vn_probe_reply() - handle incoming VN2VN probe reply.
  * @fip: The FCoE controller
- * @rdata: parsed remote port with frport from the probe request
+ * @frport: parsed FCoE rport from the probe request
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vn_probe_reply(struct fcoe_ctlr *fip,
-				   struct fc_rport_priv *rdata)
+				     struct fcoe_rport *frport)
 {
-	if (rdata->ids.port_id != fip->port_id)
+	if (frport->rdata.ids.port_id != fip->port_id)
 		return;
 	switch (fip->state) {
 	case FIP_ST_VNMP_START:
@@ -2484,11 +2482,11 @@ static void fcoe_ctlr_vn_probe_reply(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_vn_add() - Add a VN2VN entry to the list, based on a claim reply.
  * @fip: The FCoE controller
- * @new: newly-parsed remote port with frport as a template for new rdata
+ * @new: newly-parsed FCoE rport as a template for new rdata
  *
  * Called with ctlr_mutex held.
  */
-static void fcoe_ctlr_vn_add(struct fcoe_ctlr *fip, struct fc_rport_priv *new)
+static void fcoe_ctlr_vn_add(struct fcoe_ctlr *fip, struct fcoe_rport *new)
 {
 	struct fc_lport *lport = fip->lp;
 	struct fc_rport_priv *rdata;
@@ -2496,7 +2494,7 @@ static void fcoe_ctlr_vn_add(struct fcoe_ctlr *fip, struct fc_rport_priv *new)
 	struct fcoe_rport *frport;
 	u32 port_id;
 
-	port_id = new->ids.port_id;
+	port_id = new->rdata.ids.port_id;
 	if (port_id == fip->port_id)
 		return;
 
@@ -2513,22 +2511,28 @@ static void fcoe_ctlr_vn_add(struct fcoe_ctlr *fip, struct fc_rport_priv *new)
 	rdata->disc_id = lport->disc.disc_id;
 
 	ids = &rdata->ids;
-	if ((ids->port_name != -1 && ids->port_name != new->ids.port_name) ||
-	    (ids->node_name != -1 && ids->node_name != new->ids.node_name)) {
+	if ((ids->port_name != -1 &&
+	     ids->port_name != new->rdata.ids.port_name) ||
+	    (ids->node_name != -1 &&
+	     ids->node_name != new->rdata.ids.node_name)) {
 		mutex_unlock(&rdata->rp_mutex);
 		LIBFCOE_FIP_DBG(fip, "vn_add rport logoff %6.6x\n", port_id);
 		fc_rport_logoff(rdata);
 		mutex_lock(&rdata->rp_mutex);
 	}
-	ids->port_name = new->ids.port_name;
-	ids->node_name = new->ids.node_name;
+	ids->port_name = new->rdata.ids.port_name;
+	ids->node_name = new->rdata.ids.node_name;
 	mutex_unlock(&rdata->rp_mutex);
 
 	frport = fcoe_ctlr_rport(rdata);
 	LIBFCOE_FIP_DBG(fip, "vn_add rport %6.6x %s state %d\n",
 			port_id, frport->fcoe_len ? "old" : "new",
 			rdata->rp_state);
-	*frport = *fcoe_ctlr_rport(new);
+	frport->fcoe_len = new->fcoe_len;
+	frport->flags = new->flags;
+	frport->login_count = new->login_count;
+	memcpy(frport->enode_mac, new->enode_mac, ETH_ALEN);
+	memcpy(frport->vn_mac, new->vn_mac, ETH_ALEN);
 	frport->time = 0;
 }
 
@@ -2560,16 +2564,14 @@ static int fcoe_ctlr_vn_lookup(struct fcoe_ctlr *fip, u32 port_id, u8 *mac)
 /**
  * fcoe_ctlr_vn_claim_notify() - handle received FIP VN2VN Claim Notification
  * @fip: The FCoE controller
- * @new: newly-parsed remote port with frport as a template for new rdata
+ * @new: newly-parsed FCoE rport as a template for new rdata
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vn_claim_notify(struct fcoe_ctlr *fip,
-				      struct fc_rport_priv *new)
+				      struct fcoe_rport *new)
 {
-	struct fcoe_rport *frport = fcoe_ctlr_rport(new);
-
-	if (frport->flags & FIP_FL_REC_OR_P2P) {
+	if (new->flags & FIP_FL_REC_OR_P2P) {
 		LIBFCOE_FIP_DBG(fip, "send probe req for P2P/REC\n");
 		fcoe_ctlr_vn_send(fip, FIP_SC_VN_PROBE_REQ, fcoe_all_vn2vn, 0);
 		return;
@@ -2578,7 +2580,7 @@ static void fcoe_ctlr_vn_claim_notify(struct fcoe_ctlr *fip,
 	case FIP_ST_VNMP_START:
 	case FIP_ST_VNMP_PROBE1:
 	case FIP_ST_VNMP_PROBE2:
-		if (new->ids.port_id == fip->port_id) {
+		if (new->rdata.ids.port_id == fip->port_id) {
 			LIBFCOE_FIP_DBG(fip, "vn_claim_notify: "
 					"restart, state %d\n",
 					fip->state);
@@ -2587,8 +2589,8 @@ static void fcoe_ctlr_vn_claim_notify(struct fcoe_ctlr *fip,
 		break;
 	case FIP_ST_VNMP_CLAIM:
 	case FIP_ST_VNMP_UP:
-		if (new->ids.port_id == fip->port_id) {
-			if (new->ids.port_name > fip->lp->wwpn) {
+		if (new->rdata.ids.port_id == fip->port_id) {
+			if (new->rdata.ids.port_name > fip->lp->wwpn) {
 				LIBFCOE_FIP_DBG(fip, "vn_claim_notify: "
 						"restart, port_id collision\n");
 				fcoe_ctlr_vn_restart(fip);
@@ -2600,15 +2602,16 @@ static void fcoe_ctlr_vn_claim_notify(struct fcoe_ctlr *fip,
 			break;
 		}
 		LIBFCOE_FIP_DBG(fip, "vn_claim_notify: send reply to %x\n",
-				new->ids.port_id);
-		fcoe_ctlr_vn_send(fip, FIP_SC_VN_CLAIM_REP, frport->enode_mac,
-				  min((u32)frport->fcoe_len,
+				new->rdata.ids.port_id);
+		fcoe_ctlr_vn_send(fip, FIP_SC_VN_CLAIM_REP, new->enode_mac,
+				  min((u32)new->fcoe_len,
 				      fcoe_ctlr_fcoe_size(fip)));
 		fcoe_ctlr_vn_add(fip, new);
 		break;
 	default:
 		LIBFCOE_FIP_DBG(fip, "vn_claim_notify: "
-				"ignoring claim from %x\n", new->ids.port_id);
+				"ignoring claim from %x\n",
+				new->rdata.ids.port_id);
 		break;
 	}
 }
@@ -2616,15 +2619,15 @@ static void fcoe_ctlr_vn_claim_notify(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_vn_claim_resp() - handle received Claim Response
  * @fip: The FCoE controller that received the frame
- * @new: newly-parsed remote port with frport from the Claim Response
+ * @new: newly-parsed FCoE rport from the Claim Response
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vn_claim_resp(struct fcoe_ctlr *fip,
-				    struct fc_rport_priv *new)
+				    struct fcoe_rport *new)
 {
 	LIBFCOE_FIP_DBG(fip, "claim resp from from rport %x - state %s\n",
-			new->ids.port_id, fcoe_ctlr_state(fip->state));
+			new->rdata.ids.port_id, fcoe_ctlr_state(fip->state));
 	if (fip->state == FIP_ST_VNMP_UP || fip->state == FIP_ST_VNMP_CLAIM)
 		fcoe_ctlr_vn_add(fip, new);
 }
@@ -2632,28 +2635,28 @@ static void fcoe_ctlr_vn_claim_resp(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_vn_beacon() - handle received beacon.
  * @fip: The FCoE controller that received the frame
- * @new: newly-parsed remote port with frport from the Beacon
+ * @new: newly-parsed FCoE rport from the Beacon
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vn_beacon(struct fcoe_ctlr *fip,
-				struct fc_rport_priv *new)
+				struct fcoe_rport *new)
 {
 	struct fc_lport *lport = fip->lp;
 	struct fc_rport_priv *rdata;
 	struct fcoe_rport *frport;
 
-	frport = fcoe_ctlr_rport(new);
-	if (frport->flags & FIP_FL_REC_OR_P2P) {
+	if (new->flags & FIP_FL_REC_OR_P2P) {
 		LIBFCOE_FIP_DBG(fip, "p2p beacon while in vn2vn mode\n");
 		fcoe_ctlr_vn_send(fip, FIP_SC_VN_PROBE_REQ, fcoe_all_vn2vn, 0);
 		return;
 	}
-	rdata = fc_rport_lookup(lport, new->ids.port_id);
+	rdata = fc_rport_lookup(lport, new->rdata.ids.port_id);
 	if (rdata) {
-		if (rdata->ids.node_name == new->ids.node_name &&
-		    rdata->ids.port_name == new->ids.port_name) {
+		if (rdata->ids.node_name == new->rdata.ids.node_name &&
+		    rdata->ids.port_name == new->rdata.ids.port_name) {
 			frport = fcoe_ctlr_rport(rdata);
+
 			LIBFCOE_FIP_DBG(fip, "beacon from rport %x\n",
 					rdata->ids.port_id);
 			if (!frport->time && fip->state == FIP_ST_VNMP_UP) {
@@ -2676,7 +2679,7 @@ static void fcoe_ctlr_vn_beacon(struct fcoe_ctlr *fip,
 	 * Don't add the neighbor yet.
 	 */
 	LIBFCOE_FIP_DBG(fip, "beacon from new rport %x. sending claim notify\n",
-			new->ids.port_id);
+			new->rdata.ids.port_id);
 	if (time_after(jiffies,
 		       fip->sol_time + msecs_to_jiffies(FIP_VN_ANN_WAIT)))
 		fcoe_ctlr_vn_send_claim(fip);
@@ -2762,19 +2765,19 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	mutex_lock(&fip->ctlr_mutex);
 	switch (sub) {
 	case FIP_SC_VN_PROBE_REQ:
-		fcoe_ctlr_vn_probe_req(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_req(fip, &buf);
 		break;
 	case FIP_SC_VN_PROBE_REP:
-		fcoe_ctlr_vn_probe_reply(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_reply(fip, &buf);
 		break;
 	case FIP_SC_VN_CLAIM_NOTIFY:
-		fcoe_ctlr_vn_claim_notify(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_notify(fip, &buf);
 		break;
 	case FIP_SC_VN_CLAIM_REP:
-		fcoe_ctlr_vn_claim_resp(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_resp(fip, &buf);
 		break;
 	case FIP_SC_VN_BEACON:
-		fcoe_ctlr_vn_beacon(fip, &buf.rdata);
+		fcoe_ctlr_vn_beacon(fip, &buf);
 		break;
 	default:
 		LIBFCOE_FIP_DBG(fip, "vn_recv unknown subcode %d\n", sub);
@@ -2950,13 +2953,13 @@ static void fcoe_ctlr_vlan_send(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_vlan_disk_reply() - send FIP VLAN Discovery Notification.
  * @fip: The FCoE controller
+ * @frport: The newly-parsed FCoE rport from the Discovery Request
  *
  * Called with ctlr_mutex held.
  */
 static void fcoe_ctlr_vlan_disc_reply(struct fcoe_ctlr *fip,
-				      struct fc_rport_priv *rdata)
+				      struct fcoe_rport *frport)
 {
-	struct fcoe_rport *frport = fcoe_ctlr_rport(rdata);
 	enum fip_vlan_subcode sub = FIP_SC_VL_NOTE;
 
 	if (fip->mode == FIP_MODE_VN2VN)
@@ -2988,7 +2991,7 @@ static int fcoe_ctlr_vlan_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	}
 	mutex_lock(&fip->ctlr_mutex);
 	if (sub == FIP_SC_VL_REQ)
-		fcoe_ctlr_vlan_disc_reply(fip, &buf.rdata);
+		fcoe_ctlr_vlan_disc_reply(fip, &buf);
 	mutex_unlock(&fip->ctlr_mutex);
 
 drop:
-- 
2.16.4

