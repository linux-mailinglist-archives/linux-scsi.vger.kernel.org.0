Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E07568D41
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jul 2022 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiGFPdm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiGFPcj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 11:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ED26571;
        Wed,  6 Jul 2022 08:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 399D861FF2;
        Wed,  6 Jul 2022 15:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ECDC341CA;
        Wed,  6 Jul 2022 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657121537;
        bh=ftRCXwc4371VseYpxVHNBx88Hlwn+pfvaap8UhlLLAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fD0wdxUJMs0dJE8UsCD0uXOMVilowVFImSROLQTJvStbo7MpU6zV//moHuK4eLDmN
         Yyj4F2GazyyjPLdIzvMZ+IuW2vhR3IVUf/PLmt6lcqGtrYy3CHFRQYB2+ZLQ1iW+Gg
         v3WWSygbXpXrPUMi/wjbgLWEoalCK6YqoROdNfi512EUA2i3oDpFPnqtPHspSjjewe
         wc33n41akXCTtCS72rx/xIDc719gxSVdnTdPWq07EWnK+xwe/vBkN40cxWaTRXOIH8
         UaCI2csJGk1xVb2oq8AxmyMI4/fvrM4tmV6LOB7hW/LnhkRneDm2WZHi1F2mMVPDfp
         tNxh5uyuQErhA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/18] scsi: hisi_sas: Limit max hw sectors for v3 HW
Date:   Wed,  6 Jul 2022 11:31:43 -0400
Message-Id: <20220706153153.1598076-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153153.1598076-1-sashal@kernel.org>
References: <20220706153153.1598076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit fce54ed027577517df1e74b7d54dc2b1bd536887 ]

If the controller is behind an IOMMU then the IOMMU IOVA caching range can
affect performance, as discussed in [0].

Limit the max HW sectors to not exceed this limit. We need to hardcode the
value until a proper DMA mapping API is available.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Link: https://lore.kernel.org/r/1655988119-223714-1-git-send-email-john.garry@huawei.com
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 1f5e0688c0c8..15c7451fb30f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2758,6 +2758,7 @@ static int slave_configure_v3_hw(struct scsi_device *sdev)
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct device *dev = hisi_hba->dev;
 	int ret = sas_slave_configure(sdev);
+	unsigned int max_sectors;
 
 	if (ret)
 		return ret;
@@ -2775,6 +2776,12 @@ static int slave_configure_v3_hw(struct scsi_device *sdev)
 		}
 	}
 
+	/* Set according to IOMMU IOVA caching limit */
+	max_sectors = min_t(size_t, queue_max_hw_sectors(sdev->request_queue),
+			    (PAGE_SIZE * 32) >> SECTOR_SHIFT);
+
+	blk_queue_max_hw_sectors(sdev->request_queue, max_sectors);
+
 	return 0;
 }
 
-- 
2.35.1

