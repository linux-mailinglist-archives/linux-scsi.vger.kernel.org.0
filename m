Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF84483AD
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFQNQj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 09:16:39 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:47948 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNQj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 09:16:39 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x5HDGVOC018542;
        Mon, 17 Jun 2019 06:16:32 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, dt@chelsio.com, indranil@chelsio.com,
        ganji.aravind@chelsio.com, varun@chelsio.com
Subject: [PATCH] scsi: cxgb4i: add support for IEEE_8021QAZ_APP_SEL_STREAM selector
Date:   Mon, 17 Jun 2019 18:46:26 +0530
Message-Id: <1560777386-5295-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

IEEE_8021QAZ_APP_SEL_STREAM is a valid selector
for iSCSI connections, so add code to use
IEEE_8021QAZ_APP_SEL_STREAM selector to get priority
mask.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 124f334..0e767e6 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -1665,8 +1665,12 @@ static u8 get_iscsi_dcb_priority(struct net_device *ndev)
 		return 0;
 
 	if (caps & DCB_CAP_DCBX_VER_IEEE) {
-		iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_ANY;
+		iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_STREAM;
 		rv = dcb_ieee_getapp_mask(ndev, &iscsi_dcb_app);
+		if (!rv) {
+			iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_ANY;
+			rv = dcb_ieee_getapp_mask(ndev, &iscsi_dcb_app);
+		}
 	} else if (caps & DCB_CAP_DCBX_VER_CEE) {
 		iscsi_dcb_app.selector = DCB_APP_IDTYPE_PORTNUM;
 		rv = dcb_getapp(ndev, &iscsi_dcb_app);
@@ -2251,7 +2255,8 @@ cxgb4_dcb_change_notify(struct notifier_block *self, unsigned long val,
 	u8 priority;
 
 	if (iscsi_app->dcbx & DCB_CAP_DCBX_VER_IEEE) {
-		if (iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_ANY)
+		if ((iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_STREAM) &&
+		    (iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_ANY))
 			return NOTIFY_DONE;
 
 		priority = iscsi_app->app.priority;
-- 
2.0.2

