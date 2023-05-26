Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA9712AA0
	for <lists+linux-scsi@lfdr.de>; Fri, 26 May 2023 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEZQ3Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 May 2023 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEZQ3P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 May 2023 12:29:15 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 09:29:13 PDT
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC152BC
        for <linux-scsi@vger.kernel.org>; Fri, 26 May 2023 09:29:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685117990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qYU4uF9VbfEtej7g/oa6dO+x31qhOWdcbVmmgCv4IHE=;
        b=xVmBCDNwqiJXtXJKLxZuGvIgPF7dg+/uDWkgwmuafOjXsIw5oJ9eJQVwuk6h+C65Yj3rSj
        wbi76bzBU2k9c9mv7CdSMnp+BsVFhqcO4VgOO1FjQmsJmmA0aIeHgfpbyp3O1kFOSe93TA
        zZBIkkMhd1i9hEOi0Mwl5u3p2zL3g4M=
From:   Jackie Liu <liu.yun@linux.dev>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix memleak on memory alloc failed
Date:   Sat, 27 May 2023 00:19:36 +0800
Message-Id: <20230526161936.1433332-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Returning directly without free memory can lead to memory leaks, which
can be avoided by goto 'fail_dma_pool'.

Fixes: 06634d5b6e92 ("scsi: qla2xxx: Return -ENOMEM if kzalloc() fails")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2fa695bf38b7..da7698c8293b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4245,7 +4245,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 					ql_dbg_pci(ql_dbg_init, ha->pdev,
 					    0xe0ee, "%s: failed alloc dsd\n",
 					    __func__);
-					return -ENOMEM;
+					goto fail_dma_pool;
 				}
 				ha->dif_bundle_kallocs++;
 
-- 
2.25.1

