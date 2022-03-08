Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC93A4D1207
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiCHIWO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 03:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344952AbiCHIWF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 03:22:05 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B3A3F30E
        for <linux-scsi@vger.kernel.org>; Tue,  8 Mar 2022 00:21:08 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22883jqh000787
        for <linux-scsi@vger.kernel.org>; Tue, 8 Mar 2022 00:21:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=mCb/2Ug3wE6/j3OSU9YAy6d+ep0QrFmI4E4U/x8LyRg=;
 b=dOOpYt4S3qDRngTU2vtF76RZC8AM8g00gWS90CyPj1DUBo8rP0pDlQ/f0dwClytFL1Nc
 iB3MzXz1L3eQM5oz6RX2weFmnQcW1Rk2C9SVPwrfOho7nMiZ+Sphucksk7a/JZSetyFm
 bb9maOe4RgcbaCVa8xTFMaG94RXbG0lFwY1sF2+9/DDuUi9e0oALyxq+2+3P36uI5K19
 wP2LBpfggSI9szF0HfYicCrG7+zpcO3ERVG4sj50XUQ5yJhlEG5EPWY32wo7uc6Aop2k
 Zv5L6x3mcXX+NpZH8P7iW6qcE2Qn+EmUgotpIGZdajD7xoWGlWCHPJNpxKhYLuI5Y4DO Mg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ep39x82uy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 08 Mar 2022 00:21:07 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 00:21:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 00:21:06 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id E1A545B692C;
        Tue,  8 Mar 2022 00:21:05 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 2288L5he009829;
        Tue, 8 Mar 2022 00:21:05 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 2288L5wb009828;
        Tue, 8 Mar 2022 00:21:05 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 05/13] qla2xxx: Fix crash during module load unload test
Date:   Tue, 8 Mar 2022 00:20:40 -0800
Message-ID: <20220308082048.9774-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220308082048.9774-1-njavali@marvell.com>
References: <20220308082048.9774-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zWq0qXOAmzDRecIywEhmbmciIOQddvhR
X-Proofpoint-GUID: zWq0qXOAmzDRecIywEhmbmciIOQddvhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

During purex packet handling driver was incorrectly
freeing a pre-allocated structure. Fix this by
skipping that entry.

System crashed with the following stack during a
module unload test.

Call Trace:
          sbitmap_init_node+0x7f/0x1e0
          sbitmap_queue_init_node+0x24/0x150
          blk_mq_init_bitmaps+0x3d/0xa0
          blk_mq_init_tags+0x68/0x90
          blk_mq_alloc_map_and_rqs+0x44/0x120
          blk_mq_alloc_set_map_and_rqs+0x63/0x150
          blk_mq_alloc_tag_set+0x11b/0x230
          scsi_add_host_with_dma.cold+0x3f/0x245
          qla2x00_probe_one+0xd5a/0x1b80 [qla2xxx]

Call Trace with slub_debug and debug kernel:
        kasan_report_invalid_free+0x50/0x80
        __kasan_slab_free+0x137/0x150
        slab_free_freelist_hook+0xc6/0x190
        kfree+0xe8/0x2e0
        qla2x00_free_device+0x3bb/0x5d0 [qla2xxx]
        qla2x00_remove_one+0x668/0xcf0 [qla2xxx]

Reported-by: Marco Patalano <mpatalan@redhat.com>
Tested-by: Marco Patalano <mpatalan@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 62e9dd177732 ("scsi: qla2xxx: Change in PUREX to handle FPIN ELS requests")
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a4546346c18b..d572a76d0fa0 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3904,6 +3904,8 @@ qla24xx_free_purex_list(struct purex_list *list)
 	spin_lock_irqsave(&list->lock, flags);
 	list_for_each_entry_safe(item, next, &list->head, list) {
 		list_del(&item->list);
+		if (item == &item->vha->default_item)
+			continue;
 		kfree(item);
 	}
 	spin_unlock_irqrestore(&list->lock, flags);
-- 
2.19.0.rc0

