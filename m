Return-Path: <linux-scsi+bounces-15545-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8CB11629
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Jul 2025 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5B5AE029B
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Jul 2025 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB921FF1D1;
	Fri, 25 Jul 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6mbD69k"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9419066B
	for <linux-scsi@vger.kernel.org>; Fri, 25 Jul 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408847; cv=none; b=QFfEJ92gtI1qPB6KBgNA3Ke1hFD8EaC59bkAvv0m1bEIkJT/jR+wYdSAnx4EIMAk63gq70NtK3sa/dixrVWWtMqWBBETwMMNAXoaZZrw9oHuHfLUSeTe9mRMZJIzRdsgcPK59D3UqdiyOsGdgJG7LbhWOAW9uWcJ98NJfgZqKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408847; c=relaxed/simple;
	bh=LLfmZiQEoDSOrlBZWiKoPbKJAiD+2Gio8rdnOpFcVdU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS7CVQVVV487NYiGHMEiY0UW7ETos4IvSm/zCDwi0snaXUpNzvXEfU/UAUxZJZkcjFIGBwS4j4b69+6A3xKvuRajGBRAK2Zm/xcbLzNMtRtlDuVQqxwhq0iRC03K+eAhdyhwQJUcAh7r+8E0m0C9YBNQpHv+W2ziqISf8H8jolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6mbD69k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC6BC4CEF5;
	Fri, 25 Jul 2025 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408847;
	bh=LLfmZiQEoDSOrlBZWiKoPbKJAiD+2Gio8rdnOpFcVdU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K6mbD69kQ3vpuONI3YlOtlQ0R1XqrXwROoKPIMzVjMJzgrVJsrU/EL31KTImYdD3v
	 j/vt08NGCfjJK3JSq6hfcAalJWkcHAE/RyMtE4FVqMO07bF/QnRBsPdJ8uap0fMQGd
	 aR0xvHXX76LdmGQn9RLds/lY2IYL2o57Y/MxAJfe6Fq8d/knZUZmYlJ+94/7hIejrf
	 RpY2dgVoj7yGw453xPo43nxtZcXCHBibG3fuwU2gEj/5GZobe4LbBe7uPX/IozfmOS
	 rUWFzhn+cz/pkUNJ55A04tZ4Bo6zlbO3zQVJ9uTXt4a5t/XeQzL774WA4a3XW+mPs2
	 V3h0XeqL5nh7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 2/5] scsi: libsas: Simplify sas_ata_wait_eh()
Date: Fri, 25 Jul 2025 10:58:15 +0900
Message-ID: <20250725015818.171252-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725015818.171252-1-dlemoal@kernel.org>
References: <20250725015818.171252-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code of sas_ata_wait_eh(), removing the local variable ap
for the pointer to the device ata_port structure. The test using
dev_is_sata() is also removed as all call sites of this function check
if the device is a SATA one before calling this function.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_ata.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 7b4e7a61965a..2cbf38b18c5c 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -927,13 +927,7 @@ EXPORT_SYMBOL_GPL(sas_ata_schedule_reset);
 
 void sas_ata_wait_eh(struct domain_device *dev)
 {
-	struct ata_port *ap;
-
-	if (!dev_is_sata(dev))
-		return;
-
-	ap = dev->sata_dev.ap;
-	ata_port_wait_eh(ap);
+	ata_port_wait_eh(dev->sata_dev.ap);
 }
 
 void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
-- 
2.50.1


