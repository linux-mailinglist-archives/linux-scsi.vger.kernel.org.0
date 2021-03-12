Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3733837B
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 03:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhCLCTc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 21:19:32 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:43622 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCLCTB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Mar 2021 21:19:01 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 8ACA940022B;
        Fri, 12 Mar 2021 10:18:58 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] scsi: ibmvscsi: delete the useless casting value returned
Date:   Fri, 12 Mar 2021 10:18:53 +0800
Message-Id: <1615515534-1250-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkhITxgeSkJKSB5CVkpNSk5OSk5OSENCT0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6ESo4Tj8IEwIzDzE0Eyw3
        TiEwCzpVSlVKTUpOTkpOTkhCQ0tNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSUtDSzcG
X-HM-Tid: 0a78243ad5abd991kuws8aca940022b
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:
WARNING: casting value returned by memory allocation function is useless.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 29fcc44..f084ca10
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -717,8 +717,7 @@ static int map_sg_data(struct scsi_cmnd *cmd,
 
 	/* get indirect table */
 	if (!evt_struct->ext_list) {
-		evt_struct->ext_list = (struct srp_direct_buf *)
-			dma_alloc_coherent(dev,
+		evt_struct->ext_list = dma_alloc_coherent(dev,
 					   SG_ALL * sizeof(struct srp_direct_buf),
 					   &evt_struct->ext_list_token, 0);
 		if (!evt_struct->ext_list) {
-- 
2.7.4

