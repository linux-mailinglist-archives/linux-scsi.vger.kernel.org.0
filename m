Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0620410625E
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 07:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfKVGD2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Nov 2019 01:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfKVGDH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Nov 2019 01:03:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E2C2070B;
        Fri, 22 Nov 2019 06:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402586;
        bh=ciyw++3xZyqHxnZ7BrAdNCJ4ZxjMZGzMxtvQRKjfYxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzvGRSofmrDi+hYas3x/kz42vbovwjEk+DVtcqlaSYVRMqko8i0I40PyaC+SYStNZ
         1P/cgltknT8oo7cVpG37Iqs371PvlxLMwvnIyzSmRVdVsem5y3lI+mjvnmGvu8z9jm
         C3oNrGgrwOnlTEU3mdgxiEALVcvXeOWyyJUt+QZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Jian Luo <luojian5@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 87/91] scsi: libsas: Support SATA PHY connection rate unmatch fixing during discovery
Date:   Fri, 22 Nov 2019 01:01:25 -0500
Message-Id: <20191122060129.4239-86-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit cec9771d2e954650095aa37a6a97722c8194e7d2 ]

   +----------+             +----------+
   |          |             |          |
   |          |--- 3.0 G ---|          |--- 6.0 G --- SAS  disk
   |          |             |          |
   |          |--- 3.0 G ---|          |--- 6.0 G --- SAS  disk
   |initiator |             |          |
   | device   |--- 3.0 G ---| Expander |--- 6.0 G --- SAS  disk
   |          |             |          |
   |          |--- 3.0 G ---|          |--- 6.0 G --- SATA disk  -->failed to connect
   |          |             |          |
   |          |             |          |--- 6.0 G --- SATA disk  -->failed to connect
   |          |             |          |
   +----------+             +----------+

According to Serial Attached SCSI - 1.1 (SAS-1.1):
If an expander PHY attached to a SATA PHY is using a physical link rate
greater than the maximum connection rate supported by the pathway from an
STP initiator port, a management application client should use the SMP PHY
CONTROL function (see 10.4.3.10) to set the PROGRAMMED MAXIMUM PHYSICAL
LINK RATE field of the expander PHY to the maximum connection rate
supported by the pathway from that STP initiator port.

Currently libsas does not support checking if this condition occurs, nor
rectifying when it does.

Such a condition is not at all common, however it has been seen on some
pre-silicon environments where the initiator PHY only supports a 1.5 Gbit
maximum linkrate, mated with 12G expander PHYs and 3/6G SATA phy.

This patch adds support for checking and rectifying this condition during
initial device discovery only.

We do support checking min pathway connection rate during revalidation phase,
when new devices can be detected in the topology. However we do not
support in the case of the the user reprogramming PHY linkrates, such that
min pathway condition is not met/maintained.

A note on root port PHY rates:
The libsas root port PHY rates calculation is broken. Libsas sets the
rates (min, max, and current linkrate) of a root port to the same linkrate
of the first PHY member of that same port. In doing so, it assumes that
all other PHYs which subsequently join the port to have the same
negotiated linkrate, when they could actually be different.

In practice this doesn't happen, as initiator and expander PHYs are
normally initialised with consistent min/max linkrates.

This has not caused an issue so far, so leave alone for now.

Tested-by: Jian Luo <luojian5@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_expander.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 400eee9d77832..ba16231665a5e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -806,6 +806,26 @@ static struct domain_device *sas_ex_discover_end_dev(
 
 #ifdef CONFIG_SCSI_SAS_ATA
 	if ((phy->attached_tproto & SAS_PROTOCOL_STP) || phy->attached_sata_dev) {
+		if (child->linkrate > parent->min_linkrate) {
+			struct sas_phy_linkrates rates = {
+				.maximum_linkrate = parent->min_linkrate,
+				.minimum_linkrate = parent->min_linkrate,
+			};
+			int ret;
+
+			pr_notice("ex %016llx phy%02d SATA device linkrate > min pathway connection rate, attempting to lower device linkrate\n",
+				   SAS_ADDR(child->sas_addr), phy_id);
+			ret = sas_smp_phy_control(parent, phy_id,
+						  PHY_FUNC_LINK_RESET, &rates);
+			if (ret) {
+				pr_err("ex %016llx phy%02d SATA device could not set linkrate (%d)\n",
+				       SAS_ADDR(child->sas_addr), phy_id, ret);
+				goto out_free;
+			}
+			pr_notice("ex %016llx phy%02d SATA device set linkrate successfully\n",
+				  SAS_ADDR(child->sas_addr), phy_id);
+			child->linkrate = child->min_linkrate;
+		}
 		res = sas_get_ata_info(child, phy);
 		if (res)
 			goto out_free;
-- 
2.20.1

