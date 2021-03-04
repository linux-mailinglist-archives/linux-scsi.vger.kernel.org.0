Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03132D328
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhCDMdX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 07:33:23 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:40762 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240757AbhCDMdC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Mar 2021 07:33:02 -0500
Received: from localhost.localdomain (unknown [10.157.2.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 9B4CD24355;
        Thu,  4 Mar 2021 04:20:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9B4CD24355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1614860404;
        bh=v1ezuB3jbcKDskk9u9m7+Qopj32EWapNdSLpPFu+KcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3UAAiNeF20QruQIp2xNvK13/wroPDizp69OrwfhE9EM9NL2RAKwUCii6jSLPqR6K
         60/RHV31mG0Bozq3/dIEzAVjTYdP7VH9lb/kDCS+e1Q4u1LhvNi182l8KJUdVurnKS
         RndkLtFxWQo3W6eDpW2dN0TcBXR5QKNCRqsqcGaw=
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v8 16/16] scsi: Made changes in Kconfig to select BLK_CGROUP_FC_APPID
Date:   Thu,  4 Mar 2021 10:57:26 +0530
Message-Id: <1614835646-16217-17-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Added a new config FC_APPID to select BLK_CGROUP_FC_APPID
which Enable support to track FC io Traffic.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v8:
No change

v7:
Modified the Kconfig comments

v6:
Modified the Kconfig comments

v5:
No change

v4:
Addressed the error reported by kernel test robot

v3:
New patch
---
 drivers/scsi/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 06b87c7f6bab..20aa1536a3ba 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -235,6 +235,19 @@ config SCSI_FC_ATTRS
 	  each attached FiberChannel device to sysfs, say Y.
 	  Otherwise, say N.
 
+config FC_APPID
+	bool "Enable support to track FC I/O Traffic"
+	depends on BLOCK && BLK_CGROUP
+	depends on SCSI
+	select BLK_CGROUP_FC_APPID
+	default y
+	help
+	  If you say Y here, it enables the support to track
+	  FC I/O traffic over fabric. It enables the Fabric and the
+	  storage targets to identify, monitor, and handle FC traffic
+	  based on VM tags by inserting application specific
+	  identification into the FC frame.
+
 config SCSI_ISCSI_ATTRS
 	tristate "iSCSI Transport Attributes"
 	depends on SCSI && NET
-- 
2.26.2

