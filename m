Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F17AA1E0
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Sep 2023 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIUVIC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Sep 2023 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIUVHs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Sep 2023 17:07:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193FB05AB;
        Thu, 21 Sep 2023 11:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2762DC433C7;
        Thu, 21 Sep 2023 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695319717;
        bh=lluOKqw7tLNV/kxgRi98Hm7XDhcmRwFMDXZzXCgSCAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGAL7/3nv9GDFco2lMzFYE5japtR9Xzg9LfuVaGFBn4d6oIPi5qXWkTcbIjWcrhuu
         CqIQYcT3F+dZNpUhagWOo+48qQXkLhQFoL/iqLQE9S0uTlff7WKCq4Hotuv4PBF/mJ
         Jn+zl5OVTIhzostqtnRTU7UYUavcTdiYoTxonRTf6RPivXrvyiOyZbBHzBe4hirL3m
         1KKMTxfgr1xj7MTXeDjAeezQrI7kJeSTnmnOWnlv0rXNxrpfrsW8qicPNRMb7bcw6j
         gBjqPl7pBIxMR6i8nHdkDra04RhbuzwCDgqpZtUfxxFcP1PaRgFmVEEv0K4OXgnrHY
         /PcztrUVGCnjw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chia-Lin Kao <acelan.kao@canonical.com>
Subject: [PATCH v5 20/23] ata: libata-sata: Improve ata_sas_slave_configure()
Date:   Fri, 22 Sep 2023 03:07:55 +0900
Message-ID: <20230921180758.955317-21-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921180758.955317-1-dlemoal@kernel.org>
References: <20230921180758.955317-1-dlemoal@kernel.org>
MIME-Version: 1.0
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

Change ata_sas_slave_configure() to return the return value of
ata_scsi_dev_config() to ensure that any error from that function is
propagated to libsas.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index a701e1538482..83a9497e48e1 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1182,8 +1182,8 @@ EXPORT_SYMBOL_GPL(ata_sas_tport_delete);
 int ata_sas_slave_configure(struct scsi_device *sdev, struct ata_port *ap)
 {
 	ata_scsi_sdev_config(sdev);
-	ata_scsi_dev_config(sdev, ap->link.device);
-	return 0;
+
+	return ata_scsi_dev_config(sdev, ap->link.device);
 }
 EXPORT_SYMBOL_GPL(ata_sas_slave_configure);
 
-- 
2.41.0

