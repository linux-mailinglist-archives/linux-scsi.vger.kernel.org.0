Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0AE1A1BFC
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Apr 2020 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDHGnp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Apr 2020 02:43:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44200 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDHGno (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Apr 2020 02:43:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0386f71u031042;
        Tue, 7 Apr 2020 23:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=vwKelhqUYMrPdrew/4dT6RRjJjd/icNbgOjZwRCkK58=;
 b=IvXt6dGaDCzhRVaDQJ+m9x0TPnNuAiVXKKojui15Cy5PwJjmoIgK4I1mz1I4qwss7Guy
 Dvw8jgO/yOkitHUWZZjbESMT5n37Bt2pArTFNhcNr/esbZJ031waOJjNOO3RRTuLXg0z
 c9I21iMI0OFk3mc0uhUrVbipPWa71PqqyaVyVWuMunM/HlGgG7mVxAtFJAAnB8bzvcMw
 RRotP+r8a1K2/Fgrq5m73IVGoVamsL6HLy1JymJ0zDWLc/CrH7tm2b8c1fbui6wm/bs/
 08I5w66DiMvfe1msaF7qZmgba17gjnCwYuAyASqHweU08RQbe6VLtTJLYD2QSboLknWB cg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3091jwa0qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 23:43:39 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 23:43:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Apr 2020 23:43:38 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 65BD83F7045;
        Tue,  7 Apr 2020 23:43:36 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0386haJ0019416;
        Tue, 7 Apr 2020 23:43:36 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0386haJq019415;
        Tue, 7 Apr 2020 23:43:36 -0700
From:   Manish Rangankar <mrangankar@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 1/6] qedi: Remove additional char from boot target iqnname.
Date:   Tue, 7 Apr 2020 23:43:27 -0700
Message-ID: <20200408064332.19377-2-mrangankar@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200408064332.19377-1-mrangankar@marvell.com>
References: <20200408064332.19377-1-mrangankar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

While parsing the iSCSI TLV data to MFW request,
fw boot target iqnname string was having additional
character because of which we are getting below error
even after the boot from SAN target were logged-in.

"[qedi_get_protocol_tlv_data:1197]:1: Boot target not set"

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
---
 drivers/scsi/qedi/qedi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index b995b19..2fe1140 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -921,7 +921,7 @@ static void qedi_get_boot_tgt_info(struct nvm_iscsi_block *block,
 	ipv6_en = !!(block->generic.ctrl_flags &
 		     NVM_ISCSI_CFG_GEN_IPV6_ENABLED);
 
-	snprintf(tgt->iscsi_name, sizeof(tgt->iscsi_name), "%s\n",
+	snprintf(tgt->iscsi_name, sizeof(tgt->iscsi_name), "%s",
 		 block->target[index].target_name.byte);
 
 	tgt->ipv6_en = ipv6_en;
-- 
1.8.3.1

