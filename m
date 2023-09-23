Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16A27ABCCE
	for <lists+linux-scsi@lfdr.de>; Sat, 23 Sep 2023 02:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIWAbQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Sep 2023 20:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIWAaY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Sep 2023 20:30:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF315CCC;
        Fri, 22 Sep 2023 17:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15080C433C9;
        Sat, 23 Sep 2023 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695429005;
        bh=B/LOcvpJHNZI8Taj8thEnE9tb7Zy6HMTbO08wRi1qFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFbWbT9Pk8VF9E0oloc9AxF+vYZxLF1xaRUF5rrMPX8T/gKUZZDxSvzbrPh1HNVsv
         6DhFoKuJrx93P0w8B7R1vzHJDQSejXzHML7xtFoOoDtPk+G2KlyfutY4rrvddq0cVs
         +xJCYfTbJgRKWaJsmpqAlw3cwAnls0ASfChspTL8DVxJi38uLZ7GR5iujzbTkMC4Pi
         SsQbstLAErr472uPazPha7Vl0JuiBIf86aH1F2tSdcNU/PfmhJNOcU9vA7/57ZIWpf
         bPDshzuoT/wgp319S6+diCWvv5B2F6wdklY6/h7zlZZHCGa7DZw64uIaqfVzSZuBkp
         FdBRk6UK/ZeMQ==
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
Subject: [PATCH v6 20/23] ata: libata-sata: Improve ata_sas_slave_configure()
Date:   Sat, 23 Sep 2023 09:29:29 +0900
Message-ID: <20230923002932.1082348-21-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923002932.1082348-1-dlemoal@kernel.org>
References: <20230923002932.1082348-1-dlemoal@kernel.org>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

