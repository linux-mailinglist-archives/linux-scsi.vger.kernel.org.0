Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82507AC975
	for <lists+linux-scsi@lfdr.de>; Sun, 24 Sep 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIXNbu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Sep 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjIXNbb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 24 Sep 2023 09:31:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDA423A;
        Sun, 24 Sep 2023 06:19:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD2FC433CA;
        Sun, 24 Sep 2023 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561574;
        bh=wn0yYa9J9TDOzpYHqgGiQe2tQr3OqhjaBash6LAj8jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXneB48Kq4J5/CwiELnV6Ghc7uQa6IWVJHXUNBGY+uLAc17tCibP1yNCdWHaOdYxn
         39Qk7YZZpTRUQoIVjFODYWS2TcWiveAa3JZuVYAoD4dO/7z3L+iZ13r+l3Bwfh/5QO
         fGOUB57fjbANUo2BRu34ma91TCGtHzgrjPDdWvnJXRSAdApKzre2Hjytn8W38qWqFY
         3NfVEk1de//s2xZwQM8SsFoEspS9L2269aJ5jmQHKbtRVX7TlNv5T8S685RWbPd75E
         0GcwA4Zwg3lS8ipLlcdNKdHiVDLF+W/z4sQc6aDSzXWk1lyV4AQjvoAtg4kfNW1Bbp
         +qrm2qAWjferw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Grzedzicki <mge@meta.com>, Jack Wang <jinpu.wang@ionos.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/18] scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
Date:   Sun, 24 Sep 2023 09:18:53 -0400
Message-Id: <20230924131857.1276330-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Michal Grzedzicki <mge@meta.com>

[ Upstream commit c13e7331745852d0dd7c35eabbe181cbd5b01172 ]

Tags allocated for OPC_INB_SET_CONTROLLER_CONFIG command need to be freed
when we receive the response.

Signed-off-by: Michal Grzedzicki <mge@meta.com>
Link: https://lore.kernel.org/r/20230911170340.699533-2-mge@meta.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index ea305d093c871..d37b1bdb29b49 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3793,10 +3793,12 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
 			(struct set_ctrl_cfg_resp *)(piomb + 4);
 	u32 status = le32_to_cpu(pPayload->status);
 	u32 err_qlfr_pgcd = le32_to_cpu(pPayload->err_qlfr_pgcd);
+	u32 tag = le32_to_cpu(pPayload->tag);
 
 	pm8001_dbg(pm8001_ha, MSG,
 		   "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
 		   status, err_qlfr_pgcd);
+	pm8001_tag_free(pm8001_ha, tag);
 
 	return 0;
 }
-- 
2.40.1

