Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A762E6899
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Dec 2020 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgL1Qii (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Dec 2020 11:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbgL1NBP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 28 Dec 2020 08:01:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE0E207C9;
        Mon, 28 Dec 2020 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609160459;
        bh=DzQVrDmpBv/nzWuap9GEoQhzLuYOWJZ/LoOP4HLkE0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsCOnj/B72NzYPjRf4VvyJbQPoBbJIDrVQMZYT3qVNUzkAiL6Zeyztbka8U+Tc1XR
         Oej7iq3D9b5So0gN9bc08GMa3CiG+VfJ2GZ0E4sl+bpYFiV9J0wlw2eCeaZsMvZHtG
         l4+0yJcZIwyRUI9JmD05fCgb673okO8/kzFmn8tQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-scsi@vger.kernel.org,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 028/175] scsi: bnx2i: Requires MMU
Date:   Mon, 28 Dec 2020 13:48:01 +0100
Message-Id: <20201228124854.620731202@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228124853.216621466@linuxfoundation.org>
References: <20201228124853.216621466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 2d586494c4a001312650f0b919d534e429dd1e09 ]

The SCSI_BNX2_ISCSI kconfig symbol selects CNIC and CNIC selects UIO, which
depends on MMU.

Since 'select' does not follow dependency chains, add the same MMU
dependency to SCSI_BNX2_ISCSI.

Quietens this kconfig warning:

WARNING: unmet direct dependencies detected for CNIC
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_BROADCOM [=y] && PCI [=y] && (IPV6 [=m] || IPV6 [=m]=n) && MMU [=n]
  Selected by [m]:
  - SCSI_BNX2_ISCSI [=m] && SCSI_LOWLEVEL [=y] && SCSI [=y] && NET [=y] && PCI [=y] && (IPV6 [=m] || IPV6 [=m]=n)

Link: https://lore.kernel.org/r/20201129070916.3919-1-rdunlap@infradead.org
Fixes: cf4e6363859d ("[SCSI] bnx2i: Add bnx2i iSCSI driver.")
Cc: linux-scsi@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Manish Rangankar <mrangankar@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bnx2i/Kconfig b/drivers/scsi/bnx2i/Kconfig
index ba30ff86d5818..b27a3738d940c 100644
--- a/drivers/scsi/bnx2i/Kconfig
+++ b/drivers/scsi/bnx2i/Kconfig
@@ -3,6 +3,7 @@ config SCSI_BNX2_ISCSI
 	depends on NET
 	depends on PCI
 	depends on (IPV6 || IPV6=n)
+	depends on MMU
 	select SCSI_ISCSI_ATTRS
 	select NETDEVICES
 	select ETHERNET
-- 
2.27.0



