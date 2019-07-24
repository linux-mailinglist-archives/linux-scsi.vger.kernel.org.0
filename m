Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B285E72AF3
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 11:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfGXJBO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 05:01:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfGXJBO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41721B033;
        Wed, 24 Jul 2019 09:01:12 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/3] fcoe: Embed fc_rport_priv in fcoe_rport structure
Date:   Wed, 24 Jul 2019 11:00:55 +0200
Message-Id: <20190724090056.7506-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190724090056.7506-1-hare@suse.de>
References: <20190724090056.7506-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Gcc-9 complains for a memset across pointer boundaries, which happens
as the code tries to allocate a flexible array on the stack.
Turns out we cannot do this without relying on gcc-isms, so
with this patch we'll embed the fc_rport_priv structure into
fcoe_rport, can use the normal 'container_of' outcast, and
will only have to do a memset over one structure.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 51 +++++++++++++++++--------------------------
 drivers/scsi/libfc/fc_rport.c |  5 ++++-
 include/scsi/libfcoe.h        |  1 +
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 0d7770d07405..472626cfa150 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -2005,7 +2005,7 @@ EXPORT_SYMBOL_GPL(fcoe_wwn_from_mac);
  */
 static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *rdata)
 {
-	return (struct fcoe_rport *)(rdata + 1);
+	return container_of(rdata, struct fcoe_rport, rdata);
 }
 
 /**
@@ -2269,7 +2269,7 @@ static void fcoe_ctlr_vn_start(struct fcoe_ctlr *fip)
  */
 static int fcoe_ctlr_vn_parse(struct fcoe_ctlr *fip,
 			      struct sk_buff *skb,
-			      struct fc_rport_priv *rdata)
+			      struct fcoe_rport *frport)
 {
 	struct fip_header *fiph;
 	struct fip_desc *desc = NULL;
@@ -2277,16 +2277,12 @@ static int fcoe_ctlr_vn_parse(struct fcoe_ctlr *fip,
 	struct fip_wwn_desc *wwn = NULL;
 	struct fip_vn_desc *vn = NULL;
 	struct fip_size_desc *size = NULL;
-	struct fcoe_rport *frport;
 	size_t rlen;
 	size_t dlen;
 	u32 desc_mask = 0;
 	u32 dtype;
 	u8 sub;
 
-	memset(rdata, 0, sizeof(*rdata) + sizeof(*frport));
-	frport = fcoe_ctlr_rport(rdata);
-
 	fiph = (struct fip_header *)skb->data;
 	frport->flags = ntohs(fiph->fip_flags);
 
@@ -2349,15 +2345,17 @@ static int fcoe_ctlr_vn_parse(struct fcoe_ctlr *fip,
 			if (dlen != sizeof(struct fip_wwn_desc))
 				goto len_err;
 			wwn = (struct fip_wwn_desc *)desc;
-			rdata->ids.node_name = get_unaligned_be64(&wwn->fd_wwn);
+			frport->rdata.ids.node_name =
+				get_unaligned_be64(&wwn->fd_wwn);
 			break;
 		case FIP_DT_VN_ID:
 			if (dlen != sizeof(struct fip_vn_desc))
 				goto len_err;
 			vn = (struct fip_vn_desc *)desc;
 			memcpy(frport->vn_mac, vn->fd_mac, ETH_ALEN);
-			rdata->ids.port_id = ntoh24(vn->fd_fc_id);
-			rdata->ids.port_name = get_unaligned_be64(&vn->fd_wwpn);
+			frport->rdata.ids.port_id = ntoh24(vn->fd_fc_id);
+			frport->rdata.ids.port_name =
+				get_unaligned_be64(&vn->fd_wwpn);
 			break;
 		case FIP_DT_FC4F:
 			if (dlen != sizeof(struct fip_fc4_feat))
@@ -2738,10 +2736,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fip_header *fiph;
 	enum fip_vn2vn_subcode sub;
-	struct {
-		struct fc_rport_priv rdata;
-		struct fcoe_rport frport;
-	} buf;
+	struct fcoe_rport frport = { };
 	int rc, vlan_id = 0;
 
 	fiph = (struct fip_header *)skb->data;
@@ -2757,7 +2752,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 		goto drop;
 	}
 
-	rc = fcoe_ctlr_vn_parse(fip, skb, &buf.rdata);
+	rc = fcoe_ctlr_vn_parse(fip, skb, &frport);
 	if (rc) {
 		LIBFCOE_FIP_DBG(fip, "vn_recv vn_parse error %d\n", rc);
 		goto drop;
@@ -2766,19 +2761,19 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	mutex_lock(&fip->ctlr_mutex);
 	switch (sub) {
 	case FIP_SC_VN_PROBE_REQ:
-		fcoe_ctlr_vn_probe_req(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_req(fip, &frport.rdata);
 		break;
 	case FIP_SC_VN_PROBE_REP:
-		fcoe_ctlr_vn_probe_reply(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_reply(fip, &frport.rdata);
 		break;
 	case FIP_SC_VN_CLAIM_NOTIFY:
-		fcoe_ctlr_vn_claim_notify(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_notify(fip, &frport.rdata);
 		break;
 	case FIP_SC_VN_CLAIM_REP:
-		fcoe_ctlr_vn_claim_resp(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_resp(fip, &frport.rdata);
 		break;
 	case FIP_SC_VN_BEACON:
-		fcoe_ctlr_vn_beacon(fip, &buf.rdata);
+		fcoe_ctlr_vn_beacon(fip, &frport.rdata);
 		break;
 	default:
 		LIBFCOE_FIP_DBG(fip, "vn_recv unknown subcode %d\n", sub);
@@ -2802,22 +2797,18 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
  */
 static int fcoe_ctlr_vlan_parse(struct fcoe_ctlr *fip,
 			      struct sk_buff *skb,
-			      struct fc_rport_priv *rdata)
+			      struct fcoe_rport *frport)
 {
 	struct fip_header *fiph;
 	struct fip_desc *desc = NULL;
 	struct fip_mac_desc *macd = NULL;
 	struct fip_wwn_desc *wwn = NULL;
-	struct fcoe_rport *frport;
 	size_t rlen;
 	size_t dlen;
 	u32 desc_mask = 0;
 	u32 dtype;
 	u8 sub;
 
-	memset(rdata, 0, sizeof(*rdata) + sizeof(*frport));
-	frport = fcoe_ctlr_rport(rdata);
-
 	fiph = (struct fip_header *)skb->data;
 	frport->flags = ntohs(fiph->fip_flags);
 
@@ -2871,7 +2862,8 @@ static int fcoe_ctlr_vlan_parse(struct fcoe_ctlr *fip,
 			if (dlen != sizeof(struct fip_wwn_desc))
 				goto len_err;
 			wwn = (struct fip_wwn_desc *)desc;
-			rdata->ids.node_name = get_unaligned_be64(&wwn->fd_wwn);
+			frport->rdata.ids.node_name =
+				get_unaligned_be64(&wwn->fd_wwn);
 			break;
 		default:
 			LIBFCOE_FIP_DBG(fip, "unexpected descriptor type %x "
@@ -2982,22 +2974,19 @@ static int fcoe_ctlr_vlan_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fip_header *fiph;
 	enum fip_vlan_subcode sub;
-	struct {
-		struct fc_rport_priv rdata;
-		struct fcoe_rport frport;
-	} buf;
+	struct fcoe_rport frport = { };
 	int rc;
 
 	fiph = (struct fip_header *)skb->data;
 	sub = fiph->fip_subcode;
-	rc = fcoe_ctlr_vlan_parse(fip, skb, &buf.rdata);
+	rc = fcoe_ctlr_vlan_parse(fip, skb, &frport);
 	if (rc) {
 		LIBFCOE_FIP_DBG(fip, "vlan_recv vlan_parse error %d\n", rc);
 		goto drop;
 	}
 	mutex_lock(&fip->ctlr_mutex);
 	if (sub == FIP_SC_VL_REQ)
-		fcoe_ctlr_vlan_disc_reply(fip, &buf.rdata);
+		fcoe_ctlr_vlan_disc_reply(fip, &frport.rdata);
 	mutex_unlock(&fip->ctlr_mutex);
 
 drop:
diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 0da34c7a6866..45d44c50a620 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -128,6 +128,7 @@ EXPORT_SYMBOL(fc_rport_lookup);
 struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
 {
 	struct fc_rport_priv *rdata;
+	size_t rport_priv_size = sizeof(*rdata);
 
 	lockdep_assert_held(&lport->disc.disc_mutex);
 
@@ -135,7 +136,9 @@ struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
 	if (rdata)
 		return rdata;
 
-	rdata = kzalloc(sizeof(*rdata) + lport->rport_priv_size, GFP_KERNEL);
+	if (lport->rport_priv_size > 0)
+		rport_priv_size = lport->rport_priv_size;
+	rdata = kzalloc(rport_priv_size, GFP_KERNEL);
 	if (!rdata)
 		return NULL;
 
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index ecf3e5978166..138fb8fba748 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -229,6 +229,7 @@ struct fcoe_fcf {
  * @vn_mac:	VN_Node assigned MAC address for data
  */
 struct fcoe_rport {
+	struct fc_rport_priv rdata;
 	unsigned long time;
 	u16 fcoe_len;
 	u16 flags;
-- 
2.16.4

